Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997E73F3F23
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 13:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhHVL6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 07:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhHVL6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 07:58:45 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C878FC061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 04:58:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x12so21595452wrr.11
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 04:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4j6NCEA2JsSzQ2QsfgWgHDpNcyrom07JcEHXpRwvQ14=;
        b=aojctXTp9BeGs075gGnP60Pb0/CqIhoBf7WWZx1f3Qk4xIvD2dSjNWonXwAVEIfBh/
         4H76ff14KgN5KLmvPR4Suj8+3ZeAjXM1p5iajIcZ5aGGmTimRAZ5gp31VTyxSJ1utlHH
         Ht8tu41WQKznENCSRDhJLnsiTGgHoyD0Crp6tEg/TqR/8+bnd1J2CTlIcwHUqi8DLfhG
         l8he16ClLwmKCYcuVO9ZOxV98bgv7kQA/2GmjMQj1uoR7seRwyF9bHmsuKqdOF3SZBA5
         W2zmVQ/7Ms0Iz2+eGoiyXo8E8WK8hR5Y2UQpTJA5/e3XrOcAOWanl1AW3gy1k9HdWvdR
         onXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4j6NCEA2JsSzQ2QsfgWgHDpNcyrom07JcEHXpRwvQ14=;
        b=CvUNPYnRXrvfUH7kh/axJLVRBg/+5bixikYlJ5c09bWk+VpVAflu2HiVQcuUi5lJOp
         jBFXVA0laqJEdL7PQjNaC53MtZ+8ZtGfU13ukYd9I4zIXga4Ly+x4l71t7Loqjoe5GE1
         Mkr5BIhvM88gaO3KMstUQBwMgcL6GqdB4dUFJxaEVIDfbIoR4F7U82NIe2mdkesYF5uV
         BF/0ekhaAn8BopQ1r6HYKZDUHfqOx+OrLr1YT+MyHLpxtK7G06aTOmGUmfjIv4o8hUqt
         wgxaDtyUSMhm014WcklhIxcBcLAtUvJz0sNKvJfrXVP6rZAbYW9pqGSLdjKEMd1R+ivZ
         APMA==
X-Gm-Message-State: AOAM530pWyQOzkxW+GcBXx3dgVIa7UUoKJI1t5ryLpy7YbP1JbbXW942
        ZalXNvXmPAuRVX91HDpxTA==
X-Google-Smtp-Source: ABdhPJzMnOC33dq2VZnwECdAtqdJtIWt0/HDpXCZlRyZcQAcpER+Z3PxsOIn5IU1WqY6q3wU9q/x6Q==
X-Received: by 2002:a5d:4bca:: with SMTP id l10mr8251436wrt.187.1629633483471;
        Sun, 22 Aug 2021 04:58:03 -0700 (PDT)
Received: from alex-ThinkPad-E480.. ([2a02:810b:f40:4200:97f6:a4b1:c76e:8844])
        by smtp.googlemail.com with ESMTPSA id k16sm1597965wrx.87.2021.08.22.04.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 04:58:03 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Johan Jonker <jbx6244@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: Re-add interrupt-names for RK3399's vpu
Date:   Sun, 22 Aug 2021 13:57:55 +0200
Message-Id: <20210822115755.3171937-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a728c10dd62a ("arm64: dts: rockchip: remove interrupt-names from iommu nodes")
intended to remove the interrupt-names property for mmu nodes, but it
also removed it for the vpu node in rk3399.dtsi. That makes the driver
fail probing currently.
Fix this by re-adding the property for this node.

Fixes: a728c10dd62a ("arm64: dts: rockchip: remove interrupt-names from iommu nodes")
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 9db9484ca38f..44def886b391 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1240,6 +1240,7 @@ vpu: video-codec@ff650000 {
 		reg = <0x0 0xff650000 0x0 0x800>;
 		interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH 0>,
 			     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "vepu", "vdpu";
 		clocks = <&cru ACLK_VCODEC>, <&cru HCLK_VCODEC>;
 		clock-names = "aclk", "hclk";
 		iommus = <&vpu_mmu>;

base-commit: 5936c9eb785b46fdc5563d1c5c34b5558e3fa156
-- 
2.30.2

