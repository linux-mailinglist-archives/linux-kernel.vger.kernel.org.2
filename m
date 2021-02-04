Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012A430FA24
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 18:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238713AbhBDRrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 12:47:17 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:6219 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237445AbhBDRqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:46:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612460799; x=1643996799;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pjBtbcoHDMSA0wjp+bsOxgmYsDoIS2N7/JQLbQ5pRx4=;
  b=Eg3YoA1IfAE8Vv8G/5rYKtL019OOMmYKFr0+vJQP4NMy62fOdrl2e6PO
   wNfJ1Na2gxLK+w6+eWQ7IrNo5DZElMPk2OHSI9bHq4npVY5yVRIbBTW3A
   bxHydKWUI9z5F0Peo3jFd91nB1xl9KEUsl8Wxsq3pX9tXwUu67RWYeFnB
   ClOBHyXGkRTJz8fr0LKZzVuCSE8fcq9MwwNfPfY5Y12nGo7GHTU2ANwXu
   fqG7SVB83DpZNbW2XZEM3Rb70/TAngA66v8a+J6bOR/OBYDqNot1NyJDU
   1bEWSoFfWjw3LBGBnKR+Y4uuwmzxUL2yTJBNHXRyiRS5bKxiFwTEXGa6+
   w==;
IronPort-SDR: fsYAYtW05pmaaqDNfF+3SXYWOjS5ES6UNGAphkbBn1RP1E/lFR9xLj0WNUZYpSyZn/svyjG5lf
 T/bP0ZuOUc14cj9y/FQs0jEqX5rsBuJg2R9bK+FeQv+820BYn3xdLeMo5nf0jgQi39ype73VtF
 wBqvkFz1RqJ6lubgxMTH5MpymMWY3yu7TBOIaVAVp+ramPGU+gFQRBL4+IoTXECE/ylNL7d21S
 rZlzn1TTm48HBQRuGlSVnk0AZ3HUMzHkvP7h8MhL8yXzsfIOgax3A3WLFIynywJKC1MRs6Z9My
 /EQ=
X-IronPort-AV: E=Sophos;i="5.81,152,1610434800"; 
   d="scan'208";a="108052498"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Feb 2021 10:45:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 4 Feb 2021 10:45:11 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 4 Feb 2021 10:45:10 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH] mtd: spi-nor: Get rid of duplicated argument in spi_nor_parse_sfdp()
Date:   Thu, 4 Feb 2021 19:45:07 +0200
Message-ID: <20210204174507.593419-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spi_nor_parse_sfdp(nor, nor->params);
passes for the second argument a member within the first argument.
Drop the second argument and obtain it directly from the first,
and do it across all the children functions. This is a follow up for
'commit 69a8eed58cc0 ("mtd: spi-nor: Don't copy self-pointing struct around")'

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.c     | 10 ++--
 drivers/mtd/spi-nor/core.h     |  6 +--
 drivers/mtd/spi-nor/issi.c     |  3 +-
 drivers/mtd/spi-nor/macronix.c |  3 +-
 drivers/mtd/spi-nor/sfdp.c     | 87 +++++++++++++---------------------
 drivers/mtd/spi-nor/sfdp.h     |  3 +-
 drivers/mtd/spi-nor/spansion.c | 12 ++---
 drivers/mtd/spi-nor/winbond.c  |  3 +-
 8 files changed, 49 insertions(+), 78 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index c50b30fbb912..2b3b977626af 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2624,22 +2624,20 @@ void spi_nor_init_uniform_erase_map(struct spi_nor_erase_map *map,
 
 int spi_nor_post_bfpt_fixups(struct spi_nor *nor,
 			     const struct sfdp_parameter_header *bfpt_header,
-			     const struct sfdp_bfpt *bfpt,
-			     struct spi_nor_flash_parameter *params)
+			     const struct sfdp_bfpt *bfpt)
 {
 	int ret;
 
 	if (nor->manufacturer && nor->manufacturer->fixups &&
 	    nor->manufacturer->fixups->post_bfpt) {
 		ret = nor->manufacturer->fixups->post_bfpt(nor, bfpt_header,
-							   bfpt, params);
+							   bfpt);
 		if (ret)
 			return ret;
 	}
 
 	if (nor->info->fixups && nor->info->fixups->post_bfpt)
-		return nor->info->fixups->post_bfpt(nor, bfpt_header, bfpt,
-						    params);
+		return nor->info->fixups->post_bfpt(nor, bfpt_header, bfpt);
 
 	return 0;
 }
@@ -2894,7 +2892,7 @@ static void spi_nor_sfdp_init_params(struct spi_nor *nor)
 
 	memcpy(&sfdp_params, nor->params, sizeof(sfdp_params));
 
-	if (spi_nor_parse_sfdp(nor, nor->params)) {
+	if (spi_nor_parse_sfdp(nor)) {
 		memcpy(nor->params, &sfdp_params, sizeof(*nor->params));
 		nor->addr_width = 0;
 		nor->flags &= ~SNOR_F_4B_OPCODES;
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 4a3f7f150b5d..db07832ee66c 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -261,8 +261,7 @@ struct spi_nor_fixups {
 	void (*default_init)(struct spi_nor *nor);
 	int (*post_bfpt)(struct spi_nor *nor,
 			 const struct sfdp_parameter_header *bfpt_header,
-			 const struct sfdp_bfpt *bfpt,
-			 struct spi_nor_flash_parameter *params);
+			 const struct sfdp_bfpt *bfpt);
 	void (*post_sfdp)(struct spi_nor *nor);
 };
 
@@ -470,8 +469,7 @@ void spi_nor_init_uniform_erase_map(struct spi_nor_erase_map *map,
 
 int spi_nor_post_bfpt_fixups(struct spi_nor *nor,
 			     const struct sfdp_parameter_header *bfpt_header,
-			     const struct sfdp_bfpt *bfpt,
-			     struct spi_nor_flash_parameter *params);
+			     const struct sfdp_bfpt *bfpt);
 
 static struct spi_nor __maybe_unused *mtd_to_spi_nor(struct mtd_info *mtd)
 {
diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index ffcb60e54a80..1e5bb5408b68 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -11,8 +11,7 @@
 static int
 is25lp256_post_bfpt_fixups(struct spi_nor *nor,
 			   const struct sfdp_parameter_header *bfpt_header,
-			   const struct sfdp_bfpt *bfpt,
-			   struct spi_nor_flash_parameter *params)
+			   const struct sfdp_bfpt *bfpt)
 {
 	/*
 	 * IS25LP256 supports 4B opcodes, but the BFPT advertises a
diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 9203abaac229..6c2680b4cdad 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -11,8 +11,7 @@
 static int
 mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
 			    const struct sfdp_parameter_header *bfpt_header,
-			    const struct sfdp_bfpt *bfpt,
-			    struct spi_nor_flash_parameter *params)
+			    const struct sfdp_bfpt *bfpt)
 {
 	/*
 	 * MX25L25635F supports 4B opcodes but MX25L25635E does not.
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 6ee7719e5903..f6fe38ea000f 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -405,8 +405,6 @@ static void spi_nor_regions_sort_erase_types(struct spi_nor_erase_map *map)
  * @nor:		pointer to a 'struct spi_nor'
  * @bfpt_header:	pointer to the 'struct sfdp_parameter_header' describing
  *			the Basic Flash Parameter Table length and version
- * @params:		pointer to the 'struct spi_nor_flash_parameter' to be
- *			filled
  *
  * The Basic Flash Parameter Table is the main and only mandatory table as
  * defined by the SFDP (JESD216) specification.
@@ -431,9 +429,9 @@ static void spi_nor_regions_sort_erase_types(struct spi_nor_erase_map *map)
  * Return: 0 on success, -errno otherwise.
  */
 static int spi_nor_parse_bfpt(struct spi_nor *nor,
-			      const struct sfdp_parameter_header *bfpt_header,
-			      struct spi_nor_flash_parameter *params)
+			      const struct sfdp_parameter_header *bfpt_header)
 {
+	struct spi_nor_flash_parameter *params = nor->params;
 	struct spi_nor_erase_map *map = &params->erase_map;
 	struct spi_nor_erase_type *erase_type = map->erase_type;
 	struct sfdp_bfpt bfpt;
@@ -552,8 +550,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 
 	/* Stop here if not JESD216 rev A or later. */
 	if (bfpt_header->length == BFPT_DWORD_MAX_JESD216)
-		return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt,
-						params);
+		return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt);
 
 	/* Page size: this field specifies 'N' so the page size = 2^N bytes. */
 	val = bfpt.dwords[BFPT_DWORD(11)];
@@ -614,8 +611,8 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 
 	/* Stop here if not JESD216 rev C or later. */
 	if (bfpt_header->length == BFPT_DWORD_MAX_JESD216B)
-		return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt,
-						params);
+		return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt);
+
 	/* 8D-8D-8D command extension. */
 	switch (bfpt.dwords[BFPT_DWORD(18)] & BFPT_DWORD18_CMD_EXT_MASK) {
 	case BFPT_DWORD18_CMD_EXT_REP:
@@ -635,7 +632,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 		return -EOPNOTSUPP;
 	}
 
-	return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt, params);
+	return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt);
 }
 
 /**
@@ -800,18 +797,14 @@ spi_nor_region_check_overlay(struct spi_nor_erase_region *region,
 /**
  * spi_nor_init_non_uniform_erase_map() - initialize the non-uniform erase map
  * @nor:	pointer to a 'struct spi_nor'
- * @params:     pointer to a duplicate 'struct spi_nor_flash_parameter' that is
- *              used for storing SFDP parsed data
  * @smpt:	pointer to the sector map parameter table
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int
-spi_nor_init_non_uniform_erase_map(struct spi_nor *nor,
-				   struct spi_nor_flash_parameter *params,
-				   const u32 *smpt)
+static int spi_nor_init_non_uniform_erase_map(struct spi_nor *nor,
+					      const u32 *smpt)
 {
-	struct spi_nor_erase_map *map = &params->erase_map;
+	struct spi_nor_erase_map *map = &nor->params->erase_map;
 	struct spi_nor_erase_type *erase = map->erase_type;
 	struct spi_nor_erase_region *region;
 	u64 offset;
@@ -890,8 +883,6 @@ spi_nor_init_non_uniform_erase_map(struct spi_nor *nor,
  * spi_nor_parse_smpt() - parse Sector Map Parameter Table
  * @nor:		pointer to a 'struct spi_nor'
  * @smpt_header:	sector map parameter table header
- * @params:		pointer to a duplicate 'struct spi_nor_flash_parameter'
- *                      that is used for storing SFDP parsed data
  *
  * This table is optional, but when available, we parse it to identify the
  * location and size of sectors within the main data array of the flash memory
@@ -900,8 +891,7 @@ spi_nor_init_non_uniform_erase_map(struct spi_nor *nor,
  * Return: 0 on success, -errno otherwise.
  */
 static int spi_nor_parse_smpt(struct spi_nor *nor,
-			      const struct sfdp_parameter_header *smpt_header,
-			      struct spi_nor_flash_parameter *params)
+			      const struct sfdp_parameter_header *smpt_header)
 {
 	const u32 *sector_map;
 	u32 *smpt;
@@ -929,11 +919,11 @@ static int spi_nor_parse_smpt(struct spi_nor *nor,
 		goto out;
 	}
 
-	ret = spi_nor_init_non_uniform_erase_map(nor, params, sector_map);
+	ret = spi_nor_init_non_uniform_erase_map(nor, sector_map);
 	if (ret)
 		goto out;
 
-	spi_nor_regions_sort_erase_types(&params->erase_map);
+	spi_nor_regions_sort_erase_types(&nor->params->erase_map);
 	/* fall through */
 out:
 	kfree(smpt);
@@ -945,13 +935,11 @@ static int spi_nor_parse_smpt(struct spi_nor *nor,
  * @nor:		pointer to a 'struct spi_nor'.
  * @param_header:	pointer to the 'struct sfdp_parameter_header' describing
  *			the 4-Byte Address Instruction Table length and version.
- * @params:		pointer to the 'struct spi_nor_flash_parameter' to be.
  *
  * Return: 0 on success, -errno otherwise.
  */
 static int spi_nor_parse_4bait(struct spi_nor *nor,
-			       const struct sfdp_parameter_header *param_header,
-			       struct spi_nor_flash_parameter *params)
+			       const struct sfdp_parameter_header *param_header)
 {
 	static const struct sfdp_4bait reads[] = {
 		{ SNOR_HWCAPS_READ,		BIT(0) },
@@ -975,8 +963,8 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
 		{ 0u /* not used */,		BIT(11) },
 		{ 0u /* not used */,		BIT(12) },
 	};
-	struct spi_nor_pp_command *params_pp = params->page_programs;
-	struct spi_nor_erase_map *map = &params->erase_map;
+	struct spi_nor_pp_command *params_pp = nor->params->page_programs;
+	struct spi_nor_erase_map *map = &nor->params->erase_map;
 	struct spi_nor_erase_type *erase_type = map->erase_type;
 	u32 *dwords;
 	size_t len;
@@ -1013,7 +1001,7 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
 		const struct sfdp_4bait *read = &reads[i];
 
 		discard_hwcaps |= read->hwcaps;
-		if ((params->hwcaps.mask & read->hwcaps) &&
+		if ((nor->params->hwcaps.mask & read->hwcaps) &&
 		    (dwords[0] & read->supported_bit))
 			read_hwcaps |= read->hwcaps;
 	}
@@ -1029,8 +1017,8 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
 		/*
 		 * The 4 Byte Address Instruction (Optional) Table is the only
 		 * SFDP table that indicates support for Page Program Commands.
-		 * Bypass the params->hwcaps.mask and consider 4BAIT the biggest
-		 * authority for specifying Page Program support.
+		 * Bypass the nor->params->hwcaps.mask and consider 4BAIT the
+		 * biggest authority for specifying Page Program support.
 		 */
 		discard_hwcaps |= program->hwcaps;
 		if (dwords[0] & program->supported_bit)
@@ -1064,12 +1052,12 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
 	 * Discard all operations from the 4-byte instruction set which are
 	 * not supported by this memory.
 	 */
-	params->hwcaps.mask &= ~discard_hwcaps;
-	params->hwcaps.mask |= (read_hwcaps | pp_hwcaps);
+	nor->params->hwcaps.mask &= ~discard_hwcaps;
+	nor->params->hwcaps.mask |= (read_hwcaps | pp_hwcaps);
 
 	/* Use the 4-byte address instruction set. */
 	for (i = 0; i < SNOR_CMD_READ_MAX; i++) {
-		struct spi_nor_read_command *read_cmd = &params->reads[i];
+		struct spi_nor_read_command *read_cmd = &nor->params->reads[i];
 
 		read_cmd->opcode = spi_nor_convert_3to4_read(read_cmd->opcode);
 	}
@@ -1131,13 +1119,11 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
  * @nor:		pointer to a 'struct spi_nor'
  * @profile1_header:	pointer to the 'struct sfdp_parameter_header' describing
  *			the Profile 1.0 Table length and version.
- * @params:		pointer to the 'struct spi_nor_flash_parameter' to be.
  *
  * Return: 0 on success, -errno otherwise.
  */
 static int spi_nor_parse_profile1(struct spi_nor *nor,
-				  const struct sfdp_parameter_header *profile1_header,
-				  struct spi_nor_flash_parameter *params)
+				  const struct sfdp_parameter_header *profile1_header)
 {
 	u32 *dwords, addr;
 	size_t len;
@@ -1161,14 +1147,14 @@ static int spi_nor_parse_profile1(struct spi_nor *nor,
 
 	 /* Set the Read Status Register dummy cycles and dummy address bytes. */
 	if (dwords[0] & PROFILE1_DWORD1_RDSR_DUMMY)
-		params->rdsr_dummy = 8;
+		nor->params->rdsr_dummy = 8;
 	else
-		params->rdsr_dummy = 4;
+		nor->params->rdsr_dummy = 4;
 
 	if (dwords[0] & PROFILE1_DWORD1_RDSR_ADDR_BYTES)
-		params->rdsr_addr_nbytes = 4;
+		nor->params->rdsr_addr_nbytes = 4;
 	else
-		params->rdsr_addr_nbytes = 0;
+		nor->params->rdsr_addr_nbytes = 0;
 
 	/*
 	 * We don't know what speed the controller is running at. Find the
@@ -1194,7 +1180,7 @@ static int spi_nor_parse_profile1(struct spi_nor *nor,
 	dummy = round_up(dummy, 2);
 
 	/* Update the fast read settings. */
-	spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8_8_8_DTR],
+	spi_nor_set_read_settings(&nor->params->reads[SNOR_CMD_READ_8_8_8_DTR],
 				  0, dummy, opcode,
 				  SNOR_PROTO_8_8_8_DTR);
 
@@ -1211,13 +1197,11 @@ static int spi_nor_parse_profile1(struct spi_nor *nor,
  * @nor:		pointer to a 'struct spi_nor'
  * @sccr_header:	pointer to the 'struct sfdp_parameter_header' describing
  *			the SCCR Map table length and version.
- * @params:		pointer to the 'struct spi_nor_flash_parameter' to be.
  *
  * Return: 0 on success, -errno otherwise.
  */
 static int spi_nor_parse_sccr(struct spi_nor *nor,
-			      const struct sfdp_parameter_header *sccr_header,
-			      struct spi_nor_flash_parameter *params)
+			      const struct sfdp_parameter_header *sccr_header)
 {
 	u32 *dwords, addr;
 	size_t len;
@@ -1246,8 +1230,6 @@ static int spi_nor_parse_sccr(struct spi_nor *nor,
 /**
  * spi_nor_parse_sfdp() - parse the Serial Flash Discoverable Parameters.
  * @nor:		pointer to a 'struct spi_nor'
- * @params:		pointer to the 'struct spi_nor_flash_parameter' to be
- *			filled
  *
  * The Serial Flash Discoverable Parameters are described by the JEDEC JESD216
  * specification. This is a standard which tends to supported by almost all
@@ -1257,8 +1239,7 @@ static int spi_nor_parse_sccr(struct spi_nor *nor,
  *
  * Return: 0 on success, -errno otherwise.
  */
-int spi_nor_parse_sfdp(struct spi_nor *nor,
-		       struct spi_nor_flash_parameter *params)
+int spi_nor_parse_sfdp(struct spi_nor *nor)
 {
 	const struct sfdp_parameter_header *param_header, *bfpt_header;
 	struct sfdp_parameter_header *param_headers = NULL;
@@ -1327,7 +1308,7 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
 			bfpt_header = param_header;
 	}
 
-	err = spi_nor_parse_bfpt(nor, bfpt_header, params);
+	err = spi_nor_parse_bfpt(nor, bfpt_header);
 	if (err)
 		goto exit;
 
@@ -1337,19 +1318,19 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
 
 		switch (SFDP_PARAM_HEADER_ID(param_header)) {
 		case SFDP_SECTOR_MAP_ID:
-			err = spi_nor_parse_smpt(nor, param_header, params);
+			err = spi_nor_parse_smpt(nor, param_header);
 			break;
 
 		case SFDP_4BAIT_ID:
-			err = spi_nor_parse_4bait(nor, param_header, params);
+			err = spi_nor_parse_4bait(nor, param_header);
 			break;
 
 		case SFDP_PROFILE1_ID:
-			err = spi_nor_parse_profile1(nor, param_header, params);
+			err = spi_nor_parse_profile1(nor, param_header);
 			break;
 
 		case SFDP_SCCR_MAP_ID:
-			err = spi_nor_parse_sccr(nor, param_header, params);
+			err = spi_nor_parse_sccr(nor, param_header);
 			break;
 
 		default:
diff --git a/drivers/mtd/spi-nor/sfdp.h b/drivers/mtd/spi-nor/sfdp.h
index 89152ae1cf3e..bbf80d2990ab 100644
--- a/drivers/mtd/spi-nor/sfdp.h
+++ b/drivers/mtd/spi-nor/sfdp.h
@@ -107,7 +107,6 @@ struct sfdp_parameter_header {
 	u8		id_msb;
 };
 
-int spi_nor_parse_sfdp(struct spi_nor *nor,
-		       struct spi_nor_flash_parameter *params);
+int spi_nor_parse_sfdp(struct spi_nor *nor);
 
 #endif /* __LINUX_MTD_SFDP_H */
diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index b0c5521c1e27..ee82dcd75310 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -142,8 +142,7 @@ static void s28hs512t_post_sfdp_fixup(struct spi_nor *nor)
 
 static int s28hs512t_post_bfpt_fixup(struct spi_nor *nor,
 				     const struct sfdp_parameter_header *bfpt_header,
-				     const struct sfdp_bfpt *bfpt,
-				     struct spi_nor_flash_parameter *params)
+				     const struct sfdp_bfpt *bfpt)
 {
 	/*
 	 * The BFPT table advertises a 512B page size but the page size is
@@ -162,9 +161,9 @@ static int s28hs512t_post_bfpt_fixup(struct spi_nor *nor,
 		return ret;
 
 	if (nor->bouncebuf[0] & SPINOR_REG_CYPRESS_CFR3V_PGSZ)
-		params->page_size = 512;
+		nor->params->page_size = 512;
 	else
-		params->page_size = 256;
+		nor->params->page_size = 256;
 
 	return 0;
 }
@@ -178,8 +177,7 @@ static struct spi_nor_fixups s28hs512t_fixups = {
 static int
 s25fs_s_post_bfpt_fixups(struct spi_nor *nor,
 			 const struct sfdp_parameter_header *bfpt_header,
-			 const struct sfdp_bfpt *bfpt,
-			 struct spi_nor_flash_parameter *params)
+			 const struct sfdp_bfpt *bfpt)
 {
 	/*
 	 * The S25FS-S chip family reports 512-byte pages in BFPT but
@@ -187,7 +185,7 @@ s25fs_s_post_bfpt_fixups(struct spi_nor *nor,
 	 * of 256 bytes.  Overwrite the page size advertised by BFPT
 	 * to get the writes working.
 	 */
-	params->page_size = 256;
+	nor->params->page_size = 256;
 
 	return 0;
 }
diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index e5dfa786f190..5d5240fb9a32 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -11,8 +11,7 @@
 static int
 w25q256_post_bfpt_fixups(struct spi_nor *nor,
 			 const struct sfdp_parameter_header *bfpt_header,
-			 const struct sfdp_bfpt *bfpt,
-			 struct spi_nor_flash_parameter *params)
+			 const struct sfdp_bfpt *bfpt)
 {
 	/*
 	 * W25Q256JV supports 4B opcodes but W25Q256FV does not.
-- 
2.25.1

