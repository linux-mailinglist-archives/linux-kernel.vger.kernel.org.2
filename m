Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5883C3A1340
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbhFILsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239440AbhFILsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:48:21 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7FBC0613A2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 04:46:10 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id s70-20020a1ca9490000b02901a589651424so3074948wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=faDJwJkZnio3K1+D2/qEPWG8piye6Bb4xmyIkwVtbsM=;
        b=UmrttrlpGT6MTSmxtyJNOBUbmgFtWxEkrhN37QpZ+rjaocPopM9jfvdyufpxSLlm3G
         DdiTLtUDRpfqttGSfpsIllmhbJ3yPScaZZRUaRyJBZnNXj6wCa8gAabrGfeTZI1gYv8B
         iWLYVRax67K6VijlPRVRzhtdTgkuxDM8hXOCH+VVNa3OjM6deZP0eUuAGBbjkJ8vRiuL
         zu+VMO8ydFC+lQDEtpVBfrbRwMRXOe6wuzYmvRUBNhn6EDgRRTgpL1qFdSVUAnXjwYtC
         ZHZzvTOJNmF8AwrInbW5Kro32m3fh9DIeaXdNYkIyeLLcWbLrBPSgWUdKK3oT7IBb2N4
         AdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=faDJwJkZnio3K1+D2/qEPWG8piye6Bb4xmyIkwVtbsM=;
        b=kXRArugJhq3u+xa7gdi8ed4UNzGUkDxK5ocErIWoxl1L94RVWxJpAKsrg3QAqyngyD
         1jZcwUpxfDGVe0ICgU6yrGxN2GTIKag/9nJRnIDL5e7LztOnccZyDvxpXFv7Qx1gVcr1
         hfNSq0LmP3YwLFnlvw4Bwgz6xbi9+jEFvzoUo1mQaylx5BsyfDH1rl6yJr06rO/CeLCm
         sI15+YSdBEWW57aiuYddoXYSrTl6HPB9kSfG9+VnOiwT/JiQTPFZare8dmKlvmyU/KVG
         J/BtI3pL7YH4QwX0/axhkf4CNoFtcc31E9FZxoVPkSNqA2jijRd8qlAIkM7sXiF4iDMF
         rIzg==
X-Gm-Message-State: AOAM532G9iEBZidzloA0h73eJQEipE4eeFK37RZgOE2bWoSPHFA+GiHI
        m9pfN3C3wq6AqG6z1Gjx0Rc9UqYvqPlAREXg
X-Google-Smtp-Source: ABdhPJwyvaRJV27WEeZvyOtiMcZITiOPSb+nkAyiLSj8gjv4MqWxJI0U3RW05ioxpVts1hS0s+ciiw==
X-Received: by 2002:a05:600c:4f8f:: with SMTP id n15mr11461111wmq.116.1623239169240;
        Wed, 09 Jun 2021 04:46:09 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id x18sm2153689wrw.19.2021.06.09.04.46.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jun 2021 04:46:08 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 28/31] arm64: zynqmp: Sync psgtr node location with zcu104-revA
Date:   Wed,  9 Jun 2021 13:45:04 +0200
Message-Id: <cd168b19c13fd46874e017a6735a744111f3b47a.1623239033.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623239033.git.michal.simek@xilinx.com>
References: <cover.1623239033.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zcu104-revA has node below pinctrl which is not the same on revC. Sync
location for easier comparison.
Also zc1751-dc1 is not using this position.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 .../boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    | 14 +++++++-------
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts  | 14 +++++++-------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
index 9f176307b62a..d78439e891b9 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
@@ -58,13 +58,6 @@ clock_si5338_3: clk150 {
 	};
 };
 
-&psgtr {
-	status = "okay";
-	/* dp, usb3, sata */
-	clocks = <&clock_si5338_0>, <&clock_si5338_2>, <&clock_si5338_3>;
-	clock-names = "ref1", "ref2", "ref3";
-};
-
 &fpd_dma_chan1 {
 	status = "okay";
 };
@@ -340,6 +333,13 @@ conf {
 	};
 };
 
+&psgtr {
+	status = "okay";
+	/* dp, usb3, sata */
+	clocks = <&clock_si5338_0>, <&clock_si5338_2>, <&clock_si5338_3>;
+	clock-names = "ref1", "ref2", "ref3";
+};
+
 &qspi {
 	status = "okay";
 	flash@0 {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
index fb8d76b5c27f..c21d9612ce04 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
@@ -429,6 +429,13 @@ conf-tx {
 	};
 };
 
+&psgtr {
+	status = "okay";
+	/* nc, sata, usb3, dp */
+	clocks = <&clock_8t49n287_5>, <&clock_8t49n287_2>, <&clock_8t49n287_3>;
+	clock-names = "ref1", "ref2", "ref3";
+};
+
 &qspi {
 	status = "okay";
 	flash@0 {
@@ -446,13 +453,6 @@ &rtc {
 	status = "okay";
 };
 
-&psgtr {
-	status = "okay";
-	/* nc, sata, usb3, dp */
-	clocks = <&clock_8t49n287_5>, <&clock_8t49n287_2>, <&clock_8t49n287_3>;
-	clock-names = "ref1", "ref2", "ref3";
-};
-
 &sata {
 	status = "okay";
 	/* SATA OOB timing settings */
-- 
2.31.1

