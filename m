Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E99834B158
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 22:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhCZV35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 17:29:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230106AbhCZV32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 17:29:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D08D619F7;
        Fri, 26 Mar 2021 21:29:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lPu1G-002DSs-HZ; Fri, 26 Mar 2021 17:29:26 -0400
Message-ID: <20210326212926.427864267@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Mar 2021 17:28:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [for-next][PATCH 6/6] tracing: Update create_system_filter() kernel-doc comment
References: <20210326212848.385566448@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiujun Huang <hqjagain@gmail.com>

commit f306cc82a93d ("tracing: Update event filters for multibuffer")
added the parameter @tr for create_system_filter().

commit bb9ef1cb7d86 ("tracing: Change apply_subsystem_event_filter()
paths to check file->system == dir") changed the parameter from @system to @dir.

Link: https://lkml.kernel.org/r/20210325161911.123452-1-hqjagain@gmail.com

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index c2dd697cc9c0..c9124038b140 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1693,6 +1693,7 @@ static void create_filter_finish(struct filter_parse_error *pe)
 
 /**
  * create_filter - create a filter for a trace_event_call
+ * @tr: the trace array associated with these events
  * @call: trace_event_call to create a filter for
  * @filter_str: filter string
  * @set_str: remember @filter_str and enable detailed error in filter
@@ -1741,8 +1742,8 @@ int create_event_filter(struct trace_array *tr,
 }
 
 /**
- * create_system_filter - create a filter for an event_subsystem
- * @system: event_subsystem to create a filter for
+ * create_system_filter - create a filter for an event subsystem
+ * @dir: the descriptor for the subsystem directory
  * @filter_str: filter string
  * @filterp: out param for created filter (always updated on return)
  *
-- 
2.30.1


