Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87DF424B0F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 02:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239961AbhJGAWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 20:22:13 -0400
Received: from linux.microsoft.com ([13.77.154.182]:52168 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbhJGAWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 20:22:12 -0400
Received: from localhost.localdomain (unknown [24.17.193.74])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8C5E020B85E6;
        Wed,  6 Oct 2021 17:20:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8C5E020B85E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1633566019;
        bh=vzIdSjGRZPP4HR/kLS9rLCzu7szruWoDwQmDGCKlAag=;
        h=From:To:Cc:Subject:Date:From;
        b=er4DxL0InbjLuaAr+WW3bOh2Zrud7JEi/96LJZ2ULWADqf/gx6ochMW4eksx47quY
         d54PAChNBQvawk+uyVrb2AtmYh+z30ZDrGNgHY4jPrWQO9l/nyYudH49fUqTEaV+8E
         wPETnUuDtJhxz/rrjyaZeT1/yvE9RN32ahmpVTzU=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     beaub@linux.microsoft.com, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] user_events: Enable user processes to create and write to trace events
Date:   Wed,  6 Oct 2021 17:20:04 -0700
Message-Id: <20211007002004.30498-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User mode processes that wish to use trace events to get data into
ftrace, perf, eBPF, etc are limited to uprobes today. The user events
features enables an ABI for user mode processes to create and write to
trace events that are isolated from kernel level trace events. This
enables a faster path for tracing from user mode data as well as opens
managed code to participate in trace events, where stub locations are
dynamic.

User processes often want to trace only when it's useful. To enable this
a set of pages are mapped into the user process space that indicate the
current state of the user events that have been registered. User
processes can check if their event is hooked to a trace/probe, and if it
is, emit the event data out via the write() syscall.

Two new files are introduced into tracefs to accomplish this:
user_events_status - This file is mmap'd into participating user mode
processes to indicate event status.

user_events_data - This file is opened and register/delete ioctl's are
issued to create/open/delete trace events that can be used for tracing.

The typical scenario is on process start to mmap user_events_status. Processes
then register the events they plan to use via the REG ioctl. The return value
of the ioctl indicates the byte in the mmap to use for status. The file that
was used for the ioctl is now accepting data via write() to emit out into the
trace event.

Psuedo code example of typical usage:
int page_fd = open("user_events_status", O_RDWR);
char *page_data = mmap(NULL, PAGE_SIZE, PROT_READ, MAP_SHARED, page_fd, 0);

int data_fd = open("user_events_data", O_RDWR);
int data_id = ioctl(data_fd, DIAG_IOCSREG, "test");

if (page_data[data_id]) write(data_fd, &payload, sizeof(payload));

User events are also exposed via the dynamic_events tracefs file for
both create and delete. Current status is exposed via the user_events_status
tracefs file.

Simple example to register a user event via dynamic_events:
	echo u:test >> dynamic_events
	cat dynamic_events
	u:test

If an event is hooked to a probe, the probe hooked shows up:
	echo 1 > events/user_events/test/enable
	cat user_events_status
	1:test (Used by ftrace)

	Active: 1
	Busy: 1 Max: 4096

If an event is not hooked to a probe, no probe status shows up:
	echo 0 > events/user_events/test/enable
	cat user_events_status
	1:test

	Active: 1
	Busy: 0
	Max: 4096

Users can describe the trace event format via the following format:
	name [field1;field2]

Each field has the following format:
	type name size

Example for char array with a size of 20 named msg:
	echo 'u:detailed char[20] msg 20' >> dynamic_events
	cat dynamic_events
	u:detailed	char[20] msg

Data offsets are based on the data written out via write() and will be
updated to reflect the correct offset in the trace_event fields. __data_loc
types must be aware of the size of trace_entry/common properties to ensure
proper decoding. An ioctl is provided that enables user mode processes that
only have access to user_events_data that returns the correct offset to use
within the data payload (nothing needs to be done on registration).

The above format is valid for both the ioctl and the dynamic_events file.

V2:
Fixed kmalloc vs kzalloc for register_page.
Renamed user_event_mmap to user_event_status.
Renamed user_event prefix from ue to u.
Added seq_* operations to user_event_status to enable cat output.
Aligned field parsing to synth_events format (+ size specifier for
custom/user types).
Added uapi header user_events.h to align kernel and user ABI definitions.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 include/uapi/linux/user_events.h |  36 ++
 kernel/trace/Kconfig             |  15 +
 kernel/trace/Makefile            |   1 +
 kernel/trace/trace_events_user.c | 900 +++++++++++++++++++++++++++++++
 4 files changed, 952 insertions(+)
 create mode 100644 include/uapi/linux/user_events.h
 create mode 100644 kernel/trace/trace_events_user.c

diff --git a/include/uapi/linux/user_events.h b/include/uapi/linux/user_events.h
new file mode 100644
index 000000000000..ac308d3a1a62
--- /dev/null
+++ b/include/uapi/linux/user_events.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2021, Microsoft Corporation.
+ *
+ * Authors:
+ *   Beau Belgrave <beaub@linux.microsoft.com>
+ */
+#ifndef _UAPI_LINUX_USER_EVENTS_H
+#define _UAPI_LINUX_USER_EVENTS_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define USER_EVENTS_SYSTEM "user_events"
+#define USER_EVENTS_PREFIX "u:"
+
+/* Bits 0-6 are for known probe types, Bit 7 is for unknown probes */
+#define EVENT_BIT_FTRACE 0
+#define EVENT_BIT_PERF 1
+#define EVENT_BIT_OTHER 7
+
+#define EVENT_STATUS_FTRACE (1 << EVENT_BIT_FTRACE)
+#define EVENT_STATUS_PERF (1 << EVENT_BIT_PERF)
+#define EVENT_STATUS_OTHER (1 << EVENT_BIT_OTHER)
+
+#define DIAG_IOC_MAGIC '*'
+#define DIAG_IOCSREG _IOW(DIAG_IOC_MAGIC, 0, char*)
+#define DIAG_IOCSDEL _IOW(DIAG_IOC_MAGIC, 1, char*)
+#define DIAG_IOCQLOCOFFSET _IO(DIAG_IOC_MAGIC, 2)
+
+struct user_bpf_context {
+	int udatalen;
+	const char __user *udata;
+};
+
+#endif /* _UAPI_LINUX_USER_EVENTS_H */
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 3ee23f4d437f..deaaad421be4 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -725,6 +725,21 @@ config SYNTH_EVENTS
 
 	  If in doubt, say N.
 
+config USER_EVENTS
+	bool "User trace events"
+	select TRACING
+	select DYNAMIC_EVENTS
+	default n
+	help
+	  User trace events are user-defined trace events that
+	  can be used like an existing kernel trace event.  User trace
+	  events are generated by writing to a tracefs file.  User
+	  processes can determine if their tracing events should be
+	  generated by memory mapping a tracefs file and checking for
+	  an associated byte being non-zero.
+
+	  If in doubt, say N.
+
 config HIST_TRIGGERS
 	bool "Histogram triggers"
 	depends on ARCH_HAVE_NMI_SAFE_CMPXCHG
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index b1c47ccf4f73..a653b255e89c 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_EVENT_TRACING) += trace_events_trigger.o
 obj-$(CONFIG_TRACE_EVENT_INJECT) += trace_events_inject.o
 obj-$(CONFIG_SYNTH_EVENTS) += trace_events_synth.o
 obj-$(CONFIG_HIST_TRIGGERS) += trace_events_hist.o
+obj-$(CONFIG_USER_EVENTS) += trace_events_user.o
 obj-$(CONFIG_BPF_EVENTS) += bpf_trace.o
 obj-$(CONFIG_KPROBE_EVENTS) += trace_kprobe.o
 obj-$(CONFIG_TRACEPOINTS) += error_report-traces.o
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
new file mode 100644
index 000000000000..ce38f7b796d9
--- /dev/null
+++ b/kernel/trace/trace_events_user.c
@@ -0,0 +1,900 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, Microsoft Corporation.
+ *
+ * Authors:
+ *   Beau Belgrave <beaub@linux.microsoft.com>
+ */
+
+#include <linux/bitmap.h>
+#include <linux/cdev.h>
+#include <linux/hashtable.h>
+#include <linux/io.h>
+#include <linux/ioctl.h>
+#include <linux/jhash.h>
+#include <linux/trace_events.h>
+#include <linux/tracefs.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <uapi/linux/user_events.h>
+#include "trace.h"
+#include "trace_dynevent.h"
+
+#define USER_EVENTS_PREFIX_LEN (sizeof(USER_EVENTS_PREFIX)-1)
+
+#define FIELD_DEPTH_TYPE 0
+#define FIELD_DEPTH_NAME 1
+#define FIELD_DEPTH_SIZE 2
+
+/*
+ * Limits how many trace_event calls user processes can create:
+ * Must be multiple of PAGE_SIZE.
+ */
+#define MAX_PAGES 1
+#define MAX_EVENTS (MAX_PAGES * PAGE_SIZE)
+
+/* Limit how long of an event name plus args within the subsystem. */
+#define MAX_EVENT_DESC 512
+#define EVENT_NAME(user_event) ((user_event)->tracepoint.name)
+
+static char *register_page_data;
+
+static DEFINE_HASHTABLE(register_table, 4);
+static DECLARE_BITMAP(page_bitmap, MAX_EVENTS);
+
+struct user_event {
+	struct tracepoint tracepoint;
+	struct trace_event_call call;
+	struct trace_event_class class;
+	struct dyn_event devent;
+	struct hlist_node node;
+	atomic_t refs;
+	int index;
+	char *args;
+};
+
+typedef void (*user_event_func_t) (struct user_event *user,
+				   const char __user *udata,
+				   size_t udatalen, void *tpdata);
+
+static int register_user_event(char *name, char *args,
+			       struct user_event **newuser);
+
+/*
+ * Parses a register command for user_events
+ * Format: event_name[;field1;field2;...]
+ *
+ * Example event named test with a 20 char msg field with a unsigned int after:
+ * test char[20] msg 20;unsigned int id 4;
+ *
+ * NOTE: Offsets are from the user data perspective, they are not from the
+ * trace_entry/buffer perspective. We automatically add the common properties
+ * sizes to the offset for the user. Types of __data_loc must trace a value that
+ * is offset by the value of the DIAG_IOCQLOCOFFSET ioctl to decode properly.
+ * This makes it easy for the common cases via the terminal, as only __data_loc
+ * types require an awareness by the user of the common property offsets.
+ */
+static int user_event_parse_cmd(char *raw_command, struct user_event **newuser)
+{
+	char *name = raw_command;
+	char *args = strpbrk(name, " ");
+
+	if (args)
+		*args++ = 0;
+
+	return register_user_event(name, args, newuser);
+}
+
+/*
+ * Parses the values of a field within the description
+ * Format: type name size [future]
+ */
+static int user_event_parse_field(char *field, struct user_event *user,
+				  u32 *offset)
+{
+	char *part, *type, *name;
+	u32 size = 0, depth = 0, saved_offset = *offset;
+
+	if (strstr(field, "unsigned ") == field) {
+		type = field;
+		field = strpbrk(field + sizeof("unsigned "), " ");
+
+		if (field == NULL)
+			return -EINVAL;
+
+		*field++ = 0;
+		depth++;
+	}
+
+	while ((part = strsep(&field, " ")) != NULL) {
+		switch (depth++) {
+		case FIELD_DEPTH_TYPE:
+			type = part;
+			break;
+		case FIELD_DEPTH_NAME:
+			name = part;
+			break;
+		case FIELD_DEPTH_SIZE:
+			if (kstrtou32(part, 10, &size))
+				return -EINVAL;
+			break;
+		default:
+			/* Forward compatibility, ignore */
+			goto end;
+		}
+	}
+end:
+	if (depth < FIELD_DEPTH_SIZE)
+		return -EINVAL;
+
+	if (!strcmp(type, "print_fmt")) {
+		user->call.print_fmt = name;
+		return 0;
+	}
+
+	*offset = saved_offset + size;
+
+	return trace_define_field(&user->call, type, name, saved_offset, size,
+				  type[0] != 'u', FILTER_OTHER);
+}
+
+/*
+ * Parses the fields that were described for the event
+ */
+static int user_event_parse_fields(struct user_event *user)
+{
+	char *field;
+	u32 offset = sizeof(struct trace_entry);
+	int ret = -EINVAL;
+
+	while ((field = strsep(&user->args, ";")) != NULL) {
+		ret = user_event_parse_field(field, user, &offset);
+
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int user_event_define_fields(struct trace_event_call *call)
+{
+	struct user_event *user = (struct user_event *)call->data;
+
+	/* User chose to not disclose arguments */
+	if (user->args == NULL)
+		return 0;
+
+	return user_event_parse_fields(user);
+}
+
+static struct trace_event_fields user_event_fields_array[] = {
+	{ .type = TRACE_FUNCTION_TYPE,
+	  .define_fields = user_event_define_fields },
+	{}
+};
+
+static enum print_line_t user_event_print_trace(struct trace_iterator *iter,
+						int flags,
+						struct trace_event *event)
+{
+	/* Unsafe to try to decode user provided print_fmt, use hex */
+	trace_print_hex_dump_seq(&iter->seq, "", DUMP_PREFIX_OFFSET, 16,
+				 1, iter->ent, iter->ent_size, true);
+
+	return trace_handle_return(&iter->seq);
+}
+
+static struct trace_event_functions user_event_funcs = {
+	.trace = user_event_print_trace,
+};
+
+static int destroy_user_event(struct user_event *user)
+{
+	int ret = 0;
+
+	/*
+	 * trace_remove_event_call invokes unregister_trace_event:
+	 * Pick the correct one based on if we set the data or not
+	 */
+	if (user->index != 0) {
+		ret = trace_remove_event_call(&user->call);
+
+		if (ret)
+			return ret;
+
+		dyn_event_remove(&user->devent);
+
+		register_page_data[user->index] = 0;
+		clear_bit(user->index, page_bitmap);
+		hash_del(&user->node);
+	} else {
+		unregister_trace_event(&user->call.event);
+	}
+
+	kfree(EVENT_NAME(user));
+	kfree(user);
+
+	return ret;
+}
+
+static struct user_event *find_user_event(u32 key, char *name)
+{
+	struct user_event *user;
+
+	hash_for_each_possible(register_table, user, node, key)
+		if (!strcmp(EVENT_NAME(user), name))
+			return user;
+
+	return NULL;
+}
+
+/*
+ * Writes the user supplied payload out to a trace file.
+ */
+static void user_event_ftrace(struct user_event *user, const char __user *udata,
+			      size_t udatalen, void *tpdata)
+{
+	struct trace_event_file *file;
+	struct trace_entry *entry;
+	struct trace_event_buffer event_buffer;
+
+	file = (struct trace_event_file *)tpdata;
+
+	if (!file ||
+	    !(file->flags & EVENT_FILE_FL_ENABLED) ||
+	    trace_trigger_soft_disabled(file))
+		return;
+
+	entry = trace_event_buffer_reserve(&event_buffer, file,
+					   sizeof(*entry) + udatalen);
+
+	if (!entry)
+		return;
+
+	if (!copy_from_user(entry + 1, udata, udatalen))
+		trace_event_buffer_commit(&event_buffer);
+}
+
+#ifdef CONFIG_PERF_EVENTS
+/*
+ * Writes the user supplied payload out to perf ring buffer or eBPF program.
+ */
+static void user_event_perf(struct user_event *user, const char __user *udata,
+			    size_t udatalen, void *tpdata)
+{
+	struct hlist_head *perf_head;
+
+	if (bpf_prog_array_valid(&user->call)) {
+		struct user_bpf_context context = {0};
+
+		context.udatalen = udatalen;
+		context.udata = udata;
+
+		trace_call_bpf(&user->call, &context);
+	}
+
+	perf_head = this_cpu_ptr(user->call.perf_events);
+
+	if (perf_head && !hlist_empty(perf_head)) {
+		struct trace_entry *perf_entry;
+		struct pt_regs *regs;
+		size_t size = sizeof(*perf_entry) + udatalen;
+		int context;
+
+		perf_entry = perf_trace_buf_alloc(ALIGN(size, 8),
+						  &regs, &context);
+
+		if (!perf_entry)
+			return;
+
+		perf_fetch_caller_regs(regs);
+
+		if (copy_from_user(perf_entry + 1,
+				   udata,
+				   udatalen))
+			return;
+
+		perf_trace_buf_submit(perf_entry, size, context,
+				      user->call.event.type, 1, regs,
+				      perf_head, NULL);
+	}
+}
+#endif
+
+/*
+ * Update the register page that is shared between user processes.
+ */
+static void update_reg_page_for(struct user_event *user)
+{
+	struct tracepoint *tp = &user->tracepoint;
+	char status = 0;
+
+	if (atomic_read(&tp->key.enabled) > 0) {
+		struct tracepoint_func *probe_func_ptr;
+		user_event_func_t probe_func;
+
+		probe_func_ptr = rcu_dereference_sched(tp->funcs);
+
+		if (probe_func_ptr) {
+			do {
+				probe_func = probe_func_ptr->func;
+
+				if (probe_func == user_event_ftrace)
+					status |= EVENT_STATUS_FTRACE;
+#ifdef CONFIG_PERF_EVENTS
+				else if (probe_func == user_event_perf)
+					status |= EVENT_STATUS_PERF;
+#endif
+				else
+					status |= EVENT_STATUS_OTHER;
+			} while ((++probe_func_ptr)->func);
+		}
+	}
+
+	register_page_data[user->index] = status;
+}
+
+/*
+ * Register callback for our events from tracing sub-systems.
+ */
+static int user_event_reg(struct trace_event_call *call,
+			  enum trace_reg type,
+			  void *data)
+{
+	struct user_event *user = (struct user_event *)call->data;
+	int ret = 0;
+
+	if (!user)
+		return -ENOENT;
+
+	switch (type) {
+	case TRACE_REG_REGISTER:
+		ret = tracepoint_probe_register(call->tp,
+						call->class->probe,
+						data);
+		if (!ret)
+			goto inc;
+		break;
+
+	case TRACE_REG_UNREGISTER:
+		tracepoint_probe_unregister(call->tp,
+					    call->class->probe,
+					    data);
+		goto dec;
+
+#ifdef CONFIG_PERF_EVENTS
+	case TRACE_REG_PERF_REGISTER:
+		ret = tracepoint_probe_register(call->tp,
+						call->class->perf_probe,
+						data);
+		if (!ret)
+			goto inc;
+		break;
+
+	case TRACE_REG_PERF_UNREGISTER:
+		tracepoint_probe_unregister(call->tp,
+					    call->class->perf_probe,
+					    data);
+		goto dec;
+
+	case TRACE_REG_PERF_OPEN:
+	case TRACE_REG_PERF_CLOSE:
+	case TRACE_REG_PERF_ADD:
+	case TRACE_REG_PERF_DEL:
+		break;
+#endif
+	}
+
+	return ret;
+inc:
+	atomic_inc(&user->refs);
+	update_reg_page_for(user);
+	return 0;
+dec:
+	update_reg_page_for(user);
+	atomic_dec(&user->refs);
+	return 0;
+}
+
+static u32 user_event_key(char *name)
+{
+	return jhash(name, strlen(name), 0);
+}
+
+static int user_event_create(const char *raw_command)
+{
+	struct user_event *user;
+	char *name;
+	int ret;
+
+	if (strstr(raw_command, USER_EVENTS_PREFIX) != raw_command)
+		return -ECANCELED;
+
+	raw_command += USER_EVENTS_PREFIX_LEN;
+	raw_command = skip_spaces(raw_command);
+
+	name = kstrdup(raw_command, GFP_KERNEL);
+
+	if (!name)
+		return -ENOMEM;
+
+	mutex_lock(&event_mutex);
+	ret = user_event_parse_cmd(name, &user);
+	mutex_unlock(&event_mutex);
+
+	return ret;
+}
+
+static int user_event_show(struct seq_file *m, struct dyn_event *ev)
+{
+	struct user_event *user = container_of(ev, struct user_event, devent);
+	struct ftrace_event_field *field, *next;
+	struct list_head *head;
+	int depth = 0;
+
+	seq_printf(m, "%s%s", USER_EVENTS_PREFIX, EVENT_NAME(user));
+
+	head = trace_get_fields(&user->call);
+
+	list_for_each_entry_safe_reverse(field, next, head, link) {
+		if (depth == 0)
+			seq_puts(m, "\t");
+		else
+			seq_puts(m, "; ");
+		seq_printf(m, "%s %s", field->type, field->name);
+		depth++;
+	}
+
+	seq_puts(m, "\n");
+
+	return 0;
+}
+
+static bool user_event_is_busy(struct dyn_event *ev)
+{
+	struct user_event *user = container_of(ev, struct user_event, devent);
+
+	return atomic_read(&user->refs) != 0;
+}
+
+static int user_event_free(struct dyn_event *ev)
+{
+	struct user_event *user = container_of(ev, struct user_event, devent);
+
+	return destroy_user_event(user);
+}
+
+static bool user_event_match(const char *system, const char *event,
+			     int argc, const char **argv, struct dyn_event *ev)
+{
+	struct user_event *user = container_of(ev, struct user_event, devent);
+
+	return strcmp(EVENT_NAME(user), event) == 0 &&
+		(!system || strcmp(system, USER_EVENTS_SYSTEM) == 0);
+}
+
+static struct dyn_event_operations user_event_dops = {
+	.create = user_event_create,
+	.show = user_event_show,
+	.is_busy = user_event_is_busy,
+	.free = user_event_free,
+	.match = user_event_match,
+};
+
+/*
+ * Register a trace_event into the system, either find or create.
+ */
+static int register_user_event(char *name, char *args,
+			       struct user_event **newuser)
+{
+	int ret;
+	int index;
+	u32 key = user_event_key(name);
+	struct user_event *user = find_user_event(key, name);
+
+	if (user) {
+		*newuser = user;
+		ret = 0;
+		goto put_name;
+	}
+
+	index = find_first_zero_bit(page_bitmap, MAX_EVENTS);
+
+	if (index == MAX_EVENTS) {
+		ret = -EMFILE;
+		goto put_name;
+	}
+
+	user = kzalloc(sizeof(*user), GFP_KERNEL);
+
+	if (!user) {
+		ret = -ENOMEM;
+		goto put_name;
+	}
+
+	INIT_LIST_HEAD(&user->class.fields);
+
+	user->tracepoint.name = name;
+	user->args = args;
+
+	user->call.data = user;
+	user->call.class = &user->class;
+	user->call.name = name;
+	user->call.flags = TRACE_EVENT_FL_TRACEPOINT;
+	user->call.tp = &user->tracepoint;
+	user->call.event.funcs = &user_event_funcs;
+
+	user->class.system = USER_EVENTS_SYSTEM;
+	user->class.fields_array = user_event_fields_array;
+	user->class.reg = user_event_reg;
+	user->class.probe = user_event_ftrace;
+#ifdef CONFIG_PERF_EVENTS
+	user->class.perf_probe = user_event_perf;
+#endif
+
+	ret = register_trace_event(&user->call.event);
+
+	if (!ret) {
+		ret = -ENODEV;
+		goto put_user;
+	}
+
+	ret = trace_add_event_call(&user->call);
+
+	if (ret) {
+		destroy_user_event(user);
+		goto out;
+	}
+
+	user->index = index;
+	dyn_event_init(&user->devent, &user_event_dops);
+	dyn_event_add(&user->devent);
+	set_bit(user->index, page_bitmap);
+	hash_add(register_table, &user->node, key);
+
+	*newuser = user;
+	return 0;
+put_user:
+	kfree(user);
+put_name:
+	kfree(name);
+out:
+	return ret;
+}
+
+/*
+ * Deletes a previously created event if it is no longer being used.
+ */
+static int delete_user_event(char *name)
+{
+	u32 key = user_event_key(name);
+	struct user_event *user = find_user_event(key, name);
+
+	if (!user)
+		return -ENOENT;
+
+	if (atomic_read(&user->refs) != 0)
+		return -EBUSY;
+
+	return destroy_user_event(user);
+}
+
+/*
+ * Validates the user payload and writes to the appropriate sub-system.
+ */
+static ssize_t user_events_write(struct file *file, const char __user *ubuf,
+				 size_t count, loff_t *ppos)
+{
+	struct user_event *user;
+	struct tracepoint *tp;
+
+	if (*ppos != 0 || count <= 0)
+		return -EFAULT;
+
+	user = file->private_data;
+
+	if (!user)
+		return -ENOENT;
+
+	tp = &user->tracepoint;
+
+	if (likely(atomic_read(&tp->key.enabled) > 0)) {
+		struct tracepoint_func *probe_func_ptr;
+		user_event_func_t probe_func;
+		void *tpdata;
+
+		preempt_disable();
+
+		if (unlikely(!(cpu_online(raw_smp_processor_id()))))
+			goto preempt_out;
+
+		probe_func_ptr = rcu_dereference_sched(tp->funcs);
+
+		if (probe_func_ptr) {
+			do {
+				probe_func = probe_func_ptr->func;
+				tpdata = probe_func_ptr->data;
+				probe_func(user, ubuf, count, tpdata);
+			} while ((++probe_func_ptr)->func);
+		}
+preempt_out:
+		preempt_enable();
+	}
+
+	return count;
+}
+
+/*
+ * Handles the ioctl from user mode to register or alter operations.
+ */
+static long user_events_ioctl(struct file *file, unsigned int cmd,
+			      unsigned long uarg)
+{
+	void __user *ubuf = (void __user *)uarg;
+	struct user_event *user;
+	char *name;
+	long ret;
+
+	switch (cmd) {
+	case DIAG_IOCSREG:
+		/* Register/lookup on behalf of user process */
+		name = strndup_user(ubuf, MAX_EVENT_DESC);
+
+		if (IS_ERR(name)) {
+			ret = PTR_ERR(name);
+			goto out;
+		}
+
+		mutex_lock(&event_mutex);
+
+		if (file->private_data) {
+			/* Already associated with an event */
+			ret = -EMFILE;
+			kfree(name);
+			goto reg_out;
+		}
+
+		ret = user_event_parse_cmd(name, &user);
+
+		if (!ret) {
+			file->private_data = user;
+			atomic_inc(&user->refs);
+		}
+reg_out:
+		mutex_unlock(&event_mutex);
+
+		if (ret < 0)
+			goto out;
+
+		/* Return page index to check before writes */
+		ret = user->index;
+		break;
+
+	case DIAG_IOCSDEL:
+		/* Delete on behalf of user process */
+		name = strndup_user(ubuf, MAX_EVENT_DESC);
+
+		if (IS_ERR(name)) {
+			ret = PTR_ERR(name);
+			goto out;
+		}
+
+		mutex_lock(&event_mutex);
+		ret = delete_user_event(name);
+		mutex_unlock(&event_mutex);
+
+		kfree(name);
+		break;
+
+	case DIAG_IOCQLOCOFFSET:
+		/*
+		 * Return data offset to use for data locs. This enables
+		 * user mode processes to query the common property sizes.
+		 * If this was not known, the data location values written
+		 * would be incorrect from the user mode side.
+		 */
+		ret = sizeof(struct trace_entry);
+		break;
+
+	default:
+		ret = -ENOTTY;
+		break;
+	}
+out:
+	return ret;
+}
+
+/*
+ * Handles the final close of the file from user mode.
+ */
+static int user_events_release(struct inode *node, struct file *file)
+{
+	struct user_event *user = file->private_data;
+
+	if (user)
+		atomic_dec(&user->refs);
+
+	return 0;
+}
+
+static const struct file_operations user_data_fops = {
+	.write = user_events_write,
+	.unlocked_ioctl	= user_events_ioctl,
+	.release = user_events_release,
+};
+
+/*
+ * Maps the shared page into the user process for checking if event is enabled.
+ */
+static int user_status_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	unsigned long size = vma->vm_end - vma->vm_start;
+
+	if (size != MAX_EVENTS)
+		return -EINVAL;
+
+	return remap_pfn_range(vma, vma->vm_start,
+			       virt_to_phys(register_page_data) >> PAGE_SHIFT,
+			       size, PAGE_READONLY);
+}
+
+static int user_status_show(struct seq_file *m, void *p)
+{
+	struct user_event *user;
+	char status;
+	int i, active = 0, busy = 0;
+
+	mutex_lock(&event_mutex);
+
+	hash_for_each(register_table, i, user, node) {
+		status = register_page_data[user->index];
+
+		seq_printf(m, "%d:%s", user->index, EVENT_NAME(user));
+
+		if (status != 0) {
+			seq_puts(m, " (Used by");
+			if (status & EVENT_STATUS_FTRACE)
+				seq_puts(m, " ftrace");
+			if (status & EVENT_STATUS_PERF)
+				seq_puts(m, " perf");
+			if (status & EVENT_STATUS_OTHER)
+				seq_puts(m, " other");
+			seq_puts(m, ")");
+			busy++;
+		}
+
+		seq_puts(m, "\n");
+		active++;
+	}
+
+	mutex_unlock(&event_mutex);
+
+	seq_puts(m, "\n");
+	seq_printf(m, "Active: %d\n", active);
+	seq_printf(m, "Busy: %d\n", busy);
+	seq_printf(m, "Max: %ld\n", MAX_EVENTS);
+
+	return 0;
+}
+
+static ssize_t user_status_read(struct file *file, char __user *ubuf,
+				size_t count, loff_t *ppos)
+{
+	/* 
+	 * Delay allocation of seq data until requested, most callers
+	 * will never read the status file. They will only mmap.
+	 */
+	if (file->private_data == NULL) {
+		int ret;
+
+		if (*ppos != 0)
+			return -EINVAL;
+
+		ret = single_open(file, user_status_show, NULL);
+
+		if (ret)
+			return ret;
+	}
+	
+	return seq_read(file, ubuf, count, ppos);
+}
+
+static loff_t user_status_seek(struct file *file, loff_t offset, int whence)
+{
+	if (file->private_data == NULL)
+		return 0;
+
+	return seq_lseek(file, offset, whence);
+}
+
+static int user_status_release(struct inode *node, struct file *file)
+{
+	if (file->private_data == NULL)
+		return 0;
+
+	return single_release(node, file);
+}
+
+static const struct file_operations user_status_fops = {
+	.mmap = user_status_mmap,
+	.read = user_status_read,
+	.llseek  = user_status_seek,
+	.release = user_status_release,
+};
+
+/*
+ * Creates a set of tracefs files to allow user mode interactions.
+ */
+static int create_user_tracefs(void)
+{
+	struct dentry *edata, *emmap;
+
+	edata = tracefs_create_file("user_events_data", 0644, NULL,
+				    NULL, &user_data_fops);
+
+	if (!edata) {
+		pr_warn("Could not create tracefs 'user_events_data' entry\n");
+		goto err;
+	}
+
+	/* mmap with MAP_SHARED requires writable fd */
+	emmap = tracefs_create_file("user_events_status", 0644, NULL,
+				    NULL, &user_status_fops);
+
+	if (!emmap) {
+		tracefs_remove(edata);
+		pr_warn("Could not create tracefs 'user_events_mmap' entry\n");
+		goto err;
+	}
+
+	return 0;
+err:
+	return -ENODEV;
+}
+
+static void set_page_reservations(bool set)
+{
+	int page;
+
+	for (page = 0; page < MAX_PAGES; ++page) {
+		void *addr = register_page_data + (PAGE_SIZE * page);
+
+		if (set)
+			SetPageReserved(virt_to_page(addr));
+		else
+			ClearPageReserved(virt_to_page(addr));
+	}
+}
+
+static int __init trace_events_user_init(void)
+{
+	int ret;
+
+	/* Zero all bits beside 0 (which is reserved for failures) */
+	bitmap_zero(page_bitmap, MAX_EVENTS);
+	set_bit(0, page_bitmap);
+
+	register_page_data = kzalloc(MAX_EVENTS, GFP_KERNEL);
+
+	if (!register_page_data)
+		return -ENOMEM;
+
+	set_page_reservations(true);
+
+	ret = create_user_tracefs();
+
+	if (ret) {
+		pr_warn("user_events could not register with tracefs\n");
+		set_page_reservations(false);
+		kfree(register_page_data);
+		return ret;
+	}
+
+	if (dyn_event_register(&user_event_dops))
+		pr_warn("user_events could not register with dyn_events\n");
+
+	return 0;
+}
+
+fs_initcall(trace_events_user_init);
-- 
2.17.1

