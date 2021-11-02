Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3114644370A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 21:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhKBUPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 16:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231697AbhKBUOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 16:14:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CF6A6117A;
        Tue,  2 Nov 2021 20:12:00 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mi08V-001jQA-AH;
        Tue, 02 Nov 2021 16:11:59 -0400
Message-ID: <20211102201159.142867097@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 02 Nov 2021 16:11:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [for-next][PATCH 14/14] ftrace/samples: Add missing prototype for my_direct_func
References: <20211102201126.559641540@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

There's compilation fail reported kernel test robot for W=1 build:

  >> samples/ftrace/ftrace-direct-multi.c:8:6: warning: no previous
  prototype for function 'my_direct_func' [-Wmissing-prototypes]
     void my_direct_func(unsigned long ip)

The inlined assembly is used outside function, so we can't make
my_direct_func static and pass it as asm input argument.

However my_tramp is already extern so I think there's no problem
keeping my_direct_func extern as well and just add its prototype.

Link: https://lkml.kernel.org/r/20211101153907.377668-1-jolsa@kernel.org

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 5fae941b9a6f ("ftrace/samples: Add multi direct interface test module")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 samples/ftrace/ftrace-direct-multi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index 2a5b1fb7ac14..b6d7806b400e 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -5,6 +5,8 @@
 #include <linux/ftrace.h>
 #include <linux/sched/stat.h>
 
+extern void my_direct_func(unsigned long ip);
+
 void my_direct_func(unsigned long ip)
 {
 	trace_printk("ip %lx\n", ip);
-- 
2.33.0
