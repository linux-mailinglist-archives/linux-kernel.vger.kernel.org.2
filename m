Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689E3455EC0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 15:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhKRO6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 09:58:40 -0500
Received: from relay.sw.ru ([185.231.240.75]:37694 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229587AbhKRO6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 09:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
        Content-Type; bh=WQi5+rgaHPzF5NhG9pqdt7iWYlVLkiBM+aEJu98Q2Uo=; b=c4S8yOGP86sZ
        uKLlXuxISezNKCOs0M4JUDac7fCJmCohmJmpSuEMSK9dhiFNN4cacHqm7u0NmbNYIiHhnSeyjdcBb
        mgaBRPw27BvTvhN0n/EFO+q7NiH8PdITwDdPoU5VyMXiHfs14qTs9McULjjvGBqrq91hjA2pnZ4E1
        RXp+0=;
Received: from [192.168.15.175] (helo=cobook.home)
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <nikita.yushchenko@virtuozzo.com>)
        id 1mnip2-000hUv-VI; Thu, 18 Nov 2021 17:55:33 +0300
From:   Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: [PATCH] trace: don't use out-of-sync va_list in event printing
Date:   Thu, 18 Nov 2021 17:55:16 +0300
Message-Id: <20211118145516.13219-1-nikita.yushchenko@virtuozzo.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If trace_seq becomes full, trace_seq_vprintf() no longer consumes
arguments from va_list, making va_list out of sync with format
processing by trace_check_vprintf().

This causes va_arg() in trace_check_vprintf() to return wrong
positional argument, which results into a WARN_ON_ONCE() hit.

ftrace_stress_test from LTP triggers this situation.

Fix it by explicitly avoiding further use if va_list at the point
when it's consistency can no longer be guaranteed.

Signed-off-by: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
---
 kernel/trace/trace.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a1adb29ef5c1..3f527c2e08f2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3826,6 +3826,18 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
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
2.30.2

