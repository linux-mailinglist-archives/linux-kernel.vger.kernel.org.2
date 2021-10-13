Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8772C42BCA4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 12:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239320AbhJMKV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 06:21:57 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:48790 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239299AbhJMKV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 06:21:56 -0400
Received: from localhost (unknown [192.168.167.225])
        by lucky1.263xmail.com (Postfix) with ESMTP id B2F07FB9B5;
        Wed, 13 Oct 2021 18:19:47 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P26701T140614792369920S1634120379732571_;
        Wed, 13 Oct 2021 18:19:47 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: zyf@rock-chips.com
X-SENDER: zyf@rock-chips.com
X-LOGIN-NAME: zyf@rock-chips.com
X-FST-TO: heiko@sntech.de
X-RCPT-COUNT: 12
X-LOCAL-RCPT-COUNT: 1
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-UNIQUE-TAG: <2264d20134754bff60603e65da9a4501>
X-System-Flag: 0
From:   Yifeng Zhao <yifeng.zhao@rock-chips.com>
To:     heiko@sntech.de, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, vkoul@kernel.org,
        michael.riesch@wolfvision.net, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kishon@ti.com,
        p.zabel@pengutronix.de, Yifeng Zhao <yifeng.zhao@rock-chips.com>
Subject: [PATCH v2 0/3] Add Naneng combo PHY support for RK3568
Date:   Wed, 13 Oct 2021 18:19:35 +0800
Message-Id: <20211013101938.28061-1-yifeng.zhao@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This phy can be used as pcie-phy, usb3-phy, sata-phy or sgmii-phy.

Changes in v2:
- Fix dtschema/dtc warnings/errors
- Using api devm_platform_get_and_ioremap_resource.
- Modify rockchip_combphy_set_Mode.
- Add some PHY registers definition.
- Move phy0 to rk3568.dtsi

Yifeng Zhao (3):
  dt-bindings: phy: rockchip: Add Naneng combo PHY bindings
  phy/rockchip: add naneng combo phy for RK3568
  arm64: dts: rockchip: add naneng combo phy nodes for rk3568

 .../phy/phy-rockchip-naneng-combphy.yaml      |  98 +++
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      |  21 +
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      |  47 ++
 drivers/phy/rockchip/Kconfig                  |   8 +
 drivers/phy/rockchip/Makefile                 |   1 +
 .../rockchip/phy-rockchip-naneng-combphy.c    | 650 ++++++++++++++++++
 6 files changed, 825 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
 create mode 100644 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c

-- 
2.17.1



