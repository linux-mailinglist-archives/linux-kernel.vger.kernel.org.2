Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7995331443
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhCHRKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:10:43 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33258 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhCHRKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:10:04 -0500
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lJJON-0003Pi-LO
        for linux-kernel@vger.kernel.org; Mon, 08 Mar 2021 17:10:03 +0000
Received: by mail-wr1-f69.google.com with SMTP id x9so5055921wro.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 09:10:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ncNIlFsguYiY4EF+KxnIV2xUChGRcZpDkfhtUUnJSss=;
        b=UPoytEwZdB3MomcVLeAbeVt9f+PrGXMzMZPexhcS02lsUgIfoS3yZxD+ssihl7rWeW
         dPEnYbsXgq83TrXcph9hEFPU9TXlXhwf4txSDgXVyklI6LSbUnkGvJWLHv6wpPqRNe01
         tAKZOyQIQ7ET6e8rmPPeMsR7njHT+8l93dFgT8KC41GvU5NUUeCtXsrYzngqZRLJMPwI
         lbQhK0lr0hgim8c3yPa+EI/m3kp6O66CweLvnJ0D+gy+KjGSXIMnytzPjNg64SPRQa0C
         /3qR/prB00J1Ay7HfJ0ZxV9kLyWlT+wbe6gxceb0l7c8Qf2oP0X6tMF0eDIPfmgmC7zx
         Xvpw==
X-Gm-Message-State: AOAM53022/Zej6M9AGVYpLsjmLPWSK5y4d9sO95V+EmJfjKuzBrgUOWn
        miLvtrjIMwIVWJXjAXZPCZzKfbrgBu+TZFNheKZaqG3GqADIebfPk/xHYXCm3jYo+jj4iFc7JBc
        mQD0kATYa1PrwAABPM8YfFDyj9Qpjs882NqFIK9JczA==
X-Received: by 2002:a1c:6a05:: with SMTP id f5mr23064138wmc.75.1615223403143;
        Mon, 08 Mar 2021 09:10:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynHW0REjkwiR9tjpHrXCCFWLKx3SXjo9gDBvdZo+0uKZAhz3wSWTrLAfBYT39sHPr5aWe/nw==
X-Received: by 2002:a1c:6a05:: with SMTP id f5mr23064130wmc.75.1615223403027;
        Mon, 08 Mar 2021 09:10:03 -0800 (PST)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id c11sm19568762wrs.28.2021.03.08.09.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:10:02 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arm@kernel.org, soc@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND 2nd PATCH 08/10] arm64: dts: intel: socfpga_agilex: align node names with dtschema
Date:   Mon,  8 Mar 2021 18:09:43 +0100
Message-Id: <20210308170945.161468-9-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210308170945.161468-1-krzysztof.kozlowski@canonical.com>
References: <20210308170945.161468-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

Align the NAND, GIC and UART node names with dtschema to silence
dtbs_check warnings like:

    arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dt.yaml:
        intc@fffc1000: $nodename:0: 'intc@fffc1000' does not match '^interrupt-controller(@[0-9a-f,]+)*$'
    arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dt.yaml:
        serial0@ffc02000: $nodename:0: 'serial0@ffc02000' does not match '^serial(@[0-9a-f,]+)*$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index 3cba4c03d560..163f33b46e4f 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -78,7 +78,7 @@ psci {
 		method = "smc";
 	};
 
-	intc: intc@fffc1000 {
+	intc: interrupt-controller@fffc1000 {
 		compatible = "arm,gic-400", "arm,cortex-a15-gic";
 		#interrupt-cells = <3>;
 		interrupt-controller;
@@ -316,7 +316,7 @@ mmc: dwmmc0@ff808000 {
 			status = "disabled";
 		};
 
-		nand: nand@ffb90000 {
+		nand: nand-controller@ffb90000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "altr,socfpga-denali-nand";
@@ -479,7 +479,7 @@ timer3: timer3@ffd00100 {
 			clock-names = "timer";
 		};
 
-		uart0: serial0@ffc02000 {
+		uart0: serial@ffc02000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xffc02000 0x100>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
@@ -490,7 +490,7 @@ uart0: serial0@ffc02000 {
 			clocks = <&clkmgr AGILEX_L4_SP_CLK>;
 		};
 
-		uart1: serial1@ffc02100 {
+		uart1: serial@ffc02100 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xffc02100 0x100>;
 			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

