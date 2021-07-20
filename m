Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D983CFAED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 15:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237560AbhGTNCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 09:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238362AbhGTM56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:57:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BB4661107;
        Tue, 20 Jul 2021 13:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626788316;
        bh=yix51yf07Z8qDxgST7yPFtC4zAsHbFq/kObexAIh79w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eBA3j5jxeHAyFRsjt09covbtUAO/5KX9Omg/7cPGyvA0TIQgNXHvi1zvf5dhdlnzx
         GAIp1VEY64vEoXex6YONdYCNQLl8nAsdbRkL555eq+hrvyg/UzND1hwVdy7/tCEL/5
         j4pW9n5VkHYSJan2fC4E1WX90urMLxwiX1qe7YMrdneCugVC3iAtVMHM93hqVv5/UL
         gp0+BPlllg1t01yzrqD4YfHOwEiuyE3IHzR4Wcn/42MlYwyn8S+2nohti8o12TDZr/
         DcXGpJiz/hB9I9PsDO0nvHGx/RiyuTNZ+d+KIcwjdtVpA5K5soy/sPY2/8OvK6LBIx
         eHw9iBh0w3FEQ==
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Claire Chang <tientzu@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 1/4] of: Return success from of_dma_set_restricted_buffer() when !OF_ADDRESS
Date:   Tue, 20 Jul 2021 14:38:23 +0100
Message-Id: <20210720133826.9075-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210720133826.9075-1-will@kernel.org>
References: <20210720133826.9075-1-will@kernel.org>
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
Tested-by: Claire Chang <tientzu@chromium.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

