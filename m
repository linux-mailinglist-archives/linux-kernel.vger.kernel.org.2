Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EC431837B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 03:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhBKCMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 21:12:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:49756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230000AbhBKCLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 21:11:14 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB3A364EC7;
        Thu, 11 Feb 2021 02:09:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lA1QT-00BAX8-OB; Wed, 10 Feb 2021 21:09:49 -0500
Message-ID: <20210211020949.591519859@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Feb 2021 21:09:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 08/12] tracing: Rework synthetic event command parsing
References: <20210211020927.829775774@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Now that command parsing has been delegated to the create functions
and we're no longer constrained by argv_split(), we can modify the
synthetic event command parser to better match the higher-level
structure of the synthetic event commands, which is basically an event
name followed by a set of semicolon-separated fields.

Since we're also now passed the raw command, we can also save it
directly and can get rid of save_cmdstr().

Link: https://lkml.kernel.org/r/cb9e2be92d992ce59f2b4f132264a5d467f3933f.1612208610.git.zanussi@kernel.org

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 245 +++++++++++++++++-------------
 1 file changed, 143 insertions(+), 102 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index b2588a5650c9..4f6c5a104ee2 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -48,7 +48,7 @@ static int errpos(const char *str)
 	return err_pos(last_cmd, str);
 }
 
-static void last_cmd_set(char *str)
+static void last_cmd_set(const char *str)
 {
 	if (!str)
 		return;
@@ -579,18 +579,14 @@ static void free_synth_field(struct synth_field *field)
 	kfree(field);
 }
 
-static struct synth_field *parse_synth_field(int argc, const char **argv,
-					     int *consumed)
+static struct synth_field *parse_synth_field(int argc, char **argv)
 {
-	struct synth_field *field;
 	const char *prefix = NULL, *field_type = argv[0], *field_name, *array;
-	int len, ret = -ENOMEM;
+	int len, consumed, ret = -ENOMEM;
+	struct synth_field *field;
 	struct seq_buf s;
 	ssize_t size;
 
-	if (field_type[0] == ';')
-		field_type++;
-
 	if (!strcmp(field_type, "unsigned")) {
 		if (argc < 3) {
 			synth_err(SYNTH_ERR_INCOMPLETE_TYPE, errpos(field_type));
@@ -599,10 +595,20 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 		prefix = "unsigned ";
 		field_type = argv[1];
 		field_name = argv[2];
-		*consumed = 3;
+		consumed = 3;
 	} else {
 		field_name = argv[1];
-		*consumed = 2;
+		consumed = 2;
+	}
+
+	if (consumed < argc) {
+		synth_err(SYNTH_ERR_INVALID_FIELD, errpos(field_type));
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (!field_name) {
+		synth_err(SYNTH_ERR_INVALID_FIELD, errpos(field_type));
+		return ERR_PTR(-EINVAL);
 	}
 
 	field = kzalloc(sizeof(*field), GFP_KERNEL);
@@ -613,8 +619,6 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 	array = strchr(field_name, '[');
 	if (array)
 		len -= strlen(array);
-	else if (field_name[len - 1] == ';')
-		len--;
 
 	field->name = kmemdup_nul(field_name, len, GFP_KERNEL);
 	if (!field->name)
@@ -626,8 +630,6 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 		goto free;
 	}
 
-	if (field_type[0] == ';')
-		field_type++;
 	len = strlen(field_type) + 1;
 
 	if (array)
@@ -644,11 +646,8 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 	if (prefix)
 		seq_buf_puts(&s, prefix);
 	seq_buf_puts(&s, field_type);
-	if (array) {
+	if (array)
 		seq_buf_puts(&s, array);
-		if (s.buffer[s.len - 1] == ';')
-			s.len--;
-	}
 	if (WARN_ON_ONCE(!seq_buf_buffer_left(&s)))
 		goto free;
 
@@ -1160,46 +1159,12 @@ int synth_event_gen_cmd_array_start(struct dynevent_cmd *cmd, const char *name,
 }
 EXPORT_SYMBOL_GPL(synth_event_gen_cmd_array_start);
 
-static int save_cmdstr(int argc, const char *name, const char **argv)
-{
-	struct seq_buf s;
-	char *buf;
-	int i;
-
-	buf = kzalloc(MAX_DYNEVENT_CMD_LEN, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	seq_buf_init(&s, buf, MAX_DYNEVENT_CMD_LEN);
-
-	seq_buf_puts(&s, name);
-
-	for (i = 0; i < argc; i++) {
-		seq_buf_putc(&s, ' ');
-		seq_buf_puts(&s, argv[i]);
-	}
-
-	if (!seq_buf_buffer_left(&s)) {
-		synth_err(SYNTH_ERR_CMD_TOO_LONG, 0);
-		kfree(buf);
-		return -EINVAL;
-	}
-	buf[s.len] = 0;
-	last_cmd_set(buf);
-
-	kfree(buf);
-	return 0;
-}
-
-static int __create_synth_event(int argc, const char *name, const char **argv)
+static int __create_synth_event(const char *name, const char *raw_fields)
 {
+	char **argv, *field_str, *tmp_fields, *saved_fields = NULL;
 	struct synth_field *field, *fields[SYNTH_FIELDS_MAX];
+	int i, argc, n_fields = 0, ret = 0;
 	struct synth_event *event = NULL;
-	int i, consumed = 0, n_fields = 0, ret = 0;
-
-	ret = save_cmdstr(argc, name, argv);
-	if (ret)
-		return ret;
 
 	/*
 	 * Argument syntax:
@@ -1208,46 +1173,60 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
 	 *      where 'field' = type field_name
 	 */
 
-	if (name[0] == '\0' || argc < 1) {
+	if (name[0] == '\0') {
 		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
 		return -EINVAL;
 	}
 
-	mutex_lock(&event_mutex);
-
 	if (!is_good_name(name)) {
 		synth_err(SYNTH_ERR_BAD_NAME, errpos(name));
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
+	mutex_lock(&event_mutex);
+
 	event = find_synth_event(name);
 	if (event) {
 		synth_err(SYNTH_ERR_EVENT_EXISTS, errpos(name));
 		ret = -EEXIST;
-		goto out;
+		goto err;
 	}
 
-	for (i = 0; i < argc - 1; i++) {
-		if (strcmp(argv[i], ";") == 0)
-			continue;
-		if (n_fields == SYNTH_FIELDS_MAX) {
-			synth_err(SYNTH_ERR_TOO_MANY_FIELDS, 0);
-			ret = -EINVAL;
+	tmp_fields = saved_fields = kstrdup(raw_fields, GFP_KERNEL);
+	if (!tmp_fields) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	while ((field_str = strsep(&tmp_fields, ";")) != NULL) {
+		argv = argv_split(GFP_KERNEL, field_str, &argc);
+		if (!argv) {
+			ret = -ENOMEM;
 			goto err;
 		}
 
-		field = parse_synth_field(argc - i, &argv[i], &consumed);
+		if (!argc)
+			continue;
+
+		field = parse_synth_field(argc, argv);
 		if (IS_ERR(field)) {
+			argv_free(argv);
 			ret = PTR_ERR(field);
 			goto err;
 		}
+
+		argv_free(argv);
+
 		fields[n_fields++] = field;
-		i += consumed - 1;
+		if (n_fields == SYNTH_FIELDS_MAX) {
+			synth_err(SYNTH_ERR_TOO_MANY_FIELDS, 0);
+			ret = -EINVAL;
+			goto err;
+		}
 	}
 
-	if (i < argc && strcmp(argv[i], ";") != 0) {
-		synth_err(SYNTH_ERR_INVALID_FIELD, errpos(argv[i]));
+	if (n_fields == 0) {
+		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
 		ret = -EINVAL;
 		goto err;
 	}
@@ -1266,6 +1245,8 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
  out:
 	mutex_unlock(&event_mutex);
 
+	kfree(saved_fields);
+
 	return ret;
  err:
 	for (i = 0; i < n_fields; i++)
@@ -1383,31 +1364,79 @@ int synth_event_delete(const char *event_name)
 }
 EXPORT_SYMBOL_GPL(synth_event_delete);
 
-static int create_or_delete_synth_event(const char *raw_command)
+static int check_command(const char *raw_command)
 {
-	char **argv, *name = NULL;
-	int argc = 0, ret = 0;
+	char **argv = NULL, *cmd, *saved_cmd, *name_and_field;
+	int argc, ret = 0;
 
-	argv = argv_split(GFP_KERNEL, raw_command, &argc);
-	if (!argv)
+	cmd = saved_cmd = kstrdup(raw_command, GFP_KERNEL);
+	if (!cmd)
 		return -ENOMEM;
 
-	if (!argc)
+	name_and_field = strsep(&cmd, ";");
+	if (!name_and_field) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	if (name_and_field[0] == '!')
+		goto free;
+
+	argv = argv_split(GFP_KERNEL, name_and_field, &argc);
+	if (!argv) {
+		ret = -ENOMEM;
 		goto free;
+	}
+	argv_free(argv);
+
+	if (argc < 3)
+		ret = -EINVAL;
+free:
+	kfree(saved_cmd);
 
-	name = argv[0];
+	return ret;
+}
+
+static int create_or_delete_synth_event(const char *raw_command)
+{
+	char *name = NULL, *fields, *p;
+	int ret = 0;
+
+	raw_command = skip_spaces(raw_command);
+	if (raw_command[0] == '\0')
+		return ret;
+
+	last_cmd_set(raw_command);
+
+	ret = check_command(raw_command);
+	if (ret) {
+		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
+		return ret;
+	}
+
+	p = strpbrk(raw_command, " \t");
+	if (!p && raw_command[0] != '!') {
+		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
+		ret = -EINVAL;
+		goto free;
+	}
+
+	name = kmemdup_nul(raw_command, p ? p - raw_command : strlen(raw_command), GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
 
-	/* trace_run_command() ensures argc != 0 */
 	if (name[0] == '!') {
 		ret = synth_event_delete(name + 1);
 		goto free;
 	}
 
-	ret = __create_synth_event(argc - 1, name, (const char **)argv + 1);
+	fields = skip_spaces(p);
+
+	ret = __create_synth_event(name, fields);
 free:
-	argv_free(argv);
+	kfree(name);
 
-	return ret == -ECANCELED ? -EINVAL : ret;
+	return ret;
 }
 
 static int synth_event_run_command(struct dynevent_cmd *cmd)
@@ -1953,39 +1982,51 @@ EXPORT_SYMBOL_GPL(synth_event_trace_end);
 
 static int create_synth_event(const char *raw_command)
 {
-	char **argv, *name;
-	int len, argc = 0, ret = 0;
+	char *fields, *p;
+	const char *name;
+	int len, ret = 0;
 
-	argv = argv_split(GFP_KERNEL, raw_command, &argc);
-	if (!argv) {
-		ret = -ENOMEM;
+	raw_command = skip_spaces(raw_command);
+	if (raw_command[0] == '\0')
 		return ret;
-	}
 
-	if (!argc)
-		goto free;
+	last_cmd_set(raw_command);
 
-	name = argv[0];
+	p = strpbrk(raw_command, " \t");
+	if (!p)
+		return -EINVAL;
 
-	if (name[0] != 's' || name[1] != ':') {
-		ret = -ECANCELED;
-		goto free;
-	}
+	fields = skip_spaces(p);
+
+	name = raw_command;
+
+	if (name[0] != 's' || name[1] != ':')
+		return -ECANCELED;
 	name += 2;
 
 	/* This interface accepts group name prefix */
 	if (strchr(name, '/')) {
 		len = str_has_prefix(name, SYNTH_SYSTEM "/");
-		if (len == 0) {
-			ret = -EINVAL;
-			goto free;
-		}
+		if (len == 0)
+			return -EINVAL;
 		name += len;
 	}
 
-	ret = __create_synth_event(argc - 1, name, (const char **)argv + 1);
-free:
-	argv_free(argv);
+	len = name - raw_command;
+
+	ret = check_command(raw_command + len);
+	if (ret) {
+		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
+		return ret;
+	}
+
+	name = kmemdup_nul(raw_command + len, p - raw_command - len, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+
+	ret = __create_synth_event(name, fields);
+
+	kfree(name);
 
 	return ret;
 }
-- 
2.29.2


