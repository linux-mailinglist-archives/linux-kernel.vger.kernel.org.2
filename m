Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF1943CCE0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 16:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237445AbhJ0PAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 11:00:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237416AbhJ0PAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 11:00:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54C4960724;
        Wed, 27 Oct 2021 14:57:55 +0000 (UTC)
Date:   Wed, 27 Oct 2021 10:57:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2] bootconfig: Initialize ret in xbc_parse_tree()
Message-ID: <20211027105753.6ab9da5f@gandalf.local.home>
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

Fixes: bdac5c2b243f ("bootconfig: Allocate xbc_data inside xbc_init()")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
Changes since v1:
   https://lkml.kernel.org/r/20211027095512.3da02311@gandalf.local.home
   - Just updated the Fixes tag and removed Cc to stable


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

