Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBDA42FFD1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 05:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243496AbhJPDFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 23:05:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239700AbhJPDFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 23:05:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00FD261214;
        Sat, 16 Oct 2021 03:02:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mbZyG-006ZSm-Ej; Fri, 15 Oct 2021 23:02:52 -0400
Message-ID: <20211016030252.289632776@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 15 Oct 2021 23:02:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 3/7] bootconfig: init: Fix memblock leak in xbc_make_cmdline()
References: <20211016030222.926060517@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Free unused memblock in a error case to fix memblock leak
in xbc_make_cmdline().

Link: https://lkml.kernel.org/r/163177339181.682366.8713781325929549256.stgit@devnote2

Fixes: 51887d03aca1 ("bootconfig: init: Allow admin to use bootconfig for kernel command line")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 init/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/main.c b/init/main.c
index 81a79a77db46..3c4054a95545 100644
--- a/init/main.c
+++ b/init/main.c
@@ -382,6 +382,7 @@ static char * __init xbc_make_cmdline(const char *key)
 	ret = xbc_snprint_cmdline(new_cmdline, len + 1, root);
 	if (ret < 0 || ret > len) {
 		pr_err("Failed to print extra kernel cmdline.\n");
+		memblock_free_ptr(new_cmdline, len + 1);
 		return NULL;
 	}
 
-- 
2.32.0
