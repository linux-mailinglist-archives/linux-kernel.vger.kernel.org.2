Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9003A6A1C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhFNP2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbhFNP2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:28:13 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44902C0617AF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:10 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id my49so17365082ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2qGghIKaYFqU7hEUb09j1WP4s4KmFYblcf/Dch+fhjY=;
        b=hQrQo11y6XVZ1fadqMpMa8A09h6njOKE7VFm6Jf4eGtPDqKNk1i1BZBShMWkHC3WqG
         cULfd9GSgipt9ZZA5nEPFAcOigNke9fbGKHmdS71fCN1UKECZkj62LaMxWiqVl0R1EBd
         ACvwL+orEB8VHUTtqz1db1tTNTGZkJLBkxIBUOXQpu8gc9y1XW2TYmYCBUp1K/5ekTcg
         9kollqMuu/3hkxpRqd55m3BPUUqPvxaxqA6lyk6cj/YoqHQXer5cvIP/5fME7k2Uh9On
         XyrZraBIR4pNacKROd19IQYkjmEquwtthbiye6Q4SZyO0WPATsQKW6vxG0Rj3EULzHKR
         bd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2qGghIKaYFqU7hEUb09j1WP4s4KmFYblcf/Dch+fhjY=;
        b=tWfoYlzmCMiRtV5k7fek/Pmq8r+RzOG3IRSgkuG4QM+iL7A4x8Vk35hfvFAVuD9/3V
         iRugShXtXvRZjUrb8y7vg6qv7aYtrnhOLk2rNd7oILFDT70HMQt2qVQ4H5FNnbyi9G6V
         WwmY9EDkK5jN7dO0uGyeoJ3m2do3AGLIHi76MBybvw/MaFHEv8b1eoq52xA2lsrzrsoj
         uZ2xDQwOTflbo5FrjE6qkl4RlVDKhA80b/8S7VJTOFRgaGT45vQLVZWh33L5J0LGAmlb
         JtjUELE9141OsdX2S7DZnrH5e2ThV8YPQCP1b0oip7IPyoV9YYFSCreNIPw0noNu2Vs2
         itiA==
X-Gm-Message-State: AOAM532niDrvRVnT9fiI4e3RfpJyXzhLVYOdBtDK4j/A/cCVAt2zQwAr
        kIY7MvJ7xbjuKUUExxTZasp+w8ivtIMpB1k3
X-Google-Smtp-Source: ABdhPJz2Va0ejvXApN82il5QYicrZYTJS9vZjMJByjRF3my485AsAcgKWivuLHXIHKImD0SPdr4iiw==
X-Received: by 2002:a17:906:e01:: with SMTP id l1mr15972952eji.280.1623684368733;
        Mon, 14 Jun 2021 08:26:08 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id de19sm9356119edb.70.2021.06.14.08.26.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jun 2021 08:26:08 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 17/33] arm64: zynqmp: Add nvmem alises for eeproms
Date:   Mon, 14 Jun 2021 17:25:25 +0200
Message-Id: <9b860b47ec3ca64340b4d29317e92b667236d7d1.1623684253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623684253.git.michal.simek@xilinx.com>
References: <cover.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use nvmem alias to point to eeprom memory which contains information about
board. The change is done based on discussion in the link below.

Link: https://lore.kernel.org/r/CAL_JsqLMDqpkyg-Q7mUfw-XH67-v068Q6e9wTq2UOoN=0-_coQ@mail.gmail.com
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 1 +
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts | 3 ++-
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts | 1 +
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts | 1 +
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 1 +
 5 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 1a45e4946dd4..339a12b255c1 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -25,6 +25,7 @@ aliases {
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		mmc0 = &sdhci1;
+		nvmem0 = &eeprom;
 		rtc0 = &rtc;
 		serial0 = &uart0;
 		serial1 = &uart1;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index d7ecfcadd08b..4c328569c3ac 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -23,6 +23,7 @@ aliases {
 		ethernet0 = &gem3;
 		i2c0 = &i2c1;
 		mmc0 = &sdhci1;
+		nvmem0 = &eeprom;
 		rtc0 = &rtc;
 		serial0 = &uart0;
 		serial1 = &uart1;
@@ -146,7 +147,7 @@ i2c@0 {
 			 * 512B - 768B address 0x56
 			 * 768B - 1024B address 0x57
 			 */
-			eeprom@54 { /* u23 */
+			eeprom: eeprom@54 { /* u23 */
 				compatible = "atmel,24c08";
 				reg = <0x54>;
 				#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
index 403a8ea6a36f..99d172867f6a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
@@ -23,6 +23,7 @@ aliases {
 		ethernet0 = &gem3;
 		i2c0 = &i2c1;
 		mmc0 = &sdhci1;
+		nvmem0 = &eeprom;
 		rtc0 = &rtc;
 		serial0 = &uart0;
 		serial1 = &uart1;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index 186d2e00d4a0..dbb8bfbb5c7f 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -25,6 +25,7 @@ aliases {
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		mmc0 = &sdhci1;
+		nvmem0 = &eeprom;
 		rtc0 = &rtc;
 		serial0 = &uart0;
 		serial1 = &uart1;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index e646246a3b14..85e9d0e2f9bd 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -25,6 +25,7 @@ aliases {
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		mmc0 = &sdhci1;
+		nvmem0 = &eeprom;
 		rtc0 = &rtc;
 		serial0 = &uart0;
 		serial1 = &dcc;
-- 
2.32.0

