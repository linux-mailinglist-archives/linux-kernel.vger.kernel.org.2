Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF6531837F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 03:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhBKCNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 21:13:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:49762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230014AbhBKCLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 21:11:17 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC1AE64ED4;
        Thu, 11 Feb 2021 02:09:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lA1QT-00BAXd-UC; Wed, 10 Feb 2021 21:09:49 -0500
Message-ID: <20210211020949.780243101@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Feb 2021 21:09:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 09/12] tracing: Update synth command errors
References: <20210211020927.829775774@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Since array types are handled differently, errors referencing them
also need to be handled differently.  Add and use a new
INVALID_ARRAY_SPEC error.  Also add INVALID_CMD and INVALID_DYN_CMD to
catch and display the correct form for badly-formed commands, which
can also be used in place of CMD_INCOMPLETE, which is removed, and
remove CMD_TOO_LONG, since it's no longer used.

Link: https://lkml.kernel.org/r/b9dd434dc6458dcff11adc6ed616fe93a8794770.1612208610.git.zanussi@kernel.org

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 4f6c5a104ee2..aace72426e99 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -23,13 +23,14 @@
 #undef ERRORS
 #define ERRORS	\
 	C(BAD_NAME,		"Illegal name"),		\
-	C(CMD_INCOMPLETE,	"Incomplete command"),		\
+	C(INVALID_CMD,		"Command must be of the form: <name> field[;field] ..."),\
+	C(INVALID_DYN_CMD,	"Command must be of the form: s or -:[synthetic/]<name> field[;field] ..."),\
 	C(EVENT_EXISTS,		"Event already exists"),	\
 	C(TOO_MANY_FIELDS,	"Too many fields"),		\
 	C(INCOMPLETE_TYPE,	"Incomplete type"),		\
 	C(INVALID_TYPE,		"Invalid type"),		\
-	C(INVALID_FIELD,	"Invalid field"),		\
-	C(CMD_TOO_LONG,		"Command too long"),
+	C(INVALID_FIELD,        "Invalid field"),		\
+	C(INVALID_ARRAY_SPEC,	"Invalid array specification"),
 
 #undef C
 #define C(a, b)		SYNTH_ERR_##a
@@ -655,7 +656,10 @@ static struct synth_field *parse_synth_field(int argc, char **argv)
 
 	size = synth_field_size(field->type);
 	if (size < 0) {
-		synth_err(SYNTH_ERR_INVALID_TYPE, errpos(field_type));
+		if (array)
+			synth_err(SYNTH_ERR_INVALID_ARRAY_SPEC, errpos(field_name));
+		else
+			synth_err(SYNTH_ERR_INVALID_TYPE, errpos(field_type));
 		ret = -EINVAL;
 		goto free;
 	} else if (size == 0) {
@@ -1174,7 +1178,7 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 	 */
 
 	if (name[0] == '\0') {
-		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
+		synth_err(SYNTH_ERR_INVALID_CMD, 0);
 		return -EINVAL;
 	}
 
@@ -1226,7 +1230,7 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 	}
 
 	if (n_fields == 0) {
-		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
+		synth_err(SYNTH_ERR_INVALID_CMD, 0);
 		ret = -EINVAL;
 		goto err;
 	}
@@ -1410,13 +1414,13 @@ static int create_or_delete_synth_event(const char *raw_command)
 
 	ret = check_command(raw_command);
 	if (ret) {
-		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
+		synth_err(SYNTH_ERR_INVALID_CMD, 0);
 		return ret;
 	}
 
 	p = strpbrk(raw_command, " \t");
 	if (!p && raw_command[0] != '!') {
-		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
+		synth_err(SYNTH_ERR_INVALID_CMD, 0);
 		ret = -EINVAL;
 		goto free;
 	}
@@ -1993,8 +1997,10 @@ static int create_synth_event(const char *raw_command)
 	last_cmd_set(raw_command);
 
 	p = strpbrk(raw_command, " \t");
-	if (!p)
+	if (!p) {
+		synth_err(SYNTH_ERR_INVALID_CMD, 0);
 		return -EINVAL;
+	}
 
 	fields = skip_spaces(p);
 
@@ -2007,8 +2013,10 @@ static int create_synth_event(const char *raw_command)
 	/* This interface accepts group name prefix */
 	if (strchr(name, '/')) {
 		len = str_has_prefix(name, SYNTH_SYSTEM "/");
-		if (len == 0)
+		if (len == 0) {
+			synth_err(SYNTH_ERR_INVALID_DYN_CMD, 0);
 			return -EINVAL;
+		}
 		name += len;
 	}
 
@@ -2016,7 +2024,7 @@ static int create_synth_event(const char *raw_command)
 
 	ret = check_command(raw_command + len);
 	if (ret) {
-		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
+		synth_err(SYNTH_ERR_INVALID_CMD, 0);
 		return ret;
 	}
 
-- 
2.29.2


