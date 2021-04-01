Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53413521BD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhDAVhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbhDAVhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:37:04 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94991C06178A;
        Thu,  1 Apr 2021 14:37:02 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x21so3547086eds.4;
        Thu, 01 Apr 2021 14:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+gY/T/hsynUQpVciph/AvsX8Mdk/HLeWGZvwma0uW5s=;
        b=AhUKu0pmsunzA78Qt4W/brku7n7SJaPMtwMa4YYwIa5t8IHj8dgwYHxoVwePylGeih
         m/5uMNsNqlvbnQXk4/ASCNS38oD3USZ2ZTjdofhInx6v0rH/ULhfg0ZFcud3YHj09WkU
         ace8WXTAFLFkbgERZw9aO2jPBdhpZrYg9YH9GfRuA7JyQ+R2mnjUN3yU4qPpEHDoLYz4
         ExIeYMs3KJ9qJbUY6s6zA4r2xrj1x7pGd+hbKZRkCrjV2gyaqi+N/HGbKPbRrl1PpzYS
         gagymYUE/WYo6S/mDMSf1NcFzUwl5IR48B94a9eA77seoKeyJV8IbrosnYFOzqveRXm9
         wi4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+gY/T/hsynUQpVciph/AvsX8Mdk/HLeWGZvwma0uW5s=;
        b=YJ33KC0a6g90l/G14u8pVAX0WevVq5FMomx6fpdcIUP6hbG6cjduRvOE/LKWOtIXLY
         2M7QUIrd7vPwtuXy8AFFJ2fJJRwBrFNoGMPhfSr9mVmfR0g+u3rrhq8FQ1tJa02BWLLg
         yyrBzvqjJ9HNRrWeVc96X2w0NGrqn5U1TK8xwMHvMJLgbsjIoG/UKlX4x5/B4tPriURS
         pUYaZQqLfwPkTMSfpxwEwo6e7g6RufHMqvSdCkkczlg7xMMsJXlWCYkHXEeAP3MKQdRm
         sEi8EjzMtOGT/QhyZDxLQIzu8nzyRMgdOQ+MdXKJolinf16bgDa5hxgHXVaXnH025pre
         iB2Q==
X-Gm-Message-State: AOAM531w2DDAM5kTnfwxvXtUUHYy1JFxdgbHXhh4/dFqtEEwcdhG5zCa
        22L5ATAASFEO8JabVJlckl0=
X-Google-Smtp-Source: ABdhPJxSFwDDqAg4YlAUoBIucg5N9sMbXaak/lHX+VbYCr1rlnr9ooQx9zIN8T+kUb9kD1TSGO10gA==
X-Received: by 2002:aa7:c1d5:: with SMTP id d21mr11821310edp.167.1617313021276;
        Thu, 01 Apr 2021 14:37:01 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f9sm4237006edq.43.2021.04.01.14.37.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Apr 2021 14:37:01 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v6 2/4] arm64: dts: rockchip: optimize clks for rk3399 dwc3
Date:   Thu,  1 Apr 2021 23:36:50 +0200
Message-Id: <20210401213652.14676-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210401213652.14676-1-jbx6244@gmail.com>
References: <20210401213652.14676-1-jbx6244@gmail.com>
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
index e93a5f320..186a7c483 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -370,11 +370,9 @@
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
@@ -406,11 +404,9 @@
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

