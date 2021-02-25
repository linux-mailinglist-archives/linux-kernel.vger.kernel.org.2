Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B8D324E66
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 11:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbhBYKk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 05:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbhBYKSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 05:18:05 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7FAC061224
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 02:16:46 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id s23so3265299pji.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 02:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AOnu5+rwwrxagaBbf8x0GjKsvpo3db+Itt5LI3BY7eA=;
        b=FN0DasRvoVznQ6E4Y/uUENAY0JjGIAWRWInz95h/Puo/8Tm4QEnbA8qhftyt4NyklR
         FKF2qeGViS7xGwJViornwpXb4Cnd/kyfU9BFEHHF7YbGr+2IQJfc+IDMV9C2jo3p6Ry6
         xk5TZxJqO8SneFI5R43DkmyQ1pRg1hYCnKpX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AOnu5+rwwrxagaBbf8x0GjKsvpo3db+Itt5LI3BY7eA=;
        b=ZCCZQigYFlWbKLKb9qPLExRX73jZxa75QjitTnaN8YoUkcvjGR9MR01fWwc5lVkjmP
         P04d/BDJ8/Q6vMycPHttE7tNLqbhiA2vpFmH4cF5bEQO7SBlINsz+hZ7ItBk9uCzwY58
         ZV7TIYFv66lvbV0w2s/2EU7Gt/qd28HBDveKIYGDKRP8cRJ4/3b0yN0Q+7nWHKPxPx03
         IBwrgF9hFvtq8JEummzdfUa68Mvv8IssFv08VuqpeFlh5u0uh6OW680oQoQtw4mJBFH9
         NBTWHNuV5Spgi7qIGVkccidDBiQLD29oFeentMudqlrLPCVVkfVfY1tcQMieiZdaJ86n
         /JEw==
X-Gm-Message-State: AOAM532DdxFqA0AP4sS7lC47I0QUxMjJsoPYt7sV6x5O5qZFtdtc0Doq
        mBD3SI7CB/hd/WkCuq66RbuP95kN67A4ZQ==
X-Google-Smtp-Source: ABdhPJxYnrlwLEA12Pq2yUQxpxKVdVUC1QRTp2SRT75TUZk3NGgHWKkRD2dvNBrC5K6NHMWXR+6sIA==
X-Received: by 2002:a17:90a:b28b:: with SMTP id c11mr2638559pjr.62.1614248206231;
        Thu, 25 Feb 2021 02:16:46 -0800 (PST)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:2550:3154:2c53:b6e7])
        by smtp.gmail.com with ESMTPSA id z2sm5848193pfc.8.2021.02.25.02.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 02:16:45 -0800 (PST)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH v2 7/8] dt-bindings: media: document mediatek,mt8183-vcodec-dec
Date:   Thu, 25 Feb 2021 19:16:11 +0900
Message-Id: <20210225101612.2832444-8-acourbot@chromium.org>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
In-Reply-To: <20210225101612.2832444-1-acourbot@chromium.org>
References: <20210225101612.2832444-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8183's decoder is instantiated similarly to MT8173's.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 Documentation/devicetree/bindings/media/mediatek-vcodec.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
index 8217424fd4bd..30c5888bf2d6 100644
--- a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
+++ b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
@@ -7,6 +7,7 @@ Required properties:
 - compatible : "mediatek,mt8173-vcodec-enc" for MT8173 encoder
   "mediatek,mt8183-vcodec-enc" for MT8183 encoder.
   "mediatek,mt8173-vcodec-dec" for MT8173 decoder.
+  "mediatek,mt8183-vcodec-dec" for MT8183 decoder.
 - reg : Physical base address of the video codec registers and length of
   memory mapped region.
 - interrupts : interrupt number to the cpu.
-- 
2.30.0.617.g56c4b15f3c-goog

