Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11633BEA61
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 17:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhGGPLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 11:11:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232017AbhGGPLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 11:11:09 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BC6861CC1;
        Wed,  7 Jul 2021 15:08:28 +0000 (UTC)
Date:   Wed, 7 Jul 2021 11:08:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH] tracing/histograms: Fix parsing of "sym-offset" modifier
Message-ID: <20210707110821.188ae255@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

With the addition of simple mathematical operations (plus and minus), the
parsing of the "sym-offset" modifier broke, as it took the '-' part of the
"sym-offset" as a minus, and tried to break it up into a mathematical
operation of "field.sym - offset", in which case it failed to parse
(unless the event had a field called "offset").

Both .sym and .sym-offset modifiers should not be entered into
mathematical calculations anyway. If ".sym-offset" is found in the
modifier, then simply make it not an operation that can be calculated on.

Cc: stable@vger.kernel.org
Fixes: 100719dcef447 ("tracing: Add simple expression support to hist triggers")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index ba03b7d84fc2..0207aeed31e6 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1555,6 +1555,13 @@ static int contains_operator(char *str)
 
 	switch (*op) {
 	case '-':
+		/*
+		 * Unfortunately, the modifier ".sym-offset"
+		 * can confuse things.
+		 */
+		if (op - str >= 4 && !strncmp(op - 4, ".sym-offset", 11))
+			return FIELD_OP_NONE;
+
 		if (*str == '-')
 			field_op = FIELD_OP_UNARY_MINUS;
 		else
-- 
2.31.1

