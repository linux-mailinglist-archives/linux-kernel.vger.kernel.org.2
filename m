Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0EE3B197B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 13:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhFWMB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhFWMBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:01:55 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449D9C061574;
        Wed, 23 Jun 2021 04:59:37 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id h21-20020a1ccc150000b02901d4d33c5ca0so1163003wmb.3;
        Wed, 23 Jun 2021 04:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xzw/4c3zYIVYrIQdBbMBp4EEh/m3aAvDBYr8K6MbN2U=;
        b=FDdt0PMX1Os97ku1lM/T7xZsc+mCtqRZhdLHnnWOX6Mcu+7YHQ61oZguWkC1ASwsw1
         vgP/GdS60Mv0otXIjYI+11IrHNRwHgSvogVwoXkzZFI4pWHj4XYRtmLb0DOaC7myQHZ3
         dvnzmb2vnxLrvM2L/cKoN16dXdIGgLhUWzU9NasBNFll6ZJ2jaCZjPY1WpNz/fE5jxij
         fQ5xIDr/NONAcdrSxu1QTTRj0V5DOylYeyt/vNWS7yp8SHaDHyPxX8B/2xF94Rt23Nbk
         DL25dX5NipeqRkLBdq1JbekayStncreY4QzOnL/Ik9g0N2HyU+Okgvs2nRzHwB5ZJde5
         w0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xzw/4c3zYIVYrIQdBbMBp4EEh/m3aAvDBYr8K6MbN2U=;
        b=uY1PV6Ao3jtj/vCY9TmdU4MyiSXzsDSvg+c3fJYOPubls/oHUwvSn5IKC4jihWHYJ6
         OK6sKbsDHeZPeYhCP+W7DOIqYbXNCu7lPrmcO0f9I2c9RuZbg4pyetrf5Jm/9xMurCJg
         24RP/Unbl34KXXP20wkeuEJEHMC6zX3YpKFpc3wbPV8MjCvkYX8vTmt43UEtPlD2sPB7
         R6x+ShXBz3vxLPoZ3hk7j+5fcgAcYNDf0dHAWd0dsOvfFr7BLpqRsUgSmMGJaTxlgQ+f
         exsE954XTRecOXN05zi33F1MHb7i5Jhvg0Cdvvxgh6lzUJqVYlTn/bHSAqYRpSk1LxLh
         O1YA==
X-Gm-Message-State: AOAM532OHHcdLHKZrQCmayxi0hORHAh7FFwv2OjPvVCcm4tUk04XuM3H
        61qu0h/FCvSlGYWUbgClwA==
X-Google-Smtp-Source: ABdhPJwZuK8Va11JBkM37YotH8BmGlV0DaMaCUiNgAghs6DU2efC15zigmOSaUc5v6PneRTKxNyebg==
X-Received: by 2002:a7b:ce8e:: with SMTP id q14mr10204347wmj.33.1624449575836;
        Wed, 23 Jun 2021 04:59:35 -0700 (PDT)
Received: from localhost.localdomain (ip5b434b8b.dynamic.kabel-deutschland.de. [91.67.75.139])
        by smtp.googlemail.com with ESMTPSA id o3sm2661265wrj.94.2021.06.23.04.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 04:59:35 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: Fix GPU register width for RK3328
Date:   Wed, 23 Jun 2021 13:59:26 +0200
Message-Id: <20210623115926.164861-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As can be seen in RK3328's TRM the register range for the GPU is
0xff300000 to 0xff330000.
It would (and does in vendor kernel) overlap with the registers of
the HEVC encoder (node/driver do not exist yet in upstream kernel).
See already existing h265e_mmu node.

Fixes: 752fbc0c8da7 ("arm64: dts: rockchip: add rk3328 mali gpu node")
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 8c821acb21ff..da84be6f4715 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -599,7 +599,7 @@ saradc: adc@ff280000 {
 
 	gpu: gpu@ff300000 {
 		compatible = "rockchip,rk3328-mali", "arm,mali-450";
-		reg = <0x0 0xff300000 0x0 0x40000>;
+		reg = <0x0 0xff300000 0x0 0x30000>;
 		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.27.0

