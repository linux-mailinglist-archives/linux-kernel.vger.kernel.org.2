Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B4D437F87
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbhJVUvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:51:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234377AbhJVUu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:50:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAD5661248;
        Fri, 22 Oct 2021 20:48:41 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1Sy-000QJN-Q5;
        Fri, 22 Oct 2021 16:48:40 -0400
Message-ID: <20211022204840.647993536@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:48:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Carles Pey <carles.pey@gmail.com>
Subject: [for-next][PATCH 14/40] ftrace: Add unit test for removing trace function
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carles Pey <carles.pey@gmail.com>

A self test is provided for the trace function removal functionality.

Link: https://lkml.kernel.org/r/20210918153043.318016-2-carles.pey@gmail.com

Signed-off-by: Carles Pey <carles.pey@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_selftest.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index adf7ef194005..875b4f1a0476 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -287,6 +287,40 @@ static int trace_selftest_ops(struct trace_array *tr, int cnt)
 	if (trace_selftest_test_probe3_cnt != 4)
 		goto out_free;
 
+	/* Remove trace function from probe 3 */
+	func1_name = "!" __stringify(DYN_FTRACE_TEST_NAME);
+	len1 = strlen(func1_name);
+
+	ftrace_set_filter(&test_probe3, func1_name, len1, 0);
+
+	DYN_FTRACE_TEST_NAME();
+
+	print_counts();
+
+	if (trace_selftest_test_probe1_cnt != 3)
+		goto out_free;
+	if (trace_selftest_test_probe2_cnt != 2)
+		goto out_free;
+	if (trace_selftest_test_probe3_cnt != 4)
+		goto out_free;
+	if (cnt > 1) {
+		if (trace_selftest_test_global_cnt == 0)
+			goto out_free;
+	}
+	if (trace_selftest_test_dyn_cnt == 0)
+		goto out_free;
+
+	DYN_FTRACE_TEST_NAME2();
+
+	print_counts();
+
+	if (trace_selftest_test_probe1_cnt != 3)
+		goto out_free;
+	if (trace_selftest_test_probe2_cnt != 3)
+		goto out_free;
+	if (trace_selftest_test_probe3_cnt != 5)
+		goto out_free;
+
 	ret = 0;
  out_free:
 	unregister_ftrace_function(dyn_ops);
-- 
2.33.0
