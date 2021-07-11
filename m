Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64463C3F8A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 23:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhGKVnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 17:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhGKVnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 17:43:21 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD9CC0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 14:40:34 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l6so1716014wmq.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 14:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IKIR62m9zVkXxG+1eboDYFTYTh8DV2vf9zqwrpBAfSg=;
        b=hNZPcdHFpWM4e15vO1XRt1t1s+vPKT9lj9tuATED58XFszt2/dGMSu2wuKQHfVHWUx
         yTAloFyx2NjBzj1WTcOmJnnJsT/5NnEweR6vnmP2B+bNltOaCdOI3XyBM3xyX/s3aB3t
         SQHHa01/ETb6Z8vRW6/lYZwbFlr9LWOu4P4FqoSe3sKb3FOdwOvymiJv5CTrbGHlsx1J
         /9Ghg3NenJlk/2m8wMJExNZNebfm82HlTHFO5x0j59MOJuHXSoGc7Cmyf81oo2mnfp2n
         NxPb2PSoyWchngYedzAxzrpk6vN9uKq1WG3PplsHef/4xShVePCVOHXBNKBiMFdqyUGS
         demQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IKIR62m9zVkXxG+1eboDYFTYTh8DV2vf9zqwrpBAfSg=;
        b=hZuMfPt+f+yIymT1h65uCaF1pyI0rgPfpdSni9aCszV9dgq0C0GmT8vAmd5sjSsFLl
         eWqe4lxpDlvD2k/WdeQpigJOVwlhzkomcw9oOKqx/5HOhqZn0XH4/Io6eHIIiXlCezDo
         qbHAFUE3dSldKA4iHVKY6VX3Lm39mkdxmVnOvv1JmFapOtHwmkD/cT4i3GSdMnGUY5MZ
         6sX4+3WwgYEJcCJ16LJK6CE4V015//xoMJl1uiMWzfXGsRSNyljHQ/1YnLVkIfC+nm5m
         i/N0FMuqi+MKIsmVccXLJn4S7Zhx+dyFU05MR69Ny7QE6sdMz/qvJCRazZVB/H92HxU3
         2KOg==
X-Gm-Message-State: AOAM5318siyWnvgxlTvvdMEXSh2MgkanQD7ytZavLeEWyDwnh9ARD6yh
        GmZMXL9bgkExZb9Sa9SFwS4rywWYAbA=
X-Google-Smtp-Source: ABdhPJypYBWjgzOKZ7Xpagpufk8hb0p9U/cfCi1CQN2PkHDCdkbtg5PCUIGYN8Ovv++YFXy1vZYcRg==
X-Received: by 2002:a1c:1b87:: with SMTP id b129mr52754193wmb.189.1626039632613;
        Sun, 11 Jul 2021 14:40:32 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-721c-fc00-f22f-74ff-fe21-0725.c22.pool.telefonica.de. [2a01:c22:721c:fc00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id m29sm17563212wms.13.2021.07.11.14.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 14:40:32 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, khilman@baylibre.com,
        jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Demetris Ierokipides <ierokipides.dem@gmail.com>
Subject: [PATCH] ARM: dts: meson8: Use a higher default GPU clock frequency
Date:   Sun, 11 Jul 2021 23:40:23 +0200
Message-Id: <20210711214023.2163565-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are seeing "imprecise external abort (0x1406)" errors during boot
(which then cause the whole board to hang) on Meson8 (but not Meson8m2).
These are observed while trying to access the GPU's registers when the
MALI clock is running at it's default setting of 24MHz. The 3.10 vendor
kernel uses 318.75MHz as "default" GPU frequency. Using that makes the
"imprecise external aborts" go away.
Add the assigned-clocks and assigned-clock-rates properties to also bump
the MALI clock to 318.75MHz before accessing any of it's registers.

Fixes: 7d3f6b536e72c9 ("ARM: dts: meson8: add the Mali-450 MP6 GPU")
Reported-by: Demetris Ierokipides <ierokipides.dem@gmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 157a950a55d3..686c7b7c79d5 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -304,8 +304,13 @@ mali: gpu@c0000 {
 					  "pp2", "ppmmu2", "pp4", "ppmmu4",
 					  "pp5", "ppmmu5", "pp6", "ppmmu6";
 			resets = <&reset RESET_MALI>;
+
 			clocks = <&clkc CLKID_CLK81>, <&clkc CLKID_MALI>;
 			clock-names = "bus", "core";
+
+			assigned-clocks = <&clkc CLKID_MALI>;
+			assigned-clock-rates = <318750000>;
+
 			operating-points-v2 = <&gpu_opp_table>;
 			#cooling-cells = <2>; /* min followed by max */
 		};
-- 
2.32.0

