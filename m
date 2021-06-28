Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFFF3B5DB3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 14:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbhF1MNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 08:13:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232933AbhF1MNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:13:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24EE161C49;
        Mon, 28 Jun 2021 12:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624882252;
        bh=hsJq4K0UQ3estcFibPEXpVe1Nv88MXs/+qqxawzOhRA=;
        h=From:To:Cc:Subject:Date:From;
        b=uIjOf7bJMdxmc2t375ISss25RTVzbzHsiMEPv2P0ql5aUoNpaN1TapTQ7XrsZoxb4
         FmPH7fWnwS363O/j+8BwgFoeh/p296Ysq+o0oe39c7Pjdw94/SgMoWVTBx7vRJASm2
         3mGyp/cGGqGddC1RHccFv6Mtq8qEnZPRJrZwmTwQ+O0bQosOku2N57JpgrdrtUIGip
         9uK+xRqlv5wqzAtnByrf23IwZyMBsdim68G1PWlbDA4k+ERpZV9bYlu7UU3Rsx6x43
         7pYrl7n2IFPI/p/dPwX4AS4c01czhmI1EEA8ICefL0aZNY0gjh8JCqjOjNDFDy7kBa
         QGqOnkevPWkTQ==
Received: by pali.im (Postfix)
        id D3AD170A; Mon, 28 Jun 2021 14:10:49 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: armada-3720-turris-mox.dts: remove mrvl,i2c-fast-mode
Date:   Mon, 28 Jun 2021 14:10:15 +0200
Message-Id: <20210628121015.22660-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SFP modules are not detected when i2c-fast-mode is enabled even when
clock-frequency is already set to 100000. The I2C bus violates the timing
specifications when run in fast mode. So disable fast mode on Turris Mox.

Same change was already applied for uDPU (also Armada 3720 board with SFP)
in commit fe3ec631a77d ("arm64: dts: uDPU: remove i2c-fast-mode").

Fixes: 7109d817db2e ("arm64: dts: marvell: add DTS for Turris Mox")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index 6bcc319a0161..27ded36a1a13 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -119,6 +119,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1_pins>;
 	clock-frequency = <100000>;
+	/delete-property/mrvl,i2c-fast-mode;
 	status = "okay";
 
 	rtc@6f {
-- 
2.20.1

