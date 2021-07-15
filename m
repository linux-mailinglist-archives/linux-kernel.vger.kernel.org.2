Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE5A3C996D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 09:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240244AbhGOHPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 03:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239259AbhGOHO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 03:14:58 -0400
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21311C061760
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 00:12:06 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout4.routing.net (Postfix) with ESMTP id CFAD11008A2;
        Thu, 15 Jul 2021 07:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1626333124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bHCbwCI5MpbahEdZ+ZAHQEIG0Qqobtp7he3SCKGjng4=;
        b=UZUcYAROrcxiZ4qtTYQi8LA4YUQLgFnIF9U7QtMoI6bCOudaAFgjKITsbnZAIgaTV/JdPb
        7AG/U/I8x8rYv7Aiu3iRaFl4yFrXbjRerIQiiv/GyG6VCUAQgaS2+NQUS2epxEChEEbMfg
        M/uPVC4nbhNRnOoWQ3Dy/MyF30X37RA=
Received: from localhost.localdomain (fttx-pool-80.245.79.66.bambit.de [80.245.79.66])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 9C17B3606AA;
        Thu, 15 Jul 2021 07:12:01 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     iommu@lists.linux-foundation.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, yong.wu@mediatek.com
Subject: [PATCH] iommu: check if group is NULL before remove device
Date:   Thu, 15 Jul 2021 09:11:50 +0200
Message-Id: <20210715071150.82157-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: c6a9bf0f-a649-438f-8b8f-4f345d6069d2
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

