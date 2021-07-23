Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7553D311F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 03:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbhGWAbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 20:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232942AbhGWAbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 20:31:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22D2160EBA;
        Fri, 23 Jul 2021 01:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627002696;
        bh=lOc2xP+lph4o4VoGCKPzwsM/UYyLXBdrt2I3hj21/f8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U+GyTallHXE/NJsK8XrBjzKHebNJVxFOSG3ewrDCt4kKAGj7MMA1xk3wxGCRfD7Wo
         EyZfd2uEdo1HxeEPlgW2EXLxKpXr/WFJZvqPXrloUUQ5zn+Wk0JVqoj+0qtkd+XSSi
         WEMxL8MAwJR2BI3nFBqdC3LwqNNmHqZxUctCOZ3uP5R0x+tTRDUodVnyZd1IRMws/S
         sNkg7iqG5aEwP1ZIJkw3Itl9QB2DscNhCOieAkBbYToJCB8lDUloAsv9Yvpy4WDB1w
         ns8DKA88lCVj1Ohg6aIyYysZNvDq6Rj1OL5N9WJEW9P2VfbCoSopO+uAtEKKGhSlcf
         L4tqgtS8hP9Dw==
Date:   Fri, 23 Jul 2021 10:11:33 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 2/2] tracing: Allow execnames to be passed as args
 for synthetic events
Message-Id: <20210723101133.3378369c618c53f2e71d3e4c@kernel.org>
In-Reply-To: <20210722123234.636d5363@oasis.local.home>
References: <20210722142705.992001628@goodmis.org>
        <20210722142837.458596338@goodmis.org>
        <20210723011935.efb25bc4a23ebd567243ed0f@kernel.org>
        <20210722123234.636d5363@oasis.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jul 2021 12:32:34 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 23 Jul 2021 01:19:35 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > > +/* Convert a var that points to common_pid.execname to a string */
> > > +static void update_var_execname(struct hist_field *hist_field)
> > > +{
> > > +	hist_field->flags = HIST_FIELD_FL_STRING | HIST_FIELD_FL_VAR |
> > > +		HIST_FIELD_FL_EXECNAME;
> > > +	hist_field->size = MAX_FILTER_STR_VAL;
> > > +	hist_field->is_signed = 0;
> > > +
> > > +	kfree_const(hist_field->type);
> > > +	hist_field->type = "char[]";
> > > +
> > > +	hist_field->fn = hist_field_execname;
> > > +}  
> > 
> > Hmm, this is a bit ad-hoc.
> > 
> > Can't this be done in the create_hist_field()? If you check 'var_name' and
> > flags & HIST_FIELD_FL_EXECNAME, you can do the same thing I think.
> 
> Hi Masami,
> 
> I originally tried that, but then found that it converted the pid over
> to it as well. So this must be done only for vars, and not only that, it
> needs to be done in a single place, because I was spending hours
> debugging it.

I understand. As far as I can see the code, it looks a bit complicated.
To simplify it, I need to understand the spec for "hist_field"
for keys and for vars. And maybe need to split both case.

> I found this to be the least intrusive solution.
> 
> Maybe Tom has a better idea, but I don't have any more time to work on
> it, and I really want this feature for the next merge window.
> 
> If you can make it work, and have time to play with it, I'm happy to
> take an alternative :-)

Me neither at least this moment, need more investigation. Let me try.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
