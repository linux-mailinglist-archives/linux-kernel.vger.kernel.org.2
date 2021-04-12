Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4F135C48F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 13:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbhDLLAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 07:00:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:52648 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239843AbhDLLAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 07:00:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618225191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FIwJ2o1ChvUTQac2QV6kY4C/JqzebedAs3YH2KsUrwk=;
        b=uQXF9AGnwE8HshC8CP3Jun+axKZdGLySEhwpcbWGJ7G2LHJi1HDujPh78vSSRndZ7LY4Ir
        voyMDDET7bbqJ/RrmB1sEhmVrnoD5enId5gB+SOFJALpflmMcQcdnou3PaS5MUBJkaggMP
        LnNFj32K0RIzJWwuqYM7vw78d9fBPfU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 41133AEFE;
        Mon, 12 Apr 2021 10:59:51 +0000 (UTC)
Date:   Mon, 12 Apr 2021 12:59:50 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Perches <joe@perches.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Alexander Monakov <amonakov@ispras.ru>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Joerg Roedel <jroedel@suse.de>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] iommu/amd: Fix extended features logging
Message-ID: <YHQoJtUOh7A1k1PF@alley>
References: <20210410211152.1938-1-amonakov@ispras.ru>
 <e884200f-55a4-59b5-4311-964e6ddc94d1@molgen.mpg.de>
 <alpine.LNX.2.20.13.2104111410340.11104@monopod.intra.ispras.ru>
 <87o8ekioo4.fsf@jogness.linutronix.de>
 <9a9246c417587f17009543f8048d5f9b7a2ed68f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a9246c417587f17009543f8048d5f9b7a2ed68f.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2021-04-11 14:08:14, Joe Perches wrote:
> On Sun, 2021-04-11 at 21:52 +0200, John Ogness wrote:
> > I'd rather fix dev_info callers to allow pr_cont and then fix any code
> > that is using this workaround.
> 
> Assuming you mean all dev_<level>() uses, me too.
> 
> > And if the print maintainers agree it is OK to encourage
> > pr_cont(LOGLEVEL "...") usage, then people should really start using
> > that if the loglevel on those pieces is important.
> 
> I have no stong feeling about the use of pr_cont(<KERN_LEVEL>
> as valuable or not.  I think it's just a trivial bit that
> could be somewhat useful when interleaving occurs.
> 
> A somewhat better mechanism would be to have an explicit
> cookie use like:
> 
> 	cookie = printk_multipart_init(KERN_LEVEL, fmt, ...);
> 	while (<condition>)
> 		printk_multipart_cont(cookie, fmt, ...);
> 	printk_multipark_end(cookie, fmt, ...);
> 
> And separately, there should be a pr_debug_cont or equivalent.

We would need to implement this a lockless way. It is doable,
for example, using some per-CPU X per-context buffers. Which would
require to disable preemption in the section.

But I think that using dev_cont_info() would be easier after all.

That said, some printk_*_init()/end() API would be useful
for storing the pieces in a temporary buffer. It would allow
to store the entire lines without the risk of interleaving
with other messages.

Best Regards,
Petr
