Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799FB3E50ED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 04:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbhHJCIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 22:08:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237458AbhHJCIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 22:08:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11A3E610EA;
        Tue, 10 Aug 2021 02:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628561258;
        bh=+Eoht/nwkfIIOii/JuqUnPPbCyoHQDT6irRFJbpfRcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SH4/SJ+/0XTVJjlcBf1j6+ylpxccTUMlLrmSsOLpabESAn6Il6dVe+qd0Lw3Zm7XZ
         r/NcKNoiFDtgSzVj5miju6SprEjjlwjQNvt4v0ti+QLgGeauhT6eUNSd555R7lBulC
         bFrQvd8l8xLdhjyCCm2Uu8VSEzq8cGdJtmLf7EQJCTtq2/Kr2iJ1AaRc81ZOWjY6Lo
         CgLHIsTIFwIDXs0Ci9w/wGIObY6dmEWJT6pmFGpaV36vxVgNVYg3iMbqIPig3zO0Ll
         0emeB20q1SvjRhTixarXd5cCRtOTfSorHFuXGiaJ4OAFvPFjVp+DmMeR+utmERIx19
         ciU8UlY9a4KHA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v4 04/10] tracing/boot: Support multiple histograms for each event
Date:   Tue, 10 Aug 2021 11:07:36 +0900
Message-Id: <162856125628.203126.15846930277378572120.stgit@devnote2>
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

Add multiple histograms support for each event. This allows
user to set multiple histograms to an event.

ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist[.N] {
...
}

The 'N' is a digit started string and it can be omitted
for the default histogram.

For example, multiple hist triggers example in the
Documentation/trace/histogram.rst can be written as below;

ftrace.event.net.netif_receive_skb.hist {
	1 {
		keys = skbaddr.hex
		values = len
		filter = len < 0
	}
	2 {
		keys = skbaddr.hex
		values = len
		filter = len > 4096
	}
	3 {
		keys = skbaddr.hex
		values = len
		filter = len == 256
	}
	4 {
		keys = skbaddr.hex
		values = len
	}
	5 {
		keys = len
		values = common_preempt_count
	}
}

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v3:
  - Fixes a build error when CONFIG_HIST_TRIGGERS=n.
---
 kernel/trace/trace_boot.c |   41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index f024f27b3602..1a2b270e9cda 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -324,7 +324,7 @@ trace_boot_hist_add_handlers(struct xbc_node *hnode, char **bufp,
 /*
  * Histogram boottime tracing syntax.
  *
- * ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist {
+ * ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist[.N] {
  *	keys = <KEY>[,...]
  *	values = <VAL>[,...]
  *	sort = <SORT-KEY>[,...]
@@ -415,11 +415,37 @@ trace_boot_compose_hist_cmd(struct xbc_node *hnode, char *buf, size_t size)
 
 	return 0;
 }
+
+static void __init
+trace_boot_init_histograms(struct trace_event_file *file,
+			   struct xbc_node *hnode, char *buf, size_t size)
+{
+	struct xbc_node *node;
+	const char *p;
+
+	xbc_node_for_each_subkey(hnode, node) {
+		p = xbc_node_get_data(node);
+		if (!isdigit(p[0]))
+			continue;
+		/* All digit started node should be instances. */
+		if (trace_boot_compose_hist_cmd(node, buf, size) == 0) {
+			if (trigger_process_regex(file, buf) < 0)
+				pr_err("Failed to apply hist trigger: %s\n", buf);
+		}
+	}
+
+	if (xbc_node_find_child(hnode, "keys")) {
+		if (trace_boot_compose_hist_cmd(hnode, buf, size) == 0)
+			if (trigger_process_regex(file, buf) < 0)
+				pr_err("Failed to apply hist trigger: %s\n", buf);
+	}
+}
 #else
-static int __init
-trace_boot_compose_hist_cmd(struct xbc_node *hnode, char *buf, size_t size)
+static void __init
+trace_boot_init_histograms(struct trace_event_file *file,
+			   struct xbc_node *hnode, char *buf, size_t size)
 {
-	return -EOPNOTSUPP;
+	/* do nothing */
 }
 #endif
 
@@ -465,11 +491,8 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 				pr_err("Failed to apply an action: %s\n", buf);
 		}
 		anode = xbc_node_find_child(enode, "hist");
-		if (anode &&
-		    trace_boot_compose_hist_cmd(anode, buf, ARRAY_SIZE(buf)) == 0) {
-			if (trigger_process_regex(file, buf) < 0)
-				pr_err("Failed to apply hist trigger: %s\n", buf);
-		}
+		if (anode)
+			trace_boot_init_histograms(file, anode, buf, ARRAY_SIZE(buf));
 	} else if (xbc_node_find_value(enode, "actions", NULL))
 		pr_err("Failed to apply event actions because CONFIG_HIST_TRIGGERS is not set.\n");
 

