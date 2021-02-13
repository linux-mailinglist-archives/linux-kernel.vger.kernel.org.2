Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F30D31AB4E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 13:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhBMMXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 07:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhBMMXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 07:23:42 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4ABC0613D6;
        Sat, 13 Feb 2021 04:23:02 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id j12so1258974pfj.12;
        Sat, 13 Feb 2021 04:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UwsSeUNNKvf0P+u3/VBnSdTVeBy4Lxz1fah/cTXhS24=;
        b=Z5gcsUgheUTqMuhUtEsRCaymVpmkzsNcxY/rSe5yPwLnlQpiBgfqmdqWyCVk9F9axU
         ZEiFTT6Sajy52Jg4gQ6Oc8ygLvb8a2BSyBAFZrhS8u9RN1t9yII7da62UUesRurAXl2G
         XvW/7e3CZUfxzGtrdCLzLVnfhL0F+lIXoYyxmtsx2aMZqDetR9j27jPkZN79jsmSb6ib
         D9KAPnxNF2ikGN/yHQj9fVYUJwRRUbgm9GUJxdv6kxjOAvMCkwzB7nC9TSde4O5Mrx1h
         oBGl/WP/q+la+qiT4/NOmOo4h/cAV32i9hL1GC1/mWbDyLjI6C4hlJAU0ZExESh6EKLG
         0PdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UwsSeUNNKvf0P+u3/VBnSdTVeBy4Lxz1fah/cTXhS24=;
        b=kEfkifFKjDHhsvADfsyq+TTJMLRe0/7NfIT6IhYcZp0DRlL0afGrmARWNouQAVTiHc
         lJgaeuhD5WJmU2G9bzMw/foxFt5PVWs8UQtSk3KzhlhlHAZxYBwu0+KvyldV0LHa6fEd
         PwK38liK0djWKgSEqQ7a1eo+NP5OqbioknlJXwG3mRm/hYqEo7vkDYInNU5NCi813U4M
         272KiAxTv0u6CLz8qZTUCH3zGkPaQpQgn4M8xKC0Yrh+A/btDrsNRVN0JHhpIK4VCfwr
         cV1QoX+jhMXAj2IxyLL9xsn77wMWSkX7dSWkRcctnDbbxqfB76/hLrL5V6ZAKYATTlol
         TKCQ==
X-Gm-Message-State: AOAM531oZDMx9lFtjxd4Cg/rTDi2a3s1KMeY76aAcNTUFrckUfxCTvRN
        YQCVKJNFlXSZmjZ0G+WiMlY=
X-Google-Smtp-Source: ABdhPJxSbZynzYn++7AzRR6wXb78p8Zj0SLEju73UOO5CIHt/IFHOEb6x3SMdtP5M8b9BsED8HX54w==
X-Received: by 2002:a63:da4a:: with SMTP id l10mr7373851pgj.222.1613218982090;
        Sat, 13 Feb 2021 04:23:02 -0800 (PST)
Received: from localhost (li1438-199.members.linode.com. [45.33.111.199])
        by smtp.gmail.com with ESMTPSA id u3sm12897550pfm.144.2021.02.13.04.23.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Feb 2021 04:23:01 -0800 (PST)
From:   Orson Zhai <orsonzhai@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haidong Yao <yaohaidong369@gmail.com>,
        Orson Zhai <orson.zhai@unisoc.com>
Subject: [PATCH v2 2/3] dt-bindings: mailbox: Add interrupt-names to SPRD mailbox
Date:   Sat, 13 Feb 2021 20:21:42 +0800
Message-Id: <20210213122143.19240-3-orsonzhai@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210213122143.19240-1-orsonzhai@gmail.com>
References: <20210213122143.19240-1-orsonzhai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Orson Zhai <orson.zhai@unisoc.com>

We add an optional supp-outbox interrupt support to SPRD mailbox driver
with newly added sc9863a support and change to configure interrupts with
names in device tree files.

Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
---
 .../bindings/mailbox/sprd-mailbox.yaml         | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
index 26a5cca3f838..67736450ee93 100644
--- a/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
@@ -15,6 +15,7 @@ properties:
   compatible:
     enum:
       - sprd,sc9860-mailbox
+      - sprd,sc9863a-mailbox
 
   reg:
     items:
@@ -22,9 +23,18 @@ properties:
       - description: outbox registers' base address
 
   interrupts:
-    items:
-      - description: inbox interrupt
-      - description: outbox interrupt
+    minItems: 2
+    maxItems: 3
+
+  interrupt-names:
+    oneOf:
+      - items:
+          - const: inbox
+          - const: outbox
+      - items:
+          - const: inbox
+          - const: outbox
+          - const: supp-outbox
 
   clocks:
     maxItems: 1
@@ -40,6 +50,7 @@ required:
   - compatible
   - reg
   - interrupts
+  - interrupt-names
   - "#mbox-cells"
   - clocks
   - clock-names
@@ -56,5 +67,6 @@ examples:
       clock-names = "enable";
       clocks = <&aon_gate 53>;
       interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "inbox", "outbox";
     };
 ...
-- 
2.17.1

