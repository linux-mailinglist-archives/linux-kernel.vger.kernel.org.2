Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19C33F4B8F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 15:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbhHWNUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 09:20:04 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:58043 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236614AbhHWNUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 09:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629724761; x=1661260761;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NN+RmRO+ICIl+sv2UO9mWnmI/qOtLU3PVSl7VwGkagU=;
  b=dRVbGXDqGacBIQ/GrXq6Q00cGBHjK5dvsluSZzC8CeRpWI9j0x6f6bKq
   L3273kRORcoZUEXj2DpFAVvu6iYlvUQx6d4jHjzghLpfcOfQXHDFdwFHd
   vEpqH7KXlwaQsJyMQ+4ywogpUOMK6at1r7mA7SwQhaRVDoKGRhPWwup/G
   YsdlnYPcqIgvyBSzkvu9ypXLYjEhHY0GAv7J7u/AqBwVlRxp2ecLIQUaP
   WdQqfk6K+RIZCgGiByT5YznZ8YHkayKzAf2mg7aAeC+ynv0pbHzywvIy5
   vv8lpGlhPtvZqxdVD8txth3LqpuVqKldG+qVqOfXgDEdGhRr40sqS3cbt
   Q==;
IronPort-SDR: Dn53Ca7DIJTDalHurftDyM8bf5t4Gu/vawhLk8HxgQ6PxJYKiHsg9GTKre/Yijiclpi2IKxgsu
 pROrxOKPm1flCovMtRTD4kjTksKyRh+l0TIiGY6I6A43US82T3zr6QfwjPCi6B/UbjG2aGTGPr
 blM+FC0DJoyqLrB8vFEKtB3jLJr0Tz4lWDHxwMonKCDLFpCJbl6mNGJYRkVzvwSA/i8c9C1xgc
 Kx+aJ6QSn441b6S2W9CEKFQt290N5DA/w7uy966Yva3IRzBgF0E0kxW6QikyYDSfIBTDWBYxRl
 JBChXM4zWOMuOjgL7s43gI1L
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="141194692"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2021 06:19:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 23 Aug 2021 06:19:20 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 23 Aug 2021 06:19:17 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 0/4] ARM: at91: add new nodes to DT and fix for PM
Date:   Mon, 23 Aug 2021 16:19:11 +0300
Message-ID: <20210823131915.23857-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patches enable UDDRC, DDR3 PHY, SECURAM and SHDWC IPs
on SAMA7G5.

Besides this patch 1/1 avoid the panic on PM initialization code allowing
the system to boot when PM is enabled but not enough information is
provided in DT.

Thank you,
Claudiu Beznea

Changes in v2:
- changes cover letter title from
  "ARM: dts: at91: enable ips for sama7g5" to
  "ARM: at91: add new nodes to DT and fix for PM"
- update the device tree patches title and description
- added patch "ARM: at91: pm: do not panic if ram controllers are not
  enabled"

Claudiu Beznea (4):
  ARM: at91: pm: do not panic if ram controllers are not enabled
  ARM: dts: at91: sama7g5: add ram controllers
  ARM: dts: at91: sama7g5: add securam node
  ARM: dts: at91: sama7g5: add shdwc node

 arch/arm/boot/dts/at91-sama7g5ek.dts |  9 ++++
 arch/arm/boot/dts/sama7g5.dtsi       | 34 ++++++++++++
 arch/arm/mach-at91/pm.c              | 78 ++++++++++++++++++++++------
 3 files changed, 105 insertions(+), 16 deletions(-)

-- 
2.25.1

