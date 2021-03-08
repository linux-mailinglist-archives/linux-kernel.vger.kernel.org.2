Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8534A331B0A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 00:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhCHXkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 18:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhCHXje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 18:39:34 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C8DC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 15:39:33 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l11so9863811wrp.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 15:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uZSiFVg2/jE/hYgherndxXMvyjYS/mnvO0aiBAtVcTY=;
        b=P8IUb56aHvxNiBcR/CB2PDATcfaksqV1COHeci+/1rPLmnHVhC6/J6dmga1ype2kPD
         y5nO+fZRT+Q01YyfV6dVWpjcTV11S8AEgt0Dxv8iLETo3Qpqiyr7cMzYyVbhV3edes7D
         Ntt0UFi0vz8SeHE5hMwsYOeNeHeWcAoXpk5ZKt46Bo+ktVq3Y9izfK5uUe+7S0+v7eFu
         9vMfA4eKgd0IEn1yEIgXRwddhbs780bpdI0xhI9olt3COY4rJ0giRYZnnW49jp8BdNjI
         gs2xNiv25fwG+FW6Ga3uwnMrTvMZUtYDa7uxqloKRC4t9A2Xs2ip5AqCtbPITWTov4pQ
         T6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uZSiFVg2/jE/hYgherndxXMvyjYS/mnvO0aiBAtVcTY=;
        b=lv+sqeKVP4fMhAQMYG9nPkCey/zam2Vy6paaZ2TzY8bUKSeXVAZ86caIQxo9jEbWDH
         8JCDgkrtnwkHrP4ewUXBL/IuPMMycQBJgT8t3jVTIJnDFD4S3Pk0/Wfx3xYKYO1aQwhm
         vPG39Slv5KRE4fBIgnRl0eNKgopavqq7f9hpc5Oh4NM+D6iZNXBauggwK/4Obmf9bF92
         4Ldx3OCmv5+vMkdo+BgLE4aHwEmzudWa7RxTzle4qdkYqHLvhP6dgIl+IkRaSL8ZY6aP
         Qpt6lSytiO4Qumc6DUikHAjZV3AhpqbupddTEp+JNOvdFAKLgBMDsH166YsXf/HpuLhZ
         XSdA==
X-Gm-Message-State: AOAM533ZNvPJhxQfj1fqXCEJwqE5MsA1qSoLg3GTjP8UOTyE32xuYpKD
        MUmmqRRCjpMvwxOqw+8BaBvFiw==
X-Google-Smtp-Source: ABdhPJyRtfec+1PX+zot1HDJ41Qt6zDolA4BMsNuV8uYbC8MJpD9vosvX5TPZ+IV7sKmKEzKnFQ+EA==
X-Received: by 2002:adf:b642:: with SMTP id i2mr2594471wre.8.1615246772633;
        Mon, 08 Mar 2021 15:39:32 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-141-80.adsl.proxad.net. [82.252.141.80])
        by smtp.gmail.com with ESMTPSA id b186sm1145408wmc.44.2021.03.08.15.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 15:39:32 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     heiko@sntech.de
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, Lin Huang <hl@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH v5 3/4] arm64: dts: rockchip: Enable dmc and dfi nodes on gru.
Date:   Tue,  9 Mar 2021 00:38:57 +0100
Message-Id: <20210308233858.24741-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210308233858.24741-1-daniel.lezcano@linaro.org>
References: <20210308233858.24741-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lin Huang <hl@rock-chips.com>

Enable the DMC (Dynamic Memory Controller) and the DFI (DDR PHY
Interface) nodes on gru boards so we can support DDR DVFS.

Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../dts/rockchip/rk3399-gru-chromebook.dtsi   |  4 ++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  | 45 +++++++++++++++++++
 .../boot/dts/rockchip/rk3399-op1-opp.dtsi     | 29 ++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
index 1384dabbdf40..d32b015ad2cd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
@@ -398,3 +398,7 @@ ap_i2c_tp: &i2c5 {
 		rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
 	};
 };
+
+&dmc {
+	center-supply = <&ppvar_centerlogic>;
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 32dcaf210085..fc3dc9a4b43c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -289,6 +289,12 @@
 	status = "okay";
 };
 
+&dmc_opp_table {
+	opp04 {
+		opp-suspend;
+	};
+};
+
 /*
  * Set some suspend operating points to avoid OVP in suspend
  *
@@ -489,6 +495,45 @@ ap_i2c_audio: &i2c8 {
 	status = "okay";
 };
 
+&dfi {
+	status = "okay";
+};
+
+&dmc {
+	status = "okay";
+	upthreshold = <25>;
+	downdifferential = <15>;
+	rockchip,ddr3_speed_bin = <21>;
+	rockchip,pd_idle = <0x40>;
+	rockchip,sr_idle = <0x2>;
+	rockchip,sr_mc_gate_idle = <0x3>;
+	rockchip,srpd_lite_idle	= <0x4>;
+	rockchip,standby_idle = <0x2000>;
+	rockchip,dram_dll_dis_freq = <300000000>;
+	rockchip,phy_dll_dis_freq = <125000000>;
+	rockchip,auto_pd_dis_freq = <666000000>;
+	rockchip,ddr3_odt_dis_freq = <333000000>;
+	rockchip,ddr3_drv = <40>;
+	rockchip,ddr3_odt = <120>;
+	rockchip,phy_ddr3_ca_drv = <40>;
+	rockchip,phy_ddr3_dq_drv = <40>;
+	rockchip,phy_ddr3_odt = <240>;
+	rockchip,lpddr3_odt_dis_freq = <333000000>;
+	rockchip,lpddr3_drv = <34>;
+	rockchip,lpddr3_odt = <240>;
+	rockchip,phy_lpddr3_ca_drv = <40>;
+	rockchip,phy_lpddr3_dq_drv = <40>;
+	rockchip,phy_lpddr3_odt = <240>;
+	rockchip,lpddr4_odt_dis_freq = <333000000>;
+	rockchip,lpddr4_drv = <60>;
+	rockchip,lpddr4_dq_odt = <40>;
+	rockchip,lpddr4_ca_odt = <40>;
+	rockchip,phy_lpddr4_ca_drv = <40>;
+	rockchip,phy_lpddr4_ck_cs_drv = <80>;
+	rockchip,phy_lpddr4_dq_drv = <80>;
+	rockchip,phy_lpddr4_odt = <60>;
+};
+
 &sdhci {
 	/*
 	 * Signal integrity isn't great at 200 MHz and 150 MHz (DDR) gives the
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
index 69cc9b05baa5..c9e7032b01a8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
@@ -110,6 +110,31 @@
 			opp-microvolt = <1075000>;
 		};
 	};
+
+	dmc_opp_table: dmc_opp_table {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <900000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <900000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <666000000>;
+			opp-microvolt = <900000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <900000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <928000000>;
+			opp-microvolt = <900000>;
+		};
+	};
 };
 
 &cpu_l0 {
@@ -139,3 +164,7 @@
 &gpu {
 	operating-points-v2 = <&gpu_opp_table>;
 };
+
+&dmc {
+	operating-points-v2 = <&dmc_opp_table>;
+};
-- 
2.17.1

