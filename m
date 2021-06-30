Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154C13B8ADB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 01:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbhF3XVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 19:21:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235704AbhF3XUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 19:20:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53DC96146D;
        Wed, 30 Jun 2021 23:18:23 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lyjTK-000ZDI-CI; Wed, 30 Jun 2021 19:18:22 -0400
Message-ID: <20210630231822.219090027@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 30 Jun 2021 19:18:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [for-next][PATCH 2/5] trace/osnoise: Make noise variable s64 in run_osnoise()
References: <20210630231758.861158022@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@redhat.com>

Dab Carpenter reported that:

 The patch bce29ac9ce0b: "trace: Add osnoise tracer" from Jun 22,
 2021, leads to the following static checker warning:

	kernel/trace/trace_osnoise.c:1103 run_osnoise()
	warn: unsigned 'noise' is never less than zero.

In this part of the code:

  1100                  /*
  1101                   * This shouldn't happen.
  1102                   */
  1103                  if (noise < 0) {
                            ^^^^^^^^^
  1104                          osnoise_taint("negative noise!");
  1105                          goto out;
  1106                  }
  1107

And the static checker is right because 'noise' is u64.

Make noise s64 and keep the check. It is important to check if
the time read is behaving correctly - so we can trust the results.

I also re-arranged some variable declarations.

Link: https://lkml.kernel.org/r/acd7cd6e7d56b798a298c3bc8139a390b3c4ab52.1624986368.git.bristot@redhat.com

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-kernel@vger.kernel.org
Fixes: bce29ac9ce0b ("trace: Add osnoise tracer")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 085a83de98ad..cc1faca1a620 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1042,15 +1042,16 @@ static void osnoise_stop_tracing(void)
 static int run_osnoise(void)
 {
 	struct osnoise_variables *osn_var = this_cpu_osn_var();
-	u64 noise = 0, sum_noise = 0, max_noise = 0;
 	struct trace_array *tr = osnoise_trace;
 	u64 start, sample, last_sample;
 	u64 last_int_count, int_count;
+	s64 noise = 0, max_noise = 0;
 	s64 total, last_total = 0;
 	struct osnoise_sample s;
 	unsigned int threshold;
-	int hw_count = 0;
 	u64 runtime, stop_in;
+	u64 sum_noise = 0;
+	int hw_count = 0;
 	int ret = -1;
 
 	/*
-- 
2.30.2
