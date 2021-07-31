Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1717A3DC494
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 09:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhGaHry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 03:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhGaHrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 03:47:51 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A95FC06175F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 00:47:46 -0700 (PDT)
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
        by mxout2.routing.net (Postfix) with ESMTP id 742395FC28;
        Sat, 31 Jul 2021 07:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1627717663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=203p5LOrdBHh+Yer5N7D3VTBaUXubh54vrXwH3UF8Lk=;
        b=sTVl6SjEaPCkXfzHdCJW6bkXpfSshz1B+2feQ8pz2TcMhOHMuuTuMXo1LwG6wa37Ag8MiT
        XCep1oJyXfXwIz3y9dL36QqsPVvld76XWHlp4JrjUWvZWGOHCaFfJTyi0BRFoJMkwwuGGC
        6Q1r5uWoWW0DatZh0p3SESLRXf5B7hE=
Received: from localhost.localdomain (fttx-pool-80.245.79.120.bambit.de [80.245.79.120])
        by mxbox4.masterlogin.de (Postfix) with ESMTPSA id CD16280843;
        Sat, 31 Jul 2021 07:47:42 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     iommu@lists.linux-foundation.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, yong.wu@mediatek.com
Subject: [PATCH v2] iommu: Check if group is NULL before remove device
Date:   Sat, 31 Jul 2021 09:47:37 +0200
Message-Id: <20210731074737.4573-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: c0f3efb9-ff49-441d-a9bc-ca8ab5fd7dbc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

If probe_device is failing, iommu_group is not initialized because
iommu_group_add_device is not reached, so freeing it will result
in NULL pointer access.

iommu_bus_init
  ->bus_iommu_probe
      ->probe_iommu_group in for each:/* return -22 in fail case */
          ->iommu_probe_device
              ->__iommu_probe_device       /* return -22 here.*/
                  -> ops->probe_device          /* return -22 here.*/
                  -> iommu_group_get_for_dev
                        -> ops->device_group
                        -> iommu_group_add_device //good case
  ->remove_iommu_group  //in fail case, it will remove group
     ->iommu_release_device
         ->iommu_group_remove_device // here we don't have group

In my case ops->probe_device (mtk_iommu_probe_device from
mtk_iommu_v1.c) is due to failing fwspec->ops mismatch.

Fixes: d72e31c93746 ("iommu: IOMMU Groups")
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v2:
- commit-message with captial letters on beginning of sentenence
- added more information, many thanks to Yong Wu
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

