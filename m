Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E8B3D9E6D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 09:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbhG2H3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 03:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbhG2H3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 03:29:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4BEC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 00:29:41 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jbe@pengutronix.de>)
        id 1m90U7-0000u9-F0; Thu, 29 Jul 2021 09:29:39 +0200
Received: from [2a0a:edc0:0:900:2e4d:54ff:fe67:bfa5] (helo=ginster)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <jbe@pengutronix.de>)
        id 1m90U6-0002J0-Fl; Thu, 29 Jul 2021 09:29:38 +0200
Received: from jbe by ginster with local (Exim 4.92)
        (envelope-from <jbe@pengutronix.de>)
        id 1m90U6-0002gl-Ej; Thu, 29 Jul 2021 09:29:38 +0200
From:   Juergen Borleis <jbe@pengutronix.de>
To:     linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, festevam@gmail.com,
        wsa+renesas@sang-engineering.com, dianders@chromium.org,
        ulf.hansson@linaro.org, kernel@pengutronix.de
Subject: [PATCH 2/2] mmc: mxcmmc: don't expect a DMA operation if DMA seems present
Date:   Thu, 29 Jul 2021 09:29:29 +0200
Message-Id: <20210729072929.10267-3-jbe@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729072929.10267-1-jbe@pengutronix.de>
References: <20210729072929.10267-1-jbe@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: jbe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the driver's default behaviour from DMA to PIO for each request.
Preparing DMA can fail or be prevented by other causes. Switch to a DMA
operation only, if it is really possible.

This avoids a NULL pointer dereference on shutdown in mxcmci_start_cmd()
where it tries to store a DMA callback configuration into mxcmci_host::desc
which isn't setup a this point of time.

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
---
 drivers/mmc/host/mxcmmc.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 611f827..41feea9 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -293,14 +293,13 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 	mxcmci_writew(host, blksz, MMC_REG_BLK_LEN);
 	host->datasize = datasize;
 
-	if (!mxcmci_use_dma(host))
-		return 0;
+	if (host->dma == NULL)
+		return 0; /* Keep PIO */
 
+	/* Avoid the use of DMA on short transfers, e.g. non-sectors for example */
 	for_each_sg(data->sg, sg, data->sg_len, i) {
-		if (sg->offset & 3 || sg->length & 3 || sg->length < 512) {
-			host->do_dma = 0;
-			return 0;
-		}
+		if (sg->offset & 3 || sg->length & 3 || sg->length < 512)
+			return 0; /* Keep PIO */
 	}
 
 	if (data->flags & MMC_DATA_READ) {
@@ -325,9 +324,11 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 	if (!host->desc) {
 		dma_unmap_sg(host->dma->device->dev, data->sg, data->sg_len,
 				host->dma_dir);
-		host->do_dma = 0;
-		return 0; /* Fall back to PIO */
+		return 0; /* Keep PIO */
 	}
+
+	/* DMA is possible */
+	host->do_dma = 1;
 	wmb();
 
 	dmaengine_submit(host->desc);
@@ -747,8 +748,11 @@ static void mxcmci_request(struct mmc_host *mmc, struct mmc_request *req)
 	host->req = req;
 	host->cmdat &= ~CMD_DAT_CONT_INIT;
 
-	if (host->dma)
-		host->do_dma = 1;
+	/*
+	 * Default always to PIO. DMA will be enabled in
+	 * mxcmci_setup_data() if possible
+	 */
+	host->do_dma = 0;
 
 	if (req->data) {
 		error = mxcmci_setup_data(host, req->data);
-- 
2.20.1

