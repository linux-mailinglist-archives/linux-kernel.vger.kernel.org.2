Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7843E50EA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 04:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237411AbhHJCHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 22:07:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237382AbhHJCHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 22:07:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42E0661040;
        Tue, 10 Aug 2021 02:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628561235;
        bh=JSmjCt9aBGdj9hOSm6aKpUpqMXkuEWepoDs4IlQC5w0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VPtbLgiJcyoHuYYX9v7jCyTXu3q7EcrwAkd5zDGCHsu68kJ1oGlEQ+TgXpF4Javu5
         sFvpTa3Y/wCV3ZR84yAlj0xz57o5+dWMFHVXTpzbjyTYP8Onc9kJnR6CwmVzCgYO/H
         Rh5OSWFl9wb+w/KvXnlHNPGw9B+pODz2szNDY08TeHsgASsshWtZnDUqQsEPJUvCZd
         sQbFW5a2In5bQhWIVQTIIzrKHRuwQYRYqxNT9sBE0lvQ/3cLdHvpqauHSAYcxBgOAo
         f6lvR7/EWsC50FMelUmg3y+0RRt8T9q7fKcLJO0PfGWwFvqpfnmbcoZNELY+3K6VSL
         aocYI6S78QnOg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v4 01/10] tracing/boot: Fix a hist trigger dependency for boot time tracing
Date:   Tue, 10 Aug 2021 11:07:14 +0900
Message-Id: <162856123376.203126.582144262622247352.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162856122550.203126.17607127017097781682.stgit@devnote2>
References: <162856122550.203126.17607127017097781682.stgit@devnote2>
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
 Changes in v3:
  - Use IS_ENABLED() instead of #ifdef and show an error if
    CONFIG_HIST_TRIGGERS is not set but per-event actions
    specified.
---
 kernel/trace/trace_boot.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 94ef2d099e32..d713714cba67 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -205,12 +205,15 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 			pr_err("Failed to apply filter: %s\n", buf);
 	}
 
-	xbc_node_for_each_array_value(enode, "actions", anode, p) {
-		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
-			pr_err("action string is too long: %s\n", p);
-		else if (trigger_process_regex(file, buf) < 0)
-			pr_err("Failed to apply an action: %s\n", buf);
-	}
+	if (IS_ENABLED(CONFIG_HIST_TRIGGERS)) {
+		xbc_node_for_each_array_value(enode, "actions", anode, p) {
+			if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
+				pr_err("action string is too long: %s\n", p);
+			else if (trigger_process_regex(file, buf) < 0)
+				pr_err("Failed to apply an action: %s\n", buf);
+		}
+	} else if (xbc_node_find_value(enode, "actions", NULL))
+		pr_err("Failed to apply event actions because CONFIG_HIST_TRIGGERS is not set.\n");
 
 	if (xbc_node_find_value(enode, "enable", NULL)) {
 		if (trace_event_enable_disable(file, 1, 0) < 0)

