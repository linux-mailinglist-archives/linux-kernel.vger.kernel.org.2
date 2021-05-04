Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE9837318F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 22:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbhEDUmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 16:42:09 -0400
Received: from albireo.enyo.de ([37.24.231.21]:43426 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230150AbhEDUmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 16:42:08 -0400
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 May 2021 16:42:07 EDT
Received: from [172.17.203.2] (port=38747 helo=deneb.enyo.de)
        by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1le1lb-0004Rz-97; Tue, 04 May 2021 20:35:39 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1le1lb-0003zU-5D; Tue, 04 May 2021 22:35:39 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     "Vladislav K. Valtchev" <vladislav.valtchev@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gcc@vger.kernel.org,
        linux-toolchains@vger.kernel.org
Subject: Re: GCC, unaligned access and UB in the Linux kernel
References: <c8fa8ea79ffaa5c87dac9ea16e12088c94a35faf.camel@gmail.com>
Date:   Tue, 04 May 2021 22:35:39 +0200
In-Reply-To: <c8fa8ea79ffaa5c87dac9ea16e12088c94a35faf.camel@gmail.com>
        (Vladislav K. Valtchev's message of "Tue, 04 May 2021 21:07:46 +0300")
Message-ID: <877dkekzj8.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vladislav K. Valtchev:

> Hi everyone,
>
> I noticed that in the Linux kernel we have a define called
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS that's used in a fair amount of places
> with the following purpose: when it's set, unaligned access is supported by the
> CPU so we can do it directly, otherwise fall-back to some logic where a byte at
> the time is read/written. For example, check the implementation of
> do_strncpy_from_user():
> https://elixir.bootlin.com/linux/latest/source/lib/strncpy_from_user.c#L15
>
>
> That's nice and seems to work today as expected, but there's one problem:
> unaligned access is UB according to the ISO C standard, no matter if the
> architecture supports it or not. Also, GCC doesn't have any option similar to "-
> fno-strict-aliasing" to make unaligned access non-UB. At the moment, they won't
> consider introducing such an option either. Check this bug:
>
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=93031
>
> Starting from GCC 8.x, the compiler introduced some new optimizations that
> assume correct alignment which can break some code[1]. However, unaligned access
> like the following [from do_strncpy_from_user()]:
>
>     *(unsigned long *)(dst+res) = c;
>
> Still generate correct instructions because:
>
>   1. There's no aliasing involved [1]
>   2. SIMD instructions are not allowed in the kernel [2]
>
> But that doesn't mean at all that things won't change in the future. At any
> point, some optimization in a newer compiler might generate incorrect code even
> for the above-mentioned example. Therefore, while I understand compiler
> engineers' point of view (they provide a compiler with an ISO-compliant
> behaviour), I'm concerned about the correctness of all the code that assumes
> unaligned access (on some architectures) in C is just fine. 
>
> Mitigations
> ------------
> In my understanding, the simplest way to force GCC to emit a single MOV
> instruction with unaligned access, without risking any kind of UB, is to use
> __builtin_memcpy(). It works great, but it requires fixing the code in many
> places. Also, maybe using get_unaligned()/put_unaligned() is the right thing to
> do? The problem is that the put_unaligned_* inline functions don't use
> __builtin_memcpy() and are defined like:
>
>    static __always_inline void put_unaligned_le32(u32 val, void *p)
>    {
>    	*((__le32 *)p) = cpu_to_le32(val);
>    }
>
> So, still UB. To make the compiler happy, maybe we should make them use
> __builtin_memcpy()?
>
>
> Conclusion
> -------------
> What do you think about all of this? I realize that this is not a big urgent
> problem *right now*, but at some point it might become one. How do you believe
> this problem should be addressed in Linux? 
>
>
> Thanks,
> Vlad
>
>
>
> Footnotes
> ---------------------------------------------------
> [1] If aliasing is involved, even with -fno-strict-aliasing, unaligned access
> WILL break some code, today. Check the following example:
>
>    int h(int *p, int *q){
>      *p = 1;
>      *q = 1;
>      return *p;
>    }
>
>    typedef __attribute__((__may_alias__)) int I;
>
>    I k(I *p, I *q){
>      *p = 1;
>      *q = 1;
>      return *p;
>    }
>
> Starting from GCC 8.1, both h() and k() will always return 1, when compiled with
> -O2, even with -fno-strict-aliasing.
>
> [2] Some SIMD instructions have alignment requirements that recent compilers
> might just start to assume to be true, in my current understanding. In general,
> SIMD instructions can be emitted automatically by the compiler because of auto-
> vectorization. But, fortunately, that *cannot* happen in the kernel because we
> build with -fno-mmx, -fno-sse, -fno-avx etc.

Cc:ing linux-toolchains.

__attribute__ ((aligned (1))) can be used to reduce alignment, similar
to attribute packed on structs.  If that doesn't work for partially
overlapping accesses, that's probably a compiler bug.
