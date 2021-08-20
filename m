Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C803F356C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 22:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239196AbhHTUjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 16:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhHTUjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 16:39:32 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0282FC061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 13:38:54 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so8178908pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 13:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Y3InmxhpoYm0EqzJmyqf4YlfP1zDRs0XYYkt2TgkvM=;
        b=hv4DtvS/OHwCV6bvqRoipVam5+aL/92SEmRA16aPth6cOL+Pm3gdWuNUbsCg0nKGeI
         Y8T0wh1aW5WX54zH9pDZHGh2IdM7u6FPC8XaTzM8GD2ARnd+9uQ8tAfVPtwPp/8SaxcH
         d5vHqs1FmqnKPPiLNLAc50w95TmxKyPzZZkPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Y3InmxhpoYm0EqzJmyqf4YlfP1zDRs0XYYkt2TgkvM=;
        b=HRwRu5EcNXoTZaznjQlaTfyq+ib4/D1bqnvbbuWIg4s9OOvA8CVOZpllt7foFGC+T5
         NqbXlwGfumWCNP3Rzldw6k1q1UcOaXMovZuS+KNCtU9elhdqBsit9cw1Cf3S/3YB6I50
         g/qnTEs84wMETE2l2igv9+koapr00cU0DLxo6tYucId1N1MuavUawcg2XXD/XDFfz++4
         MnCZ65BB2jmltAeOdjj+5EGuwy/MXn80EGE1o8yb+I7uaKZ/C4JlXqjDd8gif5Rpi7Og
         UWWqb/JJIjCeoIjvaT/7dLk87iAhTyD7myPkxzQh7ci8aPFdikzpZdINlPPjwkDS4dQt
         +TpQ==
X-Gm-Message-State: AOAM531rwYkrWWDkb3MxPU84Lo8U8Zf3bHcL36UyhR1Cnp5rynOAYvib
        h2xdGBayoqrs2Ra0HeAINbXUP5Atvo3WtVDt
X-Google-Smtp-Source: ABdhPJxrQzbsRBaNc9QyvYCGYzZnK/vRO7AW7HVMqxcDBV6N96brDzCEUE7I1E7nfkqN9IDBarsdIQ==
X-Received: by 2002:a17:90a:8b81:: with SMTP id z1mr6382419pjn.82.1629491933445;
        Fri, 20 Aug 2021 13:38:53 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:b547:9806:eff8:54ae])
        by smtp.gmail.com with ESMTPSA id b1sm7749715pfv.151.2021.08.20.13.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 13:38:52 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] arm64: dts: rockchip: add RK3399 Gru gpio-line-names
Date:   Fri, 20 Aug 2021 13:38:35 -0700
Message-Id: <20210820133829.1.Ica46f428de8c3beb600760dbcd63cf879ec24baf@changeid>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's convenient to get nice names for GPIOs. In particular, Chrome OS
tooling looks for "AP_FLASH_WP" and "AP_FLASH_WP_L". The rest are
provided for convenience.

Gru-Bob and Gru-Kevin share the gru-chromebook.dtsi, and for the most
part they share pin meanings. I omitted a few areas where components
were available only on one or the other.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 .../dts/rockchip/rk3399-gru-chromebook.dtsi   | 176 +++++++++++++++++
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi | 180 ++++++++++++++++++
 2 files changed, 356 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
index 1384dabbdf40..9b2c679f5eca 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
@@ -251,6 +251,182 @@ edp_out_panel: endpoint@0 {
 	};
 };
 
+&gpio0 {
+	gpio-line-names = /* GPIO0 A 0-7 */
+			  "AP_RTC_CLK_IN",
+			  "EC_AP_INT_L",
+			  "PP1800_AUDIO_EN",
+			  "BT_HOST_WAKE_L",
+			  "WLAN_MODULE_PD_L",
+			  "H1_INT_OD_L",
+			  "CENTERLOGIC_DVS_PWM",
+			  "",
+
+			  /* GPIO0 B 0-4 */
+			  "WIFI_HOST_WAKE_L",
+			  "PMUIO2_33_18_L",
+			  "PP1500_EN",
+			  "AP_EC_WARM_RESET_REQ",
+			  "PP3000_EN";
+};
+
+&gpio1 {
+	gpio-line-names = /* GPIO1 A 0-7 */
+			  "",
+			  "",
+			  "SPK_PA_EN",
+			  "",
+			  "TRACKPAD_INT_L",
+			  "AP_EC_S3_S0_L",
+			  "AP_EC_OVERTEMP",
+			  "AP_SPI_FLASH_MISO",
+
+			  /* GPIO1 B 0-7 */
+			  "AP_SPI_FLASH_MOSI_R",
+			  "AP_SPI_FLASH_CLK_R",
+			  "AP_SPI_FLASH_CS_L_R",
+			  "WLAN_MODULE_RESET_L",
+			  "WIFI_DISABLE_L",
+			  "MIC_INT",
+			  "",
+			  "AP_I2C_DVS_SDA",
+
+			  /* GPIO1 C 0-7 */
+			  "AP_I2C_DVS_SCL",
+			  "AP_BL_EN",
+			  /*
+			   * AP_FLASH_WP is crossystem ABI. Schematics call it
+			   * AP_FW_WP or CPU1_FW_WP, depending on the variant.
+			   */
+			  "AP_FLASH_WP",
+			  "LITCPU_DVS_PWM",
+			  "AP_I2C_AUDIO_SDA",
+			  "AP_I2C_AUDIO_SCL",
+			  "",
+			  "HEADSET_INT_L";
+};
+
+&gpio2 {
+	gpio-line-names = /* GPIO2 A 0-7 */
+			  "",
+			  "",
+			  "SD_IO_PWR_EN",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+
+			  /* GPIO2 B 0-7 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+
+			  /* GPIO2 C 0-7 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "AP_SPI_EC_MISO",
+			  "AP_SPI_EC_MOSI",
+			  "AP_SPI_EC_CLK",
+			  "AP_SPI_EC_CS_L",
+
+			  /* GPIO2 D 0-4 */
+			  "BT_DEV_WAKE_L",
+			  "",
+			  "WIFI_PCIE_CLKREQ_L",
+			  "WIFI_PERST_L",
+			  "SD_PWR_3000_1800_L";
+};
+
+&gpio3 {
+	gpio-line-names = /* GPIO3 A 0-7 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "AP_SPI_TPM_MISO",
+			  "AP_SPI_TPM_MOSI_R",
+			  "AP_SPI_TPM_CLK_R",
+			  "AP_SPI_TPM_CS_L_R",
+
+			  /* GPIO3 B 0-7 */
+			  "EC_IN_RW",
+			  "",
+			  "AP_I2C_TP_SDA",
+			  "AP_I2C_TP_SCL",
+			  "AP_I2C_TP_PU_EN",
+			  "TOUCH_INT_L",
+			  "",
+			  "",
+
+			  /* GPIO3 C 0-7 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+
+			  /* GPIO3 D 0-7 */
+			  "I2S0_SCLK",
+			  "I2S0_LRCK_RX",
+			  "I2S0_LRCK_TX",
+			  "I2S0_SDI_0",
+			  "I2S0_SDI_1",
+			  "",
+			  "I2S0_SDO_1",
+			  "I2S0_SDO_0";
+};
+
+&gpio4 {
+	gpio-line-names = /* GPIO4 A 0-7 */
+			  "I2S_MCLK",
+			  "AP_I2C_MIC_SDA",
+			  "AP_I2C_MIC_SCL",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+
+			  /* GPIO4 B 0-7 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+
+			  /* GPIO4 C 0-7 */
+			  "AP_I2C_TS_SDA",
+			  "AP_I2C_TS_SCL",
+			  "GPU_DVS_PWM",
+			  "UART_DBG_TX_AP_RX",
+			  "UART_AP_TX_DBG_RX",
+			  "",
+			  "BIGCPU_DVS_PWM",
+			  "EDP_HPD_3V0",
+
+			  /* GPIO4 D 0-5 */
+			  "SD_CARD_DET_L",
+			  "USB_DP_HPD",
+			  "TOUCH_RESET_L",
+			  "PP3300_DISP_EN",
+			  "",
+			  "SD_SLOT_PWR_EN";
+};
+
 ap_i2c_mic: &i2c1 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
index 5d7a9d96d163..61afb5f0f15b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
@@ -389,6 +389,186 @@ &cru {
 		<400000000>;
 };
 
+&gpio0 {
+	gpio-line-names = /* GPIO0 A 0-7 */
+			  "CLK_32K_AP",
+			  "EC_IN_RW_OD",
+			  "SPK_PA_EN",
+			  "WLAN_PERST_1V8_L",
+			  "WLAN_PD_1V8_L",
+			  "WLAN_RF_KILL_1V8_L",
+			  "BIGCPU_DVS_PWM",
+			  "SD_CD_L_JTAG_EN",
+
+			  /* GPIO0 B 0-5 */
+			  "BT_EN_BT_RF_KILL_1V8_L",
+			  "PMUIO2_33_18_L_PP3300_S0_EN",
+			  "TOUCH_RESET_L",
+			  "AP_EC_WARM_RESET_REQ",
+			  "PEN_RESET_L",
+			  /*
+			   * AP_FLASH_WP_L is crossystem ABI. Schematics call
+			   * it AP_FLASH_WP_R_ODL.
+			   */
+			  "AP_FLASH_WP_L";
+};
+
+&gpio1 {
+	gpio-line-names = /* GPIO1 A 0-7 */
+			  "PEN_INT_ODL",
+			  "PEN_EJECT_ODL",
+			  "BT_HOST_WAKE_1V8_L",
+			  "WLAN_HOST_WAKE_1V8_L",
+			  "TOUCH_INT_ODL",
+			  "AP_EC_S3_S0_L",
+			  "AP_EC_OVERTEMP",
+			  "AP_SPI_FLASH_MISO",
+
+			  /* GPIO1 B 0-7 */
+			  "AP_SPI_FLASH_MOSI_R",
+			  "AP_SPI_FLASH_CLK_R",
+			  "AP_SPI_FLASH_CS_L_R",
+			  "SD_CARD_DET_ODL",
+			  "",
+			  "AP_EXPANSION_IO1",
+			  "AP_EXPANSION_IO2",
+			  "AP_I2C_DISP_SDA",
+
+			  /* GPIO1 C 0-7 */
+			  "AP_I2C_DISP_SCL",
+			  "H1_INT_ODL",
+			  "EC_AP_INT_ODL",
+			  "LITCPU_DVS_PWM",
+			  "AP_I2C_AUDIO_SDA",
+			  "AP_I2C_AUDIO_SCL",
+			  "AP_EXPANSION_IO3",
+			  "HEADSET_INT_ODL",
+
+			  /* GPIO1 D0 */
+			  "AP_EXPANSION_IO4";
+};
+
+&gpio2 {
+	gpio-line-names = /* GPIO2 A 0-7 */
+			  "AP_I2C_PEN_SDA",
+			  "AP_I2C_PEN_SCL",
+			  "SD_IO_PWR_EN",
+			  "UCAM_RST_L",
+			  "PP1250_CAM_EN",
+			  "WCAM_RST_L",
+			  "AP_EXPANSION_IO5",
+			  "AP_I2C_CAM_SDA",
+
+			  /* GPIO2 B 0-7 */
+			  "AP_I2C_CAM_SCL",
+			  "AP_H1_SPI_MISO",
+			  "AP_H1_SPI_MOSI",
+			  "AP_H1_SPI_CLK",
+			  "AP_H1_SPI_CS_L",
+			  "",
+			  "",
+			  "",
+
+			  /* GPIO2 C 0-7 */
+			  "UART_EXPANSION_TX_AP_RX",
+			  "UART_AP_TX_EXPANSION_RX",
+			  "UART_EXPANSION_RTS_AP_CTS",
+			  "UART_AP_RTS_EXPANSION_CTS",
+			  "AP_SPI_EC_MISO",
+			  "AP_SPI_EC_MOSI",
+			  "AP_SPI_EC_CLK",
+			  "AP_SPI_EC_CS_L",
+
+			  /* GPIO2 D 0-4 */
+			  "PP2800_CAM_EN",
+			  "CLK_24M_CAM",
+			  "WLAN_PCIE_CLKREQ_1V8_L",
+			  "",
+			  "SD_PWR_3000_1800_L";
+};
+
+&gpio3 {
+	gpio-line-names = /* GPIO3 A 0-7 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+
+			  /* GPIO3 B 0-7 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+
+			  /* GPIO3 C 0-7 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+
+			  /* GPIO3 D 0-7 */
+			  "I2S0_SCLK",
+			  "I2S0_LRCK_RX",
+			  "I2S0_LRCK_TX",
+			  "I2S0_SDI_0",
+			  "STRAP_LCDBIAS_L",
+			  "STRAP_FEATURE_1",
+			  "STRAP_FEATURE_2",
+			  "I2S0_SDO_0";
+};
+
+&gpio4 {
+	gpio-line-names = /* GPIO4 A 0-7 */
+			  "I2S_MCLK",
+			  "AP_I2C_EXPANSION_SDA",
+			  "AP_I2C_EXPANSION_SCL",
+			  "DMIC_EN",
+			  "",
+			  "",
+			  "",
+			  "",
+
+			  /* GPIO4 B 0-7 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+
+			  /* GPIO4 C 0-7 */
+			  "AP_I2C_TS_SDA",
+			  "AP_I2C_TS_SCL",
+			  "GPU_DVS_PWM",
+			  "UART_DBG_TX_AP_RX",
+			  "UART_AP_TX_DBG_RX",
+			  "BL_EN",
+			  "BL_PWM",
+			  "",
+
+			  /* GPIO4 D 0-5 */
+			  "",
+			  "DISPLAY_RST_L",
+			  "",
+			  "PPVARP_LCD_EN",
+			  "PPVARN_LCD_EN",
+			  "SD_SLOT_PWR_EN";
+};
+
 &i2c_tunnel {
 	google,remote-bus = <0>;
 };
-- 
2.33.0.rc2.250.ged5fa647cd-goog

