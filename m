Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52014424BB1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 03:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhJGBvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 21:51:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230300AbhJGBvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 21:51:54 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D602610A4;
        Thu,  7 Oct 2021 01:50:00 +0000 (UTC)
Date:   Wed, 6 Oct 2021 21:49:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 1/4] bootconfig: init: Fix memblock leak in
 xbc_make_cmdline()
Message-ID: <20211006214959.600221a8@rorschach.local.home>
In-Reply-To: <20211007104357.7b1132f2785858552e53654f@kernel.org>
References: <163177338366.682366.5998343833719057348.stgit@devnote2>
        <163177339181.682366.8713781325929549256.stgit@devnote2>
        <20211006210216.2fdf63cd@rorschach.local.home>
        <20211007104357.7b1132f2785858552e53654f@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2021 10:43:57 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Wed, 6 Oct 2021 21:02:16 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Thu, 16 Sep 2021 15:23:12 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >   
> > > Free unused memblock in a error case to fix memblock leak
> > > in xbc_make_cmdline().
> > > 
> > > Fixes: 51887d03aca1 ("bootconfig: init: Allow admin to use bootconfig for kernel command line")
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > ---
> > >  init/main.c |    1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/init/main.c b/init/main.c
> > > index 3f7216934441..0b054fff8e92 100644
> > > --- a/init/main.c
> > > +++ b/init/main.c
> > > @@ -382,6 +382,7 @@ static char * __init xbc_make_cmdline(const char *key)
> > >  	ret = xbc_snprint_cmdline(new_cmdline, len + 1, root);
> > >  	if (ret < 0 || ret > len) {
> > >  		pr_err("Failed to print extra kernel cmdline.\n");
> > > +		memblock_free_ptr(new_cmdline, len + 1);
> > >  		return NULL;
> > >  	}
> > >    
> > 
> > Hmm, looking at my patch queue, I noticed that this did not get
> > applied. I'm thinking I may have been confused with the other memory
> > freeing that was put into the xbc_destroy(), thinking this was part of
> > that. But now that I look at this patch in the context of the code, it
> > looks like this patch is required, as "new_cmdline" never gets exposed
> > on this error.
> > 
> > Masami, I just want to confirm, that this patch is still relevant, right?  
> 
> Yes, with other 2 patches in this series ([1/4]-[3/4]), I thought you already
> queued it in your tree as you said in [1];
> 
> > I'm going to leave this patch out, and just review and accept the first three patches
> > in the series.  
> 
> [1] https://lore.kernel.org/all/20210916164805.32592423@gandalf.local.home/T/#u

Bah, doing all my rebases with Linus's "nack" probably caused me to
accidentally drop this one.

> 
> So, my next cleanup series [2] (including xbc_destroy_all() -> xbc_exit()) was
> based on the [1]'s first 3 patches.
> 
> [2] https://lore.kernel.org/all/163187294400.2366983.7393164788107844569.stgit@devnote2/T/#u
> 

I just went through my queue from as far back as August, to pick up
everything that I left behind to worry about Linux Plumbers and Open
Source Summit, and found this set in that queue. I'll be processing all
these patches in the next few days.


> If it helps, I can make these series to one series and rebase on top of your
> for-next (or ftrace/core) branch.

No, this patch should be added to my urgent tree and pushed onto Linus
(and stable).

I'm working on those patches first, then will move on to my for-next
tree.

Thanks,

-- Steve
