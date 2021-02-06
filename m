Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2F0311F85
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 19:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhBFSwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 13:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhBFSvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 13:51:48 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383A4C06178C;
        Sat,  6 Feb 2021 10:50:32 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id p20so18291307ejb.6;
        Sat, 06 Feb 2021 10:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CZhB/NEJnRkF+TAIIRVQHf9Sf3lp8bbtJmnwDMjx8Fs=;
        b=R6fCBkx8u/8W0j4Rtc2sDV5mm7466GqtBmaU3vj2oPj7rN7vsiuOzmxLNyOAcg79Gv
         hi5iZPp1jAJaVzKa1JveNGfh4eQAzOYUP1MIvahayzsK5HS9uXw2nu7cOFzVYVoC+6fZ
         JUSTdRiyMz8UJgsUkHRhznQgWl9UmSYAsf6XBZBQ20prRIx9SRbSqgcKNsQNTRbNdVrN
         Za/xPHXOLOyfI1T8aqoD+PWjUzp6e7MJg8xky6fsIx1+eEwiND7PrxkT6bnlCV9SVIO9
         Cp+iGMm/MydppiVAH29H62ZB+FViUMtoZDYNYPyZNlyzm8IQQilWgxpjoVUkaGXUpoJ2
         6QXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CZhB/NEJnRkF+TAIIRVQHf9Sf3lp8bbtJmnwDMjx8Fs=;
        b=dPJw9Bs06bkW0nkHrFoV4FykPRMekuvsoSIslUNHhNY6YG+drSW7PJ3d2m3DDNXJjO
         jZTgSQwwnwt/eNizyYnaYsgBvPoJo2Z7kYJ1Rt/fRG+mkCMU05BwvMhs9cWJxn2rMhoH
         p79MFAlXkgnYsUsUtRlQ3uy8JR4ZXEMFI++veGCx80hIQIUok+i5pb8oL/STWupvFkEM
         0XxYYoklAczx96ith4xX4emAOO0WsmF//qo89Z0U5H14FiN8U4KdEU/wg5haK+fbodio
         tb167hGoQ1Vx54ywKbZZoQMPFAsBDlpgWTrk5o7A5B2neWhb4tSg8xokCSpS6pR0P7+r
         s5mw==
X-Gm-Message-State: AOAM531w7+jabUCqR1S+QziZC71UqcKxJnI6T6Dt8fa2CRU9g+NTgkNx
        YFWrI5MOKgdZFfA9gtXDxQlFA59b4VY=
X-Google-Smtp-Source: ABdhPJwsSh1tKVCA79/3hisG5qg/We4ZfU7mddmJzSHUz1nyYR4t8uOAg3xqYl8Fbc8VHsMOR1t+zw==
X-Received: by 2002:a17:906:854d:: with SMTP id h13mr9521280ejy.124.1612637431042;
        Sat, 06 Feb 2021 10:50:31 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id cb21sm5890005edb.57.2021.02.06.10.50.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Feb 2021 10:50:30 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/8] arm64: dts: rockchip: add rk3328 dwc3 usb controller node
Date:   Sat,  6 Feb 2021 19:50:16 +0100
Message-Id: <20210206185017.1817-7-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210206185017.1817-1-jbx6244@gmail.com>
References: <20210206185017.1817-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cameron Nemo <cnemo@tutanota.com>

RK3328 SoCs have one USB 3.0 OTG controller which uses DWC_USB3
core's general architecture. It can act as static xHCI host
controller, static device controller, USB 3.0/2.0 OTG basing
on ID of USB3.0 PHY.

Signed-off-by: William Wu <william.wu@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Cameron Nemo <cnemo@tutanota.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Changed V2:
  remove node wrapper
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 4d4cd1830..a3b069a10 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -988,6 +988,25 @@
 		status = "disabled";
 	};
 
+	usbdrd3: usb@ff600000 {
+		compatible = "rockchip,rk3328-dwc3", "snps,dwc3";
+		reg = <0x0 0xff600000 0x0 0x100000>;
+		interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_USB3OTG_REF>, <&cru SCLK_USB3OTG_SUSPEND>,
+			 <&cru ACLK_USB3OTG>;
+		clock-names = "ref_clk", "suspend_clk",
+			      "bus_clk";
+		dr_mode = "otg";
+		phy_type = "utmi_wide";
+		snps,dis-del-phy-power-chg-quirk;
+		snps,dis_enblslpm_quirk;
+		snps,dis-tx-ipgap-linecheck-quirk;
+		snps,dis-u2-freeclk-exists-quirk;
+		snps,dis_u2_susphy_quirk;
+		snps,dis_u3_susphy_quirk;
+		status = "disabled";
+	};
+
 	gic: interrupt-controller@ff811000 {
 		compatible = "arm,gic-400";
 		#interrupt-cells = <3>;
-- 
2.11.0

