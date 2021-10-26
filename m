Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37B043B710
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbhJZQ0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:26:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234618AbhJZQ0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:26:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5B7060F0F;
        Tue, 26 Oct 2021 16:23:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mfPEr-000qRk-06;
        Tue, 26 Oct 2021 12:23:49 -0400
Message-ID: <20211026162348.832650089@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 26 Oct 2021 12:23:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [for-next][PATCH 08/12] tracing: Fix missing trace_boot_init_histograms kstrdup NULL checks
References: <20211026162315.297389528@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

trace_boot_init_histograms misses NULL pointer checks for kstrdup
failure.

Link: https://lkml.kernel.org/r/20211015195550.22742-1-mathieu.desnoyers@efficios.com

Fixes: 64dc7f6958ef5 ("tracing/boot: Show correct histogram error command")
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_boot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 8d252f63cd78..0580287d7a0d 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -430,6 +430,8 @@ trace_boot_init_histograms(struct trace_event_file *file,
 		/* All digit started node should be instances. */
 		if (trace_boot_compose_hist_cmd(node, buf, size) == 0) {
 			tmp = kstrdup(buf, GFP_KERNEL);
+			if (!tmp)
+				return;
 			if (trigger_process_regex(file, buf) < 0)
 				pr_err("Failed to apply hist trigger: %s\n", tmp);
 			kfree(tmp);
@@ -439,6 +441,8 @@ trace_boot_init_histograms(struct trace_event_file *file,
 	if (xbc_node_find_subkey(hnode, "keys")) {
 		if (trace_boot_compose_hist_cmd(hnode, buf, size) == 0) {
 			tmp = kstrdup(buf, GFP_KERNEL);
+			if (!tmp)
+				return;
 			if (trigger_process_regex(file, buf) < 0)
 				pr_err("Failed to apply hist trigger: %s\n", tmp);
 			kfree(tmp);
-- 
2.33.0
