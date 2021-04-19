Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06A4363C99
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbhDSHds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237869AbhDSHdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:33:32 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE6AC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:33:02 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id p19so17583790wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h2PEGOMW+3gpulsJ3q1pOUjCBVZvJJtGNOmv6/kS2ZM=;
        b=yZHvSB3fef3HnnFjWGamiYb5ZJjeXp8+WDU0fFLeest0MXpgvf7sM6naMALr2nV3r0
         OaVPutnaC6Y7Ddmmw0/Ke6QAWh2+uBV+Fwb5WDwwTFBRdN/jTEoeIPOvXzfhd2ftDYLG
         p4QCyFiYCMyseJOfmQdvccFpiNSxKQdqpwI0ryCF+PrFFYv0fbR2Oesb9EqmMjDgir5g
         hlpRH0/NPN0gqyreH5u1gXnl+PC9/j2r5bSL7m4IUvDaG9yFQMCmo6910OYdz4qChSDf
         mRdH/h9Oq7HVAmSWeE+JCikmPx2UFoRPQpHwOK/uJfC9sWTpZGtLLaqIuDh1XzIznzT/
         9LSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h2PEGOMW+3gpulsJ3q1pOUjCBVZvJJtGNOmv6/kS2ZM=;
        b=RNkw5k4n9SShMPTuAGjlwJWWqi2ipVgAFolw9jyPrh7RdjI4k2et+9ESqOVzCorKpq
         RlMhrJ9a116rNbMvYYfjO/GTO95OYnicvNb+12FcCxwJ6VqZ3xsFYco4F0WyL7zqExln
         tyTDVN4F0z4IZsXTiNCujnSovMAJHAUvX+8svq1qGgxRI14Wux0RlQC2cQewIirEdNJC
         UFCQMR+/IyEXUjmpS5N8KzKIAN2rYkGl/ejIILtwkaeU3BmgLP2cEKiaQ2HJHCGDwPam
         t0d1epfE54IVRYviDJAdI3HFq/6E4TmxJ5vEtVLr7sUGi7KTDQi7NMu+tMnR8y/WhcSV
         LFMA==
X-Gm-Message-State: AOAM530OYIYR4dGSdrMwZUhIrMLXDacPhwBIXJQsBDG7jWuvBRmSIHpR
        0cr5NAP4AMB6mXPBz8QLmyjYGg==
X-Google-Smtp-Source: ABdhPJwWOVRcnouCxuWBQ/lQ5ASbbEd+ynjH8QI7wycxaKzH87nIRpFgnrsrwB6ZhQ7D/YYr/9AhDQ==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr19913634wmc.90.1618817581576;
        Mon, 19 Apr 2021 00:33:01 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:2e82:31e6:67f1:4f33])
        by smtp.gmail.com with ESMTPSA id y125sm5492311wmy.34.2021.04.19.00.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:33:01 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 2/5] dt-bindings: mediatek: add mt8167 to hdmi, hdmi-ddc and cec bindings
Date:   Mon, 19 Apr 2021 09:32:41 +0200
Message-Id: <20210419073244.2678688-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210419073244.2678688-1-narmstrong@baylibre.com>
References: <20210419073244.2678688-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=weRuGrIrSCS/7E0z7zGXTfkieqKmo2b9b3zEqPhglEk=; m=4OhWpDRl3EWsKo2xAbHezHdcGoUrsEeovaOubbEbqC4=; p=zKmvMzMsvi/UJaeb54phx7cTaLZasyaFc1SoAWluN64=; g=bc9c5611c788292574b503426cd53c1df4c9afa2
X-Patch-Sig: m=pgp; i=narmstrong@baylibre.com; s=0xA4CFF8AE; b=iQIzBAABCgAdFiEEPVPGJshWBf4d9CyLd9zb2sjISdEFAmB9MgwACgkQd9zb2sjISdHkERAAk+N +2dE9zUrVcQjhb8YopX7VKUMGbIIP9PuZo9jpMxJOiARMjBObXYlVFKIabe6tjTwGJOmdd7UJRCRN Q5arXTAze7ZBggM4NU9T5iGkUf8q1PCfsfKWVKwpRLAe517LqsBICviVOlivfrokYS2wrD4y6YvBJ fuisd9b7iwfSrPSr0bUkxCdrMoOwasYUrsLDygxYcQeE7++YZnBjVfdiiP0G05ktzUdbxruMOOSN1 Ox3hrMIKqujAGnSaqSi5TXssVrSUMU9R1qb9nZ/M6SEEBoQ8+HNRQDAM2NfDGqy0cNoCVUzvJ/Yt1 r6D3xKSWFpzqKXkQTR8tdpTy4wXeeLJdKdZnlNXbpyNCdTAGKZS/kAbul8/TMKRdWwBr0hUYZlz4I nq3NdEkJOq5by7N2JZk2dzXUmxcmvzg7SADvoQRBhi4TgVTo4Z92XMDaX3dcjErqWARwGw7mUhSMZ yuaVibaskfGYgBQbKhMdft/+JMW/HA5SB9DHhDKZLsyIa9emSThNz94R95xeJ+xeIEcQFWrwBvDS2 gRMT+iay39T04/VYfwkq0RJxD+9Bwz4XqWH6awDvAlprJmQRPwGnUkh+3cQUjEIMTTSfU8uDPbECl 03oxBby4nmvDVtxMFk5jb/vDz+b12P3pYj9ZBYgM+IrTEETFaVALYE0F2LmFyDaQ=
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
index b38d8732d7e0..66288b9f0aa6 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,cec.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,cec.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - mediatek,mt7623-cec
+      - mediatek,mt8167-cec
       - mediatek,mt8173-cec
 
   reg:
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi-ddc.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi-ddc.yaml
index c8ba94d6908b..b6fcdfb99ab2 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi-ddc.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi-ddc.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - mediatek,mt7623-hdmi-ddc
+      - mediatek,mt8167-hdmi-ddc
       - mediatek,mt8173-hdmi-ddc
 
   reg:
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
index 6a144faed682..111967efa999 100644
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

