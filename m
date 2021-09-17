Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9203E40FD08
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 17:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbhIQPry convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Sep 2021 11:47:54 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:56534 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245546AbhIQPrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:47:33 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-s-zpI9wxPFSmf-DnMJVd0A-1; Fri, 17 Sep 2021 11:46:07 -0400
X-MC-Unique: s-zpI9wxPFSmf-DnMJVd0A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D98C9F92C;
        Fri, 17 Sep 2021 15:46:05 +0000 (UTC)
Received: from x1.bristot.me.homenet.telecomitalia.it (unknown [10.22.17.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8AA8B5D9C6;
        Fri, 17 Sep 2021 15:46:02 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Kate Carcia <kcarcia@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 07/19] rtla: Helper functions for rtla
Date:   Fri, 17 Sep 2021 17:43:50 +0200
Message-Id: <a9c8de597635ba86be0caaff40db38fd65c29fba.1631889858.git.bristot@kernel.org>
In-Reply-To: <cover.1631889858.git.bristot@kernel.org>
References: <cover.1631889858.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a set of utils and tracer helper functions. They are used by
rtla mostly to parse config, display data and some trace operations that
are not part of libtracefs (because they are only useful it for this
case).

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: linux-rt-users@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-of-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/trace.c | 220 +++++++++++++++++
 tools/tracing/rtla/src/trace.h |  26 ++
 tools/tracing/rtla/src/utils.c | 433 +++++++++++++++++++++++++++++++++
 tools/tracing/rtla/src/utils.h |  55 +++++
 4 files changed, 734 insertions(+)
 create mode 100644 tools/tracing/rtla/src/trace.c
 create mode 100644 tools/tracing/rtla/src/trace.h
 create mode 100644 tools/tracing/rtla/src/utils.c
 create mode 100644 tools/tracing/rtla/src/utils.h

diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
new file mode 100644
index 000000000000..6ea148c75403
--- /dev/null
+++ b/tools/tracing/rtla/src/trace.c
@@ -0,0 +1,220 @@
+#define _GNU_SOURCE
+#include <sys/sendfile.h>
+#include <tracefs.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+
+#include "trace.h"
+#include "utils.h"
+
+/*
+ * enable_tracer_by_name - enable a tracer on the given instance
+ */
+int enable_tracer_by_name(struct tracefs_instance *inst, const char *tracer)
+{
+	enum tracefs_tracers t;
+	int retval;
+
+	t = TRACEFS_TRACER_CUSTOM;
+
+	debug_msg("enabling %s tracer\n", tracer);
+
+	retval = tracefs_tracer_set(inst, t, tracer);
+	if (retval < 0) {
+		if (errno == ENODEV)
+			err_msg("tracer %s not found!\n", tracer);
+
+		err_msg("failed to enable the tracer %s\n", tracer);
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * disable_tracer - set nop tracer to the insta
+ */
+void disable_tracer(struct tracefs_instance *inst)
+{
+	enum tracefs_tracers t = TRACEFS_TRACER_NOP;
+	int retval;
+
+	retval = tracefs_tracer_set(inst, t);
+	if (retval < 0)
+		err_msg("oops, error disabling tracer\n");
+
+	return;
+}
+
+/*
+ * create_instance - create a trace instance with *instance_name
+ */
+struct tracefs_instance *create_instance(char *instance_name)
+{
+	return tracefs_instance_create(instance_name);
+}
+
+/*
+ * destroy_instance - remove a trace instance and free the data
+ */
+void destroy_instance(struct tracefs_instance *inst)
+{
+	tracefs_instance_destroy(inst);
+	tracefs_instance_free(inst);
+}
+
+/*
+ * save_trace_to_file - save the trace output of the instance to the file
+ */
+int save_trace_to_file(struct tracefs_instance *inst, const char *filename)
+{
+	mode_t mode = S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH;
+	const char *file = "trace";
+	char *buffer[4096];
+	int out_fd, in_fd;
+	int retval = -1;
+
+	in_fd = tracefs_instance_file_open(inst, file, O_RDONLY);
+	if (in_fd < 0) {
+		err_msg("Failed to open trace file\n");
+		return -1;
+	}
+
+	out_fd = creat(filename, mode);
+	if (out_fd < 0) {
+		err_msg("Failed to create output file %s\n", filename);
+		goto out_close;
+	}
+
+	do {
+		retval = read(in_fd, buffer, sizeof(buffer));
+		if (read <= 0)
+			goto out_close;
+
+		retval = write(out_fd, buffer, retval);
+		if (retval < 0)
+			goto out_close;
+	} while (retval > 0);
+
+	retval = 0;
+	close(out_fd);
+out_close:
+	close(in_fd);
+	return retval;
+}
+
+struct tracefs_instance *stop_inst = NULL;
+static void stop_trace_pipe(int sig)
+{
+	tracefs_trace_pipe_stop(stop_inst);
+}
+
+/*
+ * save_trace_pipe_to_file - save the trace output from a pipe to the file
+ *
+ * it works until receiving a signal to stop.
+ */
+int save_trace_pipe_to_file(struct tracefs_instance *inst, const char *filename)
+{
+	mode_t mode = S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH;
+	int retval;
+	int fd;
+
+	fd = creat(filename, mode);
+
+	stop_inst = inst;
+	signal(SIGINT, stop_trace_pipe);
+	retval = tracefs_trace_pipe_stream(fd, inst, SPLICE_F_NONBLOCK);
+	stop_inst = NULL;
+
+	close(fd);
+	return retval;
+}
+
+/*
+ * collect_registered_events - call the existing callback function for the event
+ *
+ * If an event has a registered callback function, call it.
+ * Otherwise, ignore the event.
+ */
+int
+collect_registered_events(struct tep_event *event, struct tep_record *record,
+			  int cpu, void *context)
+{
+	struct trace_instance *trace = context;
+	struct trace_seq *s = trace->seq;
+
+	if (!event->handler)
+		return 0;
+
+	event->handler(s, record, event, context);
+
+	return 0;
+}
+
+/*
+ * trace_instance_destroy - destroy and free a rtla trace instance
+ */
+void trace_instance_destroy(struct trace_instance *trace)
+{
+	if (trace->inst) {
+		disable_tracer(trace->inst);
+		destroy_instance(trace->inst);
+	}
+
+	if (trace->seq)
+		free(trace->seq);
+
+	if (trace->tep)
+		tep_free(trace->tep);
+}
+
+/*
+ * trace_instance_init - create an rtla trace instance
+ *
+ * It is more than the tracefs instance, as it contains other
+ * things required for the tracing, such as the local events and
+ * a seq file.
+ *
+ * Note that the trace instance is returned disabled. This allows
+ * the tool to apply some other configs, like setting priority
+ * to the kernel threads, before starting generating trace entires.
+ */
+int trace_instance_init(struct trace_instance *trace, char *tool_name)
+{
+	trace->seq = calloc(1, sizeof(*trace->seq));
+	if (!trace->seq)
+		goto out_err;
+
+	trace_seq_init(trace->seq);
+
+	trace->inst = create_instance(tool_name);
+	if (!trace->inst)
+		goto out_err;
+
+	trace->tep = tracefs_local_events(NULL);
+	if (!trace->tep)
+		goto out_err;
+
+	/*
+	 * Let the main enable the record after setting some other
+	 * things such as the priority of the tracer's threads.
+	 */
+	tracefs_trace_off(trace->inst);
+
+	return 0;
+
+out_err:
+	trace_instance_destroy(trace);
+	return 1;
+}
+
+/*
+ * trace_instance_start - start tracing a given rtla instance
+ */
+int trace_instance_start(struct trace_instance *trace)
+{
+	return tracefs_trace_on(trace->inst);
+}
diff --git a/tools/tracing/rtla/src/trace.h b/tools/tracing/rtla/src/trace.h
new file mode 100644
index 000000000000..c961e23b2909
--- /dev/null
+++ b/tools/tracing/rtla/src/trace.h
@@ -0,0 +1,26 @@
+#include <tracefs.h>
+#include <stddef.h>
+
+struct trace_instance {
+	struct tracefs_instance		*inst;
+	struct tep_handle		*tep;
+	struct trace_seq		*seq;
+};
+
+int trace_instance_init(struct trace_instance *trace, char *tool_name);
+int trace_instance_start(struct trace_instance *trace);
+void trace_instance_destroy(struct trace_instance *trace);
+
+struct trace_seq *get_trace_seq(void);
+int enable_tracer_by_name(struct tracefs_instance *inst, const char *tracer);
+void disable_tracer(struct tracefs_instance *inst);
+
+int enable_osnoise(struct trace_instance *trace);
+int enable_timerlat(struct trace_instance *trace);
+
+struct tracefs_instance *create_instance(char *instance_name);
+void destroy_instance(struct tracefs_instance *inst);
+
+int save_trace_to_file(struct tracefs_instance *inst, const char *filename);
+int collect_registered_events(struct tep_event *tep, struct tep_record *record,
+			      int cpu, void *context);
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
new file mode 100644
index 000000000000..20900e4bb194
--- /dev/null
+++ b/tools/tracing/rtla/src/utils.c
@@ -0,0 +1,433 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Red Hat Inc, Daniel Bristot de Oliveira <bristot@kernel.org>
+ */
+
+#include <proc/readproc.h>
+#include <stdarg.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <ctype.h>
+#include <errno.h>
+#include <sched.h>
+#include <stdio.h>
+
+#include "utils.h"
+
+#define MAX_MSG_LENGTH	1024
+int config_debug = 0;
+
+/*
+ * err_msg - print an error message to the stderr
+ */
+void err_msg(const char *fmt, ...)
+{
+	char message[MAX_MSG_LENGTH];
+	va_list ap;
+
+	va_start(ap, fmt);
+	vsnprintf(message, sizeof(message), fmt, ap);
+	va_end(ap);
+
+	fprintf(stderr, "%s", message);
+}
+
+/*
+ * debug_msg - print a debug message to stderr if debug is set
+ */
+void debug_msg(const char *fmt, ...)
+{
+	char message[MAX_MSG_LENGTH];
+	va_list ap;
+
+	if (!config_debug)
+		return;
+
+	va_start(ap, fmt);
+	vsnprintf(message, sizeof(message), fmt, ap);
+	va_end(ap);
+
+	fprintf(stderr, "%s", message);
+}
+
+/*
+ * get_long_from_str - get a long int from a string
+ */
+long get_long_from_str(char *start)
+{
+	long value;
+	char *end;
+
+	errno = 0;
+	value = strtol(start, &end, 10);
+	if (errno || start == end)
+		return -1;
+
+	return value;
+}
+
+/*
+ * get_duration - fill output with a human readable duration since start_time
+ */
+void get_duration(time_t start_time, char *output, int output_size)
+{
+	time_t now = time(NULL);
+	struct tm *tm_info;
+	time_t duration;
+
+	duration = difftime(now, start_time);
+	tm_info = localtime(&duration);
+
+	snprintf(output, output_size, "%3d %02d:%02d:%02d",
+			tm_info->tm_yday,
+			tm_info->tm_hour - 1,
+			tm_info->tm_min,
+			tm_info->tm_sec);
+
+	return;
+}
+
+/*
+ * parse_cpu_list - parse a cpu_list filling a char vector with cpus set
+ *
+ * Receives a cpu list, like 1-3,5 (cpus 1, 2, 3, 5), and then set the char
+ * in the monitored_cpus.
+ *
+ * XXX: convert to a bitmask.
+ */
+int parse_cpu_list(char *cpu_list, char **monitored_cpus)
+{
+	char *mon_cpus;
+	const char *p;
+	int end_cpu;
+	int nr_cpus;
+	int cpu;
+	int i;
+
+	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
+
+	mon_cpus = malloc(nr_cpus * sizeof(char));
+	memset(mon_cpus, 0, (nr_cpus * sizeof(char)));
+
+	for (p = cpu_list; *p; ) {
+		cpu = atoi(p);
+		if (cpu < 0 || (!cpu && *p != '0') || cpu >= nr_cpus)
+			goto err;
+
+		while (isdigit(*p))
+			p++;
+		if (*p == '-') {
+			p++;
+			end_cpu = atoi(p);
+			if (end_cpu < cpu || (!end_cpu && *p != '0') || end_cpu >= nr_cpus)
+				goto err;
+			while (isdigit(*p))
+				p++;
+		} else
+			end_cpu = cpu;
+
+		if (cpu == end_cpu) {
+			debug_msg("cpu_list: adding cpu %d\n", cpu);
+			mon_cpus[cpu] = 1;
+		} else {
+			for (i = cpu; i <= end_cpu; i++) {
+				debug_msg("cpu_list: adding cpu %d\n", i);
+				mon_cpus[i] = 1;
+			}
+		}
+
+		if (*p == ',')
+			p++;
+	}
+
+	*monitored_cpus = mon_cpus;
+
+	return 0;
+
+err:
+	debug_msg("Error parsing the cpu list %s", cpu_list);
+	return 1;
+}
+
+/*
+ * parse_duration - parse duration with s/m/h/d suffix converting it to seconds
+ */
+long parse_seconds_duration(char *val)
+{
+	char *end;
+	long t;
+	t = strtol(val, &end, 10);
+
+	if (end) {
+		switch (*end) {
+		case 's':
+		case 'S':
+			break;
+		case 'm':
+		case 'M':
+			t *= 60;
+			break;
+		case 'h':
+		case 'H':
+			t *= 60 * 60;
+			break;
+
+		case 'd':
+		case 'D':
+			t *= 24 * 60 * 60;
+			break;
+		}
+	}
+
+	return t;
+}
+
+/*
+ * parse_ns_duration - parse duration with ns/us/ms/s converting it to nanoseconds
+ */
+long parse_ns_duration(char *val)
+{
+	char *end;
+	long t;
+
+	t = strtol(val, &end, 10);
+
+	if (end) {
+		if (!strncmp(end, "ns", 2)) {
+			return t;
+		} else if (!strncmp(end, "us", 2)) {
+			t *= 1000;
+			return t;
+		} else if (!strncmp(end, "ms", 2)) {
+			t *= 1000 * 1000;
+			return t;
+		} else if (!strncmp(end, "s", 1)) {
+			t *= 1000 * 1000 *100;
+			return t;
+		}
+		return -1;
+	}
+
+	return t;
+}
+
+/*
+ * This is a set of helper functions to use SCHED_DEADLINE.
+ */
+#ifdef __x86_64__
+# define __NR_sched_setattr 314
+# define __NR_sched_getattr 315
+#elif __i386__
+# define __NR_sched_setattr 351
+# define __NR_sched_getattr 352
+#elif __arm__
+# define __NR_sched_setattr 380
+# define __NR_sched_getattr 381
+#elif __aarch64__
+# define __NR_sched_setattr 274
+# define __NR_sched_getattr 275
+#elif __powerpc__
+# define __NR_sched_setattr 355
+# define __NR_sched_getattr 356
+#elif __s390x__
+# define __NR_sched_setattr 345
+# define __NR_sched_getattr 346
+#endif
+
+#define SCHED_DEADLINE 	6
+
+static inline int sched_setattr(pid_t pid, const struct sched_attr *attr,
+				unsigned int flags) {
+	return syscall(__NR_sched_setattr, pid, attr, flags);
+}
+
+static inline int sched_getattr(pid_t pid, struct sched_attr *attr,
+				unsigned int size, unsigned int flags)
+{
+	return syscall (__NR_sched_getattr, pid , attr, size, flags);
+}
+
+int __set_sched_attr(int pid, struct sched_attr *attr)
+{
+	int flags = 0;
+	int retval;
+
+	retval = sched_setattr(pid, attr, flags);
+	if (retval < 0) {
+	err_msg("boost_with_deadline failed to boost pid %d: %s\n",
+		pid, strerror(errno));
+	return 1;
+	}
+
+	return 0;
+}
+/*
+ * set_comm_sched_attr - set sched params to threads starting with char *comm
+ *
+ * This function uses procps to list the currently running threads and then
+ * set the sched_attr *attr to the threads that start with char *comm. It is
+ * mainly used to set the priority to the kernel threads created by the
+ * tracers.
+ */
+int set_comm_sched_attr(const char *comm, struct sched_attr *attr)
+{
+	int flags = PROC_FILLCOM | PROC_FILLSTAT;
+	PROCTAB *ptp;
+	proc_t task;
+	int retval;
+
+	ptp = openproc(flags);
+	if (!ptp) {
+		err_msg("error openproc()\n");
+		return -ENOSYS;
+	}
+
+	memset(&task, 0, sizeof (task));
+	while (readproc(ptp, &task)) {
+		retval = strncmp(comm, task.cmd, strlen(comm));
+		if (retval)
+			continue;
+		retval = __set_sched_attr(task.tid, attr);
+		if (retval)
+			goto out_err;
+	}
+
+	closeproc(ptp);
+	return 0;
+
+out_err:
+	closeproc(ptp);
+	return 1;
+}
+
+#define INVALID_VAL 	(~0L)
+static long get_long_ns_after_colon(char *start)
+{
+	long val = INVALID_VAL;
+
+	/* find the ":" */
+	start = strstr(start, ":");
+	if (!start)
+		return -1;
+
+	/* skip ":" */
+	start++;
+	val = parse_ns_duration(start);
+
+	return val;
+}
+
+static long get_long_after_colon(char *start)
+{
+	long val = INVALID_VAL;
+
+	/* find the ":" */
+	start = strstr(start, ":");
+	if (!start)
+		return -1;
+
+	/* skip ":" */
+	start++;
+	val = get_long_from_str(start);
+
+	return val;
+}
+
+/*
+ * parse priority in the format:
+ * SCHED_OTHER:
+ * 		o:<prio>
+ * 		O:<prio>
+ * SCHED_RR:
+ * 		r:<prio>
+ * 		R:<prio>
+ * SCHED_FIFO:
+ * 		f:<prio>
+ * 		F:<prio>
+ * SCHED_DEADLINE:
+ * 		d:runtime:period
+ * 		R:runtime:period
+ */
+int parse_prio(char *arg, struct sched_attr *sched_param)
+{
+	long prio;
+	long runtime;
+	long period;
+
+	memset(sched_param, 0, sizeof(*sched_param));
+	sched_param->size = sizeof(*sched_param);
+
+	switch (arg[0]) {
+		case 'd':
+		case 'D':
+			/* d:runtime:period */
+			if (strlen(arg) < 4)
+				return -1;
+
+			runtime = get_long_ns_after_colon(arg);
+			if (runtime == INVALID_VAL)
+				return -1;
+
+			period = get_long_ns_after_colon(&arg[2]);
+			if (period == INVALID_VAL)
+				return -1;
+
+			if (runtime > period)
+				return -1;
+
+			sched_param->sched_policy   = SCHED_DEADLINE;
+			sched_param->sched_runtime  = runtime;
+			sched_param->sched_deadline = period;
+			sched_param->sched_period   = period;
+			break;
+		case 'f':
+		case 'F':
+			/* f:prio */
+			prio = get_long_after_colon(arg);
+			if (prio == INVALID_VAL)
+				return -1;
+
+			if (prio < sched_get_priority_min(SCHED_FIFO))
+				return -1;
+			if (prio > sched_get_priority_max(SCHED_FIFO))
+				return -1;
+
+			sched_param->sched_policy   = SCHED_FIFO;
+			sched_param->sched_priority = prio;
+			break;
+		case 'r':
+		case 'R':
+			/* r:prio */
+			prio = get_long_after_colon(arg);
+			if (prio == INVALID_VAL)
+				return -1;
+
+			if (prio < sched_get_priority_min(SCHED_RR))
+				return -1;
+			if (prio > sched_get_priority_max(SCHED_RR))
+				return -1;
+
+			sched_param->sched_policy   = SCHED_RR;
+			sched_param->sched_priority = prio;
+			break;
+		case 'o':
+		case 'O':
+			/* o:prio */
+			prio = get_long_after_colon(arg);
+			if (prio == INVALID_VAL)
+				return -1;
+
+			if (prio < sched_get_priority_min(SCHED_OTHER))
+				return -1;
+			if (prio > sched_get_priority_max(SCHED_OTHER))
+				return -1;
+
+			sched_param->sched_policy   = SCHED_OTHER;
+			sched_param->sched_priority = prio;
+			break;
+		default:
+			return -1;
+	}
+	return 0;
+}
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
new file mode 100644
index 000000000000..31a7ce1bfa9a
--- /dev/null
+++ b/tools/tracing/rtla/src/utils.h
@@ -0,0 +1,55 @@
+#include <stdint.h>
+#include <time.h>
+
+/*
+ * '18446744073709551615\0'
+ */
+#define BUFF_U64_STR_SIZE	24
+
+#define container_of(ptr, type, member) ({			\
+	const typeof( ((type *)0)->member ) *__mptr = (ptr);	\
+	(type *)( (char *)__mptr - offsetof(type,member) );})
+
+extern int config_debug;
+void debug_msg(const char *fmt, ...);
+void err_msg(const char *fmt, ...);
+
+long parse_seconds_duration(char *val);
+void get_duration(time_t start_time, char *output, int output_size);
+
+int parse_cpu_list(char *cpu_list, char **monitored_cpus);
+long get_long_from_str(char *start);
+
+static inline void
+update_min(unsigned long long *a, unsigned long long *b)
+{
+	if (*a > *b)
+		*a = *b;
+}
+
+static inline void
+update_max(unsigned long long *a, unsigned long long *b)
+{
+	if (*a < *b)
+		*a = *b;
+}
+
+static inline void
+update_sum(unsigned long long *a, unsigned long long *b)
+{
+	*a += *b;
+}
+
+struct sched_attr {
+	uint32_t size;
+	uint32_t sched_policy;
+	uint64_t sched_flags;
+	int32_t sched_nice;
+	uint32_t sched_priority;
+	uint64_t sched_runtime;
+	uint64_t sched_deadline;
+	uint64_t sched_period;
+};
+
+int parse_prio(char *arg, struct sched_attr *sched_param);
+int set_comm_sched_attr(const char *comm, struct sched_attr *attr);
-- 
2.31.1

