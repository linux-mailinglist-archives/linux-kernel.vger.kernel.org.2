Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDE534CD8F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 12:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbhC2KCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 06:02:10 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:53767 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbhC2KBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 06:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617012080; x=1648548080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=leVblOH1MY8DwoTNFe/JSw6Rm5p0N8qVukn2RO/GPfI=;
  b=h873+Ve24RWPiJ7RnmahSc3MYHwhjE4hxfW8MaPCQZaa3Me244lVJcRJ
   tw4vLsQxEOZ8pccABPryyed1v72ZYuRFeU8lDwV5VKjDZs4C4D+yp38qa
   a/eUHVdgxugG/LgzkA4MpG89I7lAa3gmGih/y/Dv1S9y0fRWzIJ1VzObD
   vZrRHIhT8C4+X5UCJc50nfpf8IdOFDuY3jte5nIwtLcCV0F2TiZOMsmXH
   p3+vZcxWqJOrHeV5rhcR34WsekLbYCiHHZdLi7zJfLAkaPAGtK3SXz49V
   3oOhsM1VxxIic4kt5efaL4ZA5QSQd6bgw2tVNiCkxm7p9bWIm81Ev7Sfm
   Q==;
IronPort-SDR: ZoZ+nI/wsZeYVRPBx+aV6O5YDDBDF00oohmnwoe5Tq2WRFRZZZw/bRcHCCDasDdX3TyS84B569
 +dtzZ1IU3bg0MyRfbqSkNIxrTOA8Hu4WA52b8V9BRpDk5OPqQnI7Pw4kbxM1W914bmcb0mOMn/
 6Esd1XkIowklYg4gCE6Jqgsz1h6pHzqqxMGu8ye/phYxdjKIeLLQPQHzQzURQh9pEaTi8nJ2xM
 Nm3jA+KxkwV950vwtG1YPL/d/K5igl6/7w89gyelHdvZvYQ57CUH+Z6HC0/vcDJEHzI/xKsECW
 cKU=
X-IronPort-AV: E=Sophos;i="5.81,287,1610434800"; 
   d="scan'208";a="111696168"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Mar 2021 03:01:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 29 Mar 2021 03:01:19 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 29 Mar 2021 03:01:17 -0700
From:   <nicolas.ferre@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        <emil.velikov@collabora.com>, <ezequiel@collabora.com>
Subject: [PATCH 7/7] ARM: configs: at91: Modernize UBI defconfig part
Date:   Mon, 29 Mar 2021 11:56:45 +0200
Message-ID: <4136c4443efce6f028eca74885870ac649981da1.1617010856.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1617010856.git.nicolas.ferre@microchip.com>
References: <cover.1617010856.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

UBI_GLUEBI is not so common and UBI_FASTMAP is used for several years.
Make them part of a modernization of UBI defconfig options.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/configs/at91_dt_defconfig | 2 +-
 arch/arm/configs/sama5_defconfig   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index e033d08c9cda..06c888a45eb3 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -54,7 +54,7 @@ CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_ATMEL=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=y
-CONFIG_MTD_UBI_GLUEBI=y
+CONFIG_MTD_UBI_FASTMAP=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=4
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 99d167623940..17db3b3e2dd3 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -63,7 +63,7 @@ CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_ATMEL=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=y
-CONFIG_MTD_UBI_GLUEBI=y
+CONFIG_MTD_UBI_FASTMAP=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=4
-- 
2.31.1

