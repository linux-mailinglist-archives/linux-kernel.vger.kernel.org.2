Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD55D3DF05C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbhHCOdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbhHCOdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:33:11 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E90C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 07:33:00 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id l18so25536263wrv.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 07:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=JnAQe55H44yXqV5MeskQcrSV5sTQ09ofmwohDfaVvNE=;
        b=m+MsmA+Uiw/gmtc06liX/OUsVOiuS+XchqPunoyHhgJajiRN+//GRLz/OjwvNns2G5
         r2uwdnWf5Lbz/65G3+absCGaJ7spQVyfq8I4tPE0ViP1aNZhhkkt/3LStROtshhil638
         Br1LxstnbRDhlf6YKQ6v4l52LqFf5LULlEy3eakUYc60BfH+4L9qDV29l91eGqrKGNMb
         zxQBLlLcyOahfHJw9k5G1ptSZ9WVGfnDjGv64urKcMmV5mypgRs6F11Y0wVJKpnGwd/5
         RoS8/lu9TRQlrKdyacly8nEYF9dZ2yjqg+Nuh3YulVMwv50wF8Uvq+VlcfieCEoJ7Z91
         wDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JnAQe55H44yXqV5MeskQcrSV5sTQ09ofmwohDfaVvNE=;
        b=sWj8Crwr+tejO63R+DJ9eqDtqGNDv8yoA3GJVEAZvF0GYaAitA5RZn5achx7TiJmRv
         2K4Lo6K4uzkPk7scporpjAadLX7g3+x0BfBY44WA3gw4PQTGtHwEVRTzffZgO7n22pYu
         ArYhya8fiS+Rp7AsejZQ042UM1IkxwCtaM4D9YIo4stQc7oGpBbUq2u8axXNY0qEMhSR
         rRqP1k7eViAYLhMF2fOFLaIDr9hwYoNVw2JdrHj5pZPpMrQ6+L6BY7aglkIT8ljHr3mD
         JzncT7AM7EYh0Qu3M/u9D0Ca3I6CpzzbBWvsw866gmJY0gpnzRR/+X0K9Yqh4HMFE2+H
         hBbA==
X-Gm-Message-State: AOAM531ksECZRFP+vXuN5jlH62pO+GtKyVbXqDmWX24h6hof5+BSEAKl
        d5w9YJ0DhJ/RbID9Acsikbrpwv0VecF1ig==
X-Google-Smtp-Source: ABdhPJzCZKhuklX67exUNipVKVEcV65KTpbeavr9kerSSJOMmZzYj/v6c8QxiLmK/zwvhAfXXU6xLQ==
X-Received: by 2002:adf:e5cf:: with SMTP id a15mr23357581wrn.362.1628001178742;
        Tue, 03 Aug 2021 07:32:58 -0700 (PDT)
Received: from ubuntu ([155.133.219.250])
        by smtp.gmail.com with ESMTPSA id v6sm14699059wru.50.2021.08.03.07.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 07:32:58 -0700 (PDT)
Date:   Tue, 3 Aug 2021 16:32:56 +0200
From:   Daniel Kestrel <kestrelseventyfour@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Daniel Kestrel <kestrelseventyfour@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: xway: No hardcoded ECC engine for Micron Chips
Message-ID: <20210803143256.GA5209@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some lantiq xway devices use Micron NAND chips, which use on-die ECC.
The hardcoded setting of NAND_ECC_ENGINE_TYPE_SOFT makes them unusable,
because the software ECC on top of the hardware ECC produces errors for
every read and write access, not to mention that booting does not work,
because the boot loader uses the correct ECC when trying to load the
kernel and stops loading on severe ECC errors.
Removing the hardcoded settings would break a number of devices that
work with those settings.
Adding a DTB property was considered, but did not work, because devices
of the same type but from different manufacture dates have different
NAND chips and as such it is not possible to determine the NAND chip
in advance or device specific.

Signed-off-by: Daniel Kestrel <kestrelseventyfour@gmail.com>
---
 drivers/mtd/nand/raw/xway_nand.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/xway_nand.c b/drivers/mtd/nand/raw/xway_nand.c
index 26751976e502..20cb5ce2f3b0 100644
--- a/drivers/mtd/nand/raw/xway_nand.c
+++ b/drivers/mtd/nand/raw/xway_nand.c
@@ -10,6 +10,7 @@
 #include <linux/of_platform.h>
 
 #include <lantiq_soc.h>
+#include "internals.h"
 
 /* nand registers */
 #define EBU_ADDSEL1		0x24
@@ -148,7 +149,8 @@ static void xway_write_buf(struct nand_chip *chip, const u_char *buf, int len)
 
 static int xway_attach_chip(struct nand_chip *chip)
 {
-	chip->ecc.engine_type = NAND_ECC_ENGINE_TYPE_SOFT;
+	if (chip->manufacturer.desc->id != NAND_MFR_MICRON)
+		chip->ecc.engine_type = NAND_ECC_ENGINE_TYPE_SOFT;
 
 	if (chip->ecc.algo == NAND_ECC_ALGO_UNKNOWN)
 		chip->ecc.algo = NAND_ECC_ALGO_HAMMING;
-- 
2.17.1

