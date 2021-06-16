Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E663AA238
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 19:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhFPRPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 13:15:20 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52068 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhFPRPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 13:15:20 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15GHD8LQ020064;
        Wed, 16 Jun 2021 12:13:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623863588;
        bh=BH72bZyeNH/FYvgeSqvxbowmWgkRNsupvwrEn3isOgc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pjcHGqySMHvTAopbKNW6uWs0ZrfW+5g8ox2VQ/JGw0kMoqOjTaamUIihCwi0qp59O
         TNHOlUHJOxc6oYcYxAYR1APXt3ySR/kzqAyT2M2j3wXFNnDhwCBgHNqm3JGvZ2mRUw
         cT4cGbG3wIO7TJVyMZidBI9MRLbDozLHQu8m5gZs=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15GHD81Y011842
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Jun 2021 12:13:08 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 16
 Jun 2021 12:13:04 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 16 Jun 2021 12:13:04 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15GHCSuD106909;
        Wed, 16 Jun 2021 12:12:58 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Suman Anna <s-anna@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/3] arm64: dts: ti: k3-am64-main: Reserve OCMRAM for DMSC-lite and secure proxy communication
Date:   Wed, 16 Jun 2021 22:42:23 +0530
Message-ID: <20210616171224.24635-3-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210616171224.24635-1-a-govindraju@ti.com>
References: <20210616171224.24635-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The final 128KB in SRAM is reserved by default for DMSC-lite code and
secure proxy communication buffer. The memory region used for DMSC-lite
code can be optionally freed up by secure firmware API[1]. However, the
buffer for secure proxy communication is not configurable. This default
hardware configuration is unique for AM64.

Therefore, indicate the area reserved for DMSC-lite code and secure proxy
communication buffer in the oc_sram device tree node.

[1] - http://downloads.ti.com/tisci/esd/latest/6_topic_user_guides/security_handover.html#triggering-security-handover

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Reviewed-by: Suman Anna <s-anna@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index e918afc2298e..27888ee6f039 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -27,6 +27,14 @@
 		tfa-sram@0 {
 			reg = <0x0 0x20000>;
 		};
+
+		dmsc-sram@1e0000 {
+			reg = <0x1e0000 0x1c000>;
+		};
+
+		sproxy-sram@1fc000 {
+			reg = <0x1fc000 0x4000>;
+		};
 	};
 
 	main_conf: syscon@43000000 {
-- 
2.17.1

