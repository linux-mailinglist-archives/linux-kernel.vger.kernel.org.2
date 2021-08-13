Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8953EAFBC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 07:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238461AbhHMFse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 01:48:34 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:1444 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbhHMFsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 01:48:33 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 17D5UCiP018825;
        Fri, 13 Aug 2021 13:30:12 +0800 (GMT-8)
        (envelope-from chiawei_wang@aspeedtech.com)
Received: from ChiaWeiWang-PC.aspeed.com (192.168.2.66) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 13 Aug
 2021 13:48:04 +0800
From:   Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To:     <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <cyrilbur@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>
Subject: [PATCH 0/2] aspeed: Add LPC mailbox support
Date:   Fri, 13 Aug 2021 13:47:56 +0800
Message-ID: <20210813054758.13189-1-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.66]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 17D5UCiP018825
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver support for the LPC mailbox controller of ASPEED SoCs.

Chia-Wei Wang (2):
  soc: aspeed: Add LPC mailbox support
  ARM: dts: aspeed: Add mailbox to device tree

 arch/arm/boot/dts/aspeed-g4.dtsi     |   7 +
 arch/arm/boot/dts/aspeed-g5.dtsi     |   8 +-
 arch/arm/boot/dts/aspeed-g6.dtsi     |   7 +
 drivers/soc/aspeed/Kconfig           |  10 +
 drivers/soc/aspeed/Makefile          |   9 +-
 drivers/soc/aspeed/aspeed-lpc-mbox.c | 415 +++++++++++++++++++++++++++
 6 files changed, 451 insertions(+), 5 deletions(-)
 create mode 100644 drivers/soc/aspeed/aspeed-lpc-mbox.c

-- 
2.17.1

