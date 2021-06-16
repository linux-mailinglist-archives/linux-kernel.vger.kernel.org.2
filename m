Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4EA3AA082
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbhFPP6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:58:34 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:38103 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbhFPP5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:57:32 -0400
Received: from mwalle01.fritz.box (ip4d17858c.dynamic.kabel-deutschland.de [77.23.133.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A31C222288;
        Wed, 16 Jun 2021 17:55:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1623858917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cb27ko3Q1yZ9bGSQiewzUMLPTntEDoVo8AEqnhcMysI=;
        b=jdeMuoFoTFKAg0gtE3gOUUJgpMrtNHKtbVmuwyekU+UJbli81EBpotWNp60BOJ93s18p8t
        FjxaK3ujTsgesBeSPBUm2Udo9Lw7DmVIgnTKTTCyO0q44z/u0zAdkPZPRfjN6pCcTkuK9h
        TQGZmEhnElRaBChGtGbotwkoY7Z/QNk=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Michael Walle <michael@walle.cc>
Subject: [PATCH 3/3] ARM: dts: ebaz4205: enable NAND support
Date:   Wed, 16 Jun 2021 17:54:37 +0200
Message-Id: <20210616155437.27378-4-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210616155437.27378-1-michael@walle.cc>
References: <20210616155437.27378-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The board features a 128MiB NAND chip and recently linux gained support
for the NAND controller on the Zynq SoC. Thus add the corresponding
devicetree nodes.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm/boot/dts/zynq-ebaz4205.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-ebaz4205.dts b/arch/arm/boot/dts/zynq-ebaz4205.dts
index b0b836aedd76..53fa6dbfd8fd 100644
--- a/arch/arm/boot/dts/zynq-ebaz4205.dts
+++ b/arch/arm/boot/dts/zynq-ebaz4205.dts
@@ -48,6 +48,14 @@
 	pinctrl-0 = <&pinctrl_gpio0_default>;
 };
 
+&nfc0 {
+	status = "okay";
+
+	nand@0 {
+		reg = <0>;
+	};
+};
+
 &pinctrl0 {
 	pinctrl_gpio0_default: gpio0-default {
 		mux {
@@ -118,6 +126,10 @@
 	};
 };
 
+&smcc {
+	status = "okay";
+};
+
 &sdhci0 {
 	status = "okay";
 	disable-wp;
-- 
2.20.1

