Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570C030B0C9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhBATud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:50:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:54644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232604AbhBATtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:49:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE34C64EC5;
        Mon,  1 Feb 2021 19:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612208905;
        bh=w+jT0Bq7SyeL2HAlCH1/Ffjc/Lwy2+bprwnBmFcSX5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=mMz4lcIMk8PSgFAVIWYNyWiiPnv22sEGbuDKRZntstrXDppA5iMKinT4C3Xbl6qmv
         rSu2P/5Fy3V5C6tLNGkmJq3SXnx17Bsg/htO7vw+CffYHxpTKAV/RvGJyZG9zcwfBZ
         +a77X4kemLqxfLq1JFuF7R/56QS1WWm6YMQj66vaSxR0q0LF+VjpwueL+yPo4dHwCW
         nPvPUX682kstdDdHHNvwkIXFsKJAvumXCygOBUx2lU2uXKBWfaagyAL7sXzJgNWALI
         M8GOqDwWaXlSfI3vieoxrYmydbIoyJLBMjllGkKT9c69nfZaWZ4k+J+92kxWRhEry+
         H0+HjBlmWeIlQ==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/6] tracing: Update synth command errors
Date:   Mon,  1 Feb 2021 13:48:13 -0600
Message-Id: <b9dd434dc6458dcff11adc6ed616fe93a8794770.1612208610.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1612208610.git.zanussi@kernel.org>
References: <cover.1612208610.git.zanussi@kernel.org>
In-Reply-To: <cover.1612208610.git.zanussi@kernel.org>
References: <cover.1612208610.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since array types are handled differently, errors referencing them
also need to be handled differently.  Add and use a new
INVALID_ARRAY_SPEC error.  Also add INVALID_CMD and INVALID_DYN_CMD to
catch and display the correct form for badly-formed commands, which
can also be used in place of CMD_INCOMPLETE, which is removed, and
remove CMD_TOO_LONG, since it's no longer used.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
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
2.17.1

