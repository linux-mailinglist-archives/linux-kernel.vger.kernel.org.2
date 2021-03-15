Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D20A33B158
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 12:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhCOLlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 07:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhCOLlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 07:41:11 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47325C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 04:41:11 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id w34so19229681pga.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 04:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DhxSzlXHtGlfEeBFDHzLfSiaE4UuFtHOZg5BLqDfKGQ=;
        b=li20L3BagNhJ0hbClmRmAWso+KjpQm0+6SWwVscsDqjd1IBhbyes1oh9L3WY0XqzCi
         TwLuzXfXZ78sKf0neiGKXJfckB9jKS9eimN+pSdGuk8Qv0zOKeIgFIl65uOsJrADiUIT
         StRZqdTmNCT46uadcyIZjPiMXf1daznABqjV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DhxSzlXHtGlfEeBFDHzLfSiaE4UuFtHOZg5BLqDfKGQ=;
        b=Gyxxe72g7Qm3DZDPnU1tL49vDjEyzHnt8/o/euQky1XG4IOgMsvfJCh7LZF4rzl77x
         iEQA4ILJQ/8vtSGWf5/9gIRtdFdEnxn9IvawUAjs9ZMS7+xLTUGaD4lTglv02CEBCpie
         +z+dDC+1HeXiI+mqhbPWEOMezUww4fpQ2E10apXrTd36rL9/Ia7bt/BsXpc8nsqh92nA
         +YTQrzxrnfUTGCYiZ0Sp5a1HwWWd/kj+ioqsQa8xCBZGqqyvjItNYoLk/1O9LbqUvkfC
         GrEn269p3FC9Eyl88SmfEWtyTHx9UEYhA2/AhLZkDNGJ92XCQY8PqMGGR4YdNuabYsHm
         e9IA==
X-Gm-Message-State: AOAM531EC2erSbhCKUjHlXaDtHcXrSYOsWvyNMYJiiawTx53jZu84Z5C
        xnmAtu9Lleu+e+lxfwj82xVCmUL/6He6c1O3
X-Google-Smtp-Source: ABdhPJz7AGpl1rifUGBo2AufTSWcYkSCUhsjpApraQYLxQUj2FrnggU00tSjLByDU+D514QI6cCCFw==
X-Received: by 2002:a63:c702:: with SMTP id n2mr22349356pgg.382.1615808470067;
        Mon, 15 Mar 2021 04:41:10 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:89b7:339b:c097:5ebb])
        by smtp.gmail.com with ESMTPSA id u12sm13192621pfn.123.2021.03.15.04.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 04:41:09 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Ben Ho <Ben.Ho@mediatek.com>
Subject: [PATCH v2 1/2] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-damu
Date:   Mon, 15 Mar 2021 19:41:03 +0800
Message-Id: <20210315114104.1241622-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mt8183-kukui-jacuzzi-damu board also known as ASUS Chromebook Flip CM3,
using mediatek mt8183 SoC.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 93b3bdf6eaeb..a86716cdd408 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -125,6 +125,10 @@ properties:
               - google,krane-sku176
           - const: google,krane
           - const: mediatek,mt8183
+      - description: Google Damu (ASUS Chromebook Flip CM3)
+        items:
+          - const: google,damu
+          - const: mediatek,mt8183
 
 additionalProperties: true
 
-- 
2.31.0.rc2.261.g7f71774620-goog

