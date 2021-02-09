Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA8E315A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbhBJAGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbhBIUib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:38:31 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6398C0611C1;
        Tue,  9 Feb 2021 11:24:01 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id jj19so33687967ejc.4;
        Tue, 09 Feb 2021 11:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r7BU1Ua7cwHe6jzoj7pIEXXpfnh5K4Y+YXR073vkvQE=;
        b=bh1IT2E376Yq6oXbtlLRVU+ZZgwlQGngdXEgtoCLNApGVLxKZgNcwTXuBftb9haijP
         IIjApj2MGOwBkU4/qoDv8H5kROC7Ft9rXktG0pwxcodKCht0kPvXTv/S5Sw/XF2cBeGd
         qAwGBS1P4pNyT8b2GVyW1VbiAFE2pbYimxz6Wh3twMtY5kDU0JRy1UKKWpaK6ujwF9SI
         qp3oeiRdTb0QMw0J4grCoBzbrLvAzZhdNi++4bjwbOkdPCyOyiYcuj5p8D4S+Lwffwzd
         zTXauPyAD+rCiPkeMGS8u2Z9aqlADrMziri6dNWDPabmtIt8ewRfL1HgSNzN38rADgBh
         he3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r7BU1Ua7cwHe6jzoj7pIEXXpfnh5K4Y+YXR073vkvQE=;
        b=g6kfxvLv+JkZ4DVu99B/nhi+DAvpqmQTrAlxgHE/mbHVHN89lM2RkxXi6X0Wi19P0y
         lZBOPEv8Tenae+eRelrsBXyRXdqqNoaouddaEqg4OXKmkTy1OXqW9pXo8qJQ6TkQs/fm
         IPvZIjY7CqISYvCs6qX4YXgbCqZTCIhyDdCdpKNGrx5zp7pAw5f+9OD+zq2+C2bnKE2x
         nJugeuhMdFP6v5cAAVh/uWWFSMLCyAus55RuDWzux4ROWZdsnT9DlWWEqJRwXoRtpMIs
         /aDOvB9vIDTz9R9a1+mueSTG1YouqUsB3bA6j5MekMZ6U/EUmq08DCz7IzZqEAU3iqlA
         cXKQ==
X-Gm-Message-State: AOAM530KC3v7rYkq7xYQQ8yAHAevWYTFdY+GDK7u5060b+kOuZ6ZuU1M
        E5k5NSJ5IC9GVtHfzIjM820=
X-Google-Smtp-Source: ABdhPJxKg0jN0s/0ilpBmiIkOppmd8gfTSX0HME5CQ924LQSHlmH/a9j412UFHOcO2XDV1B8AX7bGw==
X-Received: by 2002:a17:906:7b8d:: with SMTP id s13mr23864808ejo.479.1612898640598;
        Tue, 09 Feb 2021 11:24:00 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w3sm11075779eja.52.2021.02.09.11.23.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 11:24:00 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/8] arm64: dts: rockchip: optimize clks for rk3399 dwc3
Date:   Tue,  9 Feb 2021 20:23:45 +0100
Message-Id: <20210209192350.7130-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210209192350.7130-1-jbx6244@gmail.com>
References: <20210209192350.7130-1-jbx6244@gmail.com>
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

