Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547963625DC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 18:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbhDPQle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 12:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbhDPQl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 12:41:28 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1C5C061761
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 09:41:03 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id p12so19567942pgj.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 09:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vzcQwijJhfY7OpfvhBJPOdOpXaIv6ebJi2ScpoILz7g=;
        b=PHbuQvOJAqlLg3IDRJ/vUPfugXYBoCBVhndXgCkWJtDPPSxSbeE7zgKRHPtw9XTPVR
         U+nGFHJ8d/HjRZhUNqzBvYSW8ANQDQ2XJH3NQ92El4oeo3eOkuaG1RdnNUI0kM4+49Er
         vpfugcssifS5tZ7S6J9ISCL8p8sdh9bOXp5Vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vzcQwijJhfY7OpfvhBJPOdOpXaIv6ebJi2ScpoILz7g=;
        b=fOJRHkkC2jPY6Ca7ueYo+fsrPigfOye8yV4AgVP7PxKpQvrv3CmkgCEOi81i8f0vzv
         BepGCOvn0LV7QkPeCdP8zJHrkajxspSFBEiW1S5w6U6hALgi0hRYIpGuQAI8s+ZnoUEy
         A42VCjs4yFcVRmKcn8C5xUA8mFTo5YpLrBinb+jyxUOgWVSixyoztnd5SsgK16wUgldo
         lJ9vx4qoQ1vXEAm9ftACJrxkgf4BmLkZLXnEF9h6lu0Jb43e+hbF4qkVcdHdlw2xUMDW
         NQCiwcg72uHKrDdYGI4gG3+ETCLM/tZWDpZ3FPus5pZaxQMaVai30J+TAt5KkgQbzeHB
         TgIQ==
X-Gm-Message-State: AOAM5316ptRr0lZxZX+cvUL6723Mfcsp7XfnNyqvfZivjw0wAlyibjLm
        ckiFv28X/XE+VGX3N/57jA4Dvg==
X-Google-Smtp-Source: ABdhPJxUh/mtVkeY7xRtwh9IW1IBjcLiEAJh0wutc9cPsIFSvErkHlC647yq4IzxXMn86frujypE4A==
X-Received: by 2002:a05:6a00:1354:b029:241:91b9:75b3 with SMTP id k20-20020a056a001354b029024191b975b3mr8547393pfu.5.1618591263275;
        Fri, 16 Apr 2021 09:41:03 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:ccd5:218f:365:b90f])
        by smtp.gmail.com with ESMTPSA id g14sm6187186pjh.28.2021.04.16.09.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 09:41:02 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v2 3/8] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-burnet
Date:   Sat, 17 Apr 2021 00:40:50 +0800
Message-Id: <20210416164055.3223088-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210416164055.3223088-1-hsinyi@chromium.org>
References: <20210416164055.3223088-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Burnet is known as HP Chromebook x360 11MK G3 EE.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
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
2.31.1.368.gbe11c130af-goog

