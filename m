Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C32F3D313F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 03:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbhGWAlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 20:41:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233073AbhGWAlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 20:41:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22CB360EBA;
        Fri, 23 Jul 2021 01:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627003334;
        bh=TjZEmQ97xT2sXa9YqVF5fNPPzrHkrETAv/O2Zq7GrrU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ucd0CgMhHj51EYdcrhAgl4+idMbtHVxIJFydbKodlpolAmogp6FOXlaeSvcoOXa9W
         xklYCNE/3LB6aobDBn9bBodGQAb5ZJCXeyzB0zXxq+MfzzLKK6X3L7BSJ9K2DYXf3H
         38HTWU9M0zvUL9nOsBmZz7FkLDlivQBV+LiC7dk8s9bH7oljKvAVZD3ITKIta/ey8x
         ZGpt36/FlNVNFzs5h0JoYC8k5diUDuNTBD9bDaN8ZQfu54Gm+8GHE10PsKkXWemmxC
         7MfSPMETpPOleLyXIcwMxCNSvRNIgJK3YmJu/UEGjStoroJWu4A9BLSZxybFPsf/Si
         CBAg1Oizs/KWA==
Date:   Fri, 23 Jul 2021 10:22:11 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 2/2] tracing: Allow execnames to be passed as args
 for synthetic events
Message-Id: <20210723102211.a9e0a5cfeb912384a0774145@kernel.org>
In-Reply-To: <20210723101133.3378369c618c53f2e71d3e4c@kernel.org>
References: <20210722142705.992001628@goodmis.org>
        <20210722142837.458596338@goodmis.org>
        <20210723011935.efb25bc4a23ebd567243ed0f@kernel.org>
        <20210722123234.636d5363@oasis.local.home>
        <20210723101133.3378369c618c53f2e71d3e4c@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2021 10:11:33 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Thu, 22 Jul 2021 12:32:34 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 23 Jul 2021 01:19:35 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > > +/* Convert a var that points to common_pid.execname to a string */
> > > > +static void update_var_execname(struct hist_field *hist_field)
> > > > +{
> > > > +	hist_field->flags = HIST_FIELD_FL_STRING | HIST_FIELD_FL_VAR |
> > > > +		HIST_FIELD_FL_EXECNAME;
> > > > +	hist_field->size = MAX_FILTER_STR_VAL;
> > > > +	hist_field->is_signed = 0;
> > > > +
> > > > +	kfree_const(hist_field->type);
> > > > +	hist_field->type = "char[]";
> > > > +
> > > > +	hist_field->fn = hist_field_execname;
> > > > +}  
> > > 
> > > Hmm, this is a bit ad-hoc.
> > > 
> > > Can't this be done in the create_hist_field()? If you check 'var_name' and
> > > flags & HIST_FIELD_FL_EXECNAME, you can do the same thing I think.
> > 
> > Hi Masami,
> > 
> > I originally tried that, but then found that it converted the pid over
> > to it as well. So this must be done only for vars, and not only that, it
> > needs to be done in a single place, because I was spending hours
> > debugging it.
> 
> I understand. As far as I can see the code, it looks a bit complicated.
> To simplify it, I need to understand the spec for "hist_field"
> for keys and for vars. And maybe need to split both case.
> 
> > I found this to be the least intrusive solution.
> > 
> > Maybe Tom has a better idea, but I don't have any more time to work on
> > it, and I really want this feature for the next merge window.
> > 
> > If you can make it work, and have time to play with it, I'm happy to
> > take an alternative :-)
> 
> Me neither at least this moment, need more investigation. Let me try.

But anyway, maybe I need this weekend to make a time.
So, as far as it works OK, I'm OK for this patch.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

BTW, please update the ftracetest testcases for hist triggers.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
