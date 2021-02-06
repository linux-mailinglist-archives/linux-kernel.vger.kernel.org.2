Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F53311DEB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 15:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhBFOri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 09:47:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:45274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhBFOr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 09:47:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BB5C64E07;
        Sat,  6 Feb 2021 14:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612622806;
        bh=fxpNf6/vSlVy8KoDHlE/p2NI0kE3WPeb0ArfXHTepJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JiVCcS0asYKhguHBskKR0D6rKTwbTX+XWx3gWtMGyNMsGw7yZZDHOO45j2j25VWOB
         6K/z7LTELt7qL25fjQBQbPV5rp3NVdVadMdqcgPr8IGnXth2887jA4a+h/WY3LNvs8
         g1Ge/nSvTArb7ZjeDG/g0eNAgrjNMICqSqn4Cet8=
Date:   Sat, 6 Feb 2021 15:46:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [char-misc-next 1/6] mei: use sprintf in tx_queue_limit_show
 sysfs
Message-ID: <YB6r1HcHjEQpseaM@kroah.com>
References: <20210206144325.25682-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210206144325.25682-1-tomas.winkler@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 06, 2021 at 04:43:20PM +0200, Tomas Winkler wrote:
> Using of snprintf is discouraged in sysfs.
> For simple u8 it is safe to use sprintf.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  drivers/misc/mei/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
> index 9f6682033ed7..24a05f45b639 100644
> --- a/drivers/misc/mei/main.c
> +++ b/drivers/misc/mei/main.c
> @@ -1026,7 +1026,7 @@ static ssize_t tx_queue_limit_show(struct device *device,
>  	size = dev->tx_queue_limit;
>  	mutex_unlock(&dev->device_lock);
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", size);
> +	return sprintf(buf, "%u\n", size);

If you are going to do this, why not just convert it to use sysfs_emit()
instead?

thanks,

greg k-h
