Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD773350E74
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 07:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhDAFcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 01:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbhDAFcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 01:32:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76025C0613E6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 22:32:07 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id o2so451765plg.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 22:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EGCaNYuJs5ysS+G47sBAgFfeBuakOnmZVc6UOW7pnu8=;
        b=H4LMh6naKuD9jE1jgXbD+Y6im6xj6SrczGVRGFyo2QjAV8r/Jzu0IWlYhmxqsaovAe
         POh3cEIv5YtAJ9THgZPkjIual8JLUsh0XWwWlZTlBxVvdFSz5My3Z0YxGhRJUjkaMGuX
         ZN1jamFCfnnYkzUq7QDx8/ngukUjepeiKGEKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EGCaNYuJs5ysS+G47sBAgFfeBuakOnmZVc6UOW7pnu8=;
        b=i1cfXM7rGEzZ2/5XOI9gvn3XTP/0LkioIizw3HyB/M/9+Z/VpST7rtxPyI8aZzQj6s
         dNOUht82A27KpHXrAfb6OIt54QuPYIclMYR6eBaiFKalKiiuN2VJB7/pBgvKIb8Y0AK/
         WyT1QJ2MFghFWg01crz7bIZua0g2wTe9AySCyEuYJle78o5y8qalbhP2wSfgWXtDg5sC
         NK+a6iUfY3jdR6VZa+DQCTgNqa+gUUj8CVdsOBY8/3YVmW5ZSIdHtiWcPI2hrvphN1ot
         vmdEilOOJVvjAkTQNxxXv4ln0B0XIn4THq0vjglpNxeuP2lL+QIjDQIEVlwdDcOME5Mo
         8Jeg==
X-Gm-Message-State: AOAM533wpEN8yRTf1hL4JwLDqjrqhWeFTIgJkBN+oEQ6CrVPf65fGxBj
        AHKAUrNmvryQga24iKqluWbwbA==
X-Google-Smtp-Source: ABdhPJze72R8x10Uwimtp/vAMjJ5lbZAFSGzBuvIY68rbCBL5/iz4VkpPs1KdmUR01pqLTvYeVHPSw==
X-Received: by 2002:a17:90a:2e0d:: with SMTP id q13mr7361084pjd.225.1617255126907;
        Wed, 31 Mar 2021 22:32:06 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:8730:fe8e:d1f8:82c])
        by smtp.gmail.com with ESMTPSA id mz11sm3990058pjb.6.2021.03.31.22.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 22:32:06 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org
Cc:     Robert Foss <robert.foss@linaro.org>,
        David Airlie <airlied@linux.ie>, Xin Ji <xji@analogixsemi.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [RESEND PATCH v4 1/2] dt-bindings: drm/bridge: anx7625: Add power supplies
Date:   Thu,  1 Apr 2021 13:32:01 +0800
Message-Id: <20210401053202.159302-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

anx7625 requires 3 power supply regulators.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Robert Foss <robert.foss@linaro.org>
---
v3->v4: rebase to drm-misc/for-linux-next
---
 .../bindings/display/bridge/analogix,anx7625.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
index c789784efe306..ab48ab2f4240d 100644
--- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
@@ -34,6 +34,15 @@ properties:
     description: used for reset chip control, RESET_N pin B7.
     maxItems: 1
 
+  vdd10-supply:
+    description: Regulator that provides the supply 1.0V power.
+
+  vdd18-supply:
+    description: Regulator that provides the supply 1.8V power.
+
+  vdd33-supply:
+    description: Regulator that provides the supply 3.3V power.
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
 
@@ -55,6 +64,9 @@ properties:
 required:
   - compatible
   - reg
+  - vdd10-supply
+  - vdd18-supply
+  - vdd33-supply
   - ports
 
 additionalProperties: false
@@ -72,6 +84,9 @@ examples:
             reg = <0x58>;
             enable-gpios = <&pio 45 GPIO_ACTIVE_HIGH>;
             reset-gpios = <&pio 73 GPIO_ACTIVE_HIGH>;
+            vdd10-supply = <&pp1000_mipibrdg>;
+            vdd18-supply = <&pp1800_mipibrdg>;
+            vdd33-supply = <&pp3300_mipibrdg>;
 
             ports {
                 #address-cells = <1>;
-- 
2.31.0.291.g576ba9dcdaf-goog

