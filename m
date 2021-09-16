Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CB340D625
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbhIPJ1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:27:08 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:39217 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhIPJ1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:27:07 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 18G95Fm4009659;
        Thu, 16 Sep 2021 17:05:15 +0800 (GMT-8)
        (envelope-from chiawei_wang@aspeedtech.com)
Received: from ChiaWeiWang-PC.aspeed.com (192.168.2.66) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 16 Sep
 2021 17:25:12 +0800
From:   Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To:     <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <openbmc@lists.ozlabs.org>
CC:     <osk@google.com>, <yulei.sh@bytedance.com>
Subject: [PATCH v5 0/4] arm: aspeed: Add UART routing support
Date:   Thu, 16 Sep 2021 17:25:11 +0800
Message-ID: <20210916092515.10553-1-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.66]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 18G95Fm4009659
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add UART routing driver and the device tree nodes.

v5:
 - Fix typo in YAML file to solve the compatible string not found error

v4:
 - Convert aspeed-lpc bindings to YAML schema to resolve dependecy issues

v3:
 - Add individual bindings in YAML
 - Add support for AST24xx (AST25xx shares the same design)
 - Add more explanation for the sysfs ABI

v2:
 - Add dt-bindings
 - Add ABI documents for the exported sysfs interface
 - Revise driver implementation suggested by Joel


Chia-Wei Wang (4):
  dt-bindings: mfd: aspeed-lpc: Convert to YAML schema
  dt-bindings: aspeed: Add UART routing controller
  soc: aspeed: Add UART routing support
  ARM: dts: aspeed: Add uart routing to device tree

 .../testing/sysfs-driver-aspeed-uart-routing  |  15 +
 .../devicetree/bindings/mfd/aspeed-lpc.txt    | 157 -----
 .../devicetree/bindings/mfd/aspeed-lpc.yaml   | 191 ++++++
 .../bindings/soc/aspeed/uart-routing.yaml     |  70 ++
 arch/arm/boot/dts/aspeed-g4.dtsi              |   6 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |   6 +
 arch/arm/boot/dts/aspeed-g6.dtsi              |   6 +
 drivers/soc/aspeed/Kconfig                    |  10 +
 drivers/soc/aspeed/Makefile                   |   9 +-
 drivers/soc/aspeed/aspeed-uart-routing.c      | 603 ++++++++++++++++++
 10 files changed, 912 insertions(+), 161 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing
 delete mode 100644 Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml
 create mode 100644 drivers/soc/aspeed/aspeed-uart-routing.c

-- 
2.17.1

