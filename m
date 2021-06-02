Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A33398559
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 11:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhFBJf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:35:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37802 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229583AbhFBJf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622626425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=N9Sh/QOE9Zh9rY3P1FOigUDT0+nzaPyFTdrh3FzN9+k=;
        b=PJUYSVSPKySZpR9vG6Igah8fd8RTrrg4uCHOVqeWFNyqwtUQikKFFOjsdLZeDBKjezYMh+
        ZoXwO1ycnayAes8pRBGiaIlmU2I6AcT8oFjSsTM+95HnsPNvILLU0HLzg1hj99wM6mgUTm
        mDwr4uMQlbn1Opkss2VuE6Bv8JyIUEs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-o626dd4dP1S5lSxmkzPL1g-1; Wed, 02 Jun 2021 05:33:44 -0400
X-MC-Unique: o626dd4dP1S5lSxmkzPL1g-1
Received: by mail-wr1-f71.google.com with SMTP id x9-20020adfffc90000b02901178add5f60so769571wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 02:33:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N9Sh/QOE9Zh9rY3P1FOigUDT0+nzaPyFTdrh3FzN9+k=;
        b=mPY0wlXUa4efRT/+pSpX2Hi5FZHxeQE/5dLxCESzPx6Zp55qb4i7NPvwBigwO7E1+4
         2bf/5rftjl4cgozgq7ENFeG5/gJiGsxF2XWe7KSuTkp1aVfFAdXRwndALxg75Auk+r6S
         cmcDr+cD7A1y6hUhBXe68b4OyYYWDCLNe82f6MelR+7kKoGG2JJMEVHxqv8HEPF9Mc5l
         swIML0MsHk0JgRFnEgQezASG/KGu1FU0sVYMKD1Ji/Fm6XEnObtj0guF2LUbM1FTZTNf
         WjaRsx0S/NfJmugwyiaxdgCEoxRBGkbJiWVU9GrJkLs/3qhSYUeJFLzblPSFBLQobsIE
         26Yw==
X-Gm-Message-State: AOAM530pf/KcnZGjbg2eurJM6CHG0gSuid6WEr4uFygzkMIDMvesS2JJ
        mBvI2O3MdkoF+WUopsy0CkemIkePOux8CPb5ebzGI1IeSI8/a48ewGaw5mDfgktozTgBKteUXJN
        Uh53nsgoS0eQg1Ma5giP9FeJP
X-Received: by 2002:a7b:c3d4:: with SMTP id t20mr30242753wmj.13.1622626422990;
        Wed, 02 Jun 2021 02:33:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGc8ClC7bCKOsyy/VLX3opMH9cizkHQaqiNprhVMyoO37dTAB84jL7XmYIVQImG/cs1qd2cg==
X-Received: by 2002:a7b:c3d4:: with SMTP id t20mr30242740wmj.13.1622626422872;
        Wed, 02 Jun 2021 02:33:42 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:3d14:2800:933d:abfc:d8e4:637f])
        by smtp.gmail.com with ESMTPSA id b7sm5781142wri.83.2021.06.02.02.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 02:33:42 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     rostedt@goodmis.org, linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, mtosatti@redhat.com, nsaenzju@redhat.com,
        frederic@kernel.org
Subject: [PATCH] ring_buffer: Offload wakeup IPI to housekeeping CPUs
Date:   Wed,  2 Jun 2021 11:33:26 +0200
Message-Id: <20210602093326.15355-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to minimize trace's effect on nohz_full CPUs, offload the
ring-buffer consumer wakeup IPI into one of the housekeeping CPUs.
Systems not using nohz_full will still run the wakeup IPI locally (as
per housekeeping_any_cpu()'s implementation).

This wakeup IPI, although negligible for the vast majority of trace
workloads, may cause unwarranted latencies on systems tracing events on
nohz_full CPUs. This is made worse on PREEMPT_RT kernels, as they defer
the irq_work handling into ksoftirqd, forcing unwarranted context
switches on the otherwise extremely busy CPU.

Note that the local IPI can't be avoided when tracing in NMI context, as
irq_work_queue() is the only mechanism supported in that context.

To illustrate this, tracing on a nohz_full CPU with PREEMPT_RT=y (plus a
good amount of extra isolation options). I see:
  - 50-100 μs latency spikes while tracing without this patch
  - 10-14 μs latency spikes while tracing with this patch
  - 8-11 μs latency spikes when not tracing at all

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 kernel/trace/ring_buffer.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 2c0ee6484990..ce7817861c5e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2008 Steven Rostedt <srostedt@redhat.com>
  */
 #include <linux/trace_recursion.h>
+#include <linux/sched/isolation.h>
 #include <linux/trace_events.h>
 #include <linux/ring_buffer.h>
 #include <linux/trace_clock.h>
@@ -3052,6 +3053,20 @@ static void rb_commit(struct ring_buffer_per_cpu *cpu_buffer,
 	rb_end_commit(cpu_buffer);
 }
 
+/*
+ * Offload the irq_work into a housekeeping CPU unless in NMI context, which
+ * doesn't support it. Systems not using nohz_full trigger the IPI locally.
+ *
+ * Note that irq_work supplies its own memory barriers.
+ */
+static __always_inline void rb_irq_work_queue(struct irq_work *work)
+{
+	if (in_nmi())
+		irq_work_queue(work);
+	else
+		irq_work_queue_on(work, housekeeping_any_cpu(HK_FLAG_MISC));
+}
+
 static __always_inline void
 rb_wakeups(struct trace_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
 {
@@ -3061,14 +3076,12 @@ rb_wakeups(struct trace_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
 
 	if (buffer->irq_work.waiters_pending) {
 		buffer->irq_work.waiters_pending = false;
-		/* irq_work_queue() supplies it's own memory barriers */
-		irq_work_queue(&buffer->irq_work.work);
+		rb_irq_work_queue(&buffer->irq_work.work);
 	}
 
 	if (cpu_buffer->irq_work.waiters_pending) {
 		cpu_buffer->irq_work.waiters_pending = false;
-		/* irq_work_queue() supplies it's own memory barriers */
-		irq_work_queue(&cpu_buffer->irq_work.work);
+		rb_irq_work_queue(&cpu_buffer->irq_work.work);
 	}
 
 	if (cpu_buffer->last_pages_touch == local_read(&cpu_buffer->pages_touched))
@@ -3090,8 +3103,7 @@ rb_wakeups(struct trace_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
 
 	cpu_buffer->irq_work.wakeup_full = true;
 	cpu_buffer->irq_work.full_waiters_pending = false;
-	/* irq_work_queue() supplies it's own memory barriers */
-	irq_work_queue(&cpu_buffer->irq_work.work);
+	rb_irq_work_queue(&cpu_buffer->irq_work.work);
 }
 
 #ifdef CONFIG_RING_BUFFER_RECORD_RECURSION
-- 
2.31.1

