Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D49836B280
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 13:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhDZLuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 07:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhDZLuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 07:50:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBC5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 04:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SYKQ9oCxcSWwe5wSwHhuDS6qiub6VAFCoqgUBic5noU=; b=JcaImW1gEK6h9q8tQwRD8bt6Vx
        CMbiB9SUpKICdiMygGUpNyrxLl/zCXJQeqOQrL+hEipcnO64TKBBsz9v95ULi/qW5AqHcFNHtNcbj
        7J+N9exjen/qSrf2/OAPlOzGUN9PPZOHvvNE72ytzOOj7gtT1+eI2YO0QEKoLQY6zXSOt0g/7etIU
        sntT5M5TTJ5LwQG/UTONKMURpYasR+OlXF9PZ08uLil0la547od4+ZUqV1H7iUaybUnfzDT95jVYy
        D04/oWWIMTgiyAYPG+627zGFyZcQXKQSFZ8E5Mt1okA0HKkfhy3vGTz4FY3J2vbZb1gDXI6KxUYgi
        9pXu/WpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lazja-005Z51-Dy; Mon, 26 Apr 2021 11:49:11 +0000
Date:   Mon, 26 Apr 2021 12:49:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Outreachy kernel] [RFC PATCH] staging: unisys: visorhba:
 Convert module from IDR to XArray
Message-ID: <20210426114902.GI235567@casper.infradead.org>
References: <20210426095015.18556-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426095015.18556-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 11:50:15AM +0200, Fabio M. De Francesco wrote:
>  #define VISORHBA_ERROR_COUNT 30
>  
> +static DEFINE_XARRAY_ALLOC(xa_dtstr);
> +
>  static struct dentry *visorhba_debugfs_dir;
>  
>  /* GUIDS for HBA channel type supported by this driver */
> @@ -78,12 +80,6 @@ struct visorhba_devdata {
>  	unsigned int max_buff_len;
>  	int devnum;
>  	struct uiscmdrsp *cmdrsp;
> -	/*
> -	 * allows us to pass int handles back-and-forth between us and
> -	 * iovm, instead of raw pointers
> -	 */
> -	struct idr idr;
> -

Why did you change the driver from having one namespace per HBA to having
a global namespace?

>  /*
> - * simple_idr_get - Associate a provided pointer with an int value
> - *		    1 <= value <= INT_MAX, and return this int value;
> - *		    the pointer value can be obtained later by passing
> - *		    this int value to idr_find()
> - * @idrtable: The data object maintaining the pointer<-->int mappings
> - * @p:	      The pointer value to be remembered
> - * @lock:     A spinlock used when exclusive access to idrtable is needed
> - *
> - * Return: The id number mapped to pointer 'p', 0 on failure
> + * simple_xa_dtstr_get - Store a pointer to xa_dtstr xarray
> + * @id: Pointer to ID
> + * @entry: New entry
>   */
> -static unsigned int simple_idr_get(struct idr *idrtable, void *p,
> -				   spinlock_t *lock)
> +static int simple_xa_dtstr_get(u32 *id, void *entry)
>  {
> -	int id;
> -	unsigned long flags;
> +	int ret = xa_alloc_irq(&xa_dtstr, id, entry, xa_limit_32b, GFP_NOWAIT);
> +	/* TODO: check for and manage errors */
>  
> -	idr_preload(GFP_KERNEL);
> -	spin_lock_irqsave(lock, flags);
> -	id = idr_alloc(idrtable, p, 1, INT_MAX, GFP_NOWAIT);
> -	spin_unlock_irqrestore(lock, flags);
> -	idr_preload_end();
> -	/* failure */
> -	if (id < 0)
> -		return 0;
> -	/* idr_alloc() guarantees > 0 */
> -	return (unsigned int)(id);
> +	return ret;
>  }

I would think that this wrapper should probably be removed.  It'll almost
certainly be better to inline the call to xa_alloc_irq() at the call
sites.

You've also changed the behaviour; it used to allocate an id between 1
and INT_MAX; now it allocates an ID between 0 and UINT_MAX.  Maybe that's
safe, but you need to argue for it in the changelog.

And it shouldn't be using GFP_NOWAIT, but GFP_KERNEL, like the IDR code
used to do.

>  /*
> @@ -216,22 +196,25 @@ static unsigned int simple_idr_get(struct idr *idrtable, void *p,
>   *				completion processing logic for a taskmgmt
>   *				cmd will be able to find who to wake up
>   *				and where to stash the result
> - * @idrtable: The data object maintaining the pointer<-->int mappings
> - * @lock:     A spinlock used when exclusive access to idrtable is needed
> + * @xa_dtstr: The data object maintaining the pointer<-->int mappings

You added this in the documentation, but not in the function ...

>   * @cmdrsp:   Response from the IOVM
>   * @event:    The event handle to associate with an id
>   * @result:   The location to place the result of the event handle into
>   */
> -static void setup_scsitaskmgmt_handles(struct idr *idrtable, spinlock_t *lock,
> -				       struct uiscmdrsp *cmdrsp,
> -				       wait_queue_head_t *event, int *result)
> +static void setup_scsitaskmgmt_handles(struct uiscmdrsp *cmdrsp,
> +				       wait_queue_head_t *event, u32 *result)
>  {
> -	/* specify the event that has to be triggered when this */
> -	/* cmd is complete */
> -	cmdrsp->scsitaskmgmt.notify_handle =
> -		simple_idr_get(idrtable, event, lock);
> -	cmdrsp->scsitaskmgmt.notifyresult_handle =
> -		simple_idr_get(idrtable, result, lock);
> +	void *entry;
> +	int ret;
> +
> +	/* specify the event that has to be triggered when this cmd is complete */
> +	entry = &cmdrsp->scsitaskmgmt.notify_handle;
> +	ret = simple_xa_dtstr_get(result, entry);
> +	/* TODO: Check for and manage errors */

The prior code assigned the ID for 'event' to scsitaskmgmt.notify_handle.
Now, you're allocating an ID for the address of scsitaskmgmt.notify_handle
to 'result'.  That's clearly not right.

> +	entry = &cmdrsp->scsitaskmgmt.notifyresult_handle;
> +	ret = simple_xa_dtstr_get(result, entry);
> +	/* TODO: Check for and manage errors */
>  }
>  
>  /*
> @@ -240,13 +223,17 @@ static void setup_scsitaskmgmt_handles(struct idr *idrtable, spinlock_t *lock,
>   * @idrtable: The data object maintaining the pointer<-->int mappings
>   * @cmdrsp:   Response from the IOVM
>   */
> -static void cleanup_scsitaskmgmt_handles(struct idr *idrtable,
> -					 struct uiscmdrsp *cmdrsp)
> +static void cleanup_scsitaskmgmt_handles(struct uiscmdrsp_scsitaskmgmt *scsitaskmgmt)
>  {
> -	if (cmdrsp->scsitaskmgmt.notify_handle)
> -		idr_remove(idrtable, cmdrsp->scsitaskmgmt.notify_handle);
> -	if (cmdrsp->scsitaskmgmt.notifyresult_handle)
> -		idr_remove(idrtable, cmdrsp->scsitaskmgmt.notifyresult_handle);
> +	struct uiscmdrsp *cmdrsp;
> +	unsigned long index;
> +
> +	xa_for_each(&xa_dtstr, index, cmdrsp) {
> +		if (&cmdrsp->scsitaskmgmt != scsitaskmgmt)
> +			continue;
> +		xa_erase(&xa_dtstr, index);
> +		kfree(cmdrsp);
> +	}

I suspect this is part of the same confusion, but the old code passed in an
ID that we just looked up & removed.  You've changed that to iterate over
all the entries and remove the ones that match ...

> @@ -1096,7 +1077,7 @@ static void visorhba_remove(struct visor_device *dev)
>  	scsi_remove_host(scsihost);
>  	scsi_host_put(scsihost);
>  
> -	idr_destroy(&devdata->idr);
> +	xa_destroy(&xa_dtstr);
>  
>  	dev_set_drvdata(&dev->device, NULL);
>  	debugfs_remove(devdata->debugfs_info);

What happens if you have two HBAs in the system, one is active and you
remove the other one?

More generally, the IDR required you call idr_destroy() to avoid leaking
preallocated memory.  I changed that, but there are still many drivers
that have unnecessary calls to idr_destroy().  It's good form to just
delete them and not turn them into calls to xa_destroy().
