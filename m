Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D526744A65A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 06:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243028AbhKIFgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 00:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242916AbhKIFgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 00:36:32 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBF7C06120B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 21:33:46 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id p18so18815805plf.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 21:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7VRwqE4mljaTBbEn84HnhMeSkIM9YCg3MxPTKXVa2zs=;
        b=JYk6RuEtncv9Yj8kUzfQQAsHTXqjpqW4CuGBXznkYbTp8u3JXO0hGBhsNowicIqzha
         ZZ4i7LW0HN1mOsgYe2oTm5bjrj8NHDDqjo/42xZxyBWkrVY+hqXYKxGxrZj904NVQMAR
         HCZCaPTv/spHvGvWK3cwodQHmwMF9h5xvoeyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7VRwqE4mljaTBbEn84HnhMeSkIM9YCg3MxPTKXVa2zs=;
        b=Hl0TbLbIQ+/ZxSvFfUvwVFOiFIcomRSurO8ikbQqw0tmOUzteCQMyFmrM0iu3BXVeQ
         9wby8TEC/ujBvhSFkRFLdGtODi0GuvSxCc9NUZg6QJG9WoAiCIr96pVnZ+GjiMf+gYNo
         UHw5U/tihtEpFkCadm8x3CGdtraZ2U/RzVQ47sBW31z3RFiaadFdJ5UDqUr335DgASUS
         UHxiQDnSStru9IdAnEnGzAKmP5fv/JTsGv2SHiiS+6rO++CCghW/KNp8o5vKwJqabZ0s
         MpX2PeW43H8DEt8sY8VmDZRnhpT8qTat/3gUDQ7sool5FtnY/BeU3Izdl8Nx5EBb+JN+
         vBtg==
X-Gm-Message-State: AOAM530+05ISYt+6EMdztB3ifIRIDG7o0YIHD9bynyBJokYHfxU26W6N
        1GLXdVla2l5syRqPCorOwVL2OfYyVkQvXw==
X-Google-Smtp-Source: ABdhPJyYiw2ESBezPSH2ABAAwdfC34sMPgqeOgJGIZvnyav6y0KjpeuGgvhlTdr2trwcbIe2bNQfyA==
X-Received: by 2002:a17:902:758b:b0:13e:8b1:e49f with SMTP id j11-20020a170902758b00b0013e08b1e49fmr4970995pll.6.1636436026004;
        Mon, 08 Nov 2021 21:33:46 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:cc3e:b71b:e327:fb32])
        by smtp.gmail.com with ESMTPSA id w5sm13741479pgp.79.2021.11.08.21.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 21:33:45 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] dt-bindings: arm64: dts: mediatek: Add more SKUs for mt8183 fennel board
Date:   Tue,  9 Nov 2021 13:33:33 +0800
Message-Id: <20211109053334.1840273-6-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
In-Reply-To: <20211109053334.1840273-1-hsinyi@chromium.org>
References: <20211109053334.1840273-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sku2 and sku7 which uses different audio codec than other fennel boards.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 7cf0c76cd31006..99e7f8e294cd03 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -147,7 +147,9 @@ properties:
           - enum:
               - google,fennel-sku0
               - google,fennel-sku1
+              - google,fennel-sku2
               - google,fennel-sku6
+              - google,fennel-sku7
           - const: google,fennel
           - const: mediatek,mt8183
       - description: Google Juniper (Acer Chromebook Spin 311) / Kenzo (Acer Chromebook 311)
-- 
2.34.0.rc0.344.g81b53c2807-goog

