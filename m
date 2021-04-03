Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABF53532C9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 08:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbhDCGJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 02:09:39 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:26505 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhDCGJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 02:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617430176; x=1648966176;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S6cdx9nJCphR+TuZTRATBfbVh4GtEZJtm8NrOBPj77k=;
  b=LT6xA9spCl+mpP5KQy8KeukHy80vrO9YnQlOZz/OoeK4AU1mkvdqtQws
   4k1Zst5G6mxS+MNWnrtWlzDP9jqg07SMcR8ZOULCDiLoWHEU3/rNm2vu8
   eT92xGxZhV4ys1dwva+WNU91O75LXvgthSm37dboNEmdvypNCjp5LmrcR
   ubqbr2wtyiwZGxz7Fn4U2F22mE9pLOj4vfHpZbfKrDapnqsbxfX5u3Yr5
   2jYgDjSopU05f28tgClOBAFV/HiCOPpx56Os0anhWhWJKiGGTcqdlC0hv
   xY83fuRSR71hj/eDfbJW7d/OkzfIy4vAPxugM5yCPhvWQY2lMILeJMADh
   w==;
IronPort-SDR: tDiyfH90o6toY1GOMttHv1wU3XvcfgGv/YjWKlCw3xhQqWsL3wMW6VPxQ6S/u8aSzSWxJgaFvj
 q8Lyuw1/8vn7whAfQS2jGdq89CUb92Jhp8Av+Vnlg5a1nwok1abFyNgo0+ixGqg1d2+zAHqiQr
 LUi+Uh1I1HrFssyNxo9tYn9iP88lrBmxZTgYUmTO/s2YQ4NzLTos/p8LzcgsOF+4b6ha1cIln+
 5+2lakB/o0wAS9z0T6IVJK2QDHCDXAvCIViM+ZRD+uC3hICAlyT4NBVVko5VVdyd1AzZcjG1r4
 FE4=
X-IronPort-AV: E=Sophos;i="5.81,302,1610434800"; 
   d="scan'208";a="115168349"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Apr 2021 23:09:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 2 Apr 2021 23:09:35 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 2 Apr 2021 23:09:33 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <kyungmin.park@samsung.com>
CC:     <michael@walle.cc>, <p.yadav@ti.com>, <jean-philippe@linaro.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH] mtd: core: Constify buf in mtd_write_user_prot_reg()
Date:   Sat, 3 Apr 2021 09:09:31 +0300
Message-ID: <20210403060931.7119-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The write buffer comes from user and should be const.
Constify write buffer in mtd core and across all _write_user_prot_reg()
users. cfi_cmdset_{0001, 0002} and onenand_base will pay the cost of an
explicit cast to discard the const qualifier since the beginning, since
they are using an otp_op_t function prototype that is used for both reads
and writes. mtd_dataflash and SPI NOR will benefit of the const buffer
because they are using different paths for writes and reads.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/chips/cfi_cmdset_0001.c     | 7 ++++---
 drivers/mtd/chips/cfi_cmdset_0002.c     | 6 +++---
 drivers/mtd/devices/mtd_dataflash.c     | 2 +-
 drivers/mtd/mtdcore.c                   | 2 +-
 drivers/mtd/nand/onenand/onenand_base.c | 5 +++--
 drivers/mtd/spi-nor/core.h              | 6 ++++--
 drivers/mtd/spi-nor/otp.c               | 9 +++++----
 include/linux/mtd/mtd.h                 | 5 +++--
 8 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/chips/cfi_cmdset_0001.c b/drivers/mtd/chips/cfi_cmdset_0001.c
index 42001c49833b..87f29c84bea9 100644
--- a/drivers/mtd/chips/cfi_cmdset_0001.c
+++ b/drivers/mtd/chips/cfi_cmdset_0001.c
@@ -72,7 +72,8 @@ static int cfi_intelext_is_locked(struct mtd_info *mtd, loff_t ofs,
 #ifdef CONFIG_MTD_OTP
 static int cfi_intelext_read_fact_prot_reg (struct mtd_info *, loff_t, size_t, size_t *, u_char *);
 static int cfi_intelext_read_user_prot_reg (struct mtd_info *, loff_t, size_t, size_t *, u_char *);
-static int cfi_intelext_write_user_prot_reg (struct mtd_info *, loff_t, size_t, size_t *, u_char *);
+static int cfi_intelext_write_user_prot_reg(struct mtd_info *, loff_t, size_t,
+					    size_t *, const u_char *);
 static int cfi_intelext_lock_user_prot_reg (struct mtd_info *, loff_t, size_t);
 static int cfi_intelext_get_fact_prot_info(struct mtd_info *, size_t,
 					   size_t *, struct otp_info *);
@@ -2447,10 +2448,10 @@ static int cfi_intelext_read_user_prot_reg(struct mtd_info *mtd, loff_t from,
 
 static int cfi_intelext_write_user_prot_reg(struct mtd_info *mtd, loff_t from,
 					    size_t len, size_t *retlen,
-					     u_char *buf)
+					    const u_char *buf)
 {
 	return cfi_intelext_otp_walk(mtd, from, len, retlen,
-				     buf, do_otp_write, 1);
+				     (u_char *)buf, do_otp_write, 1);
 }
 
 static int cfi_intelext_lock_user_prot_reg(struct mtd_info *mtd,
diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
index a1f3e1031c3d..46fac266ceb8 100644
--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -80,7 +80,7 @@ static int cfi_amdstd_read_fact_prot_reg(struct mtd_info *, loff_t, size_t,
 static int cfi_amdstd_read_user_prot_reg(struct mtd_info *, loff_t, size_t,
 					 size_t *, u_char *);
 static int cfi_amdstd_write_user_prot_reg(struct mtd_info *, loff_t, size_t,
-					  size_t *, u_char *);
+					  size_t *, const u_char *);
 static int cfi_amdstd_lock_user_prot_reg(struct mtd_info *, loff_t, size_t);
 
 static int cfi_amdstd_panic_write(struct mtd_info *mtd, loff_t to, size_t len,
@@ -1630,9 +1630,9 @@ static int cfi_amdstd_read_user_prot_reg(struct mtd_info *mtd, loff_t from,
 
 static int cfi_amdstd_write_user_prot_reg(struct mtd_info *mtd, loff_t from,
 					  size_t len, size_t *retlen,
-					  u_char *buf)
+					  const u_char *buf)
 {
-	return cfi_amdstd_otp_walk(mtd, from, len, retlen, buf,
+	return cfi_amdstd_otp_walk(mtd, from, len, retlen, (u_char *)buf,
 				   do_otp_write, 1);
 }
 
diff --git a/drivers/mtd/devices/mtd_dataflash.c b/drivers/mtd/devices/mtd_dataflash.c
index 6d1eefe94106..9802e265fca8 100644
--- a/drivers/mtd/devices/mtd_dataflash.c
+++ b/drivers/mtd/devices/mtd_dataflash.c
@@ -527,7 +527,7 @@ static int dataflash_read_user_otp(struct mtd_info *mtd,
 }
 
 static int dataflash_write_user_otp(struct mtd_info *mtd,
-		loff_t from, size_t len, size_t *retlen, u_char *buf)
+		loff_t from, size_t len, size_t *retlen, const u_char *buf)
 {
 	struct spi_message	m;
 	const size_t		l = 4 + 64;
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 2d6423d89a17..0c02789e94b6 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1884,7 +1884,7 @@ int mtd_read_user_prot_reg(struct mtd_info *mtd, loff_t from, size_t len,
 EXPORT_SYMBOL_GPL(mtd_read_user_prot_reg);
 
 int mtd_write_user_prot_reg(struct mtd_info *mtd, loff_t to, size_t len,
-			    size_t *retlen, u_char *buf)
+			    size_t *retlen, const u_char *buf)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
 	int ret;
diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
index a9fdea26ea46..958bac54b190 100644
--- a/drivers/mtd/nand/onenand/onenand_base.c
+++ b/drivers/mtd/nand/onenand/onenand_base.c
@@ -3167,9 +3167,10 @@ static int onenand_read_user_prot_reg(struct mtd_info *mtd, loff_t from,
  * Write user OTP area.
  */
 static int onenand_write_user_prot_reg(struct mtd_info *mtd, loff_t from,
-			size_t len, size_t *retlen, u_char *buf)
+			size_t len, size_t *retlen, const u_char *buf)
 {
-	return onenand_otp_walk(mtd, from, len, retlen, buf, do_otp_write, MTD_OTP_USER);
+	return onenand_otp_walk(mtd, from, len, retlen, (u_char *)buf,
+				do_otp_write, MTD_OTP_USER);
 }
 
 /**
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index e9b6b2e76cdb..28a2e0be97a3 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -211,7 +211,8 @@ struct spi_nor_otp_organization {
  */
 struct spi_nor_otp_ops {
 	int (*read)(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf);
-	int (*write)(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf);
+	int (*write)(struct spi_nor *nor, loff_t addr, size_t len,
+		     const u8 *buf);
 	int (*lock)(struct spi_nor *nor, unsigned int region);
 	int (*is_locked)(struct spi_nor *nor, unsigned int region);
 };
@@ -504,7 +505,8 @@ ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
 			   const u8 *buf);
 
 int spi_nor_otp_read_secr(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf);
-int spi_nor_otp_write_secr(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf);
+int spi_nor_otp_write_secr(struct spi_nor *nor, loff_t addr, size_t len,
+			   const u8 *buf);
 int spi_nor_otp_lock_sr2(struct spi_nor *nor, unsigned int region);
 int spi_nor_otp_is_locked_sr2(struct spi_nor *nor, unsigned int region);
 
diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
index 5021d40dffbf..fcf38d260345 100644
--- a/drivers/mtd/spi-nor/otp.c
+++ b/drivers/mtd/spi-nor/otp.c
@@ -70,7 +70,8 @@ int spi_nor_otp_read_secr(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf)
  *
  * Return: number of bytes written successfully, -errno otherwise
  */
-int spi_nor_otp_write_secr(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf)
+int spi_nor_otp_write_secr(struct spi_nor *nor, loff_t addr, size_t len,
+			   const u8 *buf)
 {
 	enum spi_nor_protocol write_proto;
 	struct spi_mem_dirmap_desc *wdesc;
@@ -241,7 +242,7 @@ static int spi_nor_mtd_otp_info(struct mtd_info *mtd, size_t len,
 
 static int spi_nor_mtd_otp_read_write(struct mtd_info *mtd, loff_t ofs,
 				      size_t total_len, size_t *retlen,
-				      u8 *buf, bool is_write)
+				      const u8 *buf, bool is_write)
 {
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
 	const struct spi_nor_otp_ops *ops = nor->params->otp.ops;
@@ -285,7 +286,7 @@ static int spi_nor_mtd_otp_read_write(struct mtd_info *mtd, loff_t ofs,
 		if (is_write)
 			ret = ops->write(nor, rstart + rofs, len, buf);
 		else
-			ret = ops->read(nor, rstart + rofs, len, buf);
+			ret = ops->read(nor, rstart + rofs, len, (u8 *)buf);
 		if (ret == 0)
 			ret = -EIO;
 		if (ret < 0)
@@ -310,7 +311,7 @@ static int spi_nor_mtd_otp_read(struct mtd_info *mtd, loff_t from, size_t len,
 }
 
 static int spi_nor_mtd_otp_write(struct mtd_info *mtd, loff_t to, size_t len,
-				 size_t *retlen, u8 *buf)
+				 size_t *retlen, const u8 *buf)
 {
 	return spi_nor_mtd_otp_read_write(mtd, to, len, retlen, buf, true);
 }
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 157357ec1441..7a1806962fc5 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -333,7 +333,8 @@ struct mtd_info {
 	int (*_read_user_prot_reg) (struct mtd_info *mtd, loff_t from,
 				    size_t len, size_t *retlen, u_char *buf);
 	int (*_write_user_prot_reg) (struct mtd_info *mtd, loff_t to,
-				     size_t len, size_t *retlen, u_char *buf);
+				     size_t len, size_t *retlen,
+				     const u_char *buf);
 	int (*_lock_user_prot_reg) (struct mtd_info *mtd, loff_t from,
 				    size_t len);
 	int (*_writev) (struct mtd_info *mtd, const struct kvec *vecs,
@@ -515,7 +516,7 @@ int mtd_get_user_prot_info(struct mtd_info *mtd, size_t len, size_t *retlen,
 int mtd_read_user_prot_reg(struct mtd_info *mtd, loff_t from, size_t len,
 			   size_t *retlen, u_char *buf);
 int mtd_write_user_prot_reg(struct mtd_info *mtd, loff_t to, size_t len,
-			    size_t *retlen, u_char *buf);
+			    size_t *retlen, const u_char *buf);
 int mtd_lock_user_prot_reg(struct mtd_info *mtd, loff_t from, size_t len);
 
 int mtd_writev(struct mtd_info *mtd, const struct kvec *vecs,
-- 
2.25.1

