Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309AF3261B5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 12:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhBZLCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 06:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhBZLCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 06:02:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D31C061756
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 03:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=EHWhhdLDdzPYVi8ynm/zJC3ILtPiJrXEzth9Tr7EpT0=; b=Bpsc9CHDrK2PskzqNGquxpCtex
        XIdexpSrLQl5RadANAzuwUD7loNRMgNqVqTB0cNsTuTM0Ief96lnUCTsiYjyLUkQ4Kf30YWJokcIT
        zuTX4sRl+VzA84L6+1MqFeNqWtcIvB4yOQD1o8GW3e4Z7qSeL2BCCwUfcpvWYmmourEslhlnhvhZJ
        cVROlduD5kpkcrmwq8J3L0BjOIxFHM0ou4hbm/M9NRD+0KgARNJKTi7AsKUWGtjZD//2YDzphVUp/
        qgemrFvtHyRUD0OfEZTtpcADMdYM1QVuVFxEwoVbSgN+UHYFxKBUK1+YHfNWj7kHVsgScVaSWf7M6
        G6CfEk1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lFarU-00Btt0-Qm; Fri, 26 Feb 2021 11:00:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 76648305C1C;
        Fri, 26 Feb 2021 12:00:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 61FC2236424F1; Fri, 26 Feb 2021 12:00:43 +0100 (CET)
Message-ID: <20210226110004.193108106@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Feb 2021 11:57:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     bp@alien8.de, jpoimboe@redhat.com, mbenes@suze.cz
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org
Subject: [PATCH 2/3] objtool: Collate parse_options() users
References: <20210226105742.844988140@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure there's a single place that parses check_options, in
preparation for extending where to get options from.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/builtin-check.c           |   14 +++++++++-----
 tools/objtool/builtin-orc.c             |    5 +----
 tools/objtool/include/objtool/builtin.h |    2 ++
 3 files changed, 12 insertions(+), 9 deletions(-)

--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -40,17 +40,21 @@ const struct option check_options[] = {
 	OPT_END(),
 };
 
+int cmd_parse_options(int argc, const char **argv, const char * const usage[])
+{
+	argc = parse_options(argc, argv, check_options, usage, 0);
+	if (argc != 1)
+		usage_with_options(usage, check_options);
+	return argc;
+}
+
 int cmd_check(int argc, const char **argv)
 {
 	const char *objname, *s;
 	struct objtool_file *file;
 	int ret;
 
-	argc = parse_options(argc, argv, check_options, check_usage, 0);
-
-	if (argc != 1)
-		usage_with_options(check_usage, check_options);
-
+	argc = cmd_parse_options(argc, argv, check_usage);
 	objname = argv[0];
 
 	s = strstr(objname, "vmlinux.o");
--- a/tools/objtool/builtin-orc.c
+++ b/tools/objtool/builtin-orc.c
@@ -34,10 +34,7 @@ int cmd_orc(int argc, const char **argv)
 		struct objtool_file *file;
 		int ret;
 
-		argc = parse_options(argc, argv, check_options, orc_usage, 0);
-		if (argc != 1)
-			usage_with_options(orc_usage, check_options);
-
+		argc = cmd_parse_options(argc, argv, orc_usage);
 		objname = argv[0];
 
 		file = objtool_open_read(objname);
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -11,6 +11,8 @@ extern const struct option check_options
 extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats;
 extern bool validate_dup, vmlinux, backup;
 
+extern int cmd_parse_options(int argc, const char **argv, const char * const usage[]);
+
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
 


