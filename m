Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F99325BB9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 03:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhBZCtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 21:49:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:43418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229460AbhBZCtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 21:49:00 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02ADE64EDC;
        Fri, 26 Feb 2021 02:48:20 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lFTAw-0012j9-Tx; Thu, 25 Feb 2021 21:48:18 -0500
Message-ID: <20210226024818.816211653@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 25 Feb 2021 21:47:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
Subject: [for-linus][PATCH 2/2] tracing/tools: fix a couple of spelling mistakes
References: <20210226024751.443534071@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the -g help option, I believe
it should be "graph".  There is also a spelling mistake in a
warning message. Fix both mistakes.

Link: https://lkml.kernel.org/r/20210225165248.22050-2-Viktor.Rosendahl@bmw.de

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/tracing/latency/latency-collector.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/tracing/latency/latency-collector.c b/tools/tracing/latency/latency-collector.c
index 57b20802e71b..b69de9263ee6 100644
--- a/tools/tracing/latency/latency-collector.c
+++ b/tools/tracing/latency/latency-collector.c
@@ -1650,7 +1650,7 @@ static void start_printthread(void)
 		if (ufd <  0 ||
 		    read(ufd, seed, sizeof(*seed)) != sizeof(*seed)) {
 			printf(
-"Warning! Using trivial random nummer seed, since %s not available\n",
+"Warning! Using trivial random number seed, since %s not available\n",
 			DEV_URANDOM);
 			fflush(stdout);
 			*seed = i;
@@ -1711,8 +1711,8 @@ static void show_usage(void)
 "\t\t\tbeginning, end, and backtrace.\n\n"
 
 "-g, --graph\t\tEnable the display-graph option in trace_option. This\n"
-"\t\t\toption causes ftrace to show the functionph of how\n"
-"\t\t\tfunctions are calling other functions.\n\n"
+"\t\t\toption causes ftrace to show the graph of how functions\n"
+"\t\t\tare calling other functions.\n\n"
 
 "-c, --policy POL\tRun the program with scheduling policy POL. POL can be\n"
 "\t\t\tother, batch, idle, rr or fifo. The default is rr. When\n"
-- 
2.30.0


