Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31110326B81
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 05:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhB0D4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 22:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhB0D4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 22:56:51 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EBDC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 19:56:10 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id b3so10472608wrj.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 19:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gFUEweW7YJBzI3ekrNG7roS8iZCSvnRTwYDpnG7vQuk=;
        b=pM6I4h2mHDT+CVmAC7GmP/X2W0FuZsmcB5ImCodcFLJ3mUwrxW2fFgsx/xtxPQ/xrw
         h3spGoI3oz7Hnrlakjx5bEAhUtOc1+8Xlv+H4GKMRbpq/8/GsbWrbu2Zp3hXjw0zOClM
         0XsU6nkxoH878uV1xUw5r2nrVuYbcYAp6zOEEa6TRmYOOWOOo0vw8ImBUjIH6JPtBYy8
         KHO+/osA1p4KNn78IS81sOVunLWw/oqZ/5XZUBKuXQcvk6JHl7bSo7L4S5QQtv8w3YbS
         u0DqvMkO8OAXHKTyEdI5ceDq1mtlk1Ov2Ktqeu7+6ZRPjm9GzEd0Q4dVoBIDjM5NYCVn
         y2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gFUEweW7YJBzI3ekrNG7roS8iZCSvnRTwYDpnG7vQuk=;
        b=prbGJKEGoM9T/oZ2LFSwv0xClnW4AIkZmRUm0876idmJd0NSuCQB8rp0pveOYLRZcE
         vjKwjsoEVOscie1ytXaw2D1ItnVsXChydJ1ckY9Xy8Y+ynltL/kuguV+//+ENLVeJY2X
         RkXe03vrshQpjbzg0IkBvxnVAkBRYcQ6ahWCZG8Hzzu2+Wh2Rle5Ao2wieKJA6riwsf2
         6YzlTKQVC37ofcHmgK8fnMWGmMss2b7HHLIvE8jTgR5IH1/3rKaqFkvXimigkiwVGybs
         1qzdDdUh0MnRdzfQ8jIaIJlnjP3CqeS17vMdCFCOeu3GWz7euQDpPWOAwMh7rbchgy/o
         N9dg==
X-Gm-Message-State: AOAM533S1gOrGE00/xNggUbfxeZpozzMlbdjst0eaYeVmetUxS/0fvDr
        oIDwjd7QqBsL8K3pvf0kbTyFjYWU3t4iqSjVK56c0g==
X-Google-Smtp-Source: ABdhPJxYldVHcYvW8MTjwC5dmIQbJsXoKjlbP43ahrwfoDnEWt24PI0rkJ+yme5V8zhe4KF2IaCsacby0jDa5KFAB5o=
X-Received: by 2002:a5d:5109:: with SMTP id s9mr6293250wrt.325.1614398169457;
 Fri, 26 Feb 2021 19:56:09 -0800 (PST)
MIME-Version: 1.0
References: <20210209054620.25005-1-anup.patel@wdc.com> <mhng-ae92ee05-1177-4e83-9385-1e513e4883d1@palmerdabbelt-glaptop>
In-Reply-To: <mhng-ae92ee05-1177-4e83-9385-1e513e4883d1@palmerdabbelt-glaptop>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 27 Feb 2021 09:25:57 +0530
Message-ID: <CAAhSdy0ZJF2uGzYDGxuhbR831GJtyRorfjAMbU8CtJ=0twiZig@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Enable CPU Hotplug in defconfigs
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Fri, Feb 19, 2021 at 12:45 PM Palmer Dabbelt
<palmerdabbelt@google.com> wrote:
>
> On Mon, 08 Feb 2021 21:46:20 PST (-0800), Anup Patel wrote:
> > The CPU hotplug support has been tested on QEMU, Spike, and SiFive
> > Unleashed so let's enable it by default in RV32 and RV64 defconfigs.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> >  arch/riscv/configs/defconfig      | 1 +
> >  arch/riscv/configs/rv32_defconfig | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> > index 8c3d1e451703..6c0625aa96c7 100644
> > --- a/arch/riscv/configs/defconfig
> > +++ b/arch/riscv/configs/defconfig
> > @@ -17,6 +17,7 @@ CONFIG_BPF_SYSCALL=y
> >  CONFIG_SOC_SIFIVE=y
> >  CONFIG_SOC_VIRT=y
> >  CONFIG_SMP=y
> > +CONFIG_HOTPLUG_CPU=y
> >  CONFIG_JUMP_LABEL=y
> >  CONFIG_MODULES=y
> >  CONFIG_MODULE_UNLOAD=y
> > diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> > index 2c2cda6cc1c5..8dd02b842fef 100644
> > --- a/arch/riscv/configs/rv32_defconfig
> > +++ b/arch/riscv/configs/rv32_defconfig
> > @@ -18,6 +18,7 @@ CONFIG_SOC_SIFIVE=y
> >  CONFIG_SOC_VIRT=y
> >  CONFIG_ARCH_RV32I=y
> >  CONFIG_SMP=y
> > +CONFIG_HOTPLUG_CPU=y
> >  CONFIG_JUMP_LABEL=y
> >  CONFIG_MODULES=y
> >  CONFIG_MODULE_UNLOAD=y
>
> Thanks, this is on for-next.

This patch was missed in your PR for Linux-5.12-rc1

Regards,
Anup
