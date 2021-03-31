Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C4B346184
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhCWOca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbhCWOcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:32:01 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBE8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 07:32:00 -0700 (PDT)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 82B692224E;
        Tue, 23 Mar 2021 15:31:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1616509915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lpNLWuEKx8dzJLcBJzIlBDq8ODHdrnJPwZUUHOCb5SQ=;
        b=M44WQAEA/IN6G35tg4Zgg8pMLYZaJKgBjxSxtDpuLE0/leLgP8SKGfzamXNx4Oyens59n0
        VrhFcQMVtwuy7eSITP37C5ZOEQrhTpN58f2/b8d/MnqNmCUspM9s4CqbI9y4euE3OFt/zG
        Al0BBoA0tyUTRZNyaarnOt3949qN4r0=
From:   Michael Walle <michael@walle.cc>
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 1/2] mtd: spi-nor: sfdp: save a copy of the SFDP data
Date:   Tue, 23 Mar 2021 15:31:43 +0100
Message-Id: <20210323143144.12730-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210323143144.12730-1-michael@walle.cc>
References: <20210323143144.12730-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to possible mode switching to 8D-8D-8D, it might not be possible to
read the SFDP after the initial probe. To be able to dump the SFDP via
sysfs afterwards, make a complete copy of it.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/core.h  | 10 +++++++
 drivers/mtd/spi-nor/sfdp.c  | 58 +++++++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h |  2 ++
 3 files changed, 70 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index db07832ee66c..08d2469837da 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -406,6 +406,16 @@ struct spi_nor_manufacturer {
 	const struct spi_nor_fixups *fixups;
 };
 
+/**
+ * struct sfdp - SFDP data
+ * @num_dwords: number of entries in the dwords array
+ * @dwords: array of double words of the SFDP data
+ */
+struct sfdp {
+	size_t	num_dwords;
+	u32	*dwords;
+};
+
 /* Manufacturer drivers. */
 extern const struct spi_nor_manufacturer spi_nor_atmel;
 extern const struct spi_nor_manufacturer spi_nor_catalyst;
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 23c28e91f698..c500c2118a5d 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -16,6 +16,7 @@
 	(((p)->parameter_table_pointer[2] << 16) | \
 	 ((p)->parameter_table_pointer[1] <<  8) | \
 	 ((p)->parameter_table_pointer[0] <<  0))
+#define SFDP_PARAM_HEADER_PARAM_LEN(p) ((p)->length * 4)
 
 #define SFDP_BFPT_ID		0xff00	/* Basic Flash Parameter Table */
 #define SFDP_SECTOR_MAP_ID	0xff81	/* Sector Map Table */
@@ -1245,6 +1246,8 @@ int spi_nor_parse_sfdp(struct spi_nor *nor)
 	struct sfdp_parameter_header *param_headers = NULL;
 	struct sfdp_header header;
 	struct device *dev = nor->dev;
+	struct sfdp *sfdp;
+	size_t sfdp_size;
 	size_t psize;
 	int i, err;
 
@@ -1267,6 +1270,9 @@ int spi_nor_parse_sfdp(struct spi_nor *nor)
 	    bfpt_header->major != SFDP_JESD216_MAJOR)
 		return -EINVAL;
 
+	sfdp_size = SFDP_PARAM_HEADER_PTP(bfpt_header) +
+		    SFDP_PARAM_HEADER_PARAM_LEN(bfpt_header);
+
 	/*
 	 * Allocate memory then read all parameter headers with a single
 	 * Read SFDP command. These parameter headers will actually be parsed
@@ -1293,6 +1299,58 @@ int spi_nor_parse_sfdp(struct spi_nor *nor)
 		}
 	}
 
+	/*
+	 * Cache the complete SFDP data. It is not (easily) possible to fetch
+	 * SFDP after probe time and we need it for the sysfs access.
+	 */
+	for (i = 0; i < header.nph; i++) {
+		param_header = &param_headers[i];
+		sfdp_size = max_t(size_t, sfdp_size,
+				  SFDP_PARAM_HEADER_PTP(param_header) +
+				  SFDP_PARAM_HEADER_PARAM_LEN(param_header));
+	}
+
+	/*
+	 * Limit the total size to a reasonable value to avoid allocating too
+	 * much memory just of because the flash returned some insane values.
+	 */
+	if (sfdp_size > PAGE_SIZE) {
+		dev_dbg(dev, "SFDP data (%zu) too big, truncating\n",
+			sfdp_size);
+		sfdp_size = PAGE_SIZE;
+	}
+
+	sfdp = devm_kzalloc(dev, sizeof(*sfdp), GFP_KERNEL);
+	if (!sfdp) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	/*
+	 * The SFDP is organized in chunks of DWORDs. Thus, in theory, the
+	 * sfdp_size should be a multiple of DWORDs. But in case a flash
+	 * is not spec compliant, make sure that we have enough space to store
+	 * the complete SFDP data.
+	 */
+	sfdp->num_dwords = DIV_ROUND_UP(sfdp_size, sizeof(*sfdp->dwords));
+	sfdp->dwords = devm_kcalloc(dev, sfdp->num_dwords,
+				    sizeof(*sfdp->dwords), GFP_KERNEL);
+	if (!sfdp->dwords) {
+		err = -ENOMEM;
+		devm_kfree(dev, sfdp);
+		goto exit;
+	}
+
+	err = spi_nor_read_sfdp(nor, 0, sfdp_size, sfdp->dwords);
+	if (err < 0) {
+		dev_dbg(dev, "failed to read SFDP data\n");
+		devm_kfree(dev, sfdp->dwords);
+		devm_kfree(dev, sfdp);
+		goto exit;
+	}
+
+	nor->sfdp = sfdp;
+
 	/*
 	 * Check other parameter headers to get the latest revision of
 	 * the basic flash parameter table.
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index a0d572855444..2215e3565422 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -375,6 +375,7 @@ struct spi_nor_flash_parameter;
  * @read_proto:		the SPI protocol for read operations
  * @write_proto:	the SPI protocol for write operations
  * @reg_proto:		the SPI protocol for read_reg/write_reg/erase operations
+ * @sfdp:		the SFDP data of the flash
  * @controller_ops:	SPI NOR controller driver specific operations.
  * @params:		[FLASH-SPECIFIC] SPI NOR flash parameters and settings.
  *                      The structure includes legacy flash parameters and
@@ -404,6 +405,7 @@ struct spi_nor {
 	bool			sst_write_second;
 	u32			flags;
 	enum spi_nor_cmd_ext	cmd_ext_type;
+	struct sfdp		*sfdp;
 
 	const struct spi_nor_controller_ops *controller_ops;
 
-- 
2.20.1

