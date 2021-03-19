Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192503413DC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 04:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbhCSDxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 23:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbhCSDwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 23:52:51 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9758FC061760
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 20:52:51 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id e14so2327802plj.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 20:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wu0UN0qTxD7NQTRZi1+qshriPs2sSwGOFj55/TJrhfs=;
        b=fqqvH2c7HgMSttFHhPrVseaYGYI7ND17sa4mOG9uxCnTyKNZoYpah+jzIMyTWsQtVi
         cFHQa6VIMlMw0oO9A//gedyeB84lyFm9tYX2HqoJw3TnRchhRUgaoeRvuHLtJDK8xRZD
         UhV+9UZ6BYweMxfHNxIw6wIEauX5a/w0sb/vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wu0UN0qTxD7NQTRZi1+qshriPs2sSwGOFj55/TJrhfs=;
        b=Iu0Iph8x90QAEPjdKdySbZUtvtC/4KSV7wGvqm3/t4h7O14c1JYedCYNIYMNTMow7q
         fKV74DYKyBbyXqXM1lp0qLJ9TyzZzNUbKQgKrPxaKAQa3cs9KCOL8z9LNVmYgEStnpgB
         V/euIKNq+DPKuhR1qNBoPY8AgiqDhmV3etmENO9qI+PLP6BhSNU2JH+V2uvAbH1nUFhW
         BT5wCkL4Q0WrMf6LfqeyIGfN3ww7JbeubZhCEzubilCV7IoESMxU58iHizB5V24msCJf
         y05jIw+YkdHvOQZExI588GANsraAaHAhFJ8FP7xz3vuCbMUMOBVP0a5bZraRqZ/lUVRR
         Xwng==
X-Gm-Message-State: AOAM533D3LposbUUO9pp0MJ8AEk6shcAw/zG0fCdaZSlVjb8x/qkI+zH
        81Nn0+icP7Alp+DihRIUTAAP3EGusT0ZxHPl
X-Google-Smtp-Source: ABdhPJwtstJdF7ulIAFEh2bGsL+qpO3Qj+dYWl2OUYKZAv1QwvYbJBHLwVcpzF2cMuew4wQ5OLgG8A==
X-Received: by 2002:a17:902:ecc4:b029:e6:1a9f:3397 with SMTP id a4-20020a170902ecc4b02900e61a9f3397mr12844270plh.9.1616125970722;
        Thu, 18 Mar 2021 20:52:50 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:e12f:5c36:14f:bbf5])
        by smtp.gmail.com with ESMTPSA id u66sm3442180pfu.186.2021.03.18.20.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 20:52:50 -0700 (PDT)
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
Subject: [PATCH v4 1/4] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-damu
Date:   Fri, 19 Mar 2021 11:52:42 +0800
Message-Id: <20210319035245.2751911-1-hsinyi@chromium.org>
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

