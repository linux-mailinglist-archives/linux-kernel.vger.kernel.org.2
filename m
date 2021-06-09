Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754B13A132B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbhFILrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbhFILrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:47:45 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544DEC061789
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 04:45:50 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r9so8429432wrz.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OFkJ4b+Pv9hA9fg/hHFAqZWjcxiSUunEmPfat4jQdC4=;
        b=Ts8TbXPH/MqSFzh9qeCjFmMNJ7DArCCG2XWTDXEtuPLRtl+xkadG1WFuu39jDDUi4+
         OO8e4MOv7ihZdTaJzg8M/4NSKkz3ESZduJ/4QdjJWlzP0xDHzQ0+SrhNptIp5iDlRhgg
         0g/xrpytLVFKOGxadnv5Cnp9xGISUFO6q2Wz+p8xhR+sEkQW3oV/XFsKEf8VAUM+xEzy
         14uvEx8qE470D8gTNWjlF760fnB1rFj/8wWetPOPZTYuCLGu1Wgw9V2qMQwc6tecubPs
         MI8Jsnli5nAbGI5iwfJ/GERKxvG/UR0SDVLQQcr7vcdhtuhEDCdsaxaTF9Vmbzg0PjGq
         Kz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=OFkJ4b+Pv9hA9fg/hHFAqZWjcxiSUunEmPfat4jQdC4=;
        b=khvHlZu5afFRhyIp211l9SBP3v1n6OUI4SSqYHrvQ2gkuLTfguBGAzHOwQKGXZ66wa
         M+BPXpM+6i87iUWxaKE16RgkzSFR8J28zpcLGuQ/3xuF/hCaPJtw3y1VtMdSpoZZILay
         Y3xMX3F5EMES+v44DbEgaSnoHj/6B8Li4Vr3rc1uzuEu2tmxI7AcDuVe4LF1FD6z2iKT
         T/Cyut3VoOzdY9ze1bVD9yvrdWOJiFktQYF6oV3yAAylY03UgXG+kbPJHKliDohj6sxt
         Gwz9W8mDjjKaGTgxIiYlYnIOX23zG3wLzs5Yns+tz6n45mQ6Pb7Ap5Qen3Os9ftkNauK
         x3FQ==
X-Gm-Message-State: AOAM532Fvm7GZntITE+DKFJqZ5FWlzuXCHjZN19zPH9P7JTPVYfqyXYW
        4JSNSRES7tivgaS1Ex3WYjKaS6qrnVSXCFfa
X-Google-Smtp-Source: ABdhPJyURMieWSx/lNg4b2fyHhX9FhDq86PbmK1VZeJCx8xeecvlukgiGTspB96uKuiLVljoOa9klg==
X-Received: by 2002:a5d:47ce:: with SMTP id o14mr27341558wrc.273.1623239148723;
        Wed, 09 Jun 2021 04:45:48 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id t9sm16840930wmq.14.2021.06.09.04.45.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jun 2021 04:45:48 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 16/31] arm64: zynqmp: Move clock node to zynqmp-clk-ccf.dtsi
Date:   Wed,  9 Jun 2021 13:44:52 +0200
Message-Id: <48bfd8cf0de4d10b9c4d745218595f28954f70d5.1623239033.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623239033.git.michal.simek@xilinx.com>
References: <cover.1623239033.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using clock firmware driver is not the only one option how to configure
clock. In past fixed clocks were also used and that configuration is still
valid that's why move clock firmware node to the same file where zynqmp_clk
references are used.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi | 13 ++++++++++++-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi         | 15 ---------------
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
index cf5295224750..1e0b1bca7c94 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
@@ -2,7 +2,7 @@
 /*
  * Clock specification for Xilinx ZynqMP
  *
- * (C) Copyright 2017 - 2019, Xilinx, Inc.
+ * (C) Copyright 2017 - 2021, Xilinx, Inc.
  *
  * Michal Simek <michal.simek@xilinx.com>
  */
@@ -40,6 +40,17 @@ aux_ref_clk: aux_ref_clk {
 	};
 };
 
+&zynqmp_firmware {
+	zynqmp_clk: clock-controller {
+		#clock-cells = <1>;
+		compatible = "xlnx,zynqmp-clk";
+		clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>,
+			 <&aux_ref_clk>, <&gt_crx_ref_clk>;
+		clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk",
+			      "aux_ref_clk", "gt_crx_ref_clk";
+	};
+};
+
 &can0 {
 	clocks = <&zynqmp_clk CAN0_REF>, <&zynqmp_clk LPD_LSBUS>;
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 3fa0517cfd98..bd3f0d456ca4 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -156,21 +156,6 @@ zynqmp_power: zynqmp-power {
 				mbox-names = "tx", "rx";
 			};
 
-			zynqmp_clk: clock-controller {
-				#clock-cells = <1>;
-				compatible = "xlnx,zynqmp-clk";
-				clocks = <&pss_ref_clk>,
-					 <&video_clk>,
-					 <&pss_alt_ref_clk>,
-					 <&aux_ref_clk>,
-					 <&gt_crx_ref_clk>;
-				clock-names = "pss_ref_clk",
-					      "video_clk",
-					      "pss_alt_ref_clk",
-					      "aux_ref_clk",
-					      "gt_crx_ref_clk";
-			};
-
 			nvmem_firmware {
 				compatible = "xlnx,zynqmp-nvmem-fw";
 				#address-cells = <1>;
-- 
2.31.1

