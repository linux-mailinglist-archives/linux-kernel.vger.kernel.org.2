Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFF4313234
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhBHMXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:23:42 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:52752 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbhBHMDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 07:03:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612785800; x=1644321800;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ktQ5H8JYp5ZgySkZR4VfvzwHO9Mgrs/mBdNMLYeZkxM=;
  b=Onwn1HUMmBtG8I7HFC5PwElzo8bdtjKjk/bvL0xdL2PHK2Rfxw0NGq0M
   HU2rm+tLkAPv1I+IxobOJSZEdR5niL1+ZltXMzweG8ktKhfswNkplTdWm
   /cPKx3WJXmckEiKlV8ttGz9s76Jqh8Pa/Wx1D2NlQce5LhhLXpioHIv3d
   EasvHXuLIVCImxC0EtNJyXSEpSA3Vtd5D79prEm6qEJ6JwjUeBUspRz3t
   OYIlKXhGOh4S1SUFTvzY0bj6tu/RXa6pUZXSYFfijzxTvDvGHbOrwLOvN
   UXpDXDv2wYN+AQJEsCIOKrSn+4Z+/iGLvEaFNttk1OF2+4J8qoZq+VBjE
   Q==;
IronPort-SDR: rb5GGXYKJ5kzLbBo/stIFUeaIMnmsV3zR5j4y77pvHVeAUZvBwQkajr3G6WGASlqK5CiWTM4Qw
 aSx/gxlnBcnwD5emNbzpDgy9iDfxgOTelfv+qU8J/p/QJcXKCm7ncyPSpD7JialLK7EwAHzkvu
 IQ4HNNTlwV9fL/nmNvaliYycyGSTZG03dQ6+G7bD1lfay2YFQV9chkW0Az/RDXtl3Hj0l7fEAY
 RRZ6sLAjBl5Rzhf88TOb1E3qFPklbzFGZJePc02r22Pxhna/FjDbm7ZqVdnpoWAg5nA6qjx0Ku
 C18=
X-IronPort-AV: E=Sophos;i="5.81,161,1610434800"; 
   d="scan'208";a="105816294"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Feb 2021 05:02:04 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 8 Feb 2021 05:02:04 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 8 Feb 2021 05:02:00 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [GIT PULL] ARM: at91: defconfig for 5.12 #2
Date:   Mon, 8 Feb 2021 12:57:53 +0100
Message-ID: <20210208115753.54730-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Organization: microchip
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Arnd, Olof,

Here is the second batch of defconfig changes for 5.12.

Thanks, best regards,
  Nicolas

The following changes since commit 00a1aa475f507454fab82f02c6230c8fb2312a12:

  ARM: configs: multi_{v5,v7}: remove ATMEL_TCLIB (2021-01-02 14:06:48 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-defconfig-5.11-2

for you to fetch changes up to b33f4da7b3efcb7521399d5e18cdd15e60ab34df:

  ARM: configs: sama5_defconfig: add QSPI driver (2021-02-08 09:55:00 +0100)

----------------------------------------------------------------
AT91 defconfig for 5.12, part 2:

- only at91_dt_defconfig and sama5_defconfig modified
- update to match current options, unneeded options removed
- missing drivers added, some are on-SoC peripherals, some are helpers
- modify legacy ATAGS or DT options to match common usage

----------------------------------------------------------------
Claudiu Beznea (1):
      ARM: configs: at91: enable drivers for sam9x60

Nicolas Ferre (5):
      ARM: configs: sama5_defconfig: update and remove unneeded options
      ARM: configs: at91: DT/ATAG defconfig modifications
      ARM: configs: at91_dt_defconfig: add useful helper options
      ARM: configs: at91_dt_defconfig: add ov7740 module
      ARM: configs: sama5_defconfig: add QSPI driver

 arch/arm/configs/at91_dt_defconfig | 17 ++++++++++++-----
 arch/arm/configs/sama5_defconfig   | 14 ++------------
 2 files changed, 14 insertions(+), 17 deletions(-)

-- 
Nicolas Ferre
