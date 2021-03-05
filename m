Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78F932DE9D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 01:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhCEAwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 19:52:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:39064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231749AbhCEAw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 19:52:28 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0ED565015;
        Fri,  5 Mar 2021 00:52:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lHyhe-001sVG-Oo; Thu, 04 Mar 2021 19:52:26 -0500
Message-ID: <20210305005226.644708987@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Mar 2021 19:52:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 3/3] tracing: Fix comment about the trace_event_call flags
References: <20210305005201.588505771@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

In the declaration of the struct trace_event_call, the flags has the bits
defined in the comment above it. But these bits are also defined by the
TRACE_EVENT_FL_* enums just above the declaration of the struct. As the
comment about the flags in the struct has become stale and incorrect, just
replace it with a reference to the TRACE_EVENT_FL_* enum above.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_events.h | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 7077fec653bb..28e7af1406f2 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -349,15 +349,8 @@ struct trace_event_call {
 	struct event_filter	*filter;
 	void			*mod;
 	void			*data;
-	/*
-	 *   bit 0:		filter_active
-	 *   bit 1:		allow trace by non root (cap any)
-	 *   bit 2:		failed to apply filter
-	 *   bit 3:		trace internal event (do not enable)
-	 *   bit 4:		Event was enabled by module
-	 *   bit 5:		use call filter rather than file filter
-	 *   bit 6:		Event is a tracepoint
-	 */
+
+	/* See the TRACE_EVENT_FL_* flags above */
 	int			flags; /* static flags of different events */
 
 #ifdef CONFIG_PERF_EVENTS
-- 
2.30.0


