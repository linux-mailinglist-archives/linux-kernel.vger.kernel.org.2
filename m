Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA32D339718
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 20:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbhCLTGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 14:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbhCLTGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 14:06:06 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37965C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 11:06:06 -0800 (PST)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 18E5D22246;
        Fri, 12 Mar 2021 20:06:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1615575964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6+KxuP01OXn0P4BC96DpLPW6zDJBUCK1si/Mhm3vETY=;
        b=uFdxA+J9wKJe1up+L2tmP70GjgkcwqQqLn6rrQw8tKjaXfNZFxVMRY8Z1PPQepdLHJ6KU7
        M0qeo3lfCOZ22IQpR5UCM606r48VpNrIIVR0CK36y7J18Eik51gNtSQOHhF9uPqyOKDQQQ
        NOKXiEjw0U3gdEq8k8JoVnMrzWpom8w=
From:   Michael Walle <michael@walle.cc>
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [RFC PATCH 1/3] mtd: spi-nor: sfdp: remember sfdp_size
Date:   Fri, 12 Mar 2021 20:05:46 +0100
Message-Id: <20210312190548.6954-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210312190548.6954-1-michael@walle.cc>
References: <20210312190548.6954-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save the sftp_size in the spi_nor struct so we can use it to dump the
SFDP table without parsing the headers again.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/sfdp.c  | 12 ++++++++++++
 include/linux/mtd/spi-nor.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 25142ec4737b..b1814afefc33 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -16,6 +16,7 @@
 	(((p)->parameter_table_pointer[2] << 16) | \
 	 ((p)->parameter_table_pointer[1] <<  8) | \
 	 ((p)->parameter_table_pointer[0] <<  0))
+#define SFDP_PARAM_HEADER_PARAM_LEN(p) ((p)->length * 4)
 
 #define SFDP_BFPT_ID		0xff00	/* Basic Flash Parameter Table */
 #define SFDP_SECTOR_MAP_ID	0xff81	/* Sector Map Table */
@@ -1263,6 +1264,7 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
 	struct sfdp_parameter_header *param_headers = NULL;
 	struct sfdp_header header;
 	struct device *dev = nor->dev;
+	size_t param_max_offset;
 	size_t psize;
 	int i, err;
 
@@ -1285,6 +1287,9 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
 	    bfpt_header->major != SFDP_JESD216_MAJOR)
 		return -EINVAL;
 
+	nor->sfdp_size = SFDP_PARAM_HEADER_PTP(bfpt_header) +
+			 SFDP_PARAM_HEADER_PARAM_LEN(bfpt_header);
+
 	/*
 	 * Allocate memory then read all parameter headers with a single
 	 * Read SFDP command. These parameter headers will actually be parsed
@@ -1311,6 +1316,13 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
 		}
 	}
 
+	for (i = 0; i < header.nph; i++) {
+		param_header = &param_headers[i];
+		param_max_offset = SFDP_PARAM_HEADER_PTP(param_header) +
+				   SFDP_PARAM_HEADER_PARAM_LEN(param_header);
+		nor->sfdp_size = max(nor->sfdp_size, param_max_offset);
+	}
+
 	/*
 	 * Check other parameter headers to get the latest revision of
 	 * the basic flash parameter table.
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index a0d572855444..a58118b8b002 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -404,6 +404,7 @@ struct spi_nor {
 	bool			sst_write_second;
 	u32			flags;
 	enum spi_nor_cmd_ext	cmd_ext_type;
+	size_t			sfdp_size;
 
 	const struct spi_nor_controller_ops *controller_ops;
 
-- 
2.20.1

