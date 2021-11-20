Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7741C457AF9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 04:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbhKTEB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 23:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhKTEBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 23:01:25 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BAFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 19:58:22 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id a9so21465656wrr.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 19:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k2CjoMsxBptXVqkDa29fYtIMwwlgdoCQU4ETPJxBOQ8=;
        b=EhjqRL/Z4pOX+J811Y+x6gcbH7pV9cQJosEHhcTLiQ8rexN1ajlRPoJoyIr/dwbIJC
         7MYQVzWG8XuY/mcMHREuB9s36SOreVe8G4NfHUKz0ChpPWhUABvb23kh9dBqZHJ0RIpK
         hRFVUGXQ3ZeSCUS5YD6jV3efnsb2lcfO7GRok5FVKGBgWYz9ucsvDBH55XxtJzn/Ge4L
         rHxArTMMLhYF2nsWLagRH7L/2ME08CJZTMuYvVAZGA6tCp9BDdt+TXtFwW94ARDQuHmK
         sGyiIJX5klNEISw5aGszx81lylTc9nA56c/rE1RmYJYNgXxMjUiNnP7seCTWs7Ru0FOn
         Kr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k2CjoMsxBptXVqkDa29fYtIMwwlgdoCQU4ETPJxBOQ8=;
        b=Bi/nLGW9uHVtm+SNvUQTzOa8DTFqUxSCKdzZt5ShxRR+RXD5ECRGzSnB72/fOvAxGe
         W3DJztFaY2kVRfiSJp5JUtEWQMrFMXNaO0gnHA2PdaCgMPXP4SXUWbTtwqHmCfxejZEn
         lXuSLk3mkKsKVRBOqDEsvTWOMMkRJHTI3/oIhVmP910IA1vQhIp9eanEM0qw9EQpJdjd
         LRgeDVXmxzO0icAvmULFFfebu7KBzFURNMpb6z5sKUjuASCbh6x+G0clhcWJorKLgLBS
         PEtddqopFLPEDOqXVmGRG20miRrBffwcvAPysstiirUDHbXyDtYbk4/OM3gWY/mmYt59
         w51g==
X-Gm-Message-State: AOAM531iTJVQCbcDq3TWiWEuWAZ7mm7YizixXW30D19uI4NaRRXjrKEH
        GW/4B/3RIr7YSha8V2nas0mBRLP3aCgvxTeyQH59Ew==
X-Google-Smtp-Source: ABdhPJwGvccO8ogaudOrnhnsD+gIPWIGY/81C3RezCTNz+iSgUGzBBaViIBhkvwypBJ+MIZDrneEzGUnme2SftJo9y8=
X-Received: by 2002:a5d:4846:: with SMTP id n6mr13626836wrs.249.1637380700802;
 Fri, 19 Nov 2021 19:58:20 -0800 (PST)
MIME-Version: 1.0
References: <20211119164413.29052-1-palmer@rivosinc.com> <20211119164413.29052-4-palmer@rivosinc.com>
In-Reply-To: <20211119164413.29052-4-palmer@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 20 Nov 2021 09:28:09 +0530
Message-ID: <CAAhSdy2qswfrbb0LMNxq-U29og9OQRwRyMBH+KaGPgFdDQEgEg@mail.gmail.com>
Subject: Re: [PATCH 03/12] RISC-V: defconfigs: Sort CONFIG_BPF_SYSCALL
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

On Fri, Nov 19, 2021 at 10:14 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> This should have no functional change, it just sorts CONFIG_BPF_SYSCALL
> the same way savedefconfig does.
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/configs/defconfig      | 2 +-
>  arch/riscv/configs/rv32_defconfig | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 11de2ab9ed6e..a6cb99cf4d3c 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -2,6 +2,7 @@ CONFIG_SYSVIPC=y
>  CONFIG_POSIX_MQUEUE=y
>  CONFIG_NO_HZ_IDLE=y
>  CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_BPF_SYSCALL=y
>  CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
>  CONFIG_CGROUPS=y
> @@ -13,7 +14,6 @@ CONFIG_USER_NS=y
>  CONFIG_CHECKPOINT_RESTORE=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_EXPERT=y
> -CONFIG_BPF_SYSCALL=y
>  CONFIG_SOC_SIFIVE=y
>  CONFIG_SOC_VIRT=y
>  CONFIG_SOC_MICROCHIP_POLARFIRE=y
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index 05b6f17adbc1..8a57c940d5ef 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -2,6 +2,7 @@ CONFIG_SYSVIPC=y
>  CONFIG_POSIX_MQUEUE=y
>  CONFIG_NO_HZ_IDLE=y
>  CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_BPF_SYSCALL=y
>  CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
>  CONFIG_CGROUPS=y
> @@ -13,7 +14,6 @@ CONFIG_USER_NS=y
>  CONFIG_CHECKPOINT_RESTORE=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_EXPERT=y
> -CONFIG_BPF_SYSCALL=y
>  CONFIG_SOC_SIFIVE=y
>  CONFIG_SOC_VIRT=y
>  CONFIG_ARCH_RV32I=y
> --
> 2.32.0
>
