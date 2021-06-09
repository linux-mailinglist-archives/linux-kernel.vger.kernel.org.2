Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F07C3A1360
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbhFILuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:50:15 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:37540 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239509AbhFILs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:48:58 -0400
Received: by mail-wr1-f41.google.com with SMTP id i94so20088593wri.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2oJBCb/IEp6HCT0Khc41E+ZKW3BEVh2wQ7Q+Btm9aLE=;
        b=u33UTezcqWw3EwAL8es1PrN9BNk7b9P6aXfTUXOzGWKzRU6LGDhufMDBOfMYaBaYT4
         j+iPZkh2PBwNtEMxwiJpskl5YbN7timv2lOCyKcRx77nrM176NuN5g+yB7ccIjUe71wo
         /ml5VXI12qXCAVDRpt3XDYylJsVS9SWUGGnBT9Zka4lUB2zTJ7cERD4MYes/g9WcBGLT
         YSuPRi1FN0kRIEAtMFSuMVB33yYz3IdtyNe30kSAuuzOGiiSFT63DL4msLO0oW9hPNN4
         UjltDjinK7zo/jy+pfcl1DTHlLUfEeuQt9BpWdPeWHuOJv0pOsbe8ukg1eibPAy8BLnf
         tx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2oJBCb/IEp6HCT0Khc41E+ZKW3BEVh2wQ7Q+Btm9aLE=;
        b=Ob1jg+5oV5qpgtB1TiHVqYB0EsSsH1TjNszNMcXUp6xjPa1nzAD1NLNiyqVP4XpWoa
         DQjNgviTEQzrpUwZ7t8JcjPScZNIqnjcR598uJlrFlqzio6GAMCE21H2M1Hf/wAFuk4O
         V1CGpnjRT/qPSF/zHRVI8mt6VfD8s2rmM349Ph5x28ZFV17AouSkzd4FLZg9rRBc2+jL
         qqGGS7ZopArOqSoWczbxBnmDCXiyOdOpM69bz8g75vNat/A1piK0l2V8bf5Gdc7jxXAN
         WN0EOEdztggzyvVLHQhLNeCIsKUHjJc/y+J71Mlb2Woh1L4zb8DI9Ly7mhy1nTtWBavS
         nZwA==
X-Gm-Message-State: AOAM530mNxyKBQU+FoRIgeQ+Tz/uwc1z+iqeDil7GQZn8gn1mvifPi7I
        RbghYTxzgvDFmdfXDoiGWUvGMxqnAUiuNKSD
X-Google-Smtp-Source: ABdhPJwu3dPsiYPGloJtXLHsOdDjrEjSlsgc0e2EjWGqoM/VtNdqkJ4OceOVsDvXUIFHi1wPvQEQHA==
X-Received: by 2002:a5d:6a41:: with SMTP id t1mr21296407wrw.113.1623239150445;
        Wed, 09 Jun 2021 04:45:50 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id l2sm23037103wrp.21.2021.06.09.04.45.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jun 2021 04:45:50 -0700 (PDT)
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
Subject: [PATCH 17/31] arm64: zynqmp: Add nvmem alises for eeproms
Date:   Wed,  9 Jun 2021 13:44:53 +0200
Message-Id: <9b860b47ec3ca64340b4d29317e92b667236d7d1.1623239033.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623239033.git.michal.simek@xilinx.com>
References: <cover.1623239033.git.michal.simek@xilinx.com>
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
2.31.1

