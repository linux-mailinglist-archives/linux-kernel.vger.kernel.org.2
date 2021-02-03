Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7938130DF39
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbhBCQIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:08:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:36052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234921AbhBCQH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:07:27 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9761F64FAA;
        Wed,  3 Feb 2021 16:05:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1l7Kf8-009JAx-Gx; Wed, 03 Feb 2021 11:05:50 -0500
Message-ID: <20210203160550.409319275@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Feb 2021 11:05:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bean Huo <beanhuo@micron.com>
Subject: [for-next][PATCH 12/15] tracing: Fix a kernel doc warning
References: <20210203160517.982448432@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Add description for trace_array_put() parameter.

kernel/trace/trace.c:464: warning: Function parameter or member 'this_tr' not described in 'trace_array_put'

Link: https://lkml.kernel.org/r/20210112111202.23508-1-huobean@gmail.com

Signed-off-by: Bean Huo <beanhuo@micron.com>
[ Merged as one of the original fixes was already fixed by someone else ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 75620c29e904..7fd432334ff5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -454,6 +454,7 @@ static void __trace_array_put(struct trace_array *this_tr)
 
 /**
  * trace_array_put - Decrement the reference counter for this trace array.
+ * @this_tr : pointer to the trace array
  *
  * NOTE: Use this when we no longer need the trace array returned by
  * trace_array_get_by_name(). This ensures the trace array can be later
-- 
2.29.2


