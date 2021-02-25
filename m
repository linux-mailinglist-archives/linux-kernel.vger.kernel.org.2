Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC8532544C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbhBYRE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:04:29 -0500
Received: from esa6.hc324-48.eu.iphmx.com ([207.54.71.69]:10315 "EHLO
        esa6.hc324-48.eu.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233668AbhBYRCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:02:34 -0500
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Feb 2021 12:02:33 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1614272552; x=1645808552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mjU49zVxdgh7tJTtLmpkg7GZMlQAxkXKBkdvMI8zKN0=;
  b=iJ6PBBWSYmI2gRHntdO+tBadLTqK4sf9A3xS8OX9Ov3NJsrLpT3Q89Bv
   nlpXiZIKHKaJt73cU29VoiFtholwR0/G+ZBq1HuIhMJHvFqHRUY1GnzDb
   Nd4+Dvx88SZpxWA0m+s3KnLhg1dn54lqY05cbK0HxLiobfaA0V+g5H11l
   M=;
Received: from esagw4.bmwgroup.com (HELO esagw4.muc) ([160.46.252.39]) by
 esa6.hc324-48.eu.iphmx.com with ESMTP/TLS; 25 Feb 2021 17:53:44 +0100
Received: from esabb3.muc ([160.50.100.30])  by esagw4.muc with ESMTP/TLS;
 25 Feb 2021 17:53:43 +0100
Received: from smucm10m.bmwgroup.net (HELO smucm10m.europe.bmw.corp) ([160.48.96.49])
 by esabb3.muc with ESMTP/TLS; 25 Feb 2021 17:53:43 +0100
Received: from greenhouse.bmw-carit.intra (192.168.221.35) by smucm10m.europe.bmw.corp
 (160.48.96.49) with Microsoft SMTP Server (TLS;
 Thu, 25 Feb 2021 17:53:43 +0100
From:   Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <linux-kernel@vger.kernel.org>, <Viktor.Rosendahl@bmw.de>,
        Colin Ian King <colin.king@canonical.com>
Subject: [PATCH 1/1] tracing/tools: fix a couple of spelling mistakes
Date:   Thu, 25 Feb 2021 17:52:48 +0100
Message-ID: <20210225165248.22050-2-Viktor.Rosendahl@bmw.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225165248.22050-1-Viktor.Rosendahl@bmw.de>
References: <20210225165248.22050-1-Viktor.Rosendahl@bmw.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucm31l.europe.bmw.corp (160.46.167.60) To
 smucm10m.europe.bmw.corp (160.48.96.49)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the -g help option, I believe
it should be "graph".  There is also a spelling mistake in a
warning message. Fix both mistakes.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
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
2.25.1

