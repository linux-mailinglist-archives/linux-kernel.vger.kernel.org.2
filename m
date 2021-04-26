Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF0436B41E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 15:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbhDZNaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 09:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhDZNaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 09:30:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C72C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 06:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hPisMVH8gfXHgWng4qXBnIRMDi/jAWhIm5sJAtRK0W4=; b=VSK1NBc2TFzoP2NEfsMcpRIwU9
        FzZlMsPEbApabA4uPbVdjh/adudAYxpGdpMlT4zQOsqHhLxboJhEeEsmmi0L5411BJF8pIHjjELKc
        MoiQetait6zn8nCdT48UVfSERi4S1v7owmRevnn1M50qLqE/lAAx+ulu66uHgkwlXB4aVwo/YalTa
        ngM3lyZmLwFTPnF5ARk0ZtvPozt1ZGwMSvHgb279/0qwq0na9Y366iFWtDmSCTd+MA/s6i+Z7fWne
        5HLJA+5X8hJp/w88U9zFIGnRvi7fX7XFsKWun2B5DPffRn1QND0qrTX8IXYixACBqY/reJnrBjIUA
        Q36hfRqA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lb1Im-005ezZ-T1; Mon, 26 Apr 2021 13:29:30 +0000
Date:   Mon, 26 Apr 2021 14:29:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Outreachy kernel] [RFC PATCH] staging: unisys: visorhba:
 Convert module from IDR to XArray
Message-ID: <20210426132928.GL235567@casper.infradead.org>
References: <20210426095015.18556-1-fmdefrancesco@gmail.com>
 <20210426114902.GI235567@casper.infradead.org>
 <2833559.jtDpNxbUmt@linux.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2833559.jtDpNxbUmt@linux.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 03:14:42PM +0200, Fabio M. De Francesco wrote:
> > > -	int id;
> > > -	unsigned long flags;
> > > 
> > > -	idr_preload(GFP_KERNEL);
> > > -	spin_lock_irqsave(lock, flags);
> > > -	id = idr_alloc(idrtable, p, 1, INT_MAX, GFP_NOWAIT);
> > > -	spin_unlock_irqrestore(lock, flags);
> > > -	idr_preload_end();
> > > -	/* failure */
> > > -	if (id < 0)
> > > -		return 0;
> > > -	/* idr_alloc() guarantees > 0 */
> > > -	return (unsigned int)(id);
> >
> > And it shouldn't be using GFP_NOWAIT, but GFP_KERNEL, like the IDR code
> > used to do.
> I'm not sure to understand why idr_preload() uses GFP_KERNEL and instead  
> idr_alloc() uses GFP_NOWAIT. I'd better read anew the documentation of the 
> above-mentioned functions  

If you're holding a spinlock, you can't do a GFP_KERNEL allocation,
because it can sleep, and sleeping while holding a spinlock isn't allowed.

The IDR and radix tree have an approach where you first preallocate
memory using GFP_KERNEL and then use GFP_NOWAIT or GFP_ATOMIC after
you've taken the spinlock.  XArray doesn't do that; it takes the spinlock
and does a GFP_NOWAIT allocation.  If it fails, it drops the spinlock,
allocates the memory using GFP_KERNEL, and retries.

> This will not be anymore a problem when I'll restore the use of one namespace 
> per HBA. It's correct?

true ...

> > More generally, the IDR required you call idr_destroy() to avoid leaking
> > preallocated memory.  I changed that, but there are still many drivers
> > that have unnecessary calls to idr_destroy().  It's good form to just
> > delete them and not turn them into calls to xa_destroy().
> >
> This one is a bit obscure to me. I have to look into it more carefully. Maybe 
> I'll ask for some further help.

The IDR used to have a per-idr preallocation, so you had to destroy it
in order to make sure they were freed.  I got rid of that about five
years ago because most IDR users weren't calling idr_destroy().
