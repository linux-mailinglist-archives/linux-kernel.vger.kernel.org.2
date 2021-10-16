Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D9C43023C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 12:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244231AbhJPK4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 06:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244120AbhJPK4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 06:56:41 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79180C061764;
        Sat, 16 Oct 2021 03:54:33 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x192so18181040lff.12;
        Sat, 16 Oct 2021 03:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y+9bOnIXUtzWVh6jBYBC6CeR5DMs4Q+9HtnUCVf3acw=;
        b=Y8DwMJemYcnlx6P+YftUdk8rxOVY+oN0oN+w9IT2y0dmmjr6h8QRNCn2Pn49r5v/l4
         2DKzpzPjJ4Xwbv5tAkAo/CMmPoR51LIjT7XZH2HyogOWz8ilfprw/WcGZ4FdSg/jBgG4
         gxFA2LFwpBrqVRXsil0OWJkhCX+tevmoV96xJIa8sPJ2paw4J/HPrXfbuL2osgtrBAYo
         WgC1SPx8lFk3/5BEnFv2AaJuU/TSuExT5K9YaNPFbNgGSN03YgpG0CjRFe42wCwXhcsL
         np23VuYCvILThoi7s0RGJzfNsPgu1z8C+UBR/RTr+1rXEOoSU3B9hsi/LlKU73y4AMRK
         H1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y+9bOnIXUtzWVh6jBYBC6CeR5DMs4Q+9HtnUCVf3acw=;
        b=oxb80LggEs42odu3tbvxOEl1ArMqi/UBVSqLZnk2qouR6RaVdUG02wB1btB4DOQdvA
         nfnxmkhpOCIzpnaY40hvpqrKH0PEosn2csfok47EFefVGlW4+aOlLNwJAOh/XFJ9igSH
         baIu+YwJ/z7z8m8XaYkwOy3pt8KLLED4PN9suyXk3adAy5qtfjmPBIm941973j3PbkeB
         wvvObJlIhsSxGdTg+/CIzakoY8qIfVvtPx1f0NETcc3F7uYwvXIQ95aTCedkvg8vJXHM
         0WDisgsXSiLh0jwdGt2MO+a6z2DPi0YVnpqpgqt72akOnTe6ApUzgcNvusNyk6g/2yp9
         mHmA==
X-Gm-Message-State: AOAM532V3X1HIdh7qxQEzG+2xgeg8DA2U3ph635G4vTKQCFxAFzHANXG
        ewjFd9OCieV9ahl/6bP1RSE=
X-Google-Smtp-Source: ABdhPJylXH+nWmjZF01140Heh3m/n1DiYce+4V6jSo5B/7WqbKmJi/0cw7jiUYbX6TptgPDy3DEgsA==
X-Received: by 2002:a05:6512:118b:: with SMTP id g11mr16986499lfr.353.1634381671808;
        Sat, 16 Oct 2021 03:54:31 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id r3sm814224lfc.131.2021.10.16.03.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 03:54:31 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ASoC: dt-bindings: rockchip: i2s-tdm: Drop rockchip,cru property
Date:   Sat, 16 Oct 2021 12:53:51 +0200
Message-Id: <20211016105354.116513-3-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211016105354.116513-1-frattaroli.nicolas@gmail.com>
References: <20211016105354.116513-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property was only needed for a driver hack, which we can
remove. Since the bindings were not in any kernel release yet, we
are able to just drop the property instead of silently accepting
and ignoring it.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 .../bindings/sound/rockchip,i2s-tdm.yaml         | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml b/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
index ce3e18b50230..6a7c004bef17 100644
--- a/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
+++ b/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
@@ -82,12 +82,6 @@ properties:
         - tx-m
         - rx-m
 
-  rockchip,cru:
-    $ref: /schemas/types.yaml#/definitions/phandle
-    description:
-      The phandle of the cru.
-      Required if neither trcm-sync-tx-only nor trcm-sync-rx-only are specified.
-
   rockchip,grf:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -144,15 +138,6 @@ required:
   - rockchip,grf
   - "#sound-dai-cells"
 
-allOf:
-  - if:
-      properties:
-        rockchip,trcm-sync-tx-only: false
-        rockchip,trcm-sync-rx-only: false
-    then:
-      required:
-        - rockchip,cru
-
 additionalProperties: false
 
 examples:
@@ -177,7 +162,6 @@ examples:
             resets = <&cru SRST_M_I2S1_8CH_TX>, <&cru SRST_M_I2S1_8CH_RX>;
             reset-names = "tx-m", "rx-m";
             rockchip,trcm-sync-tx-only;
-            rockchip,cru = <&cru>;
             rockchip,grf = <&grf>;
             #sound-dai-cells = <0>;
             pinctrl-names = "default";
-- 
2.33.1

