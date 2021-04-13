Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6B435DE2D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 14:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244126AbhDMMCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 08:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237609AbhDMMCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 08:02:35 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BCAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 05:02:15 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id i190so11268875pfc.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 05:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=43U774HFHYflbPQdqOHAW3OVnrmdMQMR7y/I+ghE8Cg=;
        b=Z7j7DCZKXLddsX2fqj/zX3WzQ5l5zPPGKjSr1HnCVr095YpcTxwE2E9BJl2rqO8vuI
         jn0nv8/r5goPmqCmgC49hS4cnXFuntnRi6C2Okh3IFuHo3wUYkksDpOIE1d+/Raj8nAm
         WjH93riEfnHZCouhf13N+IAxB7oqX7jhyjTlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=43U774HFHYflbPQdqOHAW3OVnrmdMQMR7y/I+ghE8Cg=;
        b=fGlXdcrgCODGz/euXxeQ4qOoebWQs4J4zaR1SwPX7GbKFfDVrVVrVh5SdrzB7jW4+E
         /M19flRG+X1x1/7kzGwHoV9iFhyEL/e2FVd3M6YpHQ/gRHOI87RwYktCIXbzimSP+pJ5
         IGhDJ/z9EyqcE9H2Op/BSODAb6ix6msuyiQ8JqJ7DS5A20yJ8HC3Rw27Job10oWtcnC2
         +L1WwdaevhPJ76plJ1Hb6uux1HpjypQ7vYSERdnKGZqNt6oG75zecQIXZj8HE7jo0vx9
         x3hCEdafYXRnxxfPM4bTgVbv6zvbie5TAN8rIKluXD4qH9zpI9yZ/0l190gDALVsXCr5
         fezA==
X-Gm-Message-State: AOAM532o5fkYX9AN1jh9DLU/0cG7MRAw5kAw/Q1KeEWk4Gs3S4d4m/dC
        tjZO/bBvNhGJuaq6KUBsbpNKlg==
X-Google-Smtp-Source: ABdhPJwRUSJwBr95cQTeg64Q0dvGduBBNUuNPb62QCZ/Zzo6SJwiFeI4tdnSMPCFghGczizW+gppRg==
X-Received: by 2002:a65:5b85:: with SMTP id i5mr30812637pgr.269.1618315335258;
        Tue, 13 Apr 2021 05:02:15 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:b:f18a:a81b:ae0c:64f8])
        by smtp.gmail.com with ESMTPSA id d13sm14522058pgb.6.2021.04.13.05.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 05:02:14 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-mtd@lists.infradead.org
Cc:     Ikjoon Jang <ikjn@chromium.org>, Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: macronix: Add block protection support to mx25u6435f
Date:   Tue, 13 Apr 2021 20:02:10 +0800
Message-Id: <20210413120210.3671536-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds block protection support to Macronix mx25u6432f and
mx25u6435f. Two different chips share the same JEDEC ID while only
mx25u6423f support section protections. And two chips have slightly
different definitions of BP bits than generic (ST Micro) implementation.

So this patch defines a new spi_nor_locking_ops only for macronix
until this could be merged into a generic swp implementation.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>

---

 drivers/mtd/spi-nor/macronix.c | 193 ++++++++++++++++++++++++++++++++-
 1 file changed, 192 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 42c2cf31702e..563005830e46 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -8,6 +8,195 @@
 
 #include "core.h"
 
+/*
+ * mx25u6435f/mx25u6432f common protection table:
+ *
+ * mx25u6432f has T/B bit, but mx25u6435f doesn't.
+ * while both chips have the same JEDEC ID,
+ * Also BP bits are slightly different with generic swp.
+ * So here we only use common part of the BPs definitions.
+ *
+ * - Upper 2^(Prot Level - 1) blocks are protected.
+ * - Block size is hardcoded as 64Kib.
+ * - Assume T/B is always 0 (top protected, factory default).
+ *
+ *   BP3| BP2 | BP1 | BP0 | Prot Level
+ *  -----------------------------------
+ *    0 |  0  |  0  |  0  |  NONE
+ *    0 |  0  |  0  |  1  |  1
+ *    0 |  0  |  1  |  0  |  2
+ *    0 |  0  |  1  |  1  |  3
+ *    0 |  1  |  0  |  0  |  4
+ *    0 |  1  |  0  |  1  |  5
+ *    0 |  1  |  1  |  0  |  6
+ *    0 |  1  |  1  |  1  |  7
+ *   .....................|  differ by 35f/32f, not used
+ *    1 |  1  |  1  |  1  |  ALL
+ */
+
+#define MX_BP_MASK	(SR_BP0 | SR_BP1 | SR_BP2 | SR_BP3)
+#define MX_BP_SHIFT	(SR_BP_SHIFT)
+
+static int mx_get_locked_len(struct spi_nor *nor, u8 sr, uint64_t *lock_len)
+{
+	struct mtd_info *mtd = &nor->mtd;
+	u8 bp;
+
+	bp = (sr & MX_BP_MASK) >> MX_BP_SHIFT;
+
+	if (bp == 0xf) {
+		/* protected all */
+		*lock_len = mtd->size;
+		return 0;
+	}
+
+	/* sorry, not yet supported */
+	if (bp > 0x7)
+		return -EOPNOTSUPP;
+
+	/* block size = 64Kib */
+	*lock_len = bp ? (0x8000 << bp) : 0;
+	return 0;
+}
+
+static int mx_set_prot_level(struct spi_nor *nor, uint64_t lock_len, u8 *sr)
+{
+	uint64_t new_len;
+	u8 new_lvl;
+
+	if (lock_len) {
+		/* 64Kib block size harcoded */
+		new_lvl = ilog2(lock_len) - 15;
+		new_len = 1ULL << (15 + new_lvl);
+
+		if (new_len != lock_len)
+			return -EINVAL;
+	} else {
+		new_lvl = 0;
+	}
+
+	*sr &= ~MX_BP_MASK;
+	*sr |= (new_lvl) << MX_BP_SHIFT;
+
+	return 0;
+}
+
+static int mx_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	struct mtd_info *mtd = &nor->mtd;
+	int ret;
+	uint64_t lock_len;
+	u8 sr;
+
+	ret = spi_nor_read_sr(nor, nor->bouncebuf);
+	if (ret)
+		return ret;
+
+	sr = nor->bouncebuf[0];
+
+	/* always 'top' protection */
+	if ((ofs + len) != mtd->size)
+		return -EINVAL;
+
+	ret = mx_get_locked_len(nor, sr, &lock_len);
+	if (ret)
+		return ret;
+
+	/* already locked? */
+	if (len <= lock_len)
+		return 0;
+
+	ret = mx_set_prot_level(nor, len, &sr);
+	if (ret)
+		return ret;
+
+	/* Disallow further writes if WP pin is asserted */
+	sr |= SR_SRWD;
+
+	return spi_nor_write_sr_and_check(nor, sr);
+}
+
+static int mx_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	struct mtd_info *mtd = &nor->mtd;
+	int ret;
+	uint64_t lock_len;
+	u8 sr;
+
+	if ((ofs + len) > mtd->size)
+		return -EINVAL;
+
+	ret = spi_nor_read_sr(nor, nor->bouncebuf);
+	if (ret)
+		return ret;
+
+	sr = nor->bouncebuf[0];
+
+	ret = mx_get_locked_len(nor, sr, &lock_len);
+	if (ret)
+		return ret;
+
+	/* already unlocked? */
+	if ((ofs + len) <= (mtd->size - lock_len))
+		return 0;
+
+	/* can't make a hole in a locked region */
+	if (ofs > (mtd->size - lock_len))
+		return -EINVAL;
+
+	lock_len = mtd->size - ofs - len;
+	ret = mx_set_prot_level(nor, lock_len, &sr);
+	if (ret)
+		return ret;
+
+	/* Don't protect status register if we're fully unlocked */
+	if (lock_len == 0)
+		sr &= ~SR_SRWD;
+
+	return spi_nor_write_sr_and_check(nor, sr);
+}
+
+static int mx_is_locked(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	struct mtd_info *mtd = &nor->mtd;
+	int ret;
+	uint64_t lock_len;
+	u8 sr;
+
+	if ((ofs + len) > mtd->size)
+		return -EINVAL;
+
+	if (!len)
+		return 0;
+
+	ret = spi_nor_read_sr(nor, nor->bouncebuf);
+	if (ret)
+		return ret;
+
+	sr = nor->bouncebuf[0];
+
+	ret = mx_get_locked_len(nor, sr, &lock_len);
+	if (ret)
+		return ret;
+
+	return (ofs >= (mtd->size - lock_len)) ? 1 : 0;
+}
+
+static const struct spi_nor_locking_ops mx_locking_ops = {
+	.lock		= mx_lock,
+	.unlock		= mx_unlock,
+	.is_locked	= mx_is_locked,
+};
+
+static void mx_default_init(struct spi_nor *nor)
+{
+	nor->params->locking_ops = &mx_locking_ops;
+}
+
+static const struct spi_nor_fixups mx_locking_fixups = {
+	.default_init = mx_default_init,
+};
+
 static int
 mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
 			    const struct sfdp_parameter_header *bfpt_header,
@@ -48,7 +237,9 @@ static const struct flash_info macronix_parts[] = {
 			      SPI_NOR_QUAD_READ) },
 	{ "mx25u4035",   INFO(0xc22533, 0, 64 * 1024,   8, SECT_4K) },
 	{ "mx25u8035",   INFO(0xc22534, 0, 64 * 1024,  16, SECT_4K) },
-	{ "mx25u6435f",  INFO(0xc22537, 0, 64 * 1024, 128, SECT_4K) },
+	{ "mx25u6435f",  INFO(0xc22537, 0, 64 * 1024, 128,
+			      SECT_4K | SPI_NOR_HAS_LOCK)
+		.fixups = &mx_locking_fixups },
 	{ "mx25l12805d", INFO(0xc22018, 0, 64 * 1024, 256, SECT_4K) },
 	{ "mx25l12855e", INFO(0xc22618, 0, 64 * 1024, 256, 0) },
 	{ "mx25r1635f",  INFO(0xc22815, 0, 64 * 1024,  32,
-- 
2.31.1.295.g9ea45b61b8-goog

