Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1A13261B8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 12:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhBZLDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 06:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhBZLC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 06:02:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4045C061788
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 03:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=RC9T6ThRvJ68C5PgvqnQX8pkxJuerMsONKzf1JxZ1GA=; b=KTi84wyicjLA2CQzZQThV564QJ
        1SNg3vuitXKmtR5P/tPgbYISkmA56b+O6g5yQ7X2xtg7sUkdGEKWSCCYLXsfHBBgZ/qyupovDDgGi
        ZqMkLKr6Wpj/zX6VInzWffCGsxI/2SnuS53h7bG4DGNBHrpZ4VSAJGR6CvtZnYs23NuF8fBYxr6Bp
        Y9Mc1XoveuxvoBVJGsP9XM/fx18wL1rlTx/L5FaZQN7psjxWEcH/l8KJPpmeF8Ut0ALQPw8w85pLH
        qS/AyoEX/ViiYZ63cuU2BSzQfOgwxS8JLbbfqgN0+7wjIOdEPZHtX8lpUgx9KoB4fzkD137lSsBgK
        lOVrvQqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lFarU-00Btt2-Qq; Fri, 26 Feb 2021 11:00:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 812AE3069B1;
        Fri, 26 Feb 2021 12:00:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 65B1E236424EC; Fri, 26 Feb 2021 12:00:43 +0100 (CET)
Message-ID: <20210226110004.252553847@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Feb 2021 11:57:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     bp@alien8.de, jpoimboe@redhat.com, mbenes@suze.cz
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org
Subject: [PATCH 3/3] objtool: Parse options from OBJTOOL_ARGS
References: <20210226105742.844988140@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Teach objtool to parse options from the OBJTOOL_ARGS environment
variable.

Then enables things like:

  $ OBJTOOL_ARGS="--backup" make O=defconfig-build/ kernel/ponies.o

to obtain both defconfig-build/kernel/ponies.{o,obj} and easily
inspect what objtool actually did.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/builtin-check.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -15,6 +15,7 @@
 
 #include <subcmd/parse-options.h>
 #include <string.h>
+#include <stdlib.h>
 #include <objtool/builtin.h>
 #include <objtool/objtool.h>
 
@@ -26,6 +27,11 @@ static const char * const check_usage[]
 	NULL,
 };
 
+static const char * const env_usage[] = {
+	"OBJTOOL_ARGS=\"<options>\"",
+	NULL,
+};
+
 const struct option check_options[] = {
 	OPT_BOOLEAN('f', "no-fp", &no_fp, "Skip frame pointer validation"),
 	OPT_BOOLEAN('u', "no-unreachable", &no_unreachable, "Skip 'unreachable instruction' warnings"),
@@ -42,6 +48,25 @@ const struct option check_options[] = {
 
 int cmd_parse_options(int argc, const char **argv, const char * const usage[])
 {
+	const char *envv[16] = { };
+	char *env;
+	int envc;
+
+	env = getenv("OBJTOOL_ARGS");
+	if (env) {
+		envv[0] = "OBJTOOL_ARGS";
+		for (envc = 1; envc < ARRAY_SIZE(envv); ) {
+			envv[envc++] = env;
+			env = strchr(env, ' ');
+			if (!env)
+				break;
+			*env = '\0';
+			env++;
+		}
+
+		parse_options(envc, envv, check_options, env_usage, 0);
+	}
+
 	argc = parse_options(argc, argv, check_options, usage, 0);
 	if (argc != 1)
 		usage_with_options(usage, check_options);


