Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14822366791
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237932AbhDUJG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237856AbhDUJGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:06:42 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00100C06138B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 02:06:09 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 31so13668268pgn.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 02:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zLcreJQkIC8DjiQ1Nd/plIursk6C1otcEwiKu83irPY=;
        b=NrvwVVUSvqFZOe7U+6IHznARiMOjHNCkPxGv0hGC+S918iTaSvD2Ay0scKJDdHS4Kj
         /OWnDMLqWWaX/DTC6AbIltqvdiM7BUi4rpJP8eo7M/Tqx1FB3ZdQxPIxYwliUIRC9nk3
         HcphIHiL3APfeLhM9vugGWY4jNTDqxTYRGGyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zLcreJQkIC8DjiQ1Nd/plIursk6C1otcEwiKu83irPY=;
        b=QwpPX9PHICDATHefAZzRBB6VaqOBSS8kUUnakeDC5ykG3xF/8cO0gbrWF3P+bal2dF
         TdRC2Bk2jBaE+ByZp9UP9I/LOrzIgQbPX6PdTifffFqnzfitdTuoq5HL+sBOv5y+kpjg
         bmnZzTcqv4DpQTzUHe4Y0TbHIKaQiB3c0rqbMCxCTqXnNz/T0OzWJLnbn6relUmrXnq3
         u4M9rd/FXTIh7xC3qrJnCTGz602Sj08RVxH6Cd3HGqqgU5GhRQgdEn6V0iEdrK+j+77B
         FM/HwEox9XHECSw5pMqWzMOUYJbMdlQ+ykIdMbH3xzFVSApU9FM1sC05irXUFrDzW426
         NSVg==
X-Gm-Message-State: AOAM530RRyaHYZW3xp8NAeyAVuCb1ozqaqNTrxf7it1kpLYX5ESFDAlD
        w7gXAFHBs65T8b/AaU8rn7jXWw==
X-Google-Smtp-Source: ABdhPJyH1F9Wkud4nTiavYJ2OnYVvr6eIZcxRlWfStBQypVqAeVa3RfXKug08+KoKT2h/zqbdhO72A==
X-Received: by 2002:a62:2cce:0:b029:21d:97da:833e with SMTP id s197-20020a622cce0000b029021d97da833emr28417006pfs.40.1618995969448;
        Wed, 21 Apr 2021 02:06:09 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:60c1:887e:ac53:9b5c])
        by smtp.gmail.com with ESMTPSA id jx20sm1495889pjb.41.2021.04.21.02.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 02:06:09 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v3 02/10] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-willow
Date:   Wed, 21 Apr 2021 17:05:53 +0800
Message-Id: <20210421090601.730744-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210421090601.730744-1-hsinyi@chromium.org>
References: <20210421090601.730744-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Willow is known as Acer Chromebook 311 (C722/C722T).

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 81b86b189a8d..96c401597bd8 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -157,6 +157,13 @@ properties:
               - google,kodama-sku32
           - const: google,kodama
           - const: mediatek,mt8183
+      - description: Google Willow (Acer Chromebook 311 C722/C722T)
+        items:
+          - enum:
+              - google,willow-sku0
+              - google,willow-sku1
+          - const: google,willow
+          - const: mediatek,mt8183
       - items:
           - enum:
               - mediatek,mt8183-pumpkin
-- 
2.31.1.498.g6c1eba8ee3d-goog

