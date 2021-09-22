Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E05414AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhIVNmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:42:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55694 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbhIVNl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:41:56 -0400
Date:   Wed, 22 Sep 2021 13:40:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632318025;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VeG8v0aB2w6gNVlHQ7u5LdBJq48dIQ1rC9p+LIKcZew=;
        b=i/U5359ReGGksTFmXPJUAZq7PodYvnOaEfJM4obZyn+UvgfQmWDV2aN3YZK4tFfPHRusdX
        ikRSVugg6v1MvSV8YjYTKackD3eGiyP/ji3HehbGGzmhbY6jj5UoixKu6BwnSu7QfYzeDV
        rHmaxffJ2y6/FF46+B0uIX1bgctsKBzVRgcTvDQRL6OMw/4H9KJckxf83qg9N5xSXCPK0f
        4QC3KeIo7epHBNuJE5f5xrF0O3qDxRNpoG89SCMuGwHoafS4KBTn/fchRq8AAXGTc/LTKH
        Znb2f8emQtUG9zUxxqxGI6boVL8bIw1CsSmsQF/XGIfdGQfUnqiAzAzFHqWDhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632318025;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VeG8v0aB2w6gNVlHQ7u5LdBJq48dIQ1rC9p+LIKcZew=;
        b=aYPzkZxYZZ43Lnh9lR+wdt5jeA1cKnMPRQcIRhYPsUMkEsewtP9ZP5Gx7WSXOSQqw+xudy
        ISLrQNLFs2pmFyCQ==
From:   "irqchip-bot for Kaige Fu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/gic-v3-its: Fix potential VPE
 leak on error
Cc:     Kaige Fu <kaige.fu@linux.alibaba.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: =?utf-8?q?=3Cd9e36dee512e63670287ed9eff884a5d8d6d27f2=2E16316?=
 =?utf-8?q?72311=2Egit=2Ekaige=2Efu=40linux=2Ealibaba=2Ecom=3E?=
References: =?utf-8?q?=3Cd9e36dee512e63670287ed9eff884a5d8d6d27f2=2E163167?=
 =?utf-8?q?2311=2Egit=2Ekaige=2Efu=40linux=2Ealibaba=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <163231802507.25758.1269690690068126910.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     280bef512933b2dda01d681d8cbe499b98fc5bdd
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/280bef512933b2dda01d681d8cbe499b98fc5bdd
Author:        Kaige Fu <kaige.fu@linux.alibaba.com>
AuthorDate:    Wed, 15 Sep 2021 10:20:55 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 22 Sep 2021 14:37:04 +01:00

irqchip/gic-v3-its: Fix potential VPE leak on error

In its_vpe_irq_domain_alloc, when its_vpe_init() returns an error,
there is an off-by-one in the number of VPEs to be freed.

Fix it by simply passing the number of VPEs allocated, which is the
index of the loop iterating over the VPEs.

Fixes: 7d75bbb4bc1a ("irqchip/gic-v3-its: Add VPE irq domain allocation/teardown")
Signed-off-by: Kaige Fu <kaige.fu@linux.alibaba.com>
[maz: fixed commit message]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/d9e36dee512e63670287ed9eff884a5d8d6d27f2.1631672311.git.kaige.fu@linux.alibaba.com
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 7f40dca..eb0882d 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4501,7 +4501,7 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 
 	if (err) {
 		if (i > 0)
-			its_vpe_irq_domain_free(domain, virq, i - 1);
+			its_vpe_irq_domain_free(domain, virq, i);
 
 		its_lpi_free(bitmap, base, nr_ids);
 		its_free_prop_table(vprop_page);
