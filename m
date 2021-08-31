Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DA73FC879
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 15:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239475AbhHaNld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 09:41:33 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:56521 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239249AbhHaNlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:41:24 -0400
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id ADD1622253;
        Tue, 31 Aug 2021 15:40:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1630417227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vdn135cl0Aa6ie1nYkWTTrV8H1I8kgyGrXPstkLRVzM=;
        b=u04y2bFacYO6lMT7BE3LIHIs5oI3gVPjOhvvU1G4mzcKQ81gu8UcDV+2qVozZYjxxnSjna
        6da/JwPZYv7NeauU6Rs4DvQe1/MD4ZNM8rp5hPv+P1SGzxm/15vU0Ny8+1edRuDvCFkkx6
        tldKAsxT9Jk1YnX3g/G37Fsv2jxO3X4=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 7/7] arm64: dts: ls1028a: use phy-mode instead of phy-connection-type
Date:   Tue, 31 Aug 2021 15:40:13 +0200
Message-Id: <20210831134013.1625527-8-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210831134013.1625527-1-michael@walle.cc>
References: <20210831134013.1625527-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In linux both are identical, phy-mode is used more often, though. Also
for the ls1028a both phy-connection-type and phy-mode was used, one for
the enetc nodes and the other for the switch nodes. Unify them. But the
main reason for this is that the device tree files can be shared with
the u-boot ones; there the enetc driver only supports the "phy-mode"
property.

Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts      | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts               | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts               | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts
index 836a9b7d8263..7cd29ab970d9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var1.dts
@@ -54,6 +54,6 @@ &enetc_port0 {
 
 &enetc_port1 {
 	phy-handle = <&phy0>;
-	phy-connection-type = "rgmii-id";
+	phy-mode = "rgmii-id";
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts
index 77ed0ebd2c75..9b5e92fb753e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts
@@ -42,6 +42,6 @@ vddh: vddh-regulator {
 
 &enetc_port1 {
 	phy-handle = <&phy1>;
-	phy-connection-type = "rgmii-id";
+	phy-mode = "rgmii-id";
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
index b3e9c499e8b0..d74e738e4070 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
@@ -90,7 +90,7 @@ phy0: ethernet-phy@5 {
 
 &enetc_port0 {
 	phy-handle = <&phy0>;
-	phy-connection-type = "sgmii";
+	phy-mode = "sgmii";
 	managed = "in-band-status";
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
index f36f87858aef..6e2a1da662fb 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
@@ -320,7 +320,7 @@ mux: mux-controller {
 
 &enetc_port1 {
 	phy-handle = <&qds_phy1>;
-	phy-connection-type = "rgmii-id";
+	phy-mode = "rgmii-id";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index ea11b1eb01f8..7719f44bcaed 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -221,7 +221,7 @@ qsgmii_phy3: ethernet-phy@13 {
 
 &enetc_port0 {
 	phy-handle = <&sgmii_phy0>;
-	phy-connection-type = "sgmii";
+	phy-mode = "sgmii";
 	managed = "in-band-status";
 	status = "okay";
 };
-- 
2.30.2

