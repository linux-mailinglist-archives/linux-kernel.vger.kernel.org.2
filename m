Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC653379CD1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 04:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhEKCSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 22:18:35 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:47982 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhEKCSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 22:18:34 -0400
X-Greylist: delayed 2153 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 May 2021 22:18:34 EDT
Received: from TWHMLLG3.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG3.macronix.com with ESMTP id 14B1fafx037051
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 09:41:36 +0800 (GMT-8)
        (envelope-from ycllin@mxic.com.tw)
Received: from localhost.localdomain ([172.17.195.95])
        by TWHMLLG3.macronix.com with ESMTP id 14B1esOY036551;
        Tue, 11 May 2021 09:40:54 +0800 (GMT-8)
        (envelope-from ycllin@mxic.com.tw)
From:   YouChing Lin <ycllin@mxic.com.tw>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        juliensu@mxic.com.tw, YouChing Lin <ycllin@mxic.com.tw>
Subject: [PATCH 0/2] Fix double counting of S/W ECC engines' ECC stat
Date:   Tue, 11 May 2021 09:40:33 +0800
Message-Id: <1620697235-7829-1-git-send-email-ycllin@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG3.macronix.com 14B1esOY036551
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series fix the double counting of S/W ECC engines' ECC stat 

If you use SPI-NAND with SW-ECC engine, the ECC related statistics
(ecc_stats.failed & ecc_stats.corrected) will be doubled, because
those numbers will be double-counted in ecc-sw-[bch/hamming].c and
drivers/mtd/nand/spi/core.c.
    
This can be found by using nandtest/nandbiterrs validation.

Thanks for your time.

YouChing Lin (2):
  mtd: nand: ecc-bch: Fix the double counting of ECC stat
  mtd: nand: ecc-hamming: Fix the double counting of ECC stat

 drivers/mtd/nand/ecc-sw-bch.c     | 9 +++++----
 drivers/mtd/nand/ecc-sw-hamming.c | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

-- 
1.9.1

