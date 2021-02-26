Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03DA325BBB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 03:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhBZCtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 21:49:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:43432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229894AbhBZCtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 21:49:00 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A6D064EE4;
        Fri, 26 Feb 2021 02:48:20 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lFTAw-0012if-Pc; Thu, 25 Feb 2021 21:48:18 -0500
Message-ID: <20210226024818.655494375@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 25 Feb 2021 21:47:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacob Wen <jian.w.wen@oracle.com>
Subject: [for-linus][PATCH 1/2] mm, tracing: Fix kmem_cache_free trace event to not print stale
 pointers
References: <20210226024751.443534071@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The update to kmem_cache_free trace event added printing of the slab name in
the trace event. But it only stores the pointer of the name which will be
printed as a string when the event is read some time in the future. This is
dangerous because the name could be freed in the mean time and when reading
the trace event it would try to dereference the string name by the pointer
to the name that has been freed.

Instead, use the trace event helper macros __string(), __assign_str(), and
__get_str() that are for this very case.

Cc: Jacob Wen <jian.w.wen@oracle.com>
Fixes: 3544de8ee6e4 ("mm, tracing: record slab name for kmem_cache_free()")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/trace/events/kmem.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index 40845b0d5dad..3a60b6b6db32 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -144,17 +144,17 @@ TRACE_EVENT(kmem_cache_free,
 	TP_STRUCT__entry(
 		__field(	unsigned long,	call_site	)
 		__field(	const void *,	ptr		)
-		__field(	const char *,	name		)
+		__string(	name,	name	)
 	),
 
 	TP_fast_assign(
 		__entry->call_site	= call_site;
 		__entry->ptr		= ptr;
-		__entry->name		= name;
+		__assign_str(name, name);
 	),
 
 	TP_printk("call_site=%pS ptr=%p name=%s",
-		  (void *)__entry->call_site, __entry->ptr, __entry->name)
+		  (void *)__entry->call_site, __entry->ptr, __get_str(name))
 );
 
 TRACE_EVENT(mm_page_free,
-- 
2.30.0


