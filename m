Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC1B37A2A8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhEKIye convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 May 2021 04:54:34 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:58245 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhEKIya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:54:30 -0400
X-Originating-IP: 90.89.138.59
Received: from xps13 (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id B0AE32000D;
        Tue, 11 May 2021 08:53:20 +0000 (UTC)
Date:   Tue, 11 May 2021 10:53:19 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     YouChing Lin <ycllin@mxic.com.tw>
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, juliensu@mxic.com.tw
Subject: Re: [PATCH 0/2] Fix double counting of S/W ECC engines' ECC stat
Message-ID: <20210511105319.0c077fd5@xps13>
In-Reply-To: <1620697235-7829-1-git-send-email-ycllin@mxic.com.tw>
References: <1620697235-7829-1-git-send-email-ycllin@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YouChing,

YouChing Lin <ycllin@mxic.com.tw> wrote on Tue, 11 May 2021 09:40:33
+0800:

> Hello,
> 
> This series fix the double counting of S/W ECC engines' ECC stat 
> 
> If you use SPI-NAND with SW-ECC engine, the ECC related statistics
> (ecc_stats.failed & ecc_stats.corrected) will be doubled, because
> those numbers will be double-counted in ecc-sw-[bch/hamming].c and
> drivers/mtd/nand/spi/core.c.
>     
> This can be found by using nandtest/nandbiterrs validation.

Good catch!

However I don't think the current fix is valid because these engines
are meant to be used by the raw NAND core as well, I propose something
like the below, can you please tell me if it works as expected? (not
even build tested)

Thanks,
Miquèl


----8<----

Author: Miquel Raynal <miquel.raynal@bootlin.com>
Date:   Tue May 11 10:41:56 2021 +0200

    mtd: spinand: Fix double counting of ECC stats
    
    In the raw NAND world, ECC engines increment ecc_stats and the final
    caller is responsible for returning -EBADMSG if the verification
    failed.
    
    In the SPI-NAND world it was a bit different until now because there was
    only one possible ECC engine: the on-die one. Indeed, the
    spinand_mtd_read() call was incrementing the ecc_stats counters
    depending on the outcome of spinand_check_ecc_status() directly.
    
    So now let's split the logic like this:
    - spinand_check_ecc_status() is specific to the SPI-NAND on-die engine
      and is kept very simple: it just returns the ECC status (bonus point:
      the content of this helper can be overloaded).
    - spinand_ondie_ecc_finish_io_req() is the caller of
      spinand_check_ecc_status() and will increment the counters and
      eventually return -EBADMSG.
    - spinand_mtd_read() is not tied to the on-die ECC implementation and
      should be able to handle results coming from other ECC engines: it has
      the responsibility of returning the maximum number of bitflips which
      happened during the entire operation as this is the only helper that
      is aware that several pages may be read in a row.
    
    Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 61d932c1b718..df134c61853e 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -290,6 +290,8 @@ static int spinand_ondie_ecc_finish_io_req(struct nand_device *nand,
 {
        struct spinand_ondie_ecc_conf *engine_conf = nand->ecc.ctx.priv;
        struct spinand_device *spinand = nand_to_spinand(nand);
+       struct mtd_info *mtd = spinand_to_mtd(spinand);
+       int ret;
 
        if (req->mode == MTD_OPS_RAW)
                return 0;
@@ -299,7 +301,13 @@ static int spinand_ondie_ecc_finish_io_req(struct nand_device *nand,
                return 0;
 
        /* Finish a page write: check the status, report errors/bitflips */
-       return spinand_check_ecc_status(spinand, engine_conf->status);
+       ret = spinand_check_ecc_status(spinand, engine_conf->status);
+       if (ret == -EBADMSG)
+               mtd->ecc_stats.failed++;
+       else if (ret > 0)
+               mtd->ecc_stats.corrected += ret;
+
+       return ret;
 }
 
 static struct nand_ecc_engine_ops spinand_ondie_ecc_engine_ops = {
@@ -620,13 +628,10 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
                if (ret < 0 && ret != -EBADMSG)
                        break;
 
-               if (ret == -EBADMSG) {
+               if (ret == -EBADMSG)
                        ecc_failed = true;
-                       mtd->ecc_stats.failed++;
-               } else {
-                       mtd->ecc_stats.corrected += ret;
+               else
                        max_bitflips = max_t(unsigned int, max_bitflips, ret);
-               }
 
                ret = 0;
                ops->retlen += iter.req.datalen;
