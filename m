Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CA53D4B3C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 05:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhGYDEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 23:04:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhGYDEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 23:04:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0A1B60E90;
        Sun, 25 Jul 2021 03:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627184704;
        bh=MYAW31QXCMaQyJ7F5GZSdEIsCtCBvofLhRaYdx+9/KU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ay47S+UkkWQi+Frr4RI0Tt+VRALeqcb/l9ErJduZLz7yQwK8znEFZeFpV/993OV3r
         0SSDBEFvsRDmgubD+bgyOSsHchrn9TYTfgY4g6+tYpSNP8Ms4Po8BFcenAaKjyDisp
         98LpDLcy8kvn3lpCS2s6aVqbrVFUZNBfTO6qH0Rxq5aiP/glf2cElj6zlI/0EIdD9X
         v4jkIG2o2gEwAG7vkGrPvWj+AxIFpuyXQY+LHHJ+zxh9DZtxsFhjPlOygJp4yBhQPn
         EtOL+kNP9mpzV2St03wUMJYx3w6hY0p89MVFcdXomZrCeGronzuCU0qYhWMsvTGvPs
         lIDseLnaTFV2g==
Date:   Sun, 25 Jul 2021 12:45:02 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 2/2] tracing: Allow execnames to be passed as args
 for synthetic events
Message-Id: <20210725124502.54fa65251b5cd5b76fdf5f19@kernel.org>
In-Reply-To: <20210725111830.2f424ae3978443241b6d4a2d@kernel.org>
References: <20210722142705.992001628@goodmis.org>
        <20210722142837.458596338@goodmis.org>
        <20210723011935.efb25bc4a23ebd567243ed0f@kernel.org>
        <20210722123234.636d5363@oasis.local.home>
        <20210723101133.3378369c618c53f2e71d3e4c@kernel.org>
        <20210722212438.5933e714@rorschach.local.home>
        <20210724193145.c63b44aa843e05ed9c0b4fdc@kernel.org>
        <20210725111830.2f424ae3978443241b6d4a2d@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jul 2021 11:18:30 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> On Sat, 24 Jul 2021 19:31:45 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hi Steve,
> > 
> > On Thu, 22 Jul 2021 21:24:38 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Fri, 23 Jul 2021 10:11:33 +0900
> > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > 
> > > > I understand. As far as I can see the code, it looks a bit complicated.
> > > > To simplify it, I need to understand the spec for "hist_field"
> > > > for keys and for vars. And maybe need to split both case.
> > > 
> > > I'll give you a hint that took me a bit to figure out.
> > > 
> > > 1) The execname is saved at the start of the histogram and not by one
> > > of the ->fn() functions.
> > > 
> > > It's saved by hist_trigger_elt_data_init() if the elt_data->comm is
> > > allocated. That function is part of the "tracing_map_ops" which gets
> > > assigned by tracing_map_create() (in tracing_map.c) as the "elt_init"
> > > function, which is called when getting a new elt element by
> > > get_free_elt().
> > > 
> > > 2) That elt_data->comm is only allocated if it finds a "hist_field"
> > > that has HIST_FIELD_FL_EXECNAME flag set. It currently only looks for
> > > that flag in the "keys" fields, which means that .execname is useless
> > > for everything else. This patch changed it to search all hist_fields so
> > > that it can find that flag if a variable has it set (which I added).
> > 
> > Thanks for the hints, but actually, that part looks good to me.
> > 
> > So, what I pointed was the part of update_var_execname(). Below diff
> > is what I intended.
> > This moves HIST_FIELD_FL_EXECNAME setup in the create_hist_field()
> > as same as other flags, and removed the add-hoc update_var_execname()
> > fixup function.
> > 
> > I confirmed it passed the ftracetest trigger testcases and your
> > example code.
> > 
> > Thank you,
> > 
> 
> I found a bug in this change.
> 
> [..]
> > @@ -1682,6 +1703,16 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
> >  		goto out;
> >  	}
> >  
> > +	if ((flags & HIST_FIELD_FL_EXECNAME) && var_name) {
> > +		flags |= HIST_FIELD_FL_STRING | HIST_FIELD_FL_VAR;
> 
> Here, we don't need to check 'var_name' and remove HIST_FIELD_FL_VAR, since it must be set in the flag.
> 
> 	if (flags & HIST_FIELD_FL_EXECNAME) {
> 		flags |= HIST_FIELD_FL_STRING;

And with this change, hist trigger can correctly detect a string type in
the operand in the expression and rejects it.

Thank you,

From 5280d1efe4415a621cf69a1dc4861ab928b0ff1c Mon Sep 17 00:00:00 2001
From: Masami Hiramatsu <mhiramat@kernel.org>
Date: Sun, 25 Jul 2021 12:34:00 +0900
Subject: [PATCH] tracing: Reject string operand in the histogram expression

Since the string type can not be the target of the addition / subtraction
operation, it must be rejected. Without this fix, the string type silently
converted to digits.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_events_hist.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 76e3100a4840..3eea60e2da48 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -65,7 +65,8 @@
 	C(INVALID_SORT_MODIFIER,"Invalid sort modifier"),		\
 	C(EMPTY_SORT_FIELD,	"Empty sort field"),			\
 	C(TOO_MANY_SORT_FIELDS,	"Too many sort fields (Max = 2)"),	\
-	C(INVALID_SORT_FIELD,	"Sort field must be a key or a val"),
+	C(INVALID_SORT_FIELD,	"Sort field must be a key or a val"),	\
+	C(INVALID_STR_OPERAND,	"String type can not be an operand in expression"),
 
 #undef C
 #define C(a, b)		HIST_ERR_##a
@@ -2183,6 +2184,13 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 		ret = PTR_ERR(operand1);
 		goto free;
 	}
+	if (operand1->flags & HIST_FIELD_FL_STRING) {
+		/* String type can not be the operand of unary operator. */
+		hist_err(file->tr, HIST_ERR_INVALID_STR_OPERAND, errpos(str));
+		destroy_hist_field(operand1, 0);
+		ret = -EINVAL;
+		goto free;
+	}
 
 	expr->flags |= operand1->flags &
 		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS);
@@ -2284,6 +2292,11 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 		operand1 = NULL;
 		goto free;
 	}
+	if (operand1->flags & HIST_FIELD_FL_STRING) {
+		hist_err(file->tr, HIST_ERR_INVALID_STR_OPERAND, errpos(operand1_str));
+		ret = -EINVAL;
+		goto free;
+	}
 
 	/* rest of string could be another expression e.g. b+c in a+b+c */
 	operand_flags = 0;
@@ -2293,6 +2306,11 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 		operand2 = NULL;
 		goto free;
 	}
+	if (operand2->flags & HIST_FIELD_FL_STRING) {
+		hist_err(file->tr, HIST_ERR_INVALID_STR_OPERAND, errpos(str));
+		ret = -EINVAL;
+		goto free;
+	}
 
 	ret = check_expr_operands(file->tr, operand1, operand2);
 	if (ret)
-- 
2.25.1



-- 
Masami Hiramatsu <mhiramat@kernel.org>
