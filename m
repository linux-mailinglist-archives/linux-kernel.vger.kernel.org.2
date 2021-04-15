Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D388B3605E7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhDOJf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbhDOJfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:35:53 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E47CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:35:30 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id r13so7990365pjf.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8nK9tfz3NVekxo0c4TpGRd2q1g2g0nUPwHfUPo4fv7U=;
        b=d+H0aUou1mmX8YmV9TXJKHFFrAikaPsf0u0BJxftbdF94VgnyL7ojpDzqXFYzTEc7D
         Ttdk9zcoWolsXWeG/UCWTRcFUVyEXC/Hx2CbqXeZjDCFZr42CSPMdKDirRd5GYDl+eDE
         Y/5LjvYRJcB9vdq8c3b4FFTh4I9p/PibiCng4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8nK9tfz3NVekxo0c4TpGRd2q1g2g0nUPwHfUPo4fv7U=;
        b=Uz710E/MB1BXKGCWUcaRL71leXrX3gm2fWC1XQjbFNMKGxf3oi8CXo9nXdKT51DXQF
         080EnX94QM50MAPyPEw1nSrMJL3TlUlW55MZl4pA66qx+SQVl8kW043HxivYCluP/PfU
         TOiAG8M0NBrwnOJLMYEkCknpbYQD5FhGMiabI6L+vElGG5dIag+Prub/zP1VttW8U1qC
         NqWXnQLb4EjKxeKnY45wHBmX4qG/qgUBXVJkNtRFI/k2oAkODVVahY2e3cCCYEpJESaa
         hgGEJupPBaEFRkkl/vL6FGrODpruta1q/rT9LMmgRbON/olIQgOhfD69ehyowMvDpsFp
         6ATw==
X-Gm-Message-State: AOAM5320jTZbNmvE+RD6WVxdSpbRejjqwaCM07SvxVQ6RXtWbqvIa/O9
        QbvisTd0cLmd09SlregwqDYG/g==
X-Google-Smtp-Source: ABdhPJz8kFU5VfkPAeCLfeTkC6GhBXLlvbYC5C3lJFMiqzy47wA3ye0Sw2vDePOkEKm9vP1kxREt4A==
X-Received: by 2002:a17:90a:fb4c:: with SMTP id iq12mr2869691pjb.121.1618479330163;
        Thu, 15 Apr 2021 02:35:30 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:6432:a6cb:91d2:5e32])
        by smtp.gmail.com with ESMTPSA id a13sm1849502pgm.43.2021.04.15.02.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 02:35:29 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 4/8] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-kenzo
Date:   Thu, 15 Apr 2021 17:35:15 +0800
Message-Id: <20210415093519.1920877-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210415093519.1920877-1-hsinyi@chromium.org>
References: <20210415093519.1920877-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kenzo is known as Acer Chromebook 311.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 0870490aa350..39e4a99ebb37 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -137,9 +137,11 @@ properties:
         items:
           - const: google,damu
           - const: mediatek,mt8183
-      - description: Google Juniper (Acer Chromebook Spin 311)
+      - description: Google Juniper (Acer Chromebook Spin 311) / Kenzo (Acer Crhomebook 311)
         items:
-          - const: google,juniper-sku16
+          - enum:
+              - google,juniper-sku16
+              - google,juniper-sku17
           - const: google,juniper
           - const: mediatek,mt8183
       - description: Google Kakadu (ASUS Chromebook Detachable CM3)
-- 
2.31.1.295.g9ea45b61b8-goog

