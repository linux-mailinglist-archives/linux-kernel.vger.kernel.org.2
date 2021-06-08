Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579F03A04CD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbhFHT6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:58:40 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:33571 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235597AbhFHT63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:58:29 -0400
Received: by mail-qk1-f169.google.com with SMTP id k4so21517223qkd.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 12:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FRQbUUCJlhW9ygh9vvAmC6+FxFn5VHFTqyQsJoOuIsw=;
        b=Ca/6Ad6FX+g+Vqk4WnMo2PAkqaNvB1HEXCYUDPKBU8/t7N0r6otFmQg71xm8AXQeDa
         UJBRVWbsjTPmOvoMYOC3gjZYaQeKp/8PBxj4S99oFGkAgqcC0AqV92zp3YOFnsTQktGs
         NtCNZl7mmbPUQ05Wpp1lE4rkbFHroRLkKCMNO9xF3gSpadAcePhwsoAHlPl6wzummC88
         g4vS7utFFbr8PPp9VFSH+WgM0obA06qjCTzzAXo2rB/jva+DTa0She9+4Ob7jFliRZp2
         wSCbeV8vrrrJkOXWN5A3OqXeQJeGvL1r6TVDpGZZsjbf+k0X+mRbgzYUVyjXfQU8PMv1
         kPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FRQbUUCJlhW9ygh9vvAmC6+FxFn5VHFTqyQsJoOuIsw=;
        b=E1K8nd4KZxyR+QV2Y3OCSj3ypsrKaqspg3xu/kt5CsPbbA5tHbR74zoud8G5QgvFgw
         jd0JXCv1STMvvaOhvf6LAK8dopy45dfXNOeV/CsvhsjsJMmdwnwUoQ1ZL9LTxKqgbvss
         yhhz51Ar8iEE9hbvTLePwFioqNQ0LXfAZeDyNvuwc1ifodUHrstgg8E6u7ZNBENys/BN
         8BKc7yYJ2s+Aq2LLP0sQdqbXKKI3rmCRpMfSCJA3cIXiR2AUdlt8Ed6yT0eB9Teb6+y+
         NHZ1d5ceH+4qX2D2GNAYumCIZZ/qmaSZ/YsHasI0F4dsBNL7JEdtMi4iLKCSDdfPDdiH
         jQSg==
X-Gm-Message-State: AOAM532BBnxhqDNc1W7fZNEtbT79T2PCcWQg3kEWblNg7aBxmu25zSbk
        WJzOM4iRQOWeiFgRhCn8gqYfCg==
X-Google-Smtp-Source: ABdhPJz5fLjQW8AxvyM5NR001PVs62aqLYDy8D6ESFST46GKsM4Pdfn29/ZZkv02E9ikOnZhhzqr4g==
X-Received: by 2002:a37:444a:: with SMTP id r71mr23015575qka.381.1623182136135;
        Tue, 08 Jun 2021 12:55:36 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id l141sm643687qke.48.2021.06.08.12.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 12:55:35 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/3] dt-bindings: msm: dsi: document phy-type property for 7nm dsi phy
Date:   Tue,  8 Jun 2021 15:53:28 -0400
Message-Id: <20210608195342.18269-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210608195342.18269-1-jonathan@marek.ca>
References: <20210608195342.18269-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document a new phy-type property which will be used to determine whether
the phy should operate in D-PHY or C-PHY mode.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 .../devicetree/bindings/display/msm/dsi-phy-7nm.yaml          | 4 ++++
 include/dt-bindings/phy/phy.h                                 | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
index bf16b1c65e10..d447b517ea19 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
@@ -34,6 +34,10 @@ properties:
     description: |
       Connected to VDD_A_DSI_PLL_0P9 pin (or VDDA_DSI{0,1}_PLL_0P9 for sm8150)
 
+  phy-type:
+    description: |
+      D-PHY (default) or C-PHY mode: PHY_TYPE_DSI_DPHY or PHY_TYPE_DSI_CPHY
+
 required:
   - compatible
   - reg
diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
index 887a31b250a8..b978dac16bb8 100644
--- a/include/dt-bindings/phy/phy.h
+++ b/include/dt-bindings/phy/phy.h
@@ -20,5 +20,7 @@
 #define PHY_TYPE_XPCS		7
 #define PHY_TYPE_SGMII		8
 #define PHY_TYPE_QSGMII		9
+#define PHY_TYPE_DSI_DPHY	10
+#define PHY_TYPE_DSI_CPHY	11
 
 #endif /* _DT_BINDINGS_PHY */
-- 
2.26.1

