Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2333A87D7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhFORg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:36:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:34916 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231371AbhFORfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:35:03 -0400
X-UUID: 1caaa7783bf846d3b6503ba572f258cc-20210616
X-UUID: 1caaa7783bf846d3b6503ba572f258cc-20210616
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1925669352; Wed, 16 Jun 2021 01:32:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Jun 2021 01:32:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Jun 2021 01:32:46 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <seiya.wang@mediatek.com>, <wenst@google.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        YT Lee <yt.lee@mediatek.corp-partner.google.com>
Subject: [PATCH 27/27] arm64: dts: mt8195: add cpufreq device nodes
Date:   Wed, 16 Jun 2021 01:32:33 +0800
Message-ID: <20210615173233.26682-27-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
In-Reply-To: <20210615173233.26682-1-tinghan.shen@mediatek.com>
References: <20210615173233.26682-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YT Lee <yt.lee@mediatek.corp-partner.google.com>

this 8195 cpufreq device nodes is based on below dt-bindings document
https://patchwork.kernel.org/project/linux-mediatek/patch/1615549235-27700-3-git-send-email-hector.yuan@mediatek.com/

and it also rely on below patches to work
[1]https://patchwork.kernel.org/project/linux-mediatek/patch/1615549235-27700-2-git-send-email-hector.yuan@mediatek.com/
[2]https://patchwork.kernel.org/project/linux-pm/patch/20201105125001.32473-1-lukasz.luba@arm.com/
[3]https://patchwork.kernel.org/project/linux-pm/patch/20201103090600.29053-3-lukasz.luba@arm.com/
[4]https://patchwork.kernel.org/project/linux-pm/patch/20201103090600.29053-4-lukasz.luba@arm.com/
[5]https://patchwork.kernel.org/project/linux-pm/patch/20201103090600.29053-5-lukasz.luba@arm.com/

Signed-off-by: YT Lee <yt.lee@mediatek.corp-partner.google.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 25a6ee7c6659..e5ebf8d663df 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -54,6 +54,7 @@
 			compatible = "arm,cortex-a55", "arm,armv8";
 			reg = <0x000>;
 			enable-method = "psci";
+			performance-domains = <&performance 0>;
 			clock-frequency = <1701000000>;
 			capacity-dmips-mhz = <578>;
 			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
@@ -66,6 +67,7 @@
 			compatible = "arm,cortex-a55", "arm,armv8";
 			reg = <0x100>;
 			enable-method = "psci";
+			performance-domains = <&performance 0>;
 			clock-frequency = <1701000000>;
 			capacity-dmips-mhz = <578>;
 			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
@@ -78,6 +80,7 @@
 			compatible = "arm,cortex-a55", "arm,armv8";
 			reg = <0x200>;
 			enable-method = "psci";
+			performance-domains = <&performance 0>;
 			clock-frequency = <1701000000>;
 			capacity-dmips-mhz = <578>;
 			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
@@ -90,6 +93,7 @@
 			compatible = "arm,cortex-a55", "arm,armv8";
 			reg = <0x300>;
 			enable-method = "psci";
+			performance-domains = <&performance 0>;
 			clock-frequency = <1701000000>;
 			capacity-dmips-mhz = <578>;
 			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
@@ -102,6 +106,7 @@
 			compatible = "arm,cortex-a78", "arm,armv8";
 			reg = <0x400>;
 			enable-method = "psci";
+			performance-domains = <&performance 1>;
 			clock-frequency = <2171000000>;
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&cpuoff_b &clusteroff_b>;
@@ -114,6 +119,7 @@
 			compatible = "arm,cortex-a78", "arm,armv8";
 			reg = <0x500>;
 			enable-method = "psci";
+			performance-domains = <&performance 1>;
 			clock-frequency = <2171000000>;
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&cpuoff_b &clusteroff_b>;
@@ -126,6 +132,7 @@
 			compatible = "arm,cortex-a78", "arm,armv8";
 			reg = <0x600>;
 			enable-method = "psci";
+			performance-domains = <&performance 1>;
 			clock-frequency = <2171000000>;
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&cpuoff_b &clusteroff_b>;
@@ -138,6 +145,7 @@
 			compatible = "arm,cortex-a78", "arm,armv8";
 			reg = <0x700>;
 			enable-method = "psci";
+			performance-domains = <&performance 1>;
 			clock-frequency = <2171000000>;
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&cpuoff_b &clusteroff_b>;
@@ -257,6 +265,12 @@
 		method = "smc";
 	};
 
+	performance: performance-controller@11bc10 {
+		compatible = "mediatek,cpufreq-hw";
+		reg = <0 0x0011bc10 0 0x120>, <0 0x0011bd30 0 0x120>;
+		#performance-domain-cells = <1>;
+	};
+
 	timer: timer {
 		compatible = "arm,armv8-timer";
 		interrupt-parent = <&gic>;
-- 
2.18.0

