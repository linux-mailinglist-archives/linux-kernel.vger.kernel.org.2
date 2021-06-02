Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE223981A7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 08:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhFBG4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 02:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhFBG40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 02:56:26 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489E2C06174A;
        Tue,  1 Jun 2021 23:54:44 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id v14so1451630pgi.6;
        Tue, 01 Jun 2021 23:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wQcRpX1GVoDBUQXFUYpbeCcwiOn/D1hX7CC5ehcUovI=;
        b=Cc01z3Nfcd6Nv41ZsKvNNxytIgz0UtV+N4hh1OZqwogY8TnFcxI5wKIVIOqCqsFzbs
         BGpG1UAm0zEfLzH/RWdCQ4DWYQSd9w7i9xGKD8WG3ONTuTC8ruu+Z8y5I5Hk8NOL6xmV
         F/n9YJ5/NGCaLoNcsdMw58UJYVaKUFHAy5Mm2FNBVPECZQZrAE/eW8uNE5GGdXsqUJ4n
         TE44mI24AiPZg6fGij5+gVwR7NF1sIWK3FHscTayl86pCMdCpQiWu+s5Ra551kf945nD
         7K4cYDP//X3U8LRvley/a3vX8a2xEH+czHcFBoIiHpjUsawW4LIY6rC3v99s+wQF5dQw
         6oSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wQcRpX1GVoDBUQXFUYpbeCcwiOn/D1hX7CC5ehcUovI=;
        b=CaJgKidyNPXupIMR6OesYMZjaO7f7VjPdMMN0u58Tt9kMzyof36mUjW9r5uEm+t7r1
         tK1GkyUCgHOn1yV9hi1vvOQ/AoB4d4HuV2jM9c5mT3lJ67/gzbPULTxKFm5pZs10G7zS
         GoP2qJun6obCJI9rJhuilt5hr50fpWtm62s4/MAlZxlmRs/36VA5YNLnKybu/HOSLy1q
         4N7w7TAQxGu3n9DdANGAV/7sQxV+kdQZ3phn9O1VO3y8RXtbKdbcE48Fr9kPUFTNYP06
         DN06j/ynu99UJX2D6UGcGxFop9q1Oxnwu4jUPpXnmRG/4vanmeFva5MjwzYjhPf3Qqcz
         elEQ==
X-Gm-Message-State: AOAM532ciI3qpbb6WgB9SsmRvWMFWt7ufi4BRPW2EZkz2V8A7WOEntAY
        qd6zzswkcBVampCIaqyLsxk=
X-Google-Smtp-Source: ABdhPJzhY8w2ASZLFkI0JvBa907knpBNJtUHj5s2ZHEwZsey7YS1oZo/6jay034aCxOB+7HFka++Dw==
X-Received: by 2002:a63:1d2:: with SMTP id 201mr32583827pgb.3.1622616883726;
        Tue, 01 Jun 2021 23:54:43 -0700 (PDT)
Received: from localhost.localdomain (1-171-13-27.dynamic-ip.hinet.net. [1.171.13.27])
        by smtp.gmail.com with ESMTPSA id h6sm15190351pjs.15.2021.06.01.23.54.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 23:54:43 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, gene_chen@richtek.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        cy_huang@richtek.com, gene.chen.richtek@gmail.com
Subject: [PATCH 1/2] regulator: mt6360: Add optional mediatek.power-off-sequence in bindings document
Date:   Wed,  2 Jun 2021 14:54:34 +0800
Message-Id: <1622616875-22740-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add optional mediatek.power-off-sequence in bindings document.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Hi,

Originally, we think it must write in platform dependent code like as bootloader.
But after the evaluation, it must write only when system normal HALT or POWER_OFF.
For the other cases, just follow HW immediate off by default.
---
 .../devicetree/bindings/regulator/mt6360-regulator.yaml       | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml b/Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml
index a462d99..eaf36e2 100644
--- a/Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml
@@ -24,6 +24,16 @@ properties:
   LDO_VIN3-supply:
     description: Input supply phandle(s) for LDO6/7
 
+  mediatek,power-off-sequence:
+    description: |
+      Power off sequence time selection for BUCK1/BUCK2/LDO7/LDO6, respetively.
+      Cause these regulators are all default-on power. Each value from 0 to 63,
+      and step is 1. Each step means 2 millisecond delay.
+      Therefore, the power off sequence delay time range is from 0ms to 126ms.
+    $ref: "/schemas/types.yaml#/definitions/uint8-array"
+    minItems: 4
+    maxItems: 4
+
 patternProperties:
   "^buck[12]$":
     $ref: "regulator.yaml#"
@@ -42,6 +52,7 @@ examples:
     #include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
     regulator {
       compatible = "mediatek,mt6360-regulator";
+      mediatek,power-off-sequence = /bits/ 8 <0 0 0 0>;
       LDO_VIN3-supply = <&BUCK2>;
       buck1 {
         regulator-compatible = "BUCK1";
-- 
2.7.4

