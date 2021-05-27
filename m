Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5848C3927C3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 08:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhE0Gkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 02:40:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:11412 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229603AbhE0Gkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 02:40:43 -0400
IronPort-SDR: nf03rVZnlH+HuCuuO0mZOR5Ue6gYGq2LRlBM0HxZQUYZccIiGokYpruveNQuHxMCM/dHxSrpYs
 eS/2hlxAZDBA==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="202696284"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="202696284"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 23:39:10 -0700
IronPort-SDR: 9s8ZZSLVf35Oxu2yg4rPAGqgyQMAdQj7WTrsQnqd9RaPLk4FNQz50PwhHZN+1VUddttEquqG1c
 eRmaBTkpCEBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="615265850"
Received: from bspteam04.iind.intel.com ([10.106.46.142])
  by orsmga005.jf.intel.com with ESMTP; 26 May 2021 23:39:07 -0700
From:   shruthi.sanil@intel.com
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, kris.pan@linux.intel.com,
        mgross@linux.intel.com, srikanth.thokala@intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com, shruthi.sanil@intel.com
Subject: [PATCH v3 0/2] Add the driver for Intel Keem Bay SoC timer block
Date:   Thu, 27 May 2021 12:09:04 +0530
Message-Id: <20210527063906.18592-1-shruthi.sanil@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shruthi Sanil <shruthi.sanil@intel.com>

The timer block supports 1 64-bit free running counter
and 8 32-bit general purpose timers.

Patch 1 holds the device tree binding documentation.
Patch 2 holds the device driver.

This driver is tested on the Keem Bay evaluation module board.

I would like to inform that, I would be taking the ownership
of this patch series from this version.

Changes since v2:
- Add multi timer support.
- Update in the device tree binding to support multi timers.
- Code optimization.

Changes since v1:
- Add support for KEEMBAY_TIMER to get selected through Kconfig.platforms.
- Add CLOCK_EVT_FEAT_DYNIRQ as part of clockevent feature.
- Avoid overlapping reg regions across 2 device nodes.
- Simplify 2 device nodes as 1 because both are from same IP block.
- Adapt the driver code according to the new simplified devicetree.

Shruthi Sanil (2):
  dt-bindings: timer: Add bindings for Intel Keem Bay SoC Timer
  clocksource: Add Intel Keem Bay timer support

 .../bindings/timer/intel,keembay-timer.yaml   | 180 +++++++++++++
 MAINTAINERS                                   |   5 +
 drivers/clocksource/Kconfig                   |  11 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-keembay.c           | 255 ++++++++++++++++++
 5 files changed, 452 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
 create mode 100644 drivers/clocksource/timer-keembay.c


base-commit: ad9f25d338605d26acedcaf3ba5fab5ca26f1c10
-- 
2.17.1

