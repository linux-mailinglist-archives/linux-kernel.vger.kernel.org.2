Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B96B457B03
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 05:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbhKTEGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 23:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236743AbhKTEFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 23:05:45 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6E7C061756
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:02:20 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d24so21532780wra.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kXDYFUbtK5blbIHxgSBnYcG4kvaxmY3jttH/eZ1V35Q=;
        b=pl686RiDOYZZ+UFgC0xAnclHtqmLOetZLriBRBz82fthdUGAiDkPE9tnMsI8+qcnwU
         SQvAg8cc/OvaJ8YBoBHqSO7CN583qlSxR9Y/nW86TH/dTWS6ZDBwOqa3/VS7wwINqNlh
         eEY9Ffsts3NqjjvK4u13TES4mgN99dm1Vn8oMqz1hAhzvtRIMOuzbWVvklyKtKYYoeUh
         /sPG33PHKIij1zZixQFkMmoasd0y/fwXqVTrkQ6rwkfRENGkSGpt3TMbnpa7puX98UXp
         9+CGhogcdQxWl5gVDSez/7Y1m4rG/aFb8yXfc2/MawvbglkNcna2bkjUyYiBGY1O6x1h
         hggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kXDYFUbtK5blbIHxgSBnYcG4kvaxmY3jttH/eZ1V35Q=;
        b=wY8APSIHTkn09dNEz72pUZnlxY66/7dEo5+qXSk20AZZgkBuLkyiWLn1rX4mcbXgvV
         wksXyqXK1pm4eRejpYGHHvJtsjqlSaRvFI34GMuDoHyJ2VVV44kZ9Wtuj3+24OYzBNpv
         KpqNVNCMEQk7Hn/zcevGJ2+0xkh2G+TL9OZ4SATPlKn/s+Mczk9QgQQ5LuHTkPHc/tcw
         DzWBa1rAQYyYzKWvrpJGGcTdqh6y17pat43Kk92InrSGb/iFR6nlxQen5SOF0ZX30bBW
         mBakmzqz0aCNDguPIO1kOPo7Z6I2Rl0z6TKzJ+shlakCwcnwNQXkewvu9kioIW32Cm6K
         QWYg==
X-Gm-Message-State: AOAM532EmKIJqZilABL+Nwfuvc9w7HChdpwJg2/segh8+Mp290kTwn3C
        fhyE/LDcHkKEcrZX89rdG1n4foIDT1vOwptR2+7r5w==
X-Google-Smtp-Source: ABdhPJy4Bdo/2RoEuOQcWEe6rClCXaTStSZ9m9VeTdDUQ4H3Nvfcy7pqKZWoFaS5TuTHzrMkQ9+Ec5lRp6ph5BpMTS4=
X-Received: by 2002:a5d:4846:: with SMTP id n6mr13651427wrs.249.1637380939141;
 Fri, 19 Nov 2021 20:02:19 -0800 (PST)
MIME-Version: 1.0
References: <20211119164413.29052-1-palmer@rivosinc.com> <20211119164413.29052-9-palmer@rivosinc.com>
In-Reply-To: <20211119164413.29052-9-palmer@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 20 Nov 2021 09:32:07 +0530
Message-ID: <CAAhSdy3vdiOoVJ=M7JYQ-oFZukxdp9rc0_4F7B1cSXxrXYofTg@mail.gmail.com>
Subject: Re: [PATCH 08/12] RISC-V: defconfigs: Sort CONFIG_SURFACE_PLATFORMS
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Bin Meng <bin.meng@windriver.com>,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>, axboe@kernel.dk,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atishp@atishpatra.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 10:15 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> This should have no functional change, it just sorts
> CONFIG_SURFACE_PLATFORMS the same way savedefconfig does.
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/configs/nommu_k210_defconfig        | 1 -
>  arch/riscv/configs/nommu_k210_sdcard_defconfig | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
> index b16a2a12c82a..89ab76349ea8 100644
> --- a/arch/riscv/configs/nommu_k210_defconfig
> +++ b/arch/riscv/configs/nommu_k210_defconfig
> @@ -75,7 +75,6 @@ CONFIG_LEDS_GPIO=y
>  CONFIG_LEDS_USER=y
>  # CONFIG_VIRTIO_MENU is not set
>  # CONFIG_VHOST_MENU is not set
> -# CONFIG_SURFACE_PLATFORMS is not set
>  # CONFIG_FILE_LOCKING is not set
>  # CONFIG_DNOTIFY is not set
>  # CONFIG_INOTIFY_USER is not set
> diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/configs/nommu_k210_sdcard_defconfig
> index 61f887f65419..690460f79925 100644
> --- a/arch/riscv/configs/nommu_k210_sdcard_defconfig
> +++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig
> @@ -72,7 +72,6 @@ CONFIG_LEDS_GPIO=y
>  CONFIG_LEDS_USER=y
>  # CONFIG_VIRTIO_MENU is not set
>  # CONFIG_VHOST_MENU is not set
> -# CONFIG_SURFACE_PLATFORMS is not set
>  CONFIG_EXT2_FS=y
>  # CONFIG_FILE_LOCKING is not set
>  # CONFIG_DNOTIFY is not set
> --
> 2.32.0
>
