Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A09C343AEC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 08:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCVHxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 03:53:02 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:40063 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhCVHw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 03:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1616399546; x=1647935546;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ABEJG5RkSChbcetRBk6+q1bGur85qi1KrJf4/KyP+XE=;
  b=lOQTouVG1VREOZ7Llsg+qiyWLh0941g9q8+MHJvHlc/pU97AbXe4ZRZ5
   jVVZahp9ZjbTnbJbWLPLPfWAmM9oRo/TVdaBPzBmUehlrs5/olaMlJelU
   7ir6D0I0j6dU222TWDHS3SXnLVx0AWPUHYAgmizEFb6vNLH1lROIN8ZUm
   RO1HigAV2H9Seyic6Ueliye6IMUdKOgNMGOs8qF+JvqNGzBeAMZyW1by/
   5CzGhMky9dpdimBsuGYVPTQCnZyCBb9B+uM/LaWHgFjOOXSkDqBhPBxcb
   OjQaANbA3NaSe1rl5K0HMmJDTbsuPUENmUNL92kO0raNjv8tTJgeSRC+A
   g==;
IronPort-SDR: Yg9nL2mIDLCuNQX7JiGNkr9BNx5Ep2gnzyBfbRgx6KUblfoMwfHOV9vpEkO5ozL5kc5yw3pDkw
 JKB2sHSVTdfI+S6s9d/Ea1UTFo9uHrrAC2ye/BK3nxPw3qYokAy92G1v0W1FkcdOkG+C0tIQ/I
 brhtVMGT0Jx053UBvvl4nUyTalfPnEX15yI4iyKdoUyOYLhXQZ9MuFPi8qwVlRqGb4TRaA+AB3
 uFIJYtNUO8bqLgG5SmCEsdQhS+s2LOwH0iWSRhStuDU2zNzKvl65Nl0o3mMP9j8vPnO+Ei6Mjm
 hYw=
X-IronPort-AV: E=Sophos;i="5.81,268,1610434800"; 
   d="scan'208";a="113597886"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Mar 2021 00:51:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 22 Mar 2021 00:51:40 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 22 Mar 2021 00:51:38 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vigneshr@ti.com>, <michael@walle.cc>, <p.yadav@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v3 2/2] mtd: spi-nor: swp: Improve code around spi_nor_check_lock_status_sr()
Date:   Mon, 22 Mar 2021 09:51:31 +0200
Message-ID: <20210322075131.45093-3-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210322075131.45093-1-tudor.ambarus@microchip.com>
References: <20210322075131.45093-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- bool return value for spi_nor_check_lock_status_sr(), gets rid of
  the return 1,
- introduce temporary variables for better readability.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
v3: new patch

 drivers/mtd/spi-nor/swp.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/spi-nor/swp.c b/drivers/mtd/spi-nor/swp.c
index 5b236db6bb56..8594bcbb7dbe 100644
--- a/drivers/mtd/spi-nor/swp.c
+++ b/drivers/mtd/spi-nor/swp.c
@@ -81,36 +81,39 @@ static void spi_nor_get_locked_range_sr(struct spi_nor *nor, u8 sr, loff_t *ofs,
 }
 
 /*
- * Return 1 if the entire region is locked (if @locked is true) or unlocked (if
- * @locked is false); 0 otherwise
+ * Return true if the entire region is locked (if @locked is true) or unlocked
+ * (if @locked is false); false otherwise.
  */
-static int spi_nor_check_lock_status_sr(struct spi_nor *nor, loff_t ofs,
-					uint64_t len, u8 sr, bool locked)
+static bool spi_nor_check_lock_status_sr(struct spi_nor *nor, loff_t ofs,
+					 uint64_t len, u8 sr, bool locked)
 {
-	loff_t lock_offs;
+	loff_t lock_offs, lock_offs_max, offs_max;
 	uint64_t lock_len;
 
 	if (!len)
-		return 1;
+		return true;
 
 	spi_nor_get_locked_range_sr(nor, sr, &lock_offs, &lock_len);
 
+	lock_offs_max = lock_offs + lock_len;
+	offs_max = ofs + len;
+
 	if (locked)
 		/* Requested range is a sub-range of locked range */
-		return (ofs + len <= lock_offs + lock_len) && (ofs >= lock_offs);
+		return (offs_max <= lock_offs_max) && (ofs >= lock_offs);
 	else
 		/* Requested range does not overlap with locked range */
-		return (ofs >= lock_offs + lock_len) || (ofs + len <= lock_offs);
+		return (ofs >= lock_offs_max) || (offs_max <= lock_offs);
 }
 
-static int spi_nor_is_locked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
-				u8 sr)
+static bool spi_nor_is_locked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
+				 u8 sr)
 {
 	return spi_nor_check_lock_status_sr(nor, ofs, len, sr, true);
 }
 
-static int spi_nor_is_unlocked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
-				  u8 sr)
+static bool spi_nor_is_unlocked_sr(struct spi_nor *nor, loff_t ofs,
+				   uint64_t len, u8 sr)
 {
 	return spi_nor_check_lock_status_sr(nor, ofs, len, sr, false);
 }
-- 
2.25.1

