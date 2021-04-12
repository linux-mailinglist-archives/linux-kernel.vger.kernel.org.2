Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927C835C2E3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244319AbhDLJwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243598AbhDLJm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:42:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F894C061378
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:39:37 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id y124-20020a1c32820000b029010c93864955so8276959wmy.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hIB5ovbW1Quy+W36SGjHdu93f090uQNPnQqmgWziz2Y=;
        b=zm2xIpJUxLvzkqUTEm7Kux2j4hsc7UsSYGnXv7d2oBzNu+GMnYnhf1z5//irUI3AjJ
         MMLBh7mFElwdI+UCUkVSCWe+ZwhCqRnhDoZkVeFLOe355xwrscIYoZtDX4Xv50XAFVWn
         8iWda9Y3ht52ceGi9cqPxCKnmugHB8RTh33+v5pFyiKNADnH3k3O/OB+pfkERYORBZuK
         5zu79RUvFTSKTwZ8+6pOdcgn60pGG74Sxq7MtkWFRG3jNyYPenQXIubqmXPT8uWucvE/
         e6Hz/7o9CqCd9w/EZJMVrGxOkoXvFolAws6QSI2o0FhzpIXWaw32OXrQLmJEX0PuVY7a
         RX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hIB5ovbW1Quy+W36SGjHdu93f090uQNPnQqmgWziz2Y=;
        b=hJX3s3Qv+Selr1x20UbC/trx/Gg4C4rxnTDtQtEGl1qmK/5+FteB4NzVUOxx3ye6bR
         y86KDzPEpJmYXeOwsbl4NzMBF3Vy+g0iH+L79qAy0RnNcBsTZODG/mMMKotqIxbB6gwG
         0rxGButfpmxqSAG1EjgzcThocMPD8Nccbstc+m7rChHmZpJkZugPqbzpnR0RzGq8rqqw
         vyyA0UPqB5Ei6NrbOXR1pdgnsjMKNULWomzfAUOfUpNoXpBoEE9BgihskY5tFDSwgPs7
         6jhQyUmE4KvxqWNruCj7EjYDweL1mm2p0evw+OZR2gayxnUjDpGefCeXwboE98/oSx83
         oeBg==
X-Gm-Message-State: AOAM531mqauz389AwJo8JfxFY8NKz5Z+7A04K+dMXq/bDWILsSUTTm8y
        azEk+kpKfNzNxevLwrTot0N6Ag==
X-Google-Smtp-Source: ABdhPJwxIfToJ6h311EOoJdSj7K3pZVeoBB4kmyIbIG0GYyMak+pMG/9kiLac5dW9hAThNV4EkUzdQ==
X-Received: by 2002:a05:600c:2945:: with SMTP id n5mr24322799wmd.7.1618220375929;
        Mon, 12 Apr 2021 02:39:35 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:4c21:b00e:ff79:bf20])
        by smtp.gmail.com with ESMTPSA id r22sm14405902wmh.11.2021.04.12.02.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 02:39:35 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 2/5] dt-bindings: mediatek: add mt8167 to hdmi, hdmi-ddc and cec bindings
Date:   Mon, 12 Apr 2021 11:39:25 +0200
Message-Id: <20210412093928.3321194-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210412093928.3321194-1-narmstrong@baylibre.com>
References: <20210412093928.3321194-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mt8167 SoC compatible to Mediatek hdmi, hdmi-ddc and cec schema bindings.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/display/mediatek/mediatek,cec.yaml       | 1 +
 .../devicetree/bindings/display/mediatek/mediatek,hdmi-ddc.yaml  | 1 +
 .../devicetree/bindings/display/mediatek/mediatek,hdmi.yaml      | 1 +
 3 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,cec.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,cec.yaml
index 408e7dfce409..23e21656ca55 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,cec.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,cec.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - mediatek,mt7623-hdmi
+      - mediatek,mt8167-hdmi
       - mediatek,mt8173-hdmi
 
   reg:
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi-ddc.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi-ddc.yaml
index c15b3470d652..9d7148b1a7c3 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi-ddc.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi-ddc.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - mediatek,mt7623-hdmi
+      - mediatek,mt8167-hdmi
       - mediatek,mt8173-hdmi
 
   reg:
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
index 9c125d7c8934..01ab0e8e02bc 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
@@ -19,6 +19,7 @@ properties:
     enum:
       - mediatek,mt2701-hdmi
       - mediatek,mt7623-hdmi
+      - mediatek,mt8167-hdmi
       - mediatek,mt8173-hdmi
 
   reg:
-- 
2.25.1

