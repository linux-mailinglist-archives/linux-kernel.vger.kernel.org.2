Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98AC38C16F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 10:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhEUIMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 04:12:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236504AbhEUILR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 04:11:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC68C613AC;
        Fri, 21 May 2021 08:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621584583;
        bh=p7WwnQdSFrNgqO1+xlVddhFe1Xli0Ua4cshCl/Mhf7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wmmr9R7QlZUFyq86M9IhZmjJD40dTQS2iLq86t5Ydlspw8JJYhj+rB6wbpGQY/lVB
         ectXxMOC0BOiQt9aoPIezZcD8iSxT2p1EWSIkcYpMlZVTqz1q0zhYmfchD3Tjehwvz
         nfZ5YkolR35iObWv3H/zF3Ul6lPXOa7WGxrXXKDM=
Date:   Fri, 21 May 2021 10:09:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        paulkf@microgate.com
Subject: Re: [PATCH 05/16] char: pcmcia: synclink_cs: Fix a bunch of
 kernel-doc issues
Message-ID: <YKdqxYsVineUqqFf@kroah.com>
References: <20210520121347.3467794-1-lee.jones@linaro.org>
 <20210520121347.3467794-6-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520121347.3467794-6-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 01:13:36PM +0100, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/char/pcmcia/synclink_cs.c:4068: warning: Function parameter or member 'dev' not described in 'hdlcdev_ioctl'
>  drivers/char/pcmcia/synclink_cs.c:4068: warning: Function parameter or member 'ifr' not described in 'hdlcdev_ioctl'
>  drivers/char/pcmcia/synclink_cs.c:4068: warning: Function parameter or member 'cmd' not described in 'hdlcdev_ioctl'
>  drivers/char/pcmcia/synclink_cs.c:4068: warning: expecting prototype for called by network layer to process IOCTL call to network device(). Prototype was for hdlcdev_ioctl() instead
>  drivers/char/pcmcia/synclink_cs.c:4173: warning: Function parameter or member 'txqueue' not described in 'hdlcdev_tx_timeout'
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: paulkf@microgate.com
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/char/pcmcia/synclink_cs.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
> index 4a1e63911b279..b004abac61542 100644
> --- a/drivers/char/pcmcia/synclink_cs.c
> +++ b/drivers/char/pcmcia/synclink_cs.c
> @@ -4054,11 +4054,12 @@ static int hdlcdev_close(struct net_device *dev)
>  }
>  
>  /**
> - * called by network layer to process IOCTL call to network device
> + * hdlcdev_ioctl() - called by network layer to process IOCTL call
> + *                   to network device
>   *
> - * dev  pointer to network device structure
> - * ifr  pointer to network interface request structure
> - * cmd  IOCTL command code
> + * @dev:  pointer to network device structure
> + * @ifr:  pointer to network interface request structure
> + * @cmd:  IOCTL command code
>   *
>   * returns 0 if success, otherwise error code
>   */
> @@ -4165,7 +4166,8 @@ static int hdlcdev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
>   * hdlcdev_tx_timeout() - called by network layer when transmit timeout
>   *                        is detected
>   *
> - * @dev:  pointer to network device structure
> + * @dev:      pointer to network device structure
> + * @txqueue:  unused
>   */
>  static void hdlcdev_tx_timeout(struct net_device *dev, unsigned int txqueue)
>  {
> -- 
> 2.31.1
> 

This one did not apply to my tree :(
