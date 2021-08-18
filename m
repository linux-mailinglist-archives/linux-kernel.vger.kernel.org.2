Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB913F04F8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbhHRNkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236732AbhHRNkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:40:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71E7260238
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 13:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629293968;
        bh=/5DXAY9wt3ZgMuRws104YSIN/QFOJ4Z8rCEudD+ATnY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TkTauF0lpaELaKRZS7EcW4j9QYSug4HJvwyGgDi4wDiefEhQmKeif1lKpwJr5nqDH
         Y2pHwsRq78njyXyF+jicEXeYrQBsQcCUMekvwQ5eRsYJ8o/51BomNFm8WpdBF/AL4r
         o8Km0rozWgTNyEM+Uwj8bXJ7tduhTZkhNuk568OZ7BjjkH5LX5g4Dyhh3efa6rYpxJ
         d4atRCRbfRXrUFyX/c4I3oK0VyrOCznqwZXc4njTUd/oNMHY0Y9G3txgW0DsZ+xntg
         cWRuvoM/wMTHSEd3Gl6v8LJhpDpVt1t9oova8kcEnmtBJtwn6injfVEJ740M0z+Rm3
         70LUxqoCjxoJA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 02/16] habanalabs/gaudi: move scrubbing to late init
Date:   Wed, 18 Aug 2021 16:39:08 +0300
Message-Id: <20210818133922.63637-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210818133922.63637-1-ogabbay@kernel.org>
References: <20210818133922.63637-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HW init is mostly about configuring registers. Therefore, it is better
to activate DMAs only in late init and afterwards.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 6852bb8e55db..d8d296b66f9d 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1567,6 +1567,11 @@ static int gaudi_late_init(struct hl_device *hdev)
 		return rc;
 	}
 
+	/* Scrub both SRAM and DRAM */
+	rc = hdev->asic_funcs->scrub_device_mem(hdev, 0, 0);
+	if (rc)
+		goto disable_pci_access;
+
 	rc = gaudi_fetch_psoc_frequency(hdev);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to fetch psoc frequency\n");
@@ -4194,11 +4199,6 @@ static int gaudi_hw_init(struct hl_device *hdev)
 		goto disable_msi;
 	}
 
-	/* Scrub both SRAM and DRAM */
-	rc = hdev->asic_funcs->scrub_device_mem(hdev, 0, 0);
-	if (rc)
-		return rc;
-
 	/* Perform read from the device to flush all configuration */
 	RREG32(mmHW_STATE);
 
-- 
2.17.1

