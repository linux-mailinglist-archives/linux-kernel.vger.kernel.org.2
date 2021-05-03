Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9866B371FA0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 20:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhECS2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 14:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhECS2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 14:28:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EE1C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 11:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=glt/cPP/fwoiLZAKN8q4fKpIiWmgqcVElTx4ldgtY9I=; b=nSnAGfJwVU17YjZ0fYYRQa/Gwa
        hiK5SHRQoaI0ffOzHpYS4poQMqa+fx9Gr6LCXrAIAfA8ue08iHfpBdI+bXN5R89EdGaoEbw/GIekP
        f1JM0tpQloj3aMnJcQ+f+Bx0GNjHuCAt3WUU7NPuPzJl6lm3PiZzj9FkYH2xvFP6lE+82CvmOiqhu
        QDsZdkNXtKwlAuvFjVfAmFE72ID85MYAkvsHnq80jYWPwbgnuF2IjCYZbEKRORoLaF+UqSHyE+q4w
        OS536RsOWxnO212Aj3zkAZ1w+0kPwATKuTD/yX3p7HKtDrnNwACkGIO0QR+cBQS3uFUO17aAvro3L
        BtczUkTg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lddH3-00FTZ2-Au; Mon, 03 May 2021 18:26:40 +0000
Date:   Mon, 3 May 2021 19:26:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Outreachy kernel] [PATCH v5] staging: unisys: visorhba: Convert
 module from IDR to XArray
Message-ID: <20210503182629.GE1847222@casper.infradead.org>
References: <20210427150719.30841-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427150719.30841-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 05:07:19PM +0200, Fabio M. De Francesco wrote:
> Converted visorhba from IDR to XArray. The abstract data type XArray is
> more memory-efficient, parallelisable and cache friendly. It takes
> advantage of RCU to perform lookups without locking.

I think the commit message could use a little more work.  The advantage
of the XArray over the IDR is that it has a better API (and the IDR
interface is deprecated).

> -static void setup_scsitaskmgmt_handles(struct idr *idrtable, spinlock_t *lock,
> -				       struct uiscmdrsp *cmdrsp,
> +static void setup_scsitaskmgmt_handles(struct xarray *xa, struct uiscmdrsp *cmdrsp,
>  				       wait_queue_head_t *event, int *result)
>  {
> -	/* specify the event that has to be triggered when this */
> -	/* cmd is complete */
> -	cmdrsp->scsitaskmgmt.notify_handle =
> -		simple_idr_get(idrtable, event, lock);
> -	cmdrsp->scsitaskmgmt.notifyresult_handle =
> -		simple_idr_get(idrtable, result, lock);
> +	int ret;
> +	u32 id;
> +
> +	/* specify the event that has to be triggered when this cmd is complete */
> +	ret = xa_alloc_irq(xa, &id, event, XA_LIMIT(1, INT_MAX), GFP_KERNEL);
> +	if (ret == 0)
> +		cmdrsp->scsitaskmgmt.notify_handle = id;
> +	ret = xa_alloc_irq(xa, &id, result, XA_LIMIT(1, INT_MAX), GFP_KERNEL);
> +	if (ret == 0)
> +		cmdrsp->scsitaskmgmt.notifyresult_handle = id;
>  }

I think there's a preexisting bug here that you haven't fixed ;-)

Think through the failure case -- if we fail to allocate an ID, then we
can't send the command, because it won't be able to notify on completion.
So I'd start out by making this function return an int (0 on success,
errno on failure).  Then if the first one succeeds and the second fails,
free the first one before returning an error.

>  /*
>   * cleanup_scsitaskmgmt_handles - Forget handles created by
>   *				  setup_scsitaskmgmt_handles()
> - * @idrtable: The data object maintaining the pointer<-->int mappings
> + * @xa: The data object maintaining the pointer<-->int mappings
>   * @cmdrsp:   Response from the IOVM
>   */
> -static void cleanup_scsitaskmgmt_handles(struct idr *idrtable,
> +static void cleanup_scsitaskmgmt_handles(struct xarray *xa,
>  					 struct uiscmdrsp *cmdrsp)
>  {
>  	if (cmdrsp->scsitaskmgmt.notify_handle)
> -		idr_remove(idrtable, cmdrsp->scsitaskmgmt.notify_handle);
> +		xa_erase(xa, cmdrsp->scsitaskmgmt.notify_handle);
>  	if (cmdrsp->scsitaskmgmt.notifyresult_handle)
> -		idr_remove(idrtable, cmdrsp->scsitaskmgmt.notifyresult_handle);
> +		xa_erase(xa, cmdrsp->scsitaskmgmt.notifyresult_handle);
>  }

These can then be unconditional, because cleanup_scsitaskmgmt_handles()
won't get called unless we sent the command.

>  /*
> @@ -284,8 +257,7 @@ static int forward_taskmgmt_command(enum task_mgmt_types tasktype,
>  
>  	/* issue TASK_MGMT_ABORT_TASK */
>  	cmdrsp->cmdtype = CMD_SCSITASKMGMT_TYPE;
> -	setup_scsitaskmgmt_handles(&devdata->idr, &devdata->privlock, cmdrsp,
> -				   &notifyevent, &notifyresult);
> +	setup_scsitaskmgmt_handles(&devdata->xa, cmdrsp, &notifyevent, &notifyresult);

This needs to check the result from setup() and decline to send the
command if it fails.

>  	/* save destination */
>  	cmdrsp->scsitaskmgmt.tasktype = tasktype;
> @@ -311,14 +283,14 @@ static int forward_taskmgmt_command(enum task_mgmt_types tasktype,
>  	dev_dbg(&scsidev->sdev_gendev,
>  		"visorhba: taskmgmt type=%d success; result=0x%x\n",
>  		 tasktype, notifyresult);
> -	cleanup_scsitaskmgmt_handles(&devdata->idr, cmdrsp);
> +	cleanup_scsitaskmgmt_handles(&devdata->xa, cmdrsp);
>  	return SUCCESS;
>  
>  err_del_scsipending_ent:
>  	dev_dbg(&scsidev->sdev_gendev,
>  		"visorhba: taskmgmt type=%d not executed\n", tasktype);
>  	del_scsipending_ent(devdata, scsicmd_id);
> -	cleanup_scsitaskmgmt_handles(&devdata->idr, cmdrsp);
> +	cleanup_scsitaskmgmt_handles(&devdata->xa, cmdrsp);

... be sure not to call cleanup() on that path, though.

>  	return FAILED;
>  }
>  
