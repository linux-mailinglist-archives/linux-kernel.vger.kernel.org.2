Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3ED044DB0D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 18:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbhKKR0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 12:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbhKKR0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 12:26:33 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1B9C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 09:23:44 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d27so11009408wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 09:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1h31pnDM+c9/uNpDEht54pYlbyCZL/Dfque66Y4+sjY=;
        b=b018YNnCXOJfJAPxnKmQZDckG0ABCFkahuFTI7N0p7rUIYC3DpPLABrXo7Oawi05bl
         +2KctRRvaGmuykRYZ9knsPodONNiqT3oSRvuUosaPBzlo/rOvs8wCphAVdAVF84TDzMx
         2TJXk0n+ST34/vq+u/OMsns0HutbI/6hKfTVzj6lq0tjY49GMgx40hUUof1aeUh14/pZ
         JUz83jVmwlBwtWeD314/fqtDdy8wwwauQR8cs5DM63GGlA2T67dm8hRHmkKozO1sW4ZG
         YzDDCiu/SCqpLwXBG3yPiYgyd5ewpOXC5FaCd8/XYVAC0A32ZLCbel8FliYW7cngsE/f
         iu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1h31pnDM+c9/uNpDEht54pYlbyCZL/Dfque66Y4+sjY=;
        b=mGCrfT8CmRZ2mpanRf4GYobF/x7f98cTk503tMw4uCcQKBj/KwBNhsoybjSfMuHBdR
         S3qp+aNxGEZY/w4vNUSwKcSwL38+S86bmapm2fN6SuuLEMeuEe6a1F1kHnmKlitxKU56
         PvF9BNocvWgJJLQULEhArqi/e6roPV0HGzfBC8E70fWB0aKbfgB0IF50uANasr1CnR1v
         Zeof7N5PDxUNoKQY36wvGDOOHODbL+INsf1ilxx+dYZw6m+ci667koOGrXtVH1W/sfSG
         BuKsX33v+oB3uLdvpvvBXOa7x9aVqjLLR1qmHIyjRCRaaYaenrKL54oNeeDczlrrE8yl
         GHJg==
X-Gm-Message-State: AOAM533A9NGpQNkQrpzbhTxD2O9IMuh8dPOqh0M9OkHH19JbCp3bEdsZ
        WgujZcmYDFZNF8Hig5uOGUdYhQ==
X-Google-Smtp-Source: ABdhPJzIxN5RTKGp+w0dKloEIQ2OTkmSutlwanEUwXxXicXOLgrFFxA/yF0YwCk+Hi6uHoLIManqlA==
X-Received: by 2002:adf:cc8d:: with SMTP id p13mr10503461wrj.274.1636651422746;
        Thu, 11 Nov 2021 09:23:42 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id 10sm4292290wrb.75.2021.11.11.09.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 09:23:42 -0800 (PST)
Date:   Thu, 11 Nov 2021 17:23:40 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     laurentiu.tudor@nxp.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        diana.craciun@nxp.com, ioana.ciornei@nxp.com, jon@solid-run.com,
        leoyang.li@nxp.com
Subject: Re: [PATCH 2/8] bus: fsl-mc: handle DMA config deferral in ACPI case
Message-ID: <20211111172340.fpn4pou2xwm654g5@maple.lan>
References: <20210715140718.8513-1-laurentiu.tudor@nxp.com>
 <20210715140718.8513-2-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715140718.8513-2-laurentiu.tudor@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurentiu

On Thu, Jul 15, 2021 at 05:07:12PM +0300, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> ACPI DMA configure API may return a defer status code, so handle it.
> On top of this, move the MC firmware resume after the DMA setup
> is completed to avoid crashing due to DMA setup not being done yet or
> being deferred.
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

I saw regressions on my Honeycomb LX2 (NXP LX2060A) when I switched to
v5.15. It seems like it results in so many sMMU errors that the system
cannot function correctly (it's only about a 75% chance the system will
boot to GUI and even if it does boot successfully the system will hang
up soon after).

Bisect took me up a couple of blind alleys (mostly due to unrelated boot
problems in v5.14-rc2) by eventually led me to this patch as the cause.
Applying/unapplying this patch to a v5.14-rc3 tree will provoke/fix the
problem and reverting it against v5.15 also resolves the problem.

Is there some specific firmware version required for this patch to work
correctly?


Daniel.


PS: Below is the revert I applied to the v5.15 kernel (after
    a fairly simple merge conflict fix)

From 4162b64e4f361a6a773e065b592dbc5493202524 Mon Sep 17 00:00:00 2001
From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 11 Nov 2021 16:50:25 +0000
Subject: [PATCH] Revert "bus: fsl-mc: handle DMA config deferral in ACPI case"

This reverts commit d31e7fe20a2251f87adc6ecefbdaf25e6961ce74 because
it was causing regressions on my Honeycomb LX2 (NXP LX2060A).

All kernels where the problem manifests (as either a boot hang or a desktop
hang) issue the following messages in vast number:

~~~
arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
arm-smmu arm-smmu.0.auto: Unhandled context fault: fsr=0x402, iova=0x23e0000100, fsynr=0x20040, cbfrsynra=0x4000, cb=0
arm_smmu_context_fault: 1697259 callbacks suppressed
~~~

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 8fd4a356a86e..429bacc7de20 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -1130,6 +1130,18 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	}
 
 	if (mc->fsl_mc_regs) {
+		/*
+		 * Some bootloaders pause the MC firmware before booting the
+		 * kernel so that MC will not cause faults as soon as the
+		 * SMMU probes due to the fact that there's no configuration
+		 * in place for MC.
+		 * At this point MC should have all its SMMU setup done so make
+		 * sure it is resumed.
+		 */
+		writel(readl(mc->fsl_mc_regs + FSL_MC_GCR1) &
+			     (~(GCR1_P1_STOP | GCR1_P2_STOP)),
+		       mc->fsl_mc_regs + FSL_MC_GCR1);
+
 		if (IS_ENABLED(CONFIG_ACPI) && !dev_of_node(&pdev->dev)) {
 			mc_stream_id = readl(mc->fsl_mc_regs + FSL_MC_FAPR);
 			/*
@@ -1143,25 +1155,11 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 			error = acpi_dma_configure_id(&pdev->dev,
 						      DEV_DMA_COHERENT,
 						      &mc_stream_id);
-			if (error == -EPROBE_DEFER)
-				return error;
 			if (error)
 				dev_warn(&pdev->dev,
 					 "failed to configure dma: %d.\n",
 					 error);
 		}
-
-		/*
-		 * Some bootloaders pause the MC firmware before booting the
-		 * kernel so that MC will not cause faults as soon as the
-		 * SMMU probes due to the fact that there's no configuration
-		 * in place for MC.
-		 * At this point MC should have all its SMMU setup done so make
-		 * sure it is resumed.
-		 */
-		writel(readl(mc->fsl_mc_regs + FSL_MC_GCR1) &
-			     (~(GCR1_P1_STOP | GCR1_P2_STOP)),
-		       mc->fsl_mc_regs + FSL_MC_GCR1);
 	}
 
 	/*
-- 
2.33.0

