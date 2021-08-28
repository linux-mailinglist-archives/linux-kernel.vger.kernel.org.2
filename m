Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF583FA55A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 13:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbhH1LNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 07:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbhH1LNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 07:13:17 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C34C061756;
        Sat, 28 Aug 2021 04:12:26 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g22so13818639edy.12;
        Sat, 28 Aug 2021 04:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HNPNHeMY1pAufWRJDKpC4YVFgerQ8O6XdjZUjWL0NoY=;
        b=od/uqxeoSDEa9+9amuQv5t1T0uCN5kAoalGAmHeKNc/9b1GHvJ+kgInOP9Dr+pNw73
         idHtIMeA/Yk+H+B2awdqAf7Z6c+YX5/ZBQNkVH2hCTSg6KjoeSBC5AjxVjXfsaGcGhGz
         /lG4DhzvDy04x33Nle0X+TCL0nDTDH/dUF90vT34KXjsh7B6eRvTvSc5mbEeZJvjk+gK
         ksPws+Td9ORVhizSgv+ELhNvtcB6mJ0UNbABLCsSxT1/xIQwggBMVAnh5TO2LBICsmfy
         pqJqeDD6+Ddq1t1YHO2UrcTyOcv2+0jZ2LkLJYbZBdXfFnpIIHgteCBsFUHgh+clORZO
         /aXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HNPNHeMY1pAufWRJDKpC4YVFgerQ8O6XdjZUjWL0NoY=;
        b=FwAXYgYrOR4uH/Q8wDeTbyoDYrc9CB5QGQnH4Hbc5wOuBVczHtuKThCx9Qj4zISUn5
         CWFErmSQag4FkCBYvdfYQqsoDW3NDBcdvc/z6BRmaXERt5r+Wl7bKESgajohlXwEuKUx
         DpoZDpFUIr2xHq3QFu/lTXaTCf0hDOcrEK1naH/oNKP5v5D3irjO2mIKpmA0m0gus9Uz
         XtaCbuZlsAkM0R/rg5DcrbCBKDmv1IbIL+zFVMVXmFXHVMTMVXe259qYe+/7UBCU7iDG
         dWz5A6Bxrq7XREdyztlTMknM+2a8u6uY07nXzsI91jgCvHxsDftzq9S4U4Wod87SHv/U
         e32w==
X-Gm-Message-State: AOAM530noD5zB1ogqxgPCxAGeUCXHD5ki6EBSIKopebvaUlMKXrpsdIZ
        VpV2WJNIr3Cly+4rfCikgHo=
X-Google-Smtp-Source: ABdhPJx/9ZaL2hFLYRlQE0A/LhxFewkqLdwXnHDwwrzuHk6sG8gJjsxZEccPC8iEZ1cIJpk1osFc1A==
X-Received: by 2002:aa7:dc56:: with SMTP id g22mr14613669edu.187.1630149145258;
        Sat, 28 Aug 2021 04:12:25 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id z15sm4716665edr.80.2021.08.28.04.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 04:12:24 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: phy: rockchip: remove usb-phy fallback string for rk3066a/rk3188
Date:   Sat, 28 Aug 2021 13:12:17 +0200
Message-Id: <20210828111218.10026-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the conversion of rockchip-usb-phy.yaml a long time used fallback
string for rk3066a/rk3188 was added. The linux driver doesn't do much with
the GRF phy address range, however the u-boot driver rockchip_usb2_phy.c
does. The bits in GRF_UOC0_CON2 for rk3066a/rk3188 and rk3288 for example
don't match. Remove the usb-phy fallback string for rk3066a/rk3188
to prevent possible strange side effects.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../devicetree/bindings/phy/rockchip-usb-phy.yaml     | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/rockchip-usb-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip-usb-phy.yaml
index f0fc8275d..499d55131 100644
--- a/Documentation/devicetree/bindings/phy/rockchip-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip-usb-phy.yaml
@@ -11,13 +11,10 @@ maintainers:
 
 properties:
   compatible:
-    oneOf:
-      - const: rockchip,rk3288-usb-phy
-      - items:
-          - enum:
-              - rockchip,rk3066a-usb-phy
-              - rockchip,rk3188-usb-phy
-          - const: rockchip,rk3288-usb-phy
+    enum:
+      - rockchip,rk3066a-usb-phy
+      - rockchip,rk3188-usb-phy
+      - rockchip,rk3288-usb-phy
 
   "#address-cells":
     const: 1
-- 
2.20.1

