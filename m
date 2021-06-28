Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94143B57FC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 06:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhF1EGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 00:06:00 -0400
Received: from regular1.263xmail.com ([211.150.70.202]:38124 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhF1EFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 00:05:55 -0400
X-Greylist: delayed 523 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Jun 2021 00:05:54 EDT
Received: from localhost (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id 916D6829;
        Mon, 28 Jun 2021 11:54:33 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED2: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 1
Received: from localhost.localdomain (unknown [14.20.131.7])
        by smtp.263.net (postfix) whith ESMTP id P12369T139709984536320S1624852472443677_;
        Mon, 28 Jun 2021 11:54:33 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <fdf104fba4e4b2bf7e6009133de69086>
X-RL-SENDER: djw@t-chip.com.cn
X-SENDER: djw@t-chip.com.cn
X-LOGIN-NAME: djw@t-chip.com.cn
X-FST-TO: linux-rockchip@lists.infradead.org
X-RCPT-COUNT: 18
X-SENDER-IP: 14.20.131.7
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   djw@t-chip.com.cn
To:     linux-rockchip@lists.infradead.org
Cc:     Wayne Chou <zxf@t-chip.com.cn>, Kongxin Deng <dkx@t-chip.com.cn>,
        Levin Du <djw@t-chip.com.cn>, Heiko Stuebner <heiko@sntech.de>,
        Chen-Yu Tsai <wens@csie.org>,
        David Bauer <mail@david-bauer.net>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liang Chen <cl@rock-chips.com>,
        Marty Jones <mj8263788@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v0 0/2] Add support for Firefly ROC-RK3399-PC-PLUS
Date:   Mon, 28 Jun 2021 11:54:00 +0800
Message-Id: <20210628035402.16812-1-djw@t-chip.com.cn>
X-Mailer: git-send-email 2.23.0.37.g745f6812895b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Levin Du <djw@t-chip.com.cn>


Hi all, this is an attemp to add Firefly ROC-RK3399-PC-PLUS to the mainline
kernel.

ROC-RK3399-PC-PLUS is the board inside the portable Firefly Station P1 Geek
PC. As a redesign after the ROC-RK3399-PC, it uses DC-12V as power input
and spares a USB 3 host port. It is also equipped with a USB WiFi chip and
audio codec without the mezzanine board.

Many thanks to the Linux people!


Levin Du (2):
  dt-bindings: add doc for Firefly ROC-RK3399-PC-PLUS
  arm64: dts: rockchip: add support for Firefly ROC-RK3399-PC-PLUS

 .../devicetree/bindings/arm/rockchip.yaml     |   6 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3399-roc-pc-plus.dts  | 223 ++++++++++++++++++
 3 files changed, 230 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts

--
2.23.0.37.g745f6812895b



