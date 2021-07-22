Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD153D27AC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 18:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhGVPwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 11:52:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229797AbhGVPwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 11:52:06 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DA0D613B6;
        Thu, 22 Jul 2021 16:32:41 +0000 (UTC)
Date:   Thu, 22 Jul 2021 12:32:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 2/2] tracing: Allow execnames to be passed as args
 for synthetic events
Message-ID: <20210722123234.636d5363@oasis.local.home>
In-Reply-To: <20210723011935.efb25bc4a23ebd567243ed0f@kernel.org>
References: <20210722142705.992001628@goodmis.org>
        <20210722142837.458596338@goodmis.org>
        <20210723011935.efb25bc4a23ebd567243ed0f@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2021 01:19:35 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > +/* Convert a var that points to common_pid.execname to a string */
> > +static void update_var_execname(struct hist_field *hist_field)
> > +{
> > +	hist_field->flags = HIST_FIELD_FL_STRING | HIST_FIELD_FL_VAR |
> > +		HIST_FIELD_FL_EXECNAME;
> > +	hist_field->size = MAX_FILTER_STR_VAL;
> > +	hist_field->is_signed = 0;
> > +
> > +	kfree_const(hist_field->type);
> > +	hist_field->type = "char[]";
> > +
> > +	hist_field->fn = hist_field_execname;
> > +}  
> 
> Hmm, this is a bit ad-hoc.
> 
> Can't this be done in the create_hist_field()? If you check 'var_name' and
> flags & HIST_FIELD_FL_EXECNAME, you can do the same thing I think.

Hi Masami,

I originally tried that, but then found that it converted the pid over
to it as well. So this must be done only for vars, and not only that, it
needs to be done in a single place, because I was spending hours
debugging it.

I found this to be the least intrusive solution.

Maybe Tom has a better idea, but I don't have any more time to work on
it, and I really want this feature for the next merge window.

If you can make it work, and have time to play with it, I'm happy to
take an alternative :-)

-- Steve
