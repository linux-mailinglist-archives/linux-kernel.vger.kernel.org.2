Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EDB39E4D5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhFGRIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhFGRIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:08:22 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38696C0617A8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 10:06:20 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x73so13561573pfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 10:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J9FgQRQtT4dalpWmq/48llm03TZOe/GpH8sEg+4A3jk=;
        b=k15oyF/xyFQ+soSSAB1x/F/6ifpZGu+DCxVJPHOpM4hlTCkESHm4H7VrXK55ugz1Kx
         b8O46MJJrNDRsck8ZwLg2LdbC3EAhzWr6gEIUlKdJUwks2KjhZODrQDuyMcFB+TRIwdo
         xlOJCnuphuA3ES52yqbALNnW2NmauosxvqbqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J9FgQRQtT4dalpWmq/48llm03TZOe/GpH8sEg+4A3jk=;
        b=npQQ1dBzMeJQ4voxilmwgIa54plvljxWclkkOzO25eUxyQMQlQGkHmajjdy/vb5VNT
         IMJEe4SNheICOYqTWJDyKFY8B9wCgSRg0gs8tDW+UWTAmEUf82h3/hxrdSWfQsZeDxYu
         CjO4LIzfx4yiZMIFUC2KzYYXOGF1FbL8g4UOxejbmYN/Dq9aydLmMqS9/LzJ2AnngQNJ
         ixdR6Uw+lbmn0YmVGYP9+/abooFpvrdVWPCA3aWkkMmw9TQMSmfOXWXaayXS3Xt+xHMa
         sZJc4ETHMeZ/pFzADHepXMj0/eGTSbMRgE1lLQoBp4Q3Xe93BES75xgIWGhJnoIHY003
         evCQ==
X-Gm-Message-State: AOAM530nfYnWph9JHTjhaK9qqUqRGza0sJTwV0Et+sjyeymTiRp1lOGa
        dOwkh/PclkzWxpJlMk1K+qkHWg==
X-Google-Smtp-Source: ABdhPJxtsUrJ7UTc1mTykx5JqbbNLPl0sLEmHpUiXzkbYZI/m3P1wxuqgg9R4R9yyRcZtQZKa3p18w==
X-Received: by 2002:a63:3e4e:: with SMTP id l75mr18010152pga.10.1623085579742;
        Mon, 07 Jun 2021 10:06:19 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:f656:ffce:6348:a42a])
        by smtp.gmail.com with ESMTPSA id fs24sm12897639pjb.6.2021.06.07.10.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 10:06:19 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Linus W <linus.walleij@linaro.org>, robdclark@chromium.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Panda <spanda@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 03/11] dt-bindings: drm/bridge: ti-sn65dsi86: Add aux-bus child
Date:   Mon,  7 Jun 2021 10:05:47 -0700
Message-Id: <20210607100234.v9.3.I98bf729846c37c4c143f6ab88b1e299280e2fe26@changeid>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
In-Reply-To: <20210607170555.4006050-1-dianders@chromium.org>
References: <20210607170555.4006050-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch ("dt-bindings: drm: Introduce the DP AUX bus") talks about
how using the DP AUX bus is better than learning how to slice
bread. Let's add it to the ti-sn65dsi86 bindings.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v9:
- Use an absolute path to refer to aux-bus schema.

Changes in v8:
- ti-sn65dsi86 references the new aux bus bindings.

Changes in v7:
- ti-sn65dsi86: Add aux-bus child patch new for v7.

 .../bindings/display/bridge/ti,sn65dsi86.yaml | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
index 26932d2e86ab..12b876a20574 100644
--- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
@@ -70,6 +70,9 @@ properties:
     const: 1
     description: See ../../pwm/pwm.yaml for description of the cell formats.
 
+  aux-bus:
+    $ref: /schemas/display/dp-aux-bus.yaml#
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
 
@@ -201,11 +204,26 @@ examples:
 
           port@1 {
             reg = <1>;
-            endpoint {
+            sn65dsi86_out: endpoint {
               remote-endpoint = <&panel_in_edp>;
             };
           };
         };
+
+        aux-bus {
+          panel {
+            compatible = "boe,nv133fhm-n62";
+            power-supply = <&pp3300_dx_edp>;
+            backlight = <&backlight>;
+            hpd-gpios = <&sn65dsi86_bridge 2 GPIO_ACTIVE_HIGH>;
+
+            port {
+              panel_in_edp: endpoint {
+                remote-endpoint = <&sn65dsi86_out>;
+              };
+            };
+          };
+        };
       };
     };
   - |
-- 
2.32.0.rc1.229.g3e70b5a671-goog

