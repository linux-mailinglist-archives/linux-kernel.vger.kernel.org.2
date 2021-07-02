Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51873B9F0C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 12:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhGBKZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 06:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbhGBKZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 06:25:50 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A48C061764
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 03:23:19 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g21so8525046pfc.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 03:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UhoYD5NgEf4BoTnpIK3bxc26o2f3DMv5QYbRT9lyhY0=;
        b=ei1C7w4C7ILwqSzLafB9/8CxwhsIANZcBJoELDjHYON5cDQwlqXriDSKn2Q14wem6U
         CynjpZ4A2/H8qW9XN6UcfOUHVrH/WFLKZfLQUTilkI84+4dFHoVgtlZTdqnkdZMirvgN
         OLlUmlp5Wm2mrB1Gmr3KYq7DOhdP7BHGJB37g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UhoYD5NgEf4BoTnpIK3bxc26o2f3DMv5QYbRT9lyhY0=;
        b=HGxvOnva7yCIydQcGQifbGsz4Ez33FoK6M/pK1pugKc2jiHFek4bNV66+51RQlWujr
         HXgpFuA0gw3nWC0ZSxwXue0K/ktHf7VWQVLWzx10OaV/wadgSj8qpAaaqGrWdQhZjHxu
         dhaOuaPsZcUVVhnGGDXN/NJpDlQb/gF9UT9+scgqF+70q16sQ5cmPQZrBmFWs1lGU/cZ
         R3sSnBJof6U+/NL+U8a4OkOweZP6X1WVoUZVlG9+/OwM1JvQCgU6ZQTUw/MTtkWU2L2C
         jmO/slcSag0R4R3F+Aj8QTHUCPMkr/FnuZf02myuT7iDWZXSwosrUraDxz3l0gUxpvPf
         1yrg==
X-Gm-Message-State: AOAM5314/Zia2E+Wai7UVfgosxFDD2z9LuzjI9qo8l+niWPmxvZ/7UUV
        FNcwVZbYmo9niHiBfjh2KwrXAA==
X-Google-Smtp-Source: ABdhPJy/ZWQuZSLe/dkNz3Q11/wNxXdhcy1mjRjSeGuCv7THVpU48WmxfkQul3NL4GEqZ3CiA3JC7Q==
X-Received: by 2002:aa7:8f2f:0:b029:313:f1e6:d576 with SMTP id y15-20020aa78f2f0000b0290313f1e6d576mr4457944pfr.25.1625221398436;
        Fri, 02 Jul 2021 03:23:18 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b63b:3ac0:4dda:fdd2])
        by smtp.gmail.com with ESMTPSA id d13sm2863484pfn.136.2021.07.02.03.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 03:23:18 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        maoguang.meng@mediatek.com, yong.wu@mediatek.com
Subject: [PATCH v5 RESEND 2/3] dt-bindings: mediatek: Add mediatek, mt8183-jpgenc compatible
Date:   Fri,  2 Jul 2021 18:23:03 +0800
Message-Id: <20210702102304.3346429-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210702102304.3346429-1-hsinyi@chromium.org>
References: <20210702102304.3346429-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mediatek,mt8183-jpgenc compatible to binding document.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/media/mediatek-jpeg-encoder.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
index 5e35ecfd21f1b..fcd9b829e0366 100644
--- a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
@@ -17,6 +17,7 @@ properties:
     items:
       - enum:
           - mediatek,mt2701-jpgenc
+          - mediatek,mt8183-jpgenc
       - const: mediatek,mtk-jpgenc
   reg:
     maxItems: 1
-- 
2.32.0.93.g670b81a890-goog

