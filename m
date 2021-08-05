Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91763E196C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 18:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhHEQ0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 12:26:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230212AbhHEQ0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 12:26:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEFA061168;
        Thu,  5 Aug 2021 16:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628180753;
        bh=TTgo7Q6Ai/7opiIe6eKHafeirXXVso63gQ/2RHmMy+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XGVsDYofn/jJazbtm5O+JdWfc8Wub5xIijyyt1ydgRcwQtK3FTuZ1+H03UKDoTDv0
         zdAjyHWShPSuWFiOCpb0o87ouUmzs+ji2RYzwcaUbpmOnNrOxitQ7EXxV6mEi/hATE
         ASHNx6N49FVVOncPx5SVywjw7c/1LE/69vem7l/YfWH+IUpX26huMVjewh1dxoewqc
         4PJ4k0YOIXKKK9HiVnas9ikd7OiMH2mRV4CDIQdjk9cgjPxYQXO9JXY+GXxVjjngyv
         /s0/zHUq5hizHI9ms9gTdMfX/jiUg4CCjh+OIok8FkpFbgtIX/qYVqYPiyj1Hg6B3z
         oio+A/qN6p1sw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 4/9] tracing/boot: Support multiple histograms for each event
Date:   Fri,  6 Aug 2021 01:25:51 +0900
Message-Id: <162818075140.226227.834209417930766316.stgit@devnote2>
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
 0 files changed

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 0db0775d37af..1f4b80f6fcb6 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -303,7 +303,7 @@ trace_boot_hist_add_handlers(struct xbc_node *hnode, char **bufp,
 /*
  * Histogram boottime tracing syntax.
  *
- * ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist {
+ * ftrace.[instance.INSTANCE.]event.GROUP.EVENT.hist[.N] {
  *	keys = <KEY>[,...]
  *	values = <VAL>[,...]
  *	sort = <SORT-KEY>[,...]
@@ -392,6 +392,32 @@ trace_boot_compose_hist_cmd(struct xbc_node *hnode, char *buf, size_t size)
 
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
+
+}
 #endif
 
 static void __init
@@ -435,11 +461,8 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 			pr_err("Failed to apply an action: %s\n", buf);
 	}
 	anode = xbc_node_find_child(enode, "hist");
-	if (anode &&
-	    trace_boot_compose_hist_cmd(anode, buf, ARRAY_SIZE(buf)) == 0) {
-		if (trigger_process_regex(file, buf) < 0)
-			pr_err("Failed to apply hist trigger: %s\n", buf);
-	}
+	if (anode)
+		trace_boot_init_histograms(file, anode, buf, ARRAY_SIZE(buf));
 #endif
 
 	if (xbc_node_find_value(enode, "enable", NULL)) {

