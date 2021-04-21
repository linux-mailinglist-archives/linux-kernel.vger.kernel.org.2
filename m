Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A407D36678E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237783AbhDUJGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237850AbhDUJGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:06:41 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03619C06138B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 02:06:08 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t22so20949085ply.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 02:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lry1BwRcX1DIKG66zy5DdtnzBVoqpe6oY2tgO8jcTBw=;
        b=kZV3TZGbJifrkF+1IKw2rQMLyr0wzwJKVCoRsmvbPmmXf6WByeyK7+t8b7S4Trp4CB
         BWTNKhxieeZzGFkpDNW8swZAZ6paU2wsFhVBqjXK+pW1DQuQ/14zZKmCvQhZ28wumTHf
         33ibJhdasuAWI+qPp6z1w1gxQdCX+REwyyJ48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lry1BwRcX1DIKG66zy5DdtnzBVoqpe6oY2tgO8jcTBw=;
        b=uSt87tXg950SJ3Ary57LFwmZlp4/lEY1cWYW8b/dKbBROdZYmyGe7gwTzugQ/DgyBD
         N324D412g8/vmDg8wm+qzHZq+o/N3QxztHS8zmOBqVW94d8Jgr4ucQsa0qp9Gde+KHsf
         WbHVf5Wu7e/RfguLwckQVUgtttanr3isMvO6OvfCYyGiJY6zd6zkC3MSwDoYEs1aDsjI
         gprxw39JKsxjHcxrm+DEglxCFY74dJjxy6wEK3w3xHi+eo7+g6XwkYjODeveDKMtxDfG
         vLEqMut1lPjBUPsGFNy1L0JKjQkMeYAoXBz3Mvk/7020TnH/RQgrg4s10I2VQStWwqz0
         3P+A==
X-Gm-Message-State: AOAM533GgNRWIsKdFoorGQTBked3kukuqMEbJj7kcwykpUDGu0i+V+jd
        azzkIBxAa3Krv0XnDQyXO1oJdhG8bKEoeg==
X-Google-Smtp-Source: ABdhPJwU7paLEQSz6xwbh38lSoIwoOVf6qULB9EDv5p0KWIvFYKrIsCoq95kTJvECz7EPu1l57D+ww==
X-Received: by 2002:a17:902:a515:b029:eb:2723:3fde with SMTP id s21-20020a170902a515b02900eb27233fdemr33179409plq.56.1618995967538;
        Wed, 21 Apr 2021 02:06:07 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:60c1:887e:ac53:9b5c])
        by smtp.gmail.com with ESMTPSA id jx20sm1495889pjb.41.2021.04.21.02.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 02:06:07 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v3 01/10] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-kappa
Date:   Wed, 21 Apr 2021 17:05:52 +0800
Message-Id: <20210421090601.730744-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210421090601.730744-1-hsinyi@chromium.org>
References: <20210421090601.730744-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kappa is known as HP Chromebook 11a.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index aff57a8c8c30..81b86b189a8d 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -144,6 +144,10 @@ properties:
           - const: google,kakadu-rev2
           - const: google,kakadu
           - const: mediatek,mt8183
+      - description: Google Kappa (HP Chromebook 11a)
+        items:
+          - const: google,kappa
+          - const: mediatek,mt8183
       - description: Google Kodama (Lenovo 10e Chromebook Tablet)
         items:
           - enum:
-- 
2.31.1.498.g6c1eba8ee3d-goog

