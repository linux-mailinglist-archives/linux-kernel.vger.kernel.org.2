Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4193E3D73DD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 12:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbhG0K5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 06:57:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236169AbhG0K5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:57:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83488615E5;
        Tue, 27 Jul 2021 10:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627383471;
        bh=ASNLmJOpTtp3ybxyMVC2r+LzfoJ5BL/kbqtmTIjL7ow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fioNlQHhZyFKSGxY9UKhzm6Tb3tevvPiPBSAAMuJDPdknVyr4L8TuPeFE8zzN2Srx
         XuLb5qR/bEmfjUX0fXcuvY3cuxfm4JKfCGd+O7v91AFuGW8eXwGiOpSFjCqKOjeQSO
         U066wW0R3/29FdxISXXoa48iW0e7zOjR05rkk9K8=
Date:   Tue, 27 Jul 2021 12:57:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Filip Schauer <filip@mg6.at>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers core: Fix oops when driver probe fails
Message-ID: <YP/mrfsyUrR576FO@kroah.com>
References: <20210727104035.A03301F01285@dd38112.kasserver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727104035.A03301F01285@dd38112.kasserver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 12:40:35PM +0200, Filip Schauer wrote:
> dma_range_map is freed to early, which might cause an oops when
> a driver probe fails.
>  Call trace:
>   is_free_buddy_page+0xe4/0x1d4
>   __free_pages+0x2c/0x88
>   dma_free_contiguous+0x64/0x80
>   dma_direct_free+0x38/0xb4
>   dma_free_attrs+0x88/0xa0
>   dmam_release+0x28/0x34
>   release_nodes+0x78/0x8c
>   devres_release_all+0xa8/0x110
>   really_probe+0x118/0x2d0
>   __driver_probe_device+0xc8/0xe0
>   driver_probe_device+0x54/0xec
>   __driver_attach+0xe0/0xf0
>   bus_for_each_dev+0x7c/0xc8
>   driver_attach+0x30/0x3c
>   bus_add_driver+0x17c/0x1c4
>   driver_register+0xc0/0xf8
>   __platform_driver_register+0x34/0x40
>   ...
> 
> This issue is introduced by commit d0243bbd5dd3 ("drivers core:
> Free dma_range_map when driver probe failed"). It frees
> dma_range_map before the call to devres_release_all, which is too
> early. The solution is to free dma_range_map only after
> devres_release_all.
> 
> Fixes: d0243bbd5dd3 ("drivers core: Free dma_range_map when driver probe
> failed")
> Signed-off-by: Filip Schauer <filip@mg6.at>
> ---
>  drivers/base/dd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index daeb9b5763ae..437cd61343b2 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -653,8 +653,6 @@ static int really_probe(struct device *dev, struct
> device_driver *drv)
>  	else if (drv->remove)
>  		drv->remove(dev);
>  probe_failed:
> - kfree(dev->dma_range_map);
> - dev->dma_range_map = NULL;
>  	if (dev->bus)
>  		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>  					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
> @@ -662,6 +660,8 @@ static int really_probe(struct device *dev, struct
> device_driver *drv)
>  	device_links_no_driver(dev);
>  	devres_release_all(dev);
>  	arch_teardown_dma_ops(dev);
> + kfree(dev->dma_range_map);
> + dev->dma_range_map = NULL;
>  	driver_sysfs_remove(dev);
>  	dev->driver = NULL;
>  	dev_set_drvdata(dev, NULL);
> -- 
> 2.25.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
