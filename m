Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD9036BB66
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 00:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbhDZWEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 18:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbhDZWEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 18:04:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E720AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 15:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uQLYYr2tQMTLi+1p5HJHiiRrQ6/VqapV2NJisyQBKv0=; b=MadCHfvGq7kKDKX/4If3veG0eF
        qB5PNuZ2Hc4sm7hmLD4n7DAGIuXbLZNWvWyjNmYk1UsmujYYWeq7Vjqu3DgDv11ShYQQDQ1ND2nBn
        9sIAmQJndesSMORlygBVI5dkNkMJUaIc5DOQ4zB8nbG5HSY4YLn4nEZ0hzidpv50/FHTafibOIi58
        jmW8a3dAIdcnQhvmVsAAwkMEM0/wBOvJHZTV6zQycK8GVqA7oXPD5Yhd5IOSujcqXtFaA+DCc4lWc
        csxSAebO8bv643PG1CTbbSFpksLgMHg3Hu841+qBhltg8BGYs/vDY/pl2vji0uidmlNp1PCM22ETA
        MGAnmn2A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lb9KB-0069Pn-KL; Mon, 26 Apr 2021 22:03:31 +0000
Date:   Mon, 26 Apr 2021 23:03:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Outreachy kernel] [PATCH v3] staging: unisys: visorhba: Convert
 module from IDR to XArray
Message-ID: <20210426220327.GT235567@casper.infradead.org>
References: <20210426184245.12269-1-fmdefrancesco@gmail.com>
 <20210426192101.GQ235567@casper.infradead.org>
 <107967147.Ip005GxVp3@linux.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <107967147.Ip005GxVp3@linux.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 11:15:40PM +0200, Fabio M. De Francesco wrote:
> On Monday, April 26, 2021 9:21:01 PM CEST Matthew Wilcox wrote:
> > On Mon, Apr 26, 2021 at 08:42:45PM +0200, Fabio M. De Francesco wrote:
> > > +static void setup_scsitaskmgmt_handles(struct xarray *xa, struct 
> uiscmdrsp *cmdrsp,
> > > 
> > >  				       wait_queue_head_t *event, 
> int *result)
> > >  
> > >  {
> > > 
> > > -	/* specify the event that has to be triggered when this */
> > > -	/* cmd is complete */
> > > -	cmdrsp->scsitaskmgmt.notify_handle =
> > > -		simple_idr_get(idrtable, event, lock);
> > > -	cmdrsp->scsitaskmgmt.notifyresult_handle =
> > > -		simple_idr_get(idrtable, result, lock);
> > > +	u32 id;
> > > +	int ret;
> > > +
> > > +	/* specify the event that has to be triggered when this cmd is 
> complete */
> > > +	id = (u32)cmdrsp->scsitaskmgmt.notify_handle;
> > > +	ret = xa_alloc_irq(xa, &id, event, XA_LIMIT(1, INT_MAX), 
> GFP_KERNEL);
> > 
> > OK, think this one through a bit.  When xa_alloc_irq() stores the ID that
> > it assigned into 'id', what happens to it next?
> >
> Oh, I overlooked that... The ID in 'id' is lost when the function exits and 
> the stack frame is unwound.
> 
> Now I have another problem: xa_alloc_irq() writes id u32* but I have an u64* 
> in 'id'. What happens if I cast 'id' to an u32* when passing it to 
> xa_alloc_irq()?
> 
> u64 *id;
> int ret;
> id = &cmdrsp->scsitaskmgmt.notify_handle;
> ret = xa_alloc_irq(xa, (u32 *)id, event, XA_LIMIT(1, INT_MAX), GFP_KERNEL);
> 
> Do I destroy the information stored in 'id' with that cast?

That is a great question!  That would be a really serious bug because
it behaves differently on big and little endian systems.  That is, on a
little endian system, a pointer to a u64 can be treated as a pointer to a
u32 and it will write to the bottom 32 bits of the u64.  On a big endian
system, treating a pointer to a u64 as if it's a pointer to a u32 means
you write to the _top_ 32 bits of the u64, and things go wrong from there!

Similarly, if you have a u16, you can't pass a pointer to it, because
the called function has no idea that it's only 16 bits, and will do a
32-bit store to it, overwriting the 16 bits after it.

So you need to pass a pointer to a u32 on the stack, and then copy the
id out of it afterwards.

