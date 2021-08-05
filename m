Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F6B3E196D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 18:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbhHEQ0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 12:26:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232071AbhHEQ0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 12:26:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C7C6610CD;
        Thu,  5 Aug 2021 16:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628180760;
        bh=ipCVV9cLYyzHD22of84dHyKeBy4cHA1ha76cWKwXx5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dp8Dwb5KqxW/7M2G0ORUQZMMkFggaYtF0oBtxiH4SgvlSfluGiwn/OgZ8m8W3OTmg
         IqkaYdzZScJw2N1jdTOpI2OS5m4WJd7x7KobZ3E4muUI6dcAfmL9IgzSvFlnnrZzN4
         jJe4Drlm7KYiWnfgWz5nOlX58Ulec0U9RigUHynPe/CztopqGyUN/RPUCCmB4LCab9
         dILWGE6LxK7vpYbjDlWeylgF2jn+KdMZOaBt6yBTMlKUFaiG3FHqZH4IroQaTx3jmT
         4M/VY5W7twwyfC5oI+V1LANJx1lmsM7G36pUX9eaXcjVMqSZOgw84MLG4bNKn/+9qs
         4RZsX0tULVyhw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 5/9] tracing/boot: Show correct histogram error command
Date:   Fri,  6 Aug 2021 01:25:59 +0900
Message-Id: <162818075888.226227.14156763636028793396.stgit@devnote2>
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

Since trigger_process_regex() modifies given trigger actions
while parsing, the error message couldn't show what command
was passed to the trigger_process_regex() when it returns
an error.

To fix that, show the backed up trigger action command
instead of parsed buffer.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 0 files changed

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 1f4b80f6fcb6..0fa7167bb1e5 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -399,6 +399,7 @@ trace_boot_init_histograms(struct trace_event_file *file,
 {
 	struct xbc_node *node;
 	const char *p;
+	char *tmp;
 
 	xbc_node_for_each_subkey(hnode, node) {
 		p = xbc_node_get_data(node);
@@ -406,15 +407,19 @@ trace_boot_init_histograms(struct trace_event_file *file,
 			continue;
 		/* All digit started node should be instances. */
 		if (trace_boot_compose_hist_cmd(node, buf, size) == 0) {
+			tmp = kstrdup(buf, GFP_KERNEL);
 			if (trigger_process_regex(file, buf) < 0)
-				pr_err("Failed to apply hist trigger: %s\n", buf);
+				pr_err("Failed to apply hist trigger: %s\n", tmp);
+			kfree(tmp);
 		}
 	}
 
 	if (xbc_node_find_child(hnode, "keys")) {
 		if (trace_boot_compose_hist_cmd(hnode, buf, size) == 0)
+			tmp = kstrdup(buf, GFP_KERNEL);
 			if (trigger_process_regex(file, buf) < 0)
-				pr_err("Failed to apply hist trigger: %s\n", buf);
+				pr_err("Failed to apply hist trigger: %s\n", tmp);
+			kfree(tmp);
 	}
 
 }
@@ -458,7 +463,7 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
 			pr_err("action string is too long: %s\n", p);
 		else if (trigger_process_regex(file, buf) < 0)
-			pr_err("Failed to apply an action: %s\n", buf);
+			pr_err("Failed to apply an action: %s\n", p);
 	}
 	anode = xbc_node_find_child(enode, "hist");
 	if (anode)

