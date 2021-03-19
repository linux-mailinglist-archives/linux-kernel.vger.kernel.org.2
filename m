Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDD234154A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 07:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbhCSGQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 02:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbhCSGQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 02:16:36 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74B4C06174A;
        Thu, 18 Mar 2021 23:16:35 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x126so5162072pfc.13;
        Thu, 18 Mar 2021 23:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6H39MwURiIvie/1ewMPHtMHwmb2V7QM8qVfw4cNWYII=;
        b=hPFKBgxGJYU4z7cQkoEv7PztD5klbScp72g6s1bpUo1mAQO08s2oCuUjUQ9NSYGf8D
         3XBTTyeuQcb8nNTEeIF8Zbbt8MrKqyVlTEB6lfXQrQF4AwRGpdsRU6+n+331A5eixKRa
         sSiinyIVdaifU7bQmNY+oVT+ZkvpWNr4yEwVmwQ6sxVxga9ybyB8CPu8lZUhCMPQurb/
         nRVlLPGx2ary9p++DDcPZ2rqkBIs5YLilgCm0/8rtEgki5AaLX2Avnlc0DUH4+8X9/Fk
         JnaTMW2oIKFik//3tKpl2mKsZEMAStZ49sgfeKu+3hpsCIe1R15V5G+TDYgdkfzfLfo1
         FFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6H39MwURiIvie/1ewMPHtMHwmb2V7QM8qVfw4cNWYII=;
        b=DPLlAM9wTpKqxfpj+cLAPMQ8aUlA3qjHNeDu+787uhTWLUIXlvp2jPAlQcbm9Tx7vX
         b42IRo0HfTGh54xs7Tjg1EVqTrbHBEpPvUHaSZlfuhr41d/Y2VXI9EcKNlHVcG0zgGOP
         kYVzve8PvHUZiTlZeq+8gWzF7DNbeVQvxjVwF2EUJo1xT54rKBU9gk5faOu2+EGsBHYP
         U9TTQVYqupyrlDglgI4ULRaPwozj3bN5mauJhXnGhkRxlVuV03dT3ttOIsfdR3acYTFY
         /8MpJy3yIPr2l1JAbhexO/inugoKBaBOBvL2IxzLRiYNPodZAlJoTxgNYff8lJj0VTOy
         L8pw==
X-Gm-Message-State: AOAM532aFPGSbfNLue16JhQ0X/Krbp3ahC4r2eyp4oY0a5s6c3CkoaW9
        u5j+kSIolj9A84s8ZLgBFVRvVojlJdVC5MsJ
X-Google-Smtp-Source: ABdhPJy7585tsw1vnBC/WE7LzHLyNvxgVSsdVga2DUXDwMSclKUnqN4+j+Ie4yPKvM2iu+EbRa1Hew==
X-Received: by 2002:aa7:92cb:0:b029:1f1:542f:2b2b with SMTP id k11-20020aa792cb0000b02901f1542f2b2bmr7500002pfa.31.1616134594612;
        Thu, 18 Mar 2021 23:16:34 -0700 (PDT)
Received: from lenovo.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id o1sm4223103pjp.4.2021.03.18.23.16.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Mar 2021 23:16:34 -0700 (PDT)
From:   Orson Zhai <orsonzhai@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, haidong.yao@unisoc.com,
        Orson Zhai <orson.zhai@unisoc.com>
Subject: [PATCH v3 2/3] dt-bindings: mailbox: Add interrupt-names to SPRD mailbox
Date:   Fri, 19 Mar 2021 14:15:36 +0800
Message-Id: <1616134537-27966-3-git-send-email-orsonzhai@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616134537-27966-1-git-send-email-orsonzhai@gmail.com>
References: <1616134537-27966-1-git-send-email-orsonzhai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Orson Zhai <orson.zhai@unisoc.com>

We add an optional supp-outbox interrupt support to SPRD mailbox driver
with newly added sc9863a support and change to configure interrupts with
names in device tree files.

Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
---
 Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
index 26a5cca..80feba8 100644
--- a/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
@@ -15,6 +15,7 @@ properties:
   compatible:
     enum:
       - sprd,sc9860-mailbox
+      - sprd,sc9863a-mailbox
 
   reg:
     items:
@@ -22,9 +23,15 @@ properties:
       - description: outbox registers' base address
 
   interrupts:
+    minItems: 2
+    maxItems: 3
+
+  interrupt-names:
+    minItems: 2
     items:
-      - description: inbox interrupt
-      - description: outbox interrupt
+      - const: inbox
+      - const: outbox
+      - const: supp-outbox
 
   clocks:
     maxItems: 1
@@ -40,6 +47,7 @@ required:
   - compatible
   - reg
   - interrupts
+  - interrupt-names
   - "#mbox-cells"
   - clocks
   - clock-names
@@ -56,5 +64,6 @@ examples:
       clock-names = "enable";
       clocks = <&aon_gate 53>;
       interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "inbox", "outbox";
     };
 ...
-- 
2.7.4

