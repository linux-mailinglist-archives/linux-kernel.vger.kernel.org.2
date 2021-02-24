Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5188132374C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 07:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbhBXGRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 01:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbhBXGOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 01:14:55 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4090DC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 22:14:15 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id j24so674220pfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 22:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yxOYlDcAmFrvsseVFQZnlbu4c+MCg9v+/OLc+k95JMI=;
        b=h11vlpce4XGbBFbk13afoWc/iYSBMme7SCx6TA7PPG8goj0ZamXqmwYnchAylwh/kG
         G334yWOoUrSCVEiaQ2b11Ns6QtNTs6lyIv0I/sP/H6R2B45KRaZjH4ftfQ11MHnI52wq
         oq6Yme52ovnyQ1MJodGTN8XLzANyTf+v8UvSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yxOYlDcAmFrvsseVFQZnlbu4c+MCg9v+/OLc+k95JMI=;
        b=dhvyvkfoASy7IXTTqlwTyN5kjFYS3nX8JL/1dkjzDXXTrra2MCJ9bRBLBCmGRGJD7U
         VYENgXtIHnDn78Yd8+mB7KH8Wf9f0VI6Jmlsnba+bMVkUJUzSDk1TM4rBYea8A8kkcTK
         LrcI8iqODPQjy79ElSTCdb19srrtFRCdqrZdFYQNNh81ROoh7+Qb3pT9waAnyvZ9Aimm
         JaCBrm83Qgx9/KYYIoG9AZPbXc25uiufM6RhFWRzGBP95NH2qWDGrvj4bKSC3rUDQGJR
         odelirVx3+a+41X1dvBXvc1abW4IFmrVcOnD038m8F0AGCGSG+rc34gxh6SUSfoCt71A
         uatA==
X-Gm-Message-State: AOAM5338M3j9ZjS7uh8egqLNQZV7qNDUr1c/tQCrC1ml5s0erggnadCX
        cXXXtwAouc+Twrln8HGu7HiMfw==
X-Google-Smtp-Source: ABdhPJxy2AVlk5Xq7aOvwN63bI6UesMrVz7TGyZ2uLn4UrK2JqH1Tv0V+HKRxOP7f5vWqaG+1ITTig==
X-Received: by 2002:aa7:888b:0:b029:1ec:df4a:4da2 with SMTP id z11-20020aa7888b0000b02901ecdf4a4da2mr29828733pfe.66.1614147254429;
        Tue, 23 Feb 2021 22:14:14 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5003:b035:5243:160e])
        by smtp.gmail.com with ESMTPSA id r13sm1266765pfg.37.2021.02.23.22.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 22:14:14 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Xin Ji <xji@analogixsemi.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v4 1/2] dt-bindings: drm/bridge: anx7625: Add power supplies
Date:   Wed, 24 Feb 2021 14:14:08 +0800
Message-Id: <20210224061409.3996755-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
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
2.30.1.766.gb4fecdf3b7-goog

