Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CB043550D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 23:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhJTVOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 17:14:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55508 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhJTVOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:14:32 -0400
Date:   Wed, 20 Oct 2021 21:12:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634764336;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lxR9ClMP03VSzQM4QT9OGDa9RqdurBfSOPIP3qlYUkc=;
        b=yg2JbzW3DmygM+bVasKpc0BqOrDv+w5kS7XZCll4gzVIE1TaB7Pdrj2uuMGQyqlMvxw4GA
        bBkYj8ULOCxOD1+uPqvztvsWCNSevDnPHV+X1cUMExIrhi/37F1Th96nqlG6hC7qCzCpHl
        NUCGY0liTeG9nw+SFY07rzL4o/KbvcTCaxjQlMayyiEP3vWDL3KMi8LaN1WXwRwzV7wTUI
        osc6KcRKbRDk/b/rm8fDnUMgsliRgTro6svTsGsu9PSZ7SwI+lZKjEBPwz2Sxv9rUbPhwA
        3l2zhprbCiNgITr8z+Nc7NRU3MavXp09Sg4lnlpuz+SoAfwxO9adhOt1X7gUkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634764336;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lxR9ClMP03VSzQM4QT9OGDa9RqdurBfSOPIP3qlYUkc=;
        b=07ZtjMFeeshxGBOOZc4d38vrTM+BMecuL9kbzQqVTnhxOOmjPbJww3cDS2BMW1syQugytm
        uUCTgTxR2rj/EBAw==
From:   "irqchip-bot for Florian Fainelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/irq-bcm7038-l1: Use irq_get_irq_data()
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211020184859.2705451-4-f.fainelli@gmail.com>
References: <20211020184859.2705451-4-f.fainelli@gmail.com>
MIME-Version: 1.0
Message-ID: <163476433591.25758.5379581903187680710.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     4b55192009fc62d2817efa2346ec1c0da4be1033
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/4b55192009fc62d2817efa2346ec1c0da4be1033
Author:        Florian Fainelli <f.fainelli@gmail.com>
AuthorDate:    Wed, 20 Oct 2021 11:48:49 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 Oct 2021 20:06:32 +01:00

irqchip/irq-bcm7038-l1: Use irq_get_irq_data()

Using irq_desc_get_irq_data(irq_to_desc()) to retrieve the irq_data
structure from a virtual interrupt number is going to be problematic to
make irq-bcm7038-l1 a module because irq_to_desc() is not exported, and
there is no intent to export it to modules, see 64a1b95bb9fe ("genirq:
Restrict export of irq_to_desc()").

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211020184859.2705451-4-f.fainelli@gmail.com
---
 drivers/irqchip/irq-bcm7038-l1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index 7501562..14caf32 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -386,7 +386,7 @@ static int bcm7038_l1_map(struct irq_domain *d, unsigned int virq,
 
 	irq_set_chip_and_handler(virq, &bcm7038_l1_irq_chip, handle_level_irq);
 	irq_set_chip_data(virq, d->host_data);
-	irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(virq)));
+	irqd_set_single_target(irq_get_irq_data(virq));
 	return 0;
 }
 
