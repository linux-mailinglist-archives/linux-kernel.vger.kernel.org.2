Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37716446A7D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 22:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhKEVXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 17:23:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233897AbhKEVXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 17:23:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F5B2611C1;
        Fri,  5 Nov 2021 21:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636147222;
        bh=u4sgCo4YSOYwvHvP7P9BWZMv9uuTObC5yZGzA6hlfww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=SN8ym2/iIl8LPmjVV21+QUxbviou5QBOICcmsksP0s7N8Qy70xMkDWHzxy0rOvWoD
         Vj/4xWlDR2zs++IdmnAihp+2tWgCHFlM2RL/k6w9ht7lwEQbHFBXKyxqVB06bjAi6k
         HUrvkhyUnuur1Pe7aWst0itcH9TdX/jS5McO6J/V5jpSVMxgfpvEYW4gPdjfft8fT+
         VtnGRwbOj0pEzXX9fdFZRkN+Ph8uDT6ha8ZsS+0MZfharwKqpvMWxeECQcjEVqiC8e
         xt/QrGGjXlaXx040feA7nPNx/jlwd/CysDRPnasXeB0KhmXmpl0QefFa8Ir3pR9Vs2
         pFXnp5rC11T1g==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tracing: Add helper functions to simplify event_command callback handling
Date:   Fri,  5 Nov 2021 16:20:15 -0500
Message-Id: <bc058fce125e0728485b35332e34319cc6d51832.1636146732.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1636146732.git.zanussi@kernel.org>
References: <cover.1636146732.git.zanussi@kernel.org>
In-Reply-To: <cover.1636146732.git.zanussi@kernel.org>
References: <cover.1636146732.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The event_command.func() callback is responsible for parsing and
registering triggers.  The existing command implementions for this
callback duplicate a lot of the same code, so to clean up and
consolidate those implementations, introduce a handful of helper
functions for implementors to use.

This also makes it easier for new commands to be implemented and
allows them to focus more on the customizations they provide rather
than obscuring and complicating it with boilerplate code.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace.h                |  21 ++++
 kernel/trace/trace_events_trigger.c | 154 ++++++++++++++++++++++++++++
 2 files changed, 175 insertions(+)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 6b60ab9475ed..ff5a83b1104e 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1594,6 +1594,27 @@ get_named_trigger_data(struct event_trigger_data *data);
 extern int register_event_command(struct event_command *cmd);
 extern int unregister_event_command(struct event_command *cmd);
 extern int register_trigger_hist_enable_disable_cmds(void);
+extern int event_trigger_check(char *glob, char **trigger, char **param,
+			       bool *remove, bool require_param,
+			       bool separate_trigger);
+extern struct event_trigger_data *
+event_trigger_alloc(struct event_command *cmd_ops, char *trigger, char *cmd,
+		    void *private_data);
+extern int event_trigger_parse_num(char *trigger,
+				   struct event_trigger_data *trigger_data);
+extern int event_trigger_set_filter(struct event_command *cmd_ops,
+				    struct trace_event_file *file,
+				    char *param,
+				    struct event_trigger_data *trigger_data);
+extern void event_trigger_reset_filter(struct event_command *cmd_ops,
+				       struct event_trigger_data *trigger_data);
+extern int event_trigger_register(struct event_command *cmd_ops,
+				  struct trace_event_file *file,
+				  char *glob,
+				  char *cmd,
+				  char *trigger,
+				  struct event_trigger_data *trigger_data,
+				  int *n_registered);
 
 /**
  * struct event_trigger_ops - callbacks for trace event triggers
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 3d5c07239a2a..e3977b0a3e74 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -621,6 +621,160 @@ static void unregister_trigger(char *glob, struct event_trigger_ops *ops,
 		data->ops->free(data->ops, data);
 }
 
+int event_trigger_check(char *glob, char **trigger, char **param,
+			bool *remove, bool require_param, bool separate_trigger)
+{
+	int ret = 0;
+
+	*remove = (glob && glob[0] == '!') ? true : false;
+
+	if (!*param) {
+		if (require_param)
+			ret = -EINVAL;
+		goto out;
+	}
+
+	/* the only optional param recognized is n, ignore anything else */
+	if (*param && (!require_param) && (!isdigit(*param[0])))
+		goto out;
+
+	if (!separate_trigger) /* some callers may customize this */
+		goto out;
+
+	/* separate the trigger from the filter (trigger [if filter]) */
+	*trigger = strsep(param, " \t");
+	if (!*trigger) {
+		ret = -EINVAL;
+		goto out;
+	}
+	if (*param) {
+		*param = skip_spaces(*param);
+		if (!**param)
+			*param = NULL;
+	}
+out:
+	return ret;
+}
+
+struct event_trigger_data *event_trigger_alloc(struct event_command *cmd_ops,
+					       char *trigger,
+					       char *cmd,
+					       void *private_data)
+{
+	struct event_trigger_data *trigger_data;
+	struct event_trigger_ops *trigger_ops;
+
+	trigger_ops = cmd_ops->get_trigger_ops(cmd, trigger);
+
+	trigger_data = kzalloc(sizeof(*trigger_data), GFP_KERNEL);
+	if (!trigger_data)
+		return NULL;
+
+	trigger_data->count = -1;
+	trigger_data->ops = trigger_ops;
+	trigger_data->cmd_ops = cmd_ops;
+	trigger_data->private_data = private_data;
+
+	INIT_LIST_HEAD(&trigger_data->list);
+	INIT_LIST_HEAD(&trigger_data->named_list);
+	RCU_INIT_POINTER(trigger_data->filter, NULL);
+
+	return trigger_data;
+}
+
+void event_trigger_remove(struct event_command *cmd_ops,
+			  struct trace_event_file *file,
+			  char *glob,
+			  char *cmd,
+			  char *trigger,
+			  struct event_trigger_data **trigger_data)
+{
+	struct event_trigger_ops *trigger_ops;
+
+	trigger_ops = cmd_ops->get_trigger_ops(cmd, trigger);
+
+	cmd_ops->unreg(glob+1, trigger_ops, *trigger_data, file);
+
+	kfree(*trigger_data);
+
+	*trigger_data = NULL;
+}
+
+int event_trigger_parse_num(char *trigger,
+			    struct event_trigger_data *trigger_data)
+{
+	char *number;
+	int ret = 0;
+
+	if (trigger) {
+		number = strsep(&trigger, ":");
+
+		if (!strlen(number))
+			return -EINVAL;
+
+		/*
+		 * We use the callback data field (which is a pointer)
+		 * as our counter.
+		 */
+		ret = kstrtoul(number, 0, &trigger_data->count);
+	}
+
+	return ret;
+}
+
+int event_trigger_set_filter(struct event_command *cmd_ops,
+			     struct trace_event_file *file,
+			     char *param,
+			     struct event_trigger_data *trigger_data)
+{
+	if (param && cmd_ops->set_filter)
+		return cmd_ops->set_filter(param, trigger_data, file);
+
+	return 0;
+}
+
+void event_trigger_reset_filter(struct event_command *cmd_ops,
+				struct event_trigger_data *trigger_data)
+{
+	if (cmd_ops->set_filter)
+		cmd_ops->set_filter(NULL, trigger_data, NULL);
+}
+
+int event_trigger_register(struct event_command *cmd_ops,
+			   struct trace_event_file *file,
+			   char *glob,
+			   char *cmd,
+			   char *trigger,
+			   struct event_trigger_data *trigger_data,
+			   int *n_registered)
+{
+	struct event_trigger_ops *trigger_ops;
+	int ret;
+
+	if (n_registered)
+		*n_registered = 0;
+
+	trigger_ops = cmd_ops->get_trigger_ops(cmd, trigger);
+
+	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
+	/*
+	 * The above returns on success the # of functions enabled,
+	 * but if it didn't find any functions it returns zero.
+	 * Consider no functions a failure too.
+	 */
+	if (!ret) {
+		cmd_ops->unreg(glob, trigger_ops, trigger_data, file);
+		ret = -ENOENT;
+	} else if (ret > 0) {
+		if (n_registered)
+			*n_registered = ret;
+		/* Just return zero, not the number of enabled functions */
+		ret = 0;
+	}
+
+	return ret;
+}
+
 /**
  * event_trigger_callback - Generic event_command @func implementation
  * @cmd_ops: The command ops, used for trigger registration
-- 
2.17.1

