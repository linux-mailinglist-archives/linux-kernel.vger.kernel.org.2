Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04DB38832C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 01:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240027AbhERXam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 19:30:42 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:43727 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239043AbhERXa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 19:30:28 -0400
Received: by mail-oi1-f179.google.com with SMTP id j75so11394942oih.10;
        Tue, 18 May 2021 16:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kaw4fdxwXpH2Tc4Crz2ymu7i5j1xi8qpQ3DL7swjbB8=;
        b=Hy8sFdRpLoqNcpm9kMsE+KBYPHSy3yEOceOjy8VoDrZ6BkL/muLeQOpF6S10mRQF7o
         IMtcqqjx22XGXhKT7so84KiHBL1VKuT9WyjnetbxrZtFV04vBmtEGJ4lENXUz7U+WZUR
         7SBdQL9Ki4BLQ1cmJR4AepcEcGHXe+9BpqsgAkw1vp4pVuPVa1VJFb2oU+XF/YlviL6a
         KBiDTXxA/4cYTI+yejwU2kZHbBTGiUQz4xp9SkQicDIfVaAlE3WzmaI5/5UcsS65m7If
         Wam0L7hcVGY276HRpxuQHrnOSzsf0xOI+fp8JXvNkSLDdZUHCagcufn5WHGQnwQKx+zZ
         rEmA==
X-Gm-Message-State: AOAM532G56tQD6bjwmDPDFWXB4L2OfIw5XhUj4v62j8Mgc0iX4EbB+Gy
        sR38TIzEHgDyiqdEELB1G9Qjn8VDrA==
X-Google-Smtp-Source: ABdhPJzy60bW7jOMP9l8J926xwD2kkYdNKYxJ1XI45JCGcle3eCUzwPiB4MH9mB5QK0S2q3fYst8pw==
X-Received: by 2002:a05:6808:184:: with SMTP id w4mr5599516oic.27.1621380549000;
        Tue, 18 May 2021 16:29:09 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id d19sm3985608oop.26.2021.05.18.16.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 16:29:08 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Roger Quadros <rogerq@ti.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 6/6] dt-bindings: i2c: maxim,max9286: Use the i2c-mux.yaml schema
Date:   Tue, 18 May 2021 18:28:58 -0500
Message-Id: <20210518232858.1535403-7-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210518232858.1535403-1-robh@kernel.org>
References: <20210518232858.1535403-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the i2c-mux.yaml schema in the maxim,max9286 binding schema. With this,
several properties can be dropped as they are defined in i2c-mux.yaml
already.

Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/media/i2c/maxim,max9286.yaml     | 23 +++----------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/maxim,max9286.yaml b/Documentation/devicetree/bindings/media/i2c/maxim,max9286.yaml
index ee16102fdfe7..02f656e78700 100644
--- a/Documentation/devicetree/bindings/media/i2c/maxim,max9286.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/maxim,max9286.yaml
@@ -111,17 +111,10 @@ properties:
 
   i2c-mux:
     type: object
+    $ref: /schemas/i2c/i2c-mux.yaml#
+    unevaluatedProperties: false
     description: |
-      Each GMSL link is modelled as a child bus of an i2c bus
-      multiplexer/switch, in accordance with bindings described in
-      Documentation/devicetree/bindings/i2c/i2c-mux.txt.
-
-    properties:
-      '#address-cells':
-        const: 1
-
-      '#size-cells':
-        const: 0
+      Each GMSL link is modelled as a child bus of an i2c bus multiplexer/switch.
 
     patternProperties:
       "^i2c@[0-3]$":
@@ -133,12 +126,6 @@ properties:
           channels.
 
         properties:
-          '#address-cells':
-            const: 1
-
-          '#size-cells':
-            const: 0
-
           reg:
             description: The index of the GMSL channel.
             maxItems: 1
@@ -173,10 +160,6 @@ properties:
 
             additionalProperties: false
 
-        additionalProperties: false
-
-    additionalProperties: false
-
 required:
   - compatible
   - reg
-- 
2.27.0

