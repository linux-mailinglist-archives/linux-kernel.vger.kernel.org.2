Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337473A436B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhFKN4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbhFKN4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219EEC0613A2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 06:54:33 -0700 (PDT)
Date:   Fri, 11 Jun 2021 13:54:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=covPa+goHeNDsp+Y4nwtH7ED/6XkYIfxwCim2SBnvog=;
        b=T/qHrISdZMz3ffaqIAYs0FzXO8LwgfjU3/i/ON8PAnTsMwSgmoJT7/En7uFJMpAQlicZK2
        lm92OwqzXPqpocJtJrvALTFtnR17EAIW86+rs8IBg3gURsFgJh11nzskWtM4umP3NEImLQ
        +leU5V9aYwpL1g09XhlacCjPhkGufZoppcqnIgEM4YlkbloVbyKqijkGRif3K/ECQekfA5
        HwhgeLpUNcA9AE1Bi8pqUZQjqhFMpVZEqezIO77cQX6odwvxMpH2cW2uwKDZdZtchdRaKT
        nHmOp4iehUlrFIUKOYfRBprV17E+Wk7CuwrMzcniHrbFBxDwJwiRuAGJjgMPhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=covPa+goHeNDsp+Y4nwtH7ED/6XkYIfxwCim2SBnvog=;
        b=rrh+cdA1OWHonMpLYGau4YD9Uenqlt7NTmQht+N+Xq9pVHY6GVM7BKyMgwcfIFgPPwPXPI
        KheUpyAxli/aLNBA==
From:   "irqchip-bot for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: interrupt-controller:
 arm,gic-v3: Describe GICv3 optional properties
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210609155108.16590-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210609155108.16590-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <162341966935.19906.17116959490451790585.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     4e08a559a18c1b6424e56859c74adb4b29c17318
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/4e08a559a18c1b6424e56859c74adb4b29c17318
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Wed, 09 Jun 2021 16:51:08 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Jun 2021 14:26:31 +01:00

dt-bindings: interrupt-controller: arm,gic-v3: Describe GICv3 optional properties

Describe the optional GICv3 properties:
- clocks
- clock-names
- power-domains
- resets

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210609155108.16590-1-prabhakar.mahadev-lad.rj@bp.renesas.com
---
 Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
index 1ecd183..c84f9fe 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
@@ -145,6 +145,19 @@ properties:
         required:
           - affinity
 
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: aclk
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
 dependencies:
   mbi-ranges: [ msi-controller ]
   msi-controller: [ mbi-ranges ]
