Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA94034B159
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 22:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhCZV37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 17:29:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230043AbhCZV31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 17:29:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46D2E61A33;
        Fri, 26 Mar 2021 21:29:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lPu1G-002DRr-8Q; Fri, 26 Mar 2021 17:29:26 -0400
Message-ID: <20210326212926.145216505@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Mar 2021 17:28:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [for-next][PATCH 4/6] kernel: trace: Mundane typo fixes in the file trace_events_filter.c
References: <20210326212848.385566448@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaskar Chowdhury <unixbhaskar@gmail.com>

s/callin/calling/

Link: https://lkml.kernel.org/r/20210317095401.1854544-1-unixbhaskar@gmail.com

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
[ Other fixes already done by Ingo Molnar ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 9730acf3c03e..49de3e21e9bc 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -256,7 +256,7 @@ enum {
  * is "&&" we don't call update_preds(). Instead continue to "c". As the
  * next token after "c" is not "&&" but the end of input, we first process the
  * "&&" by calling update_preds() for the "&&" then we process the "||" by
- * callin updates_preds() with the values for processing "||".
+ * calling updates_preds() with the values for processing "||".
  *
  * What does that mean? What update_preds() does is to first save the "target"
  * of the program entry indexed by the current program entry's "target"
-- 
2.30.1


