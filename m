Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC62643E1F6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 15:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhJ1NZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 09:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhJ1NZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 09:25:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37FDC061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 06:23:25 -0700 (PDT)
Date:   Thu, 28 Oct 2021 13:23:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635427404;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kgs/qsH5tOLO8EMTfWC5dAEwDBpicjEmAyFtm6HGcZA=;
        b=CYSECXg9dKaRlVFg/ggNJUUZoEz7rJZncraE1K9wrwKPS9Qwc7VkEkJmcZpjUm1hw1OFWL
        jaYsPc/YwIGicEkpiYAdT+OGI35Cq2j1U1vU2cK7jTxJbIlCxs5BbSkqUWu1PTpG4E3IlJ
        lL+JtemtB2svgfs2NoWyyBIp/MOJ8XOHuYnOQGPAj7uI6iCsoooRLiW4sMGczjqcEALkWA
        4se3lkNY+wUHwxGl7rvWb7cnSu1R2oFTu6WTPjKnZkMieG+hmiqtice1CPxKc4QzJe8JiU
        gsU+MqoAMGSQa+zfbOfmOND0jj23Ec8KYMnkOpuJcQJpOgFqcjq1VA8Gc8SpHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635427404;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kgs/qsH5tOLO8EMTfWC5dAEwDBpicjEmAyFtm6HGcZA=;
        b=qNDhw9sVL0GDfsRKhCdlpjH6bnF1jk4fbWlB19qhCJSNZC2vm8gmJV1CCT98IrU79cNJIo
        N8tLot+IIC6bl1BA==
From:   "irqchip-bot for Marian-Cristian Rotariu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: irqchip: renesas-irqc:
 Document r8a774e1 bindings
Cc:     "Marian-Cristian Rotariu" <marian-cristian.rotariu.rb@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: =?utf-8?q?=3C53317ce1bdd1d5e517122eb5c8ea0ccaa69eba3b=2E16353?=
 =?utf-8?q?37428=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3C53317ce1bdd1d5e517122eb5c8ea0ccaa69eba3b=2E163533?=
 =?utf-8?q?7428=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
MIME-Version: 1.0
Message-ID: <163542740330.626.15868336895746257359.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     d2cf863a934b12ca3769fe4cab581d114143a35b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/d2cf863a934b12ca3769fe4cab581d114143a35b
Author:        Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
AuthorDate:    Wed, 27 Oct 2021 14:25:09 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 28 Oct 2021 13:33:58 +01:00

dt-bindings: irqchip: renesas-irqc: Document r8a774e1 bindings

Document SoC specific bindings for RZ/G2H (r8a774e1) SoC.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/53317ce1bdd1d5e517122eb5c8ea0ccaa69eba3b.1635337428.git.geert+renesas@glider.be
---
 Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
index abb22db..79d0358 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
@@ -27,6 +27,7 @@ properties:
           - renesas,intc-ex-r8a774a1    # RZ/G2M
           - renesas,intc-ex-r8a774b1    # RZ/G2N
           - renesas,intc-ex-r8a774c0    # RZ/G2E
+          - renesas,intc-ex-r8a774e1    # RZ/G2H
           - renesas,intc-ex-r8a7795     # R-Car H3
           - renesas,intc-ex-r8a7796     # R-Car M3-W
           - renesas,intc-ex-r8a77961    # R-Car M3-W+
