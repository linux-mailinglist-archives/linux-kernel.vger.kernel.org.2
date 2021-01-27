Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA902305ABF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 13:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237620AbhA0MEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 07:04:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:41274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237511AbhA0MCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 07:02:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E466F20771;
        Wed, 27 Jan 2021 12:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611748911;
        bh=8CqnV6T3SOpv1jkdFLhe9QmYQq/lPIWTvBfS5HhabSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ep/M6mDgRv1KTCGLb3E23kCs11pEReoxdm9dJjyNTMN1mZ940efBVpAVu/crsHzSS
         Lo3jEMtHhLC9pjmeDTkNU3tT367XgWcrp9sWqBtqKMDtjVlMk7hTEHBSBZUkvVcQjn
         I/HBxTg4gGbCsBDi4cLGcCGTnGviNIyMjSjhplIU=
Date:   Wed, 27 Jan 2021 13:01:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Kershner <david.kershner@unisys.com>,
        Song Chen <chensong_2000@189.cn>
Cc:     linux-kernel@vger.kernel.org, jkc@redhat.com,
        sparmaintainer@unisys.com
Subject: Re: [PATCH] staging: unisys: visornic: enhance visornic to use
 channel_interrupt
Message-ID: <YBFWLAZGlp7zJ8bX@kroah.com>
References: <1610439940-5590-1-git-send-email-chensong_2000@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610439940-5590-1-git-send-email-chensong_2000@189.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 04:25:40PM +0800, Song Chen wrote:
> visornic uses timer to check the response queue and drain
> it if needed periodically. On the other hand, visorbus
> provides periodic work to serve such request, therefore,
> timer should be replaced by channel_interrupt.
> 
> Signed-off-by: Song Chen <chensong_2000@189.cn>
> ---
>  drivers/staging/unisys/visornic/visornic_main.c | 32 +++++++++----------------
>  1 file changed, 11 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/staging/unisys/visornic/visornic_main.c b/drivers/staging/unisys/visornic/visornic_main.c
> index 0433536..09d86156 100644
> --- a/drivers/staging/unisys/visornic/visornic_main.c
> +++ b/drivers/staging/unisys/visornic/visornic_main.c
> @@ -122,7 +122,6 @@ struct chanstat {
>   * @n_rcv_packets_not_accepted:     # bogs rcv packets.
>   * @queuefullmsg_logged:
>   * @struct chstat:
> - * @struct irq_poll_timer:
>   * @struct napi:
>   * @struct cmdrsp:
>   */
> @@ -183,7 +182,6 @@ struct visornic_devdata {
>  
>  	int queuefullmsg_logged;
>  	struct chanstat chstat;
> -	struct timer_list irq_poll_timer;
>  	struct napi_struct napi;
>  	struct uiscmdrsp cmdrsp[SIZEOF_CMDRSP];
>  };
> @@ -341,7 +339,7 @@ static void visornic_serverdown_complete(struct visornic_devdata *devdata)
>  	struct net_device *netdev = devdata->netdev;
>  
>  	/* Stop polling for interrupts */
> -	del_timer_sync(&devdata->irq_poll_timer);
> +	visorbus_disable_channel_interrupts(devdata->dev);
>  
>  	rtnl_lock();
>  	dev_close(netdev);
> @@ -1749,17 +1747,17 @@ static int visornic_poll(struct napi_struct *napi, int budget)
>  	return rx_count;
>  }
>  
> -/* poll_for_irq	- checks the status of the response queue
> - * @t: pointer to the 'struct timer_list' from which we can retrieve the
> - *     the visornic devdata struct.
> +/* visornic_channel_interrupt	- checks the status of the response queue
>   *
>   * Main function of the vnic_incoming thread. Periodically check the response
>   * queue and drain it if needed.
>   */
> -static void poll_for_irq(struct timer_list *t)
> +static void visornic_channel_interrupt(struct visor_device *dev)
>  {
> -	struct visornic_devdata *devdata = from_timer(devdata, t,
> -						      irq_poll_timer);
> +	struct visornic_devdata *devdata = dev_get_drvdata(&dev->device);
> +
> +	if (!devdata)
> +		return;
>  
>  	if (!visorchannel_signalempty(
>  				   devdata->dev->visorchannel,
> @@ -1768,7 +1766,6 @@ static void poll_for_irq(struct timer_list *t)
>  
>  	atomic_set(&devdata->interrupt_rcvd, 0);
>  
> -	mod_timer(&devdata->irq_poll_timer, msecs_to_jiffies(2));
>  }
>  
>  /* visornic_probe - probe function for visornic devices
> @@ -1890,13 +1887,6 @@ static int visornic_probe(struct visor_device *dev)
>  	/* Let's start our threads to get responses */
>  	netif_napi_add(netdev, &devdata->napi, visornic_poll, NAPI_WEIGHT);
>  
> -	timer_setup(&devdata->irq_poll_timer, poll_for_irq, 0);
> -	/* Note: This time has to start running before the while
> -	 * loop below because the napi routine is responsible for
> -	 * setting enab_dis_acked
> -	 */
> -	mod_timer(&devdata->irq_poll_timer, msecs_to_jiffies(2));
> -
>  	channel_offset = offsetof(struct visor_io_channel,
>  				  channel_header.features);
>  	err = visorbus_read_channel(dev, channel_offset, &features, 8);
> @@ -1949,7 +1939,7 @@ static int visornic_probe(struct visor_device *dev)
>  	unregister_netdev(netdev);
>  
>  cleanup_napi_add:
> -	del_timer_sync(&devdata->irq_poll_timer);
> +	visorbus_disable_channel_interrupts(dev);
>  	netif_napi_del(&devdata->napi);
>  
>  cleanup_xmit_cmdrsp:
> @@ -2017,7 +2007,7 @@ static void visornic_remove(struct visor_device *dev)
>  	/* this will call visornic_close() */
>  	unregister_netdev(netdev);
>  
> -	del_timer_sync(&devdata->irq_poll_timer);
> +	visorbus_disable_channel_interrupts(devdata->dev);
>  	netif_napi_del(&devdata->napi);
>  
>  	dev_set_drvdata(&dev->device, NULL);
> @@ -2091,7 +2081,7 @@ static int visornic_resume(struct visor_device *dev,
>  	 * we can start using the device again.
>  	 * TODO: State transitions
>  	 */
> -	mod_timer(&devdata->irq_poll_timer, msecs_to_jiffies(2));
> +	visorbus_enable_channel_interrupts(dev);
>  
>  	rtnl_lock();
>  	dev_open(netdev, NULL);
> @@ -2113,7 +2103,7 @@ static struct visor_driver visornic_driver = {
>  	.remove = visornic_remove,
>  	.pause = visornic_pause,
>  	.resume = visornic_resume,
> -	.channel_interrupt = NULL,
> +	.channel_interrupt = visornic_channel_interrupt,
>  };
>  
>  /* visornic_init - init function
> -- 
> 2.7.4
> 

David, have you reviewed this?

thanks,

greg k-h
