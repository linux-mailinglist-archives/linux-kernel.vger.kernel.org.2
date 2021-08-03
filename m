Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6630F3DE834
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbhHCIUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:20:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234238AbhHCIUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:20:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47F0B60C41;
        Tue,  3 Aug 2021 08:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627978838;
        bh=R50llJLkBxpzPLGaip4NVUgeif1eu/WX/0qNCl8oXrs=;
        h=From:To:Cc:Subject:Date:From;
        b=t2m++/UYxK7omYG9YfGV0aIZMgHsPsO6vM92dJYqQqcF0Qre+83jIaZ1yHZZhYtxx
         jLs5NADuGgOG+bG4iB0doNf7Z8w+BGITI1T3U15OkZdn6tyGxpY3E5IZwYMv/LkVAM
         la0H4MJvL4OuQqkAjOgKTw8i7mhzm5fsjFY8A72l+OIui9VlXCOf77u7Bkg/QQN7kG
         jTLrtQp+QYP16JvCloJIJhhfQUHd+/4xzCa36Sxib+zqcCJ0GEf9lO1N1zSsOlIFAO
         a5Rdq4TEsbTONsDhEXNVqAOTz98drXixVSUFIvZeNBHztmYZQ39BnEhRCQN/7xIHdq
         2xtgNoKVA5+zA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Krzysztof Halasa <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soc: ixp4xx: fix printing resources
Date:   Tue,  3 Aug 2021 10:20:28 +0200
Message-Id: <20210803082034.2085618-1-arnd@kernel.org>
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

