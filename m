Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293463AEC3B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFUPZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhFUPZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:25:49 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D117FC061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:23:34 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gn32so2050217ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 08:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n2mPGF6e+QaRdPzOU0Ls1i7M7sCtOZoDk9UIo0VumFU=;
        b=D0f9REBDHx92cti3d+c5g+u85IrmzNTLUVgqSLCJkCFqs7Qmk+NgwHo+u15pOFbzS3
         k3hYAKamNb3WBqP4AE50RLDLv7PETChu/ANLkyJ7MZe4Sy+mTvADiJjZA7ugKLx9mewJ
         55oxd5ywg3dUmjblYpGoY0dbSULJe4mLRt4G0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n2mPGF6e+QaRdPzOU0Ls1i7M7sCtOZoDk9UIo0VumFU=;
        b=ayt1wrovlwGH5jNQadCNjlOsPmofgusg9IZI1QYEGweqmdDuRDsWavNDew6tQhpCwB
         ySDSoJp9E3lkykCcULMY2eOonRsQmK5ZqPKy4YPWh14s9tI3+b0i5YctlS09Z+nh/llw
         0gVQPuwTCtaRpX+yBJJCKDyAwJkBawY0iF9Ag5cH3CFoOjVnTLWrNRsHwr3XWWlznYsM
         p746N/uUYbQ90Lud2niXM1jljM3GYIsY4ccoj1FDYn/foYEKQSGaJoOfS1dlWUYU7Nqr
         ++emGHykw8SL1Lr8FSzRRUVP5mjQLzjHQrBqMznUzFyeJr7HcgeKkUMGTJbtk27mBa3k
         kyAQ==
X-Gm-Message-State: AOAM530lmVj+HwWkk2yAESMNtIXtcz1C80Nz9u3zn+LA102l/gg0sa1I
        vwtEu+A4wFD6JHkkhp0flbK2+w==
X-Google-Smtp-Source: ABdhPJyvRXdpqoFTcPfgwW1b53DCxt4JK7wQV4BGMDkeH2iHDruv/mWr06LSt3CoLs2lc8WU1E2r1g==
X-Received: by 2002:a17:906:718b:: with SMTP id h11mr8686734ejk.418.1624289013415;
        Mon, 21 Jun 2021 08:23:33 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([80.208.64.110])
        by smtp.gmail.com with ESMTPSA id q20sm5021079ejb.71.2021.06.21.08.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 08:23:33 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-mtd@lists.infradead.org
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <esben@geanix.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC 2/3] mtd: spi-nor: core: compare JEDEC bytes to already found flash_info
Date:   Mon, 21 Jun 2021 17:23:19 +0200
Message-Id: <20210621152320.3811194-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210621152320.3811194-1-linux@rasmusvillemoes.dk>
References: <20210621152320.3811194-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macronix engineers, in their infinite wisdom, have a habit of reusing
JEDEC ids for different chips. There's already one
workaround (MX25L25635F v MX25L25635E), but the same problem exists
for MX25L3205D v MX25L3233F, the latter of which is not currently
supported by linux.

AFAICT, that case cannot really be handled with any of the ->fixup
machinery: The correct entry for the MX25L3233F would read

        { "mx25l3233f",  INFO(0xc22016, 0, 64 * 1024,  64, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ ) },

while the existing one is

	{ "mx25l3205d",  INFO(0xc22016, 0, 64 * 1024,  64, SECT_4K) },

So in spi_nor_init_params(), we won't even try reading the sfdp
info (i.e. call spi_nor_sfdp_init_params), and hence
spi_nor_post_sfdp_fixups() has no way of distinguishing the
chips.

Replacing the existing entry with the mx25l3233f one to coerce the
core into issuing the SPINOR_OP_RDSFDP is also not really an option,
because the data sheet for the mx25l3205d explicitly says not to issue
any commands not listed ("It is not recommended to adopt any other
code not in the command definition table, which will potentially enter
the hidden mode.", whatever that means).

In order to support such cases, extend the logic in spi_nor_read_id()
a little so that if we already have a struct flash_info* from the name
in device tree, check the JEDEC bytes against that, and if it is a
match, accept that (device tree compatible + matching JEDEC bytes) is
stronger than merely matching JEDEC bytes.

This also makes initialization slightly faster in the common case
where the flash_info was found from the name and the JEDEC bytes do
match - it avoids a second linear search over all known chips.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/mtd/spi-nor/core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 6a1adef0fe9f..21ae655d6a6f 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1869,7 +1869,8 @@ spi_nor_search_part_by_id(const struct flash_info *parts, unsigned int nparts,
 	return NULL;
 }
 
-static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
+static const struct flash_info *
+spi_nor_read_id(struct spi_nor *nor, const struct flash_info *guess)
 {
 	const struct flash_info *info;
 	u8 *id = nor->bouncebuf;
@@ -1893,6 +1894,9 @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
 		return ERR_PTR(ret);
 	}
 
+	if (guess && spi_nor_match_part(guess, id))
+		return guess;
+
 	for (i = 0; i < ARRAY_SIZE(manufacturers); i++) {
 		info = spi_nor_search_part_by_id(manufacturers[i]->parts,
 						 manufacturers[i]->nparts,
@@ -3031,7 +3035,7 @@ static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
 		info = spi_nor_match_id(nor, name);
 	/* Try to auto-detect if chip name wasn't specified or not found */
 	if (!info)
-		info = spi_nor_read_id(nor);
+		info = spi_nor_read_id(nor, NULL);
 	if (IS_ERR_OR_NULL(info))
 		return ERR_PTR(-ENOENT);
 
@@ -3042,7 +3046,7 @@ static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
 	if (name && info->id_len) {
 		const struct flash_info *jinfo;
 
-		jinfo = spi_nor_read_id(nor);
+		jinfo = spi_nor_read_id(nor, info);
 		if (IS_ERR(jinfo)) {
 			return jinfo;
 		} else if (jinfo != info) {
-- 
2.31.1

