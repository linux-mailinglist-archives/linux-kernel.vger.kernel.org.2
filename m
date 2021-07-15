Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040F03C996C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 09:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240234AbhGOHO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 03:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239105AbhGOHO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 03:14:58 -0400
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993A1C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 00:12:05 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout1.routing.net (Postfix) with ESMTP id E318940735;
        Thu, 15 Jul 2021 07:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1626333123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bHCbwCI5MpbahEdZ+ZAHQEIG0Qqobtp7he3SCKGjng4=;
        b=Pb96nc4oos96q/wIf13w4dIhW+2Laxqwiz+nFcTpqusgGZU30ArRSv5AOjc6VCpL/l8xWy
        d/buLhtWrzb7aZ76Z7Sb1OrvX0nWCn/aNDEKMcBCnedXwKl5D4ZSOh2hOGss2Nm+X4l7Vr
        iLzDzVb9z1ADeHC/BhOgRBBDrWmkFzw=
Received: from localhost.localdomain (fttx-pool-80.245.79.66.bambit.de [80.245.79.66])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 0DAE5100A1A;
        Thu, 15 Jul 2021 07:11:21 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     iommu@lists.linux-foundation.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, yong.wu@mediatek.com
Subject: [PATCH] iommu: check if group is NULL before remove device
Date:   Thu, 15 Jul 2021 09:10:43 +0200
Message-Id: <20210715071043.82055-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 820bd0e5-1d97-456a-a2a2-24dfac31751b
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

if probe is failing, iommu_group may be not initialized,
so freeing it will result in NULL pointer access

Fixes: d72e31c93746 ("iommu: IOMMU Groups")
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/iommu/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5419c4b9f27a..63f0af10c403 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -924,6 +924,9 @@ void iommu_group_remove_device(struct device *dev)
 	struct iommu_group *group = dev->iommu_group;
 	struct group_device *tmp_device, *device = NULL;
 
+	if (!group)
+		return;
+
 	dev_info(dev, "Removing from iommu group %d\n", group->id);
 
 	/* Pre-notify listeners that a device is being removed. */
-- 
2.25.1

