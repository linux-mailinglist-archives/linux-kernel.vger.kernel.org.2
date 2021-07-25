Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A95A3D4AFA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 04:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhGYBiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 21:38:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhGYBiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 21:38:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA9D06069E;
        Sun, 25 Jul 2021 02:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627179512;
        bh=hIfW1IzXB/tUQDC6Im2ycdKDhMMDxDiPL+5D+VbyHZ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q3X00iScxuHd6Lyg4xuXM1//SU1pqjwvzbnoiBKqYr/DVAk2koFXpqZxiBmj0UIx1
         J6lnxeMIf229iEmG45I5BJ92O0GvCcu7vj74ahksBIP8VVeqMKemu/BkHOIrWzSW6I
         muZ2F8BFn+CIk+WjqYP1d7ITo4ATM7CmfC7+SvljE7sflqKT/idrY/emvjy9+y24Wa
         3jjLT4HaGogN4JdXRDBTLxuAdxO5nS/aT4rM8cYuzbZvC7BY8GeUSpdULmw4XFbh8S
         AeShIWSdogBPL586KRKTnP5XAKUbbxI0RnX0qagC+c6XNwkFrUxxHx0S52w5fuB+Ds
         NG+ifcwCjzerw==
Date:   Sun, 25 Jul 2021 11:18:30 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 2/2] tracing: Allow execnames to be passed as args
 for synthetic events
Message-Id: <20210725111830.2f424ae3978443241b6d4a2d@kernel.org>
In-Reply-To: <20210724193145.c63b44aa843e05ed9c0b4fdc@kernel.org>
References: <20210722142705.992001628@goodmis.org>
        <20210722142837.458596338@goodmis.org>
        <20210723011935.efb25bc4a23ebd567243ed0f@kernel.org>
        <20210722123234.636d5363@oasis.local.home>
        <20210723101133.3378369c618c53f2e71d3e4c@kernel.org>
        <20210722212438.5933e714@rorschach.local.home>
        <20210724193145.c63b44aa843e05ed9c0b4fdc@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 24 Jul 2021 19:31:45 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Steve,
> 
> On Thu, 22 Jul 2021 21:24:38 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 23 Jul 2021 10:11:33 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > I understand. As far as I can see the code, it looks a bit complicated.
> > > To simplify it, I need to understand the spec for "hist_field"
> > > for keys and for vars. And maybe need to split both case.
> > 
> > I'll give you a hint that took me a bit to figure out.
> > 
> > 1) The execname is saved at the start of the histogram and not by one
> > of the ->fn() functions.
> > 
> > It's saved by hist_trigger_elt_data_init() if the elt_data->comm is
> > allocated. That function is part of the "tracing_map_ops" which gets
> > assigned by tracing_map_create() (in tracing_map.c) as the "elt_init"
> > function, which is called when getting a new elt element by
> > get_free_elt().
> > 
> > 2) That elt_data->comm is only allocated if it finds a "hist_field"
> > that has HIST_FIELD_FL_EXECNAME flag set. It currently only looks for
> > that flag in the "keys" fields, which means that .execname is useless
> > for everything else. This patch changed it to search all hist_fields so
> > that it can find that flag if a variable has it set (which I added).
> 
> Thanks for the hints, but actually, that part looks good to me.
> 
> So, what I pointed was the part of update_var_execname(). Below diff
> is what I intended.
> This moves HIST_FIELD_FL_EXECNAME setup in the create_hist_field()
> as same as other flags, and removed the add-hoc update_var_execname()
> fixup function.
> 
> I confirmed it passed the ftracetest trigger testcases and your
> example code.
> 
> Thank you,
> 

I found a bug in this change.

[..]
> @@ -1682,6 +1703,16 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
>  		goto out;
>  	}
>  
> +	if ((flags & HIST_FIELD_FL_EXECNAME) && var_name) {
> +		flags |= HIST_FIELD_FL_STRING | HIST_FIELD_FL_VAR;

Here, we don't need to check 'var_name' and remove HIST_FIELD_FL_VAR, since it must be set in the flag.

	if (flags & HIST_FIELD_FL_EXECNAME) {
		flags |= HIST_FIELD_FL_STRING;


> +		hist_field->size = MAX_FILTER_STR_VAL;
> +		hist_field->is_signed = 0;
> +
> +		hist_field->type = "char[]";
> +		hist_field->fn = hist_field_execname;
> +		goto out;
> +	}
> +



Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
