Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1683EF112
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 19:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhHQRsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 13:48:32 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:37550 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhHQRsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 13:48:30 -0400
Received: by mail-ot1-f49.google.com with SMTP id n1-20020a9d1e810000b0290514da4485e4so23072442otn.4;
        Tue, 17 Aug 2021 10:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4YfAdp6URMwEzxS/XiQNwuq815IjwGiZo7iZNdeIi3M=;
        b=mC2p42Mz28+W1wCeWv52b7w/zfpSbTTmp21UFXlJ6SbR1cKvpAJFIW+fi20Dz8lbvO
         Eqh2bpnh6SG5+ov7qENz5AhbMqgpxmAYPE6g8oK7U4q5ewgrhR/XsrGt8KVfwz4CRlXt
         ZYY/tGJA3Dfrm7F0WzdprwuKQ1y6pxHktCoVfBgxzDF0Cf4I7xafI305pj41h1H3Kspy
         9qZ2C7JGBwZUnRI3cSnYD5MBKgzzLO6+tGGLOoE4aESUMtyKZBiV1xJuzN4moo7OCQSy
         Cr2qUkUXVEQrPa3WSSd4qXUOKAQVufLeMJsiOP2om/P01ErqqcTX0WFKhn+kBplZEM6G
         ytzg==
X-Gm-Message-State: AOAM532N0EfOAc9+rZ1VwA8zRdqWbeZd5K4WVBAd8QTYEjw+7BTeZUNB
        h7TjupkY8vaYAd1iqudW9XI/fFcCaw==
X-Google-Smtp-Source: ABdhPJy7VVi+GLOzKivpGy0YvumVaoyarVaWyaesbRopUsLuB4FE1R2sf4Hyp3lR/rjUoReBiRlr1Q==
X-Received: by 2002:a9d:4785:: with SMTP id b5mr3566539otf.188.1629222476823;
        Tue, 17 Aug 2021 10:47:56 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id o24sm617304oie.17.2021.08.17.10.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 10:47:56 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Yash Shah <yash.shah@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: [PATCH] dt-bindings: sifive-l2-cache: Fix 'select' matching
Date:   Tue, 17 Aug 2021 12:47:55 -0500
Message-Id: <20210817174755.541735-1-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the schema fixups are applied to 'select' the result is a single
entry is required for a match, but that will never match as there should
be 2 entries. Also, a 'select' schema should have the widest possible
match, so use 'contains' which matches the compatible string(s) in any
position and not just the first position.

Fixes: 993dcfac64eb ("dt-bindings: riscv: sifive-l2-cache: convert bindings to json-schema")
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Sagar Kadam <sagar.kadam@sifive.com>
Cc: Yash Shah <yash.shah@sifive.com>
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/riscv/sifive-l2-cache.yaml        | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
index 1d38ff76d18f..2b1f91603897 100644
--- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
+++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
@@ -24,10 +24,10 @@ allOf:
 select:
   properties:
     compatible:
-      items:
-        - enum:
-            - sifive,fu540-c000-ccache
-            - sifive,fu740-c000-ccache
+      contains:
+        enum:
+          - sifive,fu540-c000-ccache
+          - sifive,fu740-c000-ccache
 
   required:
     - compatible
-- 
2.30.2

