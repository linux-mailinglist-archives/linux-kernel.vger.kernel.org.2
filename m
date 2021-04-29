Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9809536E726
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 10:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240016AbhD2IiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 04:38:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232714AbhD2IiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 04:38:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 124A5613CC;
        Thu, 29 Apr 2021 08:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619685447;
        bh=HaAfWtOAafkNSsvz88e84TAEk52kR7zNGm+Hs1lufVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j9cwET2lfBWx4z21Rbb5XQMMhagUx2mZffCLo2Lp3v/hzb4OAB6NrKG31LTSxwiKc
         lVch/kCh8FFLY5N9U5tNB9qh03SCzDBRwkuYoMM206585XP4FdSHs8ux+y3jD1Wt9l
         HiH+s+W2q5JX1mo5P7mLWnVKEHCT5wf9OfNl3//yR3epiOmS3Ub3Jmnkg8IVKOJCV/
         fZsDZEsCMLNF2+R8iihbHsEw0q1B/uYa29DsAom/etGTcGe6qoFnnBH2HqDWiyuIZ1
         r68ti6+chgwa5tf+bOYsDae1tsDYvngA+sdcim/uCP2r9VCopjnqL5zV0jkKjddaMy
         8XEt2Nr8sbvgQ==
Received: by pali.im (Postfix)
        id C4B347DF; Thu, 29 Apr 2021 10:37:24 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 mvebu + mvebu/dt64 6/6] arm64: dts: marvell: armada-37xx: move firmware node to generic dtsi file
Date:   Thu, 29 Apr 2021 10:36:36 +0200
Message-Id: <20210429083636.22560-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210429083636.22560-1-pali@kernel.org>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210429083636.22560-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the turris-mox-rwtm firmware node from Turris MOX' device tree into
the generic armada-37xx.dtsi file and use the generic compatible string
'marvell,armada-3700-rwtm-firmware' instead of the current one.

The Turris MOX rWTM firmware can be used on any Armada 37xx device,
giving them access to the rWTM hardware random number generator, which
is otherwise unavailable.

This change allows Linux to load the turris-mox-rwtm.ko module on these
boards.

Tested on ESPRESSObin v5 with both default Marvell WTMI firmware and
CZ.NIC's firmware. With default WTMI firmware the turris-mox-rwtm fails
to probe, while with CZ.NIC's firmware it registers the HW random number
generator.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: <stable@vger.kernel.org> # 5.4+: 46d2f6d0c99f ("arm64: dts: armada-3720-turris-mox: add firmware node")
---
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 8 --------
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi           | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index 0753cc489638..ebb0ddf8d306 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -107,14 +107,6 @@
 		/* enabled by U-Boot if SFP module is present */
 		status = "disabled";
 	};
-
-	firmware {
-		turris-mox-rwtm {
-			compatible = "cznic,turris-mox-rwtm";
-			mboxes = <&rwtm 0>;
-			status = "okay";
-		};
-	};
 };
 
 &i2c0 {
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 1b7f43e27589..847a2d12a4be 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -505,4 +505,12 @@
 			};
 		};
 	};
+
+	firmware {
+		armada-3700-rwtm {
+			compatible = "marvell,armada-3700-rwtm-firmware";
+			mboxes = <&rwtm 0>;
+			status = "okay";
+		};
+	};
 };
-- 
2.20.1

