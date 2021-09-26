Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346424188F9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 15:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhIZNJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 09:09:01 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:53325 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbhIZNJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 09:09:00 -0400
Received: from pop-os.home ([90.126.248.220])
        by mwinf5d33 with ME
        id yd7K2500H4m3Hzu03d7Lw8; Sun, 26 Sep 2021 15:07:22 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 26 Sep 2021 15:07:22 +0200
X-ME-IP: 90.126.248.220
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     thierry.reding@gmail.com, vdumpa@nvidia.com, joro@8bytes.org,
        will@kernel.org, jonathanh@nvidia.com
Cc:     linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] iommu/tegra-smmu: Use devm_bitmap_zalloc when applicable
Date:   Sun, 26 Sep 2021 15:07:18 +0200
Message-Id: <2c0f4da80c3b5ef83299c651f69a563034c1c6cb.1632661557.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'smmu->asids' is a bitmap. So use 'devm_kzalloc()' to simplify code,
improve the semantic of the code and avoid some open-coded arithmetic in
allocator arguments.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iommu/tegra-smmu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 0a281833f611..e900e3c46903 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1079,7 +1079,6 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 				    struct tegra_mc *mc)
 {
 	struct tegra_smmu *smmu;
-	size_t size;
 	u32 value;
 	int err;
 
@@ -1097,9 +1096,7 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 	 */
 	mc->smmu = smmu;
 
-	size = BITS_TO_LONGS(soc->num_asids) * sizeof(long);
-
-	smmu->asids = devm_kzalloc(dev, size, GFP_KERNEL);
+	smmu->asids = devm_bitmap_zalloc(dev, soc->num_asids, GFP_KERNEL);
 	if (!smmu->asids)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.30.2

