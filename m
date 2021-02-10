Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D51316014
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 08:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbhBJH2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 02:28:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232499AbhBJH1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 02:27:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0EAA64E32;
        Wed, 10 Feb 2021 07:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612941992;
        bh=h5aoe/jOHYaMcTgcBJi5YW8xNBqHjK9eF+9xhJ40xVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GsNW6pT9hwr9RG3jmzpAYBRsx3142303lE2ZvIVYp3+8LuQiTtI9XajsoA1GmEmBe
         KG8hmZV7kPGe0Sa8yM15RA4ktjyv6jVz7xRb44yFYSpFq3tuCEfTg4ObxY7Rhnusde
         rkWNPlMxvfTxMfQaLUXgFhwRdIK/ZKtsRTvFyV5w=
Date:   Wed, 10 Feb 2021 08:26:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, surenb@google.com,
        joaodias@google.com, willy@infradead.org
Subject: Re: [PATCH v2] mm: cma: support sysfs
Message-ID: <YCOKpM9lufhD/myy@kroah.com>
References: <7cc229f4-609c-71dd-9361-063ef1bf7c73@nvidia.com>
 <cd33f8b9-89e0-05bd-2b16-85855f7541bb@nvidia.com>
 <YCIyHuOX3E+tP+AO@kroah.com>
 <YCKwjz0uDPBhbFr5@google.com>
 <YCLLKDEQ4NYqb5Y5@kroah.com>
 <09e60732-6a46-dd00-f9d5-4ef17ee685c8@nvidia.com>
 <YCL67QzPiyRhhbor@google.com>
 <YCOAmXqt6dZkCQYs@kroah.com>
 <YCOHRAAijtCbN+pr@google.com>
 <e7ea55b9-a5f6-0daf-843b-e25d8c70e980@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7ea55b9-a5f6-0daf-843b-e25d8c70e980@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 11:16:07PM -0800, John Hubbard wrote:
> On 2/9/21 11:12 PM, Minchan Kim wrote:
> ...
> > > > Agreed. How about this for the warning part?
> > > > 
> > > > +
> > > > +/*
> > > > + * note: kobj_type should provide a release function to free dynamically
> > > > + * allocated object since kobject is responsible for controlling lifespan
> > > > + * of the object. However, cma_area is static object so technially, it
> > > > + * doesn't need release function. It's very exceptional case so pleaes
> > > > + * do not follow this model.
> > > > + */
> > > >   static struct kobj_type cma_ktype = {
> > > >          .sysfs_ops = &kobj_sysfs_ops,
> > > >          .default_groups = cma_groups
> > > > +       .release = NULL, /* do not follow. See above */
> > > >   };
> > > > 
> > > 
> > > No, please no.  Just do it the correct way, what is the objection to
> > > creating a few dynamic kobjects from the heap?  How many of these are
> > > you going to have that it will somehow be "wasteful"?
> > > 
> > > Please do it properly.
> > 
> > Oh, I misunderstood your word "don't provide a release function for the
> > kobject" so thought you agreed on John. If you didn't, we are stuck again:
> > IIUC, the objection from John was the cma_stat lifetime should be on parent
> > object, which is reasonable and make code simple.
> > Frankly speaking, I don't have strong opinion about either approach.
> > John?
> > 
> 
> We should do it as Greg requests, now that it's quite clear that he's insisting
> on this. Not a big deal.
> 
> I just am not especially happy about the inability to do natural, efficient
> things here, such as use a statically allocated set of things with sysfs. And
> I remain convinced that the above is not "improper"; it's a reasonable
> step, given the limitations of the current sysfs design. I just wanted to say
> that out loud, as my proposal sinks to the bottom of the trench here. haha :)

What is "odd" is that you are creating an object in the kernel that you
_never_ free.  That's not normal at all in the kernel, and so, your wish
to have a kobject that you never free represent this object also is not
normal :)

thanks,

greg k-h
