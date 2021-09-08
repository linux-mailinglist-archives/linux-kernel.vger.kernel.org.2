Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4B3403FE4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 21:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351962AbhIHTjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 15:39:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350977AbhIHTjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 15:39:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AC7761164;
        Wed,  8 Sep 2021 19:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631129886;
        bh=c1urIeTLcxvXfHMAgK3GJHpA9/PnLBvBRxDW12izvU4=;
        h=From:To:Cc:Subject:Date:From;
        b=ZhIGeisO/6KLPXt98kGjNCNuwBcXaAofQ3AomuJMGEbM3MnWB5wqOO2VP3UfTQ7Ee
         +pOLuhjImEFVf0UiEu4tB0WCGSOc9u8qDV69CW7pgQwGxCjzQky0010FF9KRyqh8+Q
         WpE2hJLAfvklCGQaY0diWQiaTdKDrk0xp/QEaSuKjoERbAM65Yve6j2gJ8HtX8A8wl
         Uhh1iCuKXEVykn70lSJ9/JGCsECndckZES/liCjDZEh3OtDdkWtyDxWyVb9Tq2Wmb0
         1So1IvhCGn9UJzLg3IUyp2q8N37L8Sv3KHRPotat+I6j0JmDDqbL3HUKVYVjWkPRNS
         WDb3p19UM55Dg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] tracing/boot: Fix to loop on only subkeys
Date:   Thu,  9 Sep 2021 04:38:03 +0900
Message-Id: <163112988361.74896.2267026262061819145.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the commit e5efaeb8a8f5 ("bootconfig: Support mixing
a value and subkeys under a key") allows to co-exist a value
node and key nodes under a node, xbc_node_for_each_child()
is not only returning key node but also a value node.
In the boot-time tracing using xbc_node_for_each_child() to
iterate the events, groups and instances, but those must be
key nodes. Thus it must use xbc_node_for_each_subkey().

Fixes: e5efaeb8a8f5 ("bootconfig: Support mixing a value and subkeys under a key")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_boot.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 1060b0446032..388e65d05978 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -522,14 +522,14 @@ trace_boot_init_events(struct trace_array *tr, struct xbc_node *node)
 	if (!node)
 		return;
 	/* per-event key starts with "event.GROUP.EVENT" */
-	xbc_node_for_each_child(node, gnode) {
+	xbc_node_for_each_subkey(node, gnode) {
 		data = xbc_node_get_data(gnode);
 		if (!strcmp(data, "enable")) {
 			enable_all = true;
 			continue;
 		}
 		enable = false;
-		xbc_node_for_each_child(gnode, enode) {
+		xbc_node_for_each_subkey(gnode, enode) {
 			data = xbc_node_get_data(enode);
 			if (!strcmp(data, "enable")) {
 				enable = true;
@@ -625,7 +625,7 @@ trace_boot_init_instances(struct xbc_node *node)
 	if (!node)
 		return;
 
-	xbc_node_for_each_child(node, inode) {
+	xbc_node_for_each_subkey(node, inode) {
 		p = xbc_node_get_data(inode);
 		if (!p || *p == '\0')
 			continue;

