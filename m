Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55082311F7B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 19:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhBFSvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 13:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbhBFSvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 13:51:09 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCA3C061786;
        Sat,  6 Feb 2021 10:50:28 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id p20so18291183ejb.6;
        Sat, 06 Feb 2021 10:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r7BU1Ua7cwHe6jzoj7pIEXXpfnh5K4Y+YXR073vkvQE=;
        b=Pow5OVqmSB0fcoLVh8t/96ZlLlvcjcDIj/cfOUe31XBTpWOwy/8e8f0h8Gy4NE44aB
         5IlVy0Q5D6cuNPBIm6p3WFDha4KqoWRemq2MIAkJBbdHVIgX7LSusE9cPz6A6flxfUsi
         ofMy0MdMc/+ZbMvx1cbJkwbZPPBYNThQD4ELYAYReNp5X/EIEdbH0mwe5SReH/z6RPai
         MMduoV279WZJQQMzapmB/x186JRqpfs2Ej5k8DfLS1wPonrgfgByocHSXdoVBaxtQX5D
         MLWnbjAR6LzXe/STQW428Xg9yzWdJgzgoaaVkQu8IWNztY16Ghwj7AezWMvJJD3Y16l9
         V/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r7BU1Ua7cwHe6jzoj7pIEXXpfnh5K4Y+YXR073vkvQE=;
        b=RcSErZj3vK+JZMuRhg5Kr50wZLIdUGBObPwlvKm5w+Mn8vAuMg5K8+ZREUiR1uxnVd
         xN6M6djFyZXSZzhdP2VtR77lIAv0YFVc1qjfJwAsDusnwuNnWOfC7ez9abwOYN1EX1M9
         GclU1G2yqo7Y1HmTehhivmBHh7Di6Rpp9+1PHSirq/67tRVC3uu1900ujz30VqmJMB1g
         e4i9zvUtHUTK4azolOqCv/VZlljcpOk1HC8Qhtm6Igrk/gF4izeUvDsYza9o7gy8I+Yn
         KRVZyA6kdXAdsBfWAcRPFrVvaZlVdg0GGxFObQElyNDv7oLxJ5wlqgVqzC6w/rk3bIQQ
         jY5g==
X-Gm-Message-State: AOAM530AdCiKb5hD7P7Cglu0z/SKnZt8p0X1WV+MYvjXIg0/7lp9jKIx
        b3FC4gvfMB/db/toHPcH6eg=
X-Google-Smtp-Source: ABdhPJzLu2mmugL+rzB/9sYJ0QJEg/ICCAcVOclFB2ADHKG9bnSL4uodB3zf9KSSrT1Ar53emqgkvw==
X-Received: by 2002:a17:906:2bc2:: with SMTP id n2mr9618489ejg.381.1612637427667;
        Sat, 06 Feb 2021 10:50:27 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id cb21sm5890005edb.57.2021.02.06.10.50.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Feb 2021 10:50:27 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/8] arm64: dts: rockchip: optimize clks for rk3399 dwc3
Date:   Sat,  6 Feb 2021 19:50:12 +0100
Message-Id: <20210206185017.1817-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210206185017.1817-1-jbx6244@gmail.com>
References: <20210206185017.1817-1-jbx6244@gmail.com>
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

