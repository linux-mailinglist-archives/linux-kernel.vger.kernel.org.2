Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA844329CC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 00:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhJRWeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 18:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJRWeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 18:34:17 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8360C06161C;
        Mon, 18 Oct 2021 15:32:05 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id w2so16738088qtn.0;
        Mon, 18 Oct 2021 15:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B+THCBm+Bptn3AcrYHmUbk69xNON+7lXvmVZMVyCP8o=;
        b=qtDqlY1x9BHB63nIqbapHVBGHLAjMRgBvzThTZG8wtldzjEWVUFvplZhen7xrELRfY
         mf57YDR7vtU0guUcF27Nl6v0jSOW/Xlzp5RFCzh9zbrGw09etc+4yTpT06wnrQpm8U5f
         KjeMTIUqyvblv/FnQh/gxZwSk87StgGlnsRfUyBUiVZeM5YUt/FxYNeoPXidJZjPVhOK
         MGFoNYcIqgv/Joiy7ltOXXKIy2AbRXLvkpyOFNHD+bWHid+0iZGWDjqAtt9n55cunjRB
         noZ0RO0p6AL57Eld5Jkj2vObC9Xc/yvgdGMEoxSlfj0sgUd/Vzhg51XoktAMimJHkNK0
         n8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=B+THCBm+Bptn3AcrYHmUbk69xNON+7lXvmVZMVyCP8o=;
        b=tBFvNfc1Qw3++89h9N58ktq/XsGOIAkzuLDU6kOgjKxRIJkuBecjiQC732D3AzUrfs
         dhEKSltUut60L2AoXv8i8kdJsU+juXNq17GfqKBaXTZ7OfJJs2hjJCjs5zcbxOzlMAYP
         77CxGvadXr4XrwTOFg5QypOzUr2iZas5bX1PzqaLT3Pa2+ecpgbfLQ34BkxbVhCssN3q
         1XKLpcjyQvNflfoLHGP0FEk8LC2YYaYtOOKgSHYgE4ICBKa7aNFzf09cuFhO31GvFX+y
         828NOBWh8jciyk9TYPMXVadRgXPR/l3nFQaW9NMyI8//unKgFq1ZZHIaJQCYbdIutjnf
         XrKg==
X-Gm-Message-State: AOAM531dxqQv0Ww7uZh4lnxknP+d3y8qm0imCu1GHumMHA6Dp1vA3RHh
        TE4NNwWnrbJzXaFzxX8TsntWYCXeXYFRIw==
X-Google-Smtp-Source: ABdhPJxJq+3CBhP7qsX6w7M8ztSNq5vLo64yqArtuFqWeASC27vVuJPkHApqYzJR7Up9TzXZ3oKc3w==
X-Received: by 2002:a05:622a:1486:: with SMTP id t6mr33500927qtx.319.1634596324923;
        Mon, 18 Oct 2021 15:32:04 -0700 (PDT)
Received: from localhost.localdomain ([67.8.38.84])
        by smtp.gmail.com with ESMTPSA id g1sm6986585qkd.89.2021.10.18.15.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 15:32:04 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     sam@ravnborg.org, thierry.reding@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: panel-simple-dsi: add Tianma TL057FVXP01
Date:   Mon, 18 Oct 2021 18:31:49 -0400
Message-Id: <20211018223149.23591-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the bindings for the Tianma TL057FVXP01 DSI panel,
found on the Motorola Moto G6.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 .../devicetree/bindings/display/panel/panel-simple-dsi.yaml    | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
index fbd71669248f..ed674b57a304 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
@@ -55,7 +55,8 @@ properties:
       - samsung,sofef00
         # Shangai Top Display Optoelectronics 7" TL070WSH30 1024x600 TFT LCD panel
       - tdo,tl070wsh30
-
+        # Tianma Micro-electronics TL057FVXP01 5.7" 2160x1080 LCD panel
+      - tianma,tl057fvxp01
   reg:
     maxItems: 1
     description: DSI virtual channel
-- 
2.30.2

