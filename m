Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DF643BE39
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 01:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbhJZX7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 19:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237192AbhJZX7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 19:59:33 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A4DC061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 16:57:09 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d9so973825pfl.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 16:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ox25PEd+7ja67BkL02/UpuGlluy92XCgWo2yIwyEZj0=;
        b=Ny3C/AYqnDIk9xUQr0b2aUAc6ZqIKH/IzKv5eS1yCC2fOeIfvOw5ppqcw7zg2AMxmU
         daSzKE92Mphk4eLrkfaJQi5JmGg73wL6Nx7rU0ObM6PCH1qoqR5f+djvvlicX16GbpHJ
         Bykdqg8Yz55S7Yquy6LFRxoXKruHK9qzxTAXDbDK4fmqjFR21/fX8Z3J3LH4vcmZ8fs+
         L8SeDoY0Fo1+d03hrg6uCBJPvNXfmY2WuFmOg0MJlszUDIORd183Mi9ibUMmMuoKwu5d
         p1gNEAwJU3oV7ICBvxFMPeDPLOvT9isHcymcpwsgdzkWTq1YQZsUnB0Hpc7Y76hvMFhL
         O+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ox25PEd+7ja67BkL02/UpuGlluy92XCgWo2yIwyEZj0=;
        b=gbp53zWzUq7iskG+NvLpuHqTCxhfMGu6F/DslOYE9eHeuFfy8yC6t9HYkt4NYeeUY4
         xhSCZCuS0dFtY3lc6VrpbYYn3hSp78M8tEszWdfv9fTP74vIgNn7T8dciHAikzmup3Ip
         riLAGemi4cLNHpW/snTR5M4ET/oVtWcEP15aeKpHKhClMZbHn7rZRA90ajsz1OJoGXPv
         x33zx7bgjqTYeRGi7hkYJK2HS0CeFnPcbaWH8pv6ax3reu8+bQbjsGvu67r4HJBUT/LX
         VIS33/7LaIonOFJgDuFeNZLc5VsXdpNCnumS2c3NeXKRgq+I021gF5nPfVFPKuD5ScGW
         ybWw==
X-Gm-Message-State: AOAM530N/4OhU6oANsycKT+m4s8+4QWK3cWTidT4ey6c1l/IJCnKo4SZ
        pYnGgpRtAVzGFh9bUTrqM+DlIw==
X-Google-Smtp-Source: ABdhPJz3RQ63fyBQqvKn/D46Jc2OoCtWF/yyFNbn9ZrAf/N6PuubuHYBrlFNyVhRKH5q85eSH0FjDw==
X-Received: by 2002:a05:6a00:23d3:b0:44c:a67f:49af with SMTP id g19-20020a056a0023d300b0044ca67f49afmr28918069pfc.50.1635292628805;
        Tue, 26 Oct 2021 16:57:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:5e10:676c:ab93:f48d:23ae])
        by smtp.gmail.com with ESMTPSA id 23sm1847703pjc.37.2021.10.26.16.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 16:57:08 -0700 (PDT)
Date:   Tue, 26 Oct 2021 16:57:08 -0700 (PDT)
X-Google-Original-Date: Tue, 26 Oct 2021 16:57:04 PDT (-0700)
Subject:     Re: [PATCH 1/1] riscv: defconfig: enable DRM_NOUVEAU
In-Reply-To: <20211012164658.81894-1-heinrich.schuchardt@canonical.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Anup Patel <Anup.Patel@wdc.com>, axboe@kernel.dk,
        sagar.kadam@sifive.com, Atish Patra <Atish.Patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        heinrich.schuchardt@canonical.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     heinrich.schuchardt@canonical.com
Message-ID: <mhng-5dc2aa26-9f1c-4764-9877-6d99569210b4@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2021 09:46:58 PDT (-0700), heinrich.schuchardt@canonical.com wrote:
> Both RADEON and NOUVEAU graphics cards are supported on RISC-V. Enabling
> the one and not the other does not make sense.
>
> As typically at most one of RADEON, NOUVEAU, or VIRTIO GPU support will be
> needed DRM drivers should be compiled as modules.

Do you have an nVidia card that works on real hardware?  Last I checked 
was a while ago, but they weren't working at the time (IIRC it was 
something to do with PCIe addressing, but it was a hardware limitation 
so I don't remember exactly how it all fits together).

If they work then I'm happy to flip them on.

> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/riscv/configs/defconfig | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 4ebc80315f01..c252fd5706d2 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -72,9 +72,10 @@ CONFIG_GPIOLIB=y
>  CONFIG_GPIO_SIFIVE=y
>  # CONFIG_PTP_1588_CLOCK is not set
>  CONFIG_POWER_RESET=y
> -CONFIG_DRM=y
> -CONFIG_DRM_RADEON=y
> -CONFIG_DRM_VIRTIO_GPU=y
> +CONFIG_DRM=m
> +CONFIG_DRM_RADEON=m
> +CONFIG_DRM_NOUVEAU=m
> +CONFIG_DRM_VIRTIO_GPU=m
>  CONFIG_FRAMEBUFFER_CONSOLE=y
>  CONFIG_USB=y
>  CONFIG_USB_XHCI_HCD=y
