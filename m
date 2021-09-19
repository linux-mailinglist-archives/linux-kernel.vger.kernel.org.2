Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A68D410C2B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 17:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbhISPaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 11:30:10 -0400
Received: from ixit.cz ([94.230.151.217]:43342 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233114AbhISPaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 11:30:09 -0400
Received: from newone.lan (ixit.cz [94.230.151.217])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id CE37123B26;
        Sun, 19 Sep 2021 17:28:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1632065322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QI4FPjhypojGCEGbwnN4o9VsS0NIGjkdFUqs4+dbCeo=;
        b=JfbJelLhxR7R0G3cDe5XmrSAQ5/Bqf7Idp3PNIlWAuqT2sips46n+P3o0Zf2UNHupVYAwB
        BXSuQwI9e2VR3mZuJ163FkiH9SkdV0pso55FE3JdlN8f7D0CDPlpH7HdD59Y3GdlzQkz5f
        UYhLbWKZXWW1PZsInENUP3Q/Dfsy3Ic=
From:   David Heidelberg <david@ixit.cz>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: [PATCH] ARM: tegra: dts: remove unused backlight-boot-off
Date:   Sun, 19 Sep 2021 17:27:20 +0200
Message-Id: <20210919152720.72748-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

backlight-boot-off was proposed as a patch, but ended not being accepted
since different solution was already in the place:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/1406806970-12561-1-git-send-email-thierry.reding@gmail.com/#21327479

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm/boot/dts/tegra20-paz00.dts            | 2 --
 arch/arm64/boot/dts/nvidia/tegra132-norrin.dts | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index 916d29183af7..ad8a659f8c80 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -615,8 +615,6 @@ backlight: backlight {
 
 		brightness-levels = <0 16 32 48 64 80 96 112 128 144 160 176 192 208 224 240 255>;
 		default-brightness-level = <10>;
-
-		backlight-boot-off;
 	};
 
 	clk32k_in: clock-32k {
diff --git a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
index 6e5f8465669e..8a51751526ee 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
@@ -1021,8 +1021,6 @@ backlight: backlight {
 
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
-
-		backlight-boot-off;
 	};
 
 	clk32k_in: clock@0 {
-- 
2.33.0

