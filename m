Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB2B38CE4C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 21:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239176AbhEUTmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 15:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238752AbhEUTmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 15:42:06 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C45EC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 12:40:43 -0700 (PDT)
Received: from mwalle01.fritz.box (ip4d17858c.dynamic.kabel-deutschland.de [77.23.133.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 10E5C2224D;
        Fri, 21 May 2021 21:40:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1621626041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lHMyTZdZYGFCfpxbJqufZ+ZEIdyellslKI2X2YDC1ek=;
        b=XhB04tg7x8514cPGn3YDl32zCn7fiG1OZt2Y6GFGsBLNpLyU6Okm0q/pdaHh7iSquoFtzH
        HODebK5t3W0yhl9ALy5mr5m+icmdwnI+Tuhgfj3eL+Lrc+wzbFUDR7ZFX0UW+aKd883t0+
        25X3Kf6LtxB7refDkZoAa0LVPqK9ErQ=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v4 3/4] mtd: spi-nor: otp: return -EROFS if region is read-only
Date:   Fri, 21 May 2021 21:40:33 +0200
Message-Id: <20210521194034.15249-4-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210521194034.15249-1-michael@walle.cc>
References: <20210521194034.15249-1-michael@walle.cc>
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
---
 drivers/mtd/spi-nor/otp.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
index 3898ed67ba1c..b87f96593c13 100644
--- a/drivers/mtd/spi-nor/otp.c
+++ b/drivers/mtd/spi-nor/otp.c
@@ -249,6 +249,31 @@ static int spi_nor_mtd_otp_info(struct mtd_info *mtd, size_t len,
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
@@ -271,6 +296,16 @@ static int spi_nor_mtd_otp_read_write(struct mtd_info *mtd, loff_t ofs,
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

