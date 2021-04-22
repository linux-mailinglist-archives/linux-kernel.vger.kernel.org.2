Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D244236812C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 15:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbhDVNI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 09:08:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38416 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236310AbhDVNID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 09:08:03 -0400
Date:   Thu, 22 Apr 2021 13:07:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619096845;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FqQ3Hcoz3PXD1X8tuXrYy8AEm5+AtSMluVJlvrBpjqI=;
        b=yi0EEZZ2U1sjsWnWDYMKpWRD5p+k/TR+SUaCx+MGhsHBq3U+GekSy0p/ACQaGpcVj38xzG
        r1g/lhyTad5rTFjfYSfT0XVPw+pX+3Idr/fbzg/Q8+zd6cAidB8veVi1Y/Fqpj2DHnrCl/
        N5Fb4fwi/1vIfKPubxDjy83FbLQphuh1HckxRDLvkMZ4CgmZ1oaicWXUjaCeyNliwkIUlY
        iTsRSFavurSNLLIyGnRtEUNM1WyfDdiOfixLrWuoFRPcq0bTJxWGF5dg1HcF4MwkBLwjo5
        z2oqsgekVCUNsyRg5rnYJFqiFrhj5GIGLe+LYXQ3krR/y/6l0PFoATTilbiB/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619096845;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FqQ3Hcoz3PXD1X8tuXrYy8AEm5+AtSMluVJlvrBpjqI=;
        b=6Xbd1QEaBLeCXk716A+LtKUuvt1Lp6xDbkKpswnnlikcgXQVNYOXSBY1WEP4rhOwU5pV2y
        Ztv/7OmMrOvnhCAA==
From:   "irqchip-bot for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/tb10x: Use 'fallthrough' to
 eliminate a warning
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Christian Ruppert <christian.ruppert@abilis.com>
In-Reply-To: <20210422051620.23021-1-rdunlap@infradead.org>
References: <20210422051620.23021-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID: <161909684492.29796.7954496853919794538.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     a6992bbe9774e044d3d0f973593d655c53efe089
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/a6992bbe9774e044d3d0f973593d655c53efe089
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Wed, 21 Apr 2021 22:16:20 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 22 Apr 2021 13:53:33 +01:00

irqchip/tb10x: Use 'fallthrough' to eliminate a warning

Use the 'fallthrough' macro to document that this switch case
does indeed fall through to the next case.

../drivers/irqchip/irq-tb10x.c: In function 'tb10x_irq_set_type':
../drivers/irqchip/irq-tb10x.c:62:13: warning: this statement may fall through [-Wimplicit-fallthrough=]
   62 |   flow_type = IRQ_TYPE_LEVEL_LOW;
../drivers/irqchip/irq-tb10x.c:63:2: note: here
   63 |  case IRQ_TYPE_LEVEL_LOW:
      |  ^~~~

Fixes: b06eb0173ef1 ("irqchip: Add TB10x interrupt controller driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Christian Ruppert <christian.ruppert@abilis.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210422051620.23021-1-rdunlap@infradead.org
---
 drivers/irqchip/irq-tb10x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-tb10x.c b/drivers/irqchip/irq-tb10x.c
index 9e45649..9a63b02 100644
--- a/drivers/irqchip/irq-tb10x.c
+++ b/drivers/irqchip/irq-tb10x.c
@@ -60,6 +60,7 @@ static int tb10x_irq_set_type(struct irq_data *data, unsigned int flow_type)
 		break;
 	case IRQ_TYPE_NONE:
 		flow_type = IRQ_TYPE_LEVEL_LOW;
+		fallthrough;
 	case IRQ_TYPE_LEVEL_LOW:
 		mod ^= im;
 		pol ^= im;
