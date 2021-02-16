Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A82F31CCF2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 16:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhBPPbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 10:31:08 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53822 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhBPPbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 10:31:06 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lC2Ix-0006Ys-FG; Tue, 16 Feb 2021 15:30:23 +0000
From:   Colin King <colin.king@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next][V3] tracing/tools: fix a couple of spelling mistakes
Date:   Tue, 16 Feb 2021 15:30:23 +0000
Message-Id: <20210216153023.163488-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the -g help option, I believe
it should be "graph".  There is also a spelling mistake in a
warning message. Fix both mistakes.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: Also fix "nummer" spelling mistake.
V3: re-format text, as suggested by Viktor

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

