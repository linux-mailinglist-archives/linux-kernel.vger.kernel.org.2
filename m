Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBCC45A6F7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 16:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbhKWP7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 10:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237381AbhKWP7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 10:59:51 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C224DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 07:56:42 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so2394271wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 07:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YTNjqGpE3VcD9ViHGW/d2oZFLfgGV6uZyRdtocoRURc=;
        b=RA9304xNns63IlLjRuNm+T8Rp3eWxRbdJ/hHmQG3UhgcRlcOk2VlXLlDBnqlRv9MpM
         PdxsnIuO8ClAT20SfREl5kipXcbOqbloB6e1kt7e214jRC3KCdxvee5DEySscSMBNeOa
         41GERuNUateIwHRENsHic7PPCW5Dq2n0Ym9H64VH9rLiJknE+KRn6+8ZpVi+hL+aES1s
         J17vSVImd6uxf/QnAmae//Z8obQ43MWeUTwXhX5Ld1mPF//iOGx2m+DIdS723TAfG/D8
         WNZDRpcVLUEUkbU/yX4tqQki0ld32E4CGaSjsq0ZfSu7HlOOGx9kFmuucgYMIBzJtXcQ
         5C1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YTNjqGpE3VcD9ViHGW/d2oZFLfgGV6uZyRdtocoRURc=;
        b=z+7nMLQmxryDFNPVvH5CR16ewrtNZRr1qrmIPdExsI1q/q9P4ZTByrYh8MIA0wK09T
         8y9wVZGpW+2LGSQeWh8UJyEz1OUe/89CKKulFDgx0yJ58D1oc0jDtfRpo3dfL0eBIpNN
         A5f2FAHcMaeSz2/ObhwWR5HG3jQBIAZwdrhi9iawgwrJHOaDJQpXkKR9J2WPOhoTnDu4
         OvLS7AirEy0kJdv//FECQl2RVlOBYxIERXYN9D5xDQdR4Hsn18/pEPdds/l9yH++w1qD
         G+JdnaL7TfytrGZxsjlVd5i4OdRKLv31VhNAJFXr9gUSQLZrGMn9wet4LbXlyMYgKuIh
         /fRA==
X-Gm-Message-State: AOAM531zwMdloWQFg6bcsmXhIpLX2q9mJ0bcP1Nx79dX/UFdNY07GcV4
        2Yd5nIpq3rT4iDTuf6We5J8eig==
X-Google-Smtp-Source: ABdhPJyXbikfTn7PtUh68WnDjY38u0Aw8ibNTeoa5UYjoRdL57FuzLwnZVG0aXh8MXyP/eLTk64Brg==
X-Received: by 2002:a7b:c119:: with SMTP id w25mr4378312wmi.70.1637683001305;
        Tue, 23 Nov 2021 07:56:41 -0800 (PST)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id r15sm1532572wmh.13.2021.11.23.07.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 07:56:40 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     joro@8bytes.org, will@kernel.org, mst@redhat.com,
        jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        eric.auger@redhat.com, sebastien.boeuf@intel.com,
        kevin.tian@intel.com, pasic@linux.ibm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 4/5] iommu/virtio: Pass end address to viommu_add_mapping()
Date:   Tue, 23 Nov 2021 15:53:01 +0000
Message-Id: <20211123155301.1047943-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211123155301.1047943-1-jean-philippe@linaro.org>
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support identity mappings, the virtio-iommu driver must be able to
represent full 64-bit ranges internally. Pass (start, end) instead of
(start, size) to viommu_add/del_mapping().

Clean comments. The one about the returned size was never true: when
sweeping the whole address space the returned size will most certainly
be smaller than 2^64.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index d63ec4d11b00..eceb9281c8c1 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -311,8 +311,8 @@ static int viommu_send_req_sync(struct viommu_dev *viommu, void *buf,
  *
  * On success, return the new mapping. Otherwise return NULL.
  */
-static int viommu_add_mapping(struct viommu_domain *vdomain, unsigned long iova,
-			      phys_addr_t paddr, size_t size, u32 flags)
+static int viommu_add_mapping(struct viommu_domain *vdomain, u64 iova, u64 end,
+			      phys_addr_t paddr, u32 flags)
 {
 	unsigned long irqflags;
 	struct viommu_mapping *mapping;
@@ -323,7 +323,7 @@ static int viommu_add_mapping(struct viommu_domain *vdomain, unsigned long iova,
 
 	mapping->paddr		= paddr;
 	mapping->iova.start	= iova;
-	mapping->iova.last	= iova + size - 1;
+	mapping->iova.last	= end;
 	mapping->flags		= flags;
 
 	spin_lock_irqsave(&vdomain->mappings_lock, irqflags);
@@ -338,26 +338,24 @@ static int viommu_add_mapping(struct viommu_domain *vdomain, unsigned long iova,
  *
  * @vdomain: the domain
  * @iova: start of the range
- * @size: size of the range. A size of 0 corresponds to the entire address
- *	space.
+ * @end: end of the range
  *
- * On success, returns the number of unmapped bytes (>= size)
+ * On success, returns the number of unmapped bytes
  */
 static size_t viommu_del_mappings(struct viommu_domain *vdomain,
-				  unsigned long iova, size_t size)
+				  u64 iova, u64 end)
 {
 	size_t unmapped = 0;
 	unsigned long flags;
-	unsigned long last = iova + size - 1;
 	struct viommu_mapping *mapping = NULL;
 	struct interval_tree_node *node, *next;
 
 	spin_lock_irqsave(&vdomain->mappings_lock, flags);
-	next = interval_tree_iter_first(&vdomain->mappings, iova, last);
+	next = interval_tree_iter_first(&vdomain->mappings, iova, end);
 	while (next) {
 		node = next;
 		mapping = container_of(node, struct viommu_mapping, iova);
-		next = interval_tree_iter_next(node, iova, last);
+		next = interval_tree_iter_next(node, iova, end);
 
 		/* Trying to split a mapping? */
 		if (mapping->iova.start < iova)
@@ -656,8 +654,8 @@ static void viommu_domain_free(struct iommu_domain *domain)
 {
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
-	/* Free all remaining mappings (size 2^64) */
-	viommu_del_mappings(vdomain, 0, 0);
+	/* Free all remaining mappings */
+	viommu_del_mappings(vdomain, 0, ULLONG_MAX);
 
 	if (vdomain->viommu)
 		ida_free(&vdomain->viommu->domain_ids, vdomain->id);
@@ -742,6 +740,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
 {
 	int ret;
 	u32 flags;
+	u64 end = iova + size - 1;
 	struct virtio_iommu_req_map map;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
@@ -752,7 +751,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
 	if (flags & ~vdomain->map_flags)
 		return -EINVAL;
 
-	ret = viommu_add_mapping(vdomain, iova, paddr, size, flags);
+	ret = viommu_add_mapping(vdomain, iova, end, paddr, flags);
 	if (ret)
 		return ret;
 
@@ -761,7 +760,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
 		.domain		= cpu_to_le32(vdomain->id),
 		.virt_start	= cpu_to_le64(iova),
 		.phys_start	= cpu_to_le64(paddr),
-		.virt_end	= cpu_to_le64(iova + size - 1),
+		.virt_end	= cpu_to_le64(end),
 		.flags		= cpu_to_le32(flags),
 	};
 
@@ -770,7 +769,7 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
 
 	ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
 	if (ret)
-		viommu_del_mappings(vdomain, iova, size);
+		viommu_del_mappings(vdomain, iova, end);
 
 	return ret;
 }
@@ -783,7 +782,7 @@ static size_t viommu_unmap(struct iommu_domain *domain, unsigned long iova,
 	struct virtio_iommu_req_unmap unmap;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
-	unmapped = viommu_del_mappings(vdomain, iova, size);
+	unmapped = viommu_del_mappings(vdomain, iova, iova + size - 1);
 	if (unmapped < size)
 		return 0;
 
-- 
2.33.1

