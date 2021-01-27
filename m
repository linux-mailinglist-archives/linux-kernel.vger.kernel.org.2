Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26DB305F56
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343585AbhA0PRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:17:52 -0500
Received: from foss.arm.com ([217.140.110.172]:50722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343634AbhA0PQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:16:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BF0A11FB;
        Wed, 27 Jan 2021 07:15:17 -0800 (PST)
Received: from net-arm-thunderx2-02.shanghai.arm.com (net-arm-thunderx2-02.shanghai.arm.com [10.169.208.224])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5678C3F66B;
        Wed, 27 Jan 2021 07:15:15 -0800 (PST)
From:   Jianlin Lv <Jianlin.Lv@arm.com>
To:     rostedt@goodmis.org, mingo@redhat.com, mhiramat@kernel.org,
        oleg@redhat.com
Cc:     Jianlin.Lv@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4] tracing: precise log info for kretprobe addr err
Date:   Wed, 27 Jan 2021 23:15:07 +0800
Message-Id: <20210127151507.4185234-1-Jianlin.Lv@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to create kretprobe with the wrong function symbol in tracefs;
The error is triggered in the register_trace_kprobe() and recorded as
FAIL_REG_PROBE issue,

Example:
  $ cd /sys/kernel/debug/tracing
  $ echo 'r:myprobe ERROR_SYMBOL_XXX ret=%x0' >> kprobe_events
    bash: echo: write error: Invalid argument
  $ cat error_log
    [142797.347877] trace_kprobe: error: Failed to register probe event
    Command: r:myprobe ERROR_SYMBOL_XXX ret=%x0
                       ^

This error can be detected in the parameter parsing stage, the effect of
applying this patch is as follows:

  $ echo 'r:myprobe ERROR_SYMBOL_XXX ret=%x0' >> kprobe_events
    bash: echo: write error: Invalid argument
  $ cat error_log
    [415.89]trace_kprobe: error: Retprobe address must be an function entry
    Command: r:myprobe ERROR_SYMBOL_XXX ret=%x0
                       ^
v2 changes:
- Added !strchr(symbol, ':') to check whether symbol is really bad
  or from a module.

Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
---
v2: added !strchr(symbol, ':') to check really bad symbol or from module.
v4: added changelog and code comments.
---
 kernel/trace/trace_kprobe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index e6fba1798771..384208a38f82 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -830,7 +830,8 @@ static int trace_kprobe_create(int argc, const char *argv[])
 			flags |= TPARG_FL_RETURN;
 		if (kprobe_on_func_entry(NULL, symbol, offset))
 			flags |= TPARG_FL_FENTRY;
-		if (offset && is_return && !(flags & TPARG_FL_FENTRY)) {
+		/* Check whether symbol is really bad or from a module */
+		if (!strchr(symbol, ':') && is_return && !(flags & TPARG_FL_FENTRY)) {
 			trace_probe_log_err(0, BAD_RETPROBE);
 			goto parse_error;
 		}
-- 
2.25.1

