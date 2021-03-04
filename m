Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C3432CB04
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 04:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhCDDoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 22:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbhCDDno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 22:43:44 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6C6C0613D9
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 19:42:26 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id u12so5914299pjr.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 19:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pEDn5zvdGAqn29kJmMDpnpbScHXapYdOv8Q9mn7KjzI=;
        b=dyQ6mxeda93Ed1Ys7wxwT79+2r8nJaEpnMREGZsW250EbE7qM9c6J9b4zVtzRWhVwc
         8wRCFySB0rRbna24MTqikfa5Jbf5T67hOZlAQw8qrNH4/1JrBBymRZdyD5gZvo4thKw3
         uPcuryUoMDCsW/g+88IWioCkLxarMIOuosRWUuyEPcgtnfNz9LUup9BcXlOK0t7RmzvQ
         G2+NF4Fu68lGlBGMpk33MXkuHaeuIJQjbObKz15VsEh+sJAJErqq0Z9JPR+Fo6uKc6Gb
         9s7AsqWHtdmtJ9sb/w+i9BpjbwUQg0haBUa/9bS+8LTlAHk4lg5CMQLUq63AY8j34xuv
         Tk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pEDn5zvdGAqn29kJmMDpnpbScHXapYdOv8Q9mn7KjzI=;
        b=R0o/IozEzihNf85tyZuM+Rb7cpFFFLs/MFyavUw9kbzwG2qnjz/eL9z/5+tK5q8uzM
         DGA2x+Ln9uajAddG0pfdV3oFbIGGMN4dCRoQV8sdgV1NcleUeEOrNNrEZzZyw1BCXGNi
         jtwAak8PZZ3AeRnFu0vJbiqkELjLsj8w9cfz2Zd+Tbl1SWyUJ/0ZAWH1af5WC6BETSkT
         aweTFoLMPZcUzBUa1LztPKUkUOtzzTBlg1l2zY84k3NYnko+0QbYsPOjVfV66l674n0y
         4ulsUe1ez30w0njC709+EDLFWf9IXFA8G2DgizxpepCUGt4MrU3RNQG387JPY78TUUlR
         UEZA==
X-Gm-Message-State: AOAM531lCtPy5Ou3v2jsHzlYhUdWrcTow5TrOEh2gJkLqBYpOWfTWlzv
        KjVmNKU5bKHZRDKcOLBtPmdy0A==
X-Google-Smtp-Source: ABdhPJwYrpHQt7QzewDSFjUimFQsjcQaardRWxa9Dovbew7izqL2bGvYzhlZbHVt9HmcILArx/1A5g==
X-Received: by 2002:a17:90a:8b82:: with SMTP id z2mr2278618pjn.25.1614829346114;
        Wed, 03 Mar 2021 19:42:26 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id h17sm2403989pfc.211.2021.03.03.19.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 19:42:25 -0800 (PST)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] spi: cadence-quadspi: Add QSPI support for Pensando Elba SoC
Date:   Wed,  3 Mar 2021 19:41:35 -0800
Message-Id: <20210304034141.7062-3-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210304034141.7062-1-brad@pensando.io>
References: <20210304034141.7062-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add QSPI controller support fo Pensando Elba SoC.

Signed-off-by: Brad Larson <brad@pensando.io>
---
 drivers/spi/spi-cadence-quadspi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 442cc7c53a47..fb0d9b0bd596 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1353,6 +1353,7 @@ static int cqspi_request_mmap_dma(struct cqspi_st *cqspi)
 	cqspi->rx_chan = dma_request_chan_by_mask(&mask);
 	if (IS_ERR(cqspi->rx_chan)) {
 		int ret = PTR_ERR(cqspi->rx_chan);
+
 		cqspi->rx_chan = NULL;
 		return dev_err_probe(&cqspi->pdev->dev, ret, "No Rx DMA available\n");
 	}
@@ -1632,6 +1633,10 @@ static const struct cqspi_driver_platdata intel_lgm_qspi = {
 	.quirks = CQSPI_DISABLE_DAC_MODE,
 };
 
+static const struct cqspi_driver_platdata pen_cdns_qspi = {
+	.quirks = CQSPI_NEEDS_WR_DELAY | CQSPI_DISABLE_DAC_MODE,
+};
+
 static const struct of_device_id cqspi_dt_ids[] = {
 	{
 		.compatible = "cdns,qspi-nor",
@@ -1649,6 +1654,10 @@ static const struct of_device_id cqspi_dt_ids[] = {
 		.compatible = "intel,lgm-qspi",
 		.data = &intel_lgm_qspi,
 	},
+	{
+		.compatible = "pensando,cdns-qspi",
+		.data = &pen_cdns_qspi,
+	},
 	{ /* end of table */ }
 };
 
-- 
2.17.1

