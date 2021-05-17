Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC233865F5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 22:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238442AbhEQULU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 16:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236950AbhEQULI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 16:11:08 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C6DC061761
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 13:09:50 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n3so3797427plf.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 13:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ibC0JQ1noBgZMhZpAkhp6+LWFKsRlOrZ8j0drDGOJUc=;
        b=WuNlzNsceu7te8upmYnD24kk4Zbrbvf7LBNU1IGaOZTNfldtXzy8SP5gxoJmy31Ztw
         WqEQK49yIrFEDP5WcTNE1gQVxI2bG2TMmxPeQQGgwqNPO9i1CziftTYOrUqT4zaaon7n
         m3/NL/6XIwHL0CmYhCmu/ETlm0QbHatWt1e9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ibC0JQ1noBgZMhZpAkhp6+LWFKsRlOrZ8j0drDGOJUc=;
        b=ExfHBlIwzB7neG/KllAb3i3ZTHbd5rAYnhq0hUDioGmYt+1RLvv6o+obZ75DjxKeU8
         gC3jOsADIl+KUd6CBEx7digxa22FJ/a0s/n54bRVANUm+kssS3u7oz9Sza2DKIca+o9J
         kstxSxL7CQTCItqf2500xZNs+l665iXDau0ddKgP3g/s9gTtNrcjMPIYUHKilRICzfG+
         67o5TzwNZrGK57Hmi+OtciQxNcQ6FPyd8Q83nCpc9UCW3GrRUYZ/Lvfgn1MC4ikJhTL3
         V882MNZbCv99L7GcEh0ZpEXe3KxnK2Y+Zgx/M0FZ+g/P4trA30wCNyrHw4ECqmSEpQpm
         7L/w==
X-Gm-Message-State: AOAM5320cScWcCF0gk+rLtFLOkx1O2OmT/2Wi5x/b2HhB9x3tB1QPuw9
        +eGFQg1eY0A0fHpiAB9QPi4H5Q==
X-Google-Smtp-Source: ABdhPJzFA78VI2ZxClv8Expyof7VKru3oLqIN3yVSmvQaS6IsPGGiLHBrJQRCZ1MDayUfdlmXlfQsA==
X-Received: by 2002:a17:90b:1bd2:: with SMTP id oa18mr1241491pjb.72.1621282190331;
        Mon, 17 May 2021 13:09:50 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:bc91:c597:ded0:7930])
        by smtp.gmail.com with ESMTPSA id x19sm9078941pgj.66.2021.05.17.13.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 13:09:49 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Thierry Reding <treding@nvidia.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linus W <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, robdclark@chromium.org,
        Steev Klimaszewski <steev@kali.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Panda <spanda@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 03/10] dt-bindings: drm/bridge: ti-sn65dsi86: Add aux-bus child
Date:   Mon, 17 May 2021 13:09:00 -0700
Message-Id: <20210517130450.v7.3.I98bf729846c37c4c143f6ab88b1e299280e2fe26@changeid>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
In-Reply-To: <20210517200907.1459182-1-dianders@chromium.org>
References: <20210517200907.1459182-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to be able to list an eDP panel as a child of a ti-sn65dsi86
node to represent the fact that the panel is connected to the bridge's
DP AUX bus. Though the panel and the bridge chip are connected in
several ways, the DP AUX bus is the primary control interface between
the two and thus makes the most sense to model in device tree
hierarchy.

Listing a panel in this way makes it possible for the panel driver to
easily get access to the DP AUX bus that it resides on, which can be
useful to help in auto-detecting the panel and for turning on various
bits.

NOTE: it's still possible to continue using the bridge chip and point
to a panel that _isn't_ listed as a child of the bridge chip (since
it's worked that way previously), but that should be deprecated since
there is no downside to listing the panel under the bridge chip.

The idea for this bus's design was hashed out over IRC [1].

[1] https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&date=2021-05-11

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Possibly we might want something fancier that could be included by
other eDP controller bindings. If we want to do this, I'd love to be
pointed at a good example to follow.

Changes in v7:
- ti-sn65dsi86: Add aux-bus child patch new for v7.

 .../bindings/display/bridge/ti,sn65dsi86.yaml | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
index 26932d2e86ab..51f5a29e216c 100644
--- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
@@ -70,6 +70,11 @@ properties:
     const: 1
     description: See ../../pwm/pwm.yaml for description of the cell formats.
 
+  aux-bus:
+    description:
+      It is recommended that you place your panel under the aux-bus node
+      here to represent the control hierarchy.
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
 
@@ -201,11 +206,26 @@ examples:
 
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
2.31.1.751.gd2f1c929bd-goog

