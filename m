Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E949337FC4F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 19:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhEMRS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 13:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbhEMRSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 13:18:45 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A927FC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 10:17:35 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id f29so13971856qka.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 10:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5iTTcnEmTfembJ+1uyx3iDFNZSnQPXZr+n41PTIaxsQ=;
        b=UlHdeeMf4GElmCDBCS0qw9f8n4/ieOHNnVWCAo9KILQpv6ywTmp/PjUERSrj7XPrFi
         92+Dm/Ylt8sBQxCvU/O0TT9D6Ti6KRpr0etiX7kdzIEI8vrna9HM+KtCNHuZ1kwS6oRM
         A4UTDKT3MbKlPtUMfEm3AT2gE9FTybXJ8MKDno6td3U736tWQJlosOHZhr05cpfHsi8f
         xQ0cdM58IQ69MVe3uPChu9SC1jiZcx5Cu9ETondWdHcnbz/NJHl1R0T7wAaDhtr7f/Ue
         m6HRAH6NeZyy0eqCDeFv6z349Qv61X/Gy3Sq7mCLi5ahRbQ3hSLtUa5y2HAWB+ClC6zi
         TwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5iTTcnEmTfembJ+1uyx3iDFNZSnQPXZr+n41PTIaxsQ=;
        b=uRfGVrL2FryyQdBzvqwW3LhCLFEcZVZD4z+XvVs6c7Z7ZPv5f8V/XeS+9fY7WIiOfk
         zbAeTBcRAyw3AILc3T/xSk7L1+K7x5X6ECtRv5WfKcFLAsvV9YAyGTXA7d5WeO4JqF/M
         59Aa9mVXx3W7EiNQeG0iFp7LQYsxWNBROm60p+4hd6oM/aqsTZBDQvN4FZrqyp/tIB3n
         JWCKwa1gsP0KZkNvdIX4DSIxH+GjUdbPGe2yRVm5UvPrPA4AD+geZRJl5MIPe1foldp/
         ty6LJSGVwV4ndziZ8pCq0R9Yh2aBKQoStmoEGHZv8gexvXz+pUAVoFKEC9dv9faHPJUk
         /jew==
X-Gm-Message-State: AOAM530/00FJYyp9eO00r3xBA8gpjiHxUNS2adv9E28veq4UIn7SYP0u
        b9wSR4ozfpBLTA7D33WF13a5X+RYZTnrs5Dr
X-Google-Smtp-Source: ABdhPJzsXQM7NAkdeuotogjvfeBaPM2JGYXMiHG2AtKHj/vsM3i2ku05CdDmutpAfyeuXBVEGCBqTg==
X-Received: by 2002:a05:620a:10b4:: with SMTP id h20mr38633540qkk.341.1620926254914;
        Thu, 13 May 2021 10:17:34 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id f132sm2971117qke.104.2021.05.13.10.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 10:17:34 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Eric Anholt <eric@anholt.net>,
        Sharat Masetty <smasetty@codeaurora.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/8] drm/msm/a6xx: use AOP-initialized PDC for a650
Date:   Thu, 13 May 2021 13:13:57 -0400
Message-Id: <20210513171431.18632-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210513171431.18632-1-jonathan@marek.ca>
References: <20210513171431.18632-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM8250 AOP firmware already sets up PDC registers for us, and it only needs
to be enabled. This path will be used for other newer GPUs.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 3d55e153fa9c..c1ee02d6371d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -512,19 +512,26 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
 	struct platform_device *pdev = to_platform_device(gmu->dev);
 	void __iomem *pdcptr = a6xx_gmu_get_mmio(pdev, "gmu_pdc");
-	void __iomem *seqptr = a6xx_gmu_get_mmio(pdev, "gmu_pdc_seq");
+	void __iomem *seqptr;
 	uint32_t pdc_address_offset;
+	bool pdc_in_aop = false;
 
-	if (!pdcptr || !seqptr)
+	if (!pdcptr)
 		goto err;
 
-	if (adreno_is_a618(adreno_gpu) || adreno_is_a640(adreno_gpu))
+	if (adreno_is_a650(adreno_gpu))
+		pdc_in_aop = true;
+	else if (adreno_is_a618(adreno_gpu) || adreno_is_a640(adreno_gpu))
 		pdc_address_offset = 0x30090;
-	else if (adreno_is_a650(adreno_gpu))
-		pdc_address_offset = 0x300a0;
 	else
 		pdc_address_offset = 0x30080;
 
+	if (!pdc_in_aop) {
+		seqptr = a6xx_gmu_get_mmio(pdev, "gmu_pdc_seq");
+		if (!seqptr)
+			goto err;
+	}
+
 	/* Disable SDE clock gating */
 	gmu_write_rscc(gmu, REG_A6XX_GPU_RSCC_RSC_STATUS0_DRV0, BIT(24));
 
@@ -556,6 +563,9 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
 		gmu_write_rscc(gmu, REG_A6XX_RSCC_SEQ_MEM_0_DRV0 + 4, 0x0020e8a8);
 	}
 
+	if (pdc_in_aop)
+		goto setup_pdc;
+
 	/* Load PDC sequencer uCode for power up and power down sequence */
 	pdc_write(seqptr, REG_A6XX_PDC_GPU_SEQ_MEM_0, 0xfebea1e1);
 	pdc_write(seqptr, REG_A6XX_PDC_GPU_SEQ_MEM_0 + 1, 0xa5a4a3a2);
@@ -596,6 +606,7 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
 	pdc_write(pdcptr, REG_A6XX_PDC_GPU_TCS3_CMD0_DATA + 8, 0x3);
 
 	/* Setup GPU PDC */
+setup_pdc:
 	pdc_write(pdcptr, REG_A6XX_PDC_GPU_SEQ_START_ADDR, 0);
 	pdc_write(pdcptr, REG_A6XX_PDC_GPU_ENABLE_PDC, 0x80000001);
 
-- 
2.26.1

