Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84E1405737
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 15:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358334AbhIINcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 09:32:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357693AbhIINPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:15:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9ECE611C8;
        Thu,  9 Sep 2021 13:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631193140;
        bh=TDUAYeCvyONIXLM76ViX+hbRv3DvfoCaoQAVbfe/tQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eIxngzkh/sFoUV4UAmmKPE+L7/SXqMJQc2X902KjrVT9LLRFNS6xLyJuhGg2sED13
         hNWSyL+Kff+Twd0lhkByldZuXtArPQ1Q1SkQE8ANKoLXDLV2vbOQXXm5CwEcaPczTW
         dJhT3OyEM6jQGCqdcAASXNFyaQdpwYM7hiF5QOcvnYcSbtxWHJjFBUyEiV2eu1Macq
         WMsOdC4ZFyrAmIL+sC4A09NzPDSKljBhMVQR0LnhBgP8tdBNsgQgZBITF/vMd+b7M7
         fV2Xp8cyj39Tcu/uw6fKGmNIwYGtXvRBUC6GFT5S/05ONlUdqwMblSqLjPLVYz8/s3
         LZZRoKwUAyO9w==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 2/3] tracing/boot: Fix to check the histogram control param is a leaf node
Date:   Thu,  9 Sep 2021 22:12:18 +0900
Message-Id: <163119313830.159092.5978727876149173345.stgit@devnote2>
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

Since xbc_node_find_child() doesn't ensure the returned node
is a leaf node (key-value pair or do not have subkeys),
use xbc_node_find_value to ensure the histogram control
parameter is a leaf node in trace_boot_compose_hist_cmd().

Fixes: e66ed86ca6c5 ("tracing/boot: Add per-event histogram action options")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_boot.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
index a6be48b24774..db6ee372dc6d 100644
--- a/kernel/trace/trace_boot.c
+++ b/kernel/trace/trace_boot.c
@@ -385,11 +385,11 @@ trace_boot_compose_hist_cmd(struct xbc_node *hnode, char *buf, size_t size)
 	}
 
 	/* Histogram control attributes (mutual exclusive) */
-	if (xbc_node_find_child(hnode, "pause"))
+	if (xbc_node_find_value(hnode, "pause", NULL))
 		append_printf(&buf, end, ":pause");
-	else if (xbc_node_find_child(hnode, "continue"))
+	else if (xbc_node_find_value(hnode, "continue", NULL))
 		append_printf(&buf, end, ":continue");
-	else if (xbc_node_find_child(hnode, "clear"))
+	else if (xbc_node_find_value(hnode, "clear", NULL))
 		append_printf(&buf, end, ":clear");
 
 	/* Histogram handler and actions */

