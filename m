Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1405D35FD29
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 23:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhDNVTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 17:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbhDNVTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 17:19:32 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D039FC061574;
        Wed, 14 Apr 2021 14:19:10 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n2so33541200ejy.7;
        Wed, 14 Apr 2021 14:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0M5FwzbPAy5c2Cwb5UeKel5vnxZKoOrIQ9Hgfx4Nf84=;
        b=XJqVnGGlPZX8CvYzl+WAUGvK24upEn2NOmomJFSU4ooCZYs6HJOr4/t1XziPzp+u4w
         wGsQ6wTWlNxh+Hvf/mkKbRax2q5pXa4HmceACb5v8qmitzDJJJbEFs5YVwgxlUZG92gJ
         Jshy1rhQD+kHiFAkr5T/Jo0sSAUkmZ3wwZOST6F/HnNpHT5SWpabWDq+wMmkCBsOHqu4
         f/7t6SETkH9L5kVFe5CFD0vgoaRfPAA1OaSmIoSV/L8XJ0mLVKU5YWSSWd9iHobA/UTS
         mK7EhvQccYYe/WAnRds4xEYe4VhVWIECxTahYfsjMisxQYW+e8PBLrn22a9Wf2gGJTjQ
         m59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0M5FwzbPAy5c2Cwb5UeKel5vnxZKoOrIQ9Hgfx4Nf84=;
        b=eCb49Hq78xyPRUfbbf0hVPDh1LPR1L01ZjCHdqUQonVyEGPJY4yLiYjyWOPx3s024o
         UcDKcvtggfhblI3qEwDEOOyLJddWWHdhH9TodbLhcGDzknTPzJfjMAN6ZOOLoo+3c64K
         BLrsEEKfASaw82TIrFrpMwEdC+Zeg2PyF7KRM41TtBfxpz5pDv4qYTNhPKeUTMoexJ2W
         0QTTUwBLnIsSVqKIUqeMASqJ0Qo/CJx0E4cVH/TExIs5f/1H/6jvY9Fk98ftGGQMskx1
         iPgmFYN8IqfXzrHgJBNlyR/VM2paQaCoe8HTWlEZ4NC+byukwgFo46MAXa7nG4BFWy6E
         FyUA==
X-Gm-Message-State: AOAM5313O7NbNjEj7vtfCKy4R5/p6JUrQnv4wSn2Ff6keO2TFht668IV
        2coSZDuEPVdJoe5sRkxz46gSe1fxMriD1g3D
X-Google-Smtp-Source: ABdhPJz32JfxtVn+RJlnSVHMQiHFOzrDCBnX4lrD24OLqQcMNGwPPcjTjN2IvCPYDD3M7NzOLB5Mqw==
X-Received: by 2002:a17:907:969e:: with SMTP id hd30mr74976ejc.5.1618435149669;
        Wed, 14 Apr 2021 14:19:09 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v5sm568222edx.87.2021.04.14.14.19.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Apr 2021 14:19:09 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 05/11] arm64: dts: rockchip: Fix power-controller node names for rk3328
Date:   Wed, 14 Apr 2021 23:18:50 +0200
Message-Id: <20210414211856.12104-6-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210414211856.12104-1-jbx6244@gmail.com>
References: <20210414211856.12104-1-jbx6244@gmail.com>
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

