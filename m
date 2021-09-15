Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBC740C584
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237805AbhIOMpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:45:52 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:41564 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237821AbhIOMpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:45:49 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FBPnvd025776;
        Wed, 15 Sep 2021 07:44:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=UloEvTbfEYNH3Z86cpJlpt08LgEbLvh9bAFrRSEG7Js=;
 b=Q3pveP1hhInAu4sgdogqfHmH5CX9FoE16RN/T0TgRUf9xDZpbMTOg3i0el/eeuQ19+FF
 De/eOa5YRXnga8kjUYP+yoyV1qcM8FW6gJkXKQ1XFmwFpsL9RaNHsNnCZShcpArpX1pq
 ARzaUeXKoKE7qe2pyOY02LAu/auw94qHx+rgypE/qjCCjCml/D/IJLmmDg4V+9JwSxer
 Zz6v4Xp9FV6CcLnPKIRyC2znz3oR4cs8LKL8DJlHYQ3h6GwYY2fWZEtOrwlOCDWlmYOm
 q9GROFN1/0YBtuY7kUyZ1btWptE2T8u5ua9x1Nfnj5GV7eqrRiywCWZYyxUqD2blR9NG 8g== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3b3287gsm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 15 Sep 2021 07:44:28 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 15 Sep
 2021 13:44:26 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 15 Sep 2021 13:44:26 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.203])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BBEAB11C6;
        Wed, 15 Sep 2021 12:44:26 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v4 2/2] regmap: spi: Check raw_[read|write] against max message size
Date:   Wed, 15 Sep 2021 13:44:25 +0100
Message-ID: <20210915124425.34777-2-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915124425.34777-1-tanureal@opensource.cirrus.com>
References: <20210915124425.34777-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: NREozzJq3ynENmoOVv7ztmPEbWAqhULM
X-Proofpoint-ORIG-GUID: NREozzJq3ynENmoOVv7ztmPEbWAqhULM
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regmap-spi will split data and address between two transfers
in the same message, so max_[read|write] must include space
for the address and padding

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---

Changes v3:
New series

Changes v4:
None

 drivers/base/regmap/regmap-spi.c |  4 ++++
 drivers/base/regmap/regmap.c     | 15 +++++++++++++++
 include/linux/regmap.h           |  3 +++
 3 files changed, 22 insertions(+)

diff --git a/drivers/base/regmap/regmap-spi.c b/drivers/base/regmap/regmap-spi.c
index 0e6552e57ecf..1434c502e340 100644
--- a/drivers/base/regmap/regmap-spi.c
+++ b/drivers/base/regmap/regmap-spi.c
@@ -123,6 +123,10 @@ static const struct regmap_bus *regmap_get_spi_bus(struct spi_device *spi,
 		bus->free_on_exit = true;
 		bus->max_raw_read = max_size;
 		bus->max_raw_write = max_size;
+
+		if (spi_max_message_size(spi) != SIZE_MAX)
+			bus->max_combined_rw = spi_max_message_size(spi);
+
 		return bus;
 	}
 
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 21a0c2562ec0..a99152f010f8 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -735,6 +735,7 @@ struct regmap *__regmap_init(struct device *dev,
 	struct regmap *map;
 	int ret = -EINVAL;
 	enum regmap_endian reg_endian, val_endian;
+	size_t reg_pad_size;
 	int i, j;
 
 	if (!config)
@@ -840,6 +841,20 @@ struct regmap *__regmap_init(struct device *dev,
 	if (bus) {
 		map->max_raw_read = bus->max_raw_read;
 		map->max_raw_write = bus->max_raw_write;
+		if (bus->max_combined_rw) {
+			reg_pad_size = map->format.reg_bytes + map->format.pad_bytes;
+
+			if (map->max_raw_read + reg_pad_size > bus->max_combined_rw)
+				map->max_raw_read -= reg_pad_size;
+			if (map->max_raw_write + reg_pad_size > bus->max_combined_rw)
+				map->max_raw_write -= reg_pad_size;
+
+			if (map->max_raw_read  < map->format.buf_size ||
+			    map->max_raw_write < map->format.buf_size) {
+				ret = -EINVAL;
+				goto err_hwlock;
+			}
+		}
 	}
 	map->dev = dev;
 	map->bus = bus;
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index e3c9a25a853a..a720f578b8e6 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -506,6 +506,8 @@ typedef void (*regmap_hw_free_context)(void *context);
  * @max_raw_read: Max raw read size that can be used on the bus.
  * @max_raw_write: Max raw write size that can be used on the bus.
  * @free_on_exit: kfree this on exit of regmap
+ * @max_combined_rw: Max size for raw_read + raw_write, when they are issued
+ *                   together as part of the same message
  */
 struct regmap_bus {
 	bool fast_io;
@@ -523,6 +525,7 @@ struct regmap_bus {
 	enum regmap_endian val_format_endian_default;
 	size_t max_raw_read;
 	size_t max_raw_write;
+	size_t max_combined_rw;
 	bool free_on_exit;
 };
 
-- 
2.33.0

