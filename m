Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1490C39B688
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 12:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhFDKE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 06:04:58 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:60039 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhFDKEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 06:04:51 -0400
Received: from mwalle01.fritz.box (ip4d17858c.dynamic.kabel-deutschland.de [77.23.133.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3F79C22253;
        Fri,  4 Jun 2021 12:03:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1622800984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=24M02QFwLfv0Ndp7lFLCOjioGUUvuEqyzsacb1UNRDI=;
        b=JjCYyTPt9e/rdqKAgaqxvDFbyeGulWL32jQaCBU/cv5oN9Diry2gmMP7/Q3Ai7Fsf6fjoS
        FFklOepw0pEoiXbkwEYEiM9oR5QF5434m4H4kWuudz2UhTTQtwxMYLZSGPc3Zdcs0eWcUz
        HMtSowWh0XT7L/u80lGBB/u2Zk759Wc=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v5 4/5] mtd: spi-nor: otp: simplify length check
Date:   Fri,  4 Jun 2021 12:02:51 +0200
Message-Id: <20210604100252.9975-5-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210604100252.9975-1-michael@walle.cc>
References: <20210604100252.9975-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By moving the code around a bit, we can just check the length before
calling spi_nor_mtd_otp_range_is_locked() and drop the length check
there. This way we don't need to take the lock. This will also skip the
"*retlen = 0" assignment if the length is zero. But mtdcore already does
that for us. Thus we can drop that, too.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/otp.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
index 063f8fb68649..89fe52e3851a 100644
--- a/drivers/mtd/spi-nor/otp.c
+++ b/drivers/mtd/spi-nor/otp.c
@@ -256,9 +256,6 @@ static int spi_nor_mtd_otp_range_is_locked(struct spi_nor *nor, loff_t ofs,
 	unsigned int region;
 	int locked;
 
-	if (!len)
-		return 0;
-
 	/*
 	 * If any of the affected OTP regions are locked the entire range is
 	 * considered locked.
@@ -290,13 +287,16 @@ static int spi_nor_mtd_otp_read_write(struct mtd_info *mtd, loff_t ofs,
 	if (ofs < 0 || ofs >= spi_nor_otp_size(nor))
 		return 0;
 
+	/* don't access beyond the end */
+	total_len = min_t(size_t, total_len, spi_nor_otp_size(nor) - ofs);
+
+	if (!total_len)
+		return 0;
+
 	ret = spi_nor_lock_and_prep(nor);
 	if (ret)
 		return ret;
 
-	/* don't access beyond the end */
-	total_len = min_t(size_t, total_len, spi_nor_otp_size(nor) - ofs);
-
 	if (is_write) {
 		ret = spi_nor_mtd_otp_range_is_locked(nor, ofs, total_len);
 		if (ret < 0) {
@@ -307,7 +307,6 @@ static int spi_nor_mtd_otp_read_write(struct mtd_info *mtd, loff_t ofs,
 		}
 	}
 
-	*retlen = 0;
 	while (total_len) {
 		/*
 		 * The OTP regions are mapped into a contiguous area starting
-- 
2.20.1

