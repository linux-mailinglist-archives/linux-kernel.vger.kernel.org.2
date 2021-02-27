Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E19F326BCF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 06:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhB0F37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 00:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhB0F35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 00:29:57 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36A0C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 21:29:15 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id l18so7353322pji.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 21:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=FOIh0C6p3H+/JCgzGYGGAscTPrZ5Gvg80ujzoULD2s4=;
        b=0OqHQexTKfdmlFKyKJDt1xoZPVDLkTmpgkslAOzpRmyTvw07KLYhfbbDP5Za2IygZC
         nGrGoARGHxBYp7sYhQItAp+OC/f51zDLMBsHeNZd2vnlcyEr/b37JCjk0s81jwjHCJa8
         u/kJ5kcv8MF8+Jae9QAZtAjqYV4LiARUkaG0m3ZoV6ISCPaXlEVzKTiwPTyJoZxYq669
         vkWy8VU+UxQ1O6UwMdgFyNUC9JMeVPzlehdq2OJZ1SAeODK81UXH8iePMPyNJTgN/V2f
         Lits+tZIaMnA8IpR99Y60K8zQ+3UYxiC/28YTZWTEzdYLVE76JxTrJRKaWt899TDkq2X
         OzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=FOIh0C6p3H+/JCgzGYGGAscTPrZ5Gvg80ujzoULD2s4=;
        b=IkEx9c6bVP1NUnRcVxufIo2Qy8OrWZr4KHPgVySyOZz72cYG178My0Yto2QzDutIW9
         22TAokXluBL5NzVNr5uSsJl3yvTq71POGlfwRTLrVBf/hQefjbmJG9trhKglRErVmKhl
         2iRRz2HlfIy7IqFeQbM7CKA851VHvbPc3BkaphE1oCeIIbpTciKY1GCIdeteAjykCtw3
         7n2zd44XTJCxKrD11KLoaCSnQkTWmowqmySNxzakJDRqtUizGR2k3Iy/1eXHUt+KJ+aO
         uY4brclAQqDQC+74ouu/1IEAkz4w/iyy85q9QecGM/Ig4efBSanw4xrrsAU09HKG1EzM
         euDg==
X-Gm-Message-State: AOAM533ZktMnT8JU6OYVENj41LRWaCHhqIoW4Rm2vGTFE3l3/22C+jG8
        ZcsABjEma/pQ/IjZn/V2yiuvEpYHovs2yehR
X-Google-Smtp-Source: ABdhPJx1hFmgkOpRQCZvfZEJZq9FZOaO4yip8ci844PJDkDteECpwN8ig742xVNy+hIN+Ksyuuyidg==
X-Received: by 2002:a17:90a:7104:: with SMTP id h4mr6561000pjk.189.1614403755369;
        Fri, 26 Feb 2021 21:29:15 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q128sm11246093pfb.51.2021.02.26.21.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 21:29:14 -0800 (PST)
Date:   Fri, 26 Feb 2021 21:29:14 -0800 (PST)
X-Google-Original-Date: Fri, 26 Feb 2021 21:29:13 PST (-0800)
Subject:     Re: [PATCH] RISC-V: Enable CPU Hotplug in defconfigs
In-Reply-To: <20210209054620.25005-1-anup.patel@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <Anup.Patel@wdc.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-1c7a9de4-c98a-4b2f-bcee-dc0d618b8c26@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Feb 2021 21:46:20 PST (-0800), Anup Patel wrote:
> The CPU hotplug support has been tested on QEMU, Spike, and SiFive
> Unleashed so let's enable it by default in RV32 and RV64 defconfigs.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/configs/defconfig      | 1 +
>  arch/riscv/configs/rv32_defconfig | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 8c3d1e451703..6c0625aa96c7 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -17,6 +17,7 @@ CONFIG_BPF_SYSCALL=y
>  CONFIG_SOC_SIFIVE=y
>  CONFIG_SOC_VIRT=y
>  CONFIG_SMP=y
> +CONFIG_HOTPLUG_CPU=y
>  CONFIG_JUMP_LABEL=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index 2c2cda6cc1c5..8dd02b842fef 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -18,6 +18,7 @@ CONFIG_SOC_SIFIVE=y
>  CONFIG_SOC_VIRT=y
>  CONFIG_ARCH_RV32I=y
>  CONFIG_SMP=y
> +CONFIG_HOTPLUG_CPU=y
>  CONFIG_JUMP_LABEL=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y

Sorry about that.  I missed a handful of things, I'll send this out tomorrow.
