Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3916133FE46
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 05:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhCREi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 00:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhCREiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 00:38:01 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFDEC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 21:38:01 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so2468624pjv.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 21:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wu0UN0qTxD7NQTRZi1+qshriPs2sSwGOFj55/TJrhfs=;
        b=JnhEYHtG8GcWblkEqlnukB3sW2ozfkVUOTi3eX2FyFLMPicJSZpmzGzd+87u7SdNwT
         GWnRMgt6j7VvIAueGQqv9p9IOntxQzyunv1Xjh5gRySqiBmJVRdvVYuF57pLWJsqrqaU
         Jc3Wx//wy9wlk3spgOF09gRE0KkQhOyFxTUfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wu0UN0qTxD7NQTRZi1+qshriPs2sSwGOFj55/TJrhfs=;
        b=WjZDcPDFqWlq/hrPy7DY9tI0PsQnaAqtSER7iQyrQG++rd9LHemxIglZLaiD4ivqv9
         DBsUjxaSMgspCA0TvoM+d3MQXw9Ag3Ok/wciM0XwTim2DCFoAOdvkJSqe6eJTjEu13zH
         CeDJW9324PS1N+3de362PMIaDQGs/9JgW3C+k/kr2dvGZ6IQ2u0qynZwHHKiTdUm73HR
         ymcfxgmV7cnBhEo0HLnO17FitM6f/GB3jbUNpH5GShD6Vz2LJYGe4wgxC61uZ87+ErOG
         ewGOQkDSe2AcpKERcT9hGDeHhLubvo4KuYlRGDO8dxLTibN7BAil349YLh2UYjJg7BQE
         DtkQ==
X-Gm-Message-State: AOAM532N8iOX57PKHiTW3+fpj8QoB9yNtd2UL35586awgmp5ymk/KBjY
        843fkp4dCY4jD4PHP6flEsAyZbyjKOadB8EP
X-Google-Smtp-Source: ABdhPJzIaZ6w7w9IBg3hxpIxje9WnBHc4M9GJ0YeFtZVWASjJiKw0xd9PcjxU1CC3FLuBSfqt4Gq9Q==
X-Received: by 2002:a17:902:ec84:b029:e5:bd05:4a98 with SMTP id x4-20020a170902ec84b02900e5bd054a98mr7801174plg.76.1616042280176;
        Wed, 17 Mar 2021 21:38:00 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:e12f:5c36:14f:bbf5])
        by smtp.gmail.com with ESMTPSA id ft22sm611234pjb.8.2021.03.17.21.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 21:37:59 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Ben Ho <Ben.Ho@mediatek.com>
Subject: [PATCH v3 1/2] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-damu
Date:   Thu, 18 Mar 2021 12:37:54 +0800
Message-Id: <20210318043755.2273782-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mt8183-kukui-jacuzzi-damu board also known as ASUS Chromebook Flip CM3,
using mediatek mt8183 SoC.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 93b3bdf6eaeb..a86716cdd408 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -125,6 +125,10 @@ properties:
               - google,krane-sku176
           - const: google,krane
           - const: mediatek,mt8183
+      - description: Google Damu (ASUS Chromebook Flip CM3)
+        items:
+          - const: google,damu
+          - const: mediatek,mt8183
 
 additionalProperties: true
 
-- 
2.31.0.rc2.261.g7f71774620-goog

