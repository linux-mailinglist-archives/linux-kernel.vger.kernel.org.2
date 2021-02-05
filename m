Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29BA3117CF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhBFAbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbhBELlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:41:14 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B97C061786;
        Fri,  5 Feb 2021 03:40:32 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id s5so8453922edw.8;
        Fri, 05 Feb 2021 03:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r7BU1Ua7cwHe6jzoj7pIEXXpfnh5K4Y+YXR073vkvQE=;
        b=Z6bbrwsNpO/ZeSnGLip4AxmNeJckL2g7oY6Q7WV7MVkO1Uaim4ltCevLXlLS6xk2ip
         jOZ07krO/4RG/E2JmyqrpyXCV43RwQ6TnXbvzN56hNdLiz9/S8MwdKNmYmuvRCc4CswZ
         A33/u7/I8zwnUfXfl5sNVg6ewx6yhIshj/lUXFnB3xrUV8QTaSS+U/3qh/1sGdJn/s49
         3MfmM9KDyXk5NjXr/1ePbmpG4ONq2AaK2AuGrZfuyZ0K0KRQ5mhkFVi2JH1tBsIKeT4B
         SJc7HVf8f0MswsmyRffLW35/hZjnPwT7dGPFWfEZ1YcoEZtk7Kxb8iGKdJCOeLHa8MCC
         HjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r7BU1Ua7cwHe6jzoj7pIEXXpfnh5K4Y+YXR073vkvQE=;
        b=PlpyIpi2FFqPnC76XvB02NJ9GQcqKttQt0i2IgLTI4z/mTR0mGWbydBm3VSEeUmbKP
         JQS8RTKtSQ36KVvuZvglNwbdRyKhalkZannkb30+kEA3jHKiH0QdZfa/oCjHIQud338r
         eoKvvkbNudLMiOgdPKW/6B16OxnyqZx72fYC+0MvdWmUPaWh0l1gO9y+vE0QJUEYja7A
         J8Xk1+a5UwRsNFuIV7lEnWHm1TWsfafcNF5W6DdbMNdBjoWMa2wEaiuHkevo8C2U/xNf
         sFunt0siq37RbuqLKLAEOTo3Lo4JPSA/30bfMwvha9eRMWBZXNQ64IVk+lfR4TnLw6o5
         xhqA==
X-Gm-Message-State: AOAM532pbfdDvlib6RVfIRZCt8ROfHvZA6Td8Uwy5kHX7mkqXS/g4Qyw
        ZjSIWubXC/jPngroXo5seXq2xISbtXE=
X-Google-Smtp-Source: ABdhPJzO6PxNSVIAJrBNk3kwDhZZF+RCVwP3cs/j3ffeO9vWGS4tjhnCj7QpNnipfoT/uzRpH7kJBg==
X-Received: by 2002:a05:6402:5207:: with SMTP id s7mr2974663edd.311.1612525231783;
        Fri, 05 Feb 2021 03:40:31 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o4sm3883476edw.78.2021.02.05.03.40.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2021 03:40:31 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/8] arm64: dts: rockchip: optimize clks for rk3399 dwc3
Date:   Fri,  5 Feb 2021 12:40:05 +0100
Message-Id: <20210205114011.10381-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210205114011.10381-1-jbx6244@gmail.com>
References: <20210205114011.10381-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wu Liang feng <wulf@rock-chips.com>

Remove unnecessary clocks, refer to rk3399 TRM, aclk_usb3 is the
parent of aclk_usb3otg0/1 and aclk_usb3_grf, and we will enable
aclk_usb3otg0/1 and aclk_usb3_grf, so don't need to enable aclk_usb3
again. In addition, the aclk_usb3_rksoc_axi_perf clk is used for usb3
performance monitor module which we don't use now, so don't need to
enable it.

Signed-off-by: Wu Liang feng <wulf@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 04f7cc5c3..b125cac89 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -399,11 +399,9 @@
 		#size-cells = <2>;
 		ranges;
 		clocks = <&cru SCLK_USB3OTG0_REF>, <&cru SCLK_USB3OTG0_SUSPEND>,
-			 <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_RKSOC_AXI_PERF>,
-			 <&cru ACLK_USB3>, <&cru ACLK_USB3_GRF>;
+			 <&cru ACLK_USB3OTG0>, <&cru ACLK_USB3_GRF>;
 		clock-names = "ref_clk", "suspend_clk",
-			      "bus_clk", "aclk_usb3_rksoc_axi_perf",
-			      "aclk_usb3", "grf_clk";
+			      "bus_clk", "grf_clk";
 		resets = <&cru SRST_A_USB3_OTG0>;
 		reset-names = "usb3-otg";
 		status = "disabled";
@@ -435,11 +433,9 @@
 		#size-cells = <2>;
 		ranges;
 		clocks = <&cru SCLK_USB3OTG1_REF>, <&cru SCLK_USB3OTG1_SUSPEND>,
-			 <&cru ACLK_USB3OTG1>, <&cru ACLK_USB3_RKSOC_AXI_PERF>,
-			 <&cru ACLK_USB3>, <&cru ACLK_USB3_GRF>;
+			 <&cru ACLK_USB3OTG1>, <&cru ACLK_USB3_GRF>;
 		clock-names = "ref_clk", "suspend_clk",
-			      "bus_clk", "aclk_usb3_rksoc_axi_perf",
-			      "aclk_usb3", "grf_clk";
+			      "bus_clk", "grf_clk";
 		resets = <&cru SRST_A_USB3_OTG1>;
 		reset-names = "usb3-otg";
 		status = "disabled";
-- 
2.11.0

