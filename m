Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905EE39B687
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 12:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhFDKE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 06:04:56 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:45893 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhFDKEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 06:04:51 -0400
Received: from mwalle01.fritz.box (ip4d17858c.dynamic.kabel-deutschland.de [77.23.133.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DDBE12224F;
        Fri,  4 Jun 2021 12:03:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1622800984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kt4yiaInnmJeaGkE/MPYgei4muQd1jn/4Uq7TKm1ceo=;
        b=s5gDsHN1cHhYbtdUp1fJxvZ6xKbFmmUlz6nIoBpG4a4LuzOuUUFWfJZB1SbXpzs+R//nsw
        uyejZ+Du9Z9x7sNLZzznvCJiPV3QFPo+3e6Bt232XIz3uMCqkwd+ZLRO5/13VcLZ/vGbYp
        sY5Va3n618gKwABX/PxjX8KVzHOOfDk=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v5 3/5] mtd: spi-nor: otp: return -EROFS if region is read-only
Date:   Fri,  4 Jun 2021 12:02:50 +0200
Message-Id: <20210604100252.9975-4-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210604100252.9975-1-michael@walle.cc>
References: <20210604100252.9975-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI NOR flashes will just ignore program commands if the OTP region is
locked. Thus, a user might not notice that the intended write didn't end
up in the flash. Return -EROFS to the user in this case. From what I can
tell, chips/cfi_cmdset_0001.c also return this error code.

One could optimize spi_nor_mtd_otp_range_is_locked() to read the status
register only once and not for every OTP region, but for that we would
need some more invasive changes. Given that this is
one-time-programmable memory and the normal access mode is reading, we
just live with the small overhead.

Fixes: 069089acf88b ("mtd: spi-nor: add OTP support")
Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/otp.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
index 3898ed67ba1c..063f8fb68649 100644
--- a/drivers/mtd/spi-nor/otp.c
+++ b/drivers/mtd/spi-nor/otp.c
@@ -249,6 +249,32 @@ static int spi_nor_mtd_otp_info(struct mtd_info *mtd, size_t len,
 	return ret;
 }
 
+static int spi_nor_mtd_otp_range_is_locked(struct spi_nor *nor, loff_t ofs,
+					   size_t len)
+{
+	const struct spi_nor_otp_ops *ops = nor->params->otp.ops;
+	unsigned int region;
+	int locked;
+
+	if (!len)
+		return 0;
+
+	/*
+	 * If any of the affected OTP regions are locked the entire range is
+	 * considered locked.
+	 */
+	for (region = spi_nor_otp_offset_to_region(nor, ofs);
+	     region <= spi_nor_otp_offset_to_region(nor, ofs + len - 1);
+	     region++) {
+		locked = ops->is_locked(nor, region);
+		/* take the branch it is locked or in case of an error */
+		if (locked)
+			return locked;
+	}
+
+	return 0;
+}
+
 static int spi_nor_mtd_otp_read_write(struct mtd_info *mtd, loff_t ofs,
 				      size_t total_len, size_t *retlen,
 				      const u8 *buf, bool is_write)
@@ -271,6 +297,16 @@ static int spi_nor_mtd_otp_read_write(struct mtd_info *mtd, loff_t ofs,
 	/* don't access beyond the end */
 	total_len = min_t(size_t, total_len, spi_nor_otp_size(nor) - ofs);
 
+	if (is_write) {
+		ret = spi_nor_mtd_otp_range_is_locked(nor, ofs, total_len);
+		if (ret < 0) {
+			goto out;
+		} else if (ret) {
+			ret = -EROFS;
+			goto out;
+		}
+	}
+
 	*retlen = 0;
 	while (total_len) {
 		/*
-- 
2.20.1

