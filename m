Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89083B65B8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238581AbhF1Peb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:34:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238024AbhF1PPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:15:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5548661206;
        Mon, 28 Jun 2021 15:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624893169;
        bh=mKc+DGVUwwP3w69Df4E2RuWvYSvZU8sQpDkg3+zmHdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mj02hJ2U7DYOg1g9bW0KTyxbl1p3cDsRZs+m9IJNiri7W3tj2aDZhHBBtma9t5Knb
         wIHyLhtsOHvdFjr18q0P7VNAucSu68J9B0Ml5R0XNMMiYPJN67xN16QTOTqzd4babm
         53h2k2waAxLt3pciV5PyVhTekkQofqaOLRZ9VSd7iwo6+A7s52wWQg+l5doQWj7/wD
         L88K/Be8vmXy8XM6X7f9/O+x9OO4Xd+bBuaT7ukFUcA/Myc56dvFxMhOzrJWdPDPJd
         smAnU3PhpVWCgFiD3PHPV9yadjSFaGXp58StngFGRBPmTEwKK+Zioyh0DLyBA2oAnY
         uBA+sSOKC3ikQ==
Received: by pali.im (Postfix)
        id 43D0070A; Mon, 28 Jun 2021 17:12:47 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: armada-3720-turris-mox: remove mrvl,i2c-fast-mode
Date:   Mon, 28 Jun 2021 17:12:29 +0200
Message-Id: <20210628151229.25214-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210628121015.22660-1-pali@kernel.org>
References: <20210628121015.22660-1-pali@kernel.org>
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
Reviewed-by: Marek Behún <kabel@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index 6bcc319a0161..85f15f2a4740 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -119,6 +119,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1_pins>;
 	clock-frequency = <100000>;
+	/delete-property/ mrvl,i2c-fast-mode;
 	status = "okay";
 
 	rtc@6f {
-- 
2.20.1

