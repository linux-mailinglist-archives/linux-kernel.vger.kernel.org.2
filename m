Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D97B3CD4C8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 14:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbhGSLvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 07:51:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236571AbhGSLvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 07:51:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70DE461164;
        Mon, 19 Jul 2021 12:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626697908;
        bh=yTpl5rcN0Uj3hX5cptg4+vqh8gdxrnseOI6Ag6FWF+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C0bcDBI1qxITK4XurWDSE3hixNdXYW4Y674XU7jgE6jTdfKgFLnmjVPUiHwH+JFT+
         S6VmN4bFoV+u5cy0aVAH79MVYIjj4G1Q8lSr5DRaRv1VY50SLC+lKrdGVvv6Xy9Zhu
         rtQNPVWc2vyRIEpW1bzHUsLnI9aWmzxGHmbuhdF0jq6Hns8nJ7tOaTDWr+dhJubx1/
         SJMuq+A+upzMvSfTUOskKEfFxv8xH1l2dtEG3nZn7JPjDS5/52jkticX48C8wZXF1f
         WHNbot0IL3dTuepRoM7KXlUU6lM40DrDZYbHqeoWcrUPcvK0X4QFyFqk+Di+L1oiNo
         sY2L1wiUGVblg==
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Claire Chang <tientzu@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 1/5] of: Return success from of_dma_set_restricted_buffer() when !OF_ADDRESS
Date:   Mon, 19 Jul 2021 13:30:50 +0100
Message-Id: <20210719123054.6844-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210719123054.6844-1-will@kernel.org>
References: <20210719123054.6844-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_OF_ADDRESS=n, of_dma_set_restricted_buffer() returns -ENODEV
and breaks the boot for sparc[64] machines. Return 0 instead, since the
function is essentially a glorified NOP in this configuration.

Cc: Claire Chang <tientzu@chromium.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20210702030807.GA2685166@roeck-us.net
Fixes: fec9b625095f ("of: Add plumbing for restricted DMA pool")
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/of/of_private.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 376462798f7e..f557bd22b0cf 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -173,7 +173,8 @@ static inline int of_dma_get_range(struct device_node *np,
 static inline int of_dma_set_restricted_buffer(struct device *dev,
 					       struct device_node *np)
 {
-	return -ENODEV;
+	/* Do nothing, successfully. */
+	return 0;
 }
 #endif
 
-- 
2.32.0.402.g57bb445576-goog

