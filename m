Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8096421B61
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhJEBGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhJEBGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:06:12 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9B2C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 18:04:22 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id b65so18320663qkc.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 18:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=oebmTSxmq+zU8Utjs0yaAqanKgzPEsj+GJBxRd8logo=;
        b=V2iUDB19iERQnJXZioGUMJdM/uynjFuRplbo7a5cEjDjxHwD2V8DwueeGPziYpbB71
         Bi9liJ6HB2HHZX6lxu+oHLksFzHeBVlU+X0Nd6OowCRe7v7npgTonODB4rqmB3qVEqw/
         jPGpQidXVV8GXapY/RU2rL3Fyjj1axEjXQnoedoWQNonB6JXkWMVrpKM+o5p3m0Ycs2Q
         nkodGtZjkgnRUL5jEe95IomrgwwUY8EkQtpglV6mKWZOmXwzD/nwEuLhYOuXNG7rGVeN
         nYQTN8FwNRwge3tobOp0kDWk3Aj3ml6KVwepwzNcWTatc7yS9ioeSUidAKzg2Ffmq+zg
         vILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=oebmTSxmq+zU8Utjs0yaAqanKgzPEsj+GJBxRd8logo=;
        b=GB52kiMK6/S3w6vS2fgJ7xzMw/+7AMiBKdvKnwg83l8zcEgwXMX9WBggKZnedPrN5F
         PdIGyi1FQDXxhOktvx2zPv5aQ9Kl131g1gIlguMkNZB5e7fdmm6Rdv3tqIWSZCSlSfHS
         Z56APPs15l9XKEiCWg8+6MUXyyoltkidbUfIDs10DV8Vs8gu/tLbXRNGKwwZMnSoSmus
         n6C1+X5iK8h3TrtrbkTU3BDL0JCQhx7+Fz15xt6fzj2Ptg4LX2NUnsYjkjpUgc1kLl9d
         L+o87eewuJyqOWR4EzYr/3dgG9YxyyxfXoF9DfQxRQ7fvWbbdtfMAcuGG+Il+NZh1Q8B
         CEwg==
X-Gm-Message-State: AOAM533ui1AfT7XAdCeuxSkVk68yYBrH+n5Wkx3J/j6OfT4nxGwy99vB
        gyAbiduGMUlxoTbfk5J/azzu7w==
X-Google-Smtp-Source: ABdhPJxkgUQGetwYGwiMjOMe+4nfq0UAIiYMxQuw9rxEaWWsEjAU6KlSu+C3bWRK9Yx/c927Qw6f0Q==
X-Received: by 2002:a37:a40e:: with SMTP id n14mr12925505qke.81.1633395862031;
        Mon, 04 Oct 2021 18:04:22 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id c9sm10444214qte.16.2021.10.04.18.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 18:04:21 -0700 (PDT)
Date:   Mon, 04 Oct 2021 18:04:21 -0700 (PDT)
X-Google-Original-Date: Mon, 04 Oct 2021 18:04:17 PDT (-0700)
Subject:     Re: [PATCH v2 0/2] riscv: improve unaligned memory accesses
In-Reply-To: <20210918221713.289f63bb@xhacker>
CC:     wangkefeng.wang@huawei.com, chenhuang5@huawei.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Darius Rad <darius@bluespec.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang3@mail.ustc.edu.cn
Message-ID: <mhng-3469a0a8-a337-4b56-8e4f-b5a8bc47c4e9@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Sep 2021 07:17:13 PDT (-0700), jszhang3@mail.ustc.edu.cn wrote:
> On Sat, 18 Sep 2021 09:14:05 +0800
> Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>> On 2021/9/17 22:14, Jisheng Zhang wrote:
>> > On Thu, 16 Sep 2021 13:08:53 +0000
>> > Chen Huang <chenhuang5@huawei.com> wrote:
>> >  
>> >> The patchset improves RISCV unaligned memory accesses, selects
>> >> HAVE_EFFICIENT_UNALIGNED_ACCESS if CPU_HAS_NO_UNALIGNED not
>> >> enabled and supports DCACHE_WORD_ACCESS to improve the efficiency
>> >> of unaligned memory accesses.
>> >>
>> >> If CPU don't support unaligned memory accesses for now, please
>> >> select CONFIG_CPU_HAS_NO_UNALIGNED. For I don't know which CPU
>> >> don't support unaligned memory accesses, I don't choose the
>> >> CONFIG for them.  
>> > This will break unified kernel Image for riscv. Obviously, we will have
>> > two images for efficient unaligned access platforms and non-efficient
>> > unaligned access platforms. IMHO, we may need alternative mechanism or
>> > something else to dynamically enable related code path.  
>> 
>> it won't break unified kernel Image for riscv, if one SoC choose
>> 
>> CPU_HAS_NO_UNALIGNED, the single Image won't support unaligned memory
>
> the "unified" means the kernel Image has to support all RV64GC or RV32GC SoCs.
> To make the Image works for both efficient unaligned access and inefficient
> unaligned access, I think we'd better make "inefficient unaligned access"
> default behavior, the use alternative etc. tech to patch related code path
> for efficient unaligned access.

I agree, at least until we have a sufficient breadth of implementations 
to know whether efficient unaligned accesses are going to be possible.

There was also a question about what exactly the C906 unaligned access 
handling looks like on GCC, as well.  Do you guys have any sort of 
pipeline description?

>
>
>> 
>> accesses, indeed, it depends on the CONFIG, and now, arm/powerpc/m68k has
>
> linux Distributions doesn't have enough background of which config options
> must be enabled.

I wouldn't be opposed to adding this as a Kconfig option, something 
along the lines of "tune for fast unaligned accesses" or whatever.  I 
get that we're sort of just punting the problem to distros, but we could 
add a Kconfig.socs-like (though that is a mess, so we'd need something 
saner) tune target (which is maybe coupled to -mtune, as well?).  That 
would a least let us give users the option of making this choice, and 
while it'd still likely be best to set this to slow unaligned accesse to 
start we may be able to more easily see what distros choose at this 
point.

>
>> 
>> similar configuration.
>
> I have little knowledge of powerpc or m68k, but there are serveral different
> defconfig files for arm, for example multi_v7_defconfig and multi_v5_defconfig.
> The previous v7 version enables HAVE_EFFICIENT_UNALIGNED_ACCESS while
> the later v5 doesn't. Will you persuade riscv maintainers to accept one more
> defconfig file?

I'm not super worried about having more defconfigs, but I'm not really 
sure it's worth it for this option alone.

>
> Thanks
>
>> 
>> Yes,  it could be an optimization via alternative mechanism or something 
>> else to
>> 
>> dynamically enable related code path later.
>> 
>> >
>> > Regards
>> >  
>> >> Changes since v1:
>> >>   - As Darius Rad and Jisheng Zhang mentioned, some CPUs don't support
>> >>     unaligned memory accesses, add an option for CPUs to choose it or not.
>> >>
>> >> Chen Huang (2):
>> >>    riscv: support HAVE_EFFICIENT_UNALIGNED_ACCESS
>> >>    riscv: Support DCACHE_WORD_ACCESS
>> >>
>> >>   arch/riscv/Kconfig                      |  5 ++++
>> >>   arch/riscv/include/asm/word-at-a-time.h | 37 +++++++++++++++++++++++++
>> >>   2 files changed, 42 insertions(+)
>> >>  
>> >
>> > .
>> >  
