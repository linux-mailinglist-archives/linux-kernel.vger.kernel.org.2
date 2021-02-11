Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C49731837E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 03:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhBKCNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 21:13:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:49764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230026AbhBKCLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 21:11:15 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15EF564EC5;
        Thu, 11 Feb 2021 02:09:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lA1QU-00BAY7-2Q; Wed, 10 Feb 2021 21:09:50 -0500
Message-ID: <20210211020949.960507233@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Feb 2021 21:09:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 10/12] tracing: Add a backward-compatibility check for synthetic event
 creation
References: <20210211020927.829775774@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

The synthetic event parsing rework now requires semicolons between
synthetic event fields.  That requirement breaks existing users who
might already have used the old synthetic event command format, so
this adds an inner loop that can parse more than one field, if
present, between semicolons.  For each field, parse_synth_field()
checks in which version that field was introduced, using
check_field_version().  The caller, __create_synth_event() can then use
that version information to determine whether or not to enforce the
requirement on the command as a whole.

In the future, if/when new features are added, the requirement will be
that any field/string containing the new feature must use semicolons,
and the check_field_version() check can then check for those and
enforce it.  Using a version number allows this scheme to be extended
if necessary.

Link: https://lkml.kernel.org/r/74fcc500d561b40ce91c5ee94818c70c6b0c9330.1612208610.git.zanussi@kernel.org

[ zanussi: added check_field_version() comment from rostedt@goodmis.org ]
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 93 ++++++++++++++++++++++++-------
 1 file changed, 74 insertions(+), 19 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index aace72426e99..2979a96595b4 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -580,11 +580,29 @@ static void free_synth_field(struct synth_field *field)
 	kfree(field);
 }
 
-static struct synth_field *parse_synth_field(int argc, char **argv)
+static int check_field_version(const char *prefix, const char *field_type,
+			       const char *field_name)
+{
+	/*
+	 * For backward compatibility, the old synthetic event command
+	 * format did not require semicolons, and in order to not
+	 * break user space, that old format must still work. If a new
+	 * feature is added, then the format that uses the new feature
+	 * will be required to have semicolons, as nothing that uses
+	 * the old format would be using the new, yet to be created,
+	 * feature. When a new feature is added, this will detect it,
+	 * and return a number greater than 1, and require the format
+	 * to use semicolons.
+	 */
+	return 1;
+}
+
+static struct synth_field *parse_synth_field(int argc, char **argv,
+					     int *consumed, int *field_version)
 {
 	const char *prefix = NULL, *field_type = argv[0], *field_name, *array;
-	int len, consumed, ret = -ENOMEM;
 	struct synth_field *field;
+	int len, ret = -ENOMEM;
 	struct seq_buf s;
 	ssize_t size;
 
@@ -596,15 +614,10 @@ static struct synth_field *parse_synth_field(int argc, char **argv)
 		prefix = "unsigned ";
 		field_type = argv[1];
 		field_name = argv[2];
-		consumed = 3;
+		*consumed += 3;
 	} else {
 		field_name = argv[1];
-		consumed = 2;
-	}
-
-	if (consumed < argc) {
-		synth_err(SYNTH_ERR_INVALID_FIELD, errpos(field_type));
-		return ERR_PTR(-EINVAL);
+		*consumed += 2;
 	}
 
 	if (!field_name) {
@@ -612,6 +625,8 @@ static struct synth_field *parse_synth_field(int argc, char **argv)
 		return ERR_PTR(-EINVAL);
 	}
 
+	*field_version = check_field_version(prefix, field_type, field_name);
+
 	field = kzalloc(sizeof(*field), GFP_KERNEL);
 	if (!field)
 		return ERR_PTR(-ENOMEM);
@@ -1167,6 +1182,7 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 {
 	char **argv, *field_str, *tmp_fields, *saved_fields = NULL;
 	struct synth_field *field, *fields[SYNTH_FIELDS_MAX];
+	int consumed, cmd_version = 1, n_fields_this_loop;
 	int i, argc, n_fields = 0, ret = 0;
 	struct synth_event *event = NULL;
 
@@ -1212,21 +1228,60 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 		if (!argc)
 			continue;
 
-		field = parse_synth_field(argc, argv);
-		if (IS_ERR(field)) {
-			argv_free(argv);
-			ret = PTR_ERR(field);
-			goto err;
-		}
+		n_fields_this_loop = 0;
+		consumed = 0;
+		while (argc > consumed) {
+			int field_version;
+
+			field = parse_synth_field(argc - consumed,
+						  argv + consumed, &consumed,
+						  &field_version);
+			if (IS_ERR(field)) {
+				argv_free(argv);
+				ret = PTR_ERR(field);
+				goto err;
+			}
 
-		argv_free(argv);
+			/*
+			 * Track the highest version of any field we
+			 * found in the command.
+			 */
+			if (field_version > cmd_version)
+				cmd_version = field_version;
+
+			/*
+			 * Now sort out what is and isn't valid for
+			 * each supported version.
+			 *
+			 * If we see more than 1 field per loop, it
+			 * means we have multiple fields between
+			 * semicolons, and that's something we no
+			 * longer support in a version 2 or greater
+			 * command.
+			 */
+			if (cmd_version > 1 && n_fields_this_loop >= 1) {
+				synth_err(SYNTH_ERR_INVALID_CMD, errpos(field_str));
+				ret = -EINVAL;
+				goto err;
+			}
+
+			fields[n_fields++] = field;
+			if (n_fields == SYNTH_FIELDS_MAX) {
+				synth_err(SYNTH_ERR_TOO_MANY_FIELDS, 0);
+				ret = -EINVAL;
+				goto err;
+			}
+
+			n_fields_this_loop++;
+		}
 
-		fields[n_fields++] = field;
-		if (n_fields == SYNTH_FIELDS_MAX) {
-			synth_err(SYNTH_ERR_TOO_MANY_FIELDS, 0);
+		if (consumed < argc) {
+			synth_err(SYNTH_ERR_INVALID_CMD, 0);
 			ret = -EINVAL;
 			goto err;
 		}
+
+		argv_free(argv);
 	}
 
 	if (n_fields == 0) {
-- 
2.29.2


