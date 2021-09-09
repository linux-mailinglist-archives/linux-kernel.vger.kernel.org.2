Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1C3404875
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 12:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbhIIKbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 06:31:18 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:43356 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbhIIKa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 06:30:59 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 189A9ikH075150;
        Thu, 9 Sep 2021 18:09:44 +0800 (GMT-8)
        (envelope-from chiawei_wang@aspeedtech.com)
Received: from ChiaWeiWang-PC.aspeed.com (192.168.2.66) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 9 Sep
 2021 18:29:14 +0800
From:   Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To:     <joel@jms.id.au>, <andrew@aj.id.au>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <openbmc@lists.ozlabs.org>
CC:     <osk@google.com>, <yulei.sh@bytedance.com>
Subject: [PATCH v3 0/3] arm: aspeed: Add UART routing support
Date:   Thu, 9 Sep 2021 18:29:04 +0800
Message-ID: <20210909102907.32037-1-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.66]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 189A9ikH075150
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add UART routing driver and the device tree nodes.

v3:
 - Add individual bindings in YAML
 - Add support for AST24xx (AST25xx shares the same design)
 - Add more explanation for the sysfs ABI

v2:
 - Add dt-bindings
 - Add ABI documents for the exported sysfs interface
 - Revise driver implementation suggested by Joel

Chia-Wei Wang (3):
  dt-bindings: aspeed: Add UART routing controller
  soc: aspeed: Add UART routing support
  ARM: dts: aspeed: Add uart routing to device tree

 .../testing/sysfs-driver-aspeed-uart-routing  |  15 +
 .../bindings/soc/aspeed/uart-routing.yaml     |  70 ++
 arch/arm/boot/dts/aspeed-g4.dtsi              |   6 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |   6 +
 arch/arm/boot/dts/aspeed-g6.dtsi              |   6 +
 drivers/soc/aspeed/Kconfig                    |  10 +
 drivers/soc/aspeed/Makefile                   |   9 +-
 drivers/soc/aspeed/aspeed-uart-routing.c      | 603 ++++++++++++++++++
 8 files changed, 721 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-aspeed-uart-routing
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml
 create mode 100644 drivers/soc/aspeed/aspeed-uart-routing.c

-- 
2.17.1

