Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F077C3FD3C1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 08:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242301AbhIAGX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 02:23:28 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:40872 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242292AbhIAGXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 02:23:23 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 18163Gmm058024;
        Wed, 1 Sep 2021 14:03:16 +0800 (GMT-8)
        (envelope-from chiawei_wang@aspeedtech.com)
Received: from ChiaWeiWang-PC.aspeed.com (192.168.2.66) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 1 Sep
 2021 14:22:17 +0800
From:   Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To:     <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <osk@google.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>
Subject: [PATCH 0/2] arm: aspeed: Add LPC uart routing support
Date:   Wed, 1 Sep 2021 14:22:14 +0800
Message-ID: <20210901062216.32675-1-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.66]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 18163Gmm058024
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LPC uart routing driver and the device tree nodes.

Chia-Wei Wang (2):
  soc: aspeed: Add LPC UART routing support
  ARM: dts: aspeed: Add uart routing to device tree

 arch/arm/boot/dts/aspeed-g5.dtsi             |   6 +
 arch/arm/boot/dts/aspeed-g6.dtsi             |   6 +
 drivers/soc/aspeed/Kconfig                   |  11 +
 drivers/soc/aspeed/Makefile                  |   9 +-
 drivers/soc/aspeed/aspeed-lpc-uart-routing.c | 621 +++++++++++++++++++
 5 files changed, 649 insertions(+), 4 deletions(-)
 create mode 100644 drivers/soc/aspeed/aspeed-lpc-uart-routing.c

-- 
2.17.1

