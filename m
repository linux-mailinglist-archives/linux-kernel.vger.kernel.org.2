Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F5836DF3C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 20:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240264AbhD1Szu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 14:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbhD1Szt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 14:55:49 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1785AC061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 11:55:04 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id k4-20020a7bc4040000b02901331d89fb83so9395289wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 11:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4rAdk4nkjhG0XC7p2QVsAF6u5cBc2uukGOWp5W5vsvQ=;
        b=ZVO2HFrqRPs2AAGZVVJlCfWHKnyzTidrOnphxeQ14+GCXLPePCO59ANH4Mw7Vt3wwJ
         LUL2gCW0hZChYjy9qzyV99nX/+Gf1gdLJ534ksdKJxY+EE0UReaegfjK8erp5L/wTI3t
         /odDHTR+ZEu16yqb0iLeWrAAv25GTDQh52/kRXZXhBUCtvSEm0rUBdpb/zQ2wnl0px1L
         bUoASHQocvg9nsKPyWEplP96n0F7R3Rw3itFcwxalxypK9g638pi4LWEWW/4fkkFKUUf
         5Bdjemnd81P+4/SSJo9Et9cID/dA8Fqp5MaWxV2iftVXteQL5vqy+Mu64SrFrfHPytqW
         DPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4rAdk4nkjhG0XC7p2QVsAF6u5cBc2uukGOWp5W5vsvQ=;
        b=eSEYAI0WuEaF4F77JTy652BeqbX00gMXLC72ojRU2jF/AtNSNnQq/5y1301bgLpnhT
         vfuM/qLNcFzzWwf0glwry2xqo4+6HYXL4lzjiqJ4EZc3MWX9+ld65zGKQniEE/Ciol36
         u8OZBB7ik1VEEvwk8z+Rv+5sU8GvhBfkHEh5CA3kpSxDU0QmUOp0YGGgzRV1Q/biY9b9
         /AG4NZED6fhzxFNmQ0E1Vtu2ThJneNjod8uzjwZYZgqaovGvExvdGdWX0x2NY+491Q4O
         4wBGDPgror8LwkrooNnx3fF6Je7FE9+eH5Q7KpQcyWKrr3lTEppwOHBIf4WmhrXkAkmb
         m2Yg==
X-Gm-Message-State: AOAM531yGc9F8Huk6B0LjqVhnjpHNltBcmZslZAj8+Rj0fW/B+kPxwVm
        GZKpQc3MBmDoch7uqdQE5PJ3kw==
X-Google-Smtp-Source: ABdhPJyi36gCKOg8zClGfRbCs06dLWzYQm+FXkbhE/ruc+AN6PAbCEVKEnN4BhhAprFMRcbV25i6Nw==
X-Received: by 2002:a1c:f302:: with SMTP id q2mr6209998wmq.85.1619636102706;
        Wed, 28 Apr 2021 11:55:02 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id k10sm10769302wmf.0.2021.04.28.11.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 11:55:02 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        ulli.kroll@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] ARM: dts: gemini-rut1xx: remove duplicate ethernet node
Date:   Wed, 28 Apr 2021 18:54:57 +0000
Message-Id: <20210428185457.3719842-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two ethernet node was added by
commit 95220046a62c ("ARM: dts: Add ethernet to a bunch of platforms")
and commit d6d0cef55e5b ("ARM: dts: Add the FOTG210 USB host to Gemini boards")

This patch removes the duplicate one.

Fixes: d6d0cef55e5b ("ARM: dts: Add the FOTG210 USB host to Gemini boards")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/gemini-rut1xx.dts | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/boot/dts/gemini-rut1xx.dts b/arch/arm/boot/dts/gemini-rut1xx.dts
index 9611ddf06792..08091d2a64e1 100644
--- a/arch/arm/boot/dts/gemini-rut1xx.dts
+++ b/arch/arm/boot/dts/gemini-rut1xx.dts
@@ -125,18 +125,6 @@ ethernet-port@1 {
 			};
 		};
 
-		ethernet@60000000 {
-			status = "okay";
-
-			ethernet-port@0 {
-				phy-mode = "rgmii";
-				phy-handle = <&phy0>;
-			};
-			ethernet-port@1 {
-				/* Not used in this platform */
-			};
-		};
-
 		usb@68000000 {
 			status = "okay";
 		};
-- 
2.26.3

