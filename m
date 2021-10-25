Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5846C438D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 03:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhJYByu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 21:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbhJYByp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 21:54:45 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86055C061764
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 18:52:23 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q187so9388974pgq.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 18:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2IM8IILq/fLc4pskL5YAke6z8HetM8uOaIfAZ0wHh/U=;
        b=wY77ADfKrGBe/AUokIkKQpy9feYyQHt09nsvRbkv2Z/x/6dOc/t5/kTupgE2t0Zoaf
         p/xDrseKOGkJ3YrTLYJDgF8tmc0eOiS4YYPqaRbD4/jqNgi94MrJGpt0CniLxy0z1buZ
         yWndFbuoksQIBbJsCvIdUeOlnrAeJtSHapjAk5KTEVDpTwBFi+PtSxlpkrEL2fWjwZ/V
         C/JjLqesCaOHXOegETuvpzA87pwWHDaKKVsTRqLJ9JJeimMs1fdpYJqCbt5bedGoZU8a
         Vt+UAQIrt3MIl4d1pzPyre9QtiOXZ+ChcYLKrYetANCmZeDPXw6S08Ns2fVjihaNLnbi
         GJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2IM8IILq/fLc4pskL5YAke6z8HetM8uOaIfAZ0wHh/U=;
        b=MPYocF7wRKZy3Ssax4fz7b9ctI1YAX4YYRqzNc5vxqO2Mokf7HYDAvGChUCGKNBul1
         ExRalMEDexY3jpdvxTZI13zV+XhFGYGLDYVkFejoVD3PfZIxCx9W/wlw4+LZnzohZ7uk
         qe3Fck+mcUUlt0NJs3vVmrB1UiS3LowLfy4YUtdXUgDYg9mjtVpVcK2TPBl5meGwEbro
         TF79O1sv2Rd19XXBPa1XfD8vq9uJSV9nZ0SucsGdweX0BSZZ9zNsFx/Bd1dIOQ/HLhoE
         8s636U2htCMajN9FaN8MI8laKZD+LoKLX09lTfpgYM+9Fi/EwrC43p8Zyj/cn6SAZ4uc
         pcOw==
X-Gm-Message-State: AOAM531iF7kEf0MfDMYmVwVvzZia34qYmhygvNi/I1W/EAMdp4ujdRzj
        b4uu+lZ7rYvXZyPk80SHKEoTFw==
X-Google-Smtp-Source: ABdhPJxAwGb35jsQ6OvhcrJ7QSWnt7HWOAHT5NiS9pZGr/o4wy0q+kFIC5W/oA2XOczaLBQainaFHQ==
X-Received: by 2002:a62:7d8d:0:b0:47b:dfd7:e888 with SMTP id y135-20020a627d8d000000b0047bdfd7e888mr9934532pfc.42.1635126743028;
        Sun, 24 Oct 2021 18:52:23 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id q10sm14855225pgn.31.2021.10.24.18.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 18:52:22 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/11] spi: cadence-quadspi: Add compatible for Pensando Elba SoC
Date:   Sun, 24 Oct 2021 18:51:53 -0700
Message-Id: <20211025015156.33133-9-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211025015156.33133-1-brad@pensando.io>
References: <20211025015156.33133-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Pensando Elba SoC has the Cadence QSPI controller integrated.

The quirk CQSPI_NEEDS_APB_AHB_HAZARD_WAR is added and if enabled
a dummy readback from the controller is performed to ensure
synchronization.

Signed-off-by: Brad Larson <brad@pensando.io>
---
 drivers/spi/spi-cadence-quadspi.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 101cc71bffa7..af36514250d2 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -35,6 +35,7 @@
 /* Quirks */
 #define CQSPI_NEEDS_WR_DELAY		BIT(0)
 #define CQSPI_DISABLE_DAC_MODE		BIT(1)
+#define CQSPI_NEEDS_APB_AHB_HAZARD_WAR	BIT(2)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -74,6 +75,7 @@ struct cqspi_st {
 	int			current_cs;
 	unsigned long		master_ref_clk_hz;
 	bool			is_decoded_cs;
+	bool			apb_ahb_hazard;
 	u32			fifo_depth;
 	u32			fifo_width;
 	u32			num_chipselect;
@@ -862,6 +864,13 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	if (cqspi->wr_delay)
 		ndelay(cqspi->wr_delay);
 
+	/*
+	 * If a hazard exists between the APB and AHB interfaces, perform a
+	 * dummy readback from the controller to ensure synchronization.
+	 */
+	if (cqspi->apb_ahb_hazard)
+		(void)readl(reg_base + CQSPI_REG_INDIRECTWR);
+
 	while (remaining > 0) {
 		size_t write_words, mod_bytes;
 
@@ -1548,6 +1557,8 @@ static int cqspi_probe(struct platform_device *pdev)
 			master->mode_bits |= SPI_RX_OCTAL | SPI_TX_OCTAL;
 		if (!(ddata->quirks & CQSPI_DISABLE_DAC_MODE))
 			cqspi->use_direct_mode = true;
+		if (ddata->quirks & CQSPI_NEEDS_APB_AHB_HAZARD_WAR)
+			cqspi->apb_ahb_hazard = true;
 	}
 
 	ret = devm_request_irq(dev, irq, cqspi_irq_handler, 0,
@@ -1656,6 +1667,10 @@ static const struct cqspi_driver_platdata intel_lgm_qspi = {
 	.quirks = CQSPI_DISABLE_DAC_MODE,
 };
 
+static const struct cqspi_driver_platdata pen_cdns_qspi = {
+	.quirks = CQSPI_NEEDS_APB_AHB_HAZARD_WAR | CQSPI_DISABLE_DAC_MODE,
+};
+
 static const struct of_device_id cqspi_dt_ids[] = {
 	{
 		.compatible = "cdns,qspi-nor",
@@ -1673,6 +1688,10 @@ static const struct of_device_id cqspi_dt_ids[] = {
 		.compatible = "intel,lgm-qspi",
 		.data = &intel_lgm_qspi,
 	},
+	{
+		.compatible = "pensando,elba-qspi",
+		.data = &pen_cdns_qspi,
+	},
 	{ /* end of table */ }
 };
 
-- 
2.17.1

