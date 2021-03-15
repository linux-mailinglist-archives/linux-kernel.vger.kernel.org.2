Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC9133AE12
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 09:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhCOI5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 04:57:12 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:57778 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhCOI4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:56:36 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 73002D0F79;
        Mon, 15 Mar 2021 16:56:11 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P13109T139929564739328S1615798570035027_;
        Mon, 15 Mar 2021 16:56:11 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <bb98c2b9af4f7bd12a95f263a5a8b7f1>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: mturquette@baylibre.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org,
        heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, tony.xie@rock-chips.com,
        finley.xiao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v5 0/4] clk: rockchip: add clock controller for rk3568
Date:   Mon, 15 Mar 2021 16:56:04 +0800
Message-Id: <20210315085608.16010-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clock tree definition for the new rk3568 SoC.

Change in V5:
[PATCH v5 1/4]: No change.
[PATCH v5 2/4]: No change.
[PATCH v5 3/4]: fix up the warning:
		>> drivers/clk/rockchip/clk-rk3188.c:187:67: warning:
		>> missing braces around initializer [-Wmissing-braces]
		187 | static const struct rockchip_cpuclk_reg_data
		rk3188_cpuclk_data = {
[PATCH v5 4/4]: No change.

Change in V4:
[PATCH v4 1/4]: No change.
[PATCH v4 2/4]: No change.
[PATCH v4 3/4]: No change.
[PATCH v4 4/4]: Drop parenthesis and module alias.

Change in V3:
[PATCH v3 1/4]: Fix some code styles.
[PATCH v3 2/4]: No change.
[PATCH v3 3/4]: No change.
[PATCH v3 4/4]: No change.

Change in V2:
[PATCH v2 1/4]: Convert rockchip,rk3568-cru.txt to YAML,
                And update commit message.
[PATCH v2 2/4]: No change.
[PATCH v2 3/4]: Use arrays to support more core independent div
settings.
[PATCH v2 4/4]: Adapter [PATCH v2 3/4] changes.

Elaine Zhang (4):
  dt-binding: clock: Document rockchip,rk3568-cru bindings
  clk: rockchip: add dt-binding header for rk3568
  clk: rockchip: support more core div setting
  clk: rockchip: add clock controller for rk3568

 .../bindings/clock/rockchip,rk3568-cru.yaml   |   60 +
 drivers/clk/rockchip/Kconfig                  |    7 +
 drivers/clk/rockchip/Makefile                 |    1 +
 drivers/clk/rockchip/clk-cpu.c                |   53 +-
 drivers/clk/rockchip/clk-px30.c               |    7 +-
 drivers/clk/rockchip/clk-rk3036.c             |    7 +-
 drivers/clk/rockchip/clk-rk3128.c             |    7 +-
 drivers/clk/rockchip/clk-rk3188.c             |   14 +-
 drivers/clk/rockchip/clk-rk3228.c             |    7 +-
 drivers/clk/rockchip/clk-rk3288.c             |    7 +-
 drivers/clk/rockchip/clk-rk3308.c             |    7 +-
 drivers/clk/rockchip/clk-rk3328.c             |    7 +-
 drivers/clk/rockchip/clk-rk3368.c             |   14 +-
 drivers/clk/rockchip/clk-rk3399.c             |   14 +-
 drivers/clk/rockchip/clk-rk3568.c             | 1725 +++++++++++++++++
 drivers/clk/rockchip/clk-rv1108.c             |    7 +-
 drivers/clk/rockchip/clk.h                    |   54 +-
 include/dt-bindings/clock/rk3568-cru.h        |  926 +++++++++
 18 files changed, 2846 insertions(+), 78 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml
 create mode 100644 drivers/clk/rockchip/clk-rk3568.c
 create mode 100644 include/dt-bindings/clock/rk3568-cru.h

-- 
2.17.1



