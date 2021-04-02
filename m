Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD64352C17
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 18:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbhDBPCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 11:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbhDBPCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 11:02:02 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E33C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 08:02:01 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id a12so3760429pfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 08:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TWYjwlYcBYFHfUi9Dwn7UiPrXNJjNafuVdBu7SMjuLE=;
        b=Vcs11hphs/nAkTxbteqUdyb/TCjrnE6RuKPNSVv/H2Rxzv3nU/+DgtFAQVphphlfWq
         TBrfNLVOf9hQAZwbx4zH8DobquGhESg1j8A/3jr6EXwHSUB0W12gGwWOyzaOu92i7OuJ
         p/D6/JlUQezFIMkYN2OjkYh1NDx1SYuvC8YWu4F95oLdFAWmpD/WZsR3Fp4khKLy9viT
         kaq5Aavwtsa+EJ0kNy+1T4HPIayK3kg3EcWm5byshsGznXRFgJK5hudD9GEzSoesc8w+
         C9xHedw0iLLRD9QzP9O+b6lJhqShnpjI2A+P4qY6EmFTHZwLce54E2Ev9R1zXjmkFKnQ
         57ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TWYjwlYcBYFHfUi9Dwn7UiPrXNJjNafuVdBu7SMjuLE=;
        b=JF/8haqMkvzbYrmCyImGRXHST5glo7liJndu3ffuSau5AbwMlkx23WQfzbCuJAQMwe
         10lMrWATNVCmzlMhs8XWR9utyn2Xn2AuZxDfttLbkdcrqvhKXnMOVnN8OSflIOmTP/F3
         buNZB2Zj0grXnKox9KGBixwdtsM4uxLQ8gERVCBzIXmvKVYjUbvv4hSi2G/KJVi3RGh0
         zXILeiXB08zKSoDZxJpgAjnzdN6qE5oThYpLHhAATi3XEuMCup2//gvbmUzs7YK6xu67
         EfmkSzDogJ/+TPNlfpEa99s0hZO7qCGQxQHDhrNEgOrYvwO71kuuqwW6Pe7OOsioeb7B
         1sfA==
X-Gm-Message-State: AOAM5334jhiGBPrheAbeI7YuULws3XmJM7ruK7ExYQHOY6F+HjrNjFBz
        Bb7RiVVKbSPVO1NzWWs/FL/Y
X-Google-Smtp-Source: ABdhPJzX/i8ORxhI8yF2rjOztMSJLQRi9LByTEwcHhybDbPqaP6dQOSO7Uka6tJzaAKA993VlDo2KA==
X-Received: by 2002:a63:510f:: with SMTP id f15mr12223126pgb.390.1617375720468;
        Fri, 02 Apr 2021 08:02:00 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.174])
        by smtp.gmail.com with ESMTPSA id x7sm8773647pff.12.2021.04.02.08.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 08:01:59 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        boris.brezillon@collabora.com, Daniele.Palmas@telit.com,
        bjorn.andersson@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v11 3/4] mtd: rawnand: Add support for secure regions in NAND memory
Date:   Fri,  2 Apr 2021 20:31:27 +0530
Message-Id: <20210402150128.29128-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210402150128.29128-1-manivannan.sadhasivam@linaro.org>
References: <20210402150128.29128-1-manivannan.sadhasivam@linaro.org>
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
 drivers/mtd/nand/raw/nand_base.c | 100 ++++++++++++++++++++++++++++++-
 include/linux/mtd/rawnand.h      |  14 +++++
 2 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index c33fa1b1847f..132ce73df76b 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -278,11 +278,48 @@ static int nand_block_bad(struct nand_chip *chip, loff_t ofs)
 	return 0;
 }
 
+/**
+ * nand_region_is_secured() - Check if the region is secured
+ * @chip: NAND chip object
+ * @offset: Offset of the region to check
+ * @size: Size of the region to check
+ *
+ * Checks if the region is secured by comparing the offset and size with the
+ * list of secure regions obtained from DT. Returns true if the region is
+ * secured else false.
+ */
+static bool nand_region_is_secured(struct nand_chip *chip, loff_t offset, u64 size)
+{
+	int i;
+
+	/* Skip touching the secure regions if present */
+	for (i = 0; i < chip->nr_secure_regions; i++) {
+		const struct nand_secure_region *region = &chip->secure_regions[i];
+
+		if (offset + size <= region->offset ||
+		    offset >= region->offset + region->size)
+			continue;
+
+		pr_debug("%s: Region 0x%llx - 0x%llx is secured!",
+			 __func__, offset, offset + size);
+
+		return true;
+	}
+
+	return false;
+}
+
 static int nand_isbad_bbm(struct nand_chip *chip, loff_t ofs)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
 	if (chip->options & NAND_NO_BBM_QUIRK)
 		return 0;
 
+	/* Check if the region is secured */
+	if (nand_region_is_secured(chip, ofs, mtd->erasesize))
+		return -EIO;
+
 	if (chip->legacy.block_bad)
 		return chip->legacy.block_bad(chip, ofs);
 
@@ -397,6 +434,10 @@ static int nand_do_write_oob(struct nand_chip *chip, loff_t to,
 		return -EINVAL;
 	}
 
+	/* Check if the region is secured */
+	if (nand_region_is_secured(chip, to, ops->ooblen))
+		return -EIO;
+
 	chipnr = (int)(to >> chip->chip_shift);
 
 	/*
@@ -3127,6 +3168,10 @@ static int nand_do_read_ops(struct nand_chip *chip, loff_t from,
 	int retry_mode = 0;
 	bool ecc_fail = false;
 
+	/* Check if the region is secured */
+	if (nand_region_is_secured(chip, from, readlen))
+		return -EIO;
+
 	chipnr = (int)(from >> chip->chip_shift);
 	nand_select_target(chip, chipnr);
 
@@ -3458,6 +3503,10 @@ static int nand_do_read_oob(struct nand_chip *chip, loff_t from,
 	pr_debug("%s: from = 0x%08Lx, len = %i\n",
 			__func__, (unsigned long long)from, readlen);
 
+	/* Check if the region is secured */
+	if (nand_region_is_secured(chip, from, readlen))
+		return -EIO;
+
 	stats = mtd->ecc_stats;
 
 	len = mtd_oobavail(mtd, ops);
@@ -3979,6 +4028,10 @@ static int nand_do_write_ops(struct nand_chip *chip, loff_t to,
 		return -EINVAL;
 	}
 
+	/* Check if the region is secured */
+	if (nand_region_is_secured(chip, to, writelen))
+		return -EIO;
+
 	column = to & (mtd->writesize - 1);
 
 	chipnr = (int)(to >> chip->chip_shift);
@@ -4180,6 +4233,10 @@ int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
 	if (check_offs_len(chip, instr->addr, instr->len))
 		return -EINVAL;
 
+	/* Check if the region is secured */
+	if (nand_region_is_secured(chip, instr->addr, instr->len))
+		return -EIO;
+
 	/* Grab the lock and see if the device is available */
 	ret = nand_get_device(chip);
 	if (ret)
@@ -4995,6 +5052,31 @@ static bool of_get_nand_on_flash_bbt(struct device_node *np)
 	return of_property_read_bool(np, "nand-on-flash-bbt");
 }
 
+static int of_get_nand_secure_regions(struct nand_chip *chip)
+{
+	struct device_node *dn = nand_get_flash_node(chip);
+	int nr_elem, i, j;
+
+	nr_elem = of_property_count_elems_of_size(dn, "secure-regions", sizeof(u64));
+	if (!nr_elem)
+		return 0;
+
+	chip->nr_secure_regions = nr_elem / 2;
+	chip->secure_regions = kcalloc(chip->nr_secure_regions, sizeof(*chip->secure_regions),
+				       GFP_KERNEL);
+	if (!chip->secure_regions)
+		return -ENOMEM;
+
+	for (i = 0, j = 0; i < chip->nr_secure_regions; i++, j += 2) {
+		of_property_read_u64_index(dn, "secure-regions", j,
+					   &chip->secure_regions[i].offset);
+		of_property_read_u64_index(dn, "secure-regions", j + 1,
+					   &chip->secure_regions[i].size);
+	}
+
+	return 0;
+}
+
 static int rawnand_dt_init(struct nand_chip *chip)
 {
 	struct nand_device *nand = mtd_to_nanddev(nand_to_mtd(chip));
@@ -5953,6 +6035,16 @@ static int nand_scan_tail(struct nand_chip *chip)
 			goto err_free_interface_config;
 	}
 
+	/*
+	 * Look for secure regions in the NAND chip. These regions are supposed
+	 * to be protected by a secure element like Trustzone. So the read/write
+	 * accesses to these regions will be blocked in the runtime by this
+	 * driver.
+	 */
+	ret = of_get_nand_secure_regions(chip);
+	if (ret)
+		goto err_free_interface_config;
+
 	/* Check, if we should skip the bad block table scan */
 	if (chip->options & NAND_SKIP_BBTSCAN)
 		return 0;
@@ -5960,10 +6052,13 @@ static int nand_scan_tail(struct nand_chip *chip)
 	/* Build bad block table */
 	ret = nand_create_bbt(chip);
 	if (ret)
-		goto err_free_interface_config;
+		goto err_free_secure_regions;
 
 	return 0;
 
+err_free_secure_regions:
+	kfree(chip->secure_regions);
+
 err_free_interface_config:
 	kfree(chip->best_interface_config);
 
@@ -6051,6 +6146,9 @@ void nand_cleanup(struct nand_chip *chip)
 
 	nanddev_cleanup(&chip->base);
 
+	/* Free secure regions data */
+	kfree(chip->secure_regions);
+
 	/* Free bad block table memory */
 	kfree(chip->bbt);
 	kfree(chip->data_buf);
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 6b3240e44310..17ddc900a1dc 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1036,6 +1036,16 @@ struct nand_manufacturer {
 	void *priv;
 };
 
+/**
+ * struct nand_secure_region - NAND secure region structure
+ * @offset: Offset of the start of the secure region
+ * @size: Size of the secure region
+ */
+struct nand_secure_region {
+	u64 offset;
+	u64 size;
+};
+
 /**
  * struct nand_chip - NAND Private Flash Chip Data
  * @base: Inherit from the generic NAND device
@@ -1086,6 +1096,8 @@ struct nand_manufacturer {
  *          NAND Controller drivers should not modify this value, but they're
  *          allowed to read it.
  * @read_retries: The number of read retry modes supported
+ * @secure_regions: Structure containing the secure regions info
+ * @nr_secure_regions: Number of secure regions
  * @controller: The hardware controller	structure which is shared among multiple
  *              independent devices
  * @ecc: The ECC controller structure
@@ -1135,6 +1147,8 @@ struct nand_chip {
 	unsigned int suspended : 1;
 	int cur_cs;
 	int read_retries;
+	struct nand_secure_region *secure_regions;
+	u8 nr_secure_regions;
 
 	/* Externals */
 	struct nand_controller *controller;
-- 
2.25.1

