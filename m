Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B83D41D099
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 02:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347450AbhI3Agv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 20:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347232AbhI3Agt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 20:36:49 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2C8C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 17:35:07 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id w19so3386697pfn.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 17:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AgZhYHdye54r6ShDoaQFSdXhndbZUW3v28dxdpS3Tao=;
        b=oQgFAPuw89Z0XQftMMhBeGuniB6bE/9874lJytDJkWt+kezg72K+gksvMmV88OIEuM
         Eyy3WSWdxU+gnWEx70j38/t7N7wyShxBNzbSNjZXozje94sq5QwoiSqqm20aTpSQSKdC
         1N7sBCXf5Ws0kgBHUhcO5tDWZfQ/LKM9qch9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AgZhYHdye54r6ShDoaQFSdXhndbZUW3v28dxdpS3Tao=;
        b=LpL4IDmG1F+L0qOKVaSl4nL+LKOQdqfYA++m+YKC1+UEwORxhzIKB5ONBbvWYr9nw5
         Ae2I8NTkZJj5HGbqjSmYVDhffI+AkbK5Fk2wc+3yaUyEnyQ7FdBuyGHZyEJwCLliQImG
         90oDNfDJB8qv6NYcvt6EHc77g1MfaSOyuwODC2IiSBrMM3tnxhSYIMw0esyO2bF7Dy/B
         iY5XrhvPBIkb+47oet3+bnEmebTuCy5O3SMVduoYoTGt8OGMpEH+WMeALiHLWOrhIiwO
         SOSsHGz+NUy9fFn24zdjKdssbJQo8AVwXUlbHC2MKerG6MNiqnoD6FFvFFiD9ZxUI1fC
         LLKg==
X-Gm-Message-State: AOAM530rLGzd2jLwOJFv4CHg9C6TA8bL4cAqhv9yJeSLiEvjFCHB9KV9
        eq006C8DkwELAQ+A44fCoL9W6dXlISdqSg==
X-Google-Smtp-Source: ABdhPJxR9ohnQ+FXvrOlYtUk9aMrDtETY39YyKk7EZ+OawfXb0zWBw1TSfoVQJOrNHv1XXkZlynECA==
X-Received: by 2002:aa7:8f01:0:b0:447:8167:46c1 with SMTP id x1-20020aa78f01000000b00447816746c1mr1529882pfr.30.1632962106583;
        Wed, 29 Sep 2021 17:35:06 -0700 (PDT)
Received: from philipchen.mtv.corp.google.com ([2620:15c:202:201:b6b6:ed63:b801:ded7])
        by smtp.gmail.com with ESMTPSA id 23sm711648pgk.89.2021.09.29.17.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 17:35:06 -0700 (PDT)
From:   Philip Chen <philipchen@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org, swboyd@chromium.org,
        Philip Chen <philipchen@chromium.org>,
        Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/3] dt-bindings: drm/bridge: ps8640: Add aux-bus child
Date:   Wed, 29 Sep 2021 17:34:57 -0700
Message-Id: <20210929173343.v2.2.I6050ba184b24d887e92692a72ee3054d643d6091@changeid>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210929173343.v2.1.Ib7e63ae17e827ce0636a09d5dec9796043e4f80a@changeid>
References: <20210929173343.v2.1.Ib7e63ae17e827ce0636a09d5dec9796043e4f80a@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dp-aux-bus.yaml says we can list an eDP panel as a child of
an eDP controller node to represent the fact that the panel
is connected to the controller's DP AUX bus.

Let's add it to the ps8640 bindings.

Signed-off-by: Philip Chen <philipchen@chromium.org>
---

(no changes since v1)

 .../bindings/display/bridge/ps8640.yaml       | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/ps8640.yaml b/Documentation/devicetree/bindings/display/bridge/ps8640.yaml
index fce82b605c8b..cdaf7a7a8f88 100644
--- a/Documentation/devicetree/bindings/display/bridge/ps8640.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ps8640.yaml
@@ -40,6 +40,9 @@ properties:
   vdd33-supply:
     description: Regulator for 3.3V digital core power.
 
+  aux-bus:
+    $ref: /schemas/display/dp-aux-bus.yaml#
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
 
@@ -98,7 +101,21 @@ examples:
                     reg = <1>;
                     ps8640_out: endpoint {
                         remote-endpoint = <&panel_in>;
-                   };
+                    };
+                };
+            };
+
+            aux-bus {
+                panel {
+                    compatible = "boe,nv133fhm-n62";
+                    power-supply = <&pp3300_dx_edp>;
+                    backlight = <&backlight>;
+
+                    port {
+                        panel_in: endpoint {
+                            remote-endpoint = <&ps8640_out>;
+                        };
+                    };
                 };
             };
         };
-- 
2.33.0.685.g46640cef36-goog

