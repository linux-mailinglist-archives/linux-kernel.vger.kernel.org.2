Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB1B372B40
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 15:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhEDNn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 09:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhEDNn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 09:43:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D59C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 06:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/A7CKIJkD9/yQn75x3dVFpMhloUMd6NMum1pcYmMTeo=; b=jvpKksiSRZ3SeFHAQJboopnq+B
        GNVKKVYHA+/40bO3bIePcpj/KfWaYqe0jurrKqmnvZqC7G0gvaoafckGZQ12H29Yk+2LJ0WI/t3k6
        6dbLoP2J4yVzOXInItFRlDUE0xlracOF0UQiPHEVIRO6eUS2zRUQpTHDH1NuZP5CBRxeGUnF0KdAl
        4xAeazZqmb4v/Xec1LOews7bHxyGotuQUgHlezxecR1U0A55zxlXw1hBxF18nSem9tPCgRYYwuo+s
        Vn2R2uhiO5e4GT+2MQ3uuUvmIAufnPIvBf6tg0WpOxPspmH+A7rcmT7JP1NJhaJgvbZtJhDufWRYX
        qkrcoqLg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ldvJY-00Gd4j-CY; Tue, 04 May 2021 13:42:22 +0000
Date:   Tue, 4 May 2021 14:42:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com,
        David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v7] staging: unisys: visorhba: Convert module from IDR to
 XArray
Message-ID: <20210504134216.GG1847222@casper.infradead.org>
References: <20210504133253.32269-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504133253.32269-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 03:32:53PM +0200, Fabio M. De Francesco wrote:
> Changes from v6; Added a call to xa_destroy() that I had forgotten.

What?  No!  Go back and re-read what I wrote about this previously.

> +static int setup_scsitaskmgmt_handles(struct xarray *xa, struct uiscmdrsp *cmdrsp,
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
> +	ret = xa_alloc_irq(xa, &id, event, xa_limit_32b, GFP_KERNEL);
> +	if (ret) 
> +		return ret;
> +	else
> +		cmdrsp->scsitaskmgmt.notify_handle = id;

This 'else' is actively confusing.

> +	ret = xa_alloc_irq(xa, &id, result, xa_limit_32b, GFP_KERNEL);
> +	if (ret) {
> +		xa_erase_irq(xa, cmdrsp->scsitaskmgmt.notify_handle);
> +		return ret;
> +	} else
> +		cmdrsp->scsitaskmgmt.notifyresult_handle = id;

Ditto.

