Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125A33DF386
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 19:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbhHCRGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 13:06:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237553AbhHCRGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 13:06:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 122B661186;
        Tue,  3 Aug 2021 17:06:09 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@rostedt.homelinux.com>)
        id 1mAxrk-002ucB-0K; Tue, 03 Aug 2021 13:06:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-trace-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH v3 17/22] libtracefs: Add man page for tracefs_sql()
Date:   Tue,  3 Aug 2021 13:06:01 -0400
Message-Id: <20210803170606.694085-18-rostedt@goodmis.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210803170606.694085-1-rostedt@goodmis.org>
References: <20210803170606.694085-1-rostedt@goodmis.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add a man page for tracefs_sql(). Included in that man page is a full
working sql parser example program that can allow you to create synthetic
events from writing SQL on the command line.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/libtracefs-sql.txt | 389 +++++++++++++++++++++++++++++++
 1 file changed, 389 insertions(+)
 create mode 100644 Documentation/libtracefs-sql.txt

diff --git a/Documentation/libtracefs-sql.txt b/Documentation/libtracefs-sql.txt
new file mode 100644
index 000000000000..e10a22cd531b
--- /dev/null
+++ b/Documentation/libtracefs-sql.txt
@@ -0,0 +1,389 @@
+libtracefs(3)
+=============
+
+NAME
+----
+tracefs_sql - Create a synthetitc event via an SQL statement
+
+SYNOPSIS
+--------
+[verse]
+--
+*#include <tracefs.h>*
+
+struct tracefs_synth *tracefs_sql(struct tep_handle pass:[*]tep, const char pass:[*]name,
+				  const char pass:[*]sql_buffer, char pass:[**]err);
+--
+
+DESCRIPTION
+-----------
+Synthetic events are dynamically created events that attach two existing events
+together via one or more matching fields between the two events. It can be used
+to find the latency between the events, or to simply pass fields of the first event
+on to the second event to display as one event.
+
+The Linux kernel interface to create synthetic events is complex, and there needs
+to be a better way to create synthetic events that is easy and can be understood
+via existing technology.
+
+If you think of each event as a table, where the fields are the column of the table
+and each instance of the event as a row, you can understand how SQL can be used
+to attach two events together and form another event (table). Utilizing the
+SQL *SELECT* *FROM* *JOIN* *ON* [ *WHERE* ] syntax, a synthetic event can easily
+be created from two different events.
+
+
+*tracefs_sql*() takes in a *tep* handler (See _tep_local_events_(3)) that is used to
+verify the events within the _sql_buffer_ expression. The _name_ is the name of the
+synthetic event to create. If _err_ points to an address of a string, it will be filled
+with a detailed message on any type of parsing error, including fields that do not belong
+to an event, or if the events or fields are not properly compared.
+
+The example program below is a fully functional parser where it will create a synthetic
+event from a SQL syntax passed in via the command line or a file.
+
+The SQL format is as follows:
+
+*SELECT* <fields> *FROM* <start-event> *JOIN* <end-event> *ON* <matching-fields> *WHERE* <filter>
+
+Note, although the examples show the SQL commands in uppercase, they are not required to
+be so. That is, you can use "SELECT" or "select" or "sElEct".
+
+For example:
+[source,c]
+--
+SELECT syscalls.sys_enter_read.fd, syscalls.sys_exit_read.ret FROM syscalls.sys_enter_read
+   JOIN syscalls.sys_exit_read
+   ON syscalls.sys_enter_read.common_pid = syscalls.sys_exit_write.common_pid
+--
+
+Will create a synthetic event that with the fields:
+
+  u64 fd; s64 ret;
+
+Because the function takes a _tep_ handle, and usually all event names are unique, you can
+leave off the system (group) name of the event, and *tracefs_sql*() will discover the
+system for you.
+
+That is, the above statement would work with:
+
+[source,c]
+--
+SELECT sys_enter_read.fd, sys_exit_read.ret FROM sys_enter_read JOIN sys_exit_read
+   ON sys_enter_read.common_pid = sys_exit_write.common_pid
+--
+
+The *AS* keyword can be used to name the fields as well as to give an alias to the
+events, such that the above can be simplified even more as:
+
+[source,c]
+--
+SELECT start.fd, end.ret FROM sys_enter_read AS start JOIN sys_exit_read AS end ON start.common_pid = end.common_pid
+--
+
+The above aliases _sys_enter_read_ as *start* and _sys_exit_read_ as *end* and uses
+those aliases to reference the event throughout the statement.
+
+Using the *AS* keyword in the selection portion of the SQL statement will define what
+those fields will be called in the synthetic event.
+
+[source,c]
+--
+SELECT start.fd AS filed, end.ret AS return FROM sys_enter_read AS start JOIN sys_exit_read AS end
+   ON start.common_pid = end.common_pid
+--
+
+The above labels the _fd_ of _start_ as *filed* and the _ret_ of _end_ as *return* where
+the synthetic event that is created will now have the fields:
+
+  u64 filed; s64 return;
+
+The fields can also be calculated with results passed to the synthetic event:
+
+[source,c]
+--
+select start.truesize, end.len, (start.truesize - end.len) as diff from napi_gro_receive_entry as start
+   JOIN netif_receive_skb as end ON start.skbaddr = end.skbaddr
+--
+
+Which would show the *truesize* of the _napi_gro_receive_entry_ event, the actual
+_len_ of the content, shown by the _netif_receive_skb_, and the delta between
+the two and expressed by the field *diff*.
+
+The code also supports recording the timestamps at either event, and performing calculations
+on them. For wakeup latency, you have:
+
+[source,c]
+--
+select start.pid, (end.TIMESTAMP_USECS - start.TIMESTAMP_USECS) as lat from sched_waking as start
+   JOIN sched_switch as end ON start.pid = end.next_pid
+--
+
+The above will create a synthetic event that records the _pid_ of the task being woken up,
+and the time difference between the _sched_waking_ event and the _sched_switch_ event.
+The *TIMESTAMP_USECS* will truncate the time down to microseconds as the timestamp usually
+recorded in the tracing buffer has nanosecond resolution. If you do not want that
+truncation, use *TIMESTAMP* instead of *TIMESTAMP_USECS*.
+
+Finally, the *WHERE* clause can be added, that will let you add filters on either or both events.
+
+[source,c]
+--
+select start.pid, (end.TIMESTAMP_USECS - start.TIMESTAMP_USECS) as lat from sched_waking as start
+   JOIN sched_switch as end ON start.pid = end.next_pid
+   WHERE start.prio < 100 && (!(end.prev_pid < 1 || end.prev_prio > 100) || end.prev_pid == 0)
+--
+
+*NOTE*
+
+Although both events can be used together in the *WHERE* clause, they must not be mixed outside
+the top most "&&" statements. You can not OR (||) the events together, where a filter of one
+event is OR'd to a filter of the other event. This does not make sense, as the synthetic event
+requires both events to take place to be recorded. If one is filtered out, then the synthetic
+event does not execute.
+
+[source,c]
+--
+select start.pid, (end.TIMESTAMP_USECS - start.TIMESTAMP_USECS) as lat from sched_waking as start
+   JOIN sched_switch as end ON start.pid = end.next_pid
+   WHERE start.prio < 100 && end.prev_prio < 100
+--
+
+The above is valid.
+
+Where as the below is not.
+
+[source,c]
+--
+select start.pid, (end.TIMESTAMP_USECS - start.TIMESTAMP_USECS) as lat from sched_waking as start
+   JOIN sched_switch as end ON start.pid = end.next_pid
+   WHERE start.prio < 100 || end.prev_prio < 100
+--
+
+
+RETURN VALUE
+------------
+Returns 0 on success and -1 on failure. On failure, if _err_ is defined, it will be
+allocated to hold a detailed description of what went wrong if it the error was caused
+by a parsing error, or that an event, field does not exist or is not compatible with
+what it was combined with.
+
+CREATE A TOOL
+-------------
+
+The below example is a functional program that can be used to parse SQL commands into
+synthetic events.
+
+[source, c]
+--
+   man tracefs_sql | sed -ne '/^EXAMPLE/,/FILES/ { /EXAMPLE/d ; /FILES/d ; p}' > sqlhist.c
+   gcc -o sqlhist sqlhist.c `pkg-config --cflags --libs libtracefs`
+--
+
+Then you can run the above examples:
+
+[source, c]
+--
+  sudo ./sqlhist 'select start.pid, (end.TIMESTAMP_USECS - start.TIMESTAMP_USECS) as lat from sched_waking as start
+                  JOIN sched_switch as end ON start.pid = end.next_pid
+                  WHERE start.prio < 100 || end.prev_prio < 100'
+--
+
+EXAMPLE
+-------
+[source,c]
+--
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <tracefs.h>
+
+static void usage(char **argv)
+{
+	fprintf(stderr, "usage: %s [-ed][-n name][-t dir][-f file | sql-command-line]\n"
+		"  -n name - name of synthetic event 'Anonymous' if left off\n"
+		"  -t dir - use dir instead of /sys/kernel/tracing\n"
+		"  -e - execute the commands to create the synthetic event\n"
+		"  -d - delete the synthetic event that would be created\n"
+		"  -f file - read sql lines from file otherwise from the command line\n"
+		"            if file is '-' then read from standard input.\n",
+		argv[0]);
+	exit(-1);
+}
+
+static int do_sql(const char *buffer, const char *name,
+		  const char *trace_dir, bool execute)
+{
+	struct tracefs_synth *synth;
+	struct tep_handle *tep;
+	struct trace_seq seq;
+	char *err;
+
+	if (!name)
+		name = "Anonymous";
+
+	trace_seq_init(&seq);
+	tep = tracefs_local_events(trace_dir);
+	if (!tep) {
+		if (!trace_dir)
+			trace_dir = "tracefs directory";
+		perror(trace_dir);
+		exit(-1);
+	}
+
+	synth = tracefs_sql(tep, name, buffer, &err);
+	if (!synth) {
+		perror("Failed creating synthetic event!");
+		if (err)
+			fprintf(stderr, "%s", err);
+		free(err);
+		exit(-1);
+	}
+
+	tracefs_synth_show(&seq, NULL, synth);
+	if (execute)
+		tracefs_synth_create(NULL, synth);
+	tracefs_synth_free(synth);
+
+	trace_seq_do_printf(&seq);
+	trace_seq_destroy(&seq);
+	return 0;
+}
+
+int main (int argc, char **argv)
+{
+	char *trace_dir = NULL;
+	char *buffer = NULL;
+	char buf[BUFSIZ];
+	int buffer_size = 0;
+	const char *file = NULL;
+	bool execute = false;
+	const char *name;
+	FILE *fp;
+	size_t r;
+	int c;
+	int i;
+
+	for (;;) {
+		c = getopt(argc, argv, "ht:f:edn:");
+		if (c == -1)
+			break;
+
+		switch(c) {
+		case 'h':
+			usage(argv);
+		case 't':
+			trace_dir = optarg;
+			break;
+		case 'f':
+			file = optarg;
+			break;
+		case 'e':
+			execute = true;
+			break;
+		case 'n':
+			name = optarg;
+			break;
+		}
+	}
+
+	if (file) {
+		if (!strcmp(file, "-"))
+			fp = stdin;
+		else
+			fp = fopen(file, "r");
+		if (!fp) {
+			perror(file);
+			exit(-1);
+		}
+		while ((r = fread(buf, 1, BUFSIZ, fp)) > 0) {
+			buffer = realloc(buffer, buffer_size + r + 1);
+			strncpy(buffer + buffer_size, buf, r);
+			buffer_size += r;
+		}
+		fclose(fp);
+		if (buffer_size)
+			buffer[buffer_size] = '\0';
+	} else if (argc == optind) {
+		usage(argv);
+	} else {
+		for (i = optind; i < argc; i++) {
+			r = strlen(argv[i]);
+			buffer = realloc(buffer, buffer_size + r + 2);
+			if (i != optind)
+				buffer[buffer_size++] = ' ';
+			strcpy(buffer + buffer_size, argv[i]);
+			buffer_size += r;
+		}
+	}
+
+	do_sql(buffer, name, trace_dir, execute);
+	free(buffer);
+
+	return 0;
+}
+--
+
+FILES
+-----
+[verse]
+--
+*tracefs.h*
+	Header file to include in order to have access to the library APIs.
+*-ltracefs*
+	Linker switch to add when building a program that uses the library.
+--
+
+SEE ALSO
+--------
+_libtracefs(3)_,
+_libtraceevent(3)_,
+_trace-cmd(1)_,
+_tracefs_synth_init(3)_,
+_tracefs_synth_add_match_field(3)_,
+_tracefs_synth_add_compare_field(3)_,
+_tracefs_synth_add_start_field(3)_,
+_tracefs_synth_add_end_field(3)_,
+_tracefs_synth_append_start_filter(3)_,
+_tracefs_synth_append_end_filter(3)_,
+_tracefs_synth_create(3)_,
+_tracefs_synth_destroy(3)_,
+_tracefs_synth_free(3)_,
+_tracefs_synth_show(3)_,
+_tracefs_hist_alloc(3)_,
+_tracefs_hist_free(3)_,
+_tracefs_hist_add_key(3)_,
+_tracefs_hist_add_value(3)_,
+_tracefs_hist_add_name(3)_,
+_tracefs_hist_start(3)_,
+_tracefs_hist_destory(3)_,
+_tracefs_hist_add_sort_key(3)_,
+_tracefs_hist_sort_key_direction(3)_
+
+AUTHOR
+------
+[verse]
+--
+*Steven Rostedt* <rostedt@goodmis.org>
+*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>
+*sameeruddin shaik* <sameeruddin.shaik8@gmail.com>
+--
+REPORTING BUGS
+--------------
+Report bugs to  <linux-trace-devel@vger.kernel.org>
+
+LICENSE
+-------
+libtracefs is Free Software licensed under the GNU LGPL 2.1
+
+RESOURCES
+---------
+https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/
+
+COPYING
+-------
+Copyright \(C) 2020 VMware, Inc. Free use of this software is granted under
+the terms of the GNU Public License (GPL).
-- 
2.30.2

