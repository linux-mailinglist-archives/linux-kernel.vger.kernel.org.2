Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B04C45A6F9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 16:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238618AbhKWP75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 10:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238607AbhKWP7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 10:59:52 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3811C061714
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 07:56:43 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id az34-20020a05600c602200b0033bf8662572so2347929wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 07:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZRrdrvfwnfCOxGojLh1hGBZHdzw/L/mum0ej4VSc97g=;
        b=oyFy1LKvGJMU30/ivLT59O6Xv6m8YFTa3CmSp2WeA7ArdHN2pzN+8sYsZh0nJB1rpm
         TF2I8Klekcd8bV9ApA6N1uTUyS+MUUPbynsMx4R5A7Wuyv1B5BKPm2uTRN6YeON/kPub
         yyRWOLDWRI1135M63lVXQy4MGA4jh4oAUFMS7zaipKmEzLy373q6vZwbIlKtl78brDNa
         JAkYtMYeNwzNcnU98E9rav1aRV38fLddadpd7wkFzWzWq1zA+rbE+5ZBuBmu9GPBuQBX
         CIiYeKo+REQAxyrq77xvWAEZhujL1tBYi9MpEFBN3q4lRcvhtD2i9khCA7kRcnUalSyj
         U80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZRrdrvfwnfCOxGojLh1hGBZHdzw/L/mum0ej4VSc97g=;
        b=MVOYdcNthcdJ52vAkf5R3S0AssQIYbYDGij4+5hfI1Rmwwuk0i6uLo1erLMOa0oP0A
         KD5PacIaNsnNUu1OVvQM6eqY28FEZ+HkVJgft1uAE1cD9ef/1Ex7Ckh26HTcm2q+OiBv
         aKtMIi9PQsb8GLKaFIUgMF8ZUW4Pxil0P9eaEL/5YgC60tCHgYbcyXhs8OjyjjBwRThQ
         SVSshv9yMs4q7xBEb5HZpy5+7QuqLL66eR+R9aZMU8ChCuZ4Su8IQqmOCnSCHHiEeYof
         EnYObca+VEvZYGDJB0eHKFJ0mEb99I9VquTM4DV2WM7xF58npqi97r/kw7rc0t6th1zY
         iTCA==
X-Gm-Message-State: AOAM532HTTzip8vhWnk30PXPMEGxLRZOCaPtck/cXRcTBda0uiXfPzqs
        He48tDOfrPuc9BkqqfzS8rHIBA==
X-Google-Smtp-Source: ABdhPJyRqECTbpPYHH5uCjl08AXcBFe2Levxz9M2D0pbrVXsv3m/dDvD18pCR8flubLYh4b2z40a9g==
X-Received: by 2002:a05:600c:2292:: with SMTP id 18mr4489566wmf.6.1637683002293;
        Tue, 23 Nov 2021 07:56:42 -0800 (PST)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id r15sm1532572wmh.13.2021.11.23.07.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 07:56:41 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     joro@8bytes.org, will@kernel.org, mst@redhat.com,
        jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        eric.auger@redhat.com, sebastien.boeuf@intel.com,
        kevin.tian@intel.com, pasic@linux.ibm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 5/5] iommu/virtio: Support identity-mapped domains
Date:   Tue, 23 Nov 2021 15:53:02 +0000
Message-Id: <20211123155301.1047943-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211123155301.1047943-1-jean-philippe@linaro.org>
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support identity domains for devices that do not offer the
VIRTIO_IOMMU_F_BYPASS_CONFIG feature, by creating 1:1 mappings between
the virtual and physical address space. Identity domains created this
way still perform noticeably better than DMA domains, because they don't
have the overhead of setting up and tearing down mappings at runtime.
The performance difference between this and bypass is minimal in
comparison.

It does not matter that the physical addresses in the identity mappings
do not all correspond to memory. By enabling passthrough we are trusting
the device driver and the device itself to only perform DMA to suitable
locations. In some cases it may even be desirable to perform DMA to MMIO
regions.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 63 +++++++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index eceb9281c8c1..6a8a52b4297b 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -375,6 +375,55 @@ static size_t viommu_del_mappings(struct viommu_domain *vdomain,
 	return unmapped;
 }
 
+/*
+ * Fill the domain with identity mappings, skipping the device's reserved
+ * regions.
+ */
+static int viommu_domain_map_identity(struct viommu_endpoint *vdev,
+				      struct viommu_domain *vdomain)
+{
+	int ret;
+	struct iommu_resv_region *resv;
+	u64 iova = vdomain->domain.geometry.aperture_start;
+	u64 limit = vdomain->domain.geometry.aperture_end;
+	u32 flags = VIRTIO_IOMMU_MAP_F_READ | VIRTIO_IOMMU_MAP_F_WRITE;
+	unsigned long granule = 1UL << __ffs(vdomain->domain.pgsize_bitmap);
+
+	iova = ALIGN(iova, granule);
+	limit = ALIGN_DOWN(limit + 1, granule) - 1;
+
+	list_for_each_entry(resv, &vdev->resv_regions, list) {
+		u64 resv_start = ALIGN_DOWN(resv->start, granule);
+		u64 resv_end = ALIGN(resv->start + resv->length, granule) - 1;
+
+		if (resv_end < iova || resv_start > limit)
+			/* No overlap */
+			continue;
+
+		if (resv_start > iova) {
+			ret = viommu_add_mapping(vdomain, iova, resv_start - 1,
+						 (phys_addr_t)iova, flags);
+			if (ret)
+				goto err_unmap;
+		}
+
+		if (resv_end >= limit)
+			return 0;
+
+		iova = resv_end + 1;
+	}
+
+	ret = viommu_add_mapping(vdomain, iova, limit, (phys_addr_t)iova,
+				 flags);
+	if (ret)
+		goto err_unmap;
+	return 0;
+
+err_unmap:
+	viommu_del_mappings(vdomain, 0, iova);
+	return ret;
+}
+
 /*
  * viommu_replay_mappings - re-send MAP requests
  *
@@ -637,14 +686,18 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
 	vdomain->viommu		= viommu;
 
 	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
-		if (!virtio_has_feature(viommu->vdev,
-					VIRTIO_IOMMU_F_BYPASS_CONFIG)) {
+		if (virtio_has_feature(viommu->vdev,
+				       VIRTIO_IOMMU_F_BYPASS_CONFIG)) {
+			vdomain->bypass = true;
+			return 0;
+		}
+
+		ret = viommu_domain_map_identity(vdev, vdomain);
+		if (ret) {
 			ida_free(&viommu->domain_ids, vdomain->id);
-			vdomain->viommu = 0;
+			vdomain->viommu = NULL;
 			return -EOPNOTSUPP;
 		}
-
-		vdomain->bypass = true;
 	}
 
 	return 0;
-- 
2.33.1

