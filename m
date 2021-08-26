Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0793F824C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 08:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239046AbhHZGSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 02:18:00 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:18988 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238582AbhHZGRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 02:17:54 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 17Q5vjo0058460;
        Thu, 26 Aug 2021 13:57:45 +0800 (GMT-8)
        (envelope-from chiawei_wang@aspeedtech.com)
Received: from ChiaWeiWang-PC.aspeed.com (192.168.2.66) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 26 Aug
 2021 14:16:25 +0800
From:   Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To:     <joel@jms.id.au>, <robh+dt@kernel.org>, <andrew@aj.id.au>,
        <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/4] arm: aspeed: Add eSPI support
Date:   Thu, 26 Aug 2021 14:16:19 +0800
Message-ID: <20210826061623.6352-1-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.66]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 17Q5vjo0058460
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add the driver support for the eSPI controller
of Aspeed 5/6th generation SoCs. This controller is a slave device
communicating with a master over Enhanced Serial Peripheral Interface (eSPI).
It supports all of the 4 eSPI channels, namely peripheral, virtual wire,
out-of-band, and flash, and operates at max frequency of 66MHz.

v3:
 - remove the redundant patch "clk: aspeed: Add eSPI reset bit"
 - fix missing header inclusion reported by test bot
 - fix dt-bindings error reported by yamllint

v2:
 - remove irqchip implementation
 - merge per-channel drivers into single one to avoid the racing issue
   among eSPI handshake process and driver probing.

Chia-Wei Wang (4):
  dt-bindings: aspeed: Add eSPI controller
  MAINTAINER: Add ASPEED eSPI driver entry
  soc: aspeed: Add eSPI driver
  ARM: dts: aspeed: Add eSPI node

 .../devicetree/bindings/soc/aspeed/espi.yaml  | 157 +++++
 MAINTAINERS                                   |   9 +
 arch/arm/boot/dts/aspeed-g6.dtsi              |  17 +
 drivers/soc/aspeed/Kconfig                    |  11 +
 drivers/soc/aspeed/Makefile                   |   1 +
 drivers/soc/aspeed/aspeed-espi-ctrl.c         | 205 ++++++
 drivers/soc/aspeed/aspeed-espi-ctrl.h         | 304 +++++++++
 drivers/soc/aspeed/aspeed-espi-flash.h        | 380 +++++++++++
 drivers/soc/aspeed/aspeed-espi-ioc.h          | 153 +++++
 drivers/soc/aspeed/aspeed-espi-oob.h          | 611 ++++++++++++++++++
 drivers/soc/aspeed/aspeed-espi-perif.h        | 539 +++++++++++++++
 drivers/soc/aspeed/aspeed-espi-vw.h           | 142 ++++
 12 files changed, 2529 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/espi.yaml
 create mode 100644 drivers/soc/aspeed/aspeed-espi-ctrl.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-ctrl.h
 create mode 100644 drivers/soc/aspeed/aspeed-espi-flash.h
 create mode 100644 drivers/soc/aspeed/aspeed-espi-ioc.h
 create mode 100644 drivers/soc/aspeed/aspeed-espi-oob.h
 create mode 100644 drivers/soc/aspeed/aspeed-espi-perif.h
 create mode 100644 drivers/soc/aspeed/aspeed-espi-vw.h

-- 
2.17.1

