Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51E143850F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 21:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhJWTwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 15:52:07 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:60516 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhJWTwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 15:52:06 -0400
Received: from pop-os.home ([92.140.161.106])
        by smtp.orange.fr with ESMTPA
        id eN1TmCsSATdRTeN1TmKNqu; Sat, 23 Oct 2021 21:49:45 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 23 Oct 2021 21:49:45 +0200
X-ME-IP: 92.140.161.106
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] iommu/vt-d: Use bitmap_zalloc() when applicable
Date:   Sat, 23 Oct 2021 21:49:42 +0200
Message-Id: <cb7a3e0a8d522447a06298a4f244c3df072f948b.1635018498.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'iommu->domain_ids' is a bitmap. So use 'bitmap_zalloc()' to simplify code
and improve the semantic.

Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
consistency.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iommu/intel/iommu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 0bde0c8b4126..2ae75b7f7dec 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1880,17 +1880,16 @@ static void iommu_disable_translation(struct intel_iommu *iommu)
 
 static int iommu_init_domains(struct intel_iommu *iommu)
 {
-	u32 ndomains, nlongs;
+	u32 ndomains;
 	size_t size;
 
 	ndomains = cap_ndoms(iommu->cap);
 	pr_debug("%s: Number of Domains supported <%d>\n",
 		 iommu->name, ndomains);
-	nlongs = BITS_TO_LONGS(ndomains);
 
 	spin_lock_init(&iommu->lock);
 
-	iommu->domain_ids = kcalloc(nlongs, sizeof(unsigned long), GFP_KERNEL);
+	iommu->domain_ids = bitmap_zalloc(ndomains, GFP_KERNEL);
 	if (!iommu->domain_ids)
 		return -ENOMEM;
 
@@ -1905,7 +1904,7 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 	if (!iommu->domains || !iommu->domains[0]) {
 		pr_err("%s: Allocating domain array failed\n",
 		       iommu->name);
-		kfree(iommu->domain_ids);
+		bitmap_free(iommu->domain_ids);
 		kfree(iommu->domains);
 		iommu->domain_ids = NULL;
 		iommu->domains    = NULL;
@@ -1966,7 +1965,7 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 		for (i = 0; i < elems; i++)
 			kfree(iommu->domains[i]);
 		kfree(iommu->domains);
-		kfree(iommu->domain_ids);
+		bitmap_free(iommu->domain_ids);
 		iommu->domains = NULL;
 		iommu->domain_ids = NULL;
 	}
-- 
2.30.2

