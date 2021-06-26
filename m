Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299A13B4E9F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 15:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhFZNIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 09:08:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230073AbhFZNH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 09:07:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 365B061C30;
        Sat, 26 Jun 2021 13:05:37 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lx808-000Eik-9n; Sat, 26 Jun 2021 09:05:36 -0400
Message-ID: <20210626130536.139237977@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 26 Jun 2021 09:04:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 09/24] tracing: Have ftrace_dump_on_oops kernel parameter take numbers
References: <20210626130404.033700863@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The kernel parameter for ftrace_dump_on_oops can take a single assignment.
That is, it can be:

  ftrace_dump_on_oops or ftrace_dump_on_oops=orig_cpu

But the content in the sysctl file is a number.

 0 for disabled
 1 for ftrace_dump_on_oops (all CPUs)
 2 for ftrace_dump_on_oops (orig CPU)

Allow the kernel command line to take a number as well to match the sysctl
numbers.

That is:

  ftrace_dump_on_oops=1 is the same as ftrace_dump_on_oops

and

  ftrace_dump_on_oops=2 is the same as ftrace_dump_on_oops=orig_cpu

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bbc63ac5b47f..d352fb4b7709 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -197,12 +197,12 @@ __setup("ftrace=", set_cmdline_ftrace);
 
 static int __init set_ftrace_dump_on_oops(char *str)
 {
-	if (*str++ != '=' || !*str) {
+	if (*str++ != '=' || !*str || !strcmp("1", str)) {
 		ftrace_dump_on_oops = DUMP_ALL;
 		return 1;
 	}
 
-	if (!strcmp("orig_cpu", str)) {
+	if (!strcmp("orig_cpu", str) || !strcmp("2", str)) {
 		ftrace_dump_on_oops = DUMP_ORIG;
                 return 1;
         }
-- 
2.30.2
