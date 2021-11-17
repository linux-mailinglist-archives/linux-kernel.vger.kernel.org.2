Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A669455103
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 00:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241539AbhKQXWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 18:22:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:38570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236763AbhKQXWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 18:22:24 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76E2061B1E;
        Wed, 17 Nov 2021 23:19:24 +0000 (UTC)
Date:   Wed, 17 Nov 2021 18:19:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: [GIT PULL] tracing: Fix double free bug
Message-ID: <20211117181922.3e9a2329@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Fix double free bug in tracing histograms

On error, the operands and the histogram expression are destroyed,
but since the destruction is recursive, do not destroy the operands
if they already belong to the expression that is about to be destroyed.


Please pull the latest trace-v5.16-rc1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.16-rc1

Tag SHA1: a34f97bfa65691c91eed55ce5f09cfaa78e05908
Head SHA1: b0cb20110d4562bcc39f49f2de4020f0caa84bdd


Kalesh Singh (1):
      tracing/histogram: Fix UAF in destroy_hist_field()

----
 kernel/trace/trace_events_hist.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
---------------------------
commit b0cb20110d4562bcc39f49f2de4020f0caa84bdd
Author: Kalesh Singh <kaleshsingh@google.com>
Date:   Tue Nov 16 23:34:14 2021 -0800

    tracing/histogram: Fix UAF in destroy_hist_field()
    
    Calling destroy_hist_field() on an expression will recursively free
    any operands associated with the expression. If during expression
    parsing the operands of the expression are already set when an error
    is encountered, there is no need to explicity free the operands. Doing
    so will result in destroy_hist_field() being called twice for the
    operands and lead to a use-after-free (UAF) error.
    
    Fix this by only calling destroy_hist_field() for the operands if they
    are not associated with the expression hist_field.
    
    Link: https://lkml.kernel.org/r/20211117073415.2584751-1-kaleshsingh@google.com
    
    Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
    Fixes: 8b5d46fd7a38 ("tracing/histogram: Optimize division by constants")
    Reported-by: kernel test robot <oliver.sang@intel.com>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5ea2c9ec54a6..b53ee8d566f6 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2717,8 +2717,10 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 
 	return expr;
 free:
-	destroy_hist_field(operand1, 0);
-	destroy_hist_field(operand2, 0);
+	if (!expr || expr->operands[0] != operand1)
+		destroy_hist_field(operand1, 0);
+	if (!expr || expr->operands[1] != operand2)
+		destroy_hist_field(operand2, 0);
 	destroy_hist_field(expr, 0);
 
 	return ERR_PTR(ret);
