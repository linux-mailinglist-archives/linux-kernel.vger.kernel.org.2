Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480AE387E09
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 18:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351008AbhERQ6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 12:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350985AbhERQ6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 12:58:30 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E02C061573;
        Tue, 18 May 2021 09:57:12 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id lz27so15636172ejb.11;
        Tue, 18 May 2021 09:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N9ujW2Qt+Tu2jJvNcfLPCqaX9eDRsnHYASEY0yw0Dq8=;
        b=ojtTWGFpHNUppvadJCAYjdoYALUkefFh5Xy0sK1ZUDsq6ctNPpEVZszIsucn9HC4Mw
         GWgvACJxYyerY+40xWclD/KiRpePGHzW9E3fIHv5MRmOzJkc8lO30NN5dJkcYdoUY1oZ
         h34iMm9vC26eWutAu7GBdYsOoP/TpnbqpkIJkL1vc8bXIpXJRVl52o18brE1Nfja8H8T
         kAB/Ei1Omw7UskKeI04iD2FCVgdEBBUt2K+Fyr39lrbY6Bts7EAEm6cFh+3bftff/5cl
         W7U8/5dix/1mqUd9RdW9gEehfiZ3n5Jr3Y0ZXLQ+3m2zp8c4YsUQl8iQFNGCxd9/Pe+D
         HwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N9ujW2Qt+Tu2jJvNcfLPCqaX9eDRsnHYASEY0yw0Dq8=;
        b=JXGO2sBQIfroc4iUUD+YBGr11Z3iVNPUzZ+CFBWFQlOQNTAotG66DaOWDCJbauXD0X
         ASJlufnl6exrTKSv5o+yweRK28xqppx8KxltyTfFRHuD9w9yK+k1EPyCLh9VfvgoPFhf
         sdPtYCnnNGuPFhmjFo/tPcd56AENlw3WIyGziyphmni7DEKGAMwoj1+b3mi5rBPqK+Qf
         r0dXp64K6eNCCIh5Yu+vxOv8ip+34ZgZpmyyA5MYdS4ZZf1WqMR/7cRDOgu4UG3HOh+O
         Gm4MIkP92KwRoo8Pn5PHX060O/ECx27a9mmvzEfIj8HLiDjwWWaPSjmGQaLW8tlhPyw1
         +Tww==
X-Gm-Message-State: AOAM532rueQIp9XdKjeE7knB4INXB32AS7cEIUjsaUJ5CcW4g5qRAsDo
        f5trJfh3DfIsK1pYIRpNhwc=
X-Google-Smtp-Source: ABdhPJwfpapo85Wh49dGvXSFDyNc0G2A96Py0HuVovh4Il+3IEoTCKjNOigTL8725aDGkcWbDu5rkw==
X-Received: by 2002:a17:906:63d2:: with SMTP id u18mr7083280ejk.186.1621357030747;
        Tue, 18 May 2021 09:57:10 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id n2sm13525676edi.32.2021.05.18.09.57.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 May 2021 09:57:10 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/4] ARM: dts: rockchip: rename nodename for phy-rockchip-inno-usb2
Date:   Tue, 18 May 2021 18:56:57 +0200
Message-Id: <20210518165658.12764-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210518165658.12764-1-jbx6244@gmail.com>
References: <20210518165658.12764-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pattern: "^(|usb-|usb2-|usb3-|pci-|pcie-|sata-)phy(@[0-9a-f,]+)*$"
in phy-provider.yaml has required "#phy-cells" for phy nodes.
The "phy-cells" in rockchip-inno-usb2 nodes are located in subnodes.
Rename the nodename to pattern "usb2phy@[0-9a-f]+$" to prevent
notifications.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/schemas/
phy/phy-provider.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 4 ++--
 arch/arm/boot/dts/rv1108.dtsi | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 5774bc309..cffd7acfb 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -190,7 +190,7 @@
 			status = "disabled";
 		};
 
-		u2phy0: usb2-phy@760 {
+		u2phy0: usb2phy@760 {
 			compatible = "rockchip,rk3228-usb2phy";
 			reg = <0x0760 0x0c>;
 			clocks = <&cru SCLK_OTGPHY0>;
@@ -217,7 +217,7 @@
 			};
 		};
 
-		u2phy1: usb2-phy@800 {
+		u2phy1: usb2phy@800 {
 			compatible = "rockchip,rk3228-usb2phy";
 			reg = <0x0800 0x0c>;
 			clocks = <&cru SCLK_OTGPHY1>;
diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 884872ca5..9bd0acf3b 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -265,7 +265,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-		u2phy: usb2-phy@100 {
+		u2phy: usb2phy@100 {
 			compatible = "rockchip,rv1108-usb2phy";
 			reg = <0x100 0x0c>;
 			clocks = <&cru SCLK_USBPHY>;
-- 
2.11.0

