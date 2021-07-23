Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865393D3504
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 09:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbhGWGYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 02:24:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234089AbhGWGYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 02:24:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D09260EAF;
        Fri, 23 Jul 2021 07:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627023914;
        bh=bdg4IKmEOmIJGi9bkVNvHhOylDYZgIWiL34s3A6QfpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KU+G+f3V+IKPMrH7fYe6wtoHAY292z9gPpkLy1mRmfD+9fI6nY2gSqQX1dBQPeoRK
         oXNUBVPiVjRS4pokelk4eS6v9UEuJ/j7F2ZibDKupbXHZsAQmBFXL3QncaDzvC0IoP
         se6vu0db4vug1+ZCIzEXP/EgSDZs0WJS6f6i4P/8=
Date:   Fri, 23 Jul 2021 09:05:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        rajatxjain@gmail.com
Subject: Re: [PATCH] thunderbolt: For dev authorization changes, include the
 actual event in udev change notification
Message-ID: <YPpqJ6k5M3skTYdA@kroah.com>
References: <20210723012835.1935471-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723012835.1935471-1-rajatja@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 06:28:34PM -0700, Rajat Jain wrote:
> For security, we would like to monitor and track when the
> thunderbolt devices are authorized and deauthorized. Currently
> the userspace gets a udev change notification when there is a
> change, but the state may have changed (again) by the time we
> look at the authorized attribute in sysfs. So an authorization
> event may go unnoticed. Thus make it easier by informing the
> actual change (authorized/deauthorized) in the udev change
> notification.

We do have 72 columns to work with... :)

> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>  drivers/thunderbolt/switch.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index 83b1ef3d5d03..5d3e9dcba44a 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -1499,6 +1499,7 @@ static ssize_t authorized_show(struct device *dev,
>  static int disapprove_switch(struct device *dev, void *not_used)
>  {
>  	struct tb_switch *sw;
> +	char *envp[] = { "AUTHORIZED=0", NULL };
>  
>  	sw = tb_to_switch(dev);
>  	if (sw && sw->authorized) {
> @@ -1514,7 +1515,7 @@ static int disapprove_switch(struct device *dev, void *not_used)
>  			return ret;
>  
>  		sw->authorized = 0;
> -		kobject_uevent(&sw->dev.kobj, KOBJ_CHANGE);
> +		kobject_uevent_env(&sw->dev.kobj, KOBJ_CHANGE, envp);
>  	}
>  
>  	return 0;
> @@ -1523,6 +1524,8 @@ static int disapprove_switch(struct device *dev, void *not_used)
>  static int tb_switch_set_authorized(struct tb_switch *sw, unsigned int val)
>  {
>  	int ret = -EINVAL;
> +	char envp_string[13];
> +	char *envp[] = { envp_string, NULL };
>  
>  	if (!mutex_trylock(&sw->tb->lock))
>  		return restart_syscall();
> @@ -1560,7 +1563,8 @@ static int tb_switch_set_authorized(struct tb_switch *sw, unsigned int val)
>  	if (!ret) {
>  		sw->authorized = val;
>  		/* Notify status change to the userspace */
> -		kobject_uevent(&sw->dev.kobj, KOBJ_CHANGE);
> +		sprintf(envp_string, "AUTHORIZED=%u", val);
> +		kobject_uevent_env(&sw->dev.kobj, KOBJ_CHANGE, envp);

So now "val" is a userspace visable value?  Is that documented anywhere
what it is and what are you going to do to ensure it never changes in
the future?

Also this new value "field" should be documented somewhere as well,
otherwise how will any tool know it is there?

And what userspace tool will be looking for this?

thanks,

greg k-h
