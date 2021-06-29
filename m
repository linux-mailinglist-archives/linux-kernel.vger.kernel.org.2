Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3BA3B7190
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 13:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhF2Lvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 07:51:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232724AbhF2LvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 07:51:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D92361D5D;
        Tue, 29 Jun 2021 11:48:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lyCEV-000SYq-GW; Tue, 29 Jun 2021 07:48:51 -0400
Message-ID: <20210629114851.351873182@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 29 Jun 2021 07:48:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [for-next][PATCH 3/6] trace/osnoise: Make interval u64 on osnoise_main
References: <20210629114811.473560262@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@redhat.com>

kernel test robot reported:

  >> kernel/trace/trace_osnoise.c:966:3: warning: comparison of distinct
     pointer types ('typeof ((interval)) *' (aka 'long long *') and
     'uint64_t *' (aka 'unsigned long long *'))
     [-Wcompare-distinct-pointer-types]
                   do_div(interval, USEC_PER_MSEC);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:228:28: note: expanded from macro 'do_div'
           (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
                  ~~~~~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~

As interval cannot be negative because sample_period >= sample_runtime,
making interval u64 on osnoise_main() is enough to fix this problem.

Link: https://lkml.kernel.org/r/4ae1e7780563598563de079a3ef6d4d10b5f5546.1624872608.git.bristot@redhat.com

Fixes: bce29ac9ce0b ("trace: Add osnoise tracer")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 9c3109e3ffeb..79be14380581 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1202,7 +1202,7 @@ static struct cpumask save_cpumask;
  */
 static int osnoise_main(void *data)
 {
-	s64 interval;
+	u64 interval;
 
 	while (!kthread_should_stop()) {
 
-- 
2.30.2
