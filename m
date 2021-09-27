Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CB8419404
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbhI0MUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:20:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234223AbhI0MUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:20:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C105F6103B;
        Mon, 27 Sep 2021 12:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632745142;
        bh=F9/Tr9COtm4Stj4bhDIokvzMkSf99FLpUsv9Um0t5FI=;
        h=From:To:Cc:Subject:Date:From;
        b=iQ1cVnEtOm5m5/2kAdPUnsn+F/m6UMiVUTNVuuJVHQzqfCTB37Wh92MSJMucsKtLS
         hE6EEfH26Y7f55flpw2XxZbTXZOaSqx5aWlljUGX/puBub5sCl6FwV6KHrALTMS0fj
         fXJcasgF8W/8SdTAezOjWsJAoAYktTuihAPRjRFtFdXLoXXkfgGk3Sgu1u/jaHthW5
         2L+vEP9AaPWCp8njdVAzDZLerxAtaI/Cv5lOJ4OTkc1gIyZiiuNgwrdLQCd4QP6O89
         3HeumoPYO5S/iEZyMKOr9XjdjDictDEY86eIyVDUKsZ2B+AZKZPoYfjJRhaeLjgBbJ
         5JrGQXrIaY2Fg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] iommu/mediatek: fix out-of-range warning with clang
Date:   Mon, 27 Sep 2021 14:18:44 +0200
Message-Id: <20210927121857.941160-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

clang-14 notices that a comparison is never true when
CONFIG_PHYS_ADDR_T_64BIT is disabled:

drivers/iommu/mtk_iommu.c:553:34: error: result of comparison of constant 5368709120 with expression of type 'phys_addr_t' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
        if (dom->data->enable_4GB && pa >= MTK_IOMMU_4GB_MODE_REMAP_BASE)
                                     ~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Add an explicit check for the type of the variable to skip the check
and the warning in that case.

Fixes: b4dad40e4f35 ("iommu/mediatek: Adjust the PA for the 4GB Mode")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/mtk_iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index d837adfd1da5..25b834104790 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -550,7 +550,9 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 	phys_addr_t pa;
 
 	pa = dom->iop->iova_to_phys(dom->iop, iova);
-	if (dom->data->enable_4GB && pa >= MTK_IOMMU_4GB_MODE_REMAP_BASE)
+	if (IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT) &&
+	    dom->data->enable_4GB &&
+	    pa >= MTK_IOMMU_4GB_MODE_REMAP_BASE)
 		pa &= ~BIT_ULL(32);
 
 	return pa;
-- 
2.29.2

