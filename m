Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A933A6A49
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbhFNPaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:30:04 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:47022 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbhFNP3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:29:00 -0400
Received: by mail-ed1-f48.google.com with SMTP id s15so6130709edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kQrvzT3HMIq/VUwAv4dTR2eeSkMJZ0iueuT25ug4iCA=;
        b=BCTPch/Zz2IvSimcHKlQbu+xczjdoFt17x3iNgJglVbKtQwucpN0M8w8MJbwaIUj1t
         ZBGkH2diKQeknOD15bYw6sK9I3Sr5LZTbr2rLiBotss6bbWBN0N/Mm2YlLTgU631xFtY
         Pn7R3hWUUvvEaP12BL/s50Nnv9oVv9fP1NcPtRdG4lafeWUqcMuwxDwhRPG53AdMwgex
         M8QDgFESd+rxQUzw9S0XnlVrlU9xRyxrnUylpvia521unEApzHBRw8id15vgFHT/Jb07
         h5Jb8s/fjLVmzc+nlTV4SfNUdhdFpT3ODGYK7L7blk+6pSI2N9vr0woJRYEkHNr1p9CM
         9IWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kQrvzT3HMIq/VUwAv4dTR2eeSkMJZ0iueuT25ug4iCA=;
        b=Ka97aS82jQ1o422N2Si2p35DggHooP1qCNQ8IQMc/ASjzDWDGAWHaXSBlLpHUGLsYk
         I792osHXj/Un1tQ1GYH+mFiNHr542D6ZqA+qrPWN9vrnjCJTojdUUeqC/oxA/MHgLO9/
         6Mr0dY38gUYTJuipgqwjL7P/Owm4LlUYoVq836XieRNIwF/2ge1h4CCtNM6pu3zvHsnU
         QkN4ALSbudcHEP7BHOiU6YjVxkQTcvSXW6o2+nn0i1R7POAoc76UHR3EdcFSboeQCLHl
         z8f8c3jesgNVJZPoCWNJfHJntZI7uzn3S+KSyWFAlBAjrQs+NGHbYVCFWMtfusDSprv1
         R8KA==
X-Gm-Message-State: AOAM531TnpFn8nmXkLeTJRBSKNobILDZJPsouSTgcb+pYkhssNINPX+V
        vr5RJ7FVfcoAlBL9QJuxayymGrnc2IEcdeTL
X-Google-Smtp-Source: ABdhPJzx/0wJqNFGnfGuym0x8al3TBoobZMyUCqznLhmIV9ewv4+diD0kJ0rKPVC9XmW19qoS+Ii4A==
X-Received: by 2002:aa7:de1a:: with SMTP id h26mr17365903edv.176.1623684356457;
        Mon, 14 Jun 2021 08:25:56 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id a7sm7482393ejr.110.2021.06.14.08.25.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jun 2021 08:25:56 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 09/33] arm64: zynqmp: Add phy description for usb3.0
Date:   Mon, 14 Jun 2021 17:25:17 +0200
Message-Id: <cd856e5f87bc967373691d04e79de3d0022ef424.1623684253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623684253.git.michal.simek@xilinx.com>
References: <cover.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb3.0 requires serdes setting that's why also wire it up.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 6 ++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 3 +++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts | 3 +++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts | 3 +++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts | 3 +++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 3 +++
 6 files changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index 4622e173d262..80415e202814 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -538,6 +538,9 @@ &usb0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb0_default>;
 	dr_mode = "peripheral";
+	phy-names = "usb3-phy";
+	phys = <&psgtr 2 PHY_TYPE_USB3 0 0>;
+	maximum-speed = "super-speed";
 };
 
 /* ULPI SMSC USB3320 */
@@ -546,6 +549,9 @@ &usb1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb1_default>;
 	dr_mode = "host";
+	phy-names = "usb3-phy";
+	phys = <&psgtr 3 PHY_TYPE_USB3 1 0>;
+	maximum-speed = "super-speed";
 };
 
 &watchdog0 {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index b37aee2d85b9..719a9e5e1b01 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -979,6 +979,9 @@ &usb0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb0_default>;
 	dr_mode = "host";
+	phy-names = "usb3-phy";
+	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
+	maximum-speed = "super-speed";
 };
 
 &watchdog0 {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index 7e1b024f71e1..d7ecfcadd08b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -469,6 +469,9 @@ &usb0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb0_default>;
 	dr_mode = "host";
+	phy-names = "usb3-phy";
+	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
+	maximum-speed = "super-speed";
 };
 
 &watchdog0 {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
index b140fd2c86aa..403a8ea6a36f 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
@@ -491,6 +491,9 @@ &usb0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb0_default>;
 	dr_mode = "host";
+	phy-names = "usb3-phy";
+	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
+	maximum-speed = "super-speed";
 };
 
 &watchdog0 {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index 4919cdec835b..186d2e00d4a0 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -985,6 +985,9 @@ &usb0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb0_default>;
 	dr_mode = "host";
+	phy-names = "usb3-phy";
+	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
+	maximum-speed = "super-speed";
 };
 
 &watchdog0 {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index b0c2eae1b4b3..0bf29ff9c714 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -811,6 +811,9 @@ &usb0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb0_default>;
 	dr_mode = "host";
+	phy-names = "usb3-phy";
+	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
+	maximum-speed = "super-speed";
 };
 
 &zynqmp_dpdma {
-- 
2.32.0

