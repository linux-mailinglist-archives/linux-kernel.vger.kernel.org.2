Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9A63098F8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 00:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbhA3XwG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 30 Jan 2021 18:52:06 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:28760 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232542AbhA3Xub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 18:50:31 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-Ijxlz0uKPhS5F2FqZaK3SQ-1; Sat, 30 Jan 2021 18:49:12 -0500
X-MC-Unique: Ijxlz0uKPhS5F2FqZaK3SQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30FA91005504;
        Sat, 30 Jan 2021 23:49:11 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A83F26F974;
        Sat, 30 Jan 2021 23:49:08 +0000 (UTC)
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
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: [PATCH 03/24] perf daemon: Add base option
Date:   Sun, 31 Jan 2021 00:48:35 +0100
Message-Id: <20210130234856.271282-4-jolsa@kernel.org>
In-Reply-To: <20210130234856.271282-1-jolsa@kernel.org>
References: <20210129134855.195810-1-jolsa@redhat.com>
 <20210130234856.271282-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
 tools/perf/builtin-daemon.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 1f2393faad75..8d0ac44ec808 100644
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
@@ -38,6 +40,7 @@ static void sig_handler(int sig __maybe_unused)
 static void daemon__free(struct daemon *daemon)
 {
 	free(daemon->config_real);
+	free(daemon->base);
 }
 
 static void daemon__exit(struct daemon *daemon)
@@ -47,6 +50,12 @@ static void daemon__exit(struct daemon *daemon)
 
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
 
@@ -109,6 +118,8 @@ int cmd_daemon(int argc, const char **argv)
 		OPT_INCR('v', "verbose", &verbose, "be more verbose"),
 		OPT_STRING(0, "config", &__daemon.config,
 			"config file", "config file path"),
+		OPT_STRING(0, "base", &__daemon.base_user,
+			"directory", "base directory"),
 		OPT_END()
 	};
 
-- 
2.29.2

