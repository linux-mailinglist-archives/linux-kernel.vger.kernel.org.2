Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1643A43B01E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbhJZKiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbhJZKhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:37:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD79BC061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 03:35:25 -0700 (PDT)
Date:   Tue, 26 Oct 2021 10:35:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635244524;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T76pN1VQ8u+oPBFf3I3RUkYXBlULazoOxFDdpcO44AA=;
        b=vYtWp95e/w633wgZdUWhMCPv2ftEPUFnNMAFmSm1fHXVapDgmIGeTiWzmbp442bI63EdRH
        WbEVcyRVLBWIQxTkobsdBd0X+UiLKAdzGeCAJjJEBd/SwDsAI/jOZJB9GepmMPrPfa9Z33
        qrJ/+UO0JVBDsLOqz2ohKhaQwGk64edjQlTqiA860gl1/YocWF7TBWCabUSaIi8FJdlqyx
        ITg2c/Krk3tFF1E/NV8I8qf0X9lw5Nph5iHh4TFNWz22At+amjb3BjygUH0J/9FeVoiL2s
        LWuAfFBOrGA+Fklp/pe32Ec8Wv4G5THzy0kJxd/how+LseLWvjsAfkpGuCPwKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635244524;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T76pN1VQ8u+oPBFf3I3RUkYXBlULazoOxFDdpcO44AA=;
        b=ByFzqFyTZGP2bWmdovh5O15itFLDdzsWAkiTBv029WTNADwe08KULMafK5Htud7COIunrx
        RXZV5U6tk0WaT3Aw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq: Hide irq_cpu_{on,off}line()
 behind a deprecated option
Cc:     Marc Zyngier <maz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>, tglx@linutronix.de
In-Reply-To: <20211021170414.3341522-4-maz@kernel.org>
References: <20211021170414.3341522-4-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <163524452326.626.8430081556515805990.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     8d15a7295d33538954df2bca6a4011e4311a9cc2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/8d15a7295d33538954df2bca6a4011e4311a9cc2
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 21 Oct 2021 18:04:14 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 26 Oct 2021 11:19:55 +01:00

genirq: Hide irq_cpu_{on,off}line() behind a deprecated option

irq_cpu_{on,off}line() are now only used by the Octeon platform.
Make their use conditional on this plaform being enabled, and
otherwise hidden away.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
Link: https://lore.kernel.org/r/20211021170414.3341522-4-maz@kernel.org
---
 include/linux/irq.h | 5 ++++-
 kernel/irq/Kconfig  | 7 +++++++
 kernel/irq/chip.c   | 2 ++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index c8293c8..0c746d3 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -524,9 +524,10 @@ struct irq_chip {
 	void		(*irq_bus_lock)(struct irq_data *data);
 	void		(*irq_bus_sync_unlock)(struct irq_data *data);
 
+#ifdef CONFIG_DEPRECATED_IRQ_CPU_ONOFFLINE
 	void		(*irq_cpu_online)(struct irq_data *data);
 	void		(*irq_cpu_offline)(struct irq_data *data);
-
+#endif
 	void		(*irq_suspend)(struct irq_data *data);
 	void		(*irq_resume)(struct irq_data *data);
 	void		(*irq_pm_shutdown)(struct irq_data *data);
@@ -606,8 +607,10 @@ struct irqaction;
 extern int setup_percpu_irq(unsigned int irq, struct irqaction *new);
 extern void remove_percpu_irq(unsigned int irq, struct irqaction *act);
 
+#ifdef CONFIG_DEPRECATED_IRQ_CPU_ONOFFLINE
 extern void irq_cpu_online(void);
 extern void irq_cpu_offline(void);
+#endif
 extern int irq_set_affinity_locked(struct irq_data *data,
 				   const struct cpumask *cpumask, bool force);
 extern int irq_set_vcpu_affinity(unsigned int irq, void *vcpu_info);
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index fbc54c2..c0b9d46 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -144,3 +144,10 @@ config GENERIC_IRQ_MULTI_HANDLER
 	bool
 	help
 	  Allow to specify the low level IRQ handler at run time.
+
+# Cavium Octeon is the last system to use this deprecated option
+# Do not even think of enabling this on any new platform
+config DEPRECATED_IRQ_CPU_ONOFFLINE
+	bool
+	depends on CAVIUM_OCTEON_SOC
+	default CAVIUM_OCTEON_SOC
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index a98bcfc..f895265 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1122,6 +1122,7 @@ void irq_modify_status(unsigned int irq, unsigned long clr, unsigned long set)
 }
 EXPORT_SYMBOL_GPL(irq_modify_status);
 
+#ifdef CONFIG_DEPRECATED_IRQ_CPU_ONOFFLINE
 /**
  *	irq_cpu_online - Invoke all irq_cpu_online functions.
  *
@@ -1181,6 +1182,7 @@ void irq_cpu_offline(void)
 		raw_spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
+#endif
 
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 
