Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872F7366797
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237990AbhDUJHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237894AbhDUJGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:06:49 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD3DC061344
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 02:06:15 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id y32so29167256pga.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 02:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U8i9idWnh+BD1DYDC6CSI0oIABZbK1MeOIQZQDmArxc=;
        b=hZw21nzEZdpWlGnoJDYd5HTnoHj7KkGKzv9Dk9lTjwvjroxprvopNc2lxsq8Ao6e7+
         CdQjrIgZ9GudWXggHppkpO1I9UwO+DDeI9EKjZyF0Y6Q9Bg3Q0eiPsBqhovqrsmFCEXw
         8UMrTqnHqI8LG14F2fB+ne0qUvOmPyL5mE7/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U8i9idWnh+BD1DYDC6CSI0oIABZbK1MeOIQZQDmArxc=;
        b=LfuS0Zxl6nzSQjgaBllzYrbMxHGzK+LflTUvo31QmJKcsLj3ETqte8aET3Ji+vOXa2
         SdY2Md/u/R32iVLcrm5JyVVzpvqim78agstRDuuevQ0yZMcpcS7j4IatOLF4URPpp0si
         ZbnqmhlQXV4r/sLiu55vc0dzp1+zjrfTv9F8Wiu9SMQZY1IiBPI0grZULKG61ltbtPAp
         Nzn8xBc0YOiEi6iZYtYGdSdBveadl1EJrUNOzU6RFyEYvCp3nxOvp19IxKVe3A8Ew4B+
         qeZarnCH1ltMqfARDNspGNpXvpyPWoYulmSq4aWMJiUE9HS0EfN37fCl8YQk7FCrZM0D
         ItJA==
X-Gm-Message-State: AOAM531iOU/P7RLvecj40MDQlHYoRhvbNO6INFBe1gU3ZJfW3AeKxXfm
        0kL6sbgUZ/DD/0tTm7P47Db7vQ==
X-Google-Smtp-Source: ABdhPJzdaAjg/Z2Kn+80seKFBzKGWgdCYEiVirKKj44Q5A2AMjLk79uUikTaaaV2NMk1VN8qT5+0Lw==
X-Received: by 2002:aa7:80c1:0:b029:262:ab5f:adc5 with SMTP id a1-20020aa780c10000b0290262ab5fadc5mr9521262pfn.60.1618995975224;
        Wed, 21 Apr 2021 02:06:15 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:60c1:887e:ac53:9b5c])
        by smtp.gmail.com with ESMTPSA id jx20sm1495889pjb.41.2021.04.21.02.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 02:06:14 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v3 05/10] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-fennel
Date:   Wed, 21 Apr 2021 17:05:56 +0800
Message-Id: <20210421090601.730744-6-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210421090601.730744-1-hsinyi@chromium.org>
References: <20210421090601.730744-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fennel is known as Lenovo IdeaPad Flex 3 Chromebook.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 7afd01aad964..80a05f6fee85 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -137,6 +137,14 @@ properties:
         items:
           - const: google,damu
           - const: mediatek,mt8183
+      - description: Google Fennel (Lenovo IdeaPad 3 Chromebook)
+        items:
+          - enum:
+              - google,fennel-sku0
+              - google,fennel-sku1
+              - google,fennel-sku6
+          - const: google,fennel
+          - const: mediatek,mt8183
       - description: Google Juniper (Acer Chromebook Spin 311) / Kenzo (Acer Chromebook 311)
         items:
           - enum:
-- 
2.31.1.498.g6c1eba8ee3d-goog

