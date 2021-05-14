Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDD8380DD7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 18:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbhENQOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 12:14:19 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38390 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbhENQOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 12:14:12 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14EGCvLo130825;
        Fri, 14 May 2021 11:12:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1621008777;
        bh=KHTkEASXcsTHi1EG+FSRmH04PEsVkNreL3xdSNAkggU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JxienlkJ5VkqCEX76gab0BXzvg8XuWM/41fZGjVxDyuwYC1TeuDsgkHB0TmPztk6B
         5joxuOwF0S3N5D3yqx6+seaCnHDn8ZgEeptpo80b/Bg10eADIOIuzXVTwGg3Dbo9nW
         XwqDIop1ld9U7AZg9usDtMHIpU3ppg/8e/MtS3hw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14EGCv3x007547
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 May 2021 11:12:57 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 14
 May 2021 11:12:57 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 14 May 2021 11:12:57 -0500
Received: from lelv0597.itg.ti.com (lelv0597.itg.ti.com [10.181.64.32])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14EGCvWG049120;
        Fri, 14 May 2021 11:12:57 -0500
Received: from localhost ([10.250.35.60])
        by lelv0597.itg.ti.com (8.14.7/8.14.7) with ESMTP id 14EGCvsg009568;
        Fri, 14 May 2021 11:12:57 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC:     Deepak Saxena <dsaxena@plexity.net>,
        Tero Kristo <kristo@kernel.org>, Keerthy <j-keerthy@ti.com>,
        Gowtham Tammana <g-tammana@ti.com>,
        Vaibhav Gupta <v_gupta@ti.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH 2/6] crypto: sa2ul - Fix leaks on failure paths with sa_dma_init()
Date:   Fri, 14 May 2021 11:12:42 -0500
Message-ID: <20210514161246.22517-3-s-anna@ti.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210514161246.22517-1-s-anna@ti.com>
References: <20210514161246.22517-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sa_dma_init() function doesn't release the requested dma channels
on all failure paths. Any failure in this function also ends up
leaking the dma pool created in sa_init_mem() in the sa_ul_probe()
function. Fix all of these issues.

Fixes: 7694b6ca649f ("crypto: sa2ul - Add crypto driver")
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/crypto/sa2ul.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/sa2ul.c b/drivers/crypto/sa2ul.c
index 1c6929fb3a13..3d6f0af2f938 100644
--- a/drivers/crypto/sa2ul.c
+++ b/drivers/crypto/sa2ul.c
@@ -2300,9 +2300,9 @@ static int sa_dma_init(struct sa_crypto_data *dd)
 
 	dd->dma_rx2 = dma_request_chan(dd->dev, "rx2");
 	if (IS_ERR(dd->dma_rx2)) {
-		dma_release_channel(dd->dma_rx1);
-		return dev_err_probe(dd->dev, PTR_ERR(dd->dma_rx2),
-				     "Unable to request rx2 DMA channel\n");
+		ret = dev_err_probe(dd->dev, PTR_ERR(dd->dma_rx2),
+				    "Unable to request rx2 DMA channel\n");
+		goto err_dma_rx2;
 	}
 
 	dd->dma_tx = dma_request_chan(dd->dev, "tx");
@@ -2323,28 +2323,31 @@ static int sa_dma_init(struct sa_crypto_data *dd)
 	if (ret) {
 		dev_err(dd->dev, "can't configure IN dmaengine slave: %d\n",
 			ret);
-		return ret;
+		goto err_dma_config;
 	}
 
 	ret = dmaengine_slave_config(dd->dma_rx2, &cfg);
 	if (ret) {
 		dev_err(dd->dev, "can't configure IN dmaengine slave: %d\n",
 			ret);
-		return ret;
+		goto err_dma_config;
 	}
 
 	ret = dmaengine_slave_config(dd->dma_tx, &cfg);
 	if (ret) {
 		dev_err(dd->dev, "can't configure OUT dmaengine slave: %d\n",
 			ret);
-		return ret;
+		goto err_dma_config;
 	}
 
 	return 0;
 
+err_dma_config:
+	dma_release_channel(dd->dma_tx);
 err_dma_tx:
-	dma_release_channel(dd->dma_rx1);
 	dma_release_channel(dd->dma_rx2);
+err_dma_rx2:
+	dma_release_channel(dd->dma_rx1);
 
 	return ret;
 }
@@ -2414,7 +2417,7 @@ static int sa_ul_probe(struct platform_device *pdev)
 	sa_init_mem(dev_data);
 	ret = sa_dma_init(dev_data);
 	if (ret)
-		goto disable_pm_runtime;
+		goto destroy_dma_pool;
 
 	match = of_match_node(of_match, dev->of_node);
 	if (!match) {
@@ -2454,9 +2457,9 @@ static int sa_ul_probe(struct platform_device *pdev)
 	dma_release_channel(dev_data->dma_rx1);
 	dma_release_channel(dev_data->dma_tx);
 
+destroy_dma_pool:
 	dma_pool_destroy(dev_data->sc_pool);
 
-disable_pm_runtime:
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.30.1

