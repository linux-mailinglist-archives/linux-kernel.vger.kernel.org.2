Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60E435275F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 10:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbhDBIUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 04:20:45 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:58199 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbhDBIUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 04:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617351644; x=1648887644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QncFSB+LWljPbRHwRx8Zt/TjYzwpLPREbu0zOm5DH+Y=;
  b=JGW8c8K5ZVWmLHdEQ1oaZbn2Hk1kYe+jMM4w+t+mMNVbBfR8AIvlmiiM
   CkWUUhxV1EfPNJCg9QbFdhHlg8KvqtXImX2a3SPAUQf+A2u9iII3bj0pE
   xaVjZDyinLjB2VhLmdUZzIwJ9cPjwFFinVONvkiztoQTmTpMYjEMN2zCy
   19Q8oG6Oflc3WxXtlxHeN/8FG0cV4+aOB3XlW2WEnVW++58x7u0qURSvV
   rXEQ7nDbmxivJval4a3LLAyisIZvfRhaSCywHZCRLl74vZQFJj8gfbHFr
   ZhGiMfSnO8Fg+raQYnYCvrxD5S4JzQhBUfTCyoSk+0fHkvWgqZ1rVqH7k
   w==;
IronPort-SDR: qy2rfzYP0ay2K8J+9h7F5E0SFJp+QvYjR3vVX0b78B7Cj5ZBD0LskxRl+eqCZnR1IGFtgcdViR
 reoJsIKqye/tJxRKuUmreKOdrmP2uGwHBaxOKU0q0KmHtoxrAqtAz9JS9SWJQK+QeGoIxTdyAt
 78hUi6qXiHSU9+KJWPudlglK5Jj+eN8XE1pSVnbpE2V98VTPRnJp2o84mZSSo33raqGH3Ic7xC
 2o2y/0vUUSBn1dRXJCA/aOHuCmjke03L21GpeQYWNw3es+fTqj4zbIY2Y5TWHRTP06rFsfF6Yk
 knQ=
X-IronPort-AV: E=Sophos;i="5.81,299,1610434800"; 
   d="scan'208";a="121543242"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Apr 2021 01:20:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 2 Apr 2021 01:20:43 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 2 Apr 2021 01:20:40 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <michael@walle.cc>, <p.yadav@ti.com>, <vigneshr@ti.com>,
        <masonccyang@mxic.com.tw>, <zhengxunli@mxic.com.tw>,
        <ycllin@mxic.com.tw>, <juliensu@mxic.com.tw>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 2/2] mtd: spi-nor: macronix: Fix name for mx66l51235f
Date:   Fri, 2 Apr 2021 11:20:31 +0300
Message-ID: <20210402082031.19055-3-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210402082031.19055-1-tudor.ambarus@microchip.com>
References: <20210402082031.19055-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to macronix website, there is no mx66l51235l part number.
The chip detected as such is actually mx66l51235f. Rename the flash.
Do not update the mx66l51235l name from the spi_nor_dev_ids[], since
there are dt that are using this compatible.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/macronix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 42c2cf31702e..c8167de55e55 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -72,7 +72,7 @@ static const struct flash_info macronix_parts[] = {
 			      SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ) },
 	{ "mx25l25655e", INFO(0xc22619, 0, 64 * 1024, 512, 0) },
-	{ "mx66l51235l", INFO(0xc2201a, 0, 64 * 1024, 1024,
+	{ "mx66l51235f", INFO(0xc2201a, 0, 64 * 1024, 1024,
 			      SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			      SPI_NOR_4B_OPCODES) },
 	{ "mx66u51235f", INFO(0xc2253a, 0, 64 * 1024, 1024,
-- 
2.25.1

