Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA1733ABCF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 07:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhCOGxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 02:53:31 -0400
Received: from smtprelay0158.hostedemail.com ([216.40.44.158]:46092 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229828AbhCOGxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 02:53:08 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id A885B363F;
        Mon, 15 Mar 2021 06:53:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:599:800:960:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3173:3354:3622:3865:3866:3867:3868:3871:4250:4321:5007:6678:7652:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12438:12555:12740:12760:12895:12986:13095:13439:14096:14097:14181:14659:14721:21080:21433:21451:21627:21990:30012:30054:30064:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: town30_2b099872772b
X-Filterd-Recvd-Size: 3821
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon, 15 Mar 2021 06:53:06 +0000 (UTC)
Message-ID: <5723fabcc03455ee6624a7d223186e5fad2bf2e9.camel@perches.com>
Subject: Re: [PATCH v2 5/5] mtd: spi-nor: swp: Drop 'else' after 'return'
From:   Joe Perches <joe@perches.com>
To:     Pratyush Yadav <p.yadav@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     vigneshr@ti.com, michael@walle.cc, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, richard@nod.at,
        linux-kernel@vger.kernel.org
Date:   Sun, 14 Mar 2021 23:53:04 -0700
In-Reply-To: <20210308062821.wn4uqfxcg6vo3gcb@ti.com>
References: <20210306095002.22983-1-tudor.ambarus@microchip.com>
         <20210306095002.22983-6-tudor.ambarus@microchip.com>
         <20210308062821.wn4uqfxcg6vo3gcb@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-03-08 at 11:58 +0530, Pratyush Yadav wrote:
> On 06/03/21 11:50AM, Tudor Ambarus wrote:
> > else is not generally useful after a break or return.
> > 
> > Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
> 

I don't think this improves the code.

Generally, checkpatch is a stupid little script.

This code uses a form like:
	if (foo)
		return bar;
	else
		return baz;

which checkpatch recognizes as OK and so checkpatch does not
emit any warning message, but this code just adds comments
before each return which confuses checkpatch.

I think better would be to change the code to use temporaries
and convert the functions to bool.

Something like:
---
 drivers/mtd/spi-nor/core.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 0522304f52fa..e174a2f1d621 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1798,36 +1798,41 @@ static void spi_nor_get_locked_range_sr(struct spi_nor *nor, u8 sr, loff_t *ofs,
 }
 
 /*
- * Return 1 if the entire region is locked (if @locked is true) or unlocked (if
- * @locked is false); 0 otherwise
+ * Return true if the entire region is locked
+ * (if @locked is true) or unlocked (if @locked is false); false otherwise
  */
-static int spi_nor_check_lock_status_sr(struct spi_nor *nor, loff_t ofs,
+static bool spi_nor_check_lock_status_sr(struct spi_nor *nor, loff_t ofs,
 					uint64_t len, u8 sr, bool locked)
 {
 	loff_t lock_offs;
 	uint64_t lock_len;
+	uint64_t lock_max;
+	uint64_t ofs_max;
 
 	if (!len)
-		return 1;
+		return true;
 
 	spi_nor_get_locked_range_sr(nor, sr, &lock_offs, &lock_len);
 
+	lock_max = lock_offs + lock_len;
+	ofs_max = ofs + len;
+
 	if (locked)
 		/* Requested range is a sub-range of locked range */
-		return (ofs + len <= lock_offs + lock_len) && (ofs >= lock_offs);
+		return (ofs_max <= lock_max) && (ofs >= lock_offs);
 	else
 		/* Requested range does not overlap with locked range */
-		return (ofs >= lock_offs + lock_len) || (ofs + len <= lock_offs);
+		return (ofs >= lock_max) || (ofs_max <= lock_offs);
 }
 
-static int spi_nor_is_locked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
-				u8 sr)
+static bool spi_nor_is_locked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
+				 u8 sr)
 {
 	return spi_nor_check_lock_status_sr(nor, ofs, len, sr, true);
 }
 
-static int spi_nor_is_unlocked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
-				  u8 sr)
+static bool spi_nor_is_unlocked_sr(struct spi_nor *nor, loff_t ofs, uint64_t len,
+				   u8 sr)
 {
 	return spi_nor_check_lock_status_sr(nor, ofs, len, sr, false);
 }


