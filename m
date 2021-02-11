Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2D5318808
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 11:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhBKKWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 05:22:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:40966 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229763AbhBKKS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:18:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613038660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p4KSkF0c5fU4qCPg8or+1uqqop6uTe4bYlvvnGDRxWY=;
        b=DivHVvXIK3d+2H8s2mJSXlaS/ID6mGaFcAur+N//M0KKelVsACyazfqTdU4OBJdNvQbyLH
        gkM2KGQRRMZzRO4po/06SU5P4EBCoFB8pFlh44T9iVqutpsjQ14Y2is+xeZcc8XjsMhUbm
        QwWpkI3/YayYR7YxkZ8FR36tCXSQ7i4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6C4EBAEE6;
        Thu, 11 Feb 2021 10:17:40 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>
Subject: [PATCH v2 3/8] xen/events: avoid handling the same event on two cpus at the same time
Date:   Thu, 11 Feb 2021 11:16:11 +0100
Message-Id: <20210211101616.13788-4-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210211101616.13788-1-jgross@suse.com>
References: <20210211101616.13788-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When changing the cpu affinity of an event it can happen today that
(with some unlucky timing) the same event will be handled on the old
and the new cpu at the same time.

Avoid that by adding an "event active" flag to the per-event data and
call the handler only if this flag isn't set.

Reported-by: Julien Grall <julien@xen.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch
---
 drivers/xen/events/events_base.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index e157e7506830..f7e22330dcef 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -102,6 +102,7 @@ struct irq_info {
 #define EVT_MASK_REASON_EXPLICIT	0x01
 #define EVT_MASK_REASON_TEMPORARY	0x02
 #define EVT_MASK_REASON_EOI_PENDING	0x04
+	u8 is_active;		/* Is event just being handled? */
 	unsigned irq;
 	evtchn_port_t evtchn;   /* event channel */
 	unsigned short cpu;     /* cpu bound */
@@ -622,6 +623,7 @@ static void xen_irq_lateeoi_locked(struct irq_info *info, bool spurious)
 	}
 
 	info->eoi_time = 0;
+	smp_store_release(&info->is_active, 0);
 	do_unmask(info, EVT_MASK_REASON_EOI_PENDING);
 }
 
@@ -809,13 +811,15 @@ static void pirq_query_unmask(int irq)
 
 static void eoi_pirq(struct irq_data *data)
 {
-	evtchn_port_t evtchn = evtchn_from_irq(data->irq);
+	struct irq_info *info = info_for_irq(data->irq);
+	evtchn_port_t evtchn = info ? info->evtchn : 0;
 	struct physdev_eoi eoi = { .irq = pirq_from_irq(data->irq) };
 	int rc = 0;
 
 	if (!VALID_EVTCHN(evtchn))
 		return;
 
+	smp_store_release(&info->is_active, 0);
 	clear_evtchn(evtchn);
 
 	if (pirq_needs_eoi(data->irq)) {
@@ -1640,6 +1644,8 @@ void handle_irq_for_port(evtchn_port_t port, struct evtchn_loop_ctrl *ctrl)
 	}
 
 	info = info_for_irq(irq);
+	if (xchg_acquire(&info->is_active, 1))
+		return;
 
 	if (ctrl->defer_eoi) {
 		info->eoi_cpu = smp_processor_id();
@@ -1823,11 +1829,13 @@ static void disable_dynirq(struct irq_data *data)
 
 static void ack_dynirq(struct irq_data *data)
 {
-	evtchn_port_t evtchn = evtchn_from_irq(data->irq);
+	struct irq_info *info = info_for_irq(data->irq);
+	evtchn_port_t evtchn = info ? info->evtchn : 0;
 
 	if (!VALID_EVTCHN(evtchn))
 		return;
 
+	smp_store_release(&info->is_active, 0);
 	clear_evtchn(evtchn);
 }
 
@@ -1969,10 +1977,13 @@ static void restore_cpu_ipis(unsigned int cpu)
 /* Clear an irq's pending state, in preparation for polling on it */
 void xen_clear_irq_pending(int irq)
 {
-	evtchn_port_t evtchn = evtchn_from_irq(irq);
+	struct irq_info *info = info_for_irq(irq);
+	evtchn_port_t evtchn = info ? info->evtchn : 0;
 
-	if (VALID_EVTCHN(evtchn))
+	if (VALID_EVTCHN(evtchn)) {
+		smp_store_release(&info->is_active, 0);
 		clear_evtchn(evtchn);
+	}
 }
 EXPORT_SYMBOL(xen_clear_irq_pending);
 void xen_set_irq_pending(int irq)
-- 
2.26.2

