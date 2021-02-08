Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81B9314162
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbhBHVMt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 Feb 2021 16:12:49 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:49573 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236616AbhBHUKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 15:10:17 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-oe-WPCGuOB-71wnW8S0T-Q-1; Mon, 08 Feb 2021 15:09:21 -0500
X-MC-Unique: oe-WPCGuOB-71wnW8S0T-Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB83180196E;
        Mon,  8 Feb 2021 20:09:19 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4A7919C59;
        Mon,  8 Feb 2021 20:09:17 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: [PATCH 03/24] perf daemon: Add base option
Date:   Mon,  8 Feb 2021 21:08:47 +0100
Message-Id: <20210208200908.1019149-4-jolsa@kernel.org>
In-Reply-To: <20210208200908.1019149-1-jolsa@kernel.org>
References: <20210208200908.1019149-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding base option allowing user to specify base directory.
It will have precedence over config file base definition
coming in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-daemon.txt |  4 ++++
 tools/perf/builtin-daemon.c              | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/tools/perf/Documentation/perf-daemon.txt b/tools/perf/Documentation/perf-daemon.txt
index ba3f88510aee..1a4158cd973e 100644
--- a/tools/perf/Documentation/perf-daemon.txt
+++ b/tools/perf/Documentation/perf-daemon.txt
@@ -31,6 +31,10 @@ OPTIONS
 	Config file path. If not provided, perf will check system and default
 	locations (/etc/perfconfig, $HOME/.perfconfig).
 
+--base=<PATH>::
+	Base directory path. Each daemon instance is running on top
+	of base directory.
+
 All generic options are available also under commands.
 
 
diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 90b5a8ea9dda..ce0373f453d6 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -6,6 +6,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <unistd.h>
+#include <errno.h>
 #include "builtin.h"
 #include "perf.h"
 #include "debug.h"
@@ -15,6 +16,7 @@
 struct daemon {
 	const char		*config;
 	char			*config_real;
+	const char		*base_user;
 	char			*base;
 	FILE			*out;
 	char			 perf[PATH_MAX];
@@ -38,10 +40,17 @@ static void sig_handler(int sig __maybe_unused)
 static void daemon__exit(struct daemon *daemon)
 {
 	free(daemon->config_real);
+	free(daemon->base);
 }
 
 static int setup_config(struct daemon *daemon)
 {
+	if (daemon->base_user) {
+		daemon->base = strdup(daemon->base_user);
+		if (!daemon->base)
+			return -ENOMEM;
+	}
+
 	if (daemon->config) {
 		char *real = realpath(daemon->config, NULL);
 
@@ -104,6 +113,8 @@ int cmd_daemon(int argc, const char **argv)
 		OPT_INCR('v', "verbose", &verbose, "be more verbose"),
 		OPT_STRING(0, "config", &__daemon.config,
 			"config file", "config file path"),
+		OPT_STRING(0, "base", &__daemon.base_user,
+			"directory", "base directory"),
 		OPT_END()
 	};
 
-- 
2.29.2

