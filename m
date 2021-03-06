Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC3E32F92D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 10:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhCFJuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 04:50:24 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:33727 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhCFJuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 04:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615024209; x=1646560209;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6d8k/C2zcO7dRNE3vNUlOTglcHwp5T6AxxIZYwQ4r5s=;
  b=tgYd98fHi5n5Ydla5WsErMIE3YlOCyCeB2vS53q7XQCoRv84OZncnax2
   0bzhLgBsxniOUeKrHDRbv2cI8OdHP0INkVu1qIHeI8eeZ180Wv3EtfpEr
   JWM2KcL+nKLJlRyYpMGo2ICDKNBBZXizpPkM1tSRMJ1gogNzmjdD1VruY
   L+6RIrtuksPuNXc0VgiQ0b28c5IEdIlcFDv0b5bBsJL+v0CipQAPTDu1p
   zkH/q6HdkZ9ZLwhjlctSUY5BBBuwKm/E2urV8rbYVVdMWkrKbieJhLzyN
   j1guZh/mBiViepmi2rEGC/q+YNMYH1m4YPb/M9/YXhyiOVGDEN3nyc0u6
   w==;
IronPort-SDR: B0sdHwEu5mieVwBAIOzkyI2zj3sWNnjSNt+LzVp1hxIWYbZBpMO5f5cQKh1yUjjwRPTxC+QL/6
 cebMLn81i/5I2KFGfetRZjWgwC8dzlwo8l212evjJoM9SJ7W2OERLcMEC+C/2Dk0eQXuVSnoug
 vK5Mn7d2HUZw45+TXJPmziVgzMaWEhGQj5NIfVMoF2JK9aqe7lMH6npY9UV+N3f0HWi4Pl8oSG
 ftMHjMfSeTj2LkZeI8SkhKEqAgkzmxutS6ekBX+Ki9sC6L8ewBCkFmG1bZcmxpc7QnL8zzAomV
 4hQ=
X-IronPort-AV: E=Sophos;i="5.81,227,1610434800"; 
   d="scan'208";a="46513037"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Mar 2021 02:50:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 6 Mar 2021 02:50:08 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Sat, 6 Mar 2021 02:50:06 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vigneshr@ti.com>, <p.yadav@ti.com>, <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 0/5] mtd: spi-nor: Cleanup patches
Date:   Sat, 6 Mar 2021 11:49:57 +0200
Message-ID: <20210306095002.22983-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various cleanup patches done while reviewing contributions.

Tudor Ambarus (5):
  mtd: spi-nor: core: Advance erase after the erase cmd has been
    completed
  mtd: spi-nor: core: Add vdbg msg for spi_nor_erase_multi_sectors()
  mtd: spi-nor: Get rid of duplicated argument in spi_nor_parse_sfdp()
  mtd: spi-nor: Move Software Write Protection logic out of the core
  mtd: spi-nor: swp: Drop 'else' after 'return'

 drivers/mtd/spi-nor/Makefile   |   2 +-
 drivers/mtd/spi-nor/core.c     | 432 ++-------------------------------
 drivers/mtd/spi-nor/core.h     |  10 +-
 drivers/mtd/spi-nor/issi.c     |   3 +-
 drivers/mtd/spi-nor/macronix.c |   3 +-
 drivers/mtd/spi-nor/sfdp.c     |  72 +++---
 drivers/mtd/spi-nor/sfdp.h     |   3 +-
 drivers/mtd/spi-nor/spansion.c |  12 +-
 drivers/mtd/spi-nor/swp.c      | 419 ++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/winbond.c  |   3 +-
 10 files changed, 479 insertions(+), 480 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/swp.c

-- 
2.25.1

