Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2A744BBC2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 07:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhKJGeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 01:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbhKJGeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 01:34:24 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C584C061220
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 22:31:32 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y7so2289955plp.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 22:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uru6ZygcT/BbjahRjsIfXyLnWlA4uaMxI78WnRQl3Hk=;
        b=PKU43lp4Q6vbJSHJQicfiZO4YFUOVOvUmroGqlb74zJNoNWP7IE9ok9XryJyncP4M1
         LRJTIFYarPh2gqHkSAPg18lHHjGaBphYHUyD3PQEalhcLDw7HMFYdwe5eqbnoOFcYY0H
         CA2RbltRJn2HTvK3hSGEKj+VZNx+jIBDb9yo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uru6ZygcT/BbjahRjsIfXyLnWlA4uaMxI78WnRQl3Hk=;
        b=B/UMK2SBdBVzD8SdEgYg40QZ/ZcNhAlQpdIgkFa3yJc01Uu2kbL2bT8jAXtOsz4Vvv
         6F8uKQ92BqXVZXxNUBGZqDYURa3a5xj/EDBLIMWUFwqaLjsKlMMnpkaHSne9874RZv2X
         qNbJsaRd/25faUyM9wk6hL5PjBvwhf707K8QnoYinqiIFrfSav+bGcwO6H43mV1zpTyV
         T35xy8mGdR2p2glBpfQqHb6p6xw3p5Ok3SqQ2q6A6toBjm3fo28wcGvLDGXiOdYU5WnR
         CX1UzqdubOBRo+c2OeA/ZZhMU7GNBAx1zNQ8j23BCbSnZngz8teA58YPt3D4QiSb/Q5y
         kiWw==
X-Gm-Message-State: AOAM531lgXrT2MxTmoykeqhiS5yqSERO0BYltUi5NzVE7v2blNst3K4Q
        yHB2J2ElD6fcfKQRMvsMq/N2ig==
X-Google-Smtp-Source: ABdhPJx/mEB0Pl0YuO1j10sru+roHbXo7nzWSImhJUgLBlVUiZdIA1PHSaQkUMOqCv0Z3U9TSxTOlQ==
X-Received: by 2002:a17:90a:df83:: with SMTP id p3mr14327202pjv.145.1636525891951;
        Tue, 09 Nov 2021 22:31:31 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:6886:f712:1a79:e3d9])
        by smtp.gmail.com with ESMTPSA id w1sm15623959pgb.50.2021.11.09.22.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 22:31:31 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/7] dt-bindings: arm64: dts: mediatek: Add sku22 for mt8183 kakadu board
Date:   Wed, 10 Nov 2021 14:31:18 +0800
Message-Id: <20211110063118.3412564-7-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
In-Reply-To: <20211110063118.3412564-1-hsinyi@chromium.org>
References: <20211110063118.3412564-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sku22 which uses different audio codec than previous kakadu board.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
v3: Split sku22 to another oneOf items since it also has 2 revs.
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 99e7f8e294cd03..723810cffce2e7 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -165,6 +165,12 @@ properties:
           - const: google,kakadu-rev2
           - const: google,kakadu
           - const: mediatek,mt8183
+      - description: Google Kakadu (ASUS Chromebook Detachable CM3)
+        items:
+          - const: google,kakadu-rev3-sku22
+          - const: google,kakadu-rev2-sku22
+          - const: google,kakadu
+          - const: mediatek,mt8183
       - description: Google Kappa (HP Chromebook 11a)
         items:
           - const: google,kappa
-- 
2.34.0.rc0.344.g81b53c2807-goog

