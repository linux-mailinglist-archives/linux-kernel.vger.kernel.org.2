Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8DA372F5F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 20:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbhEDSIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 14:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhEDSIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 14:08:45 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F38C061574;
        Tue,  4 May 2021 11:07:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r9so14605648ejj.3;
        Tue, 04 May 2021 11:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=BKXnfHlp8ztzImlCYcud32IH8VcbYkzTpfvI8+Wsiag=;
        b=jH1JJ6o+Fgo/OO0ZUKG2vinSTJF1t0tf4Kp+5uFycQFGsHNP1ujR2igy6a0LjAFGCz
         merGuN+osiI/FXls6tFrg4pHpSrxaINSo3qAuPFzKeaWP7AORA3Mfg51+3u6GkUMYw75
         uN+Ip2gHAFjwgXJ2/Sqb0Iocb59JJBqlubAx+nTnxWnNR8apVPT1qLmw5KhjDbrPR/dL
         i7+EYpUln/5RdgRfN2rSh0f8i+kvHH18IGuGGe4tO9i4TWewZuPp8E5ZNBvmq4eQEXTN
         0HAf1KUMmNpIbd1KWCznFLdEBmtK/Icg2eCcE1En5USzmgz+xOxdDFLFQJUQoDAUoqYu
         Sh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=BKXnfHlp8ztzImlCYcud32IH8VcbYkzTpfvI8+Wsiag=;
        b=hcaxC/9jVV1ae0xsgIx1+21JiYB+LD+++MqpAmD7MKHJNeURI1L5+bmL5geE67mQxY
         AmJOWrwK9DpQe0vIDfa0LqvOmNbron1jAJxr59r+i7Xk+z78wWIxAtjVxdRiy8I243Ub
         ck6gwJNf/gCz3zGK4tyoVrhpiJhV0l7exki6oI2jI0BgzECDCtWPdBA7+Y5nfeloeKrh
         tHW6llaZxPW3QSsQ75TEYK/s/mXWETubwWyDnyJgV04D0HUIr8Pl3kaUbvTwlT9Jic6F
         TKNLJeQiUEoO8qirVZZ8e83R0azahNklGE7DM5zPsQHbf9TGU7GlmLOdg7xhOYW2WIfK
         IGoQ==
X-Gm-Message-State: AOAM533FqNZAjjO2O7VcwtHTbkZQ75l6PByMvLI5LEB+aZyDlv/7HjSW
        R7TvSZvNmHT4g6g19QnzmfCY9eAVloVyqA==
X-Google-Smtp-Source: ABdhPJyudB6OfPCLYgKIPYXH6sD5KQbsCYyThYdkkFH9WkBzncoqFElJxl39MDHPqBrig36f+GwRUA==
X-Received: by 2002:a17:907:75d5:: with SMTP id jl21mr23679148ejc.280.1620151668602;
        Tue, 04 May 2021 11:07:48 -0700 (PDT)
Received: from lenovo ([92.247.133.140])
        by smtp.gmail.com with ESMTPSA id dj17sm11425104edb.7.2021.05.04.11.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 11:07:48 -0700 (PDT)
Message-ID: <c8fa8ea79ffaa5c87dac9ea16e12088c94a35faf.camel@gmail.com>
Subject: GCC, unaligned access and UB in the Linux kernel
From:   "Vladislav K. Valtchev" <vladislav.valtchev@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gcc@vger.kernel.org
Date:   Tue, 04 May 2021 21:07:46 +0300
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I noticed that in the Linux kernel we have a define called
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS that's used in a fair amount of places
with the following purpose: when it's set, unaligned access is supported by the
CPU so we can do it directly, otherwise fall-back to some logic where a byte at
the time is read/written. For example, check the implementation of
do_strncpy_from_user():
https://elixir.bootlin.com/linux/latest/source/lib/strncpy_from_user.c#L15


That's nice and seems to work today as expected, but there's one problem:
unaligned access is UB according to the ISO C standard, no matter if the
architecture supports it or not. Also, GCC doesn't have any option similar to "-
fno-strict-aliasing" to make unaligned access non-UB. At the moment, they won't
consider introducing such an option either. Check this bug:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=93031

Starting from GCC 8.x, the compiler introduced some new optimizations that
assume correct alignment which can break some code[1]. However, unaligned access
like the following [from do_strncpy_from_user()]:

    *(unsigned long *)(dst+res) = c;

Still generate correct instructions because:

  1. There's no aliasing involved [1]
  2. SIMD instructions are not allowed in the kernel [2]

But that doesn't mean at all that things won't change in the future. At any
point, some optimization in a newer compiler might generate incorrect code even
for the above-mentioned example. Therefore, while I understand compiler
engineers' point of view (they provide a compiler with an ISO-compliant
behaviour), I'm concerned about the correctness of all the code that assumes
unaligned access (on some architectures) in C is just fine. 

Mitigations
------------
In my understanding, the simplest way to force GCC to emit a single MOV
instruction with unaligned access, without risking any kind of UB, is to use
__builtin_memcpy(). It works great, but it requires fixing the code in many
places. Also, maybe using get_unaligned()/put_unaligned() is the right thing to
do? The problem is that the put_unaligned_* inline functions don't use
__builtin_memcpy() and are defined like:

   static __always_inline void put_unaligned_le32(u32 val, void *p)
   {
   	*((__le32 *)p) = cpu_to_le32(val);
   }

So, still UB. To make the compiler happy, maybe we should make them use
__builtin_memcpy()?


Conclusion
-------------
What do you think about all of this? I realize that this is not a big urgent
problem *right now*, but at some point it might become one. How do you believe
this problem should be addressed in Linux? 


Thanks,
Vlad



Footnotes
---------------------------------------------------
[1] If aliasing is involved, even with -fno-strict-aliasing, unaligned access
WILL break some code, today. Check the following example:

   int h(int *p, int *q){
     *p = 1;
     *q = 1;
     return *p;
   }

   typedef __attribute__((__may_alias__)) int I;

   I k(I *p, I *q){
     *p = 1;
     *q = 1;
     return *p;
   }

Starting from GCC 8.1, both h() and k() will always return 1, when compiled with
-O2, even with -fno-strict-aliasing.

[2] Some SIMD instructions have alignment requirements that recent compilers
might just start to assume to be true, in my current understanding. In general,
SIMD instructions can be emitted automatically by the compiler because of auto-
vectorization. But, fortunately, that *cannot* happen in the kernel because we
build with -fno-mmx, -fno-sse, -fno-avx etc.

-- 
Vladislav Valtchev (vvaltchev)

