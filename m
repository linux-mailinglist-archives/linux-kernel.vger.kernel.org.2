Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D1F3B76F5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 19:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbhF2RNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 13:13:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56732 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233252AbhF2RNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 13:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624986641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zyp9DioknyMGJOE6OkTd6Z7YAveN+h1kkHh6DdsnZ8c=;
        b=A17fN0YlbiRCo498umXestSbd29v30anWTUqfKlFfZ1UdwLku3NpKsiTxvBqj7cKn8lpdV
        un2s5h5e/qbfFtYgilSM5b7xISsk3Vb5Kb7aVp0bDklriFwg5opmOucfEk4P7pAsQXwwJL
        TuZW9F+XFs+ZuAtikvdYbNJRPxIqe6k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-FVyqQWMuPqyqmouaOtN3Xg-1; Tue, 29 Jun 2021 13:10:39 -0400
X-MC-Unique: FVyqQWMuPqyqmouaOtN3Xg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 462931023F4B;
        Tue, 29 Jun 2021 17:10:38 +0000 (UTC)
Received: from x1.bristot.me.homenet.telecomitalia.it (ovpn-116-83.rdu2.redhat.com [10.10.116.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9904318AAB;
        Tue, 29 Jun 2021 17:10:36 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] trace/timerlat: Fix indentation on timerlat_main()
Date:   Tue, 29 Jun 2021 19:10:27 +0200
Message-Id: <3d5d8c9258fbdcfa9d3c7362941b3d13a2a28d9d.1624986368.git.bristot@redhat.com>
In-Reply-To: <acd7cd6e7d56b798a298c3bc8139a390b3c4ab52.1624986368.git.bristot@redhat.com>
References: <acd7cd6e7d56b798a298c3bc8139a390b3c4ab52.1624986368.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Carpenter reported that:

 The patch a955d7eac177: "trace: Add timerlat tracer" from Jun 22,
 2021, leads to the following static checker warning:

	kernel/trace/trace_osnoise.c:1400 timerlat_main()
	warn: inconsistent indenting

here:
  1389          while (!kthread_should_stop()) {
  1390                  now = ktime_to_ns(hrtimer_cb_get_time(&tlat->timer));
  1391                  diff = now - tlat->abs_period;
  1392
  1393                  s.seqnum = tlat->count;
  1394                  s.timer_latency = diff;
  1395                  s.context = THREAD_CONTEXT;
  1396
  1397                  trace_timerlat_sample(&s);
  1398
  1399  #ifdef CONFIG_STACKTRACE
  1400          if (osnoise_data.print_stack)
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	    This should be indented another tab?

  1401                  if (osnoise_data.print_stack <= time_to_us(diff))
  1402                          timerlat_dump_stack();
  1403  #endif /* CONFIG_STACKTRACE */
  1404
  1405                  tlat->tracing_thread = false;
  1406                  if (osnoise_data.stop_tracing_total)
  1407                          if (time_to_us(diff) >= osnoise_data.stop_tracing_total)
  1408                                  osnoise_stop_tracing();
  1409
  1410                  wait_next_period(tlat);
  1411          }

And the static checker is right. Fix the indentation.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-kernel@vger.kernel.org
Fixes: a955d7eac177 ("trace: Add timerlat tracer")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 kernel/trace/trace_osnoise.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index cc1faca1a620..a7e3c24dee13 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1403,9 +1403,9 @@ static int timerlat_main(void *data)
 		trace_timerlat_sample(&s);
 
 #ifdef CONFIG_STACKTRACE
-	if (osnoise_data.print_stack)
-		if (osnoise_data.print_stack <= time_to_us(diff))
-			timerlat_dump_stack();
+		if (osnoise_data.print_stack)
+			if (osnoise_data.print_stack <= time_to_us(diff))
+				timerlat_dump_stack();
 #endif /* CONFIG_STACKTRACE */
 
 		tlat->tracing_thread = false;
-- 
2.31.1

