Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A64536B3E8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 15:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbhDZNPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 09:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhDZNP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 09:15:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D030C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 06:14:46 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u17so84449086ejk.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 06:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CQZOIEnc0SJPBu626kW+7hWVedv6PicOrjTtJhWP+8Y=;
        b=kOhKMuotesxmj/2fYjgWbXdP/uh7nL+2JIoZr+qKMd2LTKnEltMwRNH46gYWcBd0IK
         KBoIIQHzFkUbpUP4fUIOQNOi8OBsEdZYBCU7C8xKYhgmKRrkH+zuwi7S3ZzFd7u18uPI
         xqYxAyzMZamQ36urJzC834vEJOBo2mRANLEUvO+6f4NSW7Ve48BT25jn3uGGkjwHgLup
         XDvOTgDr2JgeM75jawXvAUdrX2rBvq//y7dtKQWe1EorYLVuF6zcXaMmA9TwSVi6TbCc
         UddrUnVqpZ0hsKObi9v4vpgJ+XUdU3p2fmjuehCFJAswban9OqVvE90DAyIP/RFJWSqJ
         NOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CQZOIEnc0SJPBu626kW+7hWVedv6PicOrjTtJhWP+8Y=;
        b=n1oq4dEq75cXt8UCoznZB+TDY6JPfmmbROFHn7f64KDduqUJ1kAi6QlhVEgbOLYgH4
         ssmhErn/HeuVMYZXW0hZ3UKzZgve901BtXz7IuFVAOn4zMbdWYDoMj0fcKxprGUb9mnQ
         jmCMaaqbhvxmPSNGdQDHIDc4x6xdtKXHolkKO8iqQswEL4P3O1S/aPZ3gtgcim4aeXp2
         4N3GsrcDw40rbcYln8MSKI8fObkDwg3nCYeqXLxCS4kufpZov5vzpyIgAYpHYLod6uv2
         gc0jZDNaoER4XcWESovL7H6EqXstIWzk+SP3nbbi/CLtIRaWYgsOxq4qbBmCDweKFoIC
         bf1Q==
X-Gm-Message-State: AOAM5305nb5cgLH+fcHHBPGLLqzE+4w02YKFHENNl9BZDJwNP73WRc9w
        kV/APS0yOQp4s67XZk3QvOzQ/5Xvk1sW0Q==
X-Google-Smtp-Source: ABdhPJyks3xcwNiMb1wd53RfQznEIC/1oUXuO+letF92RYiP5kOY1qbRXCYBi3xhpv4lMlfBvOn/MQ==
X-Received: by 2002:a17:906:250d:: with SMTP id i13mr19040448ejb.474.1619442885028;
        Mon, 26 Apr 2021 06:14:45 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id k9sm14456158edv.69.2021.04.26.06.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 06:14:44 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Outreachy kernel] [RFC PATCH] staging: unisys: visorhba: Convert module from IDR to XArray
Date:   Mon, 26 Apr 2021 15:14:42 +0200
Message-ID: <2833559.jtDpNxbUmt@linux.local>
In-Reply-To: <20210426114902.GI235567@casper.infradead.org>
References: <20210426095015.18556-1-fmdefrancesco@gmail.com> <20210426114902.GI235567@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 26, 2021 1:49:02 PM CEST Matthew Wilcox wrote:
> On Mon, Apr 26, 2021 at 11:50:15AM +0200, Fabio M. De Francesco wrote:
> >  #define VISORHBA_ERROR_COUNT 30
> > 
> > +static DEFINE_XARRAY_ALLOC(xa_dtstr);
> > +
> > 
> >  static struct dentry *visorhba_debugfs_dir;
> >  
> >  /* GUIDS for HBA channel type supported by this driver */
> > 
> > @@ -78,12 +80,6 @@ struct visorhba_devdata {
> > 
> >  	unsigned int max_buff_len;
> >  	int devnum;
> >  	struct uiscmdrsp *cmdrsp;
> > 
> > -	/*
> > -	 * allows us to pass int handles back-and-forth between us and
> > -	 * iovm, instead of raw pointers
> > -	 */
> > -	struct idr idr;
> > -
> 
> Why did you change the driver from having one namespace per HBA to having
> a global namespace?
> 
I made that change simply because I didn't catch that there could be more than 
just one HBA. 
> >  /*
> > 
> > - * simple_idr_get - Associate a provided pointer with an int value
> > - *		    1 <= value <= INT_MAX, and return this int value;
> > - *		    the pointer value can be obtained later by passing
> > - *		    this int value to idr_find()
> > - * @idrtable: The data object maintaining the pointer<-->int mappings
> > - * @p:	      The pointer value to be remembered
> > - * @lock:     A spinlock used when exclusive access to idrtable is needed
> > - *
> > - * Return: The id number mapped to pointer 'p', 0 on failure
> > + * simple_xa_dtstr_get - Store a pointer to xa_dtstr xarray
> > + * @id: Pointer to ID
> > + * @entry: New entry
> > 
> >   */
> > 
> > -static unsigned int simple_idr_get(struct idr *idrtable, void *p,
> > -				   spinlock_t *lock)
> > +static int simple_xa_dtstr_get(u32 *id, void *entry)
> > 
> >  {
> > 
> > -	int id;
> > -	unsigned long flags;
> > +	int ret = xa_alloc_irq(&xa_dtstr, id, entry, xa_limit_32b, 
GFP_NOWAIT);
> > +	/* TODO: check for and manage errors */
> > 
> > -	idr_preload(GFP_KERNEL);
> > -	spin_lock_irqsave(lock, flags);
> > -	id = idr_alloc(idrtable, p, 1, INT_MAX, GFP_NOWAIT);
> > -	spin_unlock_irqrestore(lock, flags);
> > -	idr_preload_end();
> > -	/* failure */
> > -	if (id < 0)
> > -		return 0;
> > -	/* idr_alloc() guarantees > 0 */
> > -	return (unsigned int)(id);
> > +	return ret;
> > 
> >  }
> 
> I would think that this wrapper should probably be removed.  It'll almost
> certainly be better to inline the call to xa_alloc_irq() at the call
> sites.
>
I think I got it now.
> 
> You've also changed the behaviour; it used to allocate an id between 1
> and INT_MAX; now it allocates an ID between 0 and UINT_MAX.  Maybe that's
> safe, but you need to argue for it in the changelog.
>
Same as above..
>
> And it shouldn't be using GFP_NOWAIT, but GFP_KERNEL, like the IDR code
> used to do.
>
I'm not sure to understand why idr_preload() uses GFP_KERNEL and instead  
idr_alloc() uses GFP_NOWAIT. I'd better read anew the documentation of the 
above-mentioned functions  
> 
> >  /*
> > 
> > @@ -216,22 +196,25 @@ static unsigned int simple_idr_get(struct idr 
*idrtable, void
> > *p,
> > 
> >   *				completion processing logic for 
a taskmgmt
> >   *				cmd will be able to find who to 
wake up
> >   *				and where to stash the result
> > 
> > - * @idrtable: The data object maintaining the pointer<-->int mappings
> > - * @lock:     A spinlock used when exclusive access to idrtable is needed
> > + * @xa_dtstr: The data object maintaining the pointer<-->int mappings
> 
> You added this in the documentation, but not in the function ...
>
It happened when I wrongly decided to have a global namespace (as I explained 
above).
> 
> >   * @cmdrsp:   Response from the IOVM
> >   * @event:    The event handle to associate with an id
> >   * @result:   The location to place the result of the event handle into
> >   */
> > 
> > -static void setup_scsitaskmgmt_handles(struct idr *idrtable, spinlock_t 
*lock,
> > -				       struct uiscmdrsp *cmdrsp,
> > -				       wait_queue_head_t *event, 
int *result)
> > +static void setup_scsitaskmgmt_handles(struct uiscmdrsp *cmdrsp,
> > +				       wait_queue_head_t *event, 
u32 *result)
> > 
> >  {
> > 
> > -	/* specify the event that has to be triggered when this */
> > -	/* cmd is complete */
> > -	cmdrsp->scsitaskmgmt.notify_handle =
> > -		simple_idr_get(idrtable, event, lock);
> > -	cmdrsp->scsitaskmgmt.notifyresult_handle =
> > -		simple_idr_get(idrtable, result, lock);
> > +	void *entry;
> > +	int ret;
> > +
> > +	/* specify the event that has to be triggered when this cmd is 
complete */
> > +	entry = &cmdrsp->scsitaskmgmt.notify_handle;
> > +	ret = simple_xa_dtstr_get(result, entry);
> > +	/* TODO: Check for and manage errors */
> 
> The prior code assigned the ID for 'event' to scsitaskmgmt.notify_handle.
> Now, you're allocating an ID for the address of scsitaskmgmt.notify_handle
> to 'result'.  That's clearly not right.
> 
That's due to my fault in understanding the semantics of those functions.
>
> > +	entry = &cmdrsp->scsitaskmgmt.notifyresult_handle;
> > +	ret = simple_xa_dtstr_get(result, entry);
> > +	/* TODO: Check for and manage errors */
> > 
> >  }
> >  
> >  /*
> > 
> > @@ -240,13 +223,17 @@ static void setup_scsitaskmgmt_handles(struct idr 
*idrtable,
> > spinlock_t *lock,> 
> >   * @idrtable: The data object maintaining the pointer<-->int mappings
> >   * @cmdrsp:   Response from the IOVM
> >   */
> > 
> > -static void cleanup_scsitaskmgmt_handles(struct idr *idrtable,
> > -					 struct uiscmdrsp 
*cmdrsp)
> > +static void cleanup_scsitaskmgmt_handles(struct uiscmdrsp_scsitaskmgmt 
*scsitaskmgmt)
> > 
> >  {
> > 
> > -	if (cmdrsp->scsitaskmgmt.notify_handle)
> > -		idr_remove(idrtable, cmdrsp-
>scsitaskmgmt.notify_handle);
> > -	if (cmdrsp->scsitaskmgmt.notifyresult_handle)
> > -		idr_remove(idrtable, cmdrsp-
>scsitaskmgmt.notifyresult_handle);
> > +	struct uiscmdrsp *cmdrsp;
> > +	unsigned long index;
> > +
> > +	xa_for_each(&xa_dtstr, index, cmdrsp) {
> > +		if (&cmdrsp->scsitaskmgmt != scsitaskmgmt)
> > +			continue;
> > +		xa_erase(&xa_dtstr, index);
> > +		kfree(cmdrsp);
> > +	}
> 
> I suspect this is part of the same confusion, but the old code passed in an
> ID that we just looked up & removed.  You've changed that to iterate over
> all the entries and remove the ones that match ...
>
I'm not sure if I understand it, however I suppose that you mean that there is 
no need to iterate over all the entries to find the one that matches for the 
purpose of erasing it. I'll look at this issue anew and find out the right way 
for the removals.
> 
> > @@ -1096,7 +1077,7 @@ static void visorhba_remove(struct visor_device 
*dev)
> > 
> >  	scsi_remove_host(scsihost);
> >  	scsi_host_put(scsihost);
> > 
> > -	idr_destroy(&devdata->idr);
> > +	xa_destroy(&xa_dtstr);
> > 
> >  	dev_set_drvdata(&dev->device, NULL);
> >  	debugfs_remove(devdata->debugfs_info);
> 
> What happens if you have two HBAs in the system, one is active and you
> remove the other one?
>
This will not be anymore a problem when I'll restore the use of one namespace 
per HBA. It's correct?
>
> More generally, the IDR required you call idr_destroy() to avoid leaking
> preallocated memory.  I changed that, but there are still many drivers
> that have unnecessary calls to idr_destroy().  It's good form to just
> delete them and not turn them into calls to xa_destroy().
>
This one is a bit obscure to me. I have to look into it more carefully. Maybe 
I'll ask for some further help.

Thanks for your review,

Fabio 



