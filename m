Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E67362F93
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 13:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbhDQLbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 07:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbhDQLae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 07:30:34 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4670BC061574;
        Sat, 17 Apr 2021 04:30:08 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id i3so9562644edt.1;
        Sat, 17 Apr 2021 04:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0M5FwzbPAy5c2Cwb5UeKel5vnxZKoOrIQ9Hgfx4Nf84=;
        b=EKLlaDh5MVoPNX1/OV0FlVlj2mQ97da/v/YAPdKd/yEgla0FcWnzcnPlSJSuux18MC
         toefwWFr5qMSov8UL96Gh4K0lD5b1JU0HduZWEeSbc9SWwyy0Qev4XRuFhYUxoiHLlEv
         JBFJtGyg9OuOZy3V8zKE5jKa+Pp8ijDp0+gwJCSdKq+rOyzya+aQkykB6RhdlmJUe8YD
         kxIi5GhJ1wuk2ojgWPcwTrjgSRj6xCQWpSb7EQXk7C050P74/lgQBDHYhSF/kHbfD+Gt
         FKrQ8d09SUuKsroc59++W3jtKd62yU5Do3LGsKX5RaaxyU6u+wqw29/LAg09tRujTvxu
         x5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0M5FwzbPAy5c2Cwb5UeKel5vnxZKoOrIQ9Hgfx4Nf84=;
        b=dYjzYfGTuwyAOhR8vZWNGiYeoKZmF2M1oip+Q6OxrWXFOhw00em4YSa7umPrIL6XLR
         gCvst6JKjJSbbyMk3fdYLUmig7rsd/plvZxi1zxJv2dyi7xxmiBznhWIWfdlw2fEez8N
         m3tGu0yn/WKK2x8aFlRUMg60Lblxcegu+Fzpi6bqCQhSPwXNLuMs/l+wISlQqw6y/toA
         vbgznJdEIUeALpeR6rUIPRKcqrcwQOukJVcJwuYtcQf8A0q+shWJm7WprvRAO3SQyTCl
         TiO4uOGJa8DhXY2Bw6Solp20ApC6xI649kUwTDjwYgWmGzNqGOzvnX4qLvA78W0HMEub
         j/Eg==
X-Gm-Message-State: AOAM532DaDRcVeVM0fBXwbJVRhTnljTOKM+BdnY24EFdLted6tCR0ox5
        +ctUbVnFrhu0ydkFBr2spxI=
X-Google-Smtp-Source: ABdhPJwgkocHSyEp+7z9O+ghmI4Bwm6UjDlyityrYg56ZfRlxyZ2zp3NqtqITY25tjE22P1XO2evpA==
X-Received: by 2002:a05:6402:104c:: with SMTP id e12mr14716814edu.108.1618659007058;
        Sat, 17 Apr 2021 04:30:07 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f20sm3022875ejw.36.2021.04.17.04.30.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Apr 2021 04:30:06 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 06/15] arm64: dts: rockchip: Fix power-controller node names for rk3328
Date:   Sat, 17 Apr 2021 13:29:43 +0200
Message-Id: <20210417112952.8516-7-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210417112952.8516-1-jbx6244@gmail.com>
References: <20210417112952.8516-1-jbx6244@gmail.com>
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

