Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE1C38E52B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbhEXLP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:15:57 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:43865 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbhEXLPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:15:44 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 14OB0oks024990;
        Mon, 24 May 2021 19:00:50 +0800 (GMT-8)
        (envelope-from steven_lee@aspeedtech.com)
Received: from slee-VirtualBox.localdomain (192.168.100.253) by
 TWMBX02.aspeed.com (192.168.0.24) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 24 May 2021 19:13:44 +0800
From:   Steven Lee <steven_lee@aspeedtech.com>
To:     Andrew Jeffery <andrew@aj.id.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        "moderated list:ASPEED PINCTRL DRIVERS" 
        <linux-aspeed@lists.ozlabs.org>,
        "moderated list:ASPEED PINCTRL DRIVERS" <openbmc@lists.ozlabs.org>,
        "open list:ASPEED PINCTRL DRIVERS" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     <steven_lee@aspeedtech.com>, <Hongweiz@ami.com>,
        <ryan_chen@aspeedtech.com>, <billy_tsai@aspeedtech.com>
Subject: [PATCH v1 0/3] pinctrl: pinctrl-g6: Add the 2nd sgpio
Date:   Mon, 24 May 2021 19:13:34 +0800
Message-ID: <20210524111338.16049-1-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.100.253]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 14OB0oks024990
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AST2600 has 2 SGPIO master interfaces one with 128 pins and another one
has 80 pins, it also supports 2 SGPIO slave interfaces.
However, there is only the first sgpio master/slave interface defined in
dtsi and pinctrl driver.
The patch series adds the second SGPIO master and slave interfaces
in dt-bindings, dtsi and pinctrl driver.

Please help to review.

Thanks,
Steven

Steven Lee (3):
  dt-bindings: pinctrl: Update enum for adding SGPM2 and SGPS2
  ARM: dts: aspeed-g6: Add pinctrl settings
  pinctrl: pinctrl-aspeed-g6: Add sgpio pinctrl settings

 .../pinctrl/aspeed,ast2600-pinctrl.yaml       | 10 ++++----
 arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi      | 10 ++++++++
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c    | 24 +++++++++++++++----
 drivers/pinctrl/aspeed/pinmux-aspeed.h        |  9 +++++++
 4 files changed, 44 insertions(+), 9 deletions(-)

-- 
2.17.1

