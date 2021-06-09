Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371923A1320
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbhFILrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234472AbhFILrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:47:33 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEAEC061760
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 04:45:38 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id o3so6752797wri.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ztWISkfbHLRcrutYYOCwKbEn/sj5GOKylRbehxkcT8=;
        b=awyLTVcmnOLAAf+R6/GMoRbVqRSlP/YS6JgB+6D1F1gvM9MMSc4cD/WdXulgTM7//1
         G/e75TR9l4inBFCFcSrKeuOl4iETp2u4elTB4L7k8+7c0+W80zbwbhPDzwbeHpUrSYQ+
         6D8AZE45lTf8GHZTTIubBa5dArAh+hCyqhan3GPvEcwzZ2LiObWDz21m5CCE2q3YKPgL
         lky/z26B/fLzY2TPB1dOpXhoziQKAe7sxx0OKaODFJ8/z5M+XUv3CH+AQJotEFiVBByx
         mOTHqYHeY31T1pTwsNiBKUUe2Wxr7j+cNNd5f4trFAEbi00TVhjy8hywvVWA+x9RzFQQ
         HhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=+ztWISkfbHLRcrutYYOCwKbEn/sj5GOKylRbehxkcT8=;
        b=RInjs7wkPq+BgbnaBSd9djkfyjyUibBtCC3xxq5zV9R+1TdMVlB0Zpj3WwPdEOqR+E
         CudNUp4NgJrLsL0BKx01rKLvGzBlUoAvkeRUqBTuzHAKNU6dPUZRKDdz7a1hfX6M3l5G
         DIIskSROdBe9mf/LdKXvRnLYN7xVJZMOkHliXfQjL6Y1VGgscue7YZttr4WQqdW8EqEo
         biBJqan8AArX3An/Vq0MGZWiVs1iM9SbiHYPtuabuG6B/Y6dRMQ0HCz135g0bWkoRh/N
         6hgz3Db9whLqXMlB+aCDplRUq3eAGZM1otO9OpJeG/DJ8LKAYMn2kLpu+/zqdau5o7xI
         lW7g==
X-Gm-Message-State: AOAM532Osnf12lZM+Q7RjK2LXtmKqtKlHHvTisPL7pYTsd9f8fKTmdX4
        nGUdBCuhVdZRXGEwk0xYbZCELz8KqNCdRHOX
X-Google-Smtp-Source: ABdhPJzSC6EPdrOgWUgBxVgTNII5hR2mUzGO+0Gi9Q+F6XFTR4y9ZdgY1EbvuMzXNVdFwqj4XzD6/A==
X-Received: by 2002:adf:9c93:: with SMTP id d19mr27643593wre.17.1623239136750;
        Wed, 09 Jun 2021 04:45:36 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id u20sm15670188wmq.24.2021.06.09.04.45.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jun 2021 04:45:36 -0700 (PDT)
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
Subject: [PATCH 09/31] arm64: zynqmp: Add phy description for usb3.0
Date:   Wed,  9 Jun 2021 13:44:45 +0200
Message-Id: <cd856e5f87bc967373691d04e79de3d0022ef424.1623239033.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623239033.git.michal.simek@xilinx.com>
References: <cover.1623239033.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb3.0 requires serdes setting that's why also wire it up.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 6 ++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 3 +++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts | 3 +++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts | 3 +++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts | 3 +++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 3 +++
 6 files changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index 4622e173d262..80415e202814 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -538,6 +538,9 @@ &usb0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb0_default>;
 	dr_mode = "peripheral";
+	phy-names = "usb3-phy";
+	phys = <&psgtr 2 PHY_TYPE_USB3 0 0>;
+	maximum-speed = "super-speed";
 };
 
 /* ULPI SMSC USB3320 */
@@ -546,6 +549,9 @@ &usb1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb1_default>;
 	dr_mode = "host";
+	phy-names = "usb3-phy";
+	phys = <&psgtr 3 PHY_TYPE_USB3 1 0>;
+	maximum-speed = "super-speed";
 };
 
 &watchdog0 {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index b37aee2d85b9..719a9e5e1b01 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -979,6 +979,9 @@ &usb0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb0_default>;
 	dr_mode = "host";
+	phy-names = "usb3-phy";
+	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
+	maximum-speed = "super-speed";
 };
 
 &watchdog0 {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index 7e1b024f71e1..d7ecfcadd08b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -469,6 +469,9 @@ &usb0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb0_default>;
 	dr_mode = "host";
+	phy-names = "usb3-phy";
+	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
+	maximum-speed = "super-speed";
 };
 
 &watchdog0 {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
index b140fd2c86aa..403a8ea6a36f 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
@@ -491,6 +491,9 @@ &usb0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb0_default>;
 	dr_mode = "host";
+	phy-names = "usb3-phy";
+	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
+	maximum-speed = "super-speed";
 };
 
 &watchdog0 {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index 4919cdec835b..186d2e00d4a0 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -985,6 +985,9 @@ &usb0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb0_default>;
 	dr_mode = "host";
+	phy-names = "usb3-phy";
+	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
+	maximum-speed = "super-speed";
 };
 
 &watchdog0 {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index b0c2eae1b4b3..0bf29ff9c714 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -811,6 +811,9 @@ &usb0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb0_default>;
 	dr_mode = "host";
+	phy-names = "usb3-phy";
+	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
+	maximum-speed = "super-speed";
 };
 
 &zynqmp_dpdma {
-- 
2.31.1

