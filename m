Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2C134FEDF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbhCaK7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 06:59:48 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:40036 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235138AbhCaK7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617188353; x=1648724353;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tV1IHHwxHo+23pny/S3PfV0lwm90D0exK7+vUd55pmU=;
  b=kt78119mrpn1+MKzOKLQxFRp9vtsxpox2f80q8oHdVmxRot5Kl3jQDbf
   hsCI7WXx4uCJFs5GobRAA6mAuZq0QXOyMU++PluFFKgdWzO2Oo1qW72JH
   sUkxWjYEsgvCnpH6d6TXaZMGVmLdzJyz3My2xPw7pUu9gX49LPUocnCGs
   ugkOBe6Uugeu2aljfEFtTxdoUwo6M1/Zxs2QFGdnQVaFJc2a3LaT6byMC
   LfpHoCuP3WXIrpAjX3zIjyyx7Rl3K8LsHa+xZRwvdaIv3LTOMAEd5YqQi
   8HpVp1x5Z+Te+LfXlHUoVBBNtRh7g++yhyaQRHE0/efKLoPBbCO2z2a0B
   g==;
IronPort-SDR: wq8NtblxQ506lJV4tYzPoCJavkrGMtoLFq1E+Mf2u0dpBnpJa5sJN30E2XLSFx55dC1dK0Tc0B
 o5oRuT7kHw7QVyJK6ggX0RKM84gWrMsshs6v8qspcs5WROJWYsEw8NehMfadFUOsfDUYHDV415
 pihJPZPAAkw7Zbu2IsisiFFrj0xIoF9/FPKo+CVkfyK4GOJO7TPOPuZ5jPodj63LwK9M23A9kA
 ofUnl/zXJjPYtCu00tMDEzkdKe6HI7Yp6bl6Ht+maQzydlb7SXGu/wcS9C8EGGOQSHuCkvv0Mc
 Hgc=
X-IronPort-AV: E=Sophos;i="5.81,293,1610434800"; 
   d="scan'208";a="115333279"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2021 03:59:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 31 Mar 2021 03:59:12 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 31 Mar 2021 03:59:10 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 00/24] ARM: at91: pm: add support for sama7g5
Date:   Wed, 31 Mar 2021 13:58:44 +0300
Message-ID: <20210331105908.23027-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
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

 .../devicetree/bindings/arm/atmel-sysregs.txt |  15 +-
 arch/arm/mach-at91/Makefile                   |   1 +
 arch/arm/mach-at91/generic.h                  |   2 +
 arch/arm/mach-at91/pm.c                       | 343 ++++++--
 arch/arm/mach-at91/pm.h                       |   3 +
 arch/arm/mach-at91/pm_data-offsets.c          |   2 +
 arch/arm/mach-at91/pm_suspend.S               | 827 +++++++++++++-----
 arch/arm/mach-at91/sama7.c                    |  49 ++
 include/soc/at91/sama7-ddr.h                  |  80 ++
 include/soc/at91/sama7-sfrbu.h                |  34 +
 10 files changed, 1066 insertions(+), 290 deletions(-)
 create mode 100644 arch/arm/mach-at91/sama7.c
 create mode 100644 include/soc/at91/sama7-ddr.h
 create mode 100644 include/soc/at91/sama7-sfrbu.h

-- 
2.25.1

