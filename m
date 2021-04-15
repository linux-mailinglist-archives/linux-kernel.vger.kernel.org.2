Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04AA36078B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhDOKvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:51:07 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:65507 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhDOKvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1618483843; x=1650019843;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sHNXguuv2AsybwGIwlmWK3OpD0jz+l0cgkpDopfwnZU=;
  b=jG7wV7NM/1W2aaVQCwgDlRimip8Tx0P8qbz71Cu2Co5yBEbMAe6K8Lys
   lsJUXuHm0RSg0ITW8kbEoeNZfd+h1t0DaeD2nikZaZ5Ige/Iqcf8Wr0SR
   op5pEp0PgydjxHtSYHaz1J/Q525DRG56k8YW2MBxIIQfTA0r7qiWzvwI7
   960EiLBiMhftr+ajzomp1aoYZ9+HQ9V08SyTufZMM3urL41YmJ1TkCvga
   KTDTymqjVpnIHjEth81rqQInbOiuIzALNSIZNqdEy3m0mGJmbs5ToUsXC
   I7mT9y6Yy3DvRgUjrH1HVyKcRSJO8swD088sGuDBrXb60HMAB5FBtyzg2
   g==;
IronPort-SDR: YN7MNPJF+QGGxTNfo+SRqLAR5MpT6bTHDgm2Zv3YWCCevTzh1xcEbN4zY4NYzORsDO7lODKg6c
 BQizWeRwrLTrIxsnn8TTjiK9LJTOqmBGlrON3q0cM+H/yLbDdZFoouwsExLKDmCiTKU4uFQsg0
 880gjxU7kDAdVtzhD1NDLth7bFkQCbvhT+cHEtrenYnjrrNpHDNpYKR8ArTHtDg1oLPYeaxcFz
 J0Vxutw7QBbVr/epJSG7csD34wxzCClYZTAzfztHvVcHYJ9y8Ns6NQH4riYdoDXk9DM5+4Uzfu
 pTs=
X-IronPort-AV: E=Sophos;i="5.82,223,1613458800"; 
   d="scan'208";a="117122020"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Apr 2021 03:50:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Apr 2021 03:50:42 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 15 Apr 2021 03:50:38 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 00/24] ARM: at91: pm: add support for sama7g5
Date:   Thu, 15 Apr 2021 13:49:46 +0300
Message-ID: <20210415105010.569620-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds PM support for SAMA7G5. The standby, ulp0, ulp1, and
backup modes are supported.

Thank you,
Claudiu Beznea

Changes in v3:
- drop: status = "okay" in patch 16/24

Changes in v2:
- keep only the generic sama7_dt in patch 22/24 and adapt patch 23/24
- collected tags

Claudiu Beznea (23):
  ARM: at91: pm: move pm_bu to soc_pm data structure
  ARM: at91: pm: move the setup of soc_pm.bu->suspended
  ARM: at91: pm: document at91_soc_pm structure
  ARM: at91: pm: check for different controllers in at91_pm_modes_init()
  ARM: at91: pm: do not initialize pdev
  ARM: at91: pm: use r7 instead of tmp1
  ARM: at91: pm: avoid push and pop on stack while memory is in
    self-refersh
  ARM: at91: pm: s/CONFIG_SOC_SAM9X60/CONFIG_HAVE_AT91_SAM9X60_PLL/g
  ARM: at91: pm: add support for waiting MCK1..4
  ARM: at91: sfrbu: add sfrbu registers definitions for sama7g5
  ARM: at91: ddr: add registers definitions for sama7g5's ddr
  ARM: at91: pm: add self-refresh support for sama7g5
  ARM: at91: pm: add support for MCK1..4 save/restore for ulp modes
  ARM: at91: pm: add support for 2.5V LDO regulator control
  ARM: at91: pm: wait for ddr power mode off
  dt-bindings: atmel-sysreg: add bindings for sama7g5
  ARM: at91: pm: add sama7g5 ddr controller
  ARM: at91: pm: add sama7g5 ddr phy controller
  ARM: at91: pm: save ddr phy calibration data to securam
  ARM: at91: pm: add backup mode support for SAMA7G5
  ARM: at91: pm: add sama7g5's pmc
  ARM: at91: pm: add pm support for SAMA7G5
  ARM: at91: pm: add sama7g5 shdwc

Eugen Hristev (1):
  ARM: at91: sama7: introduce sama7 SoC family

 .../devicetree/bindings/arm/atmel-sysregs.txt |  14 +-
 arch/arm/mach-at91/Makefile                   |   1 +
 arch/arm/mach-at91/generic.h                  |   2 +
 arch/arm/mach-at91/pm.c                       | 343 ++++++--
 arch/arm/mach-at91/pm.h                       |   3 +
 arch/arm/mach-at91/pm_data-offsets.c          |   2 +
 arch/arm/mach-at91/pm_suspend.S               | 827 +++++++++++++-----
 arch/arm/mach-at91/sama7.c                    |  33 +
 include/soc/at91/sama7-ddr.h                  |  80 ++
 include/soc/at91/sama7-sfrbu.h                |  34 +
 10 files changed, 1049 insertions(+), 290 deletions(-)
 create mode 100644 arch/arm/mach-at91/sama7.c
 create mode 100644 include/soc/at91/sama7-ddr.h
 create mode 100644 include/soc/at91/sama7-sfrbu.h

-- 
2.25.1

