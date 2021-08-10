Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80ECD3DF385
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 19:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbhHCRGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 13:06:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237557AbhHCRGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 13:06:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3165D611C9;
        Tue,  3 Aug 2021 17:06:09 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@rostedt.homelinux.com>)
        id 1mAxrk-002ucQ-5e; Tue, 03 Aug 2021 13:06:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-trace-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH v3 22/22] libtracefs: Add CAST(x AS _COUNTER_) syntax to create values in histograms
Date:   Tue,  3 Aug 2021 13:06:06 -0400
Message-Id: <20210803170606.694085-23-rostedt@goodmis.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210803170606.694085-1-rostedt@goodmis.org>
References: <20210803170606.694085-1-rostedt@goodmis.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Use the CAST() command of SQL to define which items in the select should
be cast as values and not keys. By casting the field as the special value
_COUNTER_, it will turn the selection item into a value.

For example:

   SELECT common_pid, CAST(bytes_req AS _COUNTER_) FROM kmalloc

Will create:

  echo 'hist:keys=common_pid:vals=bytes_req' > events/kmem/kmalloc/trigger

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/libtracefs-sql.txt | 24 ++++++++++++++++++++++++
 include/tracefs-local.h          |  2 ++
 include/tracefs.h                |  3 +++
 src/tracefs-hist.c               | 28 ++++++++++++++++++++++++++--
 src/tracefs-sqlhist.c            | 23 +++++++++++++++++++++++
 5 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/Documentation/libtracefs-sql.txt b/Documentation/libtracefs-sql.txt
index b7d5c1b4f658..91c99d7969c3 100644
--- a/Documentation/libtracefs-sql.txt
+++ b/Documentation/libtracefs-sql.txt
@@ -238,6 +238,30 @@ name of the process.
 
 *LOG* or *LOG2* - bucket the key values in a log 2 values (1, 2, 3-4, 5-8, 9-16, 17-32, ...)
 
+The above fields are not case sensitive, and "LOG2" works as good as "log".
+
+A special CAST to _COUNTER_ or __COUNTER__ will make the field a value and not
+a key. For example:
+
+[source,c]
+--
+  SELECT common_pid, CAST(bytes_req AS _COUNTER_) FROM kmalloc
+--
+
+Which will create
+
+[source,c]
+--
+  echo 'hist:keys=common_pid:vals=bytes_req' > events/kmem/kmalloc/trigger
+
+  cat events/kmem/kmalloc/hist
+
+{ common_pid:       1812 } hitcount:          1  bytes_req:         32
+{ common_pid:       9111 } hitcount:          2  bytes_req:        272
+{ common_pid:       1768 } hitcount:          3  bytes_req:       1112
+{ common_pid:          0 } hitcount:          4  bytes_req:        512
+{ common_pid:      18297 } hitcount:         11  bytes_req:       2004
+--
 
 RETURN VALUE
 ------------
diff --git a/include/tracefs-local.h b/include/tracefs-local.h
index 07d40b2fae4f..684eccffafee 100644
--- a/include/tracefs-local.h
+++ b/include/tracefs-local.h
@@ -88,6 +88,8 @@ int trace_append_filter(char **filter, unsigned int *state,
 struct tracefs_synth *synth_init_from(struct tep_handle *tep,
 				      const char *start_system,
 				      const char *start_event);
+
+#define HIST_COUNTER_TYPE	(TRACEFS_HIST_KEY_MAX + 100)
 int synth_add_start_field(struct tracefs_synth *synth,
 			  const char *start_field,
 			  const char *name,
diff --git a/include/tracefs.h b/include/tracefs.h
index 219adba4b0ce..17020de0108a 100644
--- a/include/tracefs.h
+++ b/include/tracefs.h
@@ -264,6 +264,7 @@ enum tracefs_hist_key_type {
 	TRACEFS_HIST_KEY_EXECNAME,
 	TRACEFS_HIST_KEY_LOG,
 	TRACEFS_HIST_KEY_USECS,
+	TRACEFS_HIST_KEY_MAX
 };
 
 enum tracefs_hist_sort_direction {
@@ -275,6 +276,8 @@ enum tracefs_hist_sort_direction {
 #define TRACEFS_HIST_TIMESTAMP_USECS	"common_timestamp.usecs"
 #define TRACEFS_HIST_CPU		"cpu"
 
+#define TRACEFS_HIST_COUNTER		"__COUNTER__"
+
 #define TRACEFS_HIST_HITCOUNT		"hitcount"
 
 struct tracefs_hist;
diff --git a/src/tracefs-hist.c b/src/tracefs-hist.c
index 344e2525c823..7f9cf3820611 100644
--- a/src/tracefs-hist.c
+++ b/src/tracefs-hist.c
@@ -256,7 +256,7 @@ int tracefs_hist_add_key(struct tracefs_hist *hist, const char *key,
 	bool use_key = false;
 	char *key_type = NULL;
 	char **new_list;
-	int ret;
+	int ret = -1;
 
 	switch (type) {
 	case TRACEFS_HIST_KEY_NORMAL:
@@ -284,6 +284,9 @@ int tracefs_hist_add_key(struct tracefs_hist *hist, const char *key,
 	case TRACEFS_HIST_KEY_USECS:
 		ret = asprintf(&key_type, "%s.usecs", key);
 		break;
+	case TRACEFS_HIST_KEY_MAX:
+		/* error */
+		break;
 	}
 
 	if (ret < 0)
@@ -1450,6 +1453,9 @@ tracefs_synth_get_start_hist(struct tracefs_synth *synth)
 	for (i = 0; keys[i]; i++) {
 		int type = types ? types[i] : 0;
 
+		if (type == HIST_COUNTER_TYPE)
+			continue;
+
 		key = keys[i];
 
 		if (i) {
@@ -1466,7 +1472,25 @@ tracefs_synth_get_start_hist(struct tracefs_synth *synth)
 		}
 	}
 
-	if (hist && synth->start_filter) {
+	if (!hist)
+		return NULL;
+
+	for (i = 0; keys[i]; i++) {
+		int type = types ? types[i] : 0;
+
+		if (type != HIST_COUNTER_TYPE)
+			continue;
+
+		key = keys[i];
+
+		ret = tracefs_hist_add_value(hist, key);
+		if (ret < 0) {
+			tracefs_hist_free(hist);
+			return NULL;
+		}
+	}
+
+	if (synth->start_filter) {
 		hist->filter = strdup(synth->start_filter);
 		if (!hist->filter) {
 			tracefs_hist_free(hist);
diff --git a/src/tracefs-sqlhist.c b/src/tracefs-sqlhist.c
index 621310400959..622467745a94 100644
--- a/src/tracefs-sqlhist.c
+++ b/src/tracefs-sqlhist.c
@@ -1302,6 +1302,17 @@ static int verify_field_type(struct tep_handle *tep,
 	if (!type)
 		return -1;
 
+	if (!strcmp(type, TRACEFS_HIST_COUNTER) ||
+	    !strcmp(type, "_COUNTER_")) {
+		ret = HIST_COUNTER_TYPE;
+		if (tfield->flags & (TEP_FIELD_IS_STRING | TEP_FIELD_IS_ARRAY)) {
+			parse_error(sb, field->raw,
+				    "'%s' is a string, and counters may only be used with numbers\n");
+			ret = -1;
+		}
+		goto out;
+	}
+
 	for (i = 0; type[i]; i++)
 		type[i] = tolower(type[i]);
 
@@ -1341,6 +1352,7 @@ static int verify_field_type(struct tep_handle *tep,
 			    field->raw, type);
 		ret = -1;
 	}
+ out:
 	free(type);
 	return ret;
  fail_type:
@@ -1368,6 +1380,7 @@ static struct tracefs_synth *build_synth(struct tep_handle *tep,
 	const char *end_match;
 	bool started_start = false;
 	bool started_end = false;
+	bool non_val = false;
 	int ret;
 
 	if (!table->from)
@@ -1449,6 +1462,8 @@ static struct tracefs_synth *build_synth(struct tep_handle *tep,
 				type = verify_field_type(tep, table->sb, expr);
 				if (type < 0)
 					goto free;
+				if (type != HIST_COUNTER_TYPE)
+					non_val = true;
 				ret = synth_add_start_field(synth,
 						field->field, field->label,
 						type);
@@ -1479,6 +1494,14 @@ static struct tracefs_synth *build_synth(struct tep_handle *tep,
 		}
 	}
 
+	if (!non_val && !table->to) {
+		table->sb->line_no = 0;
+		table->sb->line_idx = 10;
+		parse_error(table->sb, "CAST",
+			    "Not all SELECT items can be of type _COUNTER_\n");
+		goto free;
+	}
+
 	for (expr = table->where; expr; expr = expr->next) {
 		const char *filter_system = NULL;
 		const char *filter_event = NULL;
-- 
2.30.2

