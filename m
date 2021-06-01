Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1912396FC0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 11:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbhFAJDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 05:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbhFAJDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 05:03:36 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CFEC061756
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 02:01:55 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o2-20020a05600c4fc2b029019a0a8f959dso1434060wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 02:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5IwYtF72UjHa9iHdNpTtLmTlD6+WFBrg2eN19aC9Omk=;
        b=OfHfr2YXdaik4HKexBimsUEZCrWe/vMas3BTeQo75Ubex1ai0ml+iFJUOW0SlBQsty
         qy0yBRbXnatJv9JiqrN44w+xgkP2NABvzTKh34RjnuKF09ocolSaZGoFVj5br5TT0utJ
         qLx4psENsGYhXwZ9zGm1odrUfe8ctjMdkJR+9qWCBVRRvsWbUMzh8OUshjVSbc8x7e5G
         tKKGPv5cUwJv5PWAdheSFcfDEPI5QH/TIbcDyIT2zTuh8EIXNcDddzM5p0lHFs16Z7nO
         Wed3cRXItq1DqC4sksn74Q+qlCGOrbGLLxGaJcimxO2O4hIWiMPoIHQsM7M6BtEu6xKv
         WOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5IwYtF72UjHa9iHdNpTtLmTlD6+WFBrg2eN19aC9Omk=;
        b=lCNtFPX9SCMV7HZj1PbiYiTefDABKiM4ukqSbH+vJVqQnYFBqa3tAa9WO9ISoW3prH
         j2QVfuZWNaf1H9J4Vs3VxXNPHN8r3q/piP21WdCtnER90BHgp9xlgSlSPDTAi5Xp93W6
         QSir+9qbA+ZJ4RCuFP/B5faXuwgEtQhBqTOfbarWkf0oB5IoTqIUVKL4pDPslBkiYViF
         SiJaAVZI++T5dQLnsGOhsf/KDqdOJ7KI0UdjttMzby2Nddm6/HwIEcGAvQO3iLDuvTKa
         XHwINfAXKrKdgrXZbJNhXDeSfzjh4oAKwiLnhDOxtoRDllTUXcuP6p4ZJjrwpPMWA7gf
         uPLA==
X-Gm-Message-State: AOAM533Awodf6C7CbDSOqqmh2bSf2wK/1Kn9oXi5AfPBjC7nZjejL6UI
        ZoGcLJe5OqZ/NW41Va/nN9JSKA==
X-Google-Smtp-Source: ABdhPJw937YIFZ3Mgv/DYBbwiziumbrHOQVmBQ3enRfvTw+ZjCIAI3CQUIO+DpKL0u1MnzrsSMqu4A==
X-Received: by 2002:a1c:6782:: with SMTP id b124mr3412909wmc.159.1622538113518;
        Tue, 01 Jun 2021 02:01:53 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:a3a:d001:6a80:207a])
        by smtp.gmail.com with ESMTPSA id e17sm2668199wre.79.2021.06.01.02.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 02:01:53 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tobetter@gmail.com, Christian Hewitt <christianshewitt@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 6/6] arm64: dts: meson-sm1-odroid-hc4: add spifc node to ODROID-HC4
Date:   Tue,  1 Jun 2021 11:01:40 +0200
Message-Id: <20210601090140.261768-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210601090140.261768-1-narmstrong@baylibre.com>
References: <20210601090140.261768-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=997; i=narmstrong@baylibre.com;
 h=from:subject; bh=4Apj0m6+83jroquluYgqns8V8hJcFEuKMqCVi55Btpk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBgtfc89atbVaTE3uafIleEYxQ46PDSj92zOM1wRlkq
 xyAYr5CJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYLX3PAAKCRB33NvayMhJ0aP2EA
 DOy817Oo3Aw84S+Vq02JvA9hnzMVgdWOH2Xwq8XXi21rpRxxEh3wCNcd7TR4zXAipgkWmsrAlnCQHV
 gYnk3Kzqi45QnjCLQFg84z/AySFoj3xYPXZcAnXD0EcjZhxDYJp7eO1Q3THuMl+3KyEl+ggQZUFwxn
 Eu8MKw0nss4YCdEX3MPGzP7gQaWRdfh5oEXHFGNvUiVDQauiIRBi0CMKDR5LkarQv8QQItSjX0VRaF
 RHWzQgAKhDwQEEI5I9TzPgnV+vnEGKhdwa3tn0g7qVc5wEgGkO3D/nwL9bx+ZsaQrbDs/E4srkbN23
 P0L32/DxrxqIZ9x/lMmPnmAG85gWZ4uqRjyWMonZdk5LF1VxH/gcdw4DV7dcmU1jXvUdlcAKtUnAW1
 EK5AK8luOn/JkXoqFNtLQK4peojuEEjT3XVYN6WuO4K9eo5ihFKyyiQfAOttb2XM66Vqz5D9QVdwRy
 NklDye6BtHYHHtqIf+YUIuUFB1/3CPda9YEOuqkbnyFKbelSyHDt30c3W30mpihcJZ1UhfrCPADIUj
 IKrlfhgf2xXuzuLNJtM1gETqRiAS3wx7qfLDuV2LIAwQvBEMDNDPNCUxi6r4Lu4CMaLJu57e9NoaxQ
 bolmEBvHycxccGDNqm38g0kBao4zf5f++xXwU1c9G17H9Nx7YNvl4du2hs0w==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Hewitt <christianshewitt@gmail.com>

Add a node for the XT25F128B SPI-NOR flash to make it accessible
from Linux.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-sm1-odroid-hc4.dts      | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
index d36c25b5b690..3c2ebc7333a1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
@@ -116,6 +116,20 @@ &sd_emmc_c {
 	status = "disabled";
 };
 
+&spifc {
+	status = "okay";
+	pinctrl-0 = <&nor_pins>;
+	pinctrl-names = "default";
+
+	spi-flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <104000000>;
+	};
+};
+
 &usb {
 	phys = <&usb2_phy1>;
 	phy-names = "usb2-phy1";
-- 
2.25.1

