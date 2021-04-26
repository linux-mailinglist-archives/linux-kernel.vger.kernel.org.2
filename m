Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28ED636B9EA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 21:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240215AbhDZTV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 15:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239038AbhDZTV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 15:21:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF44C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 12:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5LaqQeBsNBHU9D9jZgjWkNwbT7whKdIcOp7Scece9yQ=; b=ZlCvedhhe+0hN8sK0mbS6kAgvL
        +GPvZWgvOyaFM8lynXHsvjoIOKX0H3LR0Rw/IHh4vf/MDNJbypiFUjVTUWXbA+dti2wnCzteYyOf5
        NFRCWV+oAX0yzXfXp+S33CFFw5uTtlbRMOmKki+D89ne/gzmrfeWzFIYrlfJSvTAYVbnLOia0ghnw
        7Xf3wp8J2YMpgp0N756wucqRhoRlku1NqP5CVVKyGQMfmVXVnMCOV2rd3/TzD1UI6K098/yUksab/
        sx9wdnbzinoSkEj3GB48lsRBDHlFgVIJkyoYRwXHui3yBDqNSgZOld8MDNhP2DSziy/Hbi+Voh3rQ
        QV7ZfNbw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lb6mz-0060Kk-Fr; Mon, 26 Apr 2021 19:21:05 +0000
Date:   Mon, 26 Apr 2021 20:21:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Outreachy kernel] [PATCH v3] staging: unisys: visorhba: Convert
 module from IDR to XArray
Message-ID: <20210426192101.GQ235567@casper.infradead.org>
References: <20210426184245.12269-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426184245.12269-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 08:42:45PM +0200, Fabio M. De Francesco wrote:
> +static void setup_scsitaskmgmt_handles(struct xarray *xa, struct uiscmdrsp *cmdrsp,
>  				       wait_queue_head_t *event, int *result)
>  {
> -	/* specify the event that has to be triggered when this */
> -	/* cmd is complete */
> -	cmdrsp->scsitaskmgmt.notify_handle =
> -		simple_idr_get(idrtable, event, lock);
> -	cmdrsp->scsitaskmgmt.notifyresult_handle =
> -		simple_idr_get(idrtable, result, lock);
> +	u32 id;
> +	int ret;
> +
> +	/* specify the event that has to be triggered when this cmd is complete */
> +	id = (u32)cmdrsp->scsitaskmgmt.notify_handle;
> +	ret = xa_alloc_irq(xa, &id, event, XA_LIMIT(1, INT_MAX), GFP_KERNEL);

OK, think this one through a bit.  When xa_alloc_irq() stores the ID that
it assigned into 'id', what happens to it next?

> +	id = (u32)cmdrsp->scsitaskmgmt.notifyresult_handle;
> +	ret = xa_alloc_irq(xa, &id, result, XA_LIMIT(1, INT_MAX), GFP_KERNEL);
>  }

> @@ -1053,8 +1018,6 @@ static int visorhba_probe(struct visor_device *dev)
>  	if (err)
>  		goto err_debugfs_info;
>  
> -	idr_init(&devdata->idr);

You still need to initialise the XArray, either with xa_init() or by
using DEFINE_XARRAY.  Since it's dynamically allocated, the former is
correct.

