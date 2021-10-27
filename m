Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3AB343CE62
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236761AbhJ0QM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:12:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242950AbhJ0QM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:12:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F15AD610CF;
        Wed, 27 Oct 2021 16:10:02 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mflV4-000xsK-4N;
        Wed, 27 Oct 2021 12:10:02 -0400
Message-ID: <20211027161001.968134870@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Oct 2021 12:09:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: [for-next][PATCH 12/15] tracing/histogram: Optimize division by a power of 2
References: <20211027160940.084904334@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kalesh Singh <kaleshsingh@google.com>

The division is a slow operation. If the divisor is a power of 2, use a
shift instead.

Results were obtained using Android's version of perf (simpleperf[1]) as
described below:

1. hist_field_div() is modified to call 2 test functions:
   test_hist_field_div_[not]_optimized(); passing them the
   same args. Use noinline and volatile to ensure these are
   not optimized out by the compiler.
2. Create a hist event trigger that uses division:
      events/kmem/rss_stat$ echo 'hist:keys=common_pid:x=size/<divisor>'
         >> trigger
      events/kmem/rss_stat$ echo 'hist:keys=common_pid:vals=$x'
         >> trigger
3. Run Android's lmkd_test[2] to generate rss_stat events, and
   record CPU samples with Android's simpleperf:
      simpleperf record -a --exclude-perf --post-unwind=yes -m 16384 -g
         -f 2000 -o perf.data

== Results ==

Divisor is a power of 2 (divisor == 32):

   test_hist_field_div_not_optimized  | 8,717,091 cpu-cycles
   test_hist_field_div_optimized      | 1,643,137 cpu-cycles

If the divisor is a power of 2, the optimized version is ~5.3x faster.

Divisor is not a power of 2 (divisor == 33):

   test_hist_field_div_not_optimized  | 4,444,324 cpu-cycles
   test_hist_field_div_optimized      | 5,497,958 cpu-cycles

If the divisor is not a power of 2, as expected, the optimized version is
slightly slower (~24% slower).

[1] https://android.googlesource.com/platform/system/extras/+/master/simpleperf/doc/README.md
[2] https://cs.android.com/android/platform/superproject/+/master:system/memory/lmkd/tests/lmkd_test.cpp

Link: https://lkml.kernel.org/r/20211025200852.3002369-7-kaleshsingh@google.com

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 71b453576d85..452daad7cfb3 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -304,6 +304,10 @@ static u64 hist_field_div(struct hist_field *hist_field,
 	if (!val2)
 		return -1;
 
+	/* Use shift if the divisor is a power of 2 */
+	if (!(val2 & (val2 - 1)))
+		return val1 >> __ffs64(val2);
+
 	return div64_u64(val1, val2);
 }
 
-- 
2.33.0
