Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D2F39CF46
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 15:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhFFNJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 09:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhFFNJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 09:09:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8632C061787
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 06:07:32 -0700 (PDT)
Date:   Sun, 06 Jun 2021 13:07:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622984851;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TKznpwkJ1SXxrF4PSQx+avWfDR6o9bxtnNRFYfgezKQ=;
        b=REdHNjrRTo6YSoWwNziHiPLU6MhDd1NgzXizF7r68iPUXdyT+geuEzCxYgpzbwtNeAfc/n
        VEmrokg2nS8NMbw3qw23bMGw1Wemnk5lKyWvgbHt3aV063fMkLISU7rnlXFWs1efRnI00q
        EsrynycyRWD9hTLlFaJuxga1sniM9EvScdVBvusczyROSF9unGWa22yKZMKxbCRV5FRJ5H
        6y0a7Q8aFk9Hhd5/13AfbVv9Rs0ZuwJz5p4Wd3tkidFCldhE7+SFN53xC/YRsREh5Zn+Fy
        SKeoA35Ag9qV5KVu8l+W9iFtHQrbj5o52DnDWTKj+7cZ8mOfY4qDfPcvs10Qgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622984851;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TKznpwkJ1SXxrF4PSQx+avWfDR6o9bxtnNRFYfgezKQ=;
        b=RltjuxE4Kb3lrUKfEvClxSyYTFZjJCqtDpug+ymh2AenyIsBfikIQRbZlgIP8QymeFLLGg
        nbEG5GW7E8RUN9BA==
From:   "irqchip-bot for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: irqchip: renesas-irqc: Add
 R-Car M3-W+ support
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        niklas.soderlund+renesas@ragnatech.se,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: =?utf-8?q?=3C55d2c30cb14b2e10193a7fd4aa7670c70f360037=2E16225?=
 =?utf-8?q?46880=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3C55d2c30cb14b2e10193a7fd4aa7670c70f360037=2E162254?=
 =?utf-8?q?6880=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
MIME-Version: 1.0
Message-ID: <162298485058.29796.14880327116673909682.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqc=
hip:

Commit-ID:     e22808071d4d23596e6cc8f62588225515789031
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/e22808071d4d23596e6cc8f62588225515789031
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Tue, 01 Jun 2021 13:31:55 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 06 Jun 2021 13:54:59 +01:00

dt-bindings: irqchip: renesas-irqc: Add R-Car M3-W+ support

Document support for the Interrupt Controller for External Devices
(INT-EC) in the Renesas R-Car M3-W+ (r8a77961) SoC.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/55d2c30cb14b2e10193a7fd4aa7670c70f360037.1622=
546880.git.geert+renesas@glider.be
---
 Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml | 1=
 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,i=
rqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,irq=
c.yaml
index b67b8cb..abb22db 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
@@ -29,6 +29,7 @@ properties:
           - renesas,intc-ex-r8a774c0    # RZ/G2E
           - renesas,intc-ex-r8a7795     # R-Car H3
           - renesas,intc-ex-r8a7796     # R-Car M3-W
+          - renesas,intc-ex-r8a77961    # R-Car M3-W+
           - renesas,intc-ex-r8a77965    # R-Car M3-N
           - renesas,intc-ex-r8a77970    # R-Car V3M
           - renesas,intc-ex-r8a77980    # R-Car V3H
