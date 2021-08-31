Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56353FC428
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 10:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240233AbhHaIPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 04:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240072AbhHaIPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 04:15:36 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3424C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 01:14:40 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id dm15so25516275edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 01:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oMmNUzmo9Q7r3VmJw4TZNb8caycXHANgC/p8Tuu2198=;
        b=Y10DIN4nlK8rhbm2FENArhhhF6goAfYaMG1c5fY7+75SuH1zbT7TPm7ogk4byfjsFz
         /cvckv/UalCILdzcSeuzHwdnRGI96ObmboeyyVQi3s2ZXGBiPJRUKjKdCw+N5KOjWJ/8
         wVFqDg9IRfxr7SFVIDOWcsW3svrnSz8HO8OtYLdoNBhTHCuidPebzD8Ay6MCOHD2feAh
         Es0+SbUFRvKUeqzgqTDMoOI75ohnRgBc9zP//3AUZBCPaeOHc3UnAuDrEbVovOtZo9C0
         jGNHqcWn/YJ++C29l2lruUVZeUZGNYzyXmTNxzAKn24YbVkrF4pf8qjXswbVQSmG3qtp
         GZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oMmNUzmo9Q7r3VmJw4TZNb8caycXHANgC/p8Tuu2198=;
        b=YBvsvKkTDpmFuBHvZFS+ciETTKT0KG7oTccvMB5ruVMD4rN0GI0lD5NN6ZqE9H31lc
         Ao5n+5ru5lGKUTXmQLukX28UnXL6hYPN2m/fj4urjLZasFbDwKOd0JY2zzNMPB//uH9U
         3RHSIkihWr4LXM1jGI36LmkbncdBo3p9pZTID7GcD1PAqKpTaw9XEAaHVLu6lWf8B4nU
         wEmT2FUnCDiBzgRUmzYs6gT02fFrmqJbgRHC/GKXGytFFbosf1klO2ObAFWkbJpN/Ya5
         I/c6jpPUN1sVZrQz9bw8RZYL4aZnkVDTPJSOyE/7ZitFFJYzdVGRMMlwyyPuljyRwX6y
         eolA==
X-Gm-Message-State: AOAM530qQElVlA45XNFotK/edQxadQ8roT9fo5blPhPn83fix0upp1ll
        GbncopHM29g8Gpdv/kBEscM=
X-Google-Smtp-Source: ABdhPJzqcQV4CTygqUK/CdLP8DnQGmmYq9dVmRDzSUvLi/sh/KOc347ggv55QK/zN0+X/7+tWOnytg==
X-Received: by 2002:aa7:c88e:: with SMTP id p14mr29058184eds.174.1630397679627;
        Tue, 31 Aug 2021 01:14:39 -0700 (PDT)
Received: from localhost.localdomain ([213.215.174.110])
        by smtp.gmail.com with ESMTPSA id z15sm8922870edr.80.2021.08.31.01.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 01:14:39 -0700 (PDT)
From:   Andrea Zanotti <andreazanottifo@gmail.com>
X-Google-Original-From: Andrea Zanotti <andrea.zanotti@tyvak.eu>
Cc:     Andrea Zanotti <andreazanottifo@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: micron-st: added support for np8p128ax60
Date:   Tue, 31 Aug 2021 10:13:29 +0200
Message-Id: <20210831081329.27420-1-andrea.zanotti@tyvak.eu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Zanotti <andreazanottifo@gmail.com>

Added support for P8P Parallel Phase Change Memory.

Added memory information (page size and sector size) as per data-
sheet information, after typos corrections.

At page 37, paragraph 'SPI Memory Organization', it is written
down that the memory is organized as:
 * 16.772.216 bytes (typo here, there 16.777.216 bytes)
 * 128 sectors of 128 Kbytes each (correct)
 * 131.072 pages of 64 bytes each (typo here, as the total would be
   64Mbit, but the total memory is actually 128Mbit, correct value
   is 262.144 pages)

Patch tested against the aforementioned PCM memory.

No known regressions inserted, as the patch only adds the possibility
to recognize said PCM memory inside the common spi-nor driver.

Signed-off-by: Andrea Zanotti <andreazanottifo@gmail.com>
---
 drivers/mtd/spi-nor/micron-st.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index c224e59820a1..c78331451082 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -128,6 +128,7 @@ static const struct flash_info micron_parts[] = {
 	{ "mt35xu02g", INFO(0x2c5b1c, 0, 128 * 1024, 2048,
 			    SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
 			    SPI_NOR_4B_OPCODES) },
+	{ "np8p128ax60", {0x89, 0xda, 0x18}, 3, 128 * 1024, 128, 64, 0, 0 },
 };
 
 static const struct flash_info st_parts[] = {
-- 
2.17.1

