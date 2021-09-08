Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5173D403FC0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 21:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350586AbhIHTV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 15:21:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350956AbhIHTVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 15:21:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E59761175;
        Wed,  8 Sep 2021 19:20:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mO36v-0014XO-LR; Wed, 08 Sep 2021 15:19:53 -0400
Message-ID: <20210908191953.503827696@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 08 Sep 2021 15:18:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [for-next][PATCH 02/12] tracing: Fix some alloc_event_probe() error handling bugs
References: <20210908191851.381347939@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

There are two bugs in this code.  First, if the kzalloc() fails it leads
to a NULL dereference of "ep" on the next line.  Second, if the
alloc_event_probe() function returns an error then it leads to an
error pointer dereference in the caller.

Link: https://lkml.kernel.org/r/20210824115150.GI31143@kili

Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_eprobe.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 56a96e9750cf..3044b762cbd7 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -151,7 +151,7 @@ static struct trace_eprobe *alloc_event_probe(const char *group,
 
 	ep = kzalloc(struct_size(ep, tp.args, nargs), GFP_KERNEL);
 	if (!ep) {
-		trace_event_put_ref(ep->event);
+		trace_event_put_ref(event);
 		goto error;
 	}
 	ep->event = event;
@@ -851,7 +851,8 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 		ret = PTR_ERR(ep);
 		/* This must return -ENOMEM, else there is a bug */
 		WARN_ON_ONCE(ret != -ENOMEM);
-		goto error;	/* We know ep is not allocated */
+		ep = NULL;
+		goto error;
 	}
 
 	argc -= 2; argv += 2;
-- 
2.32.0
