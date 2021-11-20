Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33EA457B06
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 05:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbhKTEIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 23:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236671AbhKTEIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 23:08:00 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1928AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:04:57 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so62694wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EuLCYTqwajLrL4KlZnNwPOKJYICjtKr/KDo2ktZ6q40=;
        b=OsIhxRxumlp+NaVqDOIF9oC+OKhccUX4Ow5VhvH+yFWjfe0BC5505vQ6zFVBjVX3uV
         6wPiam8TiCva4H5vHLfk6oedMPQkWIM7o5z1K31v8cak5QMiQSmCm5tcmtd5OOg+XlVl
         KVWnZnWvvnDlUoFsSfM065j8Ngts7cyIQ4qcsVtD/qc5f46Zx8/dK9LPPXbsYrEpEoF7
         H01KhtIsYyxcsG1fRCb6l45QvrlTe3vYtFz/kq8BWTAwo5ZbUAHSVJrOuGQsR6HaNcRg
         mz+uYI5AQBzxThW8KXMwbMXmidCTmzwI4YiZJvezyi2RcMyO/+KiBwrgDWgv+6jUk/KY
         tGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EuLCYTqwajLrL4KlZnNwPOKJYICjtKr/KDo2ktZ6q40=;
        b=gNEC0p65Sy2oWlW1DjlVscf4ISYi5/N34TLvFtVDQD62lGY66qnAdGto+9jK6EpxEb
         Vgjt6fxNc77MtdETSU3DQI3eYK4fT1dfHiSaCz5DA+9/YIWKEvhS+q1uJBn6SoxAwx3m
         bOQ0bfamSFT2YcJnsXyOp/DvG2c1DSiJ9e6sd6HDMV2zeJUxwsysYS4KkhUjxjqIm7Yi
         ske23z95fuiSOeqsLqaXBoCH5+YH8VVD+4r74iwhBGyaYdw/D9qsu961HcWVDSWNPSmY
         hGrJul7IDZZtiQBHK+olQuBUitRJnh66RzIOREXACWWz3jMtb35K7W3OHETsfKq1I2rq
         K0gQ==
X-Gm-Message-State: AOAM532snMftMcK57pdmFuedpX0P0w5CLsykdMvPJwYZ3FcCumb/L+U+
        P03OIpM/Aw0JbhD6ncKN/Pr4ufb/3+D3Kdj7f7mWTQ==
X-Google-Smtp-Source: ABdhPJzWEO/BNh+sp0FdgL+gqqVhPArx3E0d8BJ8oMoc0LDfCZ8NXZyGHmyF6q9WXMR+6oYvk72ZJCB2MEgIl8Jdt7w=
X-Received: by 2002:a7b:c194:: with SMTP id y20mr6732345wmi.61.1637381095533;
 Fri, 19 Nov 2021 20:04:55 -0800 (PST)
MIME-Version: 1.0
References: <20211119164413.29052-1-palmer@rivosinc.com> <20211119164413.29052-11-palmer@rivosinc.com>
In-Reply-To: <20211119164413.29052-11-palmer@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 20 Nov 2021 09:34:43 +0530
Message-ID: <CAAhSdy0a5+yctd4jnSDr94+Ghi-brLXdQgeCbL6PUNm4=2AW8Q@mail.gmail.com>
Subject: Re: [PATCH 10/12] RISC-V: defconfigs: Remove redundant CONFIG_POWER_RESET
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
> As of ab7fbad0c7d7 ("riscv: Fix unmet direct dependencies built based on
> SOC_VIRT") we select CONFIG_POWER_RESET=y along with CONFIG_SOC_VIRT,
> which is already in defconfig.  This make setting CONFIG_POWER_RESET in
> the defconfigs redundant, so remove it to remain consistent with
> savedefconfig.
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/configs/defconfig      | 1 -
>  arch/riscv/configs/rv32_defconfig | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index ec9540392df7..a72dbd74b93d 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -74,7 +74,6 @@ CONFIG_SPI_SIFIVE=y
>  # CONFIG_PTP_1588_CLOCK is not set
>  CONFIG_GPIOLIB=y
>  CONFIG_GPIO_SIFIVE=y
> -CONFIG_POWER_RESET=y
>  CONFIG_DRM=m
>  CONFIG_DRM_RADEON=m
>  CONFIG_DRM_NOUVEAU=m
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index 1f6808aa1261..8b56a7f1eb06 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -70,7 +70,6 @@ CONFIG_HW_RANDOM_VIRTIO=y
>  CONFIG_SPI=y
>  CONFIG_SPI_SIFIVE=y
>  # CONFIG_PTP_1588_CLOCK is not set
> -CONFIG_POWER_RESET=y
>  CONFIG_DRM=y
>  CONFIG_DRM_RADEON=y
>  CONFIG_DRM_VIRTIO_GPU=y
> --
> 2.32.0
>
