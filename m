Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C93424BAF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 03:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhJGBpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 21:45:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230300AbhJGBpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 21:45:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE0D461177;
        Thu,  7 Oct 2021 01:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633571040;
        bh=DOUt+G+DupGP6hj17dk+ZbeIgdDhP6gqkJHwLbkCulY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kk9hfy/BKm0v35grJJ97dE3N8yaERLXE4FIsTI1J3gzubuwfe0K7nYL7Mw9D6gg4C
         UGYZAceQ1tZH3mVGdSb713Je2j/u2iedAll8iHo//5jfrrR1HSzd1tB2TzG4+SO+eN
         5UnxpC9ac2K4fvxX3iqJB/emzQX1ZVenvywLN/9tEzTveYSQGNKnnJBsNaeedFd0DF
         uYftl85Uymnk+Avm9wH/bOelQf7pdpc97OOh8lAWtrnHEY8lp1Txp6q4+KaOc8UYY9
         nY2LIu9HgKGck8zMCId7FRxd7UPxPJAumhMCANFYXnC5X25hO350AFrBJJ/1gV/zas
         dVoqs3cF4jDAw==
Date:   Thu, 7 Oct 2021 10:43:57 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 1/4] bootconfig: init: Fix memblock leak in
 xbc_make_cmdline()
Message-Id: <20211007104357.7b1132f2785858552e53654f@kernel.org>
In-Reply-To: <20211006210216.2fdf63cd@rorschach.local.home>
References: <163177338366.682366.5998343833719057348.stgit@devnote2>
        <163177339181.682366.8713781325929549256.stgit@devnote2>
        <20211006210216.2fdf63cd@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2021 21:02:16 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 16 Sep 2021 15:23:12 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Free unused memblock in a error case to fix memblock leak
> > in xbc_make_cmdline().
> > 
> > Fixes: 51887d03aca1 ("bootconfig: init: Allow admin to use bootconfig for kernel command line")
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  init/main.c |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/init/main.c b/init/main.c
> > index 3f7216934441..0b054fff8e92 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -382,6 +382,7 @@ static char * __init xbc_make_cmdline(const char *key)
> >  	ret = xbc_snprint_cmdline(new_cmdline, len + 1, root);
> >  	if (ret < 0 || ret > len) {
> >  		pr_err("Failed to print extra kernel cmdline.\n");
> > +		memblock_free_ptr(new_cmdline, len + 1);
> >  		return NULL;
> >  	}
> >  
> 
> Hmm, looking at my patch queue, I noticed that this did not get
> applied. I'm thinking I may have been confused with the other memory
> freeing that was put into the xbc_destroy(), thinking this was part of
> that. But now that I look at this patch in the context of the code, it
> looks like this patch is required, as "new_cmdline" never gets exposed
> on this error.
> 
> Masami, I just want to confirm, that this patch is still relevant, right?

Yes, with other 2 patches in this series ([1/4]-[3/4]), I thought you already
queued it in your tree as you said in [1];

> I'm going to leave this patch out, and just review and accept the first three patches
> in the series.

[1] https://lore.kernel.org/all/20210916164805.32592423@gandalf.local.home/T/#u

So, my next cleanup series [2] (including xbc_destroy_all() -> xbc_exit()) was
based on the [1]'s first 3 patches.

[2] https://lore.kernel.org/all/163187294400.2366983.7393164788107844569.stgit@devnote2/T/#u

If it helps, I can make these series to one series and rebase on top of your
for-next (or ftrace/core) branch.


Thank you,

> 
> Thanks!
> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
