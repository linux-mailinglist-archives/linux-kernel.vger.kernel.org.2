Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B028E3E397E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 09:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhHHH1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 03:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhHHH1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 03:27:05 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5491C061760
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 00:26:45 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o1-20020a05600c5101b02902e676fe1f04so1333852wms.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Aug 2021 00:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=vQGEpzFTHdiNMrj1IbLwx7ugk+DGqp8L3qv1oj8hD5g=;
        b=DtU5r9zVXntBuZSdHA6FnR+0AKscgfFfZOq2IHsQWipCUnwXWAZA2ohzu5H3+ZYo8s
         Plt283LNlbdNpERvVnwgb9S05dkSb9SEu34kp+BlrVd2pPeo2/409+1Y20+KG01mpTNU
         HD2e3N0RjIGsJA3wEXPv9lk5tcb+KbD/8RUcH6LO5x4lKNkA/mw+TJ7+g2+Nu5zlYGol
         ajEFCB3AbyNdH6V9d73+Ge3oZTSG0PvIIok0E88gAhszE3zKYS5gr3rdn44dbiiUmGSd
         vbrdS+vGvU6uco1R9wfr3wTifs/Mt0Qp3uzoTqbM/1bF5CB6YcZnFT1bvZgx73TJAiC+
         JpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vQGEpzFTHdiNMrj1IbLwx7ugk+DGqp8L3qv1oj8hD5g=;
        b=aVzHoSZXD13AXJmz+0NiirBLQB5r5FocLZMoiNWcEy3SCU+qjZFyXz5e/oSBYd96A2
         Xq3XxE86RXwDSmwZAl6mn9JX450zKhEcjZ/FJaPnySeqIUnuUWn5B5L3SdciPouE4nXY
         LKc1DpUY0VqU9z4YMVt5fLbmbX4/UqcpdQ8BR4JJBStlZtA1YOa0mNnh+lEQPBh8OTZS
         WPxDF5s2O4wnhYWsuzjXr8hSGQ2gf07gFAlvp4vdor5LczfjYbbfIa8CDe+rM7PF8G6F
         adP1coUc8hw+vbObKlEuCi0tPWsBx01/EeufSpaIc4P9JGApxJemnbHcTeKSYT/mJK0+
         u5cw==
X-Gm-Message-State: AOAM532l9qz6d37o7R/h7pcst+gMDJKgnvYLfTC8CAFcAkF7/QXU6cbj
        q2fYjNkcgbYbnIr/qTNXCvw=
X-Google-Smtp-Source: ABdhPJzff5Y98YpXQZTZOV86JynYtLA2tQaUfwWAqrpGuZ1e2BHqrq8hPzTKZQ2KVi3Zy/vFhga3NA==
X-Received: by 2002:a05:600c:a08:: with SMTP id z8mr28240065wmp.165.1628407604320;
        Sun, 08 Aug 2021 00:26:44 -0700 (PDT)
Received: from ubuntu ([155.133.219.250])
        by smtp.gmail.com with ESMTPSA id i5sm15072205wrw.13.2021.08.08.00.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Aug 2021 00:26:44 -0700 (PDT)
Date:   Sun, 8 Aug 2021 09:26:43 +0200
From:   Daniel Kestrel <kestrelseventyfour@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Kestrel <kestrelseventyfour@gmail.com>
Subject: [PATCH v2] mtd: rawnand: xway: No hardcoded ECC engine, use device
 tree setting
Message-ID: <20210808072643.GA5084@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices use Micron NAND chips, which use on-die ECC. The hardcoded
setting of NAND_ECC_ENGINE_TYPE_SOFT makes them unusable, because the
software ECC on top of the hardware ECC produces errors for every read
and write access, not to mention that booting does not work, because
the boot loader uses the correct ECC when trying to load the kernel
and stops loading on severe ECC errors.
This patch requires the devices that currently work with the hard coded
setting to set the nand-ecc-mode property to soft in their device
tree.

Signed-off-by: Daniel Kestrel <kestrelseventyfour@gmail.com>
Tested-by: Aleksander Jan Bajkowski <olek2@wp.pl> # tested on BT Home Hub 5A
---
 drivers/mtd/nand/raw/xway_nand.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/xway_nand.c b/drivers/mtd/nand/raw/xway_nand.c
index 26751976e502..0a4b0aa7dd4c 100644
--- a/drivers/mtd/nand/raw/xway_nand.c
+++ b/drivers/mtd/nand/raw/xway_nand.c
@@ -148,8 +148,6 @@ static void xway_write_buf(struct nand_chip *chip, const u_char *buf, int len)
 
 static int xway_attach_chip(struct nand_chip *chip)
 {
-	chip->ecc.engine_type = NAND_ECC_ENGINE_TYPE_SOFT;
-
 	if (chip->ecc.algo == NAND_ECC_ALGO_UNKNOWN)
 		chip->ecc.algo = NAND_ECC_ALGO_HAMMING;
 
-- 
2.17.1

