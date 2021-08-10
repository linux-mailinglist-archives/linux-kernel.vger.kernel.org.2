Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79A83E50EE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 04:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbhHJCIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 22:08:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237481AbhHJCIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 22:08:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8627861040;
        Tue, 10 Aug 2021 02:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628561266;
        bh=5MnFG8fAy3IYOBlhLjWSblXJ/ATvpy1Xzb22XyyqgzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f055yY4ko1YCIt4el1aRSve2RmaATOESyON2//ZXeswzKnddlqTOEArm1zIYn7iMx
         lgQWTWuBVO02r7xbGb741n6wAsgemJXlDy5tI5+/jwN+W+rGFQWavIo08TK14cDas5
         4RBY1SBt7vAqUTMNCUkKDvrbRQX+e2T2w/hy89N7a0UaL3UPPDJZA+SR9XS/BPutVL
         WlyflVhPeVBVJ4wFKE8tlCrorb/5stDT+RJv/CI1gDSlcknuQogAFLsLmG4BvZaPfX
         9Bzxm6300Y84ZgYZcYZ4LBClYGtBpggf3DdGeEhlDApl6N3ae66fk396skxfzApO9O
         mVVkUBEIZiM9Q==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v4 05/10] tracing/boot: Show correct histogram error command
Date:   Tue, 10 Aug 2021 11:07:44 +0900
Message-Id: <162856126413.203126.9465564928450701424.stgit@devnote2>
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

Since trigger_process_regex() modifies given trigger actions
while parsing, the error message couldn't show what command
was passed to the trigger_process_regex() when it returns
an error.

To fix that, show the backed up trigger action command
instead of parsed buffer.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v4:
  - Fix to add braces for if block.
---
 kernel/trace/trace_boot.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 1a2b270e9cda..1060b0446032 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -422,6 +422,7 @@ trace_boot_init_histograms(struct trace_event_file *file,
 {
 	struct xbc_node *node;
 	const char *p;
+	char *tmp;
 
 	xbc_node_for_each_subkey(hnode, node) {
 		p = xbc_node_get_data(node);
@@ -429,15 +430,20 @@ trace_boot_init_histograms(struct trace_event_file *file,
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
-		if (trace_boot_compose_hist_cmd(hnode, buf, size) == 0)
+		if (trace_boot_compose_hist_cmd(hnode, buf, size) == 0) {
+			tmp = kstrdup(buf, GFP_KERNEL);
 			if (trigger_process_regex(file, buf) < 0)
-				pr_err("Failed to apply hist trigger: %s\n", buf);
+				pr_err("Failed to apply hist trigger: %s\n", tmp);
+			kfree(tmp);
+		}
 	}
 }
 #else
@@ -488,7 +494,7 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 			if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
 				pr_err("action string is too long: %s\n", p);
 			else if (trigger_process_regex(file, buf) < 0)
-				pr_err("Failed to apply an action: %s\n", buf);
+				pr_err("Failed to apply an action: %s\n", p);
 		}
 		anode = xbc_node_find_child(enode, "hist");
 		if (anode)

