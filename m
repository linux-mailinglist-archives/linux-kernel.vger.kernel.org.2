Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41673F3581
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 22:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240522AbhHTUs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 16:48:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231344AbhHTUsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 16:48:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC7726115C;
        Fri, 20 Aug 2021 20:47:42 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mHBQT-004qO5-Ra; Fri, 20 Aug 2021 16:47:41 -0400
Message-ID: <20210820204741.694860960@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 20 Aug 2021 16:46:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Tzvetomir Stoyanov" <tz.stoyanov@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v9 1/6] tracing: Add a probe that attaches to trace events
References: <20210820204644.546662591@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>

A new dynamic event is introduced: event probe. The event is attached
to an existing tracepoint and uses its fields as arguments. The user
can specify custom format string of the new event, select what tracepoint
arguments will be printed and how to print them.
An event probe is created by writing configuration string in
'dynamic_events' ftrace file:
 e[:[SNAME/]ENAME] SYSTEM/EVENT [FETCHARGS]	- Set an event probe
 -:SNAME/ENAME					- Delete an event probe

Where:
 SNAME	- System name, if omitted 'eprobes' is used.
 ENAME	- Name of the new event in SNAME, if omitted the SYSTEM_EVENT is used.
 SYSTEM	- Name of the system, where the tracepoint is defined, mandatory.
 EVENT	- Name of the tracepoint event in SYSTEM, mandatory.
 FETCHARGS - Arguments:
  <name>=$<field>[:TYPE] - Fetch given filed of the tracepoint and print
			   it as given TYPE with given name. Supported
			   types are:
	                    (u8/u16/u32/u64/s8/s16/s32/s64), basic type
        	            (x8/x16/x32/x64), hexadecimal types
			    "string", "ustring" and bitfield.

Example, attach an event probe on openat system call and print name of the
file that will be opened:
 echo "e:esys/eopen syscalls/sys_enter_openat file=\$filename:string" >> dynamic_events
A new dynamic event is created in events/esys/eopen/ directory. It
can be deleted with:
 echo "-:esys/eopen" >> dynamic_events

Filters, triggers and histograms can be attached to the new event, it can
be matched in synthetic events. There is one limitation - an event probe
can not be attached to kprobe, uprobe or another event probe.

Link: https://lkml.kernel.org/r/20210812145805.2292326-1-tz.stoyanov@gmail.com
Link: https://lkml.kernel.org/r/20210819152825.142428383@goodmis.org

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_events.h        |   4 +
 kernel/trace/Makefile               |   1 +
 kernel/trace/trace.c                |   5 +-
 kernel/trace/trace.h                |  18 +
 kernel/trace/trace_eprobe.c         | 903 ++++++++++++++++++++++++++++
 kernel/trace/trace_events_trigger.c |  14 +-
 kernel/trace/trace_kprobe.c         |   8 -
 kernel/trace/trace_probe.c          |  16 +-
 kernel/trace/trace_probe.h          |   6 +-
 9 files changed, 962 insertions(+), 13 deletions(-)
 create mode 100644 kernel/trace/trace_eprobe.c

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 9564c4d9a3b6..0a0144580bbd 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -313,6 +313,7 @@ enum {
 	TRACE_EVENT_FL_DYNAMIC_BIT,
 	TRACE_EVENT_FL_KPROBE_BIT,
 	TRACE_EVENT_FL_UPROBE_BIT,
+	TRACE_EVENT_FL_EPROBE_BIT,
 };
 
 /*
@@ -325,6 +326,7 @@ enum {
  *  DYNAMIC       - Event is a dynamic event (created at run time)
  *  KPROBE        - Event is a kprobe
  *  UPROBE        - Event is a uprobe
+ *  EPROBE        - Event is an event probe
  */
 enum {
 	TRACE_EVENT_FL_FILTERED		= (1 << TRACE_EVENT_FL_FILTERED_BIT),
@@ -335,6 +337,7 @@ enum {
 	TRACE_EVENT_FL_DYNAMIC		= (1 << TRACE_EVENT_FL_DYNAMIC_BIT),
 	TRACE_EVENT_FL_KPROBE		= (1 << TRACE_EVENT_FL_KPROBE_BIT),
 	TRACE_EVENT_FL_UPROBE		= (1 << TRACE_EVENT_FL_UPROBE_BIT),
+	TRACE_EVENT_FL_EPROBE		= (1 << TRACE_EVENT_FL_EPROBE_BIT),
 };
 
 #define TRACE_EVENT_FL_UKPROBE (TRACE_EVENT_FL_KPROBE | TRACE_EVENT_FL_UPROBE)
@@ -680,6 +683,7 @@ enum event_trigger_type {
 	ETT_EVENT_ENABLE	= (1 << 3),
 	ETT_EVENT_HIST		= (1 << 4),
 	ETT_HIST_ENABLE		= (1 << 5),
+	ETT_EVENT_EPROBE	= (1 << 6),
 };
 
 extern int filter_match_preds(struct event_filter *filter, void *rec);
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index b1c47ccf4f73..6de5d4d63165 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_EVENT_TRACING) += trace_event_perf.o
 endif
 obj-$(CONFIG_EVENT_TRACING) += trace_events_filter.o
 obj-$(CONFIG_EVENT_TRACING) += trace_events_trigger.o
+obj-$(CONFIG_PROBE_EVENTS) += trace_eprobe.o
 obj-$(CONFIG_TRACE_EVENT_INJECT) += trace_events_inject.o
 obj-$(CONFIG_SYNTH_EVENTS) += trace_events_synth.o
 obj-$(CONFIG_HIST_TRIGGERS) += trace_events_hist.o
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8425c3d70895..489924cde4f8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5543,6 +5543,7 @@ static const char readme_msg[] =
 #ifdef CONFIG_HIST_TRIGGERS
 	"\t           s:[synthetic/]<event> <field> [<field>]\n"
 #endif
+	"\t           e[:[<group>/]<event>] <attached-group>.<attached-event> [<args>]\n"
 	"\t           -:[<group>/]<event>\n"
 #ifdef CONFIG_KPROBE_EVENTS
 	"\t    place: [<module>:]<symbol>[+<offset>]|<memaddr>\n"
@@ -5552,7 +5553,7 @@ static const char readme_msg[] =
   "   place (uprobe): <path>:<offset>[%return][(ref_ctr_offset)]\n"
 #endif
 	"\t     args: <name>=fetcharg[:type]\n"
-	"\t fetcharg: %<register>, @<address>, @<symbol>[+|-<offset>],\n"
+	"\t fetcharg: (%<register>|$<efield>), @<address>, @<symbol>[+|-<offset>],\n"
 #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
 	"\t           $stack<index>, $stack, $retval, $comm, $arg<N>,\n"
 #else
@@ -5567,6 +5568,8 @@ static const char readme_msg[] =
 	"\t    stype: u8/u16/u32/u64, s8/s16/s32/s64, pid_t,\n"
 	"\t           [unsigned] char/int/long\n"
 #endif
+	"\t    efield: For event probes ('e' types), the field is on of the fields\n"
+	"\t            of the <attached-group>/<attached-event>.\n"
 #endif
 	"  events/\t\t- Directory containing all trace event subsystems:\n"
 	"      enable\t\t- Write 0/1 to enable/disable tracing of all events\n"
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 4a0e693000c6..b7c0f8e160fb 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -126,6 +126,11 @@ struct kprobe_trace_entry_head {
 	unsigned long		ip;
 };
 
+struct eprobe_trace_entry_head {
+	struct trace_entry	ent;
+	unsigned int		type;
+};
+
 struct kretprobe_trace_entry_head {
 	struct trace_entry	ent;
 	unsigned long		func;
@@ -1508,9 +1513,14 @@ static inline int register_trigger_hist_enable_disable_cmds(void) { return 0; }
 extern int register_trigger_cmds(void);
 extern void clear_event_triggers(struct trace_array *tr);
 
+enum {
+	EVENT_TRIGGER_FL_PROBE		= BIT(0),
+};
+
 struct event_trigger_data {
 	unsigned long			count;
 	int				ref;
+	int				flags;
 	struct event_trigger_ops	*ops;
 	struct event_command		*cmd_ops;
 	struct event_filter __rcu	*filter;
@@ -1918,6 +1928,14 @@ static inline bool is_good_name(const char *name)
 	return true;
 }
 
+/* Convert certain expected symbols into '_' when generating event names */
+static inline void sanitize_event_name(char *name)
+{
+	while (*name++ != '\0')
+		if (*name == ':' || *name == '.')
+			*name = '_';
+}
+
 /*
  * This is a generic way to read and write a u64 value from a file in tracefs.
  *
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
new file mode 100644
index 000000000000..56a96e9750cf
--- /dev/null
+++ b/kernel/trace/trace_eprobe.c
@@ -0,0 +1,903 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * event probes
+ *
+ * Part of this code was copied from kernel/trace/trace_kprobe.c written by
+ * Masami Hiramatsu <mhiramat@kernel.org>
+ *
+ * Copyright (C) 2021, VMware Inc, Steven Rostedt <rostedt@goodmis.org>
+ * Copyright (C) 2021, VMware Inc, Tzvetomir Stoyanov tz.stoyanov@gmail.com>
+ *
+ */
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/ftrace.h>
+
+#include "trace_dynevent.h"
+#include "trace_probe.h"
+#include "trace_probe_tmpl.h"
+
+#define EPROBE_EVENT_SYSTEM "eprobes"
+
+struct trace_eprobe {
+	/* tracepoint system */
+	const char *event_system;
+
+	/* tracepoint event */
+	const char *event_name;
+
+	struct trace_event_call *event;
+
+	struct dyn_event	devent;
+	struct trace_probe	tp;
+};
+
+struct eprobe_data {
+	struct trace_event_file	*file;
+	struct trace_eprobe	*ep;
+};
+
+static int __trace_eprobe_create(int argc, const char *argv[]);
+
+static void trace_event_probe_cleanup(struct trace_eprobe *ep)
+{
+	if (!ep)
+		return;
+	trace_probe_cleanup(&ep->tp);
+	kfree(ep->event_name);
+	kfree(ep->event_system);
+	if (ep->event)
+		trace_event_put_ref(ep->event);
+	kfree(ep);
+}
+
+static struct trace_eprobe *to_trace_eprobe(struct dyn_event *ev)
+{
+	return container_of(ev, struct trace_eprobe, devent);
+}
+
+static int eprobe_dyn_event_create(const char *raw_command)
+{
+	return trace_probe_create(raw_command, __trace_eprobe_create);
+}
+
+static int eprobe_dyn_event_show(struct seq_file *m, struct dyn_event *ev)
+{
+	struct trace_eprobe *ep = to_trace_eprobe(ev);
+	int i;
+
+	seq_printf(m, "e:%s/%s", trace_probe_group_name(&ep->tp),
+				trace_probe_name(&ep->tp));
+	seq_printf(m, " %s.%s", ep->event_system, ep->event_name);
+
+	for (i = 0; i < ep->tp.nr_args; i++)
+		seq_printf(m, " %s=%s", ep->tp.args[i].name, ep->tp.args[i].comm);
+	seq_putc(m, '\n');
+
+	return 0;
+}
+
+static int unregister_trace_eprobe(struct trace_eprobe *ep)
+{
+	/* If other probes are on the event, just unregister eprobe */
+	if (trace_probe_has_sibling(&ep->tp))
+		goto unreg;
+
+	/* Enabled event can not be unregistered */
+	if (trace_probe_is_enabled(&ep->tp))
+		return -EBUSY;
+
+	/* Will fail if probe is being used by ftrace or perf */
+	if (trace_probe_unregister_event_call(&ep->tp))
+		return -EBUSY;
+
+unreg:
+	dyn_event_remove(&ep->devent);
+	trace_probe_unlink(&ep->tp);
+
+	return 0;
+}
+
+static int eprobe_dyn_event_release(struct dyn_event *ev)
+{
+	struct trace_eprobe *ep = to_trace_eprobe(ev);
+	int ret = unregister_trace_eprobe(ep);
+
+	if (!ret)
+		trace_event_probe_cleanup(ep);
+	return ret;
+}
+
+static bool eprobe_dyn_event_is_busy(struct dyn_event *ev)
+{
+	struct trace_eprobe *ep = to_trace_eprobe(ev);
+
+	return trace_probe_is_enabled(&ep->tp);
+}
+
+static bool eprobe_dyn_event_match(const char *system, const char *event,
+			int argc, const char **argv, struct dyn_event *ev)
+{
+	struct trace_eprobe *ep = to_trace_eprobe(ev);
+
+	return strcmp(trace_probe_name(&ep->tp), event) == 0 &&
+	    (!system || strcmp(trace_probe_group_name(&ep->tp), system) == 0) &&
+	    trace_probe_match_command_args(&ep->tp, argc, argv);
+}
+
+static struct dyn_event_operations eprobe_dyn_event_ops = {
+	.create = eprobe_dyn_event_create,
+	.show = eprobe_dyn_event_show,
+	.is_busy = eprobe_dyn_event_is_busy,
+	.free = eprobe_dyn_event_release,
+	.match = eprobe_dyn_event_match,
+};
+
+static struct trace_eprobe *alloc_event_probe(const char *group,
+					      const char *this_event,
+					      struct trace_event_call *event,
+					      int nargs)
+{
+	struct trace_eprobe *ep;
+	const char *event_name;
+	const char *sys_name;
+	int ret = -ENOMEM;
+
+	if (!event)
+		return ERR_PTR(-ENODEV);
+
+	sys_name = event->class->system;
+	event_name = trace_event_name(event);
+
+	ep = kzalloc(struct_size(ep, tp.args, nargs), GFP_KERNEL);
+	if (!ep) {
+		trace_event_put_ref(ep->event);
+		goto error;
+	}
+	ep->event = event;
+	ep->event_name = kstrdup(event_name, GFP_KERNEL);
+	if (!ep->event_name)
+		goto error;
+	ep->event_system = kstrdup(sys_name, GFP_KERNEL);
+	if (!ep->event_system)
+		goto error;
+
+	ret = trace_probe_init(&ep->tp, this_event, group, false);
+	if (ret < 0)
+		goto error;
+
+	dyn_event_init(&ep->devent, &eprobe_dyn_event_ops);
+	return ep;
+error:
+	trace_event_probe_cleanup(ep);
+	return ERR_PTR(ret);
+}
+
+static int trace_eprobe_tp_arg_update(struct trace_eprobe *ep, int i)
+{
+	struct probe_arg *parg = &ep->tp.args[i];
+	struct ftrace_event_field *field;
+	struct list_head *head;
+
+	head = trace_get_fields(ep->event);
+	list_for_each_entry(field, head, link) {
+		if (!strcmp(parg->code->data, field->name)) {
+			kfree(parg->code->data);
+			parg->code->data = field;
+			return 0;
+		}
+	}
+	kfree(parg->code->data);
+	parg->code->data = NULL;
+	return -ENOENT;
+}
+
+static int eprobe_event_define_fields(struct trace_event_call *event_call)
+{
+	int ret;
+	struct eprobe_trace_entry_head field;
+	struct trace_probe *tp;
+
+	tp = trace_probe_primary_from_call(event_call);
+	if (WARN_ON_ONCE(!tp))
+		return -ENOENT;
+
+	DEFINE_FIELD(unsigned int, type, FIELD_STRING_TYPE, 0);
+
+	return traceprobe_define_arg_fields(event_call, sizeof(field), tp);
+}
+
+static struct trace_event_fields eprobe_fields_array[] = {
+	{ .type = TRACE_FUNCTION_TYPE,
+	  .define_fields = eprobe_event_define_fields },
+	{}
+};
+
+/* Event entry printers */
+static enum print_line_t
+print_eprobe_event(struct trace_iterator *iter, int flags,
+		   struct trace_event *event)
+{
+	struct eprobe_trace_entry_head *field;
+	struct trace_event_call *pevent;
+	struct trace_event *probed_event;
+	struct trace_seq *s = &iter->seq;
+	struct trace_probe *tp;
+
+	field = (struct eprobe_trace_entry_head *)iter->ent;
+	tp = trace_probe_primary_from_call(
+		container_of(event, struct trace_event_call, event));
+	if (WARN_ON_ONCE(!tp))
+		goto out;
+
+	trace_seq_printf(s, "%s: (", trace_probe_name(tp));
+
+	probed_event = ftrace_find_event(field->type);
+	if (probed_event) {
+		pevent = container_of(probed_event, struct trace_event_call, event);
+		trace_seq_printf(s, "%s.%s", pevent->class->system,
+				 trace_event_name(pevent));
+	} else {
+		trace_seq_printf(s, "%u", field->type);
+	}
+
+	trace_seq_putc(s, ')');
+
+	if (print_probe_args(s, tp->args, tp->nr_args,
+			     (u8 *)&field[1], field) < 0)
+		goto out;
+
+	trace_seq_putc(s, '\n');
+ out:
+	return trace_handle_return(s);
+}
+
+static unsigned long get_event_field(struct fetch_insn *code, void *rec)
+{
+	struct ftrace_event_field *field = code->data;
+	unsigned long val;
+	void *addr;
+
+	addr = rec + field->offset;
+
+	switch (field->size) {
+	case 1:
+		if (field->is_signed)
+			val = *(char *)addr;
+		else
+			val = *(unsigned char *)addr;
+		break;
+	case 2:
+		if (field->is_signed)
+			val = *(short *)addr;
+		else
+			val = *(unsigned short *)addr;
+		break;
+	case 4:
+		if (field->is_signed)
+			val = *(int *)addr;
+		else
+			val = *(unsigned int *)addr;
+		break;
+	default:
+		if (field->is_signed)
+			val = *(long *)addr;
+		else
+			val = *(unsigned long *)addr;
+		break;
+	}
+	return val;
+}
+
+static int get_eprobe_size(struct trace_probe *tp, void *rec)
+{
+	struct probe_arg *arg;
+	int i, len, ret = 0;
+
+	for (i = 0; i < tp->nr_args; i++) {
+		arg = tp->args + i;
+		if (unlikely(arg->dynamic)) {
+			unsigned long val;
+
+			val = get_event_field(arg->code, rec);
+			len = process_fetch_insn_bottom(arg->code + 1, val, NULL, NULL);
+			if (len > 0)
+				ret += len;
+		}
+	}
+
+	return ret;
+}
+
+/* Kprobe specific fetch functions */
+
+/* Note that we don't verify it, since the code does not come from user space */
+static int
+process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
+		   void *base)
+{
+	unsigned long val;
+
+	val = get_event_field(code, rec);
+	return process_fetch_insn_bottom(code + 1, val, dest, base);
+}
+NOKPROBE_SYMBOL(process_fetch_insn)
+
+/* Return the length of string -- including null terminal byte */
+static nokprobe_inline int
+fetch_store_strlen_user(unsigned long addr)
+{
+	const void __user *uaddr =  (__force const void __user *)addr;
+
+	return strnlen_user_nofault(uaddr, MAX_STRING_SIZE);
+}
+
+/* Return the length of string -- including null terminal byte */
+static nokprobe_inline int
+fetch_store_strlen(unsigned long addr)
+{
+	int ret, len = 0;
+	u8 c;
+
+#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
+	if (addr < TASK_SIZE)
+		return fetch_store_strlen_user(addr);
+#endif
+
+	do {
+		ret = copy_from_kernel_nofault(&c, (u8 *)addr + len, 1);
+		len++;
+	} while (c && ret == 0 && len < MAX_STRING_SIZE);
+
+	return (ret < 0) ? ret : len;
+}
+
+/*
+ * Fetch a null-terminated string from user. Caller MUST set *(u32 *)buf
+ * with max length and relative data location.
+ */
+static nokprobe_inline int
+fetch_store_string_user(unsigned long addr, void *dest, void *base)
+{
+	const void __user *uaddr =  (__force const void __user *)addr;
+	int maxlen = get_loc_len(*(u32 *)dest);
+	void *__dest;
+	long ret;
+
+	if (unlikely(!maxlen))
+		return -ENOMEM;
+
+	__dest = get_loc_data(dest, base);
+
+	ret = strncpy_from_user_nofault(__dest, uaddr, maxlen);
+	if (ret >= 0)
+		*(u32 *)dest = make_data_loc(ret, __dest - base);
+
+	return ret;
+}
+
+/*
+ * Fetch a null-terminated string. Caller MUST set *(u32 *)buf with max
+ * length and relative data location.
+ */
+static nokprobe_inline int
+fetch_store_string(unsigned long addr, void *dest, void *base)
+{
+	int maxlen = get_loc_len(*(u32 *)dest);
+	void *__dest;
+	long ret;
+
+#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
+	if ((unsigned long)addr < TASK_SIZE)
+		return fetch_store_string_user(addr, dest, base);
+#endif
+
+	if (unlikely(!maxlen))
+		return -ENOMEM;
+
+	__dest = get_loc_data(dest, base);
+
+	/*
+	 * Try to get string again, since the string can be changed while
+	 * probing.
+	 */
+	ret = strncpy_from_kernel_nofault(__dest, (void *)addr, maxlen);
+	if (ret >= 0)
+		*(u32 *)dest = make_data_loc(ret, __dest - base);
+
+	return ret;
+}
+
+static nokprobe_inline int
+probe_mem_read_user(void *dest, void *src, size_t size)
+{
+	const void __user *uaddr =  (__force const void __user *)src;
+
+	return copy_from_user_nofault(dest, uaddr, size);
+}
+
+static nokprobe_inline int
+probe_mem_read(void *dest, void *src, size_t size)
+{
+#ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
+	if ((unsigned long)src < TASK_SIZE)
+		return probe_mem_read_user(dest, src, size);
+#endif
+	return copy_from_kernel_nofault(dest, src, size);
+}
+
+/* eprobe handler */
+static inline void
+__eprobe_trace_func(struct eprobe_data *edata, void *rec)
+{
+	struct eprobe_trace_entry_head *entry;
+	struct trace_event_call *call = trace_probe_event_call(&edata->ep->tp);
+	struct trace_event_buffer fbuffer;
+	int dsize;
+
+	if (WARN_ON_ONCE(call != edata->file->event_call))
+		return;
+
+	if (trace_trigger_soft_disabled(edata->file))
+		return;
+
+	fbuffer.trace_ctx = tracing_gen_ctx();
+	fbuffer.trace_file = edata->file;
+
+	dsize = get_eprobe_size(&edata->ep->tp, rec);
+	fbuffer.regs = NULL;
+
+	fbuffer.event =
+		trace_event_buffer_lock_reserve(&fbuffer.buffer, edata->file,
+					call->event.type,
+					sizeof(*entry) + edata->ep->tp.size + dsize,
+					fbuffer.trace_ctx);
+	if (!fbuffer.event)
+		return;
+
+	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
+	if (edata->ep->event)
+		entry->type = edata->ep->event->event.type;
+	else
+		entry->type = 0;
+	store_trace_args(&entry[1], &edata->ep->tp, rec, sizeof(*entry), dsize);
+
+	trace_event_buffer_commit(&fbuffer);
+}
+
+/*
+ * The event probe implementation uses event triggers to get access to
+ * the event it is attached to, but is not an actual trigger. The below
+ * functions are just stubs to fulfill what is needed to use the trigger
+ * infrastructure.
+ */
+static int eprobe_trigger_init(struct event_trigger_ops *ops,
+			       struct event_trigger_data *data)
+{
+	return 0;
+}
+
+static void eprobe_trigger_free(struct event_trigger_ops *ops,
+				struct event_trigger_data *data)
+{
+
+}
+
+static int eprobe_trigger_print(struct seq_file *m,
+				struct event_trigger_ops *ops,
+				struct event_trigger_data *data)
+{
+	/* Do not print eprobe event triggers */
+	return 0;
+}
+
+static void eprobe_trigger_func(struct event_trigger_data *data,
+				struct trace_buffer *buffer, void *rec,
+				struct ring_buffer_event *rbe)
+{
+	struct eprobe_data *edata = data->private_data;
+
+	__eprobe_trace_func(edata, rec);
+}
+
+static struct event_trigger_ops eprobe_trigger_ops = {
+	.func			= eprobe_trigger_func,
+	.print			= eprobe_trigger_print,
+	.init			= eprobe_trigger_init,
+	.free			= eprobe_trigger_free,
+};
+
+static int eprobe_trigger_cmd_func(struct event_command *cmd_ops,
+				   struct trace_event_file *file,
+				   char *glob, char *cmd, char *param)
+{
+	return -1;
+}
+
+static int eprobe_trigger_reg_func(char *glob, struct event_trigger_ops *ops,
+				 struct event_trigger_data *data,
+				 struct trace_event_file *file)
+{
+	return -1;
+}
+
+static void eprobe_trigger_unreg_func(char *glob, struct event_trigger_ops *ops,
+				    struct event_trigger_data *data,
+				    struct trace_event_file *file)
+{
+
+}
+
+static struct event_trigger_ops *eprobe_trigger_get_ops(char *cmd,
+							char *param)
+{
+	return &eprobe_trigger_ops;
+}
+
+static struct event_command event_trigger_cmd = {
+	.name			= "eprobe",
+	.trigger_type		= ETT_EVENT_EPROBE,
+	.flags			= EVENT_CMD_FL_NEEDS_REC,
+	.func			= eprobe_trigger_cmd_func,
+	.reg			= eprobe_trigger_reg_func,
+	.unreg			= eprobe_trigger_unreg_func,
+	.unreg_all		= NULL,
+	.get_trigger_ops	= eprobe_trigger_get_ops,
+	.set_filter		= NULL,
+};
+
+static struct event_trigger_data *
+new_eprobe_trigger(struct trace_eprobe *ep, struct trace_event_file *file)
+{
+	struct event_trigger_data *trigger;
+	struct eprobe_data *edata;
+
+	edata = kzalloc(sizeof(*edata), GFP_KERNEL);
+	trigger = kzalloc(sizeof(*trigger), GFP_KERNEL);
+	if (!trigger || !edata) {
+		kfree(edata);
+		kfree(trigger);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	trigger->flags = EVENT_TRIGGER_FL_PROBE;
+	trigger->count = -1;
+	trigger->ops = &eprobe_trigger_ops;
+
+	/*
+	 * EVENT PROBE triggers are not registered as commands with
+	 * register_event_command(), as they are not controlled by the user
+	 * from the trigger file
+	 */
+	trigger->cmd_ops = &event_trigger_cmd;
+
+	INIT_LIST_HEAD(&trigger->list);
+	RCU_INIT_POINTER(trigger->filter, NULL);
+
+	edata->file = file;
+	edata->ep = ep;
+	trigger->private_data = edata;
+
+	return trigger;
+}
+
+static int enable_eprobe(struct trace_eprobe *ep,
+			 struct trace_event_file *eprobe_file)
+{
+	struct event_trigger_data *trigger;
+	struct trace_event_file *file;
+	struct trace_array *tr = eprobe_file->tr;
+
+	file = find_event_file(tr, ep->event_system, ep->event_name);
+	if (!file)
+		return -ENOENT;
+	trigger = new_eprobe_trigger(ep, eprobe_file);
+	if (IS_ERR(trigger))
+		return PTR_ERR(trigger);
+
+	list_add_tail_rcu(&trigger->list, &file->triggers);
+
+	trace_event_trigger_enable_disable(file, 1);
+	update_cond_flag(file);
+
+	return 0;
+}
+
+static struct trace_event_functions eprobe_funcs = {
+	.trace		= print_eprobe_event
+};
+
+static int disable_eprobe(struct trace_eprobe *ep,
+			  struct trace_array *tr)
+{
+	struct event_trigger_data *trigger;
+	struct trace_event_file *file;
+	struct eprobe_data *edata;
+
+	file = find_event_file(tr, ep->event_system, ep->event_name);
+	if (!file)
+		return -ENOENT;
+
+	list_for_each_entry(trigger, &file->triggers, list) {
+		if (!(trigger->flags & EVENT_TRIGGER_FL_PROBE))
+			continue;
+		edata = trigger->private_data;
+		if (edata->ep == ep)
+			break;
+	}
+	if (list_entry_is_head(trigger, &file->triggers, list))
+		return -ENODEV;
+
+	list_del_rcu(&trigger->list);
+
+	trace_event_trigger_enable_disable(file, 0);
+	update_cond_flag(file);
+	return 0;
+}
+
+static int enable_trace_eprobe(struct trace_event_call *call,
+			       struct trace_event_file *file)
+{
+	struct trace_probe *pos, *tp;
+	struct trace_eprobe *ep;
+	bool enabled;
+	int ret = 0;
+
+	tp = trace_probe_primary_from_call(call);
+	if (WARN_ON_ONCE(!tp))
+		return -ENODEV;
+	enabled = trace_probe_is_enabled(tp);
+
+	/* This also changes "enabled" state */
+	if (file) {
+		ret = trace_probe_add_file(tp, file);
+		if (ret)
+			return ret;
+	} else
+		trace_probe_set_flag(tp, TP_FLAG_PROFILE);
+
+	if (enabled)
+		return 0;
+
+	list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
+		ep = container_of(pos, struct trace_eprobe, tp);
+		ret = enable_eprobe(ep, file);
+		if (ret)
+			break;
+		enabled = true;
+	}
+
+	if (ret) {
+		/* Failed to enable one of them. Roll back all */
+		if (enabled)
+			disable_eprobe(ep, file->tr);
+		if (file)
+			trace_probe_remove_file(tp, file);
+		else
+			trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
+	}
+
+	return ret;
+}
+
+static int disable_trace_eprobe(struct trace_event_call *call,
+				struct trace_event_file *file)
+{
+	struct trace_probe *pos, *tp;
+	struct trace_eprobe *ep;
+
+	tp = trace_probe_primary_from_call(call);
+	if (WARN_ON_ONCE(!tp))
+		return -ENODEV;
+
+	if (file) {
+		if (!trace_probe_get_file_link(tp, file))
+			return -ENOENT;
+		if (!trace_probe_has_single_file(tp))
+			goto out;
+		trace_probe_clear_flag(tp, TP_FLAG_TRACE);
+	} else
+		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
+
+	if (!trace_probe_is_enabled(tp)) {
+		list_for_each_entry(pos, trace_probe_probe_list(tp), list) {
+			ep = container_of(pos, struct trace_eprobe, tp);
+			disable_eprobe(ep, file->tr);
+		}
+	}
+
+ out:
+	if (file)
+		/*
+		 * Synchronization is done in below function. For perf event,
+		 * file == NULL and perf_trace_event_unreg() calls
+		 * tracepoint_synchronize_unregister() to ensure synchronize
+		 * event. We don't need to care about it.
+		 */
+		trace_probe_remove_file(tp, file);
+
+	return 0;
+}
+
+static int eprobe_register(struct trace_event_call *event,
+			   enum trace_reg type, void *data)
+{
+	struct trace_event_file *file = data;
+
+	switch (type) {
+	case TRACE_REG_REGISTER:
+		return enable_trace_eprobe(event, file);
+	case TRACE_REG_UNREGISTER:
+		return disable_trace_eprobe(event, file);
+#ifdef CONFIG_PERF_EVENTS
+	case TRACE_REG_PERF_REGISTER:
+	case TRACE_REG_PERF_UNREGISTER:
+	case TRACE_REG_PERF_OPEN:
+	case TRACE_REG_PERF_CLOSE:
+	case TRACE_REG_PERF_ADD:
+	case TRACE_REG_PERF_DEL:
+		return 0;
+#endif
+	}
+	return 0;
+}
+
+static inline void init_trace_eprobe_call(struct trace_eprobe *ep)
+{
+	struct trace_event_call *call = trace_probe_event_call(&ep->tp);
+
+	call->flags = TRACE_EVENT_FL_EPROBE;
+	call->event.funcs = &eprobe_funcs;
+	call->class->fields_array = eprobe_fields_array;
+	call->class->reg = eprobe_register;
+}
+
+static struct trace_event_call *
+find_and_get_event(const char *system, const char *event_name)
+{
+	struct trace_event_call *tp_event;
+	const char *name;
+
+	list_for_each_entry(tp_event, &ftrace_events, list) {
+		/* Skip other probes and ftrace events */
+		if (tp_event->flags &
+		    (TRACE_EVENT_FL_IGNORE_ENABLE |
+		     TRACE_EVENT_FL_KPROBE |
+		     TRACE_EVENT_FL_UPROBE |
+		     TRACE_EVENT_FL_EPROBE))
+			continue;
+		if (!tp_event->class->system ||
+		    strcmp(system, tp_event->class->system))
+			continue;
+		name = trace_event_name(tp_event);
+		if (!name || strcmp(event_name, name))
+			continue;
+		if (!trace_event_try_get_ref(tp_event)) {
+			return NULL;
+			break;
+		}
+		return tp_event;
+		break;
+	}
+	return NULL;
+}
+
+static int trace_eprobe_tp_update_arg(struct trace_eprobe *ep, const char *argv[], int i)
+{
+	unsigned int flags = TPARG_FL_KERNEL | TPARG_FL_TPOINT;
+	int ret;
+
+	ret = traceprobe_parse_probe_arg(&ep->tp, i, argv[i], flags);
+	if (ret)
+		return ret;
+
+	if (ep->tp.args[i].code->op == FETCH_OP_TP_ARG)
+		ret = trace_eprobe_tp_arg_update(ep, i);
+
+	return ret;
+}
+
+static int __trace_eprobe_create(int argc, const char *argv[])
+{
+	/*
+	 * Argument syntax:
+	 *      e[:[GRP/]ENAME] SYSTEM.EVENT [FETCHARGS]
+	 * Fetch args:
+	 *  <name>=$<field>[:TYPE]
+	 */
+	const char *event = NULL, *group = EPROBE_EVENT_SYSTEM;
+	const char *sys_event = NULL, *sys_name = NULL;
+	struct trace_event_call *event_call;
+	struct trace_eprobe *ep = NULL;
+	char buf1[MAX_EVENT_NAME_LEN];
+	char buf2[MAX_EVENT_NAME_LEN];
+	int ret = 0;
+	int i;
+
+	if (argc < 2 || argv[0][0] != 'e')
+		return -ECANCELED;
+
+	trace_probe_log_init("event_probe", argc, argv);
+
+	event = strchr(&argv[0][1], ':');
+	if (event) {
+		event++;
+		ret = traceprobe_parse_event_name(&event, &group, buf1,
+						  event - argv[0]);
+		if (ret)
+			goto parse_error;
+	} else {
+		strscpy(buf1, argv[1], MAX_EVENT_NAME_LEN);
+		sanitize_event_name(buf1);
+		event = buf1;
+	}
+	if (!is_good_name(event) || !is_good_name(group))
+		goto parse_error;
+
+	sys_event = argv[1];
+	ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2,
+					  sys_event - argv[1]);
+	if (ret || !sys_name)
+		goto parse_error;
+	if (!is_good_name(sys_event) || !is_good_name(sys_name))
+		goto parse_error;
+
+	mutex_lock(&event_mutex);
+	event_call = find_and_get_event(sys_name, sys_event);
+	ep = alloc_event_probe(group, event, event_call, argc - 2);
+	mutex_unlock(&event_mutex);
+
+	if (IS_ERR(ep)) {
+		ret = PTR_ERR(ep);
+		/* This must return -ENOMEM, else there is a bug */
+		WARN_ON_ONCE(ret != -ENOMEM);
+		goto error;	/* We know ep is not allocated */
+	}
+
+	argc -= 2; argv += 2;
+	/* parse arguments */
+	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
+		trace_probe_log_set_index(i + 2);
+		ret = trace_eprobe_tp_update_arg(ep, argv, i);
+		if (ret)
+			goto error;
+	}
+	ret = traceprobe_set_print_fmt(&ep->tp, PROBE_PRINT_EVENT);
+	if (ret < 0)
+		goto error;
+	init_trace_eprobe_call(ep);
+	mutex_lock(&event_mutex);
+	ret = trace_probe_register_event_call(&ep->tp);
+	if (ret) {
+		if (ret == -EEXIST) {
+			trace_probe_log_set_index(0);
+			trace_probe_log_err(0, EVENT_EXIST);
+		}
+		mutex_unlock(&event_mutex);
+		goto error;
+	}
+	ret = dyn_event_add(&ep->devent, &ep->tp.event->call);
+	mutex_unlock(&event_mutex);
+	return ret;
+parse_error:
+	ret = -EINVAL;
+error:
+	trace_event_probe_cleanup(ep);
+	return ret;
+}
+
+/*
+ * Register dynevent at core_initcall. This allows kernel to setup eprobe
+ * events in postcore_initcall without tracefs.
+ */
+static __init int trace_events_eprobe_init_early(void)
+{
+	int err = 0;
+
+	err = dyn_event_register(&eprobe_dyn_event_ops);
+	if (err)
+		pr_warn("Could not register eprobe_dyn_event_ops\n");
+
+	return err;
+}
+core_initcall(trace_events_eprobe_init_early);
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 6b11e335a62e..3d5c07239a2a 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -124,6 +124,18 @@ static void *trigger_next(struct seq_file *m, void *t, loff_t *pos)
 	return seq_list_next(t, &event_file->triggers, pos);
 }
 
+static bool check_user_trigger(struct trace_event_file *file)
+{
+	struct event_trigger_data *data;
+
+	list_for_each_entry_rcu(data, &file->triggers, list) {
+		if (data->flags & EVENT_TRIGGER_FL_PROBE)
+			continue;
+		return true;
+	}
+	return false;
+}
+
 static void *trigger_start(struct seq_file *m, loff_t *pos)
 {
 	struct trace_event_file *event_file;
@@ -134,7 +146,7 @@ static void *trigger_start(struct seq_file *m, loff_t *pos)
 	if (unlikely(!event_file))
 		return ERR_PTR(-ENODEV);
 
-	if (list_empty(&event_file->triggers))
+	if (list_empty(&event_file->triggers) || !check_user_trigger(event_file))
 		return *pos == 0 ? SHOW_AVAILABLE_TRIGGERS : NULL;
 
 	return seq_list_start(&event_file->triggers, *pos);
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 882c27044029..3a64ba4bbad6 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -707,14 +707,6 @@ static struct notifier_block trace_kprobe_module_nb = {
 	.priority = 1	/* Invoked after kprobe module callback */
 };
 
-/* Convert certain expected symbols into '_' when generating event names */
-static inline void sanitize_event_name(char *name)
-{
-	while (*name++ != '\0')
-		if (*name == ':' || *name == '.')
-			*name = '_';
-}
-
 static int __trace_kprobe_create(int argc, const char *argv[])
 {
 	/*
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 782c00eb6859..3ed2a3f37297 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -319,6 +319,13 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
 		code->op = FETCH_OP_ARG;
 		code->param = (unsigned int)param - 1;
 #endif
+	} else if (flags & TPARG_FL_TPOINT) {
+		if (code->data)
+			return -EFAULT;
+		code->data = kstrdup(arg, GFP_KERNEL);
+		if (!code->data)
+			return -ENOMEM;
+		code->op = FETCH_OP_TP_ARG;
 	} else
 		goto inval_var;
 
@@ -646,13 +653,14 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 	    !strcmp(parg->type->name, "ustring")) {
 		if (code->op != FETCH_OP_DEREF && code->op != FETCH_OP_UDEREF &&
 		    code->op != FETCH_OP_IMM && code->op != FETCH_OP_COMM &&
-		    code->op != FETCH_OP_DATA) {
+		    code->op != FETCH_OP_DATA && code->op != FETCH_OP_TP_ARG) {
 			trace_probe_log_err(offset + (t ? (t - arg) : 0),
 					    BAD_STRING);
 			goto fail;
 		}
 		if ((code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM ||
-		     code->op == FETCH_OP_DATA) || parg->count) {
+		     code->op == FETCH_OP_DATA) || code->op == FETCH_OP_TP_ARG ||
+		     parg->count) {
 			/*
 			 * IMM, DATA and COMM is pointing actual address, those
 			 * must be kept, and if parg->count != 0, this is an
@@ -867,6 +875,10 @@ static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
 		fmt = "(%lx <- %lx)";
 		arg = "REC->" FIELD_STRING_FUNC ", REC->" FIELD_STRING_RETIP;
 		break;
+	case PROBE_PRINT_EVENT:
+		fmt = "(%u)";
+		arg = "REC->" FIELD_STRING_TYPE;
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 66701a92d186..99e7a5df025e 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -38,6 +38,7 @@
 #define FIELD_STRING_IP		"__probe_ip"
 #define FIELD_STRING_RETIP	"__probe_ret_ip"
 #define FIELD_STRING_FUNC	"__probe_func"
+#define FIELD_STRING_TYPE	"__probe_type"
 
 #undef DEFINE_FIELD
 #define DEFINE_FIELD(type, item, name, is_signed)			\
@@ -102,6 +103,7 @@ enum fetch_op {
 	FETCH_OP_MOD_BF,	/* Bitfield: .basesize, .lshift, .rshift */
 	// Stage 5 (loop) op
 	FETCH_OP_LP_ARRAY,	/* Array: .param = loop count */
+	FETCH_OP_TP_ARG,	/* Trace Point argument */
 	FETCH_OP_END,
 	FETCH_NOP_SYMBOL,	/* Unresolved Symbol holder */
 };
@@ -351,7 +353,8 @@ int trace_probe_create(const char *raw_command, int (*createfn)(int, const char
 #define TPARG_FL_RETURN BIT(0)
 #define TPARG_FL_KERNEL BIT(1)
 #define TPARG_FL_FENTRY BIT(2)
-#define TPARG_FL_MASK	GENMASK(2, 0)
+#define TPARG_FL_TPOINT BIT(3)
+#define TPARG_FL_MASK	GENMASK(3, 0)
 
 extern int traceprobe_parse_probe_arg(struct trace_probe *tp, int i,
 				const char *argv, unsigned int flags);
@@ -366,6 +369,7 @@ int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
 enum probe_print_type {
 	PROBE_PRINT_NORMAL,
 	PROBE_PRINT_RETURN,
+	PROBE_PRINT_EVENT,
 };
 
 extern int traceprobe_set_print_fmt(struct trace_probe *tp, enum probe_print_type ptype);
-- 
2.30.2
