Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA113EF2D5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbhHQToY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:44:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233690AbhHQTnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:43:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 068016109F;
        Tue, 17 Aug 2021 19:43:07 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mG4zK-004TVC-2n; Tue, 17 Aug 2021 15:43:06 -0400
Message-ID: <20210817194305.923918067@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 17 Aug 2021 15:42:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        zhaoxiao <zhaoxiao@uniontech.com>
Subject: [for-next][PATCH 18/19] tracepoint: Fix kerneldoc comments
References: <20210817194207.947725935@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhaoxiao <zhaoxiao@uniontech.com>

Fix function name in tracepoint.c kernel-doc comment
to remove a warning found by clang_w1.

kernel/tracepoint.c:589: warning: expecting prototype for register_tracepoint_notifier(). Prototype was for register_tracepoint_module_notifier() instead
kernel/tracepoint.c:613: warning: expecting prototype for unregister_tracepoint_notifier(). Prototype was for unregister_tracepoint_module_notifier() instead

Link: https://lkml.kernel.org/r/20210816052430.16539-1-zhaoxiao@uniontech.com

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/tracepoint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index efd14c79fab4..64ea283f2f86 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -577,7 +577,7 @@ bool trace_module_has_bad_taint(struct module *mod)
 static BLOCKING_NOTIFIER_HEAD(tracepoint_notify_list);
 
 /**
- * register_tracepoint_notifier - register tracepoint coming/going notifier
+ * register_tracepoint_module_notifier - register tracepoint coming/going notifier
  * @nb: notifier block
  *
  * Notifiers registered with this function are called on module
@@ -603,7 +603,7 @@ int register_tracepoint_module_notifier(struct notifier_block *nb)
 EXPORT_SYMBOL_GPL(register_tracepoint_module_notifier);
 
 /**
- * unregister_tracepoint_notifier - unregister tracepoint coming/going notifier
+ * unregister_tracepoint_module_notifier - unregister tracepoint coming/going notifier
  * @nb: notifier block
  *
  * The notifier block callback should expect a "struct tp_module" data
-- 
2.30.2
