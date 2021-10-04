Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14414209CD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 13:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbhJDLRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 07:17:34 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:27097 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232458AbhJDLRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 07:17:30 -0400
X-IronPort-AV: E=Sophos;i="5.85,345,1624312800"; 
   d="scan'208";a="19847139"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 04 Oct 2021 13:15:38 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 04 Oct 2021 13:15:38 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 04 Oct 2021 13:15:38 +0200
X-IronPort-AV: E=Sophos;i="5.85,345,1624312800"; 
   d="scan'208";a="19847138"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 04 Oct 2021 13:15:38 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 84C30280075;
        Mon,  4 Oct 2021 13:15:38 +0200 (CEST)
From:   Alexander Stein <Alexander.Stein@tq-systems.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mtd: spi-nor: micron-st: Add support for output-driver-strength
Date:   Mon,  4 Oct 2021 13:15:29 +0200
Message-Id: <20211004111529.211089-2-Alexander.Stein@tq-systems.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004111529.211089-1-Alexander.Stein@tq-systems.com>
References: <20211004111529.211089-1-Alexander.Stein@tq-systems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Stein <alexander.stein@ew.tq-group.com>

Micron flashes support this by the Bits [2:0] in the Enhanced Volatile
Configuration Register.
Checked datasheets:
- n25q_128mb_3v_65nm.pdf
- mt25t-qljs-L512-xBA-xxT.pdf

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/mtd/spi-nor/micron-st.c | 109 ++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index c224e59820a1..5d5e7fbc24a2 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -16,6 +16,11 @@
 #define SPINOR_MT_OCT_DTR	0xe7	/* Enable Octal DTR. */
 #define SPINOR_MT_EXSPI		0xff	/* Enable Extended SPI (default) */
 
+struct micron_drive_strength {
+	u32 ohms;
+	u8 val;
+};
+
 static int spi_nor_micron_octal_dtr_enable(struct spi_nor *nor, bool enable)
 {
 	struct spi_mem_op op;
@@ -255,8 +260,112 @@ static void micron_st_default_init(struct spi_nor *nor)
 	nor->params->set_4byte_addr_mode = st_micron_set_4byte_addr_mode;
 }
 
+
+/*
+ * Read Micron enhanced volatile configuration register
+ * Return negative if error occurred or configuration register value
+ */
+static int micron_read_evcr(struct spi_nor *nor)
+{
+	int ret;
+
+	if (nor->spimem) {
+		struct spi_mem_op op =
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RD_EVCR, 1),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));
+
+		ret = spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RD_EVCR, nor->bouncebuf, 1);
+	}
+
+	if (ret < 0) {
+		dev_err(nor->dev, "error %d reading EVCR\n", ret);
+		return ret;
+	}
+
+	return nor->bouncebuf[0];
+}
+
+/*
+ * Write Micron enhanced volatile configuration register
+ * Return negative if error occurred or configuration register value
+ */
+static int micron_write_evcr(struct spi_nor *nor, u8 evcr)
+{
+	nor->bouncebuf[0] = evcr;
+
+	spi_nor_write_enable(nor);
+
+	if (nor->spimem) {
+		struct spi_mem_op op =
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WD_EVCR, 1),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
+
+		return spi_mem_exec_op(nor->spimem, &op);
+	}
+
+	return nor->controller_ops->write_reg(nor, SPINOR_OP_WD_EVCR, nor->bouncebuf, 1);
+}
+
+/*
+ * Supported values from Enahanced Volatile COnfiguration Register (Bits 2:0)
+ */
+static const struct micron_drive_strength drive_strength_data[] = {
+	{ .ohms = 90, .val = 1 },
+	{ .ohms = 45, .val = 3 },
+	{ .ohms = 20, .val = 5 },
+	{ .ohms = 30, .val = 7 },
+};
+
+static struct micron_drive_strength const *micron_st_find_drive_strength_entry(u32 ohms)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(drive_strength_data); i++) {
+		if (ohms == drive_strength_data[i].ohms)
+			return &drive_strength_data[i];
+	}
+	return NULL;
+}
+
+static void micron_st_post_sfdp(struct spi_nor *nor)
+{
+	struct device_node *np = spi_nor_get_flash_node(nor);
+	u32 ohms;
+
+	if (!np)
+		return;
+
+	if (!of_property_read_u32(np, "output-driver-strength", &ohms)) {
+		struct micron_drive_strength const *entry =
+			micron_st_find_drive_strength_entry(ohms);
+
+		if (entry) {
+			int evcrr = micron_read_evcr(nor);
+
+			if (evcrr >= 0) {
+				u8 evcr = (u8)(evcrr & 0xf8) | entry->val;
+
+				micron_write_evcr(nor, evcr);
+				dev_dbg(nor->dev, "%s: EVCR 0x%x\n", __func__,
+					(u32)micron_read_evcr(nor));
+			}
+		} else {
+			dev_warn(nor->dev,
+				"Invalid output-driver-strength property specified: %u",
+				ohms);
+		}
+	}
+}
+
 static const struct spi_nor_fixups micron_st_fixups = {
 	.default_init = micron_st_default_init,
+	.post_sfdp = micron_st_post_sfdp,
 };
 
 const struct spi_nor_manufacturer spi_nor_micron = {
-- 
2.25.1

