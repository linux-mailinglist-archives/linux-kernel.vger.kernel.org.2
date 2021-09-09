Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F334057B3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 15:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354868AbhIINlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 09:41:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353435AbhIINhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:37:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8997C611C9;
        Thu,  9 Sep 2021 13:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631194585;
        bh=9Y5a+D35/vSHniXxF7bWqKbaEJuxfKEJ5ce2XtlGwuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jCyRtPBT+jaM8uYKGKhi4kYJJ+yEtJ+fxu7sL00vZdGN4JjSZCygkMnDhdKQnwJRQ
         rI6C/wuFkV1Acsq+AT0xDxhuTTWB2Aq8iAOiNQ51y5wEemzHX2uJxj2djTz27NDR1H
         Hm4LrcHv4wkU/mO5pC8L3TZX0w2mY83PoEVhIx2ge1uen9kHGVhWVPIIdMJ1HgFjam
         c3hRhIC9IzyaSWj+ActS2n8ZxOUpyXcjHRXfO5bvWCN8wYyW4+LvLBmv89BcRSZtvS
         09o8HqPg5KXm/EjK/5zBsPg+RgzSJE+7QpokSiQ61FE+MOZhvMlFz+K+Zey8/15DH+
         ySwLMSX14fCEg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RESEND PATCH 1/3] tracing/boot: Fix trace_boot_hist_add_array() to check array is value
Date:   Thu,  9 Sep 2021 22:36:23 +0900
Message-Id: <163119458308.161018.1516455973625940212.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163119457578.161018.1615249460598506238.stgit@devnote2>
References: <163119457578.161018.1615249460598506238.stgit@devnote2>
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

