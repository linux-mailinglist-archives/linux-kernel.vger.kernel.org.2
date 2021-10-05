Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EFB4227F5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 15:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbhJENfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 09:35:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234103AbhJENfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 09:35:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE28F61354;
        Tue,  5 Oct 2021 13:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633440824;
        bh=ZUUrKlD8Dxp8jS8b/ulbcqRNvv1zelSYWWpWiZKXWgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e3Nt8yedFhKHuTLKdQwElOYdptr1+5wQVSTeAilOgmFqhNRctCSHlLmpXZuRdzAOj
         7gUMkK7wrtxAeyiDA81CbKI4JMje0iIlOeeVxOvf9R4g2dYUTAfbhapky2TaelSFY3
         tjQNL7I1fRZH6LlPKEvHFsp3dBFjknffH5PAEUFY=
Date:   Tue, 5 Oct 2021 15:33:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Amit Shah <amit@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio_console: break out of buf poll on remove
Message-ID: <YVxUNudHGxURHH/4@kroah.com>
References: <20211005070354.265164-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005070354.265164-1-mst@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 03:04:07AM -0400, Michael S. Tsirkin wrote:
> A common pattern for device reset is currently:
> vdev->config->reset(vdev);
> .. cleanup ..
> 
> reset prevents new interrupts from arriving and waits for interrupt
> handlers to finish.
> 
> However if - as is common - the handler queues a work request which is
> flushed during the cleanup stage, we have code adding buffers / trying
> to get buffers while device is reset. Not good.
> 
> This was reproduced by running
> 	modprobe virtio_console
> 	modprobe -r virtio_console
> in a loop.

That's a pathological case that is not "in the field" except by people
who want to abuse the system as root.  And they can do much worse things
than that.

> Fixing this comprehensively needs some thought, and new APIs.
> Let's at least handle the specific case of virtio_console
> removal that was reported in the field.

Let's fix this correctly, don't just hack it up now.

> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1786239
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/char/virtio_console.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 7eaf303a7a86..c852ce0b4d56 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1956,6 +1956,12 @@ static void virtcons_remove(struct virtio_device *vdev)
>  	list_del(&portdev->list);
>  	spin_unlock_irq(&pdrvdata_lock);
>  
> +	/* Device is going away, exit any polling for buffers */
> +	virtio_break_device(vdev);
> +	if (use_multiport(portdev))
> +		flush_work(&portdev->control_work);
> +	else
> +		flush_work(&portdev->config_work);
>  	/* Disable interrupts for vqs */

newline before comment?

thanks,

greg k-h
