Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96AB3311F82
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 19:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhBFSwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 13:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhBFSvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 13:51:48 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7544BC06178B;
        Sat,  6 Feb 2021 10:50:31 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id bl23so18283490ejb.5;
        Sat, 06 Feb 2021 10:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cNFFFBXY6L5UHLHUyj3rIyUKC+rbFyqqqVFEOT4uqFw=;
        b=CnzYUuxcOyyTvOan0vBJMMJPGwICmf0/GH9SAr4roDkk2w0jcRAOb5QFrIJBnRnage
         svbh6I70pNYLmUByFDqW/N5b0bMUUDdb+WDWr1yFXDjh4afUM8Ai54CVVs6P4pbJ0diK
         E3DTUWXcSYOueZQsG9UeXkeSUbcHFO0+gdHboOrjk4CJX9+b8vO6Tb7qNw4tD1qQ014S
         d2q5bQZjgKt9g1xo5rJXf2UlAXLKwDCgdRZoEdJW8YfumtLc11QfgQ3hCAQFhbOjyvpz
         jzZ04XCPPK8L2CyxZstvGnFmY07niZ3i5uSx36r/0Cz5/0nIMRDKwTLl/z9Ir5eFF1u+
         h58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cNFFFBXY6L5UHLHUyj3rIyUKC+rbFyqqqVFEOT4uqFw=;
        b=ZKcFOnYcnJcX50Fq2RImWP1WAnzTPobdz5FdcppUAWsC5kkaLWJaImUAU3ms7N7Rzn
         vHgr4GhkpBeJwnLErJ8PT9+JdUYawnJ/Vf8+3uk/R4gQB5JgZITi7NaBULl23qkrIR7u
         Zz/TAx4OsjQGAa/0L4LuM3vQrspnDUpdHSfM+AUKt8aO+FAyKjVJupqRnK1eJW5szvlg
         5za1tjbJpMfyrWPOUh9we7JEyyeX0BrkjSDkfGHml+hn71vtC3wBnZIK/dXqBIeqTys+
         X+SzW2+jsq7ygFRoLG1amSmD5BpcP2H3vX6Xi2YPaq0onHasZdWRINBKXyD+gpDPYv2K
         orHg==
X-Gm-Message-State: AOAM533RhAWup3VlZs2PZ7SbZmMwlAetxLIvY4sIKqdHALPrE8iA5+FO
        hG8pt0M96gHVqXcNKjwZKPk=
X-Google-Smtp-Source: ABdhPJylNtHRx2BQ92Cv5mX8YLcNOgMKwC7xgE/+m1i1Q2fl7RY+GSv0b11XH4gATIbkcNHYHhif/Q==
X-Received: by 2002:a17:906:d19b:: with SMTP id c27mr10099272ejz.234.1612637430296;
        Sat, 06 Feb 2021 10:50:30 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id cb21sm5890005edb.57.2021.02.06.10.50.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Feb 2021 10:50:29 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/8] dt-bindings: usb: dwc3: add description for rk3328
Date:   Sat,  6 Feb 2021 19:50:15 +0100
Message-Id: <20210206185017.1817-6-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210206185017.1817-1-jbx6244@gmail.com>
References: <20210206185017.1817-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for "rockchip,rk3328-dwc3".

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
index d815aacfc..08a08ffce 100644
--- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
@@ -27,6 +27,7 @@ properties:
   compatible:
     items:
       - enum:
+          - rockchip,rk3328-dwc3
           - rockchip,rk3399-dwc3
       - const: snps,dwc3
 
@@ -37,6 +38,7 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 3
     items:
       - description:
           Controller reference clock, must to be 24 MHz
@@ -49,6 +51,7 @@ properties:
           Controller grf clock
 
   clock-names:
+    minItems: 3
     items:
       - const: ref_clk
       - const: suspend_clk
-- 
2.11.0

