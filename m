Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBB73E9DD4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 07:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbhHLFLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 01:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhHLFLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 01:11:33 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27910C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 22:11:09 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id a5so5740423plh.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 22:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SWR2mXkg51krjGDZKbq6W+12ZAbjOnmXR2AtIiwcOUU=;
        b=abqseVDjEYnDP1IrFXt8rh5oE5TVI8E815JtxAWGbn4VXtQTD/CDlXUmK1wRW2wV3J
         Ez1v18B9oTFjJKPHPWmiT663mi1SzfFQx7pbFIfvi7gsez6nw0T8g3nYuydB1p9bSVXc
         Ku4ofIC+0sPQvr40rbn77PIph6QEH9O19N9OY5jUGGy/mNG7o68OSA5N8xqqPsTbdDZO
         H6Qk488v7sGfln98r/perUTPDhahCmyDT2kNYQl1i4SMY/HCENA8k4TEZh+LrjhU80or
         CBcX8BpFtbuHBrynR2+sJq45LBXSBULNyuUaJDOPtC0VT4NrLZuLU1kPeoTUvK5tmTBW
         q/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SWR2mXkg51krjGDZKbq6W+12ZAbjOnmXR2AtIiwcOUU=;
        b=uDqK/7nlDE6zovsX+uTF+axev/1/DLWRxNjB5XjWGRrPkKFtY9AwlpP3JiLMpWnX/R
         /FoQ8H+Iw9lhuvs0Fu0p7YgkHrcIufzCS0GOkDuMkQpkcq1lv4WRvzVgE/NJTGtTKBsj
         YA7l+SeoACrqovcnN5tCpNwDZh7dq9ELIllBatYHLtmAg3wRQNy40V4nZj285eXY9dS5
         y0L9zoDU7BBspoMWzTR6lL+o0JGIA4rhpJ1lUeTcaAZtorbAsazgzRbpQWURSFtcG43k
         sjFYF8uTgxwB1tqeqApnOeXuk1qmrfAB+0KJjeOHrtcJ+HPPUHfP41cS56TIpH8j45tC
         /gsA==
X-Gm-Message-State: AOAM530TwPThyPvSclW8knik7S3Nra63OTw5fMRhJEVRBXn7woKcyQQP
        WOpwFmGa23tTnjQDg9e3EXzSeaFX3ch8UQ==
X-Google-Smtp-Source: ABdhPJy43CERi69z2IwDxKPjKgZ1CPvwTJr71N0R8AGHc3YGb7JVs+2zPLsYvpWl+xH3fjRCzZI+vg==
X-Received: by 2002:a17:90b:3b83:: with SMTP id pc3mr197734pjb.30.1628745068662;
        Wed, 11 Aug 2021 22:11:08 -0700 (PDT)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id y23sm1544224pgf.38.2021.08.11.22.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 22:11:08 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     narmstrong@baylibre.com
Cc:     jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com, art@khadas.com, nick@khadas.com,
        gouwa@khadas.com
Subject: [PATCH] arm64: dts: meson: sm1-khadas-vim3l use one sound node configuration with VIM3
Date:   Thu, 12 Aug 2021 13:10:59 +0800
Message-Id: <20210812051059.1103641-1-art@khadas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Khadas VIM3L board sound configuration same as Khadas VIM3, its already
defined in meson-khadas-vim3.dtsi and no need overwrite it with different
card names and routing configurations.

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 .../boot/dts/amlogic/meson-sm1-khadas-vim3l.dts     | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
index f2c098143..06de0b1ce 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
@@ -32,19 +32,6 @@ vddcpu: regulator-vddcpu {
 		regulator-boot-on;
 		regulator-always-on;
 	};
-
-	sound {
-		model = "G12B-KHADAS-VIM3L";
-		audio-routing = "TDMOUT_A IN 0", "FRDDR_A OUT 0",
-				"TDMOUT_A IN 1", "FRDDR_B OUT 0",
-				"TDMOUT_A IN 2", "FRDDR_C OUT 0",
-				"TDM_A Playback", "TDMOUT_A OUT",
-				"TDMIN_A IN 0", "TDM_A Capture",
-				"TDMIN_A IN 13", "TDM_A Loopback",
-				"TODDR_A IN 0", "TDMIN_A OUT",
-				"TODDR_B IN 0", "TDMIN_A OUT",
-				"TODDR_C IN 0", "TDMIN_A OUT";
-	};
 };
 
 &cpu0 {
-- 
2.25.1

