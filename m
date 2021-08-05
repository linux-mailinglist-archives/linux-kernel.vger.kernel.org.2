Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A833E1969
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 18:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhHEQZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 12:25:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230212AbhHEQZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 12:25:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80A9461159;
        Thu,  5 Aug 2021 16:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628180731;
        bh=tTvJ0pex6wsXnWa4BHpZMxYpfD7K4z2QKxBU5X57Lck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hcQg+mwtP6h4dMd/6uFxZRzQ9iF3IxQ045l6oD95kgHu6kg6hu+hTSlal/GrmhSzC
         7FMwCE1mRAo+dYqKXw+7gN5T7Nz3COlG3qO02+K5dTc8mpmHxxxzLXWbepLHo9WBGH
         uV0zWCSAJe6Jrl5y7MNhxqsJyWmAh3qmteedOnKlQbYsGgpqHUdNEin+dkfYpsQccV
         ISEgV5AjS/BllyCDpZM9A1G9nsHu6lwzwXi02AYpxoegPzKvs0LvJNzwWNBUazGa3A
         /Ftxv/LrPxIqR9YUrztmCnKy7LX+tVOU8V9+f/sSCpO5yPpwqPMlznUfNrkz5jLo2i
         WuD3bjDTujctA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 1/9] tracing/boot: Fix a hist trigger dependency for boot time tracing
Date:   Fri,  6 Aug 2021 01:25:29 +0900
Message-Id: <162818072887.226227.1489690774195740861.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162818072104.226227.18088999222035270055.stgit@devnote2>
References: <162818072104.226227.18088999222035270055.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a build error when CONFIG_HIST_TRIGGERS=n with boot-time
tracing. Since the trigger_process_regex() is defined only
when CONFIG_HIST_TRIGGERS=y, if it is disabled, the 'actions'
event option also must be disabled.

Fixes: 81a59555ff15 ("tracing/boot: Add per-event settings")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 0 files changed

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 94ef2d099e32..e6dc9269ad75 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -204,13 +204,14 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 		else if (apply_event_filter(file, buf) < 0)
 			pr_err("Failed to apply filter: %s\n", buf);
 	}
-
+#ifdef CONFIG_HIST_TRIGGERS
 	xbc_node_for_each_array_value(enode, "actions", anode, p) {
 		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
 			pr_err("action string is too long: %s\n", p);
 		else if (trigger_process_regex(file, buf) < 0)
 			pr_err("Failed to apply an action: %s\n", buf);
 	}
+#endif
 
 	if (xbc_node_find_value(enode, "enable", NULL)) {
 		if (trace_event_enable_disable(file, 1, 0) < 0)

