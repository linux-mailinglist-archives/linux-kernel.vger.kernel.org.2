Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A3F43E1F7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 15:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhJ1NZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 09:25:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47660 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbhJ1NZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 09:25:52 -0400
Date:   Thu, 28 Oct 2021 13:23:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635427405;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=09zvCZocIX9PsQgasBU2fE8lu5NASLiAAlaGZZ5yHdM=;
        b=aqcF/Zx+jS28s584yb+YM3VwjdJsY9RlmN/tCXJYnuE+Z6a9t5ssusseayzRydJ4Ms5DwJ
        g2iJz1jyX9wqzCoyIgcO43fki5EVsrIV5gjzRI6+Xwiyas5ocGBkfQWp0c/JziizUdF/zB
        2Dwt+nQWXAqV1+/0UfWo5tdpx+jheF+0++inKemBcfVVipImO6ezaxJO3r1HnLXZYVxYT+
        AbbFGNs2Pyqj0KZ76c3Lb7QsTlevOptv1eIkcb7Atil+znxPd8J17u0JJL1CgdCE6RbvP/
        HZLCOBNtcDx2MLc687501E6VQDA0rnUA/n5pxGm/elhyK9M9VScN62g3uvbieA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635427405;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=09zvCZocIX9PsQgasBU2fE8lu5NASLiAAlaGZZ5yHdM=;
        b=af1WcxD63hP91oTEBlDZtNFEcNOyBvOvpdb6uqhXgw/p7l+l+sZlAzgH/1fE1tmbg/8R1u
        qLbjHUj3lTtzM2DA==
From:   "irqchip-bot for Yanteng Si" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] MIPS: irq: Avoid an unused-variable error
Cc:     Yanteng Si <siyanteng@loongson.cn>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20211028095652.3503790-1-siyanteng@loongson.cn>
References: <20211028095652.3503790-1-siyanteng@loongson.cn>
MIME-Version: 1.0
Message-ID: <163542740410.626.5186631730404597986.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     34fca8947b2743e6a3a9a8a3a44962e625993533
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/34fca8947b2743e6a3a9a8a3a44962e625993533
Author:        Yanteng Si <siyanteng01@gmail.com>
AuthorDate:    Thu, 28 Oct 2021 17:56:52 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 28 Oct 2021 13:28:52 +01:00

MIPS: irq: Avoid an unused-variable error

When CONFIG_IRQ_DOMAIN is set, there is a warning:
arch/mips/kernel/irq.c:114:19: error: unused variable 'desc' [-Werror=unused-variable]
  114 |  struct irq_desc *desc;
      |                   ^~~~

This variable is unused, let's remove it.

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211028095652.3503790-1-siyanteng@loongson.cn
---
 arch/mips/kernel/irq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index 1fee96e..5e11582 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -111,8 +111,6 @@ void __irq_entry do_IRQ(unsigned int irq)
 #ifdef CONFIG_IRQ_DOMAIN
 void __irq_entry do_domain_IRQ(struct irq_domain *domain, unsigned int hwirq)
 {
-	struct irq_desc *desc;
-
 	irq_enter();
 	check_stack_overflow();
 	generic_handle_domain_irq(domain, hwirq);
