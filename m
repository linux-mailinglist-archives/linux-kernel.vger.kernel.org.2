Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D8A315917
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 23:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbhBIWCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 17:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbhBIT0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 14:26:05 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D5DC0611BD;
        Tue,  9 Feb 2021 11:24:05 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id i8so33605862ejc.7;
        Tue, 09 Feb 2021 11:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CZhB/NEJnRkF+TAIIRVQHf9Sf3lp8bbtJmnwDMjx8Fs=;
        b=Pyc5ziHzNys/DmCyRT/IZGIkNcdwW2jRgLCnoc4oF8HBHLtJtCiv0kUD4zYNFyZa4x
         tsRhEQYCT38Fd0H0Abr+owIadmo000OiOsBVbBNY1c8lq3yyGFhiywtPmdB7SyMr5xA/
         7dBhgbhf/lMMhbEgEaCYOGL4y0SfCsw4OVoGRNaMuAysPUZRXX3C/Wugdz54W7NIbzAK
         yIniVvoW90wX2vxClo30xhcM7wj1eziBRUrwCR6I5t/+WoNaR5JPaNVcK/+6JIdpUcIe
         6dUXHGldLgGppakAV4WYu17hJEALqICRYPfKCuRUrNRfhcirmZLe83WLPPMg9xbfeuu8
         MX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CZhB/NEJnRkF+TAIIRVQHf9Sf3lp8bbtJmnwDMjx8Fs=;
        b=E4pJg63H4zxa7SjAbqKWIRTXo8Af+r53v42moQmhDUSJJVW2cGCrnH/DwajOSLfUfc
         YyY4emptzVoC+gNviC+SMvQMo2tfFRY5zk6j3kETSxed546E9CEqOBBKtNu9tqHIg0YV
         znNflPIGAWuvJ0yg46VUXWyMCXHTLXPnStIv185s0eyYpnKNpJS+bU3OAroE8i1nViOz
         9dpldZ0tp/j0cFr7cAc8ljQ5o/Hv0Eno1r9de9tXX8DLnV71dz6iXfmMRWk0YDbwoohB
         e2I6GOgc46f9AzccUCZoDWqcqvQQRE4YOe2sdEUKhMpqod/b+lYc6FaKESMrS/lKjSTK
         H5kA==
X-Gm-Message-State: AOAM533pV6AzgrgydSLZGun/23MV8mI4QBIx+qiWdIFAvGGwFu/oMt3Y
        ZUoJqqMkgtQLQ4vhlxnjtOE=
X-Google-Smtp-Source: ABdhPJyq2Hl1AVM7CRPhdEGtJGkzjJIdzCmDQRstMgdguIQWb8IxLBedrovs7JsXiNbv5ZgVdfF2Tw==
X-Received: by 2002:a17:906:6449:: with SMTP id l9mr24927901ejn.320.1612898644183;
        Tue, 09 Feb 2021 11:24:04 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w3sm11075779eja.52.2021.02.09.11.24.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 11:24:03 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 7/8] arm64: dts: rockchip: add rk3328 dwc3 usb controller node
Date:   Tue,  9 Feb 2021 20:23:49 +0100
Message-Id: <20210209192350.7130-7-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210209192350.7130-1-jbx6244@gmail.com>
References: <20210209192350.7130-1-jbx6244@gmail.com>
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

