Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D77E398399
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 09:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhFBHwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 03:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhFBHwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 03:52:36 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C8BC06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 00:50:54 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id e18so2462923eje.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 00:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VY1iZwIBhUlZ72YXvpAem8SwH7oltFUP+kYp7zCLOFw=;
        b=sTyRKFEQflZ4nbEcYajpc/Txd8xlDzzpT50nrZEUlhtsxgk0RJSpkPfptR2+Eugkgt
         gBUEYlGUhFUU/z5HQerEA5sruG1gyD4M3gcjZUaKYl/LQPE3BHY2goEcd5b38M1S+Tfp
         uWH4tK9GaDofqTDSrxp4BeEQOSThhs/3LQwqrsfdeKSRl9ZUEYgwnbN5N7yGcq+g0Hje
         FsNBaSD4028vciZDTu+2fN7pKqgU8Lqo4qAmrw7z738Df1pp4f/EIliXFhX+knNg3lfI
         BxxT3ho3CKPdJJUn0EnAJ1ijj7VhbU8EF1q6IrFFh1DRRNzEjs1i7HCR3qmgaGcK+Z6C
         AlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VY1iZwIBhUlZ72YXvpAem8SwH7oltFUP+kYp7zCLOFw=;
        b=axHEqKH7vKkRE6EawHagQMcmM8MEKLjhso0txjZNJrzudxxNNrMKb9ouQXc2e5T5pl
         aD5gzG8v8jZ398/n7C+p4shoCCJ+4gU9SNM8sbrXNX1Azcx6v5pmZatQkvVInGmYYdBl
         V85FosUlG8DEAvzTHgDTLTJLIKIwNA4pWjOGyYrrGse5Rb0wY/AiK4eQ6YFASC+W+5bW
         MsQ95w0qKaiA0BAgQMPTcJyAJL0rZ8qVGYuaI2A1t5nGog9LRe7Eng5thSXQXbmBDh2q
         cScnN0Tnpth6xbhEFG233Q07cjYkPJZ/oG3blrtPFtb7HIlun/WB9SjmGTzJCqWJ5EnN
         onuw==
X-Gm-Message-State: AOAM532IS3tCeePArLohZpN+dyvXLOSENpsD4IwjhABSV6CJ/frud5vi
        G+jm5MZQN8AZzaR00KkcFI/khLEZslw2Lkiv
X-Google-Smtp-Source: ABdhPJz95yJCoDmlG3Ec7cqaFUhfk9im/Gn8l1Z6M9MylMBHaviMyieZUKSaRBnpz1zwSDLYP5aOIQ==
X-Received: by 2002:a17:906:4e81:: with SMTP id v1mr24204eju.125.1622620252474;
        Wed, 02 Jun 2021 00:50:52 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id r19sm775556eds.75.2021.06.02.00.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 00:50:51 -0700 (PDT)
Subject: Re: [PATCH] arch: microblaze: Fix spelling mistake "vesion" ->
 "version"
To:     Colin King <colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210601103707.9701-1-colin.king@canonical.com>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <b46ad1a5-7901-443a-16e5-17f7695d7183@monstr.eu>
Date:   Wed, 2 Jun 2021 09:50:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601103707.9701-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/1/21 12:37 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in the comment. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  arch/microblaze/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
> index b41f323e1fde..6d4af39e3890 100644
> --- a/arch/microblaze/Makefile
> +++ b/arch/microblaze/Makefile
> @@ -3,7 +3,7 @@ KBUILD_DEFCONFIG := mmu_defconfig
>  
>  UTS_SYSNAME = -DUTS_SYSNAME=\"Linux\"
>  
> -# What CPU vesion are we building for, and crack it open
> +# What CPU version are we building for, and crack it open
>  # as major.minor.rev
>  CPU_VER   := $(shell echo $(CONFIG_XILINX_MICROBLAZE0_HW_VER))
>  CPU_MAJOR := $(shell echo $(CPU_VER) | cut -d '.' -f 1)
> 

Applied.
M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

