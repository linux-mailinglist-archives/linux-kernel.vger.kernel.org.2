Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC208366795
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237977AbhDUJG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237873AbhDUJGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:06:49 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0553EC061342
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 02:06:13 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s22so8072833pgk.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 02:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JUFJlRYw+cqn/AL+S42IH0SJKjQ6r0g1wThs2iJNVzo=;
        b=LmMv42o+n4oLkqZ+Uz95xhrzeAw6xn0dpztOFWfOSu6FArh1AgOBnXTsBUajkp8VTV
         zgPs0RXHc/PqFOyvAo+i9shPRVJsS6DxPTyNrH5x1q9aPYbI0xJytI+RBRsdnxgIrjke
         FKQTB4OEBGal1lwIRJM/s1C3hZ+C5q3H2EiW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JUFJlRYw+cqn/AL+S42IH0SJKjQ6r0g1wThs2iJNVzo=;
        b=PUVxsjFjHSI03PGhS+K6ghqJeywugJHXbe4ycNbdDL2jykQcRjWSHszAa43iooiA2A
         E+hB5ZnT4F8fO9PS3UOqk7PVMqJg36Ev5pWyRhZU6MHYuZvFoXHCWOi55VM02dF9EmYo
         WnglpoKHu+Q783u3KIySwp5rKefV3CsCyG9ICxUhJtqB3zeZOaLd9Lv1HS4b7wufd3CZ
         GpMugz1QuxxiU0Y9/kRR/mIt9uAeAZYX96pivdVYMpfSpADYYdhkjHxUlVs7jkRam7xU
         9g+nqT4DtTfnd2tc9vHtl03Zke0VpsBcfmmYdiHrXxDsE07Vo7E+sHl64ewu7Eb3IWV7
         CiBA==
X-Gm-Message-State: AOAM531fXJ2pYydGEwjMACeaFvqECjrKzt2gjT7b+3yIdgSelXt9P7NO
        i6xTDR+ZGOfzDjybDG+pC5ekDA==
X-Google-Smtp-Source: ABdhPJwLdS12xSxtecC4wgi0Qw8p7+oCENpmojb8ObATIWpCJ6sRqkQWExuuENFMOPjeX5GfG1BJnA==
X-Received: by 2002:a17:90a:6f45:: with SMTP id d63mr10008532pjk.39.1618995973292;
        Wed, 21 Apr 2021 02:06:13 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:60c1:887e:ac53:9b5c])
        by smtp.gmail.com with ESMTPSA id jx20sm1495889pjb.41.2021.04.21.02.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 02:06:12 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v3 04/10] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-kenzo
Date:   Wed, 21 Apr 2021 17:05:55 +0800
Message-Id: <20210421090601.730744-5-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210421090601.730744-1-hsinyi@chromium.org>
References: <20210421090601.730744-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kenzo is known as Acer Chromebook 311.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 0870490aa350..7afd01aad964 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -137,9 +137,11 @@ properties:
         items:
           - const: google,damu
           - const: mediatek,mt8183
-      - description: Google Juniper (Acer Chromebook Spin 311)
+      - description: Google Juniper (Acer Chromebook Spin 311) / Kenzo (Acer Chromebook 311)
         items:
-          - const: google,juniper-sku16
+          - enum:
+              - google,juniper-sku16
+              - google,juniper-sku17
           - const: google,juniper
           - const: mediatek,mt8183
       - description: Google Kakadu (ASUS Chromebook Detachable CM3)
-- 
2.31.1.498.g6c1eba8ee3d-goog

