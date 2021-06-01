Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372BF397C8F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 00:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbhFAWpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 18:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbhFAWpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 18:45:49 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946E2C061756
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 15:44:06 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id u18so629917pfk.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 15:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ttH2lB2Q3iQhWxz0MO6TSPDv0IHfj1scw5R0SMtBJU=;
        b=pIrVT61fx1rvumOUvE+U675Xr8GitSeSt4o0OfVAYKRWi8DS2mWDlWm1qtwtkfnDC0
         y9DNROp3Va+NBbZ8LgLe/HNctDwcqKGz22rixaxmBUKJb4w9iqO4F9zQm095IzbSgN+p
         NTLCHeDtMzIr9R1a2jmbIeBBnNDrS4ePTlmjU80G9C6BPpIxygTPe9dDVXJCN3ZS4Xa2
         wEym9t1RIe16wZYUD5Q/l8+EYTM2jE28SXQdUQflw79XNJ4S6wGil+4U550FrloPzrXM
         lnZOtm9n74chG/rOQTLSuWSQTLt4jKWcE+fCWJ9iEaTwZAQY/OC3KXN3P8X8zv9FYmXd
         MXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ttH2lB2Q3iQhWxz0MO6TSPDv0IHfj1scw5R0SMtBJU=;
        b=SC71uSwe+iUxdTXDE9PsEgf2ybBFaY4y8gDG6/So9JG7v409YuDK2HsDqiyOzY1HcK
         afQIOUIPC6hGdDF++KvX3lglD3TgzeAlTbQCyTJg1G9DqK7ESdR+T+otPRNQZYNjJTU+
         RLC22KBqKujbHktUZx2Cn3kJy0jKkp5VJHQDUjfi9IC7kJvTDbTdrCeb/oT0Nvzg4a61
         uTL6fqZ1RDTyDEha4tNxwAiDNyzs5tDvQddjPk0DPqsJKi7K4hbDar5oWWV2SNZ+9CE3
         H67f+UOR24i34gXUeFDLUV4fBD9Ec/6nH66KKIKjjHlFeCN1Gy/TOltJkDbD+4Ck/jNU
         TxUw==
X-Gm-Message-State: AOAM5331pRXIAnLOYE+F3Cls4RxYeb6QjR1A58L6EHdranOfI43lTkGG
        7iM15y8Il15Dxhjk0MqWA3s=
X-Google-Smtp-Source: ABdhPJwX4N/xGbofNgI/85HZIgF1a/A3xIrRRALq8vARkCD/QkQjwwSih/i8ZuLcYPS3lv2K+46TZw==
X-Received: by 2002:a63:540d:: with SMTP id i13mr904290pgb.360.1622587446121;
        Tue, 01 Jun 2021 15:44:06 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id n12sm14674511pjk.48.2021.06.01.15.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 15:44:05 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Jordan Crouse <jordan@cosmicpenguin.net>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
        iommu@lists.linux-foundation.org (open list:IOMMU DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 1/6] iommu/arm-smmu: Add support for driver IOMMU fault handlers
Date:   Tue,  1 Jun 2021 15:47:20 -0700
Message-Id: <20210601224750.513996-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210601224750.513996-1-robdclark@gmail.com>
References: <20210601224750.513996-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jordan Crouse <jcrouse@codeaurora.org>

Call report_iommu_fault() to allow upper-level drivers to register their
own fault handlers.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 6f72c4d208ca..b4b32d31fc06 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -408,6 +408,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	int idx = smmu_domain->cfg.cbndx;
+	int ret;
 
 	fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
 	if (!(fsr & ARM_SMMU_FSR_FAULT))
@@ -417,8 +418,12 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	iova = arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_FAR);
 	cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(idx));
 
-	dev_err_ratelimited(smmu->dev,
-	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
+	ret = report_iommu_fault(domain, NULL, iova,
+		fsynr & ARM_SMMU_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
+
+	if (ret == -ENOSYS)
+		dev_err_ratelimited(smmu->dev,
+		"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
 			    fsr, iova, fsynr, cbfrsynra, idx);
 
 	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
-- 
2.31.1

