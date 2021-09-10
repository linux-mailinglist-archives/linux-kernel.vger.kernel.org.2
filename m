Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080B24073A9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 01:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbhIJXFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 19:05:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231225AbhIJXFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 19:05:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2F706113E;
        Fri, 10 Sep 2021 23:04:04 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mOpYx-001JI6-Sx; Fri, 10 Sep 2021 19:04:03 -0400
Message-ID: <20210910230403.734443426@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 10 Sep 2021 19:03:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 1/3] tracing/boot: Fix trace_boot_hist_add_array() to check array is value
References: <20210910230327.606986082@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

trace_boot_hist_add_array() uses the combination of
xbc_node_find_child() and xbc_node_get_child() to get the
child node of the key node. But since it missed to check
the child node is data node or not, user can pass the
subkey node for the array node (anode).
To avoid this issue, check the array node is a data node.
Actually, there is xbc_node_find_value(node, key, vnode),
which ensures the @vnode is a value node, so use it in
trace_boot_hist_add_array() to fix this issue.

Link: https://lkml.kernel.org/r/163119458308.161018.1516455973625940212.stgit@devnote2

Fixes: e66ed86ca6c5 ("tracing/boot: Add per-event histogram action options")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_boot.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 388e65d05978..a6be48b24774 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -219,13 +219,12 @@ static int __init
 trace_boot_hist_add_array(struct xbc_node *hnode, char **bufp,
 			  char *end, const char *key)
 {
-	struct xbc_node *knode, *anode;
+	struct xbc_node *anode;
 	const char *p;
 	char sep;
 
-	knode = xbc_node_find_child(hnode, key);
-	if (knode) {
-		anode = xbc_node_get_child(knode);
+	p = xbc_node_find_value(hnode, key, &anode);
+	if (p) {
 		if (!anode) {
 			pr_err("hist.%s requires value(s).\n", key);
 			return -EINVAL;
-- 
2.32.0
