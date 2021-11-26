Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138DA45F093
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 16:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378083AbhKZP0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 10:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351972AbhKZPYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:24:34 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24D5C0613F6;
        Fri, 26 Nov 2021 07:17:40 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso10950395wmr.4;
        Fri, 26 Nov 2021 07:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+bFxhbi+YBOdMVe3lR8afDXUVB1LyZN9EknvfWnuqO4=;
        b=mkvudNPF7VhYVt3OaOIAEdEVP9/xN3txsrNbt2N/PNBtxwjicL+uesXe06jJs/nJTa
         I+t6D4QCrshuFBo/FLLTCpMxmyangJW6PmcAu7hiHX8Jydw+c8Du+zxbhfdNfsgD3rYR
         +e8Fu85w40PH0/8tUYK7kxJ08VqLuoqorrMxU5ccjp2mMGuNJZyLsLNCo12HXRhA0Ldu
         XeEXF8X9lXBR6HeZcjq6QY0rJGaRFweCdMODSpV6q7f3G9Kgf7oJrILkzQBUfvfuIbOi
         MhZ3ZtCsniUrirkTJrsLdNokgwHlasVmvJNzRJB1oORPNInNVdaN3tDyZoj0VdW+7lcV
         EE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+bFxhbi+YBOdMVe3lR8afDXUVB1LyZN9EknvfWnuqO4=;
        b=JKBPLX2/MdXW0J4BEDBryp0P9aj5w/HJOjcqjJAlrennsXvavEoBTj/XeyKVcE/Xtk
         clDZcbIP+dohBavhKi16/C6VOuFD6PnbvYg/pLe/7D8ZPbFGGzizVw8qAZ+I+1s1pw7Q
         pQC9ccCjGAHg4l2OHkhp8nElERxq2VO9yoYMC8yS4eID3PlkOHn0SR5HVxHEY9gbB53d
         RlBhS9Z4gYOOn12xKJTZo3tnZ4ytisr1vZoD3LS2I3dWzWBUrgPkLApkoF7T99yOt8tj
         NXgIAMmS+uWJB6WfhS4DbwXHAafBAJ0Ls6E3MdUGL31Gu+dFg0NQEIYYGH+N+f8tbpjI
         diXw==
X-Gm-Message-State: AOAM5330k4GDMfKk/sr/NLH4msULYa/dTBtgTy432N1kdYBPYrhpBA2r
        eyIkTi3/DWSXYTJw4T2cWw==
X-Google-Smtp-Source: ABdhPJyGQtejEAreYJ4YBr09uEGV/yHcZX3kTWvoWliGGupW6SpIbPKgCZQDD0PhTWt9WmnOjZgT6g==
X-Received: by 2002:a7b:ce16:: with SMTP id m22mr15743639wmc.39.1637939859270;
        Fri, 26 Nov 2021 07:17:39 -0800 (PST)
Received: from alex-ThinkPad-E480.. (ip5b435a69.dynamic.kabel-deutschland.de. [91.67.90.105])
        by smtp.googlemail.com with ESMTPSA id k187sm12323496wme.0.2021.11.26.07.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 07:17:38 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 1/4] dt-bindings: gpu: mali-bifrost: Allow up to two clocks
Date:   Fri, 26 Nov 2021 16:17:26 +0100
Message-Id: <20211126151729.1026566-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211126151729.1026566-1-knaerzche@gmail.com>
References: <20211126151729.1026566-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b681af0bc1cc ("drm: panfrost: add optional bus_clock")
added an optional bus_clock to support Allwinner H6 T-720 GPU.
Increase the max clock items in the dt-binding to reflect this.

Bifrost GPU in Rockchip RK3568 SoCs also has a core and a bus clock
and it gets added here in a (very) similar way it was done for
allwinner,sun50i-h6-mali compatible in arm,mali-midgard binding.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 .../bindings/gpu/arm,mali-bifrost.yaml        | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index 6f98dd55fb4c..2849a7a97d73 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -39,7 +39,14 @@ properties:
       - const: gpu
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: core
+      - const: bus
 
   mali-supply: true
 
@@ -118,6 +125,17 @@ allOf:
         power-domains:
           maxItems: 1
         sram-supply: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3568-mali
+    then:
+      properties:
+        clocks:
+          minItems: 2
+      required:
+        - clock-names
 
 examples:
   - |
-- 
2.30.2

