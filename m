Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A395405733
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 15:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357581AbhIINcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 09:32:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357725AbhIINPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:15:25 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F6FC60555;
        Thu,  9 Sep 2021 12:57:42 +0000 (UTC)
Date:   Thu, 9 Sep 2021 08:57:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH] tracing/boot: Fix to loop on only subkeys
Message-ID: <20210909085741.0eb30589@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: cfd799837dbc48499abb05d1891b3d9992354d3a


Masami Hiramatsu (1):
      tracing/boot: Fix to loop on only subkeys

----
 kernel/trace/trace_boot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
---------------------------
commit cfd799837dbc48499abb05d1891b3d9992354d3a
Author: Masami Hiramatsu <mhiramat@kernel.org>
Date:   Thu Sep 9 04:38:03 2021 +0900

    tracing/boot: Fix to loop on only subkeys
    
    Since the commit e5efaeb8a8f5 ("bootconfig: Support mixing
    a value and subkeys under a key") allows to co-exist a value
    node and key nodes under a node, xbc_node_for_each_child()
    is not only returning key node but also a value node.
    In the boot-time tracing using xbc_node_for_each_child() to
    iterate the events, groups and instances, but those must be
    key nodes. Thus it must use xbc_node_for_each_subkey().
    
    Link: https://lkml.kernel.org/r/163112988361.74896.2267026262061819145.stgit@devnote2
    
    Fixes: e5efaeb8a8f5 ("bootconfig: Support mixing a value and subkeys under a key")
    Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

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
