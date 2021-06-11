Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D2B3A4129
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 13:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhFKLWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 07:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhFKLWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 07:22:14 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF588C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 04:20:16 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id md2-20020a17090b23c2b029016de4440381so5817767pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 04:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+TF/AKS432hY9gR11OMft7K70W+Hrnb7AyCqWhl4m9s=;
        b=kzB4gw24qhVUKpuUQIjKWomf8BIdL1Fg7KnXflR1IuODTngrvXRCM2ee7VG4kMIYrx
         FraXhSHmF4qCxX9316LNxIUAEARG5YyydibAzknTNpQHsZ0lQCJ/H7FppmO1KHAOqHAC
         1RFGe9fvIDQfXctM/31iLKVAGwldADJ4YvoOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+TF/AKS432hY9gR11OMft7K70W+Hrnb7AyCqWhl4m9s=;
        b=quX0UvSbUq930nsFzbFKoVgdJp9TcJirbtR5H7/L0X5xzci6R7Fko0zKJuVBO5HVpi
         Bj6ezZ3kc7L3CRDSdRnAD93jaxegRMdO3nchGPagLELau09yVs7iq9hLYErcIduNrZK2
         qHvDiuw+cXdVnnJ2rQsE9Sc8KwrUVjMYpAMmLvM3gCZ27bkNLLRqo+BkgbxJg/B9gxnt
         +5A39ZV52UPaxLSngGSRaaXfnOlwsHbWpSoQuxz5v0kJx8PokHm3ECqH50m4VFCdgwU+
         Ocnt23vi8wOl08gQ3QCg5Q5m9O6VVT5brVl6iQiFC+bZN5+wkIexvQyah4z8D6Vq78Rl
         7Qzg==
X-Gm-Message-State: AOAM530PWVPJI97GflLAFGTWARKPUReBG8GueTyV1bMVCUj+qPq22jPx
        8Y15WbOvrTrFXGRkn2fpxePFfg==
X-Google-Smtp-Source: ABdhPJzhyiMKNoEeS0T1XF+LkKWfd1mMcozpdh1MQXRAbZevrhSbdTNkCMSX0EPOoKiVskph4615Iw==
X-Received: by 2002:a17:902:b909:b029:113:d052:9e27 with SMTP id bf9-20020a170902b909b0290113d0529e27mr3437886plb.73.1623410416401;
        Fri, 11 Jun 2021 04:20:16 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:73d3:4412:54cc:752d])
        by smtp.gmail.com with ESMTPSA id y5sm5177189pfo.25.2021.06.11.04.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 04:20:16 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        maoguang.meng@mediatek.com, yong.wu@mediatek.com
Subject: [PATCH v4 2/3] dt-bindings: mediatek: Add mediatek,mt8183-jpgenc compatible
Date:   Fri, 11 Jun 2021 19:20:08 +0800
Message-Id: <20210611112009.2955944-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210611112009.2955944-1-hsinyi@chromium.org>
References: <20210611112009.2955944-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mediatek,mt8183-jpgenc compatible to binding document.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 .../devicetree/bindings/media/mediatek-jpeg-encoder.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
index 28f26e79fcb3a..e4e791d76cdaa 100644
--- a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
@@ -17,6 +17,7 @@ properties:
     items:
       - enum:
           - mediatek,mt2701-jpgenc
+          - mediatek,mt8183-jpgenc
       - const: mediatek,mtk-jpgenc
   reg:
     maxItems: 1
-- 
2.32.0.272.g935e593368-goog

