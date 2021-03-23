Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0533459A2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 09:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCWIZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 04:25:18 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:48622 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhCWIYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 04:24:36 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 12983C7D2B;
        Tue, 23 Mar 2021 16:24:21 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P13109T139928883160832S1616487860290898_;
        Tue, 23 Mar 2021 16:24:22 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <40834fb20227d1c9f63301016460590d>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: robh+dt@kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     robh+dt@kernel.org, heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, tony.xie@rock-chips.com,
        finley.xiao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 0/3] soc: rockchip: power-domain: add rk3568 powerdomains
Date:   Tue, 23 Mar 2021 16:24:07 +0800
Message-Id: <20210323082410.22818-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support power domain function for RK3568 Soc.

Change in V2:
[PATCH v2 1/3]: No change.
[PATCH v2 2/3]: Fix up yaml code styles.
[PATCH v2 3/3]: No change.

Elaine Zhang (3):
  dt-bindings: add power-domain header for RK3568 SoCs
  dt-bindings: Convert the rockchip power_domain to YAML and extend
  soc: rockchip: power-domain: add rk3568 powerdomains

 .../bindings/soc/rockchip/power_domain.txt    | 136 ---------
 .../rockchip/rockchip,power-controller.yaml   | 259 ++++++++++++++++++
 drivers/soc/rockchip/pm_domains.c             |  31 +++
 include/dt-bindings/power/rk3568-power.h      |  32 +++
 4 files changed, 322 insertions(+), 136 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
 create mode 100644 Documentation/devicetree/bindings/soc/rockchip/rockchip,power-controller.yaml
 create mode 100644 include/dt-bindings/power/rk3568-power.h

-- 
2.17.1



