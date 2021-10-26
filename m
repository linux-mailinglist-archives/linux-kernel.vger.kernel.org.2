Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F6A43B01D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbhJZKiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:38:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60884 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbhJZKhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:37:50 -0400
Date:   Tue, 26 Oct 2021 10:35:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635244525;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hW+1lf3WNllj8PoWQyChg22cMeOWoPy0RwKAFpx0GwE=;
        b=tArqtTyTiIdGaalAlaqVd5bHucsUZe6HJSYaKsx05Bk4lWlI4kXa2JuKFPTfXSHfl6WmI+
        oYlzsdUGUN0xl/RExoyrq4XvAtU43E//tcbQRxSbQJALpjV5h3HSRZ3rPM3LwcRA3WBSyW
        ikOdkpOKgggO+xjrL1Fqvpe2EdGDtqjkRMQifARIQw3agpZI6guLHjxxwKe22XSzxBgNVC
        o3D/TId9k9QFe4FNZv+KBBwcMH4RLbZ6Uq47KgfqHo3jgvl8Y44USw/lDawI4hqy+3gAd/
        odVmCRf3IunVQGZOBW4L42SfyrW6mF4lhcnBh5Gje44QGrWjySood69PESL8hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635244525;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hW+1lf3WNllj8PoWQyChg22cMeOWoPy0RwKAFpx0GwE=;
        b=2uZmpQEIYt6ndmVpTcMIAFw15wNq3KFXT75kd1qqXR3J1LIaykgct3/lBGo3x8l/I7uSiy
        IEcjMmu7Q3CuvlDQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] MIPS: loongson64: Drop call to irq_cpu_offline()
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>, tglx@linutronix.de
In-Reply-To: <20211021170414.3341522-2-maz@kernel.org>
References: <20211021170414.3341522-2-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <163524452496.626.12676907731914820035.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     eb5411334c289c473bc11d5cef8b0bea8d7ce324
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/eb5411334c289c473bc11d5cef8b0bea8d7ce324
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 21 Oct 2021 18:04:12 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 26 Oct 2021 11:18:33 +01:00

MIPS: loongson64: Drop call to irq_cpu_offline()

Also loongson64 calls irq_cpu_offline(), none of its interrupt
controllers implement the .irq_cpu_offline callback.

It is thus obvious that this call only serves the dubious purpose
of wasting precious CPU cycles by iterating over all interrupts.

Get rid of the call altogether.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
Link: https://lore.kernel.org/r/20211021170414.3341522-2-maz@kernel.org
---
 arch/mips/loongson64/smp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
index 09ebe84..660e1de 100644
--- a/arch/mips/loongson64/smp.c
+++ b/arch/mips/loongson64/smp.c
@@ -550,7 +550,6 @@ static int loongson3_cpu_disable(void)
 	set_cpu_online(cpu, false);
 	calculate_cpu_foreign_map();
 	local_irq_save(flags);
-	irq_cpu_offline();
 	clear_c0_status(ST0_IM);
 	local_irq_restore(flags);
 	local_flush_tlb_all();
