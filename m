Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7752A3D9D94
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 08:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbhG2GV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 02:21:58 -0400
Received: from mout01.posteo.de ([185.67.36.65]:60921 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233934AbhG2GV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 02:21:57 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 4282D240028
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 08:21:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1627539713; bh=lcAhkWc/Kvh+uxpOR8FIfKZeWqnSufI171CKVlcwme0=;
        h=Date:From:To:Cc:Subject:From;
        b=hbmT7XRx/sjH+yHP3I31OjInZ03I+KZ/65UQmYBK+5F5YptCALkIaviNvAMvOezC0
         aq6qCcvbZNsfZv6F2SBmPzUgZGDR90Sy9gkTt3uKDsT1B9SEjfhlOBhPkiT2ppZa8D
         iPvFhgluTQ3bRPBovV8yPi/aZO4sjnLbKk7EskAvmgAx7n9UmTMCj6WFRhJq0VPvuN
         vec3t61RA3Xzu88c5rlkSfUWpG1Ax19uq3KO2/1RnBGLQiD08BqZvpHn23FgsN8nJL
         sGFAKhJHOI/0srwz+5Gm9QueYfsASCfrPa762Wi/asMAx6cYeUzGEVSCaWH8WZZQJg
         deYOgRqwb1nqA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Gb0mZ03Spz9rxQ;
        Thu, 29 Jul 2021 08:21:49 +0200 (CEST)
Date:   Thu, 29 Jul 2021 06:21:48 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Joerg Reiling <joerg.reiling@jenoptik.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH] mtd: spi-nor: micron-st: add another variant of mt25qu256a
Message-ID: <YQJI/MlIZ6XKKYJi@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a second variant of mt25qu256a with a slightly different extended
device id.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
Signed-off-by: Joerg Reiling <joerg.reiling@jenoptik.com>
---
 drivers/mtd/spi-nor/micron-st.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index c224e59820a1..2682d67d037b 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -156,6 +156,9 @@ static const struct flash_info st_parts[] = {
 	{ "mt25qu256a",  INFO6(0x20bb19, 0x104400, 64 * 1024,  512,
 			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
 			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ "mt25qu256a1", INFO6(0x20bb19, 0x104000, 64 * 1024,  512,
+			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
+			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ "n25q256ax1",  INFO(0x20bb19, 0, 64 * 1024,  512,
 			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
 	{ "mt25ql512a",  INFO6(0x20ba20, 0x104400, 64 * 1024, 1024,
-- 
2.32.0

