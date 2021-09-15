Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C191D40C586
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237847AbhIOMp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:45:56 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:29474 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237823AbhIOMpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:45:51 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18F6hhbD001194;
        Wed, 15 Sep 2021 07:44:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=unRJE/2nGA8KSMmenuNrP/TykT9yg6kqUcCh+92+IYQ=;
 b=C57erIdoS72MwAU5x8uc36dsafJnnodzpKe1XsVqR1FVsu117koDcllNJvRuQgmMaImP
 WgNzDH7Oo7+cWi0QAuIxadymk/XdAcvJKK1LGjz+7Hk9n1IyKPb0J6zW7nJ3ujoX1wl0
 cze3KJ/u1fAex9N0cihYZef/wSchUlz1nC9nTOyj5gtkwbjqBlPmQYtr+nNZWGhBndTf
 f8xIkWgYxNQTUBWcrUZ4CJQAjdEd4c6kSIVYFQbzX/cNboknDwKZiRs2EWgy8i8aINcB
 hpDycYZW3vbOt8i+gIpM+q9Nm3BSmbFLuITjUw+T4B/AAShKzDi+/9WhT+rk0I+BoLoZ LQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3b3af8rc9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 15 Sep 2021 07:44:28 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 15 Sep
 2021 13:44:26 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 15 Sep 2021 13:44:26 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.203])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0784BB2F;
        Wed, 15 Sep 2021 12:44:26 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v4 1/2] regmap: spi: Set regmap max raw r/w from max_transfer_size
Date:   Wed, 15 Sep 2021 13:44:24 +0100
Message-ID: <20210915124425.34777-1-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: edplpCJo8GuEUzMWEpO7jk6G7_qhs3cX
X-Proofpoint-ORIG-GUID: edplpCJo8GuEUzMWEpO7jk6G7_qhs3cX
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set regmap raw read/write from spi max_transfer_size
so regmap_raw_read/write can split the access into chunks

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes v2:
New series

Changes v3:
None

Changes v4:
Reviewed-by Charles Keepax

 drivers/base/regmap/regmap-spi.c | 36 ++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-spi.c b/drivers/base/regmap/regmap-spi.c
index c1894e93c378..0e6552e57ecf 100644
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

