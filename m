Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551093E8997
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 07:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbhHKFKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 01:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbhHKFKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 01:10:15 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF27C061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 22:09:52 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so7799153pjr.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 22:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4+7r2wYydj9au+exa7oWuSxVTG1fG9vj88byQqpPzeA=;
        b=REqW9HT3NtCm96X/UTqL6H0NrJ1fIp6GMmyoBimTuev8tTbiuwvCtB4wIHxl7q4rDp
         mUfKK33ey52cW1j8jGxlmHWCk6awcVR4l/nqqpYq58rlaCtVnYphmP/H2vXrPp9lRnPR
         zPRMs7DYH+6BhhqSZbKaHoSHrQWUBFfJksWfig9AHRdTm/6a4yRuMEf+NodKwdwwrWi7
         NZKSCkgb1u0DTPQJHkFjaBg3CgnThigPF+WUn9+7+p2eG+Sb4Jqm968e/oT38GsYWJSD
         /PjxyVqblCnukoc37nQF4r5OPm84eeoJ5TquZNdN87M/xJdnp5rIo6/0fEpYrNSwU779
         XDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4+7r2wYydj9au+exa7oWuSxVTG1fG9vj88byQqpPzeA=;
        b=R/UTy8q8m4icBKE30OQl4Hxvd2X9wX/c5SP2kIZnnKfNZ6PR4wch7oVARmHY1smTVZ
         Wt/VXo8gAxJNh2Vyx7IU+PPj0K037/oOxQytvPyn3xHJL4zci0k7GoBu7uIRR6/iWVu1
         ECpkGCDkYhtkKHEcFbrWBqmGMm3iXtT568LyaCfhlTIVxTvtw7I4GqorGM1WK2e4QArR
         pn2x/JN9XduCSdjGd6SxxCO7WFE//bkzQ/9J3DJS5hyzsP3sC2TYJyZhzovoXe60SGgA
         1tS4LgNo5PTCHe/3Rbwm/iVREBg/1OuzGMFqRCqOGuNe11NFYWYyMctWC/vj/51kagKf
         9YnA==
X-Gm-Message-State: AOAM532OjXQrmB3tJaNQUFRj9fQZ0mW5/E4yRqjGxWLOSkSV++HsSYWP
        5Di+jRBBWzaanzPb20P7MQo=
X-Google-Smtp-Source: ABdhPJzQSclZvmDBAqfL4DFvgTqVQURrVJD2YoHY90U2Cizd0Xv0QwdLJYaVQMlPn0NbFY2atWrcrA==
X-Received: by 2002:a63:1359:: with SMTP id 25mr139944pgt.79.1628658591547;
        Tue, 10 Aug 2021 22:09:51 -0700 (PDT)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id z15sm30314987pgc.13.2021.08.10.22.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 22:09:51 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     narmstrong@baylibre.com
Cc:     jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com, art@khadas.com, nick@khadas.com,
        gouwa@khadas.com
Subject: [PATCH] arm64: dts: meson-sm1: add spdifin spdifout nodes
Date:   Wed, 11 Aug 2021 13:09:41 +0800
Message-Id: <20210811050941.398360-1-art@khadas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spdifin spdifout spdifout_b nodes for Amlogic SM1 SoCs.

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
index 3d8b1f4f2..1efdbb61e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
@@ -356,6 +356,33 @@ tdmin_lb: audio-controller@3c0 {
 			status = "disabled";
 		};
 
+		spdifin: audio-controller@400 {
+			compatible = "amlogic,g12a-spdifin",
+			"amlogic,axg-spdifin";
+			reg = <0x0 0x400 0x0 0x30>;
+			#sound-dai-cells = <0>;
+			sound-name-prefix = "SPDIFIN";
+			interrupts = <GIC_SPI 151 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&clkc_audio AUD_CLKID_SPDIFIN>,
+			<&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
+			clock-names = "pclk", "refclk";
+			resets = <&clkc_audio AUD_RESET_SPDIFIN>;
+			status = "disabled";
+		};
+
+		spdifout: audio-controller@480 {
+			compatible = "amlogic,g12a-spdifout",
+			"amlogic,axg-spdifout";
+			reg = <0x0 0x480 0x0 0x50>;
+			#sound-dai-cells = <0>;
+			sound-name-prefix = "SPDIFOUT";
+			clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
+			<&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
+			clock-names = "pclk", "mclk";
+			resets = <&clkc_audio AUD_RESET_SPDIFOUT>;
+			status = "disabled";
+		};
+
 		tdmout_a: audio-controller@500 {
 			compatible = "amlogic,sm1-tdmout";
 			reg = <0x0 0x500 0x0 0x40>;
@@ -401,6 +428,19 @@ tdmout_c: audio-controller@580 {
 			status = "disabled";
 		};
 
+		spdifout_b: audio-controller@680 {
+			compatible = "amlogic,g12a-spdifout",
+			"amlogic,axg-spdifout";
+			reg = <0x0 0x680 0x0 0x50>;
+			#sound-dai-cells = <0>;
+			sound-name-prefix = "SPDIFOUT_B";
+			clocks = <&clkc_audio AUD_CLKID_SPDIFOUT_B>,
+			<&clkc_audio AUD_CLKID_SPDIFOUT_B_CLK>;
+			clock-names = "pclk", "mclk";
+			resets = <&clkc_audio AUD_RESET_SPDIFOUT_B>;
+			status = "disabled";
+		};
+
 		toacodec: audio-controller@740 {
 			compatible = "amlogic,sm1-toacodec",
 				     "amlogic,g12a-toacodec";
-- 
2.25.1

