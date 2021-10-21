Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53234362EC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 15:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbhJUN34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 09:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbhJUN3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:29:54 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B305C0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 06:27:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 913B01F44AAD
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v3] regmap: spi: Set regmap max raw r/w from max_transfer_size
Date:   Thu, 21 Oct 2021 10:27:21 -0300
Message-Id: <20211021132721.13669-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Tanure <tanureal@opensource.cirrus.com>

Set regmap raw read/write from spi max_transfer_size
so regmap_raw_read/write can split the access into chunks

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
[André: fix build warning]
Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
Changes from v2:
- Fix build warning
v2: https://lore.kernel.org/lkml/20210913130101.1577964-1-tanureal@opensource.cirrus.com/

 drivers/base/regmap/regmap-spi.c | 36 ++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-spi.c b/drivers/base/regmap/regmap-spi.c
index c1894e93c378..719323bc6c7f 100644
--- a/drivers/base/regmap/regmap-spi.c
+++ b/drivers/base/regmap/regmap-spi.c
@@ -109,13 +109,37 @@ static const struct regmap_bus regmap_spi = {
 	.val_format_endian_default = REGMAP_ENDIAN_BIG,
 };
 
+static const struct regmap_bus *regmap_get_spi_bus(struct spi_device *spi,
+						   const struct regmap_config *config)
+{
+	size_t max_size = spi_max_transfer_size(spi);
+	struct regmap_bus *bus;
+
+	if (max_size != SIZE_MAX) {
+		bus = kmemdup(&regmap_spi, sizeof(*bus), GFP_KERNEL);
+		if (!bus)
+			return ERR_PTR(-ENOMEM);
+
+		bus->free_on_exit = true;
+		bus->max_raw_read = max_size;
+		bus->max_raw_write = max_size;
+		return bus;
+	}
+
+	return &regmap_spi;
+}
+
 struct regmap *__regmap_init_spi(struct spi_device *spi,
 				 const struct regmap_config *config,
 				 struct lock_class_key *lock_key,
 				 const char *lock_name)
 {
-	return __regmap_init(&spi->dev, &regmap_spi, &spi->dev, config,
-			     lock_key, lock_name);
+	const struct regmap_bus *bus = regmap_get_spi_bus(spi, config);
+
+	if (IS_ERR(bus))
+		return ERR_CAST(bus);
+
+	return __regmap_init(&spi->dev, bus, &spi->dev, config, lock_key, lock_name);
 }
 EXPORT_SYMBOL_GPL(__regmap_init_spi);
 
@@ -124,8 +148,12 @@ struct regmap *__devm_regmap_init_spi(struct spi_device *spi,
 				      struct lock_class_key *lock_key,
 				      const char *lock_name)
 {
-	return __devm_regmap_init(&spi->dev, &regmap_spi, &spi->dev, config,
-				  lock_key, lock_name);
+	const struct regmap_bus *bus = regmap_get_spi_bus(spi, config);
+
+	if (IS_ERR(bus))
+		return ERR_CAST(bus);
+
+	return __devm_regmap_init(&spi->dev, bus, &spi->dev, config, lock_key, lock_name);
 }
 EXPORT_SYMBOL_GPL(__devm_regmap_init_spi);
 
-- 
2.33.1

