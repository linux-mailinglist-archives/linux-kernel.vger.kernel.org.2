Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F97383D78
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 21:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbhEQTdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 15:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbhEQTdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 15:33:35 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AEBC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:32:19 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h4so7591887wrt.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L8WTjWPmIl+NDRjCmABsKVn9l03ziqgB8V0IbKFuAe8=;
        b=aHD6a8IdVjOg0h8WRgNOByK07H0QAQ4/UU76vtJetpUiQI0uTzqBWSA+aUXa8IzbD3
         WVWXUrzA14bH2vQW+g6L7y3wLcY8BJwcnXStZbNfB8b3xGLAKXRFwMEcbHO7OKP6CRAp
         /XX2p4EC1cl1uZWnF/nmJKrmDaJDpiRYslPZ0PObUl53wQPmh1GLaK6wxVaFX/+3H1a7
         sPcwGqYazDaXq7Shh7WFdm94Me8lThY8yPoTRqgN6J7WTz6B73Vdz1cDyOBeW+po/JeP
         Tp7o1M1FmC+jGt0qRNgRok1ollox6tQZL7zsY3V7p2u8eOQ5jN4OinfScYXD5eHP1fiF
         MEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L8WTjWPmIl+NDRjCmABsKVn9l03ziqgB8V0IbKFuAe8=;
        b=fPz5i6wxcBtWOHL/IG9Ym94gXeNBIHwDWx2d7TWSfZEC1IezveayCD9aauzUYyJTID
         ZSY4JL5KC4PJY6CgoL+sXiRSS1uK+h5tmqw2SWuvNaRAnvkwJm8d5LLW4EHZpJ90YV2L
         Fqyx1R7BuQ0jpbhiChEpGGjvX0LlzV4IE+cLEC+jPuBfMvm/Rxsf4xLnal6XyZojRVG+
         oKQPydFcrmVLachJA+iIOJJLgf36z/RYHPfjqpOQvVogRQOXPXEyES+C/wf8MLszWniP
         AC3hF9vPsByRW+D28sQ+bhQLoTCkLu0JHQhsAcxc1lHJ0gnYU/aRJIchWIhKStIFGL0C
         sqxA==
X-Gm-Message-State: AOAM532Xqs1iy+LkI3mrndKpnFns7NPtWZxoKpg85OV1qH7RC68Vqb+0
        SGFCFzDC3NAydlM66AiUiDf2/g==
X-Google-Smtp-Source: ABdhPJw3CybUk4/0huZ1HOTg4nECJ87UHqLkIlNugxHB4p9+DNz+ufghReTZPLPr1/GLbP2eVN6sgA==
X-Received: by 2002:adf:f58e:: with SMTP id f14mr1545053wro.258.1621279937843;
        Mon, 17 May 2021 12:32:17 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id e10sm18928907wrw.20.2021.05.17.12.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 12:32:17 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, linus.walleij@linaro.org, olof@lixom.net,
        robh+dt@kernel.org, soc@kernel.org, ulli.kroll@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 1/5] ARM: dts: gemini: add labels for USB, IDE, flash and ethernet
Date:   Mon, 17 May 2021 19:32:01 +0000
Message-Id: <20210517193205.691147-2-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517193205.691147-1-clabbe@baylibre.com>
References: <20210517193205.691147-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding label will help simplify boards's dts.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/gemini.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index 065ed10a79fa..6e043869d495 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -16,7 +16,7 @@ soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&intcon>;
 
-		flash@30000000 {
+		flash: flash@30000000 {
 			compatible = "cortina,gemini-flash", "cfi-flash";
 			syscon = <&syscon>;
 			pinctrl-names = "default";
@@ -321,7 +321,7 @@ pci_intc: interrupt-controller {
 			};
 		};
 
-		ethernet@60000000 {
+		ethernet: ethernet@60000000 {
 			compatible = "cortina,gemini-ethernet";
 			reg = <0x60000000 0x4000>, /* Global registers, queue */
 			      <0x60004000 0x2000>, /* V-bit */
@@ -356,7 +356,7 @@ gmac1: ethernet-port@1 {
 			};
 		};
 
-		ide@63000000 {
+		ide0: ide@63000000 {
 			compatible = "cortina,gemini-pata", "faraday,ftide010";
 			reg = <0x63000000 0x1000>;
 			interrupts = <4 IRQ_TYPE_EDGE_RISING>;
@@ -369,7 +369,7 @@ ide@63000000 {
 			#size-cells = <0>;
 		};
 
-		ide@63400000 {
+		ide1: ide@63400000 {
 			compatible = "cortina,gemini-pata", "faraday,ftide010";
 			reg = <0x63400000 0x1000>;
 			interrupts = <5 IRQ_TYPE_EDGE_RISING>;
@@ -414,7 +414,7 @@ display-controller@6a000000 {
 			status = "disabled";
 		};
 
-		usb@68000000 {
+		usb0: usb@68000000 {
 			compatible = "cortina,gemini-usb", "faraday,fotg210";
 			reg = <0x68000000 0x1000>;
 			interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
@@ -435,7 +435,7 @@ usb@68000000 {
 			status = "disabled";
 		};
 
-		usb@69000000 {
+		usb1: usb@69000000 {
 			compatible = "cortina,gemini-usb", "faraday,fotg210";
 			reg = <0x69000000 0x1000>;
 			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.26.3

