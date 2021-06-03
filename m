Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CC2399CCA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 10:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhFCInH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Jun 2021 04:43:07 -0400
Received: from mx1.emlix.com ([136.243.223.33]:34538 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhFCInG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 04:43:06 -0400
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 2BC24602D5;
        Thu,  3 Jun 2021 10:41:21 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/vt-d: move variable to more local scope
Date:   Thu, 03 Jun 2021 10:41:19 +0200
Message-ID: <1943275.8rWz7lOq5N@mobilepool36.emlix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is only used inside the loop and the old value is not reused.

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index be35284a2016..fa262b805dd6 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2340,7 +2340,6 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 		 unsigned long phys_pfn, unsigned long nr_pages, int prot)
 {
 	unsigned int largepage_lvl = 0;
-	unsigned long lvl_pages = 0;
 	struct dma_pte *pte = NULL;
 	phys_addr_t pteval;
 	u64 attr;
@@ -2366,6 +2365,7 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 
 	while (nr_pages > 0) {
 		uint64_t tmp;
+		unsigned long lvl_pages;
 
 		if (!pte) {
 			largepage_lvl = hardware_largepage_caps(domain, iov_pfn,
-- 
2.31.1


-- 
Rolf Eike Beer, emlix GmbH, https://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source


