Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0811842A5BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 15:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbhJLNfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 09:35:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55956 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236937AbhJLNfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 09:35:12 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634045590; h=from:from:reply-to:subject:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type; bh=kzzhCfXTDEtjAULZoQTQAQVk/vJzN0Qs+xvw5wZ2xW8=;
        b=fshm+r6GuZJqUIjderhxFapYx9zHU+cgacgZcb4X3qqfOA3jGaDvAbH+anIC+WP9685mk6
        q0TKBkDt0g/d8TCr49QoRZoKVvEr9W7tfTXsay5DDNIsnJLYAZcf91hSz8dBlwGedoMCo9
        E74g57CWEurmdTWYM21l5cxRenKL2vF/eJBF0PpyTMLJ6QaH0Fobe2OR8yswaRfFby+9eA
        hDJbrq09yA+2Jq8k3m5/rJ7IQVWFni4JnkTVKlxJRtH1NXEuWURVID/OZfZGLUcu+Ku8wc
        jpIijHLw/98IL8yJ54WQkKkChMx7UdL3OlW8F8slrV1oEnGz20/GXC4PLQttvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634045590; h=from:from:reply-to:subject:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type; bh=kzzhCfXTDEtjAULZoQTQAQVk/vJzN0Qs+xvw5wZ2xW8=;
        b=Jtzxoe+JH4LioMrpry7wl7nAZ54N2HKh7QirrOr/uYKDM93VU1+yZMsGl5o/abis+gR7Hv
        XGzy0J0vXb45WQCQ==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org
Subject: [PATCH] x86/xen: Remove redundant irq_enter/exit() invocations
Subject: 
Date:   Tue, 12 Oct 2021 15:33:09 +0200
Message-ID: <877deicqqy.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All these handlers are regular device interrupt handlers, so they already
went through the proper entry code which handles this correctly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: x86@kernel.org
Cc: xen-devel@lists.xenproject.org
---
 arch/x86/xen/smp.c    |    4 ----
 arch/x86/xen/smp_pv.c |    2 --
 2 files changed, 6 deletions(-)

--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -268,20 +268,16 @@ void xen_send_IPI_allbutself(int vector)
 
 static irqreturn_t xen_call_function_interrupt(int irq, void *dev_id)
 {
-	irq_enter();
 	generic_smp_call_function_interrupt();
 	inc_irq_stat(irq_call_count);
-	irq_exit();
 
 	return IRQ_HANDLED;
 }
 
 static irqreturn_t xen_call_function_single_interrupt(int irq, void *dev_id)
 {
-	irq_enter();
 	generic_smp_call_function_single_interrupt();
 	inc_irq_stat(irq_call_count);
-	irq_exit();
 
 	return IRQ_HANDLED;
 }
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -458,10 +458,8 @@ static void xen_pv_stop_other_cpus(int w
 
 static irqreturn_t xen_irq_work_interrupt(int irq, void *dev_id)
 {
-	irq_enter();
 	irq_work_run();
 	inc_irq_stat(apic_irq_work_irqs);
-	irq_exit();
 
 	return IRQ_HANDLED;
 }
