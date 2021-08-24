Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F933F6AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 22:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhHXU7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 16:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhHXU7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 16:59:22 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5139C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 13:58:37 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id dv7-20020ad44ee7000000b0036fa79fd337so5532397qvb.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 13:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=P0j4ZUNHZMW2sebPv8vbOTFk+k+W5EprfBZkXv7dWW0=;
        b=JYoh2oraLDKX+78vyoyZOn7M3EyhNZ+Dmb94pFlKHSeNMbkOCuHSYPtkUrqVI0Cbo2
         7Ssq9dyzbo9VDlwtCGArx4VJqFnaK8FWBLWv3c/LgnhdkPoEO4ReGvFsV/nHD3nt9zxG
         dCOI4yUWB1wWzLXuK8kNg6CTKZ4bTNIBeaD14woichnmwE76OfOrJZNovBk5HbOqf7G4
         gSkh4BeGHqkQnN85MlcMH4tl2q3l1DFQHW0c2DXqJZ4XriWiFbYvp1fDj+SCqLETQlvI
         x8vuVyWwM1XGvJl0QlMPZjYMDZAsiCF9EQJvVjALHCuaUJYxnpP0BjtKxL848rN9aGml
         HDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=P0j4ZUNHZMW2sebPv8vbOTFk+k+W5EprfBZkXv7dWW0=;
        b=UKFm+63KstrrpH28zGqkw+/EjVUE0ByyNz5TEdqMmGsIqEBtxb+hqw9L4W+jaNKNEc
         xrz5ho5uGgyvoVGtoOwreLbl4yRxJVndvrXjaXxjclcLVEmexJ53f9p06KdXX0DWVug5
         fBLzMD6GMGpo3ngkaWM6SVF30how+TZ5xYQJG5hS4cggTpNN9h+LDHI60+jK0t/bI8c/
         3bp5UxYVuUX/3Byz+TKUE6CMxIoq4A/ofQJn8e2xjaRFR8D3C8Kbns5sNs0HHsonOZHN
         RmBEA6GEalrDgh1VUl1V3zk7AONzediIxpCEhj9gkr54skkTzocfFhkO0k9rfys/oEov
         YGtQ==
X-Gm-Message-State: AOAM532nVnWdezzlkyqfCP19WvP44epolpaVlkH2M2sN1Wn7F823rsut
        1a/XJN9d1Ro+CFQ3coLxGiEJyEPfu/Fc
X-Google-Smtp-Source: ABdhPJzmGFqSGfwJmRJstV5A7kM6ngNwv85K7PLl92AxsM/rYkFYm6//uxsTn5Cs3dtY6MUk7hMubK9JGjp+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d75f:d6af:12a8:ba25])
 (user=irogers job=sendgmr) by 2002:a05:6214:acd:: with SMTP id
 g13mr41583309qvi.23.1629838717148; Tue, 24 Aug 2021 13:58:37 -0700 (PDT)
Date:   Tue, 24 Aug 2021 13:58:29 -0700
Message-Id: <20210824205829.52822-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH] perf data: Correct -h output.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Joshua Martinez <jrm5317@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Joshua Martinez <joshuamart@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joshua Martinez <joshuamart@google.com>

There is currently only 1 perf data command, but supporting extra
commands was breaking the help output. Simplify for now so that the help
output is correct.

Before:
$ perf data -h

 Usage: perf data [<common options>] <command> [<options>]

$ perf data
Usage:
        perf data [<common options>] <command> [<options>]

        Available commands:
         convert        - converts data file between formats

After:
$ perf data

 Usage: perf data convert [<options>]

    -f, --force           don't complain, do it
    -i, --input <file>    input file name
    -v, --verbose         be more verbose
        --all             Convert all events
        --to-ctf ...      Convert to CTF format
        --to-json ...     Convert to JSON format
        --tod             Convert time to wall clock time

$ perf data -h

 Usage: perf data convert [<options>]

    -f, --force           don't complain, do it
    -i, --input <file>    input file name
    -v, --verbose         be more verbose
        --all             Convert all events
        --to-ctf ...      Convert to CTF format
        --to-json ...     Convert to JSON format
        --tod             Convert time to wall clock time

Signed-off-by: Joshua Martinez <joshuamart@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-data.c | 62 ++++++++++++---------------------------
 1 file changed, 19 insertions(+), 43 deletions(-)

diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
index 15ca23675ef0..b7f9dc85a407 100644
--- a/tools/perf/builtin-data.c
+++ b/tools/perf/builtin-data.c
@@ -21,46 +21,21 @@ static struct data_cmd data_cmds[];
 #define for_each_cmd(cmd) \
 	for (cmd = data_cmds; cmd && cmd->name; cmd++)
 
-static const struct option data_options[] = {
-	OPT_END()
-};
-
 static const char * const data_subcommands[] = { "convert", NULL };
 
 static const char *data_usage[] = {
-	"perf data [<common options>] <command> [<options>]",
+	"perf data convert [<options>]",
 	NULL
 };
 
-static void print_usage(void)
-{
-	struct data_cmd *cmd;
-
-	printf("Usage:\n");
-	printf("\t%s\n\n", data_usage[0]);
-	printf("\tAvailable commands:\n");
-
-	for_each_cmd(cmd) {
-		printf("\t %s\t- %s\n", cmd->name, cmd->summary);
-	}
-
-	printf("\n");
-}
-
-static const char * const data_convert_usage[] = {
-	"perf data convert [<options>]",
-	NULL
+const char *to_json;
+const char *to_ctf;
+struct perf_data_convert_opts opts = {
+	.force = false,
+	.all = false,
 };
 
-static int cmd_data_convert(int argc, const char **argv)
-{
-	const char *to_json = NULL;
-	const char *to_ctf = NULL;
-	struct perf_data_convert_opts opts = {
-		.force = false,
-		.all = false,
-	};
-	const struct option options[] = {
+const struct option data_options[] = {
 		OPT_INCR('v', "verbose", &verbose, "be more verbose"),
 		OPT_STRING('i', "input", &input_name, "file", "input file name"),
 		OPT_STRING(0, "to-json", &to_json, NULL, "Convert to JSON format"),
@@ -73,10 +48,13 @@ static int cmd_data_convert(int argc, const char **argv)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, options,
-			     data_convert_usage, 0);
+static int cmd_data_convert(int argc, const char **argv)
+{
+
+	argc = parse_options(argc, argv, data_options,
+			     data_usage, 0);
 	if (argc) {
-		usage_with_options(data_convert_usage, options);
+		usage_with_options(data_usage, data_options);
 		return -1;
 	}
 
@@ -116,14 +94,13 @@ int cmd_data(int argc, const char **argv)
 	struct data_cmd *cmd;
 	const char *cmdstr;
 
-	/* No command specified. */
-	if (argc < 2)
-		goto usage;
-
 	argc = parse_options_subcommand(argc, argv, data_options, data_subcommands, data_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
-	if (argc < 1)
-		goto usage;
+
+	if (!argc) {
+		usage_with_options(data_usage, data_options);
+		return -1;
+	}
 
 	cmdstr = argv[0];
 
@@ -135,7 +112,6 @@ int cmd_data(int argc, const char **argv)
 	}
 
 	pr_err("Unknown command: %s\n", cmdstr);
-usage:
-	print_usage();
+	usage_with_options(data_usage, data_options);
 	return -1;
 }
-- 
2.33.0.rc2.250.ged5fa647cd-goog

