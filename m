Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCE932A221
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836640AbhCBHTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:19:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:43610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835931AbhCBG1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:27:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C2A46148E;
        Tue,  2 Mar 2021 06:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614666426;
        bh=+3Kv/EyqZjPRD+Ojky4zLLPgLaC/qvoYz7Cg7qQNlrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TosIvsAfWKqiI7ePx73vBmF1fNpgflKKlKo9BMAvbAdW9Kg7T8LXGGUs9s5lq2IAg
         S6R6h1F57+OkErmWIhAzD56x8wVue/UN5C/GrVcdbuDC3V6TvSiwYJk66blRUgL1QY
         mDMvP2uGGxahSHsfTRbZjGczc/B9ABsJE2i4AaUE=
Date:   Tue, 2 Mar 2021 07:27:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     rikard.falkeborn@gmail.com, zbr@ioremap.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w1: ds2708 and ds2781 use the new API kobj_to_dev()
Message-ID: <YD3atYZfpTh0XliL@kroah.com>
References: <1614665822-12258-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614665822-12258-1-git-send-email-tiantao6@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 02:17:02PM +0800, Tian Tao wrote:
> fix the below warnning which reported by coccicheck.
> /drivers/w1/slaves/w1_ds2780.c:93:60-61: WARNING opportunity for
> kobj_to_dev().
> /drivers/w1/slaves/w1_ds2781.c:90:60-61: WARNING opportunity for
> kobj_to_dev().
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/w1/slaves/w1_ds2780.c | 2 +-
>  drivers/w1/slaves/w1_ds2781.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/w1/slaves/w1_ds2780.c b/drivers/w1/slaves/w1_ds2780.c
> index c281fe5..9dcb5a5 100644
> --- a/drivers/w1/slaves/w1_ds2780.c
> +++ b/drivers/w1/slaves/w1_ds2780.c
> @@ -90,7 +90,7 @@ static ssize_t w1_slave_read(struct file *filp, struct kobject *kobj,
>  			     struct bin_attribute *bin_attr, char *buf,
>  			     loff_t off, size_t count)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	return w1_ds2780_io(dev, buf, off, count, 0);
>  }
>  
> diff --git a/drivers/w1/slaves/w1_ds2781.c b/drivers/w1/slaves/w1_ds2781.c
> index f0d393a..2cb7c02 100644
> --- a/drivers/w1/slaves/w1_ds2781.c
> +++ b/drivers/w1/slaves/w1_ds2781.c
> @@ -87,7 +87,7 @@ static ssize_t w1_slave_read(struct file *filp, struct kobject *kobj,
>  			     struct bin_attribute *bin_attr, char *buf,
>  			     loff_t off, size_t count)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	return w1_ds2781_io(dev, buf, off, count, 0);
>  }
>  
> -- 
> 2.7.4
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
