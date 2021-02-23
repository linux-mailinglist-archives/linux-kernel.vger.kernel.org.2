Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CC2322838
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 10:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbhBWJ6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 04:58:36 -0500
Received: from lucky1.263xmail.com ([211.157.147.135]:60100 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbhBWJ4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 04:56:19 -0500
Received: from localhost (unknown [192.168.167.130])
        by lucky1.263xmail.com (Postfix) with ESMTP id DA6D7A7521;
        Tue, 23 Feb 2021 17:53:55 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P21323T140439055234816S1614074035264055_;
        Tue, 23 Feb 2021 17:53:56 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <4718419ea0cf12351627ef3878a0b8c1>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: sboyd@kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     sboyd@kernel.org, heiko@sntech.de
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, tony.xie@rock-chips.com,
        finley.xiao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v1 0/4] clk: rockchip: add clock controller for rk3568
Date:   Tue, 23 Feb 2021 17:53:48 +0800
Message-Id: <20210223095352.11544-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clock tree definition for the new rk3568 SoC

Elaine Zhang (4):
  dt-bindings: add bindings for rk3568 clock controller
  clk: rockchip: add dt-binding header for rk3568
  clk: rockchip: support more core div setting
  clk: rockchip: add clock controller for rk3568

 .../bindings/clock/rockchip,rk3568-cru.txt    |   66 +
 drivers/clk/rockchip/Kconfig                  |    7 +
 drivers/clk/rockchip/Makefile                 |    1 +
 drivers/clk/rockchip/clk-cpu.c                |   25 +
 drivers/clk/rockchip/clk-rk3568.c             | 1724 +++++++++++++++++
 drivers/clk/rockchip/clk.h                    |   45 +-
 include/dt-bindings/clock/rk3568-cru.h        |  926 +++++++++
 7 files changed, 2793 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.txt
 create mode 100644 drivers/clk/rockchip/clk-rk3568.c
 create mode 100644 include/dt-bindings/clock/rk3568-cru.h

-- 
2.17.1



