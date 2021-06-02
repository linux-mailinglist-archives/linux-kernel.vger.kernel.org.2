Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DE5398CCC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhFBOet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:34:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230072AbhFBOeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:34:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94575610E5;
        Wed,  2 Jun 2021 14:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622644383;
        bh=hF0gUK5h5fG4VQJcQAexS0ZkmAECiuolBUP7hlmAfaU=;
        h=From:To:Cc:Subject:Date:From;
        b=Ob5V39sTbdgXZrFmF6ULpnSyc6aqrJAVHvTPohn3s/DQ7+RzFooOfYXz0N25wkxz7
         mjvB4LcMPiQ3krZQZuTpH05XZwvAyUT6GecK2G7Y6B5supsetFaKfzJy1IhDVdyBjD
         62kYXWK53LAJZepaw2tY5dk7VwjifR4sTIhAs63oik0w0TCPAR5n67dq2gI206c2BL
         0sSNlPRMB1N6OmRO89234twtbiy5wlT5Ux6A8Xl+yPg+xC7lNbL6iDECjCnYiON2HE
         gxC0gz6cgEvdJx9z6BOdOmP7RwC0qgF1FgsTW7a4+dthmzY4Op/4U1SK2kTywN/jnj
         h6yp2P0CZsWjA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tracing/boot: Add per-group/all events enablement
Date:   Wed,  2 Jun 2021 23:33:00 +0900
Message-Id: <162264438005.302580.12019174481201855444.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ftrace.event.<GROUP>.enable and ftrace.event.enable
boot-time tracing, which enables all events under
given GROUP and all events respectivly.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_boot.c |   27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index a82f03f385f8..94ef2d099e32 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -225,14 +225,37 @@ static void __init
 trace_boot_init_events(struct trace_array *tr, struct xbc_node *node)
 {
 	struct xbc_node *gnode, *enode;
+	bool enable, enable_all = false;
+	const char *data;
 
 	node = xbc_node_find_child(node, "event");
 	if (!node)
 		return;
 	/* per-event key starts with "event.GROUP.EVENT" */
-	xbc_node_for_each_child(node, gnode)
-		xbc_node_for_each_child(gnode, enode)
+	xbc_node_for_each_child(node, gnode) {
+		data = xbc_node_get_data(gnode);
+		if (!strcmp(data, "enable")) {
+			enable_all = true;
+			continue;
+		}
+		enable = false;
+		xbc_node_for_each_child(gnode, enode) {
+			data = xbc_node_get_data(enode);
+			if (!strcmp(data, "enable")) {
+				enable = true;
+				continue;
+			}
 			trace_boot_init_one_event(tr, gnode, enode);
+		}
+		/* Event enablement must be done after event settings */
+		if (enable) {
+			data = xbc_node_get_data(gnode);
+			trace_array_set_clr_event(tr, data, NULL, true);
+		}
+	}
+	/* Ditto */
+	if (enable_all)
+		trace_array_set_clr_event(tr, NULL, NULL, true);
 }
 #else
 #define trace_boot_enable_events(tr, node) do {} while (0)

