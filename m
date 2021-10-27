Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A5B43CB3C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 15:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242319AbhJ0N5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 09:57:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242302AbhJ0N5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 09:57:42 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AEC860E74;
        Wed, 27 Oct 2021 13:55:14 +0000 (UTC)
Date:   Wed, 27 Oct 2021 09:55:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] bootconfig: Initialize ret in xbc_parse_tree()
Message-ID: <20211027095512.3da02311@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The do while loop continues while ret is zero, but ret is never
initialized. The check for ret in the loop at the while should always be
initialized, but if an empty string were to be passed in, q would be NULL
and p would be '\0', and it would break out of the loop without ever
setting ret.

Set ret to zero, and then xbc_verify_tree() would be called and catch that
it is an empty tree and report the proper error.

Cc: stable@vger.kernel.org
Fixes: 76db5a27a827c ("bootconfig: Add Extra Boot Config support")
Reported-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index a10ab25f6fcc..70e0d52ffd24 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -836,7 +836,7 @@ static int __init xbc_verify_tree(void)
 static int __init xbc_parse_tree(void)
 {
 	char *p, *q;
-	int ret, c;
+	int ret = 0, c;
 
 	last_parent = NULL;
 	p = xbc_data;
-- 
2.31.1

