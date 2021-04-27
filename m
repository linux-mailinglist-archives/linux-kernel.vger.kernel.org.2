Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451CE36C765
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbhD0N6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbhD0N6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:58:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691C3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 06:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2EZ9wMn5IsrCWzyEdIPf+KOdPnl6OIWHe1m9e0dWRa8=; b=kBL8O9EWg/3wmo7Rz/ngkPBWvv
        /lDdibrv2XDWvOvRxeCuN6GBui4ZCegmuOEt0hj4oRbjRSHiTPOYscLy22+WWBpi1LG0CIpEEPe/7
        PE/hqkFuZJMa5lxF32I8uQp7pKtZP1a0AEIHL2W5P3KUOVoozDSosJw+GVBzTpzEn6JcTEEe0suNG
        WnbpyRZEhUIpLmlyraJE3EoJ/VQIt2/S/9h/6uxmSQ52AvaIzhBVgkQPwgHaB+ARVtkYARELujmYf
        BbW9WvwIPcb5CTXNnHIIljHUtpXGDHSXlmh/kXYAdlQfueNAJ+Xf/oUBv5I+WzIPJmfHIzVcIJRkZ
        zZe9U5nA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lbOC6-006zBS-0S; Tue, 27 Apr 2021 13:56:33 +0000
Date:   Tue, 27 Apr 2021 14:56:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Outreachy kernel] [PATCH v4] staging: unisys: visorhba: Convert
 module from IDR to XArray
Message-ID: <20210427135605.GZ235567@casper.infradead.org>
References: <20210427132522.14547-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427132522.14547-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 03:25:22PM +0200, Fabio M. De Francesco wrote:
> +++ b/drivers/staging/unisys/include/iochannel.h
> @@ -474,8 +474,8 @@ struct uiscmdrsp_scsitaskmgmt {
>  	enum task_mgmt_types tasktype;
>  	struct uisscsi_dest vdest;
>  	u64 handle;
> -	u64 notify_handle;
> -	u64 notifyresult_handle;
> +	u32 notify_handle;
> +	u32 notifyresult_handle;
>  	char result;
>  
>  #define TASK_MGMT_FAILED 0

I'm scared of this change.  Read the top of the file:

 * Everything needed for IOPart-GuestPart communication is define in
 * this file. Note: Everything is OS-independent because this file is
 * used by Windows, Linux and possible EFI drivers.

I don't know that you can make any changes to this file.

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
> +	u32 *id;
> +
> +	/* specify the event that has to be triggered when this cmd is complete */
> +	id = &cmdrsp->scsitaskmgmt.notify_handle;
> +	ret = xa_alloc_irq(xa, id, event, XA_LIMIT(1, INT_MAX), GFP_KERNEL);

You're still not handling the error here.

