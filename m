Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CFB3DDC77
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbhHBPad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:30:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235047AbhHBPab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:30:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D28F610A8;
        Mon,  2 Aug 2021 15:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627918222;
        bh=FESD1voHusW3G648cywMnCuG4hjMHrItMdZcuY4HogY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W/BViJXYXBEdYkjg8aydPk5p+2nUs2WM/q/vPlFknJB/ThYTW+/aO9bhmotDH6M1f
         BiDTYyu+i7hfsCj1m5EnwW644pLNZ9TWHuZjWyFINBiB/QPXC1DiI1gRk2o+gEVzI1
         97FfW6YFy3ghNiDeuoUiDq5RtdqoUApqYOQaSqlwFOW82VhuBhe71E1O39EXWDQY24
         KAro0feJLspkB7Vw8PM15ic+hBWn1E2XxhS6gvFr0Jy/SBKhGBtnosYOU5xc8u6mzu
         U67RksZv7TV9LhtyzQPcy3qsq1JPISo12mLShVcYrmS6BIh2fY3OhKHvHuAKJi/Ngb
         CYtOEUxXRdW0w==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH 1/3] tracing/boot: Fix a hist trigger dependency for boot time tracing
Date:   Tue,  3 Aug 2021 00:30:20 +0900
Message-Id: <162791822025.552329.8566560619483201174.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162791821009.552329.4358174280895732459.stgit@devnote2>
References: <162791821009.552329.4358174280895732459.stgit@devnote2>
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
 kernel/trace/trace_boot.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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

