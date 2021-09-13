Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3DC408B7B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 15:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbhIMNC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 09:02:28 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:25653 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236776AbhIMNC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 09:02:26 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18D5sXGg002737;
        Mon, 13 Sep 2021 08:01:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=SnhgUKVfFb/6e87FBg0KFMGT8EGSflyNY6+o3wDQLRo=;
 b=VY8IIUMDa+H9XiMmL06xo9m3tFUjtMfyaCsZ/yyhCYOvKcloZAo8WJVz5xMtcr629z3e
 xITy5UDkCxFRUZevykoDcA7XSDh13V/Cuf0yJOWDWuMyEueZDpBDNfHLFRopUHIiNZve
 8sjWt2gs+AAlGZtjiUJ8Nq7XI+NDjMgJbXA/AhNo4pWNKdhsuujdY1aGwG3t0rKIMUyd
 zHOAalE+nt6mLwMkUEWp8VVfMesfRwnj3DDqRjT9VK8+2i6I5HlTzxYObSSBNPgi569A
 CxYO1IB1tZAFkOFUduXBIOsgSSLoRVJ6VIOK1z+ROR+LsrSoJKasQNgaRbgLcVAwGIFz ow== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3b1hb38we8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Sep 2021 08:01:05 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 13 Sep
 2021 14:01:03 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Mon, 13 Sep 2021 14:01:03 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.203])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 95D05B16;
        Mon, 13 Sep 2021 13:01:02 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v2] regmap: spi: Set regmap max raw r/w from max_transfer_size
Date:   Mon, 13 Sep 2021 14:01:01 +0100
Message-ID: <20210913130101.1577964-1-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: VZbm4NYyttwWhC75DCgOGCVvKO-wIOJx
X-Proofpoint-ORIG-GUID: VZbm4NYyttwWhC75DCgOGCVvKO-wIOJx
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set regmap raw read/write from spi max_transfer_size
so regmap_raw_read/write can split the access into chunks

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---

Changes v2:
Sent as single patch

 drivers/base/regmap/regmap-spi.c | 36 ++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-spi.c b/drivers/base/regmap/regmap-spi.c
index c1894e93c3788..0e6552e57ecf9 100644
--- a/drivers/base/regmap/regmap-spi.c
+++ b/drivers/base/regmap/regmap-spi.c
@@ -109,13 +109,37 @@ static const struct regmap_bus regmap_spi = {
 	.val_format_endian_default = REGMAP_ENDIAN_BIG,
 };
 
+static const struct regmap_bus *regmap_get_spi_bus(struct spi_device *spi,
+						   const struct regmap_config *config)
+{
+	struct spi_master *master = spi->master;
+	struct regmap_bus *bus = NULL;
+	size_t max_size = spi_max_transfer_size(spi);
+
+	if (max_size != SIZE_MAX) {
+		bus = kmemdup(&regmap_spi, sizeof(*bus), GFP_KERNEL);
+		if (!bus)
+			return ERR_PTR(-ENOMEM);
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
2.33.0

