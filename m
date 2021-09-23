Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F66415F65
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241238AbhIWNWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:22:36 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:42888 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbhIWNWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632403262; x=1663939262;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9N1lv2IZqeZ+Ad8n/m48CMIMqK900tNEnc8eqaH81QM=;
  b=LwZCdlKc9c6Cps7af6fKKg+HPTy/qLJ2+TI9hhr4rUb9DcZHGco974WW
   Wx/SHdRzVLysdQdip639PMaSqvI1whRvNZl++a1Q0/JpEkGlF3vWNz7PX
   7ArFxCpAGttGp4PY34ejQaGvEJnp5PwQTzYtWl0bNulfoGoz7Swg8wtj9
   H7W4f0k/A0TqwnUZC7mEe61DkutU/htuclzuHbJcy0K92UrTLedy/Vjwb
   J5GfjUzHDHPeVfnjlMy3xY5bVoF413eaEKnwWG4jJK8jW2dtkozjFVuwe
   kPvXPYi1F5op/eRtPvxnN7PSrF2Z45u8uf+KNbm+8DW/MA2BsbjgoupMa
   Q==;
IronPort-SDR: Y9MSNGID6mjqjXUqisMujfSgKNM6xlMtrzZbMeeBVkOydtff8CGRjh+DsB2ZjKWjiouD3rcMBS
 5qISmD+sZIQlHn1bzfwJ3zQR5NGPu1/syDb40pZpKsRQ/Ls38C11EGx/KWMSa6kKItrD6x/zw8
 zjpsX6f57/nJd69+UBHDhzGAAu3IT2zcSCCaw0jI4eBJi+aDlppnEsx0ZtsOQTf6folmqGMe9B
 FKuaafLS097YDwuWKUjSwaF+0MblYoF11CoBi+1dP5iXfqrI4FQuuLjLHeV4riMJCFuGHY+MVt
 u90765eAYUumChUzcskYYvJ7
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="137664761"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Sep 2021 06:21:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 23 Sep 2021 06:21:01 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 23 Sep 2021 06:20:59 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 00/17] clk: at91: updates for power management and dvfs
Date:   Thu, 23 Sep 2021 16:20:29 +0300
Message-ID: <20210923132046.1860549-1-claudiu.beznea@microchip.com>
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
save_context()/restore_context() on each clock driver (patch 1/17). Since
the PM part is necessary only for backup mode (supported on SAMA5D2 and
SAMA7G5) the pmc.c has been adapted to call the
save_context()/restore_context() only on switches to/from backup mode
(patch 2/17).

Patch 3/17 adds the securam clock on SAMA7G5. This is necessary for
backup mode of SAMA7G5.

Patch 4/17 adapt SAMA7G5 MCK1..4 driver to use the defines at
include/linux/clk/at91_pmc.h introduced in commit ec03f18cc222
("clk: at91: add register definition for sama7g5's master clock").

Patch 5/17 improves a bit readabiblity in some places of master clock
driver.

Patch 6/17 enable the suspend/resume for clocks also for SAMA7G5.

Patches 7-10/17 adds fixes in master clock driver and sam9x60-pll driver.

Patches 11-12/17 address DVFS by adding notifiers for master clock driver
and sam9x60-pll driver to avoid overclocking for CPU domain and MCK0
domain.

Patch 13/17 removes the master clock prescaler from Linux clock tree
as it has been discovered a hardware bug on it and it may not lock
on some scenario although its output clock is stable.

Patch 14/17 decreases the low limit of MCK0 as it can go even to 32KHz.

Patch 15/17 uses clk_core_get_rate_recalc() in clk_rate_get().

Patches 16-17/17 adds minor cleanups on clk.c

Stephen,

I added everything in one series and didn't send at 1st the non-DVFS
patches (as you suggested in [2]) as at the time of proposal patch 4/17
here depended on commit ec03f18cc222 ("clk: at91: add register definition
for sama7g5's master clock") which wasn't present on your tree at that
time.

Thank you,
Claudiu Beznea

[1] https://lore.kernel.org/lkml/20210105104426.4tmgc2l3vyicwedd@vireshk-i7/
[2] https://lore.kernel.org/lkml/163047507296.42057.10597374695758699868@swboyd.mtv.corp.google.com/ 

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


Claudiu Beznea (17):
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
  clk: remove extra empty line
  clk: do not initialize ret

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
 drivers/clk/at91/pmc.c              | 183 +++--------
 drivers/clk/at91/pmc.h              |  29 +-
 drivers/clk/at91/sam9x60.c          |   6 +-
 drivers/clk/at91/sama5d2.c          |   2 +-
 drivers/clk/at91/sama5d3.c          |   2 +-
 drivers/clk/at91/sama5d4.c          |   2 +-
 drivers/clk/at91/sama7g5.c          |  29 +-
 drivers/clk/clk.c                   |   5 +-
 25 files changed, 899 insertions(+), 316 deletions(-)

-- 
2.25.1

