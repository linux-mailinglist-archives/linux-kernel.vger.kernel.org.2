Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7053443709
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 21:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhKBUPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 16:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231669AbhKBUOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 16:14:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7215611AE;
        Tue,  2 Nov 2021 20:11:59 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mi08U-001jP2-UG;
        Tue, 02 Nov 2021 16:11:58 -0400
Message-ID: <20211102201158.771485961@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 02 Nov 2021 16:11:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 12/14] tracing/histogram: Document hist trigger variables
References: <20211102201126.559641540@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kalesh Singh <kaleshsingh@google.com>

Update the tracefs README to describe how hist trigger variables
can be created.

Link: https://lkml.kernel.org/r/20211029183339.3216491-4-kaleshsingh@google.com

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 985390cb8441..31a4632f9af1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5606,6 +5606,7 @@ static const char readme_msg[] =
 #ifdef CONFIG_HIST_TRIGGERS
 	"      hist trigger\t- If set, event hits are aggregated into a hash table\n"
 	"\t    Format: hist:keys=<field1[,field2,...]>\n"
+	"\t            [:<var1>=<field|var_ref|numeric_literal>[,<var2>=...]]\n"
 	"\t            [:values=<field1[,field2,...]>]\n"
 	"\t            [:sort=<field1[,field2,...]>]\n"
 	"\t            [:size=#entries]\n"
@@ -5617,6 +5618,16 @@ static const char readme_msg[] =
 	"\t            common_timestamp - to record current timestamp\n"
 	"\t            common_cpu - to record the CPU the event happened on\n"
 	"\n"
+	"\t    A hist trigger variable can be:\n"
+	"\t        - a reference to a field e.g. x=current_timestamp,\n"
+	"\t        - a reference to another variable e.g. y=$x,\n"
+	"\t        - a numeric literal: e.g. ms_per_sec=1000,\n"
+	"\t        - an arithmetic expression: e.g. time_secs=current_timestamp/1000\n"
+	"\n"
+	"\t    hist trigger aritmethic expressions support addition(+), subtraction(-),\n"
+	"\t    multiplication(*) and division(/) operators. An operand can be either a\n"
+	"\t    variable reference, field or numeric literal.\n"
+	"\n"
 	"\t    When a matching event is hit, an entry is added to a hash\n"
 	"\t    table using the key(s) and value(s) named, and the value of a\n"
 	"\t    sum called 'hitcount' is incremented.  Keys and values\n"
-- 
2.33.0
