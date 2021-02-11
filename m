Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6580C31837A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 03:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhBKCMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 21:12:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:49750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229997AbhBKCLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 21:11:13 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4183964ED3;
        Thu, 11 Feb 2021 02:09:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lA1QT-00BAVf-8s; Wed, 10 Feb 2021 21:09:49 -0500
Message-ID: <20210211020949.152484151@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Feb 2021 21:09:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jinyang He <hejinyang@loongson.cn>
Subject: [for-next][PATCH 05/12] ftrace: Remove unused ftrace_force_update()
References: <20210211020927.829775774@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinyang He <hejinyang@loongson.cn>

ftrace_force_update() is committed by Commit e1c08bdd9fa7 ("ftrace: force
recording") and removed by Commit cb7be3b2fc2c ("ftrace: remove daemon").
Remove it in header file.

Link: https://lkml.kernel.org/r/1612409671-8249-1-git-send-email-hejinyang@loongson.cn

Signed-off-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 9a8ce28e4485..86e5028bfa20 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -485,7 +485,6 @@ struct dyn_ftrace {
 	struct dyn_arch_ftrace	arch;
 };
 
-int ftrace_force_update(void);
 int ftrace_set_filter_ip(struct ftrace_ops *ops, unsigned long ip,
 			 int remove, int reset);
 int ftrace_set_filter(struct ftrace_ops *ops, unsigned char *buf,
@@ -740,7 +739,6 @@ extern void ftrace_disable_daemon(void);
 extern void ftrace_enable_daemon(void);
 #else /* CONFIG_DYNAMIC_FTRACE */
 static inline int skip_trace(unsigned long ip) { return 0; }
-static inline int ftrace_force_update(void) { return 0; }
 static inline void ftrace_disable_daemon(void) { }
 static inline void ftrace_enable_daemon(void) { }
 static inline void ftrace_module_init(struct module *mod) { }
-- 
2.29.2


