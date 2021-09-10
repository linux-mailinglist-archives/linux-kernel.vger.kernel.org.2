Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507B34073AA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 01:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbhIJXFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 19:05:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231495AbhIJXFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 19:05:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E71B61211;
        Fri, 10 Sep 2021 23:04:05 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mOpYy-001JIe-2m; Fri, 10 Sep 2021 19:04:04 -0400
Message-ID: <20210910230403.918647210@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 10 Sep 2021 19:03:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 2/3] tracing/boot: Fix to check the histogram control param is a leaf node
References: <20210910230327.606986082@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Since xbc_node_find_child() doesn't ensure the returned node
is a leaf node (key-value pair or do not have subkeys),
use xbc_node_find_value to ensure the histogram control
parameter is a leaf node in trace_boot_compose_hist_cmd().

Link: https://lkml.kernel.org/r/163119459059.161018.18341288218424528962.stgit@devnote2

Fixes: e66ed86ca6c5 ("tracing/boot: Add per-event histogram action options")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_boot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index a6be48b24774..db6ee372dc6d 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -385,11 +385,11 @@ trace_boot_compose_hist_cmd(struct xbc_node *hnode, char *buf, size_t size)
 	}
 
 	/* Histogram control attributes (mutual exclusive) */
-	if (xbc_node_find_child(hnode, "pause"))
+	if (xbc_node_find_value(hnode, "pause", NULL))
 		append_printf(&buf, end, ":pause");
-	else if (xbc_node_find_child(hnode, "continue"))
+	else if (xbc_node_find_value(hnode, "continue", NULL))
 		append_printf(&buf, end, ":continue");
-	else if (xbc_node_find_child(hnode, "clear"))
+	else if (xbc_node_find_value(hnode, "clear", NULL))
 		append_printf(&buf, end, ":clear");
 
 	/* Histogram handler and actions */
-- 
2.32.0
