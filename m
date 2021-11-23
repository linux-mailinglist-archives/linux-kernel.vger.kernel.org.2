Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9016E45ADA3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 21:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbhKWU5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 15:57:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:36962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239058AbhKWU5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 15:57:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 114D260FC1;
        Tue, 23 Nov 2021 20:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637700842;
        bh=WRiVZ3M3vWtxpGXfYCMeBxNQv0KeU7EyCdHPQ3hA3FY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=WxD3+sreOn4tOZJUYuLLAgSRg/MwwPli3LtiMK0ry2YdoiE+3Lp0TwuUYwh5UAHyb
         sHdfuemC5xIMhxeisRazRu5PTifCjL3SMjptpgKUxKvpps+iQJB7aoXktbL99DUalY
         hwvHAYN/+MT8DcyqWeXGgBWGZeoKg2oTcl+I6s5mM7BeDXmZmAZnZ1EzcbBr6PIG98
         bxC/vo/H4mV8/QpY2zv05fauDVlq67dJZBS15MgcsdNmVFKy7q8nmAoPGgZZH1OUKD
         Us/yEiFTnjQ8p7mCs4nBdnQibdVhJmX3aVaZC+5V6qW2qiJ+eZY4Hyyag0wCexORiP
         ccWVUb+ZxxIpQ==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] tracing: Have existing event_command implementations use helpers
Date:   Tue, 23 Nov 2021 14:53:54 -0600
Message-Id: <2b451d62e0b1a12fc99391dfdda9be2d8e9ca499.1637700535.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1637700535.git.zanussi@kernel.org>
References: <cover.1637700535.git.zanussi@kernel.org>
In-Reply-To: <cover.1637700535.git.zanussi@kernel.org>
References: <cover.1637700535.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the existing event_command implementations by making use of
the helper functions previously introduced.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_hist.c    |  51 +++------
 kernel/trace/trace_events_trigger.c | 159 +++++++---------------------
 2 files changed, 55 insertions(+), 155 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8ff572a31fd3..b7dbbafbe8c7 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6128,10 +6128,11 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	struct hist_trigger_attrs *attrs;
 	struct event_trigger_ops *trigger_ops;
 	struct hist_trigger_data *hist_data;
+	char *trigger, *p, *start;
 	struct synth_event *se;
 	const char *se_name;
-	bool remove = false;
-	char *trigger, *p, *start;
+	int n_registered;
+	bool remove;
 	int ret = 0;
 
 	lockdep_assert_held(&event_mutex);
@@ -6141,11 +6142,10 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 		last_cmd_set(file, param);
 	}
 
-	if (!param)
-		return -EINVAL;
+	remove = event_trigger_check_remove(glob);
 
-	if (glob[0] == '!')
-		remove = true;
+	if (event_trigger_empty_param(param))
+		return -EINVAL;
 
 	/*
 	 * separate the trigger from the filter (k:v [if filter])
@@ -6202,29 +6202,15 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 		return PTR_ERR(hist_data);
 	}
 
-	trigger_ops = cmd_ops->get_trigger_ops(cmd, trigger);
-
-	trigger_data = kzalloc(sizeof(*trigger_data), GFP_KERNEL);
+	trigger_data = event_trigger_alloc(cmd_ops, cmd, trigger, hist_data);
 	if (!trigger_data) {
 		ret = -ENOMEM;
 		goto out_free;
 	}
 
-	trigger_data->count = -1;
-	trigger_data->ops = trigger_ops;
-	trigger_data->cmd_ops = cmd_ops;
-
-	INIT_LIST_HEAD(&trigger_data->list);
-	RCU_INIT_POINTER(trigger_data->filter, NULL);
-
-	trigger_data->private_data = hist_data;
-
-	/* if param is non-empty, it's supposed to be a filter */
-	if (param && cmd_ops->set_filter) {
-		ret = cmd_ops->set_filter(param, trigger_data, file);
-		if (ret < 0)
-			goto out_free;
-	}
+	ret = event_trigger_set_filter(cmd_ops, file, param, trigger_data);
+	if (ret < 0)
+		goto out_free;
 
 	if (remove) {
 		if (!have_hist_trigger_match(trigger_data, file))
@@ -6244,18 +6230,14 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 		goto out_free;
 	}
 
-	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
-	/*
-	 * The above returns on success the # of triggers registered,
-	 * but if it didn't register any it returns zero.  Consider no
-	 * triggers registered a failure too.
-	 */
-	if (!ret) {
+	ret = event_trigger_register(cmd_ops, file, glob, cmd, trigger, trigger_data, &n_registered);
+	if (ret)
+		goto out_free;
+	if ((ret == 0) && (n_registered == 0)) {
 		if (!(attrs->pause || attrs->cont || attrs->clear))
 			ret = -ENOENT;
 		goto out_free;
-	} else if (ret < 0)
-		goto out_free;
+	}
 
 	if (get_named_trigger_data(trigger_data))
 		goto enable;
@@ -6289,8 +6271,7 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
  out_unreg:
 	cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
  out_free:
-	if (cmd_ops->set_filter)
-		cmd_ops->set_filter(NULL, trigger_data, NULL);
+	event_trigger_reset_filter(cmd_ops, trigger_data);
 
 	remove_hist_vars(hist_data);
 
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index a873f4e8be04..1d1716d5bee2 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -931,89 +931,47 @@ event_trigger_callback(struct event_command *cmd_ops,
 	struct event_trigger_data *trigger_data;
 	struct event_trigger_ops *trigger_ops;
 	char *trigger = NULL;
-	char *number;
+	bool remove;
 	int ret;
 
-	/* separate the trigger from the filter (t:n [if filter]) */
-	if (param && isdigit(param[0])) {
-		trigger = strsep(&param, " \t");
-		if (param) {
-			param = skip_spaces(param);
-			if (!*param)
-				param = NULL;
-		}
-	}
+	remove = event_trigger_check_remove(glob);
 
-	trigger_ops = cmd_ops->get_trigger_ops(cmd, trigger);
+	ret = event_trigger_separate_filter(&trigger, &param, false);
+	if (ret)
+		return ret;
 
 	ret = -ENOMEM;
-	trigger_data = kzalloc(sizeof(*trigger_data), GFP_KERNEL);
+	trigger_data = event_trigger_alloc(cmd_ops, cmd, trigger, file);
 	if (!trigger_data)
 		goto out;
 
-	trigger_data->count = -1;
-	trigger_data->ops = trigger_ops;
-	trigger_data->cmd_ops = cmd_ops;
-	trigger_data->private_data = file;
-	INIT_LIST_HEAD(&trigger_data->list);
-	INIT_LIST_HEAD(&trigger_data->named_list);
-
-	if (glob[0] == '!') {
+	if (remove) {
 		cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
-		kfree(trigger_data);
 		ret = 0;
 		goto out;
 	}
 
-	if (trigger) {
-		number = strsep(&trigger, ":");
-
-		ret = -EINVAL;
-		if (!strlen(number))
-			goto out_free;
-
-		/*
-		 * We use the callback data field (which is a pointer)
-		 * as our counter.
-		 */
-		ret = kstrtoul(number, 0, &trigger_data->count);
-		if (ret)
-			goto out_free;
-	}
-
-	if (!param) /* if param is non-empty, it's supposed to be a filter */
-		goto out_reg;
-
-	if (!cmd_ops->set_filter)
-		goto out_reg;
+	ret = event_trigger_parse_num(trigger, trigger_data);
+	if (ret)
+		goto out_free;
 
-	ret = cmd_ops->set_filter(param, trigger_data, file);
+	ret = event_trigger_set_filter(cmd_ops, file, param, trigger_data);
 	if (ret < 0)
 		goto out_free;
 
- out_reg:
 	/* Up the trigger_data count to make sure reg doesn't free it on failure */
 	event_trigger_init(trigger_ops, trigger_data);
-	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
-	/*
-	 * The above returns on success the # of functions enabled,
-	 * but if it didn't find any functions it returns zero.
-	 * Consider no functions a failure too.
-	 */
-	if (!ret) {
-		cmd_ops->unreg(glob, trigger_ops, trigger_data, file);
-		ret = -ENOENT;
-	} else if (ret > 0)
-		ret = 0;
+
+	ret = event_trigger_register(cmd_ops, file, glob, cmd, trigger, trigger_data, NULL);
+	if (ret)
+		goto out_free;
 
 	/* Down the counter of trigger_data or free it if not used anymore */
 	event_trigger_free(trigger_ops, trigger_data);
  out:
 	return ret;
-
  out_free:
-	if (cmd_ops->set_filter)
-		cmd_ops->set_filter(NULL, trigger_data, NULL);
+	event_trigger_reset_filter(cmd_ops, trigger_data);
 	kfree(trigger_data);
 	goto out;
 }
@@ -1675,26 +1633,21 @@ int event_enable_trigger_func(struct event_command *cmd_ops,
 	struct event_trigger_data *trigger_data;
 	struct event_trigger_ops *trigger_ops;
 	struct trace_array *tr = file->tr;
+	bool enable, remove;
 	const char *system;
 	const char *event;
 	bool hist = false;
 	char *trigger;
-	char *number;
-	bool enable;
 	int ret;
 
-	if (!param)
-		return -EINVAL;
+	remove = event_trigger_check_remove(glob);
 
-	/* separate the trigger from the filter (s:e:n [if filter]) */
-	trigger = strsep(&param, " \t");
-	if (!trigger)
+	if (event_trigger_empty_param(param))
 		return -EINVAL;
-	if (param) {
-		param = skip_spaces(param);
-		if (!*param)
-			param = NULL;
-	}
+
+	ret = event_trigger_separate_filter(&trigger, &param, true);
+	if (ret)
+		return ret;
 
 	system = strsep(&trigger, ":");
 	if (!trigger)
@@ -1719,28 +1672,23 @@ int event_enable_trigger_func(struct event_command *cmd_ops,
 	trigger_ops = cmd_ops->get_trigger_ops(cmd, trigger);
 
 	ret = -ENOMEM;
-	trigger_data = kzalloc(sizeof(*trigger_data), GFP_KERNEL);
-	if (!trigger_data)
-		goto out;
-
 	enable_data = kzalloc(sizeof(*enable_data), GFP_KERNEL);
 	if (!enable_data) {
 		kfree(trigger_data);
 		goto out;
 	}
 
-	trigger_data->count = -1;
-	trigger_data->ops = trigger_ops;
-	trigger_data->cmd_ops = cmd_ops;
-	INIT_LIST_HEAD(&trigger_data->list);
-	RCU_INIT_POINTER(trigger_data->filter, NULL);
-
 	enable_data->hist = hist;
 	enable_data->enable = enable;
 	enable_data->file = event_enable_file;
-	trigger_data->private_data = enable_data;
 
-	if (glob[0] == '!') {
+	trigger_data = event_trigger_alloc(cmd_ops, cmd, trigger, enable_data);
+	if (!trigger_data) {
+		kfree(enable_data);
+		goto out;
+	}
+
+	if (remove) {
 		cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
 		kfree(trigger_data);
 		kfree(enable_data);
@@ -1751,33 +1699,14 @@ int event_enable_trigger_func(struct event_command *cmd_ops,
 	/* Up the trigger_data count to make sure nothing frees it on failure */
 	event_trigger_init(trigger_ops, trigger_data);
 
-	if (trigger) {
-		number = strsep(&trigger, ":");
-
-		ret = -EINVAL;
-		if (!strlen(number))
-			goto out_free;
-
-		/*
-		 * We use the callback data field (which is a pointer)
-		 * as our counter.
-		 */
-		ret = kstrtoul(number, 0, &trigger_data->count);
-		if (ret)
-			goto out_free;
-	}
-
-	if (!param) /* if param is non-empty, it's supposed to be a filter */
-		goto out_reg;
-
-	if (!cmd_ops->set_filter)
-		goto out_reg;
+	ret = event_trigger_parse_num(trigger, trigger_data);
+	if (ret)
+		goto out_free;
 
-	ret = cmd_ops->set_filter(param, trigger_data, file);
+	ret = event_trigger_set_filter(cmd_ops, file, param, trigger_data);
 	if (ret < 0)
 		goto out_free;
 
- out_reg:
 	/* Don't let event modules unload while probe registered */
 	ret = trace_event_try_get_ref(event_enable_file->event_call);
 	if (!ret) {
@@ -1788,30 +1717,20 @@ int event_enable_trigger_func(struct event_command *cmd_ops,
 	ret = trace_event_enable_disable(event_enable_file, 1, 1);
 	if (ret < 0)
 		goto out_put;
-	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
-	/*
-	 * The above returns on success the # of functions enabled,
-	 * but if it didn't find any functions it returns zero.
-	 * Consider no functions a failure too.
-	 */
-	if (!ret) {
-		ret = -ENOENT;
-		goto out_disable;
-	} else if (ret < 0)
+
+	ret = event_trigger_register(cmd_ops, file, glob, cmd, trigger, trigger_data, NULL);
+	if (ret)
 		goto out_disable;
-	/* Just return zero, not the number of enabled functions */
-	ret = 0;
+
 	event_trigger_free(trigger_ops, trigger_data);
  out:
 	return ret;
-
  out_disable:
 	trace_event_enable_disable(event_enable_file, 0, 1);
  out_put:
 	trace_event_put_ref(event_enable_file->event_call);
  out_free:
-	if (cmd_ops->set_filter)
-		cmd_ops->set_filter(NULL, trigger_data, NULL);
+	event_trigger_reset_filter(cmd_ops, trigger_data);
 	event_trigger_free(trigger_ops, trigger_data);
 	kfree(enable_data);
 	goto out;
-- 
2.17.1

