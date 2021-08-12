Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B763EA266
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 11:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbhHLJs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 05:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbhHLJsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 05:48:25 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AACC061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 02:48:00 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso9813424pjy.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 02:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dOqSFltEpEbokoDy6ipxidhtAiWmCLx6EcMqY/l120k=;
        b=TqcSRmeOh1pvcfCL19XkABqdF4XmOBYjRvCaliy+6d3wemr1Mu/RiODHwBpiy0ts5u
         Gc7AGlfxitsOH18x1BqcD8qNSTPsJ06Ubc2p3rx9mL+WIvkt0mAOUqIx9NLzGdnKMJpZ
         ++a/jxJPt+QMYST0iyJDEaY9s67RSpBt4Vsp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dOqSFltEpEbokoDy6ipxidhtAiWmCLx6EcMqY/l120k=;
        b=Pn+6q68xTxVr6oWsHLecrrjyYQHPYoD52vTxRcyFLroxEuCAPXtWBEXb2fswgxTzb9
         /lxqY+aDPKhV7d0y6XvXLhkRN1YOmgAKNn2EGstN5b31F7u0evxLCXzHPrUUviWjNa19
         nVM2RRN71L3XmdVmNsh/7ksJQe0NBmznYhD46MqK5vBnSTgwJHawe6+v/GGHoSq6scLy
         MrJA6gOVmXGZiGwIyejiAk3xKnB+sJgxOeLgbL+B6L0+TaBzDGGpFhsBR0kLNwuxzErG
         qVqWc2j8O82FR/aETdF4kQsGC4jLtmU/Ck73S5Ot02Iv5KSWJbWHWAPtOu1aCE4gAWPK
         SbzA==
X-Gm-Message-State: AOAM530ZQT3sNLZXqblrRXoUHvGPNgarnKH5M5qqDgLI7T+SlUZpoC/Q
        P5biEtnOL3VkTzlrWgGqmGyrCgiiUAbWmzHU
X-Google-Smtp-Source: ABdhPJxkhC26wPbMoVehPfVfyF7Xq2iQYzJTKWqq7f5cKZSfqJrbxlyAv0AfS1F3smIRrLqcn7mJHQ==
X-Received: by 2002:a17:902:edc8:b029:12d:4a06:1c25 with SMTP id q8-20020a170902edc8b029012d4a061c25mr2994745plk.61.1628761680406;
        Thu, 12 Aug 2021 02:48:00 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:8e0d:8032:9364:612c])
        by smtp.gmail.com with ESMTPSA id z15sm2991052pgc.13.2021.08.12.02.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 02:48:00 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: rockchip: Add gru-scarlet-dumo board
Date:   Thu, 12 Aug 2021 17:47:52 +0800
Message-Id: <20210812094753.2359087-2-wenst@chromium.org>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
In-Reply-To: <20210812094753.2359087-1-wenst@chromium.org>
References: <20210812094753.2359087-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dumo is another variant of Scarlet, also known as the ASUS Chromebook
Tablet CT100. This is almost the same as Scarlet-Innolux, but uses a
specific calibration variant for the WiFi module.

Add an entry for the board compatibles.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../devicetree/bindings/arm/rockchip.yaml     | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index aa9a4fd4fc20..4aed16176434 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -298,6 +298,34 @@ properties:
           - const: google,veyron
           - const: rockchip,rk3288
 
+      - description: Google Scarlet - Dumo (ASUS Chromebook Tablet CT100)
+        items:
+          - const: google,scarlet-rev15-sku0
+          - const: google,scarlet-rev15
+          - const: google,scarlet-rev14-sku0
+          - const: google,scarlet-rev14
+          - const: google,scarlet-rev13-sku0
+          - const: google,scarlet-rev13
+          - const: google,scarlet-rev12-sku0
+          - const: google,scarlet-rev12
+          - const: google,scarlet-rev11-sku0
+          - const: google,scarlet-rev11
+          - const: google,scarlet-rev10-sku0
+          - const: google,scarlet-rev10
+          - const: google,scarlet-rev9-sku0
+          - const: google,scarlet-rev9
+          - const: google,scarlet-rev8-sku0
+          - const: google,scarlet-rev8
+          - const: google,scarlet-rev7-sku0
+          - const: google,scarlet-rev7
+          - const: google,scarlet-rev6-sku0
+          - const: google,scarlet-rev6
+          - const: google,scarlet-rev5-sku0
+          - const: google,scarlet-rev5
+          - const: google,scarlet
+          - const: google,gru
+          - const: rockchip,rk3399
+
       - description: Google Scarlet - Kingdisplay (Acer Chromebook Tab 10)
         items:
           - const: google,scarlet-rev15-sku7
-- 
2.32.0.605.g8dce9f2422-goog

