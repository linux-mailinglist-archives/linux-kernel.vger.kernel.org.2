Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978093277CA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 07:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhCAGvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 01:51:39 -0500
Received: from lucky1.263xmail.com ([211.157.147.132]:36764 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhCAGu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 01:50:29 -0500
Received: from localhost (unknown [192.168.167.70])
        by lucky1.263xmail.com (Postfix) with ESMTP id 5BF44F28BC;
        Mon,  1 Mar 2021 14:47:53 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P31655T140708449044224S1614581271100343_;
        Mon, 01 Mar 2021 14:47:52 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <d8ba457f321385b8562c37570316750f>
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
Subject: [PATCH v3 0/4] clk: rockchip: add clock controller for rk3568
Date:   Mon,  1 Mar 2021 14:47:45 +0800
Message-Id: <20210301064749.10392-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clock tree definition for the new rk3568 SoC.

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
 drivers/clk/rockchip/clk-rk3188.c             |    7 +-
 drivers/clk/rockchip/clk-rk3228.c             |    7 +-
 drivers/clk/rockchip/clk-rk3288.c             |    7 +-
 drivers/clk/rockchip/clk-rk3308.c             |    7 +-
 drivers/clk/rockchip/clk-rk3328.c             |    7 +-
 drivers/clk/rockchip/clk-rk3368.c             |   14 +-
 drivers/clk/rockchip/clk-rk3399.c             |   14 +-
 drivers/clk/rockchip/clk-rk3568.c             | 1726 +++++++++++++++++
 drivers/clk/rockchip/clk-rv1108.c             |    7 +-
 drivers/clk/rockchip/clk.h                    |   54 +-
 include/dt-bindings/clock/rk3568-cru.h        |  926 +++++++++
 18 files changed, 2843 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml
 create mode 100644 drivers/clk/rockchip/clk-rk3568.c
 create mode 100644 include/dt-bindings/clock/rk3568-cru.h

-- 
2.17.1



