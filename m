Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2586245A6F0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 16:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbhKWP7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 10:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbhKWP7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 10:59:49 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5050C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 07:56:40 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l16so1822279wrp.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 07:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ugWhUFc1gcRf18XNXQ74oVCZakMGTKA95AYpxgViHMc=;
        b=x+M+8EL5my60gL5G09sniiQ8J8uguHVYoYCOvljil6+LePL9FCGa7Igef6Qocog/H8
         rEVgDMf7bkAXYeoisiNRVZ1mvqX9tzd9c0h6xiLIgJq+GUzO3b1kXNsKeob9laPaswPv
         JpDOKgfBpCfNTehsQW1tS6urZx+IUPylvHdZMH+ABYcDceir8KyogKBmTvGmL57BRUn1
         zCWjRE/co3OFF29xQQX0Lf/4j33+t0oaSJo9HXEtu7lF1WvNMHMrBLVDib6ZfIB9/TYk
         wyt/P7EfWmf3doK4cSCMjyLJ/23K5P4U67FBDa7s2CwNCmGYFgqANTdPjccUbc2zGm2F
         wEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ugWhUFc1gcRf18XNXQ74oVCZakMGTKA95AYpxgViHMc=;
        b=AUklpWU9R962H1UD75QN8DgS6SDlGWzsVeJ29z9J3deBx5UyR8aQuEviJfa9XweYn3
         w5cElnV6oTb8zwLktIgjcp58EI74aq7ln7LRb1gntQ4joxbwruJsbzc5lLAOp3H3nC8W
         6H5C0uNm1txI15g+WCqCA9cYtmS2++C5hVtvR+krRdOaLwOU2F5n/iI9Du+HM4MMRv8j
         6QcqytEmY+gKTSzii7z7LqMMbefnfH1dj7Uu4mTVaExfmaFXawyGhDEF9QbhMVgZm2Rn
         +Jz/KKodPjCJoP2dcKWm3DktuX1B6aRUOfurIXa2qw9ggjZ5eTmEhIPw5efeZNkxcE62
         0F/A==
X-Gm-Message-State: AOAM532zEJ05fOUT9g5vsMmIXZ+noX1mUudiVqr716laA9mr9IY4Ztyj
        bOAKxC5zZ5RhMLPhWsrHXgpkYQ==
X-Google-Smtp-Source: ABdhPJz9diLXnunaItvUS4rIsQW2xdw0sxXrVOX+/drk2+7p/TRCGNxIosdJPSGo1HNkd+rDd/zYJg==
X-Received: by 2002:a5d:604b:: with SMTP id j11mr8849450wrt.22.1637682999201;
        Tue, 23 Nov 2021 07:56:39 -0800 (PST)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id r15sm1532572wmh.13.2021.11.23.07.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 07:56:38 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     joro@8bytes.org, will@kernel.org, mst@redhat.com,
        jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        eric.auger@redhat.com, sebastien.boeuf@intel.com,
        kevin.tian@intel.com, pasic@linux.ibm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 2/5] iommu/virtio: Support bypass domains
Date:   Tue, 23 Nov 2021 15:52:59 +0000
Message-Id: <20211123155301.1047943-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211123155301.1047943-1-jean-philippe@linaro.org>
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VIRTIO_IOMMU_F_BYPASS_CONFIG feature adds a new flag to the ATTACH
request, that creates a bypass domain. Use it to enable identity
domains.

When VIRTIO_IOMMU_F_BYPASS_CONFIG is not supported by the device, we
currently fail attaching to an identity domain. Future patches will
instead create identity mappings in this case.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 80930ce04a16..ee8a7afd667b 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -71,6 +71,7 @@ struct viommu_domain {
 	struct rb_root_cached		mappings;
 
 	unsigned long			nr_endpoints;
+	bool				bypass;
 };
 
 struct viommu_endpoint {
@@ -587,7 +588,9 @@ static struct iommu_domain *viommu_domain_alloc(unsigned type)
 {
 	struct viommu_domain *vdomain;
 
-	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
+	if (type != IOMMU_DOMAIN_UNMANAGED &&
+	    type != IOMMU_DOMAIN_DMA &&
+	    type != IOMMU_DOMAIN_IDENTITY)
 		return NULL;
 
 	vdomain = kzalloc(sizeof(*vdomain), GFP_KERNEL);
@@ -630,6 +633,17 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
 	vdomain->map_flags	= viommu->map_flags;
 	vdomain->viommu		= viommu;
 
+	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
+		if (!virtio_has_feature(viommu->vdev,
+					VIRTIO_IOMMU_F_BYPASS_CONFIG)) {
+			ida_free(&viommu->domain_ids, vdomain->id);
+			vdomain->viommu = 0;
+			return -EOPNOTSUPP;
+		}
+
+		vdomain->bypass = true;
+	}
+
 	return 0;
 }
 
@@ -691,6 +705,9 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		.domain		= cpu_to_le32(vdomain->id),
 	};
 
+	if (vdomain->bypass)
+		req.flags |= cpu_to_le32(VIRTIO_IOMMU_ATTACH_F_BYPASS);
+
 	for (i = 0; i < fwspec->num_ids; i++) {
 		req.endpoint = cpu_to_le32(fwspec->ids[i]);
 
@@ -1132,6 +1149,7 @@ static unsigned int features[] = {
 	VIRTIO_IOMMU_F_DOMAIN_RANGE,
 	VIRTIO_IOMMU_F_PROBE,
 	VIRTIO_IOMMU_F_MMIO,
+	VIRTIO_IOMMU_F_BYPASS_CONFIG,
 };
 
 static struct virtio_device_id id_table[] = {
-- 
2.33.1

