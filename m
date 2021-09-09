Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9774057BB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 15:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241680AbhIINlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 09:41:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354795AbhIINhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:37:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C2A561059;
        Thu,  9 Sep 2021 13:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631194593;
        bh=TDUAYeCvyONIXLM76ViX+hbRv3DvfoCaoQAVbfe/tQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LeoJWkUpINDlah8ltQPMT7O5inyN0eoJyJ2FN3pdbAaQKe+GkY2QDKa7KRek+MIoX
         Xv3AGMrtNSPQ7ZaWl4PtASa9BJGd+oy36J4oZGlzzx6cFLLGEl/L5GPX404XElFt5I
         CgwdZ0jUiyEcFaFstV0lt8XSH3YP118JS0crZoPFO7V/OwDy1NDAOQkA3qK+bL5eNu
         jhFDqxJ2mZVgw78/fYblV09Q8AaQyUsDEwCCQj/cP5m0u423Yoj7wmxUKRZFsMelRF
         nMsdaoHjcpXq3gSqgYHcpWyiSqZUogh8HMX223GrQeC8JL+MrYzD6SJOuAq60IwRSQ
         5jrrWxEsx0zsw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RESEND PATCH 2/3] tracing/boot: Fix to check the histogram control param is a leaf node
Date:   Thu,  9 Sep 2021 22:36:30 +0900
Message-Id: <163119459059.161018.18341288218424528962.stgit@devnote2>
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

