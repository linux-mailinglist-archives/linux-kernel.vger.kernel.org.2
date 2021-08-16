Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82383ECE05
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 07:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbhHPFZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 01:25:16 -0400
Received: from smtpbg702.qq.com ([203.205.195.102]:51404 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233144AbhHPFZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 01:25:14 -0400
X-QQ-mid: bizesmtp46t1629091473t2zcb0na
Received: from localhost.localdomain (unknown [111.207.172.18])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 16 Aug 2021 13:24:31 +0800 (CST)
X-QQ-SSF: 0140000000200030C000B00B0000000
X-QQ-FEAT: u9yQq91qdYWOaj06YyGGFdbq/LLLhibrDXSwguZjzCdSOrQtD7Neu9BlgelN/
        iPvSWvEeSWyw2oU9ETP38y9Bmdo3hS8rrvF1RSi9VPd9/4cU97XMPcWmMerhKzkbFB6o45j
        reYE60M7LOWChRI+MMDBM1+aPqJBENW1LBq1QAtz3Aba7Tz5q8tFGL6y1dWgtHLtgzaCyB1
        V2Kr7Pi7uPosA2U07yVpV7i4zsl85g2tsElfPKrb9ncYM36KqrmrR7Mlk8JEOnXytgplS54
        Wb9BcNVozLe/6M1uSFvn06DvfuylE2hNwf+vFtn41mn/vWpz+F8Soc172bgvZ0MbaPOw==
X-QQ-GoodBg: 2
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     gustavoars@kernel.org
Cc:     rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] tracepoint: Fix the comment style
Date:   Mon, 16 Aug 2021 13:24:30 +0800
Message-Id: <20210816052430.16539-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix function name in tracepoint.c kernel-doc comment
to remove a warning found by clang_w1.

kernel/tracepoint.c:589: warning: expecting prototype for register_tracepoint_notifier(). Prototype was for register_tracepoint_module_notifier() instead
kernel/tracepoint.c:613: warning: expecting prototype for unregister_tracepoint_notifier(). Prototype was for unregister_tracepoint_module_notifier() instead

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
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
2.20.1



