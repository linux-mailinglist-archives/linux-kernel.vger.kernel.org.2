Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5827306F81
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 08:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhA1Hb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 02:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhA1H2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:28:54 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF5CC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 23:28:14 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id t29so3427242pfg.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 23:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XcNzJ3Y1xaPDuXcAllHAfyiKBSKXPgrFbgqPU858HRE=;
        b=bmxOK+fJooGfsi1izamRIsN0nqeSv63ef+oEkbVp1glFlLrQvZ71goAnFNQsXR0ldr
         bwGyOzNYDkhdnEsJK49o/gs3Up6t1KlcUtli8//Gu4ogsMsFAOIUeBG0CJasgI3DCC5U
         1mRlK0KeM3yJ+80Sg7Lv60SXRIGdKN3OcNUyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XcNzJ3Y1xaPDuXcAllHAfyiKBSKXPgrFbgqPU858HRE=;
        b=tmM5KlFq7N15Hkvr5q8+81kb0V4fCmXNSYzhv8ralJy7wBkIVM6blbTWFxSJLT1mO4
         xU71UytP0JWv4dub5/1edUltnXMpomJELfZP2wgOHhcP4tGRFXXlI8ly8gtZIwFkglkb
         eWS6o9k5sf7FwwDcTZrKoX9sVUC2R89N7Z+dby8e3+4BlZblToL6nsfGbSBgB6sBPcLt
         iNn/7q+0l38GyOy3LyiZ6KAO0eoPO5le6zaBoiXS4L635xBSaWGUi+CQbHu2eFV0d+Sg
         lGfmYldNRo1yc+2DXFMQB9oI6J2leZ8N8tao8jxMgXTg8I+iKI6Bo+G4QVohSVTzmTcb
         NJmg==
X-Gm-Message-State: AOAM5338hotW8IHoQzUwe1oaysdgPsy9ayLLBUq5OnvPSQgrxiEaX3Sd
        7YTYLe1UboSyo4rbScJIvcmuVQ==
X-Google-Smtp-Source: ABdhPJxfvkOtpAtVlA4WoWPSHf48aGiRf3y51TDlCjt1Wf4BDlyuknkFk7E3OdmCdQkhwKxFf7BKNA==
X-Received: by 2002:a63:4e5f:: with SMTP id o31mr15143945pgl.55.1611818893892;
        Wed, 27 Jan 2021 23:28:13 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:e0a5:d2fc:aaad:1e4a])
        by smtp.gmail.com with ESMTPSA id h2sm4800304pfk.4.2021.01.27.23.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 23:28:13 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v11 2/9] arm64: dts: mt8183: refine gamma compatible name
Date:   Thu, 28 Jan 2021 15:27:55 +0800
Message-Id: <20210128072802.830971-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210128072802.830971-1-hsinyi@chromium.org>
References: <20210128072802.830971-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

mt8183 gamma is different with mt8173
remove mt8173 compatible name for mt8183 gamma

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 6c84ccb709af6..9c0073cfad452 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1055,8 +1055,7 @@ aal0: aal@14010000 {
 		};
 
 		gamma0: gamma@14011000 {
-			compatible = "mediatek,mt8183-disp-gamma",
-				     "mediatek,mt8173-disp-gamma";
+			compatible = "mediatek,mt8183-disp-gamma";
 			reg = <0 0x14011000 0 0x1000>;
 			interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_LOW>;
 			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
-- 
2.30.0.280.ga3ce27912f-goog

