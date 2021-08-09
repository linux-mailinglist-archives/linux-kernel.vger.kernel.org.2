Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8A93E491E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbhHIPsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:48:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235649AbhHIPsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:48:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63F1C60C40;
        Mon,  9 Aug 2021 15:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628524079;
        bh=JSmjCt9aBGdj9hOSm6aKpUpqMXkuEWepoDs4IlQC5w0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WEkQ1Dds5OD720GFAkYRSoqLfaXRCXIUiuezKeAay89/FG6qrIzFM40j8JnCToyzo
         jpyhb2Ge4MFSB2cwhs6bPZ9JVkKOJfek2+4yZQmxujQjU+uUMXJG/q2WQKP/xaude5
         YmFuRcLEzQTzxRYOa4inooHQlw6G12ArFSG6q/1asl5R+0OgfEezeaYLWEBxk+S9Pb
         268J28u7fH1488mUmr2kdW5VIS3MVVEHcRdL7DfgDbM7eHI7g282PZFo2TnzBbPDrZ
         ans/72raY0tE89MkwdI7YAkuHvBIo4TUmNQjI5bYtaVVKxvF9XbWUdrRFg5fJq8fyH
         TuIXcyPnH8r9A==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 01/10] tracing/boot: Fix a hist trigger dependency for boot time tracing
Date:   Tue, 10 Aug 2021 00:47:57 +0900
Message-Id: <162852407693.143877.7925780893791876618.stgit@devnote2>
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

Fixes a build error when CONFIG_HIST_TRIGGERS=n with boot-time
tracing. Since the trigger_process_regex() is defined only
when CONFIG_HIST_TRIGGERS=y, if it is disabled, the 'actions'
event option also must be disabled.

Fixes: 81a59555ff15 ("tracing/boot: Add per-event settings")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v3:
  - Use IS_ENABLED() instead of #ifdef and show an error if
    CONFIG_HIST_TRIGGERS is not set but per-event actions
    specified.
---
 kernel/trace/trace_boot.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index 94ef2d099e32..d713714cba67 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -205,12 +205,15 @@ trace_boot_init_one_event(struct trace_array *tr, struct xbc_node *gnode,
 			pr_err("Failed to apply filter: %s\n", buf);
 	}
 
-	xbc_node_for_each_array_value(enode, "actions", anode, p) {
-		if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
-			pr_err("action string is too long: %s\n", p);
-		else if (trigger_process_regex(file, buf) < 0)
-			pr_err("Failed to apply an action: %s\n", buf);
-	}
+	if (IS_ENABLED(CONFIG_HIST_TRIGGERS)) {
+		xbc_node_for_each_array_value(enode, "actions", anode, p) {
+			if (strlcpy(buf, p, ARRAY_SIZE(buf)) >= ARRAY_SIZE(buf))
+				pr_err("action string is too long: %s\n", p);
+			else if (trigger_process_regex(file, buf) < 0)
+				pr_err("Failed to apply an action: %s\n", buf);
+		}
+	} else if (xbc_node_find_value(enode, "actions", NULL))
+		pr_err("Failed to apply event actions because CONFIG_HIST_TRIGGERS is not set.\n");
 
 	if (xbc_node_find_value(enode, "enable", NULL)) {
 		if (trace_event_enable_disable(file, 1, 0) < 0)

