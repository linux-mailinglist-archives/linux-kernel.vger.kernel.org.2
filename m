Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7413424D3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhCSSiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230310AbhCSSiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:38:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B05D6198A;
        Fri, 19 Mar 2021 18:38:02 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lNK0X-0017lj-G9; Fri, 19 Mar 2021 14:38:01 -0400
Message-ID: <20210319183801.379111727@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 19 Mar 2021 14:34:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Viktor Rosendahl <Viktor.Rosendahl@bmw.de>,
        Xu Wang <vulab@iscas.ac.cn>
Subject: [for-next][PATCH 09/13] tools/latency-collector: Remove unneeded semicolon
References: <20210319183426.840228082@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu Wang <vulab@iscas.ac.cn>

Fix semicolon.cocci warning:
tools/tracing/latency/latency-collector.c:1021:2-3: Unneeded semicolon

Link: https://lkml.kernel.org/r/20210308022459.59881-1-vulab@iscas.ac.cn

Reviewed-by: Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/tracing/latency/latency-collector.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/latency/latency-collector.c b/tools/tracing/latency/latency-collector.c
index b69de9263ee6..3a2e6bb781a8 100644
--- a/tools/tracing/latency/latency-collector.c
+++ b/tools/tracing/latency/latency-collector.c
@@ -1018,7 +1018,7 @@ static long go_to_sleep(const struct entry *req)
 		cond_timedwait(&printstate.cond, &printstate.mutex, &future);
 		if (time_has_passed(&future))
 			break;
-	};
+	}
 
 	if (printstate_has_new_req_arrived(req))
 		delay = -1;
@@ -1941,7 +1941,7 @@ static void scan_arguments(int argc, char *argv[])
 			if (value < 0) {
 				warnx("TIME must be >= 0\n");
 				show_usage();
-				;
+				exit(0);
 			}
 			trace_enable = true;
 			use_random_sleep = true;
-- 
2.30.1


