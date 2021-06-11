Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E1E3A47BF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 19:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhFKRVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 13:21:07 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:46032 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbhFKRVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:21:05 -0400
Received: by mail-pf1-f178.google.com with SMTP id d16so4954091pfn.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 10:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iNt+OGJw9beffEtpBGTCu3+ysNF07AUPG7fXgLPAxNk=;
        b=KvcuA9MoUxl9ScP1xT12a2JoVbNPCXjFYHbFVn39RBDclYDN4NsOHPtu3RxGU5L+ml
         iyn6EcBshka8D6BkaKAE8rnnJbMy2F4ZLFvyYl+oAvzXW88V28FOLw8tlWDe29KUMUvy
         3uA1P5sRvzdvMmiq4SCx67LcV3CfQCRt4riB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iNt+OGJw9beffEtpBGTCu3+ysNF07AUPG7fXgLPAxNk=;
        b=bv8yMc3AVreV1LV2Bls6W+dreVoaLjwrEroFvTkhzpEo3c9C5zHzhjLB/UpnmLrh3y
         CR9tdOEJWy0hCfhc5GxGTW4LCG6fVGWvIwAW0BvblEeRN03FjIeEu/5qFJYaELxnC7Nd
         eR0GZhgFSjjxKxtM5DRlCx8bomZ/Wi09XHC0tKL/jPbL4/3WY/U6mnoDqR98c8vwndah
         6+w3hPCV3NPo5xKiCaexZmvxfyIjYa857m3qN3mF96yR4BY1tVBS5wu6hOz+37SvL29I
         Z8af93/FrWT+ofCdDyr/i2RIWxZba9gzFtSDlYpw++P0Z9eoiHDLNzgcGgSOoAHFOQsJ
         VbFw==
X-Gm-Message-State: AOAM530tFanT7OLHtULieWWx1Ho0T7+hxYoVX9Lew5r8eGqZjkeixgmj
        Y9eXDolWHQuI8QgONIY/yuCv9A==
X-Google-Smtp-Source: ABdhPJyF9EzM22Lo3EZWBnffeRG8IlVmb5QHhK1YOl5v2N6AOcQD2QDRQvoQTUNeAaxV/BhbCTkjAg==
X-Received: by 2002:a63:b54:: with SMTP id a20mr4696491pgl.407.1623431887764;
        Fri, 11 Jun 2021 10:18:07 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:4128:5428:5cd0:cfa5])
        by smtp.gmail.com with ESMTPSA id f17sm5837850pgm.37.2021.06.11.10.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 10:18:07 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Steev Klimaszewski <steev@kali.org>,
        Linus W <linus.walleij@linaro.org>, robdclark@chromium.org,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Panda <spanda@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 03/11] dt-bindings: drm/bridge: ti-sn65dsi86: Add aux-bus child
Date:   Fri, 11 Jun 2021 10:17:39 -0700
Message-Id: <20210611101711.v10.3.I98bf729846c37c4c143f6ab88b1e299280e2fe26@changeid>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210611171747.1263039-1-dianders@chromium.org>
References: <20210611171747.1263039-1-dianders@chromium.org>
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
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---

(no changes since v9)

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
2.32.0.272.g935e593368-goog

