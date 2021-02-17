Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139DE31E0F0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 22:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhBQVAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 16:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhBQVAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 16:00:44 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEBAC061756
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 13:00:03 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v62so5105573wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 13:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HvaxP01fXW2011ehS9LhieDsJ7uIvVK/63xeZZP7Nq4=;
        b=dayfpS1ux0p+igYf4Zk1yTMOllrNLO8ZCTwTQ58p/4DKftJpBGledA0yS/1t+4PInP
         D4B3TD5BsTNUqumlY0NanLZJqnFNTksfM4SEE5IfyoqDhVTDool0AqneCHVEwB3vZ7gd
         bUlR478TF6GowcHnF5D9Lh0zdAe8KDs6sky7MOc5M9Nk83qvAAd1nh3573fSxJ5WKc7A
         7vobl7dTQiP092+d2fL1CHO469jDmoHfwaPPkOedIF80yTF76dOYtyX2JJofDEK7dusS
         9zq5D4yqV9Mt3HqpxqmGun3+3FJBfvrbisumg6j3lUOqdaVfD5/PUxZHQwElVM+xmmMf
         DoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HvaxP01fXW2011ehS9LhieDsJ7uIvVK/63xeZZP7Nq4=;
        b=UNDNrs1WSBp7zWwOUKYLHftkqMiul+VWoLddJwjURo6OdpQ+CEfx5Rur21P2aop+MG
         XK/D01XRI75sYloenEhxo6YSCRv7G1330+INipDvpjH7wwThePCftB0pHfEUvkH8/duT
         CQb61EVoxMmJrZKQNgDwefdFCJcxsVTl/d9/JWzAZLM8xx49DqLHB9KBHrYt9j/Xx5My
         cHKy7dDoHIAuDmFLnuJDbBGOEZF2CZSDBcI1+/4XU/ZyXl8WLnEIwvieviP4UpofmVlA
         LMlr3/K5wg5rYQSFAzii4Hg69jtAWQAIL8oM2FkNNPlKS49oRzhiLmYopRxyC0Y82l7I
         ln9w==
X-Gm-Message-State: AOAM530lREsIKuvoOVpJ4Zs5Lm9QefZkNHQ1R9mtLo2WLjXi3TTcWtYL
        iAO0sVj9HPw103EGGrlMKsLh8Q==
X-Google-Smtp-Source: ABdhPJxt/AxJFjVbv2FOJHM7b+QucXIKyT6iLc6VNmIhtakJ96SDtbVYTAi/dltJPvblGoY+aUmpSA==
X-Received: by 2002:a1c:7301:: with SMTP id d1mr597667wmb.33.1613595602384;
        Wed, 17 Feb 2021 13:00:02 -0800 (PST)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id m2sm4140264wml.34.2021.02.17.13.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:00:01 -0800 (PST)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     mkorpershoek@baylibre.com, Fabien Parent <fparent@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: arm64: dts: mediatek: Add mt8183-pumpkin board
Date:   Wed, 17 Feb 2021 21:59:43 +0100
Message-Id: <20210217205945.830006-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the MT8183 Pumpkin board.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 53f0d4e3ea98..8f5a625cfb3d 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -123,6 +123,10 @@ properties:
           - const: google,krane-sku176
           - const: google,krane
           - const: mediatek,mt8183
+      - items:
+          - enum:
+              - mediatek,mt8183-pumpkin
+          - const: mediatek,mt8183
 
 additionalProperties: true
 
-- 
2.30.0

