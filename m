Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743D0366EDF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 17:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243873AbhDUPNS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Apr 2021 11:13:18 -0400
Received: from mx1.emlix.com ([136.243.223.33]:33072 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240356AbhDUPNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 11:13:17 -0400
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 465176078C;
        Wed, 21 Apr 2021 17:12:42 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Intel IOMMU: fix sysfs leak in hotplug init path
Date:   Wed, 21 Apr 2021 17:12:41 +0200
Message-ID: <1716403.SmlLz2RZUD@devpool47>
Organization: emlix GmbH
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 drivers/iommu/intel/dmar.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

I have not actually tested this but I guess it should match the code in 
free_iommu() just below.

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index d5c51b5c20af..fb37a9b79b3a 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1144,7 +1144,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 
 		err = iommu_device_register(&iommu->iommu);
 		if (err)
-			goto err_unmap;
+			goto err_unregister;
 	}
 
 	drhd->iommu = iommu;
@@ -1152,6 +1152,8 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 
 	return 0;
 
+err_unregister:
+	iommu_device_sysfs_remove(&iommu->iommu);
 err_unmap:
 	unmap_iommu(iommu);
 error_free_seq_id:
-- 
2.31.1


-- 
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source



