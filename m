Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF5C371752
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhECO76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhECO74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:59:56 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B352C06174A;
        Mon,  3 May 2021 07:59:03 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id p4so4374037pfo.3;
        Mon, 03 May 2021 07:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T8p4SUJLNthax2VMMiUlx/ciMxgy2stQoSBLgzmRg+g=;
        b=Gyh63uTqoLi7xsgZ8KFZaHgp195t2COs1Khr7pQ3v3A9jLYYZQXEjcWBtTUufMCcfB
         W+GO0ZWMoDybJX7KCZd3BvRgPKHGqObtZS/baocMeDHNKRejFzLpDpH03rmoAo9Ca8J4
         Et5Efebw+4X+iPhyk/c8HzcbHm2HU/mgfR2BBicvP4BqMMCNGRtKQHtsbWsXoRZU+wGs
         6bhrQqefGjajYe+bz4iYSeZbx08Xb9YUOhdq+M1LnYK4uJxIdeUns1UP4BP6dSUfvwwm
         AinFqwNIFo5hNk6AbN8hUjRnkEIMhvggISNVNBLDUD47dsf+Za8Aga0RHXMu033ayhgM
         jL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T8p4SUJLNthax2VMMiUlx/ciMxgy2stQoSBLgzmRg+g=;
        b=gN9rwXYkAZZenXheOKAsUcnG6vsXE/UikoImz/raTfPUBIoxDiFFp6F7xGineZxEDv
         ayYWVKdD1qJ1LqUgdMWOcwF326J3Q44tO6KXIp90bZPhFwbv45NYaNFmUkkUHig2lVWh
         cdVVipi9/FNJw+FDaC1fs3dwaPKUqlw+XxBjy6nz/X0yzCHQh/Oc3j39Jima73Zu7BFv
         wnW/e2xUFsiAMgNC1cvQCkkRE4kccNvv7JgpmvQMaRvvjldbLrwT/fJExStacLTyHG+q
         2Z9tt+bdcxyQQWc5t9oK46c1yOW8cbcz2C597FfNtyK20KqJYezJzguFnNm381MEftzV
         Qcvw==
X-Gm-Message-State: AOAM532bvZ7Yao4aTbGX6PqKnJf16+f5b1eOSwEUr7cWVNIvEDawBjt7
        qvEdiGNKA28BvKmcRpVh0BabnLzBh6o=
X-Google-Smtp-Source: ABdhPJyTCiMr85dToL7W7xU2vb4Qpo5Ks5YqJPeyX7+h1d8WLSi2KDlGbuhXJN3MMLzCNr93NeBiLw==
X-Received: by 2002:a63:1c02:: with SMTP id c2mr18586031pgc.195.1620053942631;
        Mon, 03 May 2021 07:59:02 -0700 (PDT)
Received: from archl-on2.. ([103.51.75.154])
        by smtp.gmail.com with ESMTPSA id k38sm3593983pgi.73.2021.05.03.07.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 07:59:02 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCHv1 4/9] arm64: dts: amlogic: Add hdmi power domain for g12a and g12b
Date:   Mon,  3 May 2021 14:54:37 +0000
Message-Id: <20210503145503.1477-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503145503.1477-1-linux.amoon@gmail.com>
References: <20210503145503.1477-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hdmi power domain id for hdmi on g12a and g12b sbc
to enable hdmi power domain via "pwrc" controller.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts     | 1 +
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts       | 1 +
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts    | 1 +
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi | 1 +
 arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi      | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index 24599f448564..23de424b58ee 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -373,6 +373,7 @@ &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
 	pinctrl-names = "default";
+	power-domains = <&pwrc PWRC_G12A_HDMI_ID>;
 };
 
 &hdmi_tx_tmds_port {
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index a26bfe72550f..4a8b3bc07151 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -208,6 +208,7 @@ &hdmi_tx {
 	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
 	pinctrl-names = "default";
 	hdmi-supply = <&vcc_5v>;
+	power-domains = <&pwrc PWRC_G12A_HDMI_ID>;
 };
 
 &hdmi_tx_tmds_port {
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 1c821800514a..09ce4a95ed7e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -309,6 +309,7 @@ &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
 	pinctrl-names = "default";
+	power-domains = <&pwrc PWRC_G12A_HDMI_ID>;
 	hdmi-supply = <&vcc_5v>;
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
index e99533dd64c2..2ac7cdcd622a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
@@ -510,6 +510,7 @@ &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
 	pinctrl-names = "default";
+	power-domains = <&pwrc PWRC_G12A_HDMI_ID>;
 	hdmi-supply = <&vcc_5v>;
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
index feb088504740..f8ff459cff78 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
@@ -286,6 +286,7 @@ &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
 	pinctrl-names = "default";
+	power-domains = <&pwrc PWRC_G12A_HDMI_ID>;
 	hdmi-supply = <&vcc_5v>;
 };
 
-- 
2.31.1

