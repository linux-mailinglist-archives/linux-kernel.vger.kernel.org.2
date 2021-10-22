Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68530437F98
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbhJVUw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:52:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234426AbhJVUvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:51:03 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4516613AD;
        Fri, 22 Oct 2021 20:48:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1T2-000QT0-2L;
        Fri, 22 Oct 2021 16:48:44 -0400
Message-ID: <20211022204843.904040848@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:48:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Subject: [for-next][PATCH 31/40] tracing: Explain the trace recursion transition bit better
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The current text of the explanation of the transition bit in the trace
recursion protection is not very clear. Improve the text, so that when all
the archs no longer have the issue of tracing between a start of a new
(interrupt) context and updating the preempt_count to reflect the new
context, that it may be removed.

Link: https://lore.kernel.org/all/20211018220203.064a42ed@gandalf.local.home/

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_recursion.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index 1d8cce02c3fb..24f284eb55a7 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -168,8 +168,12 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
 	bit = trace_get_context_bit() + start;
 	if (unlikely(val & (1 << bit))) {
 		/*
-		 * It could be that preempt_count has not been updated during
-		 * a switch between contexts. Allow for a single recursion.
+		 * If an interrupt occurs during a trace, and another trace
+		 * happens in that interrupt but before the preempt_count is
+		 * updated to reflect the new interrupt context, then this
+		 * will think a recursion occurred, and the event will be dropped.
+		 * Let a single instance happen via the TRANSITION_BIT to
+		 * not drop those events.
 		 */
 		bit = TRACE_TRANSITION_BIT;
 		if (val & (1 << bit)) {
-- 
2.33.0
