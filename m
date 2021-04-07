Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B18356C4A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352313AbhDGMjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:39:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36392 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352242AbhDGMiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:38:25 -0400
Date:   Wed, 07 Apr 2021 12:38:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617799095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=FL6ggoFwNIsO9RN3LBbyWZFaWoxqiIMV8EQ6pxilJZA=;
        b=I9XMkJopqZmAIcrKvRleSMFUXClOtqJfV2noYzbnwu7pchwdV2uewo6UtSsUq6jImmRqso
        suyPvX/fcR1EiFgMzqHqjsXy+XGlS1tKe3gdpS5QqBkvGwsagE/4Y0HIaHhOmtmh2AcnSi
        0M5ye9hGK/GyL8+21V6pMYVJwX875ULkBk5MXQ9Hixt1HBF2238OkWjzsq5/a/FlGTNpKe
        sGMdAnUVDdUdZaf364nMa8xZTKfyWoRzOL/6i+pW7/06+aUFrOCHATWgafS2vSQbW6+b9W
        H+lwoMlxPEh483RvWtfHBk40xgsWLYyhxG5P3m8Ad7CNvDenKhXcig9qq+9elw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617799095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=FL6ggoFwNIsO9RN3LBbyWZFaWoxqiIMV8EQ6pxilJZA=;
        b=NgwZOV7DB1dtfmAfKWLkb/pPYIRrBXXoMs3ucvMIIEk2/n3ohgkN9rxnFQycMCIBjwlEB6
        VqlwdqbExeqz/iBw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Get rid of
 irq_create_identity_mapping()
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <161779909540.29796.10268301085596525656.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     4a35d6a03744ded782c9301f5f5d78ad68ce680f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/4a35d6a03744ded782c9301f5f5d78ad68ce680f
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 07 Apr 2021 13:17:10 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 07 Apr 2021 13:25:52 +01:00

irqdomain: Get rid of irq_create_identity_mapping()

The sole user of irq_create_identity_mapping() having been converted,
get rid of the unused helper.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqdomain.h | 6 ------
 kernel/irq/irqdomain.c    | 3 ---
 2 files changed, 9 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 33cacc8..d2c61de 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -419,12 +419,6 @@ extern int irq_create_strict_mappings(struct irq_domain *domain,
 				      unsigned int irq_base,
 				      irq_hw_number_t hwirq_base, int count);
 
-static inline int irq_create_identity_mapping(struct irq_domain *host,
-					      irq_hw_number_t hwirq)
-{
-	return irq_create_strict_mappings(host, hwirq, hwirq, 1);
-}
-
 extern const struct irq_domain_ops irq_domain_simple_ops;
 
 /* stock xlate functions */
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index d10ab1d..35c5a99 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -715,9 +715,6 @@ EXPORT_SYMBOL_GPL(irq_create_mapping_affinity);
  * locations. For use by controllers that already have static mappings
  * to insert in to the domain.
  *
- * Non-linear users can use irq_create_identity_mapping() for IRQ-at-a-time
- * domain insertion.
- *
  * 0 is returned upon success, while any failure to establish a static
  * mapping is treated as an error.
  */
