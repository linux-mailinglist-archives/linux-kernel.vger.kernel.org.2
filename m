Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D8431F553
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 08:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhBSHQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 02:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhBSHQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 02:16:14 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BDCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 23:15:34 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id e9so2874887plh.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 23:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=KPZ5e+WI7QScUG4Pb9YaSk3mJ5BTJO553uiidTwwPnQ=;
        b=Km3K5boy26IbZJy6Uc0nROwK+ch9BJ2OS2wT3t1vxcrUO8w4Zw/S2U21vRVta1pw/I
         M5bB4kN0ulIs1ahQVNdykfDUUWDaL2bONzQ93NMKlT/QtFJmrlMPF07XZBq9QPDx6pxG
         V8NZfJPlSEUJNhKf7wnRz3gR5Uhoi0nvSzdKJO4ZSVl//E5I1ADEe0+Bh+0qJdUdGIhG
         kHsgep0V2bnrIUlIm98UHLjqvlXZVbguu0+V5SazmnxAj+T6H9ATroeIVn2dQ+o5Df+s
         i3pZ1SxBJt8vn1a196vWt0sMLI2nD4uP5dFBnFCm1dbizEj4h0+9iJ5Q2t+tpBbreg3Q
         m07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=KPZ5e+WI7QScUG4Pb9YaSk3mJ5BTJO553uiidTwwPnQ=;
        b=LATMQ4aZjih1aIRFN536n6Hn8CZ+zcHZOOe+ViByirFY8kj+OsrMTdQRuOoaE+nzxP
         oSvGJuIsNUp6lF5k1S06BbY9TjMNX06cObp8xswQwenHh/na7Oln9vvcdmQqsith5ZTu
         PvLiSFE0jrlKgize5fNlWE9t6D7A9FVSd1U93nlLGqGD4LaRlWkfpewU7j/wv5RxKs3t
         hzkKxXNa5A812P3iiKokw9K0lta+08fWTTnEE5TNbIpX+7qQQYbQZuFKLbCAj3YjA1TU
         PywDQSnLsKp3/ZI+cV+kpO3hLSSvEUNjZh92KmRSKYxP/mqgUGE/nXhl4bKqr0kgDB7k
         p4HA==
X-Gm-Message-State: AOAM532QALCn2Kw0n4zHgRd5dZkYh4IxLwztolDPOAKjTb/P85CF2bIX
        LfDLXjz3AtszurplC4xuDVQxEg==
X-Google-Smtp-Source: ABdhPJzA6v2v4lWVJczpXckHFjkNGIxtz3xyvqXeT7rEN/x5uvJ5Du4BqmG7cJXpvDZ/dfRErioYTA==
X-Received: by 2002:a17:902:b009:b029:e3:6915:5475 with SMTP id o9-20020a170902b009b02900e369155475mr7925991plr.34.1613718933323;
        Thu, 18 Feb 2021 23:15:33 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v1sm10131680pfi.99.2021.02.18.23.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 23:15:32 -0800 (PST)
Date:   Thu, 18 Feb 2021 23:15:32 -0800 (PST)
X-Google-Original-Date: Thu, 18 Feb 2021 22:32:57 PST (-0800)
Subject:     Re: [PATCH] RISC-V: Enable CPU Hotplug in defconfigs
In-Reply-To: <20210209054620.25005-1-anup.patel@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <Anup.Patel@wdc.com>
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-ae92ee05-1177-4e83-9385-1e513e4883d1@palmerdabbelt-glaptop>
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

Thanks, this is on for-next.
