Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDBA3588BE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhDHPoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:44:25 -0400
Received: from foss.arm.com ([217.140.110.172]:52168 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232017AbhDHPoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:44:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD39D1435;
        Thu,  8 Apr 2021 08:44:05 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C31643F694;
        Thu,  8 Apr 2021 08:44:04 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [RFC PATCH 05/10] genirq: Let purely flow-masked ONESHOT irqs through unmask_threaded_irq()
Date:   Thu,  8 Apr 2021 16:43:21 +0100
Message-Id: <20210408154326.3988781-6-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408154326.3988781-1-valentin.schneider@arm.com>
References: <20210408154326.3988781-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A subsequent patch will let IRQs end up in irq_finalize_oneshot() without
IRQD_IRQ_MASKED, but with IRQD_IRQ_FLOW_MASKED set instead. Let such IRQs
receive their final ->irq_eoi().

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/irq/manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index e976c4927b25..59c8056d6714 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1076,7 +1076,7 @@ static void irq_finalize_oneshot(struct irq_desc *desc,
 	desc->threads_oneshot &= ~action->thread_mask;
 
 	if (!desc->threads_oneshot && !irqd_irq_disabled(&desc->irq_data) &&
-	    irqd_irq_masked(&desc->irq_data))
+	    (irqd_irq_masked(&desc->irq_data) || irqd_irq_flow_masked(&desc->irq_data)))
 		unmask_threaded_irq(desc);
 
 out_unlock:
-- 
2.25.1

