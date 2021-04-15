Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CEC3605E4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhDOJfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbhDOJfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:35:51 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3300C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:35:28 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id lt13so2927945pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 02:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GpOIwB42K+ICb34QKJMXC/ca1T6tE7+UPtJ239iO6pc=;
        b=DGMgre8U5XYVjEl3VMNY8n9k/vakOsTgxx9UAilFaEASk0ZeIXDsXLq9hcdPhvvCcc
         zMsyMixuH85ShdD5/15Nu5g4Q3E8ZauEWeVrkP85+4dHcwGdEO67baeDRY4xg24gWnNo
         Omie+dya1YE7oYzQLghRFfJVrLh2UYEmfZ1kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GpOIwB42K+ICb34QKJMXC/ca1T6tE7+UPtJ239iO6pc=;
        b=QDrbiuqh64gXo5zdZdCXt1rzi4ve4nHs/zGQPWzjc0hPlBBC0OBEC+Lc8OF69JClLI
         +Uf2q10Ua+0PNN0fuJSq8L7ie6ZKejITKy4xDtKlU7eEvrHyBz8P6Cf6t7HJiWROdKZP
         0fltHcCtrYG3ojhoqf2kXMbvuJN9TtUoXR+M4+9HUgxSjKiGuxoPj2gm5IfCS++/Vgj7
         JPys7QdD23YWHb+iu3bexFnUimGRhF7DsGFQJNB9ONLwDAO6p4ytnZbe0Ri22L3WBQki
         mC9vMF1z9lerY4PEQChU4T1sctYdeSY3kExjtmGn1V13+3k6moRukpacGbi/TMvmArCh
         DP4Q==
X-Gm-Message-State: AOAM530ArxXXZci+23WkZkCOrSJSFoO9cu3nPRLjsRYUJe2JcXkLFOdD
        iRtSMI4ta6fDh1vFLmaQtpt6EA==
X-Google-Smtp-Source: ABdhPJwq+7XXYy5bKjqDWNELX/hcIJTFwRnyNQbFxJzwdAHq0mhsJ+82CTHUOOgKS7Sai/n/AvYHvA==
X-Received: by 2002:a17:902:9307:b029:ea:e588:10a with SMTP id bc7-20020a1709029307b02900eae588010amr2983172plb.7.1618479328206;
        Thu, 15 Apr 2021 02:35:28 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:6432:a6cb:91d2:5e32])
        by smtp.gmail.com with ESMTPSA id a13sm1849502pgm.43.2021.04.15.02.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 02:35:27 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 3/8] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-burnet
Date:   Thu, 15 Apr 2021 17:35:14 +0800
Message-Id: <20210415093519.1920877-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210415093519.1920877-1-hsinyi@chromium.org>
References: <20210415093519.1920877-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Burnet is known as HP Chromebook x360 11MK G3 EE.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 96c401597bd8..0870490aa350 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -122,6 +122,10 @@ properties:
           - enum:
               - mediatek,mt8195-evb
           - const: mediatek,mt8195
+      - description: Google Burnet (HP Chromebook x360 11MK G3 EE)
+        items:
+          - const: google,burnet
+          - const: mediatek,mt8183
       - description: Google Krane (Lenovo IdeaPad Duet, 10e,...)
         items:
           - enum:
-- 
2.31.1.295.g9ea45b61b8-goog

