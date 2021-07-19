Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58273CEDBF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386860AbhGSTls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 15:41:48 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:37415 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385781AbhGSTJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 15:09:27 -0400
Received: by mail-io1-f45.google.com with SMTP id r18so10265201iot.4;
        Mon, 19 Jul 2021 12:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aG3jRlbPN2vUwxCTM7m5lg6AuY6gMHA+0U8gF5Ougek=;
        b=k7d20Gc19RjMDalMSpw9xY6w3shoKMmuV/hehrScftjL0wk8OxRtVKR8f/MRX0LoDO
         t9EMw+GwXDGkSl6wWdlhndFkzdb5BsF8CnUZ9ebBliq0KgbjIQnaHiggC9ljhMvekt4z
         H60Q58sgHEbeL6gwwSl33KfyxcOX0uACKq6klsFDO9lB9yhfzwe3Inz+FQOfhCgnh/l5
         xAsVT24+hClY5wh2NO/xF9kZaq+5zfdSOsxjVrt1UqREKe+Ha1PJ/czOkqhE1rTkRRj2
         RjXYrJVV+Wpipcirgls6tno7FZck1MmA1HEhbOVmmnQVC21Fmm6eloARR8Gdlkfi/PIT
         1kVA==
X-Gm-Message-State: AOAM533phOFaHSSRX28gfR5BXQbaklCBVKbk6PafXrcR2tXs71poAwtI
        JwI3kgEtftzVrI36BU6ObzVEiVbB+w==
X-Google-Smtp-Source: ABdhPJzYjU7X6oo+Ckis+hbPzMu6oq0X2BoiJ+rZT/hptX49jmi/YaKeQBNle+ttKv8qObNGowKU8g==
X-Received: by 2002:a05:6602:59d:: with SMTP id v29mr9469036iox.132.1626724205186;
        Mon, 19 Jul 2021 12:50:05 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id g22sm10898287ion.10.2021.07.19.12.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 12:50:04 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marek Vasut <marex@denx.de>,
        Krishna Manikandan <mkrishn@codeaurora.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] dt-bindings: display: Fix graph 'unevaluatedProperties' related warnings
Date:   Mon, 19 Jul 2021 13:50:01 -0600
Message-Id: <20210719195001.2412345-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The graph schema doesn't allow custom properties on endpoint nodes for
'#/properties/port' and '#/$defs/port-base' should be used instead. This
doesn't matter until 'unevaluatedProperties' support is implemented.

Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Marek Vasut <marex@denx.de>
Cc: Krishna Manikandan <mkrishn@codeaurora.org>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/display/bridge/ti,sn65dsi83.yaml    | 6 ++++--
 .../bindings/display/msm/dsi-controller-main.yaml           | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
index d101233ae17f..07b20383cbca 100644
--- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
@@ -37,7 +37,8 @@ properties:
 
     properties:
       port@0:
-        $ref: /schemas/graph.yaml#/properties/port
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
         description: Video port for MIPI DSI Channel-A input
 
         properties:
@@ -57,7 +58,8 @@ properties:
                   - const: 4
 
       port@1:
-        $ref: /schemas/graph.yaml#/properties/port
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
         description: Video port for MIPI DSI Channel-B input
 
         properties:
diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 76348b71f736..de23cab9b5f1 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -77,7 +77,8 @@ properties:
 
     properties:
       port@0:
-        $ref: "/schemas/graph.yaml#/properties/port"
+        $ref: "/schemas/graph.yaml#/$defs/port-base"
+        unevaluatedProperties: false
         description: |
           Input endpoints of the controller.
         properties:
@@ -92,7 +93,8 @@ properties:
                   enum: [ 0, 1, 2, 3 ]
 
       port@1:
-        $ref: "/schemas/graph.yaml#/properties/port"
+        $ref: "/schemas/graph.yaml#/$defs/port-base"
+        unevaluatedProperties: false
         description: |
           Output endpoints of the controller.
         properties:
-- 
2.27.0

