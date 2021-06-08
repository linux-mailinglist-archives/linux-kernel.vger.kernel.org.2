Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C366139FDB7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhFHRc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:32:59 -0400
Received: from mail-qv1-f41.google.com ([209.85.219.41]:43770 "EHLO
        mail-qv1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbhFHRc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:32:57 -0400
Received: by mail-qv1-f41.google.com with SMTP id e18so11210605qvm.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 10:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5iTTcnEmTfembJ+1uyx3iDFNZSnQPXZr+n41PTIaxsQ=;
        b=Y5LC8khEOg/81kB3kO/4DnceDZQD2wJvbbOb9htCqVDvG79i3u9KzeMqg7EkaTlDLS
         jvT7n8SjbCBjHYms8Jnvo2N35gYpe1GtOP643LB6jnymFrRyxJqB8uzjNTlzhXfzaFwJ
         nanZGAJbBotCaO1/bfeDrhOzqj6OvopAVvPnKVKyb8eude8LltVOvJtYKb/5HfkNSzOo
         5XqjZ4+5TAwReTji5MPZbb9Z7srJVZ2eRYmyH0f52XLtFPXiEtdD0IACohYxE3jkbGq/
         TSessnNOyDT3ge8RZtNQYqLQWvW9svehN0LHF4Aeux5Y2eD40HXkWyQLvEm/wxwZLYRV
         Gyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5iTTcnEmTfembJ+1uyx3iDFNZSnQPXZr+n41PTIaxsQ=;
        b=mQCHNxqbiLmJA+RmT1sF69lhD1OjNr+JBT/5FynjOSHD+fMTWOa6VXwvMODSMz9iI0
         FL0t7qV8eZJc2/pTDOrwprEHKzVP753SYM56YtF4xpkGH+EL44TUjr1j+7vRAbSypLbd
         4En+I1SQ+ZR7qSO81b3sAXwMSolaRytO5Fel21RVYifkNo92vy5x3ezTrQwQg+JQvflw
         8G2jLVmMtUNitjKHapiMSX0mLa39GvdV6c36bzDXlyqEF1gwJJBYdCHRDrFe2IEBmaAb
         GxMNAAR7k026dIUM6FKrdKAWYogx1t2VA+QdSksItzC2s1CAeUosYSpFN5SKTbFBd4Y7
         /BDg==
X-Gm-Message-State: AOAM532bnjFthBe/FCWe3WmCV37VNYUofvUBW8j4nnUzX9tCB7rWEXuD
        F20Huszt1lFJQA1ilvJCTTR29Q==
X-Google-Smtp-Source: ABdhPJwlJ63UJzGcxuw+MAyhjOGHtzO+tePHYiAZkwXO7YJMIEUZLK8buNXDGwyy3AtTIDfZM19xnA==
X-Received: by 2002:a0c:e18d:: with SMTP id p13mr1229492qvl.16.1623173403538;
        Tue, 08 Jun 2021 10:30:03 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id d10sm9482983qke.47.2021.06.08.10.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:30:03 -0700 (PDT)
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
Subject: [PATCH v3 2/5] drm/msm/a6xx: use AOP-initialized PDC for a650
Date:   Tue,  8 Jun 2021 13:27:45 -0400
Message-Id: <20210608172808.11803-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210608172808.11803-1-jonathan@marek.ca>
References: <20210608172808.11803-1-jonathan@marek.ca>
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

