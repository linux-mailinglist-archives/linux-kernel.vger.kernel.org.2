Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA7B3405D2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhCRMo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbhCRMoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:44:11 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E583C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:44:11 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so3077524pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 05:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IhGMHYMmcLeKrhiSxz8FXTAntRfx6etYiml4bVTAZK8=;
        b=LOtn5eEwtiV1zaBqABmHp/3o1br1Eel9swgd8xNI1ysAHBsMY2zvKSF7Hm9l4l/hK7
         U79gOvfgg6lIk0jRbzuMvnFl8i1Zm42INDUU6FzRdWDbuEO5rBrRyRPV23BH43GaqRb4
         ZgQ2pGobh7yCHThN0NaRRTL3KmMF3nQbJH3Itd5Q/zLnHlEw0DQzjsGcP/BS1EGV584A
         B87SptBeZRmqHhWi3zwV/0JAflz8ZATwVw9lYdM7kijZVrqolqlbMSbJ43/Dfxz2k13c
         ba6f1gNS+na89goRriUQfAyMQEQd5rtlQvvHMFzPl0XnlirVFxvgEcF4jo8cGkC4PrS6
         RTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IhGMHYMmcLeKrhiSxz8FXTAntRfx6etYiml4bVTAZK8=;
        b=M5XDq9A2HqGeKCbxrHJRjW/huOebVqJxMIwXeLrCpMwFdogyzCZbjMWHUwHpD2CUPc
         FKM2uB1ZVvJBCOp/av+cjaZ20wZoLCBEBNmnJl9qgSDVjtiQG7Es9fErcB+yu8cli9Gf
         J1X5EREAIDCHcq8AwW1Wpg2ZFXyp1xioGws/APPHeldReq6vDXxadHfRBWyPngSddH+B
         59eUSMqKroTCDFh57phAoD8ioOSSuZJp3Lqv+9Q/0TYfT6C0iXb0z59NiYonhXrsMFo9
         SgsaJgjXt06+7tHWKvhinACQp/4FBIEDikkiiNCgg1SGRgZpa/Z/CJCekionJFIoCmzr
         tfYw==
X-Gm-Message-State: AOAM530Jg9IxqoFM66aNlEm7mS+agx5KBuRfdea31XzPC9AgJ2LCbpY3
        jFqkVLyyEcNGmcYC/Bq4aW15
X-Google-Smtp-Source: ABdhPJwWhLMWXwHQwJGmwyBr6XF2pjRjpgL8zsWEsHhNHtdq0K6wt4IxAeCAX7CbjTS9j6lwXuKlPg==
X-Received: by 2002:a17:90b:344c:: with SMTP id lj12mr4347160pjb.208.1616071450780;
        Thu, 18 Mar 2021 05:44:10 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6d00:4737:af26:182c:a57e:1d9e])
        by smtp.gmail.com with ESMTPSA id w84sm2530694pfc.142.2021.03.18.05.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 05:44:10 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        boris.brezillon@collabora.com, Daniele.Palmas@telit.com,
        bjorn.andersson@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 3/3] mtd: rawnand: Add support for secure regions in NAND memory
Date:   Thu, 18 Mar 2021 18:13:42 +0530
Message-Id: <20210318124342.32745-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210318124342.32745-1-manivannan.sadhasivam@linaro.org>
References: <20210318124342.32745-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a typical end product, a vendor may choose to secure some regions in
the NAND memory which are supposed to stay intact between FW upgrades.
The access to those regions will be blocked by a secure element like
Trustzone. So the normal world software like Linux kernel should not
touch these regions (including reading).

The regions are declared using a NAND chip DT property,
"secure-regions". So let's make use of this property in the raw NAND
core and skip access to the secure regions present in a system.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/mtd/nand/raw/nand_base.c | 111 +++++++++++++++++++++++++++++++
 include/linux/mtd/rawnand.h      |   4 ++
 2 files changed, 115 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index c33fa1b1847f..d2958549ba46 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -278,11 +278,47 @@ static int nand_block_bad(struct nand_chip *chip, loff_t ofs)
 	return 0;
 }
 
+/**
+ * nand_check_secure_region() - Check if the region is secured
+ * @chip: NAND chip object
+ * @offset: Offset of the region to check
+ * @size: Size of the region to check
+ *
+ * Checks if the region is secured by comparing the offset and size with the
+ * list of secure regions obtained from DT. Returns -EIO if the region is
+ * secured else 0.
+ */
+static int nand_check_secure_region(struct nand_chip *chip, loff_t offset, u32 size)
+{
+	int i, j;
+
+	/* Skip touching the secure regions if present */
+	for (i = 0, j = 0; i < chip->nr_secure_regions; i++, j += 2) {
+		/* First compare the start offset */
+		if (offset >= chip->secure_regions[j] &&
+		    (offset < chip->secure_regions[j] + chip->secure_regions[j + 1]))
+			return -EIO;
+		/* ...then offset + size */
+		else if (offset < chip->secure_regions[i] &&
+			 (offset + size) >= chip->secure_regions[i])
+			return -EIO;
+	}
+
+	return 0;
+}
+
 static int nand_isbad_bbm(struct nand_chip *chip, loff_t ofs)
 {
+	int ret;
+
 	if (chip->options & NAND_NO_BBM_QUIRK)
 		return 0;
 
+	/* Check if the region is secured */
+	ret = nand_check_secure_region(chip, ofs, 0);
+	if (ret)
+		return ret;
+
 	if (chip->legacy.block_bad)
 		return chip->legacy.block_bad(chip, ofs);
 
@@ -397,6 +433,11 @@ static int nand_do_write_oob(struct nand_chip *chip, loff_t to,
 		return -EINVAL;
 	}
 
+	/* Check if the region is secured */
+	ret = nand_check_secure_region(chip, to, ops->ooblen);
+	if (ret)
+		return ret;
+
 	chipnr = (int)(to >> chip->chip_shift);
 
 	/*
@@ -565,6 +606,11 @@ static int nand_block_isreserved(struct mtd_info *mtd, loff_t ofs)
 
 	if (!chip->bbt)
 		return 0;
+
+	/* Check if the region is secured */
+	if (nand_check_secure_region(chip, ofs, 0))
+		return -EIO;
+
 	/* Return info from the table */
 	return nand_isreserved_bbt(chip, ofs);
 }
@@ -2737,6 +2783,11 @@ static int nand_read_page_swecc(struct nand_chip *chip, uint8_t *buf,
 	uint8_t *ecc_code = chip->ecc.code_buf;
 	unsigned int max_bitflips = 0;
 
+	/* Check if the region is secured */
+	ret = nand_check_secure_region(chip, ((loff_t)page << chip->page_shift), 0);
+	if (ret)
+		return ret;
+
 	chip->ecc.read_page_raw(chip, buf, 1, page);
 
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize)
@@ -3127,6 +3178,11 @@ static int nand_do_read_ops(struct nand_chip *chip, loff_t from,
 	int retry_mode = 0;
 	bool ecc_fail = false;
 
+	/* Check if the region is secured */
+	ret = nand_check_secure_region(chip, from, readlen);
+	if (ret)
+		return ret;
+
 	chipnr = (int)(from >> chip->chip_shift);
 	nand_select_target(chip, chipnr);
 
@@ -3458,6 +3514,11 @@ static int nand_do_read_oob(struct nand_chip *chip, loff_t from,
 	pr_debug("%s: from = 0x%08Lx, len = %i\n",
 			__func__, (unsigned long long)from, readlen);
 
+	/* Check if the region is secured */
+	ret = nand_check_secure_region(chip, from, readlen);
+	if (ret)
+		return ret;
+
 	stats = mtd->ecc_stats;
 
 	len = mtd_oobavail(mtd, ops);
@@ -3709,6 +3770,11 @@ static int nand_write_page_swecc(struct nand_chip *chip, const uint8_t *buf,
 	uint8_t *ecc_calc = chip->ecc.calc_buf;
 	const uint8_t *p = buf;
 
+	/* Check if the region is secured */
+	ret = nand_check_secure_region(chip, ((loff_t)page << chip->page_shift), 0);
+	if (ret)
+		return ret;
+
 	/* Software ECC calculation */
 	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize)
 		chip->ecc.calculate(chip, p, &ecc_calc[i]);
@@ -3979,6 +4045,11 @@ static int nand_do_write_ops(struct nand_chip *chip, loff_t to,
 		return -EINVAL;
 	}
 
+	/* Check if the region is secured */
+	ret = nand_check_secure_region(chip, to, writelen);
+	if (ret)
+		return ret;
+
 	column = to & (mtd->writesize - 1);
 
 	chipnr = (int)(to >> chip->chip_shift);
@@ -4180,6 +4251,11 @@ int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
 	if (check_offs_len(chip, instr->addr, instr->len))
 		return -EINVAL;
 
+	/* Check if the region is secured */
+	ret = nand_check_secure_region(chip, instr->addr, len);
+	if (ret)
+		return ret;
+
 	/* Grab the lock and see if the device is available */
 	ret = nand_get_device(chip);
 	if (ret)
@@ -4995,10 +5071,32 @@ static bool of_get_nand_on_flash_bbt(struct device_node *np)
 	return of_property_read_bool(np, "nand-on-flash-bbt");
 }
 
+static int of_get_nand_secure_regions(struct nand_chip *chip)
+{
+	struct device_node *dn = nand_get_flash_node(chip);
+	struct property *prop;
+	int length, nr_elem;
+
+	prop = of_find_property(dn, "secure-regions", &length);
+	if (prop) {
+		nr_elem = length / sizeof(u64);
+		chip->nr_secure_regions = nr_elem / 2;
+
+		chip->secure_regions = kcalloc(nr_elem, sizeof(*chip->secure_regions), GFP_KERNEL);
+		if (!chip->secure_regions)
+			return -ENOMEM;
+
+		of_property_read_u64_array(dn, "secure-regions", chip->secure_regions, nr_elem);
+	}
+
+	return 0;
+}
+
 static int rawnand_dt_init(struct nand_chip *chip)
 {
 	struct nand_device *nand = mtd_to_nanddev(nand_to_mtd(chip));
 	struct device_node *dn = nand_get_flash_node(chip);
+	int ret;
 
 	if (!dn)
 		return 0;
@@ -5015,6 +5113,16 @@ static int rawnand_dt_init(struct nand_chip *chip)
 	of_get_nand_ecc_user_config(nand);
 	of_get_nand_ecc_legacy_user_config(chip);
 
+	/*
+	 * Look for secure regions in the NAND chip. These regions are supposed
+	 * to be protected by a secure element like Trustzone. So the read/write
+	 * accesses to these regions will be blocked in the runtime by this
+	 * driver.
+	 */
+	ret = of_get_nand_secure_regions(chip);
+	if (!ret)
+		return ret;
+
 	/*
 	 * If neither the user nor the NAND controller have requested a specific
 	 * ECC engine type, we will default to NAND_ECC_ENGINE_TYPE_ON_HOST.
@@ -6068,6 +6176,9 @@ void nand_cleanup(struct nand_chip *chip)
 	/* Free manufacturer priv data. */
 	nand_manufacturer_cleanup(chip);
 
+	/* Free secure regions data */
+	kfree(chip->secure_regions);
+
 	/* Free controller specific allocations after chip identification */
 	nand_detach(chip);
 
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 6b3240e44310..d385c4fe8b0f 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1086,6 +1086,8 @@ struct nand_manufacturer {
  *          NAND Controller drivers should not modify this value, but they're
  *          allowed to read it.
  * @read_retries: The number of read retry modes supported
+ * @secure_regions: Array representing the secure regions
+ * @nr_secure_regions: Number of secure regions
  * @controller: The hardware controller	structure which is shared among multiple
  *              independent devices
  * @ecc: The ECC controller structure
@@ -1135,6 +1137,8 @@ struct nand_chip {
 	unsigned int suspended : 1;
 	int cur_cs;
 	int read_retries;
+	u64 *secure_regions;
+	u8 nr_secure_regions;
 
 	/* Externals */
 	struct nand_controller *controller;
-- 
2.25.1

