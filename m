Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527BD3625D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 18:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbhDPQla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 12:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236133AbhDPQl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 12:41:26 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AB1C061756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 09:41:01 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id z16so19563675pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 09:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RjMuzngv1Iayt+yUw/uUaDmTQawSHVPlVJmmqgEa6BM=;
        b=g/oXo7zbtAbKKtBtmjhbLUN7uOn6hmel2a9Sf2aNlp/sBskWzN9wdi9eNjek8FlKVr
         pwVm+3HWWd33igpLMA8T3WADtg7x9sWPzE9wJq7c1+/vdhPcYwMIa2NAbC4bCSU6HvSA
         vMSWh5VYPF6GoUyfVUMZEWsQjyBkqzGLwav5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RjMuzngv1Iayt+yUw/uUaDmTQawSHVPlVJmmqgEa6BM=;
        b=hd9kKK1njOr9j6D/5v83S7WfP8ynZZR4Ku0xDW0gSf8kN6WfsUuvxOMxJnKCmJ/yLE
         CfG6tMxlRVPEY7773piEG+rvrXgVsdH1Fy+HfU19CVyNdIGlYzmXL/UIb1b/fGkj6wFh
         SU4MAfyaKdj1znYGS24G4e5aQlbb32zM5VgpFIhq+d540Rf0lTekTBZ7SYQb99T7NMOw
         MRW4PtaQOj3hLL0hc+pGSZ0XyoB6isOD/vW5TZw0OboCGPxIPgJCOeAxmSlo00KF0KJp
         9NW8o4YumPoGFLx2qnQOoMgNPq7p2/Y1ciLCuZrJ41zwJXI9QIC10pEdhUkcgj02DdJ7
         ixxQ==
X-Gm-Message-State: AOAM53165rF39e0/Z+bTEsMuB3Ulr8QW/AB+KdLJIOwinXcEG5s5BDTP
        vyhPsxUaYX9S2sg8R66wTkqpPw==
X-Google-Smtp-Source: ABdhPJz/U/VusSniOO1YHlXFt1wfBVXoqQ3hpmTxLqWMgCAS/0r7gTQnCSYPPaYNfi0wxzHFLJ3MtA==
X-Received: by 2002:a63:3245:: with SMTP id y66mr9115090pgy.435.1618591261315;
        Fri, 16 Apr 2021 09:41:01 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:ccd5:218f:365:b90f])
        by smtp.gmail.com with ESMTPSA id g14sm6187186pjh.28.2021.04.16.09.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 09:41:00 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v2 2/8] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-willow
Date:   Sat, 17 Apr 2021 00:40:49 +0800
Message-Id: <20210416164055.3223088-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210416164055.3223088-1-hsinyi@chromium.org>
References: <20210416164055.3223088-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Willow is known as Acer Chromebook 311 (C722/C722T).

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 81b86b189a8d..96c401597bd8 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -157,6 +157,13 @@ properties:
               - google,kodama-sku32
           - const: google,kodama
           - const: mediatek,mt8183
+      - description: Google Willow (Acer Chromebook 311 C722/C722T)
+        items:
+          - enum:
+              - google,willow-sku0
+              - google,willow-sku1
+          - const: google,willow
+          - const: mediatek,mt8183
       - items:
           - enum:
               - mediatek,mt8183-pumpkin
-- 
2.31.1.368.gbe11c130af-goog

