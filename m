Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B5045ACFB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 21:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240243AbhKWUEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 15:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239128AbhKWUEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 15:04:50 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BE6C061714
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 12:01:42 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id e136so662114ybc.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 12:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t/v+kSxz1eiji85Dg0icG/ia7nsKdb5UQNgj4yu1XbA=;
        b=IwRqsQL5HJZ2NNAgvFIi1eoEuWD9tyK9eiN7sz6ZqH03QgbCLrTVI5ymeaYArtG3rQ
         Y6yudwUhG/R2NCwwz3YKxhz7q/2T+Vbe0HqrQpzUKdTBIWvkTcl/GTNfZkdudMkdxRli
         EMoiBdEhsZYYwQAByJnvzZQHmWqqoANt2vLLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t/v+kSxz1eiji85Dg0icG/ia7nsKdb5UQNgj4yu1XbA=;
        b=X8PcSDFcy4qRiMEFd4HTjRlAKcGo6bdfN67R02k3t1XT7VjCHg5fuZXXSIIZMUODT5
         ryxIWh22ZIVsgos31vjaiTDWqp7viLMsa78wKmQvHhBJEHr/YY53bfAZi8pW7R6mFB0A
         7yuqxz5Vxn2rQ5gObiODpY004lriGD+2/SIZxIq2kFHScz7gIDFgn8iPbyOdFgPuzYdq
         CDnT5R/wJcErjgkhAGbthWUqnoj7aIAKx2Nh2y2VXS2IowivZRbj1KwD5iGkiiDd5UMB
         UB73qRmfW3GjJEtisSyzt4ETrzLS+EnY2LaW8xsXuKK55EAeBIRQmzGIEF7Zqy1pDmH4
         HhtA==
X-Gm-Message-State: AOAM532znPu/4bEzqDN3MK/ve6d4uzQoUSTZ9IEOGISEjdWwdjiNHeFU
        fWYF0DLn2vNDKfVWkxJFDHC5ehV/8jLWcmpkAKx2
X-Google-Smtp-Source: ABdhPJxwy2lpaMGVdBaEtmzNC/OVDfQyJQupRowAmg8DGXxghxRN8N4XPTU8UHC6petkfR4neTSFZGp5e6jxHqNyij8=
X-Received: by 2002:a25:73d0:: with SMTP id o199mr8906443ybc.87.1637697700555;
 Tue, 23 Nov 2021 12:01:40 -0800 (PST)
MIME-Version: 1.0
References: <20211123015717.542631-1-guoren@kernel.org> <1913356.JkcO0Xq8vV@diego>
In-Reply-To: <1913356.JkcO0Xq8vV@diego>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 23 Nov 2021 12:01:29 -0800
Message-ID: <CAOnJCU+-WCHA9vgrbcMFsLMaimwJNEXOpqMLS_0Gq_JRM5QNWQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] riscv: Add riscv.fwsz kernel parameter to save memory
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Guo Ren <guoren@kernel.org>, Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, atishp@rivosinc.com,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 11:33 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote=
:
>
> Hi Guo,
>
> Am Dienstag, 23. November 2021, 02:57:14 CET schrieb guoren@kernel.org:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The firmware of riscv (such as opensbi) occupy 2MB(64bit) /
> > 4MB(32bit) in Linux. It's very wasteful to small memory footprint
> > soc chip such as Allwinner D1s/F133. The kernel parameter gives a
> > chance to users to set the proper size of the firmware and get
> > more than 1.5MB of memory.
>
> is this kernel parameter approach a result of the T-Head Ice-SoC
> currently loading its openSBI from inside the main u-boot via extfs-load,
> directly before the kernel itself [0] ?

Looking at the defconfig[1], it may be U-Boot SPL not U-Boot proper. I
may be looking at the wrong config though.
If U-Boot SPL is actually used, you don't even need to manually load
OpenSBI "fw_jump" binary.

As Heiko pointed, you should just follow how U-Boot SPL works on
hifive unmatched (creating the FIT image)
The standard U-Boot SPL uses with fw_dynamic which provides all the
flexibility you want.

[1] https://github.com/T-head-Semi/u-boot/blob/main/configs/ice_evb_c910_de=
fconfig
>
> Because that approach in general looks not ideal.
>
> Normally you want the main u-boot already running with less privileges
> so firmware like openSBI should've been already loaded before that.
> Even more true when you're employing methods to protect memory regions
> from less privileged access.
>
> A lot of socs set u-boot as opensbi payload, but for the example the D1
> mainline approach uses the Allwinner TOC1 image format to load both
> opensbi and the main uboot into memory from its 1st stage loader.
>
>
> Of course the best way would be to just mimic what a number of
> arm64 and also riscv socs do and use already existing u-boot utilities.
>
> U-Boot can create a FIT image containing both main u-boot, dtb and
> firmware images that all get loaded from SPL and placed at the correct
> addresses before having the SPL jump into opensbi and from there
> into u-boot [1] .
>
> And as Anup was writing, reserved-memory should then be the way
> to go to tell the kernel what regions to omit.
>
> And mainline u-boot has already the means to even take the reserved-memor=
y
> from the devicetree used by opensbi and copy it to a new devicetree,
> if the second one is different.
>
>
> Heiko
>
>
> [0] https://github.com/T-head-Semi/u-boot/blob/main/include/configs/ice-c=
910.h#L46
> [1] see spl_invoke_opensbi() in common/spl/spl_opensbi.c
> [2] see riscv_board_reserved_mem_fixup() in arch/riscv/lib/fdt_fixup.c
>
> >
> > Guo Ren (3):
> >   riscv: Remove 2MB offset in the mm layout
> >   riscv: Add early_param to decrease firmware region
> >   riscv: Add riscv.fwsz kernel parameter
> >
> >  .../admin-guide/kernel-parameters.txt         |  3 +++
> >  arch/riscv/include/asm/page.h                 |  8 +++++++
> >  arch/riscv/kernel/head.S                      | 10 +++-----
> >  arch/riscv/kernel/vmlinux.lds.S               |  5 ++--
> >  arch/riscv/mm/init.c                          | 23 ++++++++++++++++---
> >  5 files changed, 36 insertions(+), 13 deletions(-)
> >
> >
>
>
>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



--=20
Regards,
Atish
