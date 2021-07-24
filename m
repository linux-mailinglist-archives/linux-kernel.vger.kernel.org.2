Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6AC3D471B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 12:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbhGXJvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 05:51:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234333AbhGXJvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 05:51:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BEAC60E53;
        Sat, 24 Jul 2021 10:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627122708;
        bh=oweY6g0tMz3+2WXRwdOKI4rJeUgbxYuG9AEckBYmgaY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JRC9qCl1kk1PAsOhqoncvQhEgTG1UIYxVOrBYjUuLljy6dMlB9krZ8H/rtR2K1Lnm
         TutnpwX1fBCgbG0E2svY3MgslTgmKw3iKSqJG+95NSlhZniOJBmR0UQx8FywkNc1pq
         0oOBYuUkUIu4LcHLcf2dc/VxKs7TcaDYIQOI/8u9PxmCOuUnc+QEcHFW5XpSbqKqC+
         VAJ/B8jb2TGdeOvBOz+xXodjM4SDQDtIt9Ww1UVaoOud14gq4dFRv4EU2RZTxJ0Zlr
         23llm6UIjMLIYU1lInkpZ1kWzWnODRo6nJGkM1JBAWcwMSJNgLo+huXZQP489ccyFE
         ZfqX3iWdkZ+AA==
Date:   Sat, 24 Jul 2021 19:31:45 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 2/2] tracing: Allow execnames to be passed as args
 for synthetic events
Message-Id: <20210724193145.c63b44aa843e05ed9c0b4fdc@kernel.org>
In-Reply-To: <20210722212438.5933e714@rorschach.local.home>
References: <20210722142705.992001628@goodmis.org>
        <20210722142837.458596338@goodmis.org>
        <20210723011935.efb25bc4a23ebd567243ed0f@kernel.org>
        <20210722123234.636d5363@oasis.local.home>
        <20210723101133.3378369c618c53f2e71d3e4c@kernel.org>
        <20210722212438.5933e714@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Thu, 22 Jul 2021 21:24:38 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 23 Jul 2021 10:11:33 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > I understand. As far as I can see the code, it looks a bit complicated.
> > To simplify it, I need to understand the spec for "hist_field"
> > for keys and for vars. And maybe need to split both case.
> 
> I'll give you a hint that took me a bit to figure out.
> 
> 1) The execname is saved at the start of the histogram and not by one
> of the ->fn() functions.
> 
> It's saved by hist_trigger_elt_data_init() if the elt_data->comm is
> allocated. That function is part of the "tracing_map_ops" which gets
> assigned by tracing_map_create() (in tracing_map.c) as the "elt_init"
> function, which is called when getting a new elt element by
> get_free_elt().
> 
> 2) That elt_data->comm is only allocated if it finds a "hist_field"
> that has HIST_FIELD_FL_EXECNAME flag set. It currently only looks for
> that flag in the "keys" fields, which means that .execname is useless
> for everything else. This patch changed it to search all hist_fields so
> that it can find that flag if a variable has it set (which I added).

Thanks for the hints, but actually, that part looks good to me.

So, what I pointed was the part of update_var_execname(). Below diff
is what I intended.
This moves HIST_FIELD_FL_EXECNAME setup in the create_hist_field()
as same as other flags, and removed the add-hoc update_var_execname()
fixup function.

I confirmed it passed the ftracetest trigger testcases and your
example code.

Thank you,

---
 kernel/trace/trace_events_hist.c | 69 ++++++++++++++------------------
 1 file changed, 31 insertions(+), 38 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 14b840de1326..2fab91a22628 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -492,6 +492,27 @@ struct snapshot_context {
 	void			*key;
 };
 
+static const char *no_comm = "(no comm)";
+
+static u64 hist_field_execname(struct hist_field *hist_field,
+			       struct tracing_map_elt *elt,
+			       struct trace_buffer *buffer,
+			       struct ring_buffer_event *rbe,
+			       void *event)
+{
+	struct hist_elt_data *elt_data;
+
+	if (WARN_ON_ONCE(!elt))
+		return (u64)(unsigned long)no_comm;
+
+	elt_data = elt->private_data;
+
+	if (WARN_ON_ONCE(!elt_data->comm))
+		return (u64)(unsigned long)no_comm;
+
+	return (u64)(unsigned long)(elt_data->comm);
+}
+
 static void track_data_free(struct track_data *track_data)
 {
 	struct hist_elt_data *elt_data;
@@ -1682,6 +1703,16 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
 		goto out;
 	}
 
+	if ((flags & HIST_FIELD_FL_EXECNAME) && var_name) {
+		flags |= HIST_FIELD_FL_STRING | HIST_FIELD_FL_VAR;
+		hist_field->size = MAX_FILTER_STR_VAL;
+		hist_field->is_signed = 0;
+
+		hist_field->type = "char[]";
+		hist_field->fn = hist_field_execname;
+		goto out;
+	}
+
 	if (WARN_ON_ONCE(!field))
 		goto out;
 
@@ -3703,41 +3734,6 @@ static int create_val_field(struct hist_trigger_data *hist_data,
 	return __create_val_field(hist_data, val_idx, file, NULL, field_str, 0);
 }
 
-static const char *no_comm = "(no comm)";
-
-static u64 hist_field_execname(struct hist_field *hist_field,
-			       struct tracing_map_elt *elt,
-			       struct trace_buffer *buffer,
-			       struct ring_buffer_event *rbe,
-			       void *event)
-{
-	struct hist_elt_data *elt_data;
-
-	if (WARN_ON_ONCE(!elt))
-		return (u64)(unsigned long)no_comm;
-
-	elt_data = elt->private_data;
-
-	if (WARN_ON_ONCE(!elt_data->comm))
-		return (u64)(unsigned long)no_comm;
-
-	return (u64)(unsigned long)(elt_data->comm);
-}
-
-/* Convert a var that points to common_pid.execname to a string */
-static void update_var_execname(struct hist_field *hist_field)
-{
-	hist_field->flags = HIST_FIELD_FL_STRING | HIST_FIELD_FL_VAR |
-		HIST_FIELD_FL_EXECNAME;
-	hist_field->size = MAX_FILTER_STR_VAL;
-	hist_field->is_signed = 0;
-
-	kfree_const(hist_field->type);
-	hist_field->type = "char[]";
-
-	hist_field->fn = hist_field_execname;
-}
-
 static int create_var_field(struct hist_trigger_data *hist_data,
 			    unsigned int val_idx,
 			    struct trace_event_file *file,
@@ -3762,9 +3758,6 @@ static int create_var_field(struct hist_trigger_data *hist_data,
 
 	ret = __create_val_field(hist_data, val_idx, file, var_name, expr_str, flags);
 
-	if (!ret && hist_data->fields[val_idx]->flags & HIST_FIELD_FL_EXECNAME)
-		update_var_execname(hist_data->fields[val_idx]);
-
 	if (!ret && hist_data->fields[val_idx]->flags & HIST_FIELD_FL_STRING)
 		hist_data->fields[val_idx]->var_str_idx = hist_data->n_var_str++;
 
-- 
2.25.1



-- 
Masami Hiramatsu <mhiramat@kernel.org>
