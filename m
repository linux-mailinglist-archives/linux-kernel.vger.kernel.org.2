Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F103A346569
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 17:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbhCWQhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 12:37:21 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:35552 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbhCWQgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 12:36:45 -0400
Received: by mail-io1-f51.google.com with SMTP id x17so7064611iog.2;
        Tue, 23 Mar 2021 09:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VXRg8g46EQQdfaQQE5j+9aJCuQ11jH3qTJJtKuhoDX4=;
        b=cTkIPFrgBkWDtylgnzlKjNTmGIhkf2Wa2H7I6rnmm45evBWpqIjcobIKbZPmUT0mDi
         9ZF0eTOQw1Wdtoe0FOpUJW8SK0IH4sys/mOdRf3hwcGtph4B4nM6dLy3sqStycY4to1U
         Ik4KOqjf7IhUgfBMJ+yDlHlz0lGbbth2oVXiw+acFd01lS7B5txqsuI1JIVOv2pvm+Ol
         bvcFOae8WS5sXUvcXUDL+sbDRFD4GnN7FZBIWvACQ4JVD2pxnMj2tWiZ7XGdcjCcjkOK
         8LCOR2xt5E+16CylP6WVCDwm178SGWkGLZeiJnX8S7fbQsMLiHGFJ3YWW4tp+/rX2axz
         wB4g==
X-Gm-Message-State: AOAM532Lw3rYzOUBoKIA6lvMleTi6Q7Q5NdlQAohZE9XyDJN6kX/oEll
        ghmWYQKeCKq/KnSDEE9IbQ==
X-Google-Smtp-Source: ABdhPJwiD4IP2KKeyuJ/y+wBT2DqL20iY/vmH0Iz5F5gZwG4IlajzysJQDKNcuox7dUAwqmvuthNAg==
X-Received: by 2002:a6b:b587:: with SMTP id e129mr5090193iof.19.1616517404673;
        Tue, 23 Mar 2021 09:36:44 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.253])
        by smtp.googlemail.com with ESMTPSA id r18sm9771268ilj.86.2021.03.23.09.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 09:36:43 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 2/3] ASoC: dt-bindings: Use OF graph schema
Date:   Tue, 23 Mar 2021 10:36:33 -0600
Message-Id: <20210323163634.877511-3-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210323163634.877511-1-robh@kernel.org>
References: <20210323163634.877511-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have an OF graph schema, let's use it for the
audio-graph-port schema.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/sound/audio-graph-port.yaml      | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
index 9f68142c9ae3..43e7f86e3b23 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
@@ -11,9 +11,10 @@ maintainers:
 
 select: false
 
+allOf:
+  - $ref: /schemas/graph.yaml#/$defs/port-base
+
 properties:
-  reg:
-    maxItems: 1
   prefix:
     description: "device name prefix"
     $ref: /schemas/types.yaml#/definitions/string
@@ -25,10 +26,8 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
 patternProperties:
   "^endpoint(@[0-9a-f]+)?":
-    type: object
+    $ref: /schemas/graph.yaml#/$defs/endpoint-base
     properties:
-      remote-endpoint:
-        maxItems: 1
       mclk-fs:
         description: |
           Multiplication factor between stream rate and codec mclk.
-- 
2.27.0

