Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C8A437F7D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbhJVUvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:51:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234339AbhJVUu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:50:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 628436124A;
        Fri, 22 Oct 2021 20:48:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1Sw-000QC4-Bk;
        Fri, 22 Oct 2021 16:48:38 -0400
Message-ID: <20211022204838.200954642@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:47:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>
Subject: [for-next][PATCH 01/40] tracing: Initialize upper and lower vars in pid_list_refill_irq()
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The upper and lower variables are set as link lists to add into the sparse
array. If they are NULL, after the needed allocations are done, then there
is nothing to add. But they need to be initialized to NULL for this to
work.

Link: https://lore.kernel.org/all/221bc7ba-a475-1cb9-1bbe-730bb9c2d448@canonical.com/

Fixes: 8d6e90983ade ("tracing: Create a sparse bitmask for pid filtering")
Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/pid_list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/pid_list.c b/kernel/trace/pid_list.c
index cbf8031b2b99..a2ef1d18126a 100644
--- a/kernel/trace/pid_list.c
+++ b/kernel/trace/pid_list.c
@@ -333,8 +333,8 @@ static void pid_list_refill_irq(struct irq_work *iwork)
 {
 	struct trace_pid_list *pid_list = container_of(iwork, struct trace_pid_list,
 						       refill_irqwork);
-	union upper_chunk *upper;
-	union lower_chunk *lower;
+	union upper_chunk *upper = NULL;
+	union lower_chunk *lower = NULL;
 	union upper_chunk **upper_next = &upper;
 	union lower_chunk **lower_next = &lower;
 	int upper_count;
-- 
2.33.0
