Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E93D420A44
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 13:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhJDLpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 07:45:50 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:16136 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhJDLpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 07:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633347840; x=1664883840;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vGeMwNRV/2/W5R1Qp12fVG3McJPmmla7XyPNWUNtpTo=;
  b=GqO5wIAXV6jr/0uwIs806573ZAg4kmdBC9Ao7U3Ok86njg5xxQ9PMpTn
   yicSRseo1eTrUhoM2WOjnuISDCso7g2S00gV7WmMFDzsBCqfVtYAU4a8q
   QOr2Uz5T+l8MWX75d1h2BdbgP06OCQDoL2u7h83mv5Xa36BPVohXyLkAv
   Rj8mp8OM/ehYiPjSnCgMIYOgwK7Eq6vaNJjG6/B/vnGmg1kO7LmfXT0TH
   GITWqnCT8FjYlORtNBnyQ0q7rDeiNlnJHeFlLlv/3uIyfIYkyLOYAIVOC
   LyJIdvRBpWtjbygaHCCcPoHOivGkDOCGdKomD5fHmxCDdR/HaUg58/ZeD
   g==;
IronPort-SDR: vXN74bjB7Ak1a64o8pv8oj375gh67+Tl19sq0IXcAoGPp42ScWyzBHsWD+SnySIgxoCSqw0Q9X
 QAc+hjBqqgetfyHbDGSY1sgYD2ALCz3Ahx1A5lwDdgvSNKKWAq9vc2qhMmgBWwHvo0aIfN43Bv
 XKPjS3QusQtxpRjMsfrWP+75BBYhW+MaNy+D1Kmg5ebj+7trvXx2rpmwnlae788bapgcwe+Yxb
 uC+WKrcyXy1XfSHMPZose1uWXYqf8UYi4U3McY6J/GsK+R2bEEARyI5XMYjFMYchB13KXI+Zlr
 uGJ3lFGA6A6VO3HYngY6WMOF
X-IronPort-AV: E=Sophos;i="5.85,345,1624345200"; 
   d="scan'208";a="71603582"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Oct 2021 04:43:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 4 Oct 2021 04:43:59 -0700
Received: from ness.home (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Mon, 4 Oct 2021 04:43:57 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [GIT PULL] ARM: at91: fixes for 5.15 #2
Date:   Mon, 4 Oct 2021 13:43:44 +0200
Message-ID: <20211004114344.19304-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Organization: microchip
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Arnd, Olof,

Here is the second batch of fixes for 5.15.
It goes on top of previous PR at:
https://lore.kernel.org/linux-arm-kernel/20210914162314.54347-1-nicolas.ferre@microchip.com/

Thanks, best regards,
  Nicolas

The following changes since commit 4348cc10da6377a86940beb20ad357933b8f91bb:

  ARM: dts: at91: sama5d2_som1_ek: disable ISC node by default (2021-09-14 17:05:40 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-fixes-5.15-2

for you to fetch changes up to dbe68bc9e82b6951ff88285ccffc191d872d9a01:

  ARM: dts: at91: sama7g5ek: to not touch slew-rate for SDMMC pins (2021-10-04 12:16:58 +0200)

----------------------------------------------------------------
AT91 fixes #2 for 5.15:

- More fixes for AT91 platform power management code related to the
  introduction of sama7g5:
  - management of DDR3L regulator rails for sama7g5ek
  - loading of TLB on different cores

- PIO controller slew-rate settings for sama7g5ek: be aligned with
  datasheet requirements.

----------------------------------------------------------------
Claudiu Beznea (5):
      ARM: dts: at91: sama7g5ek: add suspend voltage for ddr3l rail
      ARM: at91: pm: group constants and addresses loading
      ARM: at91: pm: preload base address of controllers in tlb
      ARM: dts: at91: sama7g5ek: use proper slew-rate settings for GMACs
      ARM: dts: at91: sama7g5ek: to not touch slew-rate for SDMMC pins

 arch/arm/boot/dts/at91-sama7g5ek.dts | 36 +++++++++++++++++++++++++-----
 arch/arm/mach-at91/pm_suspend.S      | 42 +++++++++++++++++++++++++++--------
 2 files changed, 63 insertions(+), 15 deletions(-)

-- 
Nicolas Ferre
