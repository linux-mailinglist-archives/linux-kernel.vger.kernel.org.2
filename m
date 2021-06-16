Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC3F3A9DFC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhFPOqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:46:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234052AbhFPOqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:46:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB14161042;
        Wed, 16 Jun 2021 14:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623854680;
        bh=1BSDaNQfE0DNGtfdmLGFdoYfoKAolCav5h+KOT8hnZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KMBdMHaPk4tcoim9Cf8E6+4hbVInOAJrTUS++kPLhNfAlRUuN0twPoB66ean9WtQy
         U53L1quxFEoyj8bIeeOJy9Ekg0MSV+94zjLRFUgtvmK03D0eMjbb3XhNFYJhq3cxve
         FWuK/qKy/dxL757KqLi4WU3r6x+SjKfOZs00QhkM=
Date:   Wed, 16 Jun 2021 16:44:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Rodolfo Giometti <giometti@enneenne.com>
Subject: Re: [PATCH v1 1/1] pps: generators: pps_gen_parport: Switch to use
 module_parport_driver()
Message-ID: <YMoOVrJ1ETVhRr4F@kroah.com>
References: <20210616143121.46059-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616143121.46059-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 05:31:21PM +0300, Andy Shevchenko wrote:
> Switch to use module_parport_driver() to reduce boilerplate code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pps/generators/pps_gen_parport.c | 44 +++++-------------------
>  1 file changed, 9 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/pps/generators/pps_gen_parport.c b/drivers/pps/generators/pps_gen_parport.c
> index 6a1af7664f3b..565f99782402 100644
> --- a/drivers/pps/generators/pps_gen_parport.c
> +++ b/drivers/pps/generators/pps_gen_parport.c
> @@ -20,8 +20,6 @@
>  #include <linux/hrtimer.h>
>  #include <linux/parport.h>
>  
> -#define DRVDESC "parallel port PPS signal generator"
> -
>  #define SIGNAL		0
>  #define NO_SIGNAL	PARPORT_CONTROL_STROBE
>  
> @@ -180,6 +178,11 @@ static void parport_attach(struct parport *port)
>  {
>  	struct pardev_cb pps_cb;
>  
> +	if (send_delay > SEND_DELAY_MAX) {
> +		pr_err("delay value should be not greater then %d\n", SEND_DELAY_MAX);
> +		return -EINVAL;

Note this is at a later point in time than before, are you sure this is
ok?

> +	}
> +
>  	if (attached) {
>  		/* we already have a port */
>  		return;
> @@ -223,6 +226,8 @@ static void parport_detach(struct parport *port)
>  	hrtimer_cancel(&device.timer);
>  	parport_release(device.pardev);
>  	parport_unregister_device(device.pardev);
> +
> +	pr_info("hrtimer avg error is %ldns\n", hrtimer_error);

Why is this line needed?  When drivers work properly, they are quiet.

I know the existing code has it, no reason it needs to stay here, that's
why we created these macros, to remove the ability for drivers to be
printing junk like this that they do not need to be printing.

thanks,

greg k-h
