Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9216F4198E4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbhI0Qdd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Sep 2021 12:33:33 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:45835 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbhI0Qdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:33:32 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 7BB0F10000E;
        Mon, 27 Sep 2021 16:31:51 +0000 (UTC)
Date:   Mon, 27 Sep 2021 18:31:50 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jan Hoffmann <jan@3e8.eu>
Cc:     Daniel Kestrel <kestrelseventyfour@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: xway: No hardcoded ECC engine, use
 device tree setting
Message-ID: <20210927183150.4be87140@xps13>
In-Reply-To: <14eb0cb7-b0af-87bf-b9a5-3e35eeb43f54@3e8.eu>
References: <20210808072643.GA5084@ubuntu>
        <51f2ebf4-6df1-eba5-99f1-1ec88e475d20@3e8.eu>
        <20210917190154.76203a9a@xps13>
        <e9dd0653-139f-749b-c088-e756ee2d2132@3e8.eu>
        <20210917213246.319e60cb@xps13>
        <14eb0cb7-b0af-87bf-b9a5-3e35eeb43f54@3e8.eu>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

Sorry for the delay, I had to rethink about the problem first.

jan@3e8.eu wrote on Sat, 18 Sep 2021 23:26:48 +0200:

> Hi Miquèl,
> 
> > Yes this was my understanding, that only software ECC engine was
> > supported. The mainline driver shows absolutely no signs of hardware
> > ECC engine support.
> > 
> > Perhaps however you mean that on-die ECC engine are not supported
> > anymore because of the engine_type being set in attach_chip()?  
> 
> Yes, this is exactly the issue.
> 
> > If yes then indeed there is something to do, perhaps checking if an
> > engine has been already set is enough? You can try something like:
> > 
> > if (engine_type == unknown)
> > 	engine_type = soft;  
> 
> Checking for NAND_ECC_ENGINE_TYPE_INVALID doesn't work, as the engine
> type is already set to NAND_ECC_ENGINE_TYPE_ON_HOST by rawnand_dt_init.
> The code there seems to expect that chip->ecc.engine_type contains the
> default value, which is no longer the case after commit 525914b5bd8
> ("mtd: rawnand: xway: Move the ECC initialization to ->attach_chip()").

This is indeed an issue and should be fixed. However the solution is I
think already available in the raw NAND core (but I had to dig into the
code again to remember how I wanted to handle this).

> The following in attach_chip works:
> 
> if (chip->ecc.engine_type == NAND_ECC_ENGINE_TYPE_ON_HOST)
> 	chip->ecc.engine_type = NAND_ECC_ENGINE_TYPE_SOFT;

If you look at the rawnand_dt_init() function [1] the logic is:

Is the user configuration (DT) valid ? if yes take it.
Is the NAND controller driver setting a default mode? if yes take it.
Otherwise take the raw NAND subsystem default: ON_HOST.

This logic happens very soon in the init process so the default mode
for the driver should be provided before the nand_scan() call.

So what I propose is:
- in the driver probe: set the default to software ECC
- in the attach() hook: drop the line setting the engine_type to SOFT.

Please check the below diff and tell me if it works for you. I'll then
propose a wider series fixing the other drivers as well.

> However, this will also silently use the software ECC engine if anyone
> actually configures the on-host hardware ECC engine in the device tree
> (which is of course unsupported for xway).
> 
> Thanks,
> Jan


[1] https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw/nand_base.c#L5328

Thanks,
Miquèl

---
diff --git a/drivers/mtd/nand/raw/xway_nand.c b/drivers/mtd/nand/raw/xway_nand.c
index 26751976e502..d9e167dbb717 100644
--- a/drivers/mtd/nand/raw/xway_nand.c
+++ b/drivers/mtd/nand/raw/xway_nand.c
@@ -148,9 +148,8 @@ static void xway_write_buf(struct nand_chip *chip, const u_char *buf, int len)
 
 static int xway_attach_chip(struct nand_chip *chip)
 {
-       chip->ecc.engine_type = NAND_ECC_ENGINE_TYPE_SOFT;
-
-       if (chip->ecc.algo == NAND_ECC_ALGO_UNKNOWN)
+       if (chip->ecc.engine_type == NAND_ECC_ENGINE_TYPE_SOFT &&
+           chip->ecc.algo == NAND_ECC_ALGO_UNKNOWN)
                chip->ecc.algo = NAND_ECC_ALGO_HAMMING;
 
        return 0;
@@ -219,6 +218,14 @@ static int xway_nand_probe(struct platform_device *pdev)
                    | NAND_CON_SE_P | NAND_CON_WP_P | NAND_CON_PRE_P
                    | cs_flag, EBU_NAND_CON);
 
+       /*
+        * This controller has no hardware ECC engine and the driver assumes
+        * that the default ECC engine should be TYPE_SOFT. Set ->engine_type
+        * before the NAND registration in order to provide a default value.
+        */
+       data->chip.ecc.engine_type = NAND_ECC_ENGINE_TYPE_SOFT;
+
+
        /* Scan to find existence of the device */
        err = nand_scan(&data->chip, 1);
        if (err)
