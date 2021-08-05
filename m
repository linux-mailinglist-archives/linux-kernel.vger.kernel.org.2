Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9804B3E18AB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242371AbhHEPuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242394AbhHEPtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:49:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93B9561040;
        Thu,  5 Aug 2021 15:49:37 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mBfcm-0037yd-LB; Thu, 05 Aug 2021 11:49:36 -0400
Message-ID: <20210805154936.485350096@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 05 Aug 2021 11:43:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [for-linus][PATCH 6/6] tracing: Quiet smp_processor_id() use in preemptable warning in hwlat
References: <20210805154336.208362117@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The hardware latency detector (hwlat) has a mode that it runs one thread
across CPUs. The logic to move from the currently running CPU to the next
one in the list does a smp_processor_id() to find where it currently is.
Unfortunately, it's done with preemption enabled, and this triggers a
warning for using smp_processor_id() in a preempt enabled section.

As it is only using smp_processor_id() to get information on where it
currently is in order to simply move it to the next CPU, it doesn't really
care if it got moved in the mean time. It will simply balance out later if
such a case arises.

Switch smp_processor_id() to raw_smp_processor_id() to quiet that warning.

Link: https://lkml.kernel.org/r/20210804141848.79edadc0@oasis.local.home

Acked-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Fixes: 8fa826b7344d ("trace/hwlat: Implement the mode config option")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_hwlat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index a6c0cdaf4b87..14f46aae1981 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -327,7 +327,7 @@ static void move_to_next_cpu(void)
 
 	get_online_cpus();
 	cpumask_and(current_mask, cpu_online_mask, tr->tracing_cpumask);
-	next_cpu = cpumask_next(smp_processor_id(), current_mask);
+	next_cpu = cpumask_next(raw_smp_processor_id(), current_mask);
 	put_online_cpus();
 
 	if (next_cpu >= nr_cpu_ids)
-- 
2.30.2
