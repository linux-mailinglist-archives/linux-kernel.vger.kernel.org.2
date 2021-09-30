Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0923041DDCF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345756AbhI3PoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:44:16 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:31909 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345053AbhI3PoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633016553; x=1664552553;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n1AiGLe1CHr9FbYW3RUlxBigQhawVhWX5kiq5823Vvg=;
  b=HXZ4YaD0MEZd6+Dsb8EQkvMzEaLv710zbUYFM4fzbj2LZixtBKcF1TEs
   HPUAQzB/OOkgwrGCT74Ay2lmhnANFCMIGn8aC9lgOIUBcSMLzmEm4C+dI
   EsHaB8uQzY26bA7wPYwL/dWQuc2b8/mmKZMdLT81Fc+a8D0vYcTILGeN0
   eb+Rt2Wplk7L93e+GWVHm+bs8B74hh3+Jb8piSRchwYE+JCd+KSr9IKkC
   FkjajeAu3wmeNP9Yw5V1R1iG7xZf4cmfNwn70IoUoan7nTVT7E3uPz8Xb
   a070/55qbMmE3AUPM3pRpNm4BF8vrVZu2QlIkJrSOL7fE7WzMDq5g84YS
   A==;
IronPort-SDR: sxtetZVLS7GDqe0LyHTrxGvi6x8fRgXNsnNGO9Ifk17USK71NnhVB1c71XGaebuWX8Umc/ZuzS
 Y2ix+FsYAtNoF9NacN6we316wMmw+cZGHjjC3l5BkNFghoWquXV8H4q7ZaXjqGf8pP25UNZj8n
 6ESy297qOe4CR4rVLzSDhj0ORFq+ztO6tX9HHaXNGBf6scm5QMaMmXk+WnTv0n9681UWwFR+79
 G0LbGMfmlTjIXKJZZ+nH9b2Q6l/3eZ01Mx+TxET1/deyWOpSKthU1bLwH7Og0XfGOtTHMlLMfI
 5dFuHyKLb7GL25G0nKVCFtoS
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="146284142"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2021 08:42:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 30 Sep 2021 08:42:31 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 30 Sep 2021 08:42:29 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 0/3] ARM: at91: pm: fixes
Date:   Thu, 30 Sep 2021 18:42:16 +0300
Message-ID: <20210930154219.2214051-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following series adds fixes for AT91 platform power management 
code.

Thank you,
Claudiu Beznea

Changes in v2:
- removed fixes tag from patch 2/3 and edited commit description
- s/TBL/TLB/g in patch 3/3

Claudiu Beznea (3):
  ARM: dts: at91: sama7g5ek: add suspend voltage for ddr3l rail
  ARM: at91: pm: group constants and addresses loading
  ARM: at91: pm: preload base address of controllers in tlb

 arch/arm/boot/dts/at91-sama7g5ek.dts |  2 ++
 arch/arm/mach-at91/pm_suspend.S      | 42 ++++++++++++++++++++++------
 2 files changed, 35 insertions(+), 9 deletions(-)

-- 
2.25.1

