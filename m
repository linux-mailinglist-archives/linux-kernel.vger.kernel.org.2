Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427DE3AB708
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbhFQPMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbhFQPMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:12:00 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17C8C061768
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 08:09:52 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id x6so1829554qvx.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 08:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cEGpwhG6p5ve4HkGton1AY3pWTWRxR5OFRUm+6IG0BM=;
        b=xOFHogCXEUwOHUdEDKDozRhp448e/RJv4gH5fgQt3uM+WNHVNeqW4RXEh0BjTOI9Z1
         /1Ih6xJ5hbonfI5R6h9/cm20h8UAaL1BjYocAjjxlUSiSV03t/D6d0tlUhqqz4R3F/hT
         qAOA3PEBj3JGArvQnGFFwbbmw1n1tNGwbZ5Gf6SsUqRZCm8vTHw6d+YJOucH9nmCmnwG
         0PW1zxFM4D+CfMI4VdX53JrWmDR4DNWkrGEEoz1CSt6Q3+LtQf9k5IppfQledl/Uvcbm
         lngUFfWQ6m/QCRY/rroLBMjXE1APF7TVGC33tAzfTyhVtfYV3gkw/y/KbRaCzTi7iqgQ
         rsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cEGpwhG6p5ve4HkGton1AY3pWTWRxR5OFRUm+6IG0BM=;
        b=GixxRlP9uas68w7T0YpKOjjybdycMdV5xV4bOHyUbnGFV7A7pE43drqw3BSlgfGosC
         u2omiMAisPB9yQRUjQUkhXRGkxRtUo7IUVY/NKG8R/mPW5KxXSyK29W8pb3TxhQnjGvP
         DXEMFnfhc6vUhJ6lk+swKKKb9abqlITi/+H3lSiGSTRDeKDXQpL2/zTYPobAMK04h9P3
         l3sY5i2ygCsFDqI95r0ojDecCdMAcLjmmOKd9LOgCZHLC7XuWmzoL2zX3zxQeqakWtau
         13dUo6MspN+RFv4kR3g4w0EeCvkCvHpZil0Hoo8rZZqfX4XDU5BcXMtpmgsgZM/eiyJd
         ap4Q==
X-Gm-Message-State: AOAM5302+7H8gmyfTcZLCSmRhg1+UzAwZI+wyY23GBJ0+/tqvWbNJ18u
        SoCCnDVO3yMxe6Wc48zYawI1Gw==
X-Google-Smtp-Source: ABdhPJwkwzkpMneGJhGYpV8v3Sy02fJEBm5RVWSNvS4VXlzOYBId9bl24tw7PJEscZEom7rxwflAWg==
X-Received: by 2002:a0c:e84b:: with SMTP id l11mr390498qvo.36.1623942592025;
        Thu, 17 Jun 2021 08:09:52 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id g82sm1915427qke.119.2021.06.17.08.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 08:09:51 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/3] dt-bindings: msm: dsi: document phy-type property for 7nm dsi phy
Date:   Thu, 17 Jun 2021 10:43:34 -0400
Message-Id: <20210617144349.28448-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210617144349.28448-1-jonathan@marek.ca>
References: <20210617144349.28448-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document a new phy-type property which will be used to determine whether
the phy should operate in D-PHY or C-PHY mode.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 .../devicetree/bindings/display/msm/dsi-phy-7nm.yaml         | 5 +++++
 include/dt-bindings/phy/phy.h                                | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
index c0077ca7e9e7..70809d1cac54 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
@@ -34,6 +34,11 @@ properties:
     description: |
       Connected to VDD_A_DSI_PLL_0P9 pin (or VDDA_DSI{0,1}_PLL_0P9 for sm8150)
 
+  phy-type:
+    description: D-PHY (default) or C-PHY mode
+    enum: [ 10, 11 ]
+    default: 10
+
 required:
   - compatible
   - reg
diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
index 887a31b250a8..f48c9acf251e 100644
--- a/include/dt-bindings/phy/phy.h
+++ b/include/dt-bindings/phy/phy.h
@@ -20,5 +20,7 @@
 #define PHY_TYPE_XPCS		7
 #define PHY_TYPE_SGMII		8
 #define PHY_TYPE_QSGMII		9
+#define PHY_TYPE_DPHY		10
+#define PHY_TYPE_CPHY		11
 
 #endif /* _DT_BINDINGS_PHY */
-- 
2.26.1

