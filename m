Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FCE437F93
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbhJVUwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:52:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234409AbhJVUvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:51:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F63961373;
        Fri, 22 Oct 2021 20:48:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1T1-000QQB-51;
        Fri, 22 Oct 2021 16:48:43 -0400
Message-ID: <20211022204842.991447381@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:48:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [for-next][PATCH 26/40] ftrace: Add ftrace_add_rec_direct function
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

Factor out the code that adds (ip, addr) tuple to direct_functions
hash in new ftrace_add_rec_direct function. It will be used in
following patches.

Link: https://lkml.kernel.org/r/20211008091336.33616-6-jolsa@kernel.org

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 64 +++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 8b5801881271..ccbd8377e580 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2390,6 +2390,39 @@ unsigned long ftrace_find_rec_direct(unsigned long ip)
 	return entry->direct;
 }
 
+static struct ftrace_func_entry*
+ftrace_add_rec_direct(unsigned long ip, unsigned long addr,
+		      struct ftrace_hash **free_hash)
+{
+	struct ftrace_func_entry *entry;
+
+	if (ftrace_hash_empty(direct_functions) ||
+	    direct_functions->count > 2 * (1 << direct_functions->size_bits)) {
+		struct ftrace_hash *new_hash;
+		int size = ftrace_hash_empty(direct_functions) ? 0 :
+			direct_functions->count + 1;
+
+		if (size < 32)
+			size = 32;
+
+		new_hash = dup_hash(direct_functions, size);
+		if (!new_hash)
+			return NULL;
+
+		*free_hash = direct_functions;
+		direct_functions = new_hash;
+	}
+
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return NULL;
+
+	entry->ip = ip;
+	entry->direct = addr;
+	__add_hash_entry(direct_functions, entry);
+	return entry;
+}
+
 static void call_direct_funcs(unsigned long ip, unsigned long pip,
 			      struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
@@ -5106,39 +5139,16 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
 	}
 
 	ret = -ENOMEM;
-	if (ftrace_hash_empty(direct_functions) ||
-	    direct_functions->count > 2 * (1 << direct_functions->size_bits)) {
-		struct ftrace_hash *new_hash;
-		int size = ftrace_hash_empty(direct_functions) ? 0 :
-			direct_functions->count + 1;
-
-		if (size < 32)
-			size = 32;
-
-		new_hash = dup_hash(direct_functions, size);
-		if (!new_hash)
-			goto out_unlock;
-
-		free_hash = direct_functions;
-		direct_functions = new_hash;
-	}
-
-	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		goto out_unlock;
-
 	direct = ftrace_find_direct_func(addr);
 	if (!direct) {
 		direct = ftrace_alloc_direct_func(addr);
-		if (!direct) {
-			kfree(entry);
+		if (!direct)
 			goto out_unlock;
-		}
 	}
 
-	entry->ip = ip;
-	entry->direct = addr;
-	__add_hash_entry(direct_functions, entry);
+	entry = ftrace_add_rec_direct(ip, addr, &free_hash);
+	if (!entry)
+		goto out_unlock;
 
 	ret = ftrace_set_filter_ip(&direct_ops, ip, 0, 0);
 	if (ret)
-- 
2.33.0
