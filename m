Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74A440573B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 15:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356660AbhIINcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 09:32:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357670AbhIINPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:15:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 924BD611BF;
        Thu,  9 Sep 2021 13:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631193133;
        bh=9Y5a+D35/vSHniXxF7bWqKbaEJuxfKEJ5ce2XtlGwuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z4wzFKEXhYd0jAwCWwIFCtDMhWBqjhqGefSl/SlsgMpbkP09xV8lCz34W+f7Ykvwj
         4DZzjKJZR74561E/ejxnLxL3jsVhRcBNiaQJFZ5kGQEiuqBz7gY3yHIrg7xLYKnZSp
         c4Haj8W0lXP4AT+G7wZdCa1bLsMI9raYMI/RFgAlauim/hpgywPc7JP9/XRQSkFseV
         kh2kqdC3ANC5456K8XIy1WiLN7H0O3H7su9nrc5HeSmOryqXQmUDuH3EnXArXcdnqi
         4ZASfRhjWRpijhUwlsY/r7hX+A9PmKRC6XZ19BEDT2+6JJJUWBLpnT/iC3YeQTDtZq
         aKR4SxC0GpGgg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 1/3] tracing/boot: Fix trace_boot_hist_add_array() to check array is value
Date:   Thu,  9 Sep 2021 22:12:11 +0900
Message-Id: <163119313078.159092.13886100221831384266.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163119312321.159092.9694278669123009540.stgit@devnote2>
References: <163119312321.159092.9694278669123009540.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trace_boot_hist_add_array() uses the combination of
xbc_node_find_child() and xbc_node_get_child() to get the
child node of the key node. But since it missed to check
the child node is data node or not, user can pass the
subkey node for the array node (anode).
To avoid this issue, check the array node is a data node.
Actually, there is xbc_node_find_value(node, key, vnode),
which ensures the @vnode is a value node, so use it in
trace_boot_hist_add_array() to fix this issue.

Fixes: e66ed86ca6c5 ("tracing/boot: Add per-event histogram action options")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_boot.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 388e65d05978..a6be48b24774 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -219,13 +219,12 @@ static int __init
 trace_boot_hist_add_array(struct xbc_node *hnode, char **bufp,
 			  char *end, const char *key)
 {
-	struct xbc_node *knode, *anode;
+	struct xbc_node *anode;
 	const char *p;
 	char sep;
 
-	knode = xbc_node_find_child(hnode, key);
-	if (knode) {
-		anode = xbc_node_get_child(knode);
+	p = xbc_node_find_value(hnode, key, &anode);
+	if (p) {
 		if (!anode) {
 			pr_err("hist.%s requires value(s).\n", key);
 			return -EINVAL;

