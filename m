Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFE832F931
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 10:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhCFJu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 04:50:28 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:37008 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhCFJuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 04:50:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615024217; x=1646560217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PsOk4rFOQ/dSpsD0csoV74Acj9W64l71Io7lHfbk35s=;
  b=aZ1mNUD8qAU+o16bWN1MMAzmgqsRKt1x4wsfJsCXmVkPhJvx/ZuG0RWQ
   wK1Hpf8INmlgDTqQtqDrkR7JlspFMYr5Q4MmZByU1vdP6mf6kGnyEFxrK
   TY1bafO60FuSrWz0wh0o0qj4WeI2A7rMWqasW3aen+QuXG8OKVBuYJleX
   fJQYUBn+ez5mCyCOH9VXTVDaWOVFfxsvzuzLjNpBQxepqReYfNdCqf8wi
   0/iCErDltvDfOS1U+u77tWjW3owQ3Uu0gYldD80Kvn0aMOtYiUaoRHtkc
   D+2OdM8uafrTQ5GIZygfYbft9DIWHYQ1f9ypNUbUxhSnf0WVzeuTFVxoa
   g==;
IronPort-SDR: beaBLT/sTFwrm0wRUJF4THNifrhUwWNAgdsSXhdKqFLcqkuMGFLR2SaYBXi9bzrLqKhNFfkuX3
 TmvM9tPnH/ubhrdWyDI/ngRA6Qera2O5YKO1294hNWhYc/2IiiQGlJizUN1gFZx6Lsl6W1PNaW
 VBarrF28OyS0cuD51rvOEyT/6r4UcDcOBNxdNjj1d1joHvGDjaKzzR4n6RLkPwXBZpOFQEYPsZ
 aSWXG1hsKh4lDDY6W7aFj/dI00U9SmsK61zmxFQw9xTb9T46DJR/9yMbrbzf7w8dpgWnsWHnv+
 Qo8=
X-IronPort-AV: E=Sophos;i="5.81,227,1610434800"; 
   d="scan'208";a="111726346"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Mar 2021 02:50:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 6 Mar 2021 02:50:16 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Sat, 6 Mar 2021 02:50:14 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vigneshr@ti.com>, <p.yadav@ti.com>, <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 3/5] mtd: spi-nor: Get rid of duplicated argument in spi_nor_parse_sfdp()
Date:   Sat, 6 Mar 2021 11:50:00 +0200
Message-ID: <20210306095002.22983-4-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210306095002.22983-1-tudor.ambarus@microchip.com>
References: <20210306095002.22983-1-tudor.ambarus@microchip.com>
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
v2: Add params local variable in spi_nor_parse_4bait(), because
params is used in multiple locations.

 drivers/mtd/spi-nor/core.c     | 10 ++---
 drivers/mtd/spi-nor/core.h     |  6 +--
 drivers/mtd/spi-nor/issi.c     |  3 +-
 drivers/mtd/spi-nor/macronix.c |  3 +-
 drivers/mtd/spi-nor/sfdp.c     | 72 +++++++++++++---------------------
 drivers/mtd/spi-nor/sfdp.h     |  3 +-
 drivers/mtd/spi-nor/spansion.c | 12 +++---
 drivers/mtd/spi-nor/winbond.c  |  3 +-
 8 files changed, 42 insertions(+), 70 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 498da1ec3a89..d12f14aba957 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2629,22 +2629,20 @@ void spi_nor_init_uniform_erase_map(struct spi_nor_erase_map *map,
 
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
@@ -2899,7 +2897,7 @@ static void spi_nor_sfdp_init_params(struct spi_nor *nor)
 
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
index 25142ec4737b..23c28e91f698 100644
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
@@ -889,8 +882,6 @@ spi_nor_init_non_uniform_erase_map(struct spi_nor *nor,
  * spi_nor_parse_smpt() - parse Sector Map Parameter Table
  * @nor:		pointer to a 'struct spi_nor'
  * @smpt_header:	sector map parameter table header
- * @params:		pointer to a duplicate 'struct spi_nor_flash_parameter'
- *                      that is used for storing SFDP parsed data
  *
  * This table is optional, but when available, we parse it to identify the
  * location and size of sectors within the main data array of the flash memory
@@ -899,8 +890,7 @@ spi_nor_init_non_uniform_erase_map(struct spi_nor *nor,
  * Return: 0 on success, -errno otherwise.
  */
 static int spi_nor_parse_smpt(struct spi_nor *nor,
-			      const struct sfdp_parameter_header *smpt_header,
-			      struct spi_nor_flash_parameter *params)
+			      const struct sfdp_parameter_header *smpt_header)
 {
 	const u32 *sector_map;
 	u32 *smpt;
@@ -928,11 +918,11 @@ static int spi_nor_parse_smpt(struct spi_nor *nor,
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
@@ -944,13 +934,11 @@ static int spi_nor_parse_smpt(struct spi_nor *nor,
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
@@ -974,6 +962,7 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
 		{ 0u /* not used */,		BIT(11) },
 		{ 0u /* not used */,		BIT(12) },
 	};
+	struct spi_nor_flash_parameter *params = nor->params;
 	struct spi_nor_pp_command *params_pp = params->page_programs;
 	struct spi_nor_erase_map *map = &params->erase_map;
 	struct spi_nor_erase_type *erase_type = map->erase_type;
@@ -1130,13 +1119,11 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
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
@@ -1160,14 +1147,14 @@ static int spi_nor_parse_profile1(struct spi_nor *nor,
 
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
@@ -1193,7 +1180,7 @@ static int spi_nor_parse_profile1(struct spi_nor *nor,
 	dummy = round_up(dummy, 2);
 
 	/* Update the fast read settings. */
-	spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8_8_8_DTR],
+	spi_nor_set_read_settings(&nor->params->reads[SNOR_CMD_READ_8_8_8_DTR],
 				  0, dummy, opcode,
 				  SNOR_PROTO_8_8_8_DTR);
 
@@ -1210,13 +1197,11 @@ static int spi_nor_parse_profile1(struct spi_nor *nor,
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
@@ -1245,8 +1230,6 @@ static int spi_nor_parse_sccr(struct spi_nor *nor,
 /**
  * spi_nor_parse_sfdp() - parse the Serial Flash Discoverable Parameters.
  * @nor:		pointer to a 'struct spi_nor'
- * @params:		pointer to the 'struct spi_nor_flash_parameter' to be
- *			filled
  *
  * The Serial Flash Discoverable Parameters are described by the JEDEC JESD216
  * specification. This is a standard which tends to supported by almost all
@@ -1256,8 +1239,7 @@ static int spi_nor_parse_sccr(struct spi_nor *nor,
  *
  * Return: 0 on success, -errno otherwise.
  */
-int spi_nor_parse_sfdp(struct spi_nor *nor,
-		       struct spi_nor_flash_parameter *params)
+int spi_nor_parse_sfdp(struct spi_nor *nor)
 {
 	const struct sfdp_parameter_header *param_header, *bfpt_header;
 	struct sfdp_parameter_header *param_headers = NULL;
@@ -1326,7 +1308,7 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
 			bfpt_header = param_header;
 	}
 
-	err = spi_nor_parse_bfpt(nor, bfpt_header, params);
+	err = spi_nor_parse_bfpt(nor, bfpt_header);
 	if (err)
 		goto exit;
 
@@ -1336,19 +1318,19 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
 
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

