Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222E03A5767
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 11:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhFMJuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 05:50:55 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:34437 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbhFMJuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 05:50:54 -0400
Received: by mail-wr1-f49.google.com with SMTP id q5so10967559wrm.1;
        Sun, 13 Jun 2021 02:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IDfBcudzWJBKabnnvY8z/cQCBRgnrN5jAmw/3Eca5LM=;
        b=mIUAFX4VpiU75CUcRASXp/3YKIOqCFjR04uNxvfwu3mQuXu55ZIMdPOjBCpOtwd/hJ
         SrF0ZhSw6Kzk4rVC/uzFsABKltCWHe69iY0VyooaZYXlYOilK9pLkRaRzBKv89jCTu8o
         8b3PJTsuzLyUEgYQFYBsANQVkmALybai5UZ621ndXMYJ8cqIZb8EG8SItOe2HCocmRdw
         HoKhGQ6YAWSyVjcZMKIHqj8uVb1V8MIy5JsxeNxd5/XSkeg5sVCLUufbG6D5+OKl4Egm
         NPFgtMtJGxx8anfhQ4JpBQnEWCPq04as6CYm+vxP2zmbo34KjaQH3YO4vahODo2Yoeba
         T+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IDfBcudzWJBKabnnvY8z/cQCBRgnrN5jAmw/3Eca5LM=;
        b=EFDdcnpYe0SGkE8xkkP1GgYF64UboZ7+chZwZZ2ILj0Z/o9fPmREpQy5YYLAJlynFj
         VYVPIGUFXQgGGImDeq40d/ZvgqBrbc1Razs5Qw3LRPv5kv/u0qEn0hOeDhqWL8RMqkma
         nW01XChAVAINSGwHLbdpAdaPPij9rjwQFBgSUtEDFgkoTcJ7Jv7SxteaBBeiPtXkw/Bf
         FnDHOv4+vvdEXQyTvnvKeV0GohM0aT0YIV5nZ+/VSAKtv6ExQ579rZdjl9UQal7UKA+R
         qPx1XjfGqdMYHHhaSMUVolHfZ2XCX21WSK55X9o8tE4UBaKR/LhZu1p3zf4E3gAuIKKh
         JsBg==
X-Gm-Message-State: AOAM531/6wMMHMAvjAl4woLdRnD9jgEfXJn1oSv5IfiMPdgYamnLCLak
        m/ePrZ6ET+B+kigoBKAF9lCbTYwYdjM=
X-Google-Smtp-Source: ABdhPJy1oD1q0kSYxcHbnuLF0CAphsMk6y07KdPjoM5BuVtzdozideQb7kcc94K0shW8eB3HfJFdug==
X-Received: by 2002:a05:6000:188:: with SMTP id p8mr5874031wrx.296.1623577672062;
        Sun, 13 Jun 2021 02:47:52 -0700 (PDT)
Received: from cluster5 ([80.76.206.81])
        by smtp.gmail.com with ESMTPSA id 2sm12827599wrz.87.2021.06.13.02.47.51
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 13 Jun 2021 02:47:51 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivek Unune <npcomplete13@gmail.com>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ARM: dts: NSP: Move USB3 PHY to internal MDIO bus
Date:   Sun, 13 Jun 2021 10:46:37 +0100
Message-Id: <20210613094639.3242151-4-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210613094639.3242151-1-mnhagan88@gmail.com>
References: <20210613094639.3242151-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch largely replicates Vivek Unune's patch "ARM: dts:
BCM5301X:Make usb3 phy use mdio phy driver"[1] for the NSP platform,
whereby we need to create an mdio-mux to facilitate switches
configured via external MDIO, in this case on the Meraki MX65.

However in doing so, we are creating an overlap with usb3_phy's
ccb-mii range. To resolve this, usb3_phy should be moved to a child
node of the internal MDIO bus. The result is heavily based upon Vivek's
patch. This has also been cross-referenced with Yendapally Reddy's
earlier work which utilised the subsequently dropped brcm,nsp-usb3-phy
driver: "[PATCH v2 4/4] arm: dts: nsp: Add USB nodes to device tree"
[2]. Finally, this change provides conformance to the bcm-ns-usb3-phy
documentation, utilising the required usb3-dmp-syscon property. Note
that support for the deprecated ccb-mii bindings has been dropped as of
"phy: phy-bcm-ns-usb3: drop support for deprecated DT binding"[3].

[1] https://lore.kernel.org/patchwork/patch/933971/
[2] https://www.spinics.net/lists/arm-kernel/msg555132.html
[3] https://lore.kernel.org/linux-devicetree/20201113113423.9466-1-zajec5@gmail.com/

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 38 +++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index e91a68996986..7c59816fdb32 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -370,6 +370,35 @@ mdio: mdio@32000 {
 			#address-cells = <1>;
 		};
 
+		mdio-mux@32000 {
+			compatible = "mdio-mux-mmioreg";
+			reg = <0x32000 0x4>;
+			mux-mask = <0x200>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			mdio-parent-bus = <&mdio>;
+
+			mdio_int: mdio@0 {
+				reg = <0x0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				usb3_phy: usb3-phy@10 {
+					compatible = "brcm,ns-bx-usb3-phy";
+					reg = <0x10>;
+					usb3-dmp-syscon = <&usb3_dmp>;
+					#phy-cells = <0>;
+					status = "disabled";
+				};
+			};
+
+			mdio_ext: mdio@200 {
+				reg = <0x200>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		rng: rng@33000 {
 			compatible = "brcm,bcm-nsp-rng";
 			reg = <0x33000 0x14>;
@@ -530,13 +559,8 @@ sata1: sata-port@1 {
 			};
 		};
 
-		usb3_phy: usb3-phy@104000 {
-			compatible = "brcm,ns-bx-usb3-phy";
-			reg = <0x104000 0x1000>,
-			      <0x032000 0x1000>;
-			reg-names = "dmp", "ccb-mii";
-			#phy-cells = <0>;
-			status = "disabled";
+		usb3_dmp: syscon@104000 {
+			reg = <0x104000 0x1000>;
 		};
 	};
 
-- 
2.26.3

