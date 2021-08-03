Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8323DE7E5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbhHCIHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:07:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234248AbhHCIHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:07:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4426760EBD;
        Tue,  3 Aug 2021 08:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627978044;
        bh=R50llJLkBxpzPLGaip4NVUgeif1eu/WX/0qNCl8oXrs=;
        h=From:To:Cc:Subject:Date:From;
        b=Xwk52u6rTkbI6AId2xMVEzDohdm7k4F1yODZ9/PwURjLSkObDAwBeqF+RmC9emWv8
         uMiyaQcES8y1UHAXxeSJ/nkFn70sPVy/5D+VPJSgGGiBZtOjqPVt1I12WFBwZ7IK7N
         +cAtMdBDSrBKzyqFIFoblBMBVP3LfEjzDkUNkZetvnZpUFfPx9O0U0m1OkjexdGzZf
         p0HWsgJP1h75dn15UE9y6az4MBU2w59yvO26WygbxTx0AEfWB3RLVAXOAxqXIxWlyL
         I6KS7otEGGJlq8raAt39vJzWSdQ/j5QuZlJY5ylPaXDHMajaZhzCoCZaEE3/UjqJTe
         1XmGFL4UiI8vQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Krzysztof Halasa <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soc: ixp4xx: fix printing resources
Date:   Tue,  3 Aug 2021 10:07:12 +0200
Message-Id: <20210803080720.2081312-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When compile-testing with 64-bit resource_size_t, gcc reports an invalid
printk format string:

In file included from include/linux/dma-mapping.h:7,
                 from drivers/soc/ixp4xx/ixp4xx-npe.c:15:
drivers/soc/ixp4xx/ixp4xx-npe.c: In function 'ixp4xx_npe_probe':
drivers/soc/ixp4xx/ixp4xx-npe.c:694:18: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]
    dev_info(dev, "NPE%d at 0x%08x-0x%08x not available\n",

Use the special %pR format string to print the resources.

Fixes: 0b458d7b10f8 ("soc: ixp4xx: npe: Pass addresses as resources")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/ixp4xx/ixp4xx-npe.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/ixp4xx/ixp4xx-npe.c b/drivers/soc/ixp4xx/ixp4xx-npe.c
index fea50e04d5a1..f490c4ca51f5 100644
--- a/drivers/soc/ixp4xx/ixp4xx-npe.c
+++ b/drivers/soc/ixp4xx/ixp4xx-npe.c
@@ -693,8 +693,8 @@ static int ixp4xx_npe_probe(struct platform_device *pdev)
 
 		if (!(ixp4xx_read_feature_bits() &
 		      (IXP4XX_FEATURE_RESET_NPEA << i))) {
-			dev_info(dev, "NPE%d at 0x%08x-0x%08x not available\n",
-				 i, res->start, res->end);
+			dev_info(dev, "NPE%d at %pR not available\n",
+				 i, res);
 			continue; /* NPE already disabled or not present */
 		}
 		npe->regs = devm_ioremap_resource(dev, res);
@@ -702,13 +702,12 @@ static int ixp4xx_npe_probe(struct platform_device *pdev)
 			return PTR_ERR(npe->regs);
 
 		if (npe_reset(npe)) {
-			dev_info(dev, "NPE%d at 0x%08x-0x%08x does not reset\n",
-				 i, res->start, res->end);
+			dev_info(dev, "NPE%d at %pR does not reset\n",
+				 i, res);
 			continue;
 		}
 		npe->valid = 1;
-		dev_info(dev, "NPE%d at 0x%08x-0x%08x registered\n",
-			 i, res->start, res->end);
+		dev_info(dev, "NPE%d at %pR registered\n", i, res);
 		found++;
 	}
 
-- 
2.29.2

