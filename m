Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0EF3DC0DE
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 00:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbhG3WSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 18:18:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232376AbhG3WSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 18:18:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9498B60F94;
        Fri, 30 Jul 2021 22:18:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@rostedt.homelinux.com>)
        id 1m9apt-002V1L-Gs; Fri, 30 Jul 2021 18:18:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-trace-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 06/17] libtracefs: Add unit test to test tracefs_sql() where clause
Date:   Fri, 30 Jul 2021 18:18:13 -0400
Message-Id: <20210730221824.595597-7-rostedt@goodmis.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210730221824.595597-1-rostedt@goodmis.org>
References: <20210730221824.595597-1-rostedt@goodmis.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add a test to test filtering of events via the WHERE clause.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 utest/tracefs-utest.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/utest/tracefs-utest.c b/utest/tracefs-utest.c
index f4e1a6b90a46..645c84c31f0e 100644
--- a/utest/tracefs-utest.c
+++ b/utest/tracefs-utest.c
@@ -53,6 +53,13 @@
 #define SQL_3_EVENT	"wakeup_lat"
 #define SQL_3_SQL	"select start.pid, end.next_prio as prio, (end.TIMESTAMP_USECS - start.TIMESTAMP_USECS) as lat from sched_waking as start join sched_switch as end on start.pid = end.next_pid"
 
+#define SQL_4_EVENT	"wakeup_lat_2"
+#define SQL_4_SQL	"select start.pid, end.next_prio as prio, (end.TIMESTAMP_USECS - start.TIMESTAMP_USECS) as lat from sched_waking as start join sched_switch as end on start.pid = end.next_pid where (start.prio >= 1 && start.prio < 100) || !(start.pid >= 0 && start.pid <= 1) && end.prev_pid != 0"
+
+#define SQL_5_EVENT	"irq_lat"
+#define SQL_5_SQL	"select end.common_pid as pid, (end.common_timestamp.usecs - start.common_timestamp.usecs) as irq_lat from irq_disable as start join irq_enable as end on start.common_pid = end.common_pid, start.parent_offs == end.parent_offs where start.common_pid != 0"
+#define SQL_5_START	"irq_disable"
+
 static struct tracefs_instance *test_instance;
 static struct tep_handle *test_tep;
 struct test_sample {
@@ -336,6 +343,7 @@ static void test_instance_trace_sql(struct tracefs_instance *instance)
 	struct tracefs_synth *synth;
 	struct trace_seq seq;
 	struct tep_handle *tep;
+	struct tep_event *event;
 	int ret;
 
 	tep = tracefs_local_events(NULL);
@@ -364,6 +372,23 @@ static void test_instance_trace_sql(struct tracefs_instance *instance)
 	tracefs_synth_free(synth);
 	trace_seq_reset(&seq);
 
+	synth = tracefs_sql(tep, SQL_4_EVENT, SQL_4_SQL, NULL);
+	CU_TEST(synth != NULL);
+	ret = tracefs_synth_show(&seq, instance, synth);
+	CU_TEST(ret == 0);
+	tracefs_synth_free(synth);
+	trace_seq_reset(&seq);
+
+	event = tep_find_event_by_name(tep, NULL, SQL_5_START);
+	if (event) {
+		synth = tracefs_sql(tep, SQL_5_EVENT, SQL_5_SQL, NULL);
+		CU_TEST(synth != NULL);
+		ret = tracefs_synth_show(&seq, instance, synth);
+		CU_TEST(ret == 0);
+		tracefs_synth_free(synth);
+		trace_seq_reset(&seq);
+	}
+
 	tep_free(tep);
 	trace_seq_destroy(&seq);
 }
-- 
2.30.2

