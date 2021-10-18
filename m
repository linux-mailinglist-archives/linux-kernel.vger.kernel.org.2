Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E87743277D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 21:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbhJRTXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 15:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhJRTXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 15:23:41 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FB0C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 12:21:30 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r18so3381382edv.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 12:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RFVgC2nTbZsJbOdA8XEIaDw30XWcWrdE6dI/+NoIrsw=;
        b=NMzYBaYhhNx30kEwvF4Az8faCclg9hmx/4E7njB57F9EGavIVsMUc4T63TW5t9qQSU
         lrh/j4PBi9YN9ql7ZH4b8+hPCOd/6451gZImx45sJCGw2qud67FueCriSC64nxE+6oFT
         vkuaNosxOqQrePtP6ZgOClNUroQW1ZRJlUlzpv3EhyWiUzrPWGCTuJdShQo7lg/ISZb0
         19a/jKvOb7sLqb+YoZ85eEErx2uOhysS6SeLX5Bt/wJAw04XEKDuNEbNVdMC8eD8gXmn
         unXgqZJS2fLtCUlJRPL1jI/OHAF/T4NvUA618pPF2Qy6d9a34ajOwHTf8vFXATbqX7/F
         2YAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RFVgC2nTbZsJbOdA8XEIaDw30XWcWrdE6dI/+NoIrsw=;
        b=bg/8KOADlGNUeKaOXC7/47QHBhkTIBn3+qihu8PoMjRSjpBETicyBtHLEn9IC+lczs
         R1V8aglUA4CzI1prOTgpWXYPWH+wFdq7KyQ9s7U2aKBJ7QdxWTkQ8uNNZIi9k0XFLim2
         6URbtoElNx3wrGA0j1XTqZ68m1zNHZ7Xg5+71kdAhdYqTxk4S3XOmbH9Y9t050ZJh0RU
         V6/zAD89NsdMNNyAU4LChcka/+Sj5E5dv7SGkHHIdDEUujS8mF2HNYuSjseCwsjpCDQl
         JhjYUuKTgqUDFfUO4DR6L71KUgNcIz9Dka/aiU536ZroUq+JOGYIut15SheVCElKkrtt
         yltw==
X-Gm-Message-State: AOAM530cBPkEDTHPlV9xLLVb27082mudZuAlhnTdLHpzevrlBvafwgcC
        x3FHj1ogHvLeTfCgcuzBEMUaK5IAvAw=
X-Google-Smtp-Source: ABdhPJz8+6AN4HCVy3xIyRxnrmOVpQE4T1XjJA6vsFZuKo9+Ce07vCDtOY2JzdKTnJd2SQ+H/edPQA==
X-Received: by 2002:aa7:ccc1:: with SMTP id y1mr47967896edt.177.1634584888711;
        Mon, 18 Oct 2021 12:21:28 -0700 (PDT)
Received: from tom-desktop.station (net-188-153-110-208.cust.vodafonedsl.it. [188.153.110.208])
        by smtp.gmail.com with ESMTPSA id j3sm9101291ejy.65.2021.10.18.12.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 12:21:28 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: vt6655: fix camelcase byData in card.c
Date:   Mon, 18 Oct 2021 21:21:22 +0200
Message-Id: <20211018192124.8738-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace camelcase variable "byData" into linux kernel coding style
equivalent variable "data" in card.c.
"by" prefix in hungarian notation stands for byte or unsigned char

References:
 - https://www.cse.iitk.ac.in/users/dsrkg/cs245/html/Guide.htm
 - https://www.kernel.org/doc/html/v4.10/process/coding-style.html

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
Changes since v1:
 - Make the commit body message more clearer

 drivers/staging/vt6655/card.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 26e08fec6e6a..fac2d0566d2e 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -183,7 +183,7 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 	unsigned char bySlot = 0;
 	unsigned char bySIFS = 0;
 	unsigned char byDIFS = 0;
-	unsigned char byData;
+	unsigned char data;
 	int i;
 
 	/* Set SIFS, DIFS, EIFS, SlotTime, CwMin */
@@ -194,15 +194,15 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 			priv->abyBBVGA[0] = 0x20;
 			priv->abyBBVGA[2] = 0x10;
 			priv->abyBBVGA[3] = 0x10;
-			bb_read_embedded(priv, 0xE7, &byData);
-			if (byData == 0x1C)
+			bb_read_embedded(priv, 0xE7, &data);
+			if (data == 0x1C)
 				bb_write_embedded(priv, 0xE7, priv->abyBBVGA[0]);
 
 		} else if (priv->byRFType == RF_UW2452) {
 			MACvSetBBType(priv->port_offset, BB_TYPE_11A);
 			priv->abyBBVGA[0] = 0x18;
-			bb_read_embedded(priv, 0xE7, &byData);
-			if (byData == 0x14) {
+			bb_read_embedded(priv, 0xE7, &data);
+			if (data == 0x14) {
 				bb_write_embedded(priv, 0xE7, priv->abyBBVGA[0]);
 				bb_write_embedded(priv, 0xE1, 0x57);
 			}
@@ -220,14 +220,14 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 			priv->abyBBVGA[0] = 0x1C;
 			priv->abyBBVGA[2] = 0x00;
 			priv->abyBBVGA[3] = 0x00;
-			bb_read_embedded(priv, 0xE7, &byData);
-			if (byData == 0x20)
+			bb_read_embedded(priv, 0xE7, &data);
+			if (data == 0x20)
 				bb_write_embedded(priv, 0xE7, priv->abyBBVGA[0]);
 
 		} else if (priv->byRFType == RF_UW2452) {
 			priv->abyBBVGA[0] = 0x14;
-			bb_read_embedded(priv, 0xE7, &byData);
-			if (byData == 0x18) {
+			bb_read_embedded(priv, 0xE7, &data);
+			if (data == 0x18) {
 				bb_write_embedded(priv, 0xE7, priv->abyBBVGA[0]);
 				bb_write_embedded(priv, 0xE1, 0xD3);
 			}
@@ -243,14 +243,14 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 			priv->abyBBVGA[0] = 0x1C;
 			priv->abyBBVGA[2] = 0x00;
 			priv->abyBBVGA[3] = 0x00;
-			bb_read_embedded(priv, 0xE7, &byData);
-			if (byData == 0x20)
+			bb_read_embedded(priv, 0xE7, &data);
+			if (data == 0x20)
 				bb_write_embedded(priv, 0xE7, priv->abyBBVGA[0]);
 
 		} else if (priv->byRFType == RF_UW2452) {
 			priv->abyBBVGA[0] = 0x14;
-			bb_read_embedded(priv, 0xE7, &byData);
-			if (byData == 0x18) {
+			bb_read_embedded(priv, 0xE7, &data);
+			if (data == 0x18) {
 				bb_write_embedded(priv, 0xE7, priv->abyBBVGA[0]);
 				bb_write_embedded(priv, 0xE1, 0xD3);
 			}
@@ -798,12 +798,12 @@ bool CARDbGetCurrentTSF(struct vnt_private *priv, u64 *pqwCurrTSF)
 {
 	void __iomem *iobase = priv->port_offset;
 	unsigned short ww;
-	unsigned char byData;
+	unsigned char data;
 
 	MACvRegBitsOn(iobase, MAC_REG_TFTCTL, TFTCTL_TSFCNTRRD);
 	for (ww = 0; ww < W_MAX_TIMEOUT; ww++) {
-		VNSvInPortB(iobase + MAC_REG_TFTCTL, &byData);
-		if (!(byData & TFTCTL_TSFCNTRRD))
+		VNSvInPortB(iobase + MAC_REG_TFTCTL, &data);
+		if (!(data & TFTCTL_TSFCNTRRD))
 			break;
 	}
 	if (ww == W_MAX_TIMEOUT)
-- 
2.25.1

