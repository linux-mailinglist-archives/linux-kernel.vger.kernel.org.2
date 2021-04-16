Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98A4361B12
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 10:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbhDPIFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239068AbhDPIFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:05:43 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7482DC061574;
        Fri, 16 Apr 2021 01:05:18 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id v6so39530261ejo.6;
        Fri, 16 Apr 2021 01:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0M5FwzbPAy5c2Cwb5UeKel5vnxZKoOrIQ9Hgfx4Nf84=;
        b=R/7D0OTvAun7wf19vDStVTxeNs64hQEZe0p1/bmd+HWtdihsH5lN+N4o/Qg9FM7pWG
         d1rUU3pWrv1nIW44tJj6hiWfv9V2gUzkE0KWrGr7jQ5YWtPz6mvStNZc9Jxt/y012m8B
         VHtIRC3u6JFIKklG7Zx5RnYlMivFJO6mjkkIerEA/GRdVv5XcwHghYyQmbI26uTvS3W1
         k1H70ivIoDGe0EIYVjIMwLlYA3H4szafADGEvXuPKg49SBptMbK/tuWFBkjma5SSWt9F
         nWSTGiW1ZF7QhJwJf6NMmhAHn6MQkZ3/1DsK7aNP7nKqeDE7H0GS42gfK9kXGGC+b0Lf
         klhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0M5FwzbPAy5c2Cwb5UeKel5vnxZKoOrIQ9Hgfx4Nf84=;
        b=Aq3etkqxlz0C9qIyL4oL+/wn+mDA/7Bus7T6nmtX7N1JER12wuk6QV14JzcAJpl0mt
         e2ElQbhX59fFBEO1akw5FZ4HQ0zhyXlBIUrw5FZ1hhi+6FeAV2HJDZAZeAxH80d5n1Qk
         8i/IQ7H6SEYlVZOYpFwUB7FDoRa1ee8Byfa2roGWPlmQyjLETJ5xg1CczpLT400M32Td
         a+1f7BGdFYAkKBhpInw1Ou3fXYr9sLgHGKpeOF6GyuNoFDEA83BHNzkNknYknfsRrUY+
         1rjEA9nvenIPhecdMJag0CwoyKc4cXt+cIN8CoA7LFz7zDydrdFcviLe9gMzovYgMSHd
         x7GA==
X-Gm-Message-State: AOAM530deH8CmBcYvvWoP30LV/oMW2ZiwLMK8JMw0E25T4gDOJwFhiHy
        quQmFARg1q7JPYkwPn5bZige045B5kbfKecA
X-Google-Smtp-Source: ABdhPJxp2vnoUzoJvo8dsaUcsrFzFzMLVvP8vaE4jSCfQNlNfBnTwZ200tUOsTyXGbJjlntKQh9j2g==
X-Received: by 2002:a17:907:c0b:: with SMTP id ga11mr7033746ejc.545.1618560317292;
        Fri, 16 Apr 2021 01:05:17 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q16sm4672303edv.61.2021.04.16.01.05.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Apr 2021 01:05:16 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 06/15] arm64: dts: rockchip: Fix power-controller node names for rk3328
Date:   Fri, 16 Apr 2021 10:03:33 +0200
Message-Id: <20210416080342.18614-7-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210416080342.18614-1-jbx6244@gmail.com>
References: <20210416080342.18614-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elaine Zhang <zhangqing@rock-chips.com>

Use more generic names (as recommended in the device tree specification
or the binding documentation)

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 5bab61784..35df57535 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -300,13 +300,13 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			pd_hevc@RK3328_PD_HEVC {
+			power-domain@RK3328_PD_HEVC {
 				reg = <RK3328_PD_HEVC>;
 			};
-			pd_video@RK3328_PD_VIDEO {
+			power-domain@RK3328_PD_VIDEO {
 				reg = <RK3328_PD_VIDEO>;
 			};
-			pd_vpu@RK3328_PD_VPU {
+			power-domain@RK3328_PD_VPU {
 				reg = <RK3328_PD_VPU>;
 				clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
 			};
-- 
2.11.0

