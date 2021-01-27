Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A523051D1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbhA0FQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 00:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238704AbhA0EzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 23:55:17 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F1BC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 20:54:37 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b17so365126plz.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 20:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XcNzJ3Y1xaPDuXcAllHAfyiKBSKXPgrFbgqPU858HRE=;
        b=c63/2D4Bgx2Pjk09crfuNIuRwe5/wMbu0Ar0zyQsmCvjMtnTas7y/GZBYlWxRjh3Cu
         Nb1V3mC3i2fY9O+EVE8ljfGG/yIlqdt7A80tCikJGekU3DA6bwVdJV2EpvcTM4Bl2Ejs
         w1Y6GR1JZE4dTINAqovV9VIiAh/wsO0SgoYf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XcNzJ3Y1xaPDuXcAllHAfyiKBSKXPgrFbgqPU858HRE=;
        b=fwslEdQ1jKAyedgANKr4pnB/D/LRqnEqsyHRxlZMiFmhTRYt29yXd83oYoYFTt0a20
         NjYb0x6vTzytDiXOQcZ1PlSt8N9VmFeac6GjUcQyo46jPKkIL3ldWDiqBSBwuAHajHAk
         XEq7nW6XWHqBi42EGOdREiJT/vPSd6AgTjDNhtC12yi3oTzboFeFnj5zUnEnsDQ+JJlp
         Bfli4IV2r4um1lliMAPtNRw+q5uUEPtOJuxmdVMGLSCvHfODixWvOxw4ZIWSaE6dhFzZ
         ZNn6zYJ8iUravrXKaCGKD/+mVAl/9ILfLIgAoh9kNvQLMB9upuBOJ/j96ynnJJM+ZYPG
         psyg==
X-Gm-Message-State: AOAM530XYWe5gSPBImon9B1qRRhVjP8k/Mg3IkJUtVs85606mhVGJHkF
        ++cFXGBhr66+lgMT9Mbe2loc2g==
X-Google-Smtp-Source: ABdhPJyCyyCu7ohSjPbSyt1lJg9XiT+gg2+ohCN2CtKu56w6RhygO1w9flQc9+fGYUeBaJfTm6dUew==
X-Received: by 2002:a17:902:7148:b029:df:f45d:41c9 with SMTP id u8-20020a1709027148b02900dff45d41c9mr9676516plm.3.1611723277218;
        Tue, 26 Jan 2021 20:54:37 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:e0a5:d2fc:aaad:1e4a])
        by smtp.gmail.com with ESMTPSA id a141sm684484pfa.189.2021.01.26.20.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 20:54:36 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v10 2/9] arm64: dts: mt8183: refine gamma compatible name
Date:   Wed, 27 Jan 2021 12:54:15 +0800
Message-Id: <20210127045422.2418917-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210127045422.2418917-1-hsinyi@chromium.org>
References: <20210127045422.2418917-1-hsinyi@chromium.org>
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

