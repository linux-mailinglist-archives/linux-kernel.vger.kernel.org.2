Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF87F3FA575
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 13:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbhH1L2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 07:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbhH1L2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 07:28:33 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F55EC061796;
        Sat, 28 Aug 2021 04:27:43 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m25-20020a7bcb99000000b002e751bcb5dbso6030911wmi.5;
        Sat, 28 Aug 2021 04:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=duhliZsTlIE2VE8yD9vItvYrUD0HDA/4yEWWMGX5Kx8=;
        b=vWDaKY97EsHzOSABOczsI/BMk3y7wXr1ZXLkN2ruVw7fJ6FLNJPpcY78OFeyiJFTZO
         q9Uug0HeNvNGbSj6ioXBbg/CkcQa+mJtDyTRdh6vTDKuJSzaAz5KKmA8VeH1wHN9wjqS
         cHO7/GBgBM1YBOOkrslMykLGHnN83COZ2JA1A2PVFFIXjKrbmOZ36R9fqwFvd8R4EaRJ
         cYnhu2f2QEiAjaP8id6fNvL34jfKl199++nDKHH3nP6WmY+lyhocgH/e4/dsflY8LpYK
         aM/z1VEp9wRohA3oubDHYsnnkWeN6fYCuSGRZkDRBCE7Q8ILsG3cXG/QCOPdYAlwl5I2
         kMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=duhliZsTlIE2VE8yD9vItvYrUD0HDA/4yEWWMGX5Kx8=;
        b=A2mN3RyciFo3KFuXOe/oQWaqxqsKzhOi8TdYnmj03quZve1ZBDKeN+e4F7GRQuwqfY
         sUb++crqaL/Pz4AxAnPZ0DkGycZh2A6FtVPLyd4b7hXY4r0elSvSx8tFK/ZVc15sM/qR
         XgOlHbCgrtj5eBRYC606f3HPYkpy5MHIZSd7ZBFEmLYMkrGhCtBSc+nI+XEvNb3sWNc7
         9Qm7YnK74AXgwUwPOxBgb2Flk7Rdgw963vmQKTOM2C2wLfvDos8K1mfQPrQSaUUnLvQk
         WZOF8jYGVztH60Rg30IoP5a8my6mspKPdrXgwMKLbWPvjmJdQl1hosLrvTZZk6FGcZvG
         YM5w==
X-Gm-Message-State: AOAM533AFWRg8RPvAvUDxK64fPpdUy+mnxCi4kuC2Ehl8wh+huQ0JZhN
        FOCYFGMhsu1mikqEKQWT054=
X-Google-Smtp-Source: ABdhPJzJtTsr+j4Sdr2KPv0nNpH/3oiY0Ubhor20w5rCeE7F4ayrmIa6cIpaKq3l3IWpK3LvstxKGg==
X-Received: by 2002:a1c:7316:: with SMTP id d22mr24382165wmb.171.1630150061869;
        Sat, 28 Aug 2021 04:27:41 -0700 (PDT)
Received: from oci-gb-a1.vcn08061408.oraclevcn.com ([2603:c020:c001:7eff:7c7:9b76:193f:d476])
        by smtp.googlemail.com with ESMTPSA id d145sm13571021wmd.3.2021.08.28.04.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 04:27:41 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] ARM: dts: NSP: Fix MX65 MDIO mux warnings
Date:   Sat, 28 Aug 2021 11:27:03 +0000
Message-Id: <20210828112704.2283805-5-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210828112704.2283805-1-mnhagan88@gmail.com>
References: <20210828112704.2283805-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly this fixes the following message:
mdio-mii-mux: $nodename:0: 'mdio-mii-mux' does not match '^mdio-mux[\\-@]?'

Secondly, move the mdio-mux to within the axi node and add the unit
address. This requires exposing the axi node via a label in bcm-nsp.dtsi.
This fixes the following warning:
Warning (unit_address_vs_reg): /mdio-mii-mux: node has a reg or ranges property, but no unit name

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi                | 2 +-
 arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 180827500f25..1c08daa18858 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -166,7 +166,7 @@ periph_clk: periph_clk {
 		};
 	};
 
-	axi@18000000 {
+	axi: axi@18000000 {
 		compatible = "simple-bus";
 		ranges = <0x00000000 0x18000000 0x0011c40c>;
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi b/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
index 57d0c5eb9749..102acd85fab2 100644
--- a/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
+++ b/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
@@ -70,10 +70,12 @@ led-5 {
 			gpios = <&gpioa 31 GPIO_ACTIVE_HIGH>;
 		};
 	};
+};
 
-	mdio-mii-mux {
+&axi {
+	mdio-mux@3f1c0 {
 		compatible = "mdio-mux-mmioreg", "mdio-mux";
-		reg = <0x1803f1c0 0x4>;
+		reg = <0x3f1c0 0x4>;
 		mux-mask = <0x2000>;
 		mdio-parent-bus = <&mdio_ext>;
 		#address-cells = <1>;
-- 
2.27.0

