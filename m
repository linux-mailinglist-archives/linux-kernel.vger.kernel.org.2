Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B738B457614
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 18:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbhKSRwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 12:52:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:57598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231994AbhKSRwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 12:52:05 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE13561212;
        Fri, 19 Nov 2021 17:49:02 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mo80U-001NJt-3R;
        Fri, 19 Nov 2021 12:49:02 -0500
Message-ID: <20211119174901.939152526@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 19 Nov 2021 12:47:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Subject: [for-linus][PATCH 3/3] tracing: Dont use out-of-sync va_list in event printing
References: <20211119174730.441176580@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>

If trace_seq becomes full, trace_seq_vprintf() no longer consumes
arguments from va_list, making va_list out of sync with format
processing by trace_check_vprintf().

This causes va_arg() in trace_check_vprintf() to return wrong
positional argument, which results into a WARN_ON_ONCE() hit.

ftrace_stress_test from LTP triggers this situation.

Fix it by explicitly avoiding further use if va_list at the point
when it's consistency can no longer be guaranteed.

Link: https://lkml.kernel.org/r/20211118145516.13219-1-nikita.yushchenko@virtuozzo.com

Signed-off-by: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e3c80cfd4eec..88de94da596b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3812,6 +3812,18 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 		iter->fmt[i] = '\0';
 		trace_seq_vprintf(&iter->seq, iter->fmt, ap);
 
+		/*
+		 * If iter->seq is full, the above call no longer guarantees
+		 * that ap is in sync with fmt processing, and further calls
+		 * to va_arg() can return wrong positional arguments.
+		 *
+		 * Ensure that ap is no longer used in this case.
+		 */
+		if (iter->seq.full) {
+			p = "";
+			break;
+		}
+
 		if (star)
 			len = va_arg(ap, int);
 
-- 
2.33.0
