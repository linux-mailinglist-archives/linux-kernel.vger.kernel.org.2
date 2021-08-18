Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9DE3F04F7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237703AbhHRNkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236931AbhHRNkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:40:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A3C561058;
        Wed, 18 Aug 2021 13:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629293967;
        bh=e1xtzvlIpvJS0EANVOQvuD0fUFQvp+tZ8+ZV/nuubwM=;
        h=From:To:Cc:Subject:Date:From;
        b=hYuuxjNtHHWLVhDgrgp8Qkpi/bBt+dvMu3Gr22OwR6IomDlPmJSKk1SQcCWbKhr3S
         H844lDeUd+4nx1zXUE5JJXbnSmd2AdhrBlnRwIBwY8FaELPR3GfknvTIWCPzjJDbr7
         1gIur3NmtKCqC1NIpp/sNojem2/83Wy02bq8vQOVnf3dAvNF2wz7L9licaUZ7CNv1L
         NcpsECLUrOxpQrJTTFynACvT1SoLwOTDNig5KMVT2zAWLwipRRVRoeLDlE0bsAUIUr
         3IgkwKcDovEERQHpz+Jp4sCcSZnvCfRHv4fAcZeUrK0bAoZi0TBhVo0eJr1m0orPUe
         HClBTmuOBvIvA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 01/16] habanalabs/gaudi: scrub HBM to a specific value
Date:   Wed, 18 Aug 2021 16:39:07 +0300
Message-Id: <20210818133922.63637-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In order to enhance debuggability, we will scrub the whole HBM to
a specific value, in case HBM scrubbing is enabled. Scrubbing will be
performed after reset and after user closes the FD.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 4ea45bdb9a71..6852bb8e55db 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -4194,6 +4194,11 @@ static int gaudi_hw_init(struct hl_device *hdev)
 		goto disable_msi;
 	}
 
+	/* Scrub both SRAM and DRAM */
+	rc = hdev->asic_funcs->scrub_device_mem(hdev, 0, 0);
+	if (rc)
+		return rc;
+
 	/* Perform read from the device to flush all configuration */
 	RREG32(mmHW_STATE);
 
@@ -4758,8 +4763,8 @@ static int gaudi_hbm_scrubbing(struct hl_device *hdev)
 				"Doing HBM scrubbing for 0x%09llx - 0x%09llx\n",
 				cur_addr, cur_addr + chunk_size);
 
-			WREG32(mmDMA0_CORE_SRC_BASE_LO + dma_offset, 0);
-			WREG32(mmDMA0_CORE_SRC_BASE_HI + dma_offset, 0);
+			WREG32(mmDMA0_CORE_SRC_BASE_LO + dma_offset, 0xdeadbeaf);
+			WREG32(mmDMA0_CORE_SRC_BASE_HI + dma_offset, 0xdeadbeaf);
 			WREG32(mmDMA0_CORE_DST_BASE_LO + dma_offset,
 						lower_32_bits(cur_addr));
 			WREG32(mmDMA0_CORE_DST_BASE_HI + dma_offset,
-- 
2.17.1

