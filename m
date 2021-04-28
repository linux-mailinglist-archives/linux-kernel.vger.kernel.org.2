Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79FA36D68D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 13:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbhD1LeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 07:34:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239295AbhD1LeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 07:34:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09A9E61429;
        Wed, 28 Apr 2021 11:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619609613;
        bh=MXD7bLe+1IwlfuG1c++mqw3R4Z2zJgsWia+Av/A6IGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m5ZL3xwke5a6kx2XwKd77P3VmRZi7I/Rqd+JeXPvBU/LgmbGQ+yk18TxkDXKdQTIF
         zy/yl9m7RMEp+1xGq/R6AlFPzf1Gx9wytD6gAF3Figj6XJCppiWY4WXwf1Bd3UEUys
         wMlMKtEJzOe366QgZbdJM+FClLXRjFTu1diuFS8/VhPqUN2ZpC6tnXUF+HM3bWXvZW
         emCH2zKLZbAuEOn0NojDgRatYL3+nj/igNHVgUp0sjLsgqmlxyauQgzpVdyNHo6Cpy
         x5GqEmyYDfvkGt/9jMRgYNbdulq14jDrB7iSfR8dkK9uy1jLtULp8ZGDi5zDsXNCJF
         bfr3YSutSBYfQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 5/5] habanalabs: give FW a grace time for configuring iATU
Date:   Wed, 28 Apr 2021 14:33:23 +0300
Message-Id: <20210428113323.17222-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210428113323.17222-1-ogabbay@kernel.org>
References: <20210428113323.17222-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

iATU (internal Address Translation Unit of the PCI controller)
configuration is being done by FW right after driver enables
the PCI device. Hence, driver must add a minor sleep afterwards
in order to make sure FW finishes configuring iATU regions.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/pci/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/habanalabs/common/pci/pci.c b/drivers/misc/habanalabs/common/pci/pci.c
index 9ef6c46a3146..8e7982be6191 100644
--- a/drivers/misc/habanalabs/common/pci/pci.c
+++ b/drivers/misc/habanalabs/common/pci/pci.c
@@ -430,6 +430,10 @@ int hl_pci_init(struct hl_device *hdev)
 		goto unmap_pci_bars;
 	}
 
+	/* Driver must sleep in order for FW to finish the iATU configuration */
+	if (hdev->asic_prop.iatu_done_by_fw)
+		usleep_range(2000, 3000);
+
 	return 0;
 
 unmap_pci_bars:
-- 
2.25.1

