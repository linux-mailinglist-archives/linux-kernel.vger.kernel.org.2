Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16BD3DC0E0
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 00:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbhG3WSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 18:18:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232746AbhG3WSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 18:18:40 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0FD561052;
        Fri, 30 Jul 2021 22:18:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@rostedt.homelinux.com>)
        id 1m9apt-002V18-DX; Fri, 30 Jul 2021 18:18:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-trace-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 02/17] tracefs: Add unit tests for tracefs_sql()
Date:   Fri, 30 Jul 2021 18:18:09 -0400
Message-Id: <20210730221824.595597-3-rostedt@goodmis.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210730221824.595597-1-rostedt@goodmis.org>
References: <20210730221824.595597-1-rostedt@goodmis.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add basic unit test for tracefs_sql()...

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 utest/tracefs-utest.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/utest/tracefs-utest.c b/utest/tracefs-utest.c
index 2a99217b938a..89bb1cce61f7 100644
--- a/utest/tracefs-utest.c
+++ b/utest/tracefs-utest.c
@@ -44,6 +44,12 @@
 #define KRETPROBE_ADDR	"do_sys_openat2"
 #define KRETPROBE_FMT	"ret=$retval"
 
+#define SQL_1_EVENT	"wakeup_1"
+#define SQL_1_SQL	"select sched_switch.next_pid as woke_pid, sched_waking.common_pid as waking_pid from sched_waking join sched_switch on sched_switch.next_pid = sched_waking.pid"
+
+#define SQL_2_EVENT	"wakeup_2"
+#define SQL_2_SQL	"select woke.next_pid as woke_pid, wake.common_pid as waking_pid from sched_waking as wake join sched_switch as woke on woke.next_pid = wake.pid"
+
 static struct tracefs_instance *test_instance;
 static struct tep_handle *test_tep;
 struct test_sample {
@@ -322,6 +328,41 @@ static void test_ftrace_marker(void)
 	test_instance_ftrace_marker(test_instance);
 }
 
+static void test_instance_trace_sql(struct tracefs_instance *instance)
+{
+	struct tracefs_synth *synth;
+	struct trace_seq seq;
+	struct tep_handle *tep;
+	int ret;
+
+	tep = tracefs_local_events(NULL);
+	CU_TEST(tep != NULL);
+
+	trace_seq_init(&seq);
+
+	synth = tracefs_sql(tep, SQL_1_EVENT, SQL_1_SQL, NULL);
+	CU_TEST(synth != NULL);
+	ret = tracefs_synth_show(&seq, instance, synth);
+	CU_TEST(ret == 0);
+	tracefs_synth_free(synth);
+	trace_seq_reset(&seq);
+
+	synth = tracefs_sql(tep, SQL_2_EVENT, SQL_2_SQL, NULL);
+	CU_TEST(synth != NULL);
+	ret = tracefs_synth_show(&seq, instance, synth);
+	CU_TEST(ret == 0);
+	tracefs_synth_free(synth);
+	trace_seq_reset(&seq);
+
+	tep_free(tep);
+	trace_seq_destroy(&seq);
+}
+
+static void test_trace_sql(void)
+{
+	test_instance_trace_sql(test_instance);
+}
+
 static void test_trace_file(void)
 {
 	const char *tmp = get_rand_str();
@@ -1338,6 +1379,8 @@ void test_tracefs_lib(void)
 		fprintf(stderr, "Suite \"%s\" cannot be ceated\n", TRACEFS_SUITE);
 		return;
 	}
+	CU_add_test(suite, "trace sql",
+		    test_trace_sql);
 	CU_add_test(suite, "tracing file / directory APIs",
 		    test_trace_file);
 	CU_add_test(suite, "instance file / directory APIs",
-- 
2.30.2

