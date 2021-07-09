Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB623C2069
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 10:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhGIIFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 04:05:16 -0400
Received: from regular1.263xmail.com ([211.150.70.199]:43706 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbhGIIFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 04:05:15 -0400
Received: from localhost (unknown [192.168.167.69])
        by regular1.263xmail.com (Postfix) with ESMTP id 087BA1310;
        Fri,  9 Jul 2021 16:01:54 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED2: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 1
Received: from localhost.localdomain (unknown [183.57.25.242])
        by smtp.263.net (postfix) whith ESMTP id P12349T139824269707008S1625817711146317_;
        Fri, 09 Jul 2021 16:01:52 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <75b8410723c298b4b86f84367f86a160>
X-RL-SENDER: djw@t-chip.com.cn
X-SENDER: djw@t-chip.com.cn
X-LOGIN-NAME: djw@t-chip.com.cn
X-FST-TO: linux-rockchip@lists.infradead.org
X-RCPT-COUNT: 16
X-SENDER-IP: 183.57.25.242
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   djw@t-chip.com.cn
To:     linux-rockchip@lists.infradead.org
Cc:     Wayne Chou <zxf@t-chip.com.cn>, Levin Du <djw@t-chip.com.cn>,
        Heiko Stuebner <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>,
        David Bauer <mail@david-bauer.net>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Liang Chen <cl@rock-chips.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tianling Shen <cnsztl@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v0 0/2] Add support for Firefly ROC-RK3328-PC
Date:   Fri,  9 Jul 2021 16:01:24 +0800
Message-Id: <20210709080126.17045-1-djw@t-chip.com.cn>
X-Mailer: git-send-email 2.23.0.37.g745f6812895b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Levin Du <djw@t-chip.com.cn>


Hi all, this is an attemp to add Firefly ROC-RK3328-PC to the mainline
kernel.

ROC-RK3328-PC is the board inside the portable Firefly Station M1
Geek PC. As a redesign after the ROC-RK3328-CC, it uses TypeC as
power input and OTG port, embedded with eMMC 5.1 storage and a
SDIO WiFi/BT chip (RTL8723DS).

Many thanks to the Linux people!


Levin Du (2):
  dt-bindings: add doc for Firefly ROC-RK3328-PC
  arm64: dts: rockchip: add support for Firefly ROC-RK3328-PC

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../arm64/boot/dts/rockchip/rk3328-roc-pc.dts | 110 ++++++++++++++++++
 3 files changed, 116 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts

-- 
2.23.0.37.g745f6812895b



