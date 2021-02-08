Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012EE3131F5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhBHMOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbhBHLxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:53:18 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EABDC061786;
        Mon,  8 Feb 2021 03:52:38 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id x136so2994343pfc.2;
        Mon, 08 Feb 2021 03:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=li63n/VAZtM2nG+NNvpp/FSX+mYLuMQuNa5PbgMs78g=;
        b=ONCyIo3LQY78/wjuDf4j+MAV8gqQ5Hctlihc1EljMqbxkb9kPtiO+jRWBT+AZPpIyp
         Z89Y7kQu9tWVhM22RZ55g9C9TrI/mmhT3Ssi1kn6W4sD4VUiFtjOkNTzFYeFGttqbtqW
         cgjRCDbk18+4aWp3TguQUEIzyOwsnZcUYpY7dwnrskEZNfP6zTsrktbcnuYyauOgK6nN
         VoCg4RR3CdTXys5hdIZTnhvWlrs0PxShV4YMAJMlBMmpbnpbTgEAUK1lQomG0NGUD4iX
         tzswiBUKRdwtl+5xBVOsXQENg+GgjI+SkHpG1TyNu0DJW+cUupxDHYvoIJmDhz4Lo0xk
         kgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=li63n/VAZtM2nG+NNvpp/FSX+mYLuMQuNa5PbgMs78g=;
        b=dPsd4eVy3uog7mt7pBrQY+sqnAR5kBBRoLJ8XX9DHQwpu4dcbcWejOPBWpL4cOq9BR
         Wf+871tsGNtUfvtNprQK2FZs3GWu5aEJ4k8up9ouTlR5gk2HU2UfCDxRVNfCC1Q1e4PU
         +uynI5y3mquzHV9zBvI/RupV3vMLy9ksAaGtkDpfsQ+lLb6MoEdyJrZH9gXYLWcvCw5w
         N0u+Xtpg++UKSkFYYnPVWgHQlVKLzQsTMeFNekaq454C+6TxfxB38nb+toFPRYyfWmQQ
         gkltYmTwZeekqfdmPeRvm6W46pbeAhmynjW2TPUN7eGaYxJNa/itGIC0KO5LiyA4ZSxV
         FJyA==
X-Gm-Message-State: AOAM532UFgLh5xC8Lm3hSBoWWqKv5NhXPslKvn+1f2qQgnkhfq/7zNrp
        Zu6WzRMXv8jNCQrl8dQndWk=
X-Google-Smtp-Source: ABdhPJwFnmlDq/ot2AF18aA6m+LPYo0qO3qeHs+M2zEtfnCq52A+EZku+TMLmYgyll4K5EhJ0ON1kQ==
X-Received: by 2002:aa7:9e08:0:b029:1c9:b30b:d971 with SMTP id y8-20020aa79e080000b02901c9b30bd971mr17692939pfq.72.1612785158086;
        Mon, 08 Feb 2021 03:52:38 -0800 (PST)
Received: from lenovo.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id a9sm12875564pfr.204.2021.02.08.03.52.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 03:52:37 -0800 (PST)
From:   Orson Zhai <orsonzhai@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, haidong.yao@unisoc.com,
        Orson Zhai <orson.zhai@unisoc.com>
Subject: [PATCH 3/3] dt-bindings: mailbox: Add interrupt-names to SPRD mailbox
Date:   Mon,  8 Feb 2021 19:51:04 +0800
Message-Id: <1612785064-3072-3-git-send-email-orsonzhai@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612785064-3072-1-git-send-email-orsonzhai@gmail.com>
References: <1612785064-3072-1-git-send-email-orsonzhai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Orson Zhai <orson.zhai@unisoc.com>

We add an optional supp-outbox interrupt support to driver and change to
describe interrupts with names for easy configuration in device tree files.

Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
---
 Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
index 26a5cca..bb775a4 100644
--- a/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
@@ -22,9 +22,15 @@ properties:
       - description: outbox registers' base address
 
   interrupts:
+    minItems: 2
+    maxItems: 3
+
+  interrupt-names:
     items:
-      - description: inbox interrupt
-      - description: outbox interrupt
+      enum:
+        - inbox
+        - outbox
+        - supp-outbox
 
   clocks:
     maxItems: 1
@@ -40,6 +46,7 @@ required:
   - compatible
   - reg
   - interrupts
+  - interrupt-names
   - "#mbox-cells"
   - clocks
   - clock-names
@@ -56,5 +63,6 @@ examples:
       clock-names = "enable";
       clocks = <&aon_gate 53>;
       interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "inbox", "outbox";
     };
 ...
-- 
2.7.4

