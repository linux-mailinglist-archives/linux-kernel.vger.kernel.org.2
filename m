Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D563FD1D2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 05:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241775AbhIADbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 23:31:46 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:23537 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbhIADbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 23:31:42 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1813BE3j043734;
        Wed, 1 Sep 2021 11:11:14 +0800 (GMT-8)
        (envelope-from chiawei_wang@aspeedtech.com)
Received: from ChiaWeiWang-PC.aspeed.com (192.168.2.66) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 1 Sep
 2021 11:30:15 +0800
From:   Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To:     <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ryan_chen@aspeedtech.com>
Subject: [PATCH v4 0/4] arm: aspeed: Add eSPI support
Date:   Wed, 1 Sep 2021 11:30:11 +0800
Message-ID: <20210901033015.910-1-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.66]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1813BE3j043734
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add the driver support for the eSPI controller
of Aspeed 5/6th generation SoCs. This controller is a slave device
communicating with a master over Enhanced Serial Peripheral Interface (eSPI).
It supports all of the 4 eSPI channels, namely peripheral, virtual wire,
out-of-band, and flash, and operates at max frequency of 66MHz.

v4:
 - fix dt-bindgins error with patternProperties
 - fix data type warning for ARM64 compilation
 - replace header based implementation with .c files
 - add more description for the ioctl interface

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

 .../devicetree/bindings/soc/aspeed/espi.yaml  | 162 +++++
 MAINTAINERS                                   |   9 +
 arch/arm/boot/dts/aspeed-g6.dtsi              |  17 +
 drivers/soc/aspeed/Kconfig                    |  11 +
 drivers/soc/aspeed/Makefile                   |   5 +
 drivers/soc/aspeed/aspeed-espi-ctrl.c         | 214 +++++++
 drivers/soc/aspeed/aspeed-espi-ctrl.h         | 308 ++++++++++
 drivers/soc/aspeed/aspeed-espi-flash.c        | 352 +++++++++++
 drivers/soc/aspeed/aspeed-espi-flash.h        |  45 ++
 drivers/soc/aspeed/aspeed-espi-ioc.h          | 195 ++++++
 drivers/soc/aspeed/aspeed-espi-oob.c          | 558 ++++++++++++++++++
 drivers/soc/aspeed/aspeed-espi-oob.h          |  70 +++
 drivers/soc/aspeed/aspeed-espi-perif.c        | 511 ++++++++++++++++
 drivers/soc/aspeed/aspeed-espi-perif.h        |  45 ++
 drivers/soc/aspeed/aspeed-espi-vw.c           | 137 +++++
 drivers/soc/aspeed/aspeed-espi-vw.h           |  21 +
 16 files changed, 2660 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/espi.yaml
 create mode 100644 drivers/soc/aspeed/aspeed-espi-ctrl.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-ctrl.h
 create mode 100644 drivers/soc/aspeed/aspeed-espi-flash.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-flash.h
 create mode 100644 drivers/soc/aspeed/aspeed-espi-ioc.h
 create mode 100644 drivers/soc/aspeed/aspeed-espi-oob.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-oob.h
 create mode 100644 drivers/soc/aspeed/aspeed-espi-perif.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-perif.h
 create mode 100644 drivers/soc/aspeed/aspeed-espi-vw.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-vw.h

-- 
2.17.1

