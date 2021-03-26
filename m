Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A6A34A583
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 11:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhCZK2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 06:28:10 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:59812 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhCZK1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 06:27:49 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 949D5A8A3F;
        Fri, 26 Mar 2021 18:27:40 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P22964T140517867665152S1616754460486434_;
        Fri, 26 Mar 2021 18:27:41 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f157e6d359adce75cf1c39877979e8e8>
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
Subject: [PATCH v6 00/11] soc: rockchip: power-domain: add rk3568 powerdomains
Date:   Fri, 26 Mar 2021 18:27:27 +0800
Message-Id: <20210326102738.14767-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix power-controller node names for dtbs_check.
Convert power domain documentation to json-schema.
Add a meaningful power domain name.
Support power domain function for RK3568 Soc.

Change in V6:
[PATCH v6 1/11]: No change.
[PATCH v6 2/11]: No change.
[PATCH v6 3/11]: No change.
[PATCH v6 4/11]: No change.
[PATCH v6 5/11]: No change.
[PATCH v6 6/11]: No change.
[PATCH v6 7/11]: Use kbasename(node->full_name).
[PATCH v6 8/11]: No change.
[PATCH v6 9/11]: Update the commit message.
[PATCH v6 10/11]: No change.
[PATCH v6 11/11]: No change.

Change in V5:
[PATCH v5 1/11]: New.
[PATCH v5 2/11]: New.
[PATCH v5 3/11]: New.
[PATCH v5 4/11]: New.
[PATCH v5 5/11]: New.
[PATCH v5 6/11]: New.
[PATCH v5 7/11]: New.
[PATCH v5 8/11]: No change. Same as [PATCH v4 1/4].
[PATCH v5 9/11]: [PATCH v4 2/4] Fix up yaml code styles.
[PATCH v5 10/11]: No change. Same as [PATCH v4 3/4].
[PATCH v5 11/11]: [PATCH v4 4/4] add a meaningful power domain name for
RK3568 Soc.

Change in V4:
[PATCH v4 1/4]: No change.
[PATCH v4 2/4]: Fix up yaml code styles. Remove the new compatible to
[PATCH v4 3/4]
[PATCH v4 3/4]: Adding new compatible for RK3568 Soc.
[PATCH v4 4/4]: No change. Same as [PATCH v3 3/3].

Change in V3:
[PATCH v3 1/3]: No change.
[PATCH v3 2/3]: Fix up the code styles and add rk3568 base on:
https://patchwork.kernel.org/project/linux-rockchip/patch/20210225102643.653095-1-enric.balletbo@collabora.com/
[PATCH v3 3/3]: No change.

Change in V2:
[PATCH v2 1/3]: No change.
[PATCH v2 2/3]: Fix up yaml code styles.
[PATCH v2 3/3]: No change.

Elaine Zhang (11):
  arm: dts: rockchip: Fix power-controller node names for rk3066a
  arm: dts: rockchip: Fix power-controller node names for rk3188
  arm: dts: rockchip: Fix power-controller node names for rk3288
  arm64: dts: rockchip: Fix power-controller node names for px30
  arm64: dts: rockchip: Fix power-controller node names for rk3328
  arm64: dts: rockchip: Fix power-controller node names for rk3399
  soc: rockchip: pm-domains: Add a meaningful power domain name
  dt-bindings: add power-domain header for RK3568 SoCs
  dt-bindings: power: rockchip: Convert to json-schema
  dt-bindings: power: rockchip: Add bindings for RK3568 Soc
  soc: rockchip: power-domain: add rk3568 powerdomains

 .../power/rockchip,power-controller.yaml      | 293 ++++++++++++++++++
 .../bindings/soc/rockchip/power_domain.txt    | 136 --------
 arch/arm/boot/dts/rk3066a.dtsi                |   6 +-
 arch/arm/boot/dts/rk3188.dtsi                 |   6 +-
 arch/arm/boot/dts/rk3288.dtsi                 |   8 +-
 arch/arm64/boot/dts/rockchip/px30.dtsi        |  16 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi      |   6 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      |  40 +--
 drivers/soc/rockchip/pm_domains.c             | 252 ++++++++-------
 include/dt-bindings/power/rk3568-power.h      |  32 ++
 10 files changed, 511 insertions(+), 284 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
 create mode 100644 include/dt-bindings/power/rk3568-power.h

-- 
2.17.1



