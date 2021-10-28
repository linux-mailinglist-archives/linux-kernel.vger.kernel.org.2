Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7D143D954
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 04:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhJ1CcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 22:32:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbhJ1CcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 22:32:13 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2F6B610C7;
        Thu, 28 Oct 2021 02:29:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mfvAo-0010zy-OK;
        Wed, 27 Oct 2021 22:29:46 -0400
Message-ID: <20211028022946.582230137@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Oct 2021 22:29:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 1/3] bootconfig: Initialize ret in xbc_parse_tree()
References: <20211028022915.320082859@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Link: https://lkml.kernel.org/r/20211027105753.6ab9da5f@gandalf.local.home

Fixes: bdac5c2b243f ("bootconfig: Allocate xbc_data inside xbc_init()")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
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
2.33.0
