Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA45E4433F7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 17:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbhKBQxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 12:53:02 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:34728 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234928AbhKBQwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:52:09 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A2ELW5I011686;
        Tue, 2 Nov 2021 17:49:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=QJ6uXo4CEaD4BilyVlTiA31QtvvAdHcFZfiTCH/Jv/U=;
 b=SyxBB5Wmxqce4kvtjGlGooBkwoBhYMQxW1jBIpbmkTrGmQtONC94S3D19jpN1pv4cYsd
 cQcVtfLU4qiosRqjCTTp+ApLCu5g+1NZggXUaYPZiwT59jD3+qdIpeZTTnMBCNi/y2iV
 q2dktGQnLryKh9y/+vsilWEE/l/I5TewQskuLdC05mIXy3OTphz07vDFXlrtp55o6EfB
 ysGcql6O2Do/+A9A8Xnb5DGMozfuLSruW/yKxG40zewohfUF7ekwznzMDqam4N0Lty+Y
 KzCV7yORo2jAOT6lnf3LcvMY+ixCKzQUWLq18xindPvlkzu4Wl4UYXgl6AH4o6b9iInL Yw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3c2jfj6pjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Nov 2021 17:49:21 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 06F4D100038;
        Tue,  2 Nov 2021 17:49:21 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F205123535A;
        Tue,  2 Nov 2021 17:49:20 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 2 Nov 2021 17:49:20
 +0100
From:   Nicolas Toromanoff <nicolas.toromanoff@foss.st.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Marek Vasut <marex@denx.de>,
        Nicolas Toromanoff <nicolas.toromanoff@foss.st.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        <linux-crypto@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 8/8] crypto: stm32/cryp - reorder hw initialization
Date:   Tue, 2 Nov 2021 17:47:29 +0100
Message-ID: <20211102164729.9957-9-nicolas.toromanoff@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211102164729.9957-1-nicolas.toromanoff@foss.st.com>
References: <20211102164729.9957-1-nicolas.toromanoff@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_08,2021-11-02_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CRYP IP checks the written key depending of the configuration, it's
safer to write the whole configuration to hardware then the key to avoid
unexpected key rejection.

Signed-off-by: Nicolas Toromanoff <nicolas.toromanoff@foss.st.com>
---
 drivers/crypto/stm32/stm32-cryp.c | 39 ++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-cryp.c b/drivers/crypto/stm32/stm32-cryp.c
index 5962fbb0bc91..d99eea9cb8cd 100644
--- a/drivers/crypto/stm32/stm32-cryp.c
+++ b/drivers/crypto/stm32/stm32-cryp.c
@@ -232,6 +232,11 @@ static inline int stm32_cryp_wait_busy(struct stm32_cryp *cryp)
 			!(status & SR_BUSY), 10, 100000);
 }
 
+static inline void stm32_cryp_enable(struct stm32_cryp *cryp)
+{
+	writel_relaxed(readl_relaxed(cryp->regs + CRYP_CR) | CR_CRYPEN, cryp->regs + CRYP_CR);
+}
+
 static inline int stm32_cryp_wait_enable(struct stm32_cryp *cryp)
 {
 	u32 status;
@@ -534,9 +539,6 @@ static int stm32_cryp_hw_init(struct stm32_cryp *cryp)
 	/* Disable interrupt */
 	stm32_cryp_write(cryp, CRYP_IMSCR, 0);
 
-	/* Set key */
-	stm32_cryp_hw_write_key(cryp);
-
 	/* Set configuration */
 	cfg = CR_DATA8 | CR_FFLUSH;
 
@@ -562,23 +564,36 @@ static int stm32_cryp_hw_init(struct stm32_cryp *cryp)
 	/* AES ECB/CBC decrypt: run key preparation first */
 	if (is_decrypt(cryp) &&
 	    ((hw_mode == CR_AES_ECB) || (hw_mode == CR_AES_CBC))) {
-		stm32_cryp_write(cryp, CRYP_CR, cfg | CR_AES_KP | CR_CRYPEN);
+		/* Configure in key preparation mode */
+		stm32_cryp_write(cryp, CRYP_CR, cfg | CR_AES_KP);
 
+		/* Set key only after full configuration done */
+		stm32_cryp_hw_write_key(cryp);
+
+		/* Start prepare key */
+		stm32_cryp_enable(cryp);
 		/* Wait for end of processing */
 		ret = stm32_cryp_wait_busy(cryp);
 		if (ret) {
 			dev_err(cryp->dev, "Timeout (key preparation)\n");
 			return ret;
 		}
-	}
 
-	cfg |= hw_mode;
+		cfg |= hw_mode | CR_DEC_NOT_ENC;
 
-	if (is_decrypt(cryp))
-		cfg |= CR_DEC_NOT_ENC;
+		/* Apply updated config (Decrypt + algo) and flush */
+		stm32_cryp_write(cryp, CRYP_CR, cfg);
+	} else {
+		cfg |= hw_mode;
+		if (is_decrypt(cryp))
+			cfg |= CR_DEC_NOT_ENC;
 
-	/* Apply config and flush (valid when CRYPEN = 0) */
-	stm32_cryp_write(cryp, CRYP_CR, cfg);
+		/* Apply config and flush */
+		stm32_cryp_write(cryp, CRYP_CR, cfg);
+
+		/* Set key only after configuration done */
+		stm32_cryp_hw_write_key(cryp);
+	}
 
 	switch (hw_mode) {
 	case CR_AES_GCM:
@@ -606,9 +621,7 @@ static int stm32_cryp_hw_init(struct stm32_cryp *cryp)
 	}
 
 	/* Enable now */
-	cfg |= CR_CRYPEN;
-
-	stm32_cryp_write(cryp, CRYP_CR, cfg);
+	stm32_cryp_enable(cryp);
 
 	return 0;
 }
-- 
2.17.1

