Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9493F2DC3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 16:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240927AbhHTONA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 10:13:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240801AbhHTOMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 10:12:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 904A36113D;
        Fri, 20 Aug 2021 14:12:03 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mH5Fa-004oNS-Ki; Fri, 20 Aug 2021 10:12:02 -0400
Message-ID: <20210820141202.481189564@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 20 Aug 2021 10:11:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 8/9] tracing/probes: Have process_fetch_insn() take a void * instead of
 pt_regs
References: <20210820141109.993445617@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

In preparation to allow event probes to use the process_fetch_insn()
callback in trace_probe_tmpl.h, change the data passed to it from a
pointer to pt_regs, as the event probe will not be using regs, and make it
a void pointer instead.

Update the process_fetch_insn() callers for kprobe and uprobe events to
have the regs defined in the function and just typecast the void pointer
parameter.

Link: https://lkml.kernel.org/r/20210819041842.291622924@goodmis.org

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c     | 3 ++-
 kernel/trace/trace_probe_tmpl.h | 6 +++---
 kernel/trace/trace_uprobe.c     | 3 ++-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index c6fe7a6e3f35..4b013d24f5a9 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1325,9 +1325,10 @@ probe_mem_read(void *dest, void *src, size_t size)
 
 /* Note that we don't verify it, since the code does not come from user space */
 static int
-process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
+process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
 		   void *base)
 {
+	struct pt_regs *regs = rec;
 	unsigned long val;
 
 retry:
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index f003c5d02a3a..b3bdb8ddb862 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -54,7 +54,7 @@ fetch_apply_bitfield(struct fetch_insn *code, void *buf)
  * If dest is NULL, don't store result and return required dynamic data size.
  */
 static int
-process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs,
+process_fetch_insn(struct fetch_insn *code, void *rec,
 		   void *dest, void *base);
 static nokprobe_inline int fetch_store_strlen(unsigned long addr);
 static nokprobe_inline int
@@ -188,7 +188,7 @@ __get_data_size(struct trace_probe *tp, struct pt_regs *regs)
 
 /* Store the value of each argument */
 static nokprobe_inline void
-store_trace_args(void *data, struct trace_probe *tp, struct pt_regs *regs,
+store_trace_args(void *data, struct trace_probe *tp, void *rec,
 		 int header_size, int maxlen)
 {
 	struct probe_arg *arg;
@@ -203,7 +203,7 @@ store_trace_args(void *data, struct trace_probe *tp, struct pt_regs *regs,
 		/* Point the dynamic data area if needed */
 		if (unlikely(arg->dynamic))
 			*dl = make_data_loc(maxlen, dyndata - base);
-		ret = process_fetch_insn(arg->code, regs, dl, base);
+		ret = process_fetch_insn(arg->code, rec, dl, base);
 		if (unlikely(ret < 0 && arg->dynamic)) {
 			*dl = make_data_loc(0, dyndata - base);
 		} else {
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 09f8ca7f7ba0..d219ba50efbd 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -213,9 +213,10 @@ static unsigned long translate_user_vaddr(unsigned long file_offset)
 
 /* Note that we don't verify it, since the code does not come from user space */
 static int
-process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
+process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
 		   void *base)
 {
+	struct pt_regs *regs = rec;
 	unsigned long val;
 
 	/* 1st stage: get value from context */
-- 
2.30.2
