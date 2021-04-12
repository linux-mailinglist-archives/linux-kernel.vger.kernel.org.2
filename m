Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B470B35C458
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239659AbhDLKtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:49:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:44488 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237929AbhDLKtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:49:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618224560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y3nWrWViWarEokL29oGWFlAfkjkUJE9MTrNl0iKBD4M=;
        b=iazxBz9y39JUxT0qYbRCWlWacub+aN8E+OF5PwpMp3XYR7fk1Y89jH05DbfB9yZTlgznn6
        Fa0yFGQz0FO7Ij6sjXFzSX3P5cKCD/CmrBIrY9zgvVCZaAx3l6m624mYvnxAmbjGxiWANL
        a/wz3IsjUw2mxO+V8c8nxw2mlTdisq4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6983CB250;
        Mon, 12 Apr 2021 10:49:20 +0000 (UTC)
Date:   Mon, 12 Apr 2021 12:49:19 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Alexander Monakov <amonakov@ispras.ru>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Joerg Roedel <jroedel@suse.de>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] iommu/amd: Fix extended features logging
Message-ID: <YHQlr5XTvlqxXnvX@alley>
References: <20210410211152.1938-1-amonakov@ispras.ru>
 <e884200f-55a4-59b5-4311-964e6ddc94d1@molgen.mpg.de>
 <alpine.LNX.2.20.13.2104111410340.11104@monopod.intra.ispras.ru>
 <87o8ekioo4.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8ekioo4.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2021-04-11 21:52:59, John Ogness wrote:
> On 2021-04-11, Alexander Monakov <amonakov@ispras.ru> wrote:
> >>> The second line is emitted via 'pr_cont', which causes it to have a
> >>> different ('warn') loglevel compared to the previous line ('info').
> >>> 
> >>> Commit 9a295ff0ffc9 attempted to rectify this by removing the newline
> >>> from the pci_info format string, but this doesn't work, as pci_info
> >>> calls implicitly append a newline anyway.
> >> 
> >> Hmm, did I really screw that up during my testing? I am sorry about that.
> >> 
> >> I tried to wrap my head around, where the newline is implicitly appended, and
> >> only found the definitions below.
> >> 
> > Yeah, it's not obvious: it happens in kernel/printk/printk.c:vprintk_store
> > where it does
> >
> > 	if (dev_info)
> > 		lflags |= LOG_NEWLINE;
> >
> > It doesn't seem to be documented; I think it prevents using pr_cont with
> > "rich" printk facilities that go via _dev_info.
> >
> > I suspect it quietly changed in commit c313af145b9bc ("printk() - isolate
> > KERN_CONT users from ordinary complete lines").
> 
> Yes, this behavior has been around for a while. I see no reason why it
> should be that way. These days printk does not care if there is dev_info
> included or not.

It seems that it has been this way since the dev_info was
introduced. It was called "dict" at that time. See

	if (buflen && (!cont || dict)) {
		/* no continuation; flush existing buffer */
		log_store(facility, buflevel, NULL, 0, buf, buflen);

in the commit 7ff9554bb578ba02166071d2d ("printk: convert byte-buffer
to variable-length record buffer").

I am not sure why. Well, dev_printk() previously printed the extra
information for every piece. See, the commit c4e00daaa96d3a0786f
("driver-core: extend dev_printk() to pass structured data").


> > Yeah, I saw that, but decided to go with the 'pr_info("")' solution, because
> > it is less magic, and already used in two other drivers.
> 
> Note that what I was suggesting was to fix a different issue: If the
> pr_cont() caller is interrupted by another printk user, then the
> following pr_cont() calls will use the default loglevel. By explicitly
> specifying the loglevel in pr_cont(), you can be sure that those pieces
> get the desired loglevel, even if those pieces get separated off because
> of an interrupting printk user.
> 
> So even if we fix dev_info to allow pr_cont continuation, it still may
> be desirable to specify the loglevel in the pr_cont pieces.
> 
> > pr_info("") will also prepend 'AMD-Vi:' to the feature list, which is
> > nice.
> 
> I'd rather fix dev_info callers to allow pr_cont and then fix any code
> that is using this workaround.
> 
> And if the print maintainers agree it is OK to encourage
> pr_cont(LOGLEVEL "...") usage, then people should really start using
> that if the loglevel on those pieces is important.

To be sure. We would need to repeat also the dev_info() information
in the continuous piece.

By other words. The clean solution would be:

   + remove the automatic newline in
     kernel/printk/printk.c:vprintk_store

   + create wrappers, for example, dev_cont_info()

Best Regards,
Petr
