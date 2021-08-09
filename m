Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D118C3E492F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbhHIPuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:50:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235792AbhHIPst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:48:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EED260C40;
        Mon,  9 Aug 2021 15:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628524109;
        bh=cpevs3zMIJIdHQ2QBOvyilQSiGu1bvTbDTiTCn3FD48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uRxH37UFMck/9HMhtF8ychmP6qvF7hdKuB1472H08XM9kP+7jxCzBkO71KJYtpyAO
         rq0Cud7QlW/m7lx3fdizJ+26JQMAPsQ6NsKMRy/sNdYvC7ltImcoakR+nXDzbI7cBV
         WoTYDYeF5u1tMcgAMxdJs50qheILQ7gFMMjGrL4fSdzakrsg6yUgRsD3s+IWTdi1Gk
         KvxT16GsejKAq2ECW82KKi3j1Eu3frY9E2s8oPo5nNiVxfXYhgz1+bnrZvH5AupwLO
         xh1cDj10KkIMYAy6NVR3z3dccRu7vvXTrobbQuFkPVaCJsKo7pTcuDWX6cqTf6RajF
         +d7JaOQjeevcA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 05/10] tracing/boot: Show correct histogram error command
Date:   Tue, 10 Aug 2021 00:48:26 +0900
Message-Id: <162852410657.143877.9603399373481908754.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162852406891.143877.12110677006587392853.stgit@devnote2>
References: <162852406891.143877.12110677006587392853.stgit@devnote2>
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
 kernel/trace/trace_boot.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 69558f149620..cfe4a415b468 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -422,6 +422,7 @@ trace_boot_init_histograms(struct trace_event_file *file,
 {
 	struct xbc_node *node;
 	const char *p;
+	char *tmp;
 
 	xbc_node_for_each_subkey(hnode, node) {
 		p = xbc_node_get_data(node);
@@ -429,15 +430,19 @@ trace_boot_init_histograms(struct trace_event_file *file,
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
 #else
@@ -488,7 +493,7 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 			if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
 				pr_err("action string is too long: %s\n", p);
 			else if (trigger_process_regex(file, buf) < 0)
-				pr_err("Failed to apply an action: %s\n", buf);
+				pr_err("Failed to apply an action: %s\n", p);
 		}
 		anode = xbc_node_find_child(enode, "hist");
 		if (anode)

