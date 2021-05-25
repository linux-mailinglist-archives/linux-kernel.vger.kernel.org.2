Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6336A38F6B3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 02:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhEYAEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 20:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhEYAEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 20:04:12 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F9FC06138B
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 17:02:41 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id c12so10582540pfl.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 17:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=frU/MIzwrtJawHtHpJ2wMhHOm//TNBEwf1FFx7azP48=;
        b=RmPVDYwmFaVUEaUke1HUVctixj/lUivUYphXkuYDtAk2my9OzGNqfTwHBMTLZMNOpk
         FThVamNIUDasehzHdFesXrMfpwPU/okm50gJ8OvAN9rDUM0qs9FXPfeR9vSh50LvQc48
         d5KOkGBjoOibcmUz6TNVaZHIQBk3BKVIvqTk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=frU/MIzwrtJawHtHpJ2wMhHOm//TNBEwf1FFx7azP48=;
        b=q24eeJ9b04UE9u2vMQMEv4y6119tblLtZuF0pHTX77V+PkBWV023bKCJcALE1FLiBI
         SNjn6n2D4adZGGdYNWJtxY5aiA1EIq/SQweHOFsunktsG1tKp2+32+chMHYFL7nH3N+f
         TIuOW8XOI4iRUJ3+QvUAjtPHs9/a6m/WIfhp35665/Bpc0TsPnkIZblbjsOtBwBiR+7v
         MJhSBgsE1g+Rzu/rtNeZaPbRNzS+yfpMmNSqanRC6PXTHUX3axGRkOf29xlRkh5HDCbp
         ePqZZESqpsaDRJ7QNFiKIrqbxPSg7+6Xc5v/gVejEXOvjJ5JEoSPcaJRnL9GDvRGAos2
         767Q==
X-Gm-Message-State: AOAM531/CdoYEedeqZRE1ryNQ7bbZmg93w6IUIdeB1YKBm7hat6/DvM/
        nknW4l1VvOKzRxk9tMu3Ms+zqg==
X-Google-Smtp-Source: ABdhPJz7TwoVvVpbGA4bqbTOwnQj4Q0UDCsunLiUBQEUrWd8K6cpvy/AslaHNQRurgVp+feNQF2Vow==
X-Received: by 2002:aa7:8201:0:b029:27b:9b59:8676 with SMTP id k1-20020aa782010000b029027b9b598676mr26655853pfi.47.1621900961353;
        Mon, 24 May 2021 17:02:41 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:26d1:4df0:7cdf:ce13])
        by smtp.gmail.com with ESMTPSA id f18sm10696741pjh.55.2021.05.24.17.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 17:02:41 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-arm-msm@vger.kernel.org, Linus W <linus.walleij@linaro.org>,
        Lyude Paul <lyude@redhat.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Steev Klimaszewski <steev@kali.org>, robdclark@chromium.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thierry Reding <treding@nvidia.com>,
        dri-devel@lists.freedesktop.org,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Panda <spanda@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 03/11] dt-bindings: drm/bridge: ti-sn65dsi86: Add aux-bus child
Date:   Mon, 24 May 2021 17:01:51 -0700
Message-Id: <20210524165920.v8.3.I98bf729846c37c4c143f6ab88b1e299280e2fe26@changeid>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
In-Reply-To: <20210525000159.3384921-1-dianders@chromium.org>
References: <20210525000159.3384921-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch ("dt-bindings: drm: Introduce the DP AUX bus") talks about
how using the DP AUX bus is better than learning how to slice
bread. Let's add it to the ti-sn65dsi86 bindings.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v8:
- ti-sn65dsi86 references the new aux bus bindings.

Changes in v7:
- ti-sn65dsi86: Add aux-bus child patch new for v7.

 .../bindings/display/bridge/ti,sn65dsi86.yaml | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
index 26932d2e86ab..4007f36d04ba 100644
--- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
@@ -70,6 +70,9 @@ properties:
     const: 1
     description: See ../../pwm/pwm.yaml for description of the cell formats.
 
+  aux-bus:
+    $ref: ../dp-aux-bus.yaml#
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
2.31.1.818.g46aad6cb9e-goog

