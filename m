Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4AA40C326
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 11:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbhIOJ7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 05:59:22 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:64251 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbhIOJ7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:59:06 -0400
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 15 Sep 2021 02:57:47 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Sep 2021 02:57:45 -0700
X-QCInternal: smtphost
Received: from mdalam-linux.qualcomm.com ([10.201.2.71])
  by ironmsg02-blr.qualcomm.com with ESMTP; 15 Sep 2021 15:27:42 +0530
Received: by mdalam-linux.qualcomm.com (Postfix, from userid 466583)
        id 404DF22353; Wed, 15 Sep 2021 15:27:41 +0530 (IST)
From:   Md Sadre Alam <mdalam@codeaurora.org>
To:     miquel.raynal@bootlin.com, mani@kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mdalam@codeaurora.org, sricharan@codeaurora.org
Subject: [PATCH 1/3] mtd: rawnand: qcom: Add support for status pipe
Date:   Wed, 15 Sep 2021 15:27:29 +0530
Message-Id: <1631699851-12172-2-git-send-email-mdalam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631699851-12172-1-git-send-email-mdalam@codeaurora.org>
References: <1631699851-12172-1-git-send-email-mdalam@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From QPIC V2.0 onwards there is a separate pipe
to read status of each code word, called "status" pipe.

"status" pipe will use to read CW status in case of
enhanced read mode like page scope read, multi page read.

Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 04e6f7b..42c6291 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -389,6 +389,7 @@ struct qcom_nand_controller {
 			struct dma_chan *tx_chan;
 			struct dma_chan *rx_chan;
 			struct dma_chan *cmd_chan;
+			struct dma_chan *sts_chan;
 		};
 
 		/* will be used only by EBI2 for ADM DMA */
@@ -2737,6 +2738,11 @@ static void qcom_nandc_unalloc(struct qcom_nand_controller *nandc)
 
 		if (nandc->cmd_chan)
 			dma_release_channel(nandc->cmd_chan);
+
+		if (nandc->props->qpic_v2) {
+			if (nandc->sts_chan)
+				dma_release_channel(nandc->sts_chan);
+		}
 	} else {
 		if (nandc->chan)
 			dma_release_channel(nandc->chan);
@@ -2815,6 +2821,14 @@ static int qcom_nandc_alloc(struct qcom_nand_controller *nandc)
 			goto unalloc;
 		}
 
+		if (nandc->props->qpic_v2) {
+			nandc->sts_chan = dma_request_slave_channel(nandc->dev, "sts");
+			if (!nandc->sts_chan) {
+				dev_err(nandc->dev, "failed to request sts channel\n");
+				return -ENODEV;
+			}
+		}
+
 		/*
 		 * Initially allocate BAM transaction to read ONFI param page.
 		 * After detecting all the devices, this BAM transaction will
-- 
2.7.4

