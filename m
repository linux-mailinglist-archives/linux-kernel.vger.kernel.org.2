Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E927845024C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 11:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbhKOKYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 05:24:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:52012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237676AbhKOKXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:23:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C06DD630EF;
        Mon, 15 Nov 2021 10:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636971640;
        bh=bvXo0AO8b4BBIsPwxT/e9JaGg6ch4gHq95KUBuGBsYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NGUJ1obAMsR1Tw0bs5WI74v8WRRaiXRbNy+brH/viR5wK7V5pDWwoDFJlHMH4ynU5
         3S8WCRhwaA48pG9sZEnU6pklZCuGfYCsi5bJOvewiQydkCVofIi+HB8K/n4PempLWr
         gyONd0DuzGoCgghj3cVZspDZa3/cB3UaobGifa5hQ9o44rZozCKcveNI6shtS3aZWS
         mqxCYCaH0rj1YDjTlVTFB/+lxrULv49/+KQUcUYlqgHiUwVl8HPALdn0U6cRSHd4V7
         OcYkbGKdrRvhrtAwb2fCR/xmQdDRGe+XU0R+cOYWq8u9uHcl/ayIsNy39bXRFAh9eb
         83lA1o8Hhs/ug==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 4/5] libtraceevent: Add __rel_loc relative location attribute support
Date:   Mon, 15 Nov 2021 19:20:36 +0900
Message-Id: <163697163637.131454.1385316505107139633.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163697159970.131454.2661507704362599471.stgit@devnote2>
References: <163697159970.131454.2661507704362599471.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add '__rel_loc' new dynamic data location attribute which encodes
the data location from the next to the field itself. This is similar
to the '__data_loc' but the location offset is not from the event
entry but from the next of the field.

This patch adds '__rel_loc' decoding support in the libtraceevent.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/lib/traceevent/event-parse.c  |   14 ++++++++++++++
 tools/lib/traceevent/event-parse.h  |    1 +
 tools/lib/traceevent/parse-filter.c |    5 ++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index fe58843d047c..170d2c9aa522 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -1367,6 +1367,14 @@ static int field_is_dynamic(struct tep_format_field *field)
 	return 0;
 }
 
+static int field_is_relative_dynamic(struct tep_format_field *field)
+{
+	if (strncmp(field->type, "__rel_loc", 9) == 0)
+		return 1;
+
+	return 0;
+}
+
 static int field_is_long(struct tep_format_field *field)
 {
 	/* includes long long */
@@ -1622,6 +1630,8 @@ static int event_read_fields(struct tep_event *event, struct tep_format_field **
 			field->flags |= TEP_FIELD_IS_STRING;
 		if (field_is_dynamic(field))
 			field->flags |= TEP_FIELD_IS_DYNAMIC;
+		if (field_is_relative_dynamic(field))
+			field->flags |= TEP_FIELD_IS_DYNAMIC|TEP_FIELD_IS_REL_DYNAMIC;
 		if (field_is_long(field))
 			field->flags |= TEP_FIELD_IS_LONG;
 
@@ -5109,6 +5119,8 @@ void tep_print_field(struct trace_seq *s, void *data,
 			offset = val;
 			len = offset >> 16;
 			offset &= 0xffff;
+			if (field->flags & TEP_FIELD_IS_REL_DYNAMIC)
+				offset += field->offset + field->size;
 		}
 		if (field->flags & TEP_FIELD_IS_STRING &&
 		    is_printable_array(data + offset, len)) {
@@ -6987,6 +6999,8 @@ void *tep_get_field_raw(struct trace_seq *s, struct tep_event *event,
 					 data + offset, field->size);
 		*len = offset >> 16;
 		offset &= 0xffff;
+		if (field->flags & TEP_FIELD_IS_REL_DYNAMIC)
+			offset += field->offset + field->size;
 	} else
 		*len = field->size;
 
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index a67ad9a5b835..c4138eb72605 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -125,6 +125,7 @@ enum tep_format_flags {
 	TEP_FIELD_IS_LONG	= 32,
 	TEP_FIELD_IS_FLAG	= 64,
 	TEP_FIELD_IS_SYMBOLIC	= 128,
+	TEP_FIELD_IS_REL_DYNAMIC = 256,
 };
 
 struct tep_format_field {
diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
index 368826bb5a57..9fcee7012df4 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -1712,8 +1712,11 @@ static const char *get_field_str(struct tep_filter_arg *arg, struct tep_record *
 
 		if (arg->str.field->flags & TEP_FIELD_IS_DYNAMIC) {
 			addr = *(unsigned int *)val;
-			val = record->data + (addr & 0xffff);
 			size = addr >> 16;
+			addr &= 0xffff;
+			if (arg->str.field->flags & TEP_FIELD_IS_REL_DYNAMIC)
+				addr += arg->str.field->offset + arg->str.field->size;
+			val = record->data + addr;
 		}
 
 		/*

