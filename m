Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65536428BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbhJKL3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:29:32 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:61300 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhJKL3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633951652; x=1665487652;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DlAv5sayhPu+EI8WewXPhpt7h0/Q9kN/IpzGmaVkuQU=;
  b=bJjLLkNzcNqNg9m7MhGNXVF/VsyfAXwgvtAvuIDlNxD7mLEsxkmLQA47
   9QCzfx6x50ChWR2fWQiEsSZXQbwG4XhvrYm2IS535LnhiBIEHpbpUmOP6
   gXF4m6jxbSwdF+3XeO7Ju4UgfRjqoL2ElPayBxp2xt3HmdvWG7aLWucJn
   v7xHEkI3DXzuPgPQIMq3S8CEk27yyF/arx0roh0iJZJFxKqs5oghcLhXH
   UIZxCSUJp8NxLQlRZCGwMN+n8e6N2bSTFc/1j+vaU0QGIkQwkejeVM5n7
   VtD92wKR7pNcP0cs7g11SF1BFK4xhMMVRTqQ1gHBdbtT10NYNFx6Zyd5C
   A==;
IronPort-SDR: TFpPcnuuQGFR5uvefkP0o/OCPN9NYnbJdhxDPe/oZrz3W97hHTCrnsJwXxmpf54sD3AFhPbg4q
 qzOvPuLIOzVNIBvLjhtZDXvNZ8aiiVPwMgiB9xihfVaQztzxyUJNQJKwKtFfokmzQQMX00rJO8
 yjk7g0AtU3Cj0okJDPfFdRUUyJCP/4asxhI27c3ROiKusmhaVULIjQ0WBOBg61NZGiaKpqVaVV
 vKVsLEJqovHCC7KhZNmPhp8XELVG9jwjsk8cgzzQBzS6Z6t72Rxljyo8p9NjhaLcCHDDXzhwAk
 W0U1Kyh8IgWwI0aVDEGZ5nKU
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="139244660"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Oct 2021 04:27:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 11 Oct 2021 04:27:30 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 11 Oct 2021 04:27:28 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v5 00/15] clk: at91: updates for power management and dvfs
Date:   Mon, 11 Oct 2021 14:27:04 +0300
Message-ID: <20211011112719.3951784-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series addresses the clock power management for SAMA7G5 and also
updates the master clock driver and sam9x60-pll driver to accommodate
the requests at [1] and avoid overclocking of CPU and MCK0 domains while
changing the frequency via DVFS.

The power management part is implemented by adding
save_context()/restore_context() on each clock driver (patch 1/15). Since
the PM part is necessary only for backup mode (supported on SAMA5D2 and
SAMA7G5) the pmc.c has been adapted to call the
save_context()/restore_context() only on switches to/from backup mode
(patch 2/15).

Patch 3/15 adds the securam clock on SAMA7G5. This is necessary for
backup mode of SAMA7G5.

Patch 4/15 adapt SAMA7G5 MCK1..4 driver to use the defines at
include/linux/clk/at91_pmc.h introduced in commit ec03f18cc222
("clk: at91: add register definition for sama7g5's master clock").

Patch 5/15 improves a bit readabiblity in some places of master clock
driver.

Patch 6/15 enable the suspend/resume for clocks also for SAMA7G5.

Patches 7-10/15 adds fixes in master clock driver and sam9x60-pll driver.

Patches 11-12/15 address DVFS by adding notifiers for master clock driver
and sam9x60-pll driver to avoid overclocking for CPU domain and MCK0
domain.

Patch 13/15 removes the master clock prescaler from Linux clock tree
as it has been discovered a hardware bug on it and it may not lock
on some scenario although its output clock is stable.

Patch 14/15 decreases the low limit of MCK0 as it can go even to 32KHz.

Patch 15/15 uses clk_core_get_rate_recalc() in clk_rate_get().

Thank you,
Claudiu Beznea

[1] https://lore.kernel.org/lkml/20210105104426.4tmgc2l3vyicwedd@vireshk-i7/
[2] https://lore.kernel.org/lkml/163047507296.42057.10597374695758699868@swboyd.mtv.corp.google.com/ 

Changes in v5:
- dropped patches 16/17, 17/17 from previous version
- in patch 02/15:
	- use read_relaxed() to get the value at address pointed by 
	  at91_pmc_backup_suspend
	- removed of_find_device_by_node() from pmc_register_ops() since its
	  returned value was not used in the function (of_device_is_available()
	  is enough to know before mapping securam). of_find_device_by_node()
	  was the one which needed the changes of postcore_initcall() with
	  subsys_initcall() (as described in commit description from v4) thus
	  kept the postcore_initcall(); also updated the commit description
	  to reflect this.

Changes in v4:
- removed opp dependencies along with get_cpu_device() in patch 11/17 as
  those functionalities are not available at the initialization time for
  clocks instantiated with CLK_OF_DECLARE

Changes in v3:
- minor fixes in patch 1/7 (e.g. use regmap_read() + checks + update +
  regmap_write() sequence instead of regmap_read() + checks +
  regmap_update_bits()
- patch 4/17 has been updated after commit ec03f18cc222
  ("clk: at91: add register definition for sama7g5's master clock")
- patch 6-10/17, 14-17/17 are newly introduced
- notifier for sam9x60 div pll was introduced (patch 11/17) and
  notifier logic for master clock div has been changed (patch 12/17)
  to use safe divider on PRE_RATE_CHANGE events and update clock to highest
  possible rate on POST_RATE_CHANGE events
- master clock prescaler has been removed from Linux clock tree for
  SAMA7G5

Changes in v2:
- addressed code review comments
- collected tags

Claudiu Beznea (15):
  clk: at91: re-factor clocks suspend/resume
  clk: at91: pmc: execute suspend/resume only for backup mode
  clk: at91: sama7g5: add securam's peripheral clock
  clk: at91: clk-master: add register definition for sama7g5's master
    clock
  clk: at91: clk-master: improve readability by using local variables
  clk: at91: pmc: add sama7g5 to the list of available pmcs
  clk: at91: sam9x60-pll: use DIV_ROUND_CLOSEST_ULL
  clk: at91: clk-master: check if div or pres is zero
  clk: at91: clk-master: mask mckr against layout->mask
  clk: at91: clk-master: fix prescaler logic
  clk: at91: clk-sam9x60-pll: add notifier for div part of PLL
  clk: at91: clk-master: add notifier for divider
  clk: at91: sama7g5: remove prescaler part of master clock
  clk: at91: sama7g5: set low limit for mck0 at 32KHz
  clk: use clk_core_get_rate_recalc() in clk_rate_get()

 drivers/clk/at91/at91rm9200.c       |   2 +-
 drivers/clk/at91/at91sam9260.c      |   2 +-
 drivers/clk/at91/at91sam9g45.c      |   2 +-
 drivers/clk/at91/at91sam9n12.c      |   2 +-
 drivers/clk/at91/at91sam9rl.c       |   2 +-
 drivers/clk/at91/at91sam9x5.c       |   2 +-
 drivers/clk/at91/clk-generated.c    |  46 ++-
 drivers/clk/at91/clk-main.c         |  66 ++++
 drivers/clk/at91/clk-master.c       | 463 ++++++++++++++++++++++------
 drivers/clk/at91/clk-peripheral.c   |  40 ++-
 drivers/clk/at91/clk-pll.c          |  39 +++
 drivers/clk/at91/clk-programmable.c |  29 +-
 drivers/clk/at91/clk-sam9x60-pll.c  | 174 +++++++++--
 drivers/clk/at91/clk-system.c       |  20 ++
 drivers/clk/at91/clk-usb.c          |  27 ++
 drivers/clk/at91/clk-utmi.c         |  39 +++
 drivers/clk/at91/dt-compat.c        |   2 +-
 drivers/clk/at91/pmc.c              | 173 +++--------
 drivers/clk/at91/pmc.h              |  29 +-
 drivers/clk/at91/sam9x60.c          |   6 +-
 drivers/clk/at91/sama5d2.c          |   2 +-
 drivers/clk/at91/sama5d3.c          |   2 +-
 drivers/clk/at91/sama5d4.c          |   2 +-
 drivers/clk/at91/sama7g5.c          |  29 +-
 drivers/clk/clk.c                   |   2 +-
 25 files changed, 890 insertions(+), 312 deletions(-)

-- 
2.25.1

