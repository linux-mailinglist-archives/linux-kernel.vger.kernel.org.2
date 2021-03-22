Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBCD343DDF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 11:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhCVK3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 06:29:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230138AbhCVK3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 06:29:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 624EC6198E;
        Mon, 22 Mar 2021 10:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616408970;
        bh=H8FQeltG/qRdRYgEUxZoytMISl+An60tg9dDVqJ0ekI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AjJGaMzhXjn74BfMqOSda2ZEmhcQHzBawVJITQaK6E2Z6/K5ynoo0rD55zb2qKKcM
         Yefy+HR11vlqyoHIBenqFGdV71Ca7mbkPyJH+Hil09EfqQ1i3L3+KW2/l7s3/1vL88
         IsWAhuYRSRQXv6EwtZmKwvsU9tJVGjIzYBzTqpBM=
Date:   Mon, 22 Mar 2021 11:29:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devcoredump: avoid -Wempty-body warnings
Message-ID: <YFhxhyXLyTqp4ppH@kroah.com>
References: <20210322102002.28990-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322102002.28990-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 11:19:53AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Cleaning out the last -Wempty-body warnings found some interesting
> cases with empty macros, along with harmless warnings like this one:
> 
> drivers/base/devcoredump.c: In function 'dev_coredumpm':
> drivers/base/devcoredump.c:297:56: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
>   297 |                 /* nothing - symlink will be missing */;
>       |                                                        ^
> drivers/base/devcoredump.c:301:56: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
>   301 |                 /* nothing - symlink will be missing */;
>       |                                                        ^
> 
> Randy tried addressing this one before, and there were multiple
> other ideas in that thread.
> 
> Pick up the one that Matthew Wilcox suggested by adding a
> WARN_ON_ONCE() and a comment.
> 
> Link: https://lore.kernel.org/lkml/20200418184111.13401-8-rdunlap@infradead.org/
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/base/devcoredump.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
> index 9243468e2c99..88e0d931439e 100644
> --- a/drivers/base/devcoredump.c
> +++ b/drivers/base/devcoredump.c
> @@ -292,13 +292,16 @@ void dev_coredumpm(struct device *dev, struct module *owner,
>  	if (device_add(&devcd->devcd_dev))
>  		goto put_device;
>  
> -	if (sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
> -			      "failing_device"))
> -		/* nothing - symlink will be missing */;
> +	/*
> +	 * These should normally not fail, but there is no problem
> +	 * continuing without the links, so just warn instead of
> +	 * failing.
> +	 */
> +	WARN_ON_ONCE(sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
> +				       "failing_device"));
>  
> -	if (sysfs_create_link(&dev->kobj, &devcd->devcd_dev.kobj,
> -			      "devcoredump"))
> -		/* nothing - symlink will be missing */;
> +	WARN_ON_ONCE(sysfs_create_link(&dev->kobj, &devcd->devcd_dev.kobj,
> +				       "devcoredump"));

We do not want to reboot machines that have panic-on-warn set, so if
this really needs a trace dump, please do that instead...

thanks,

greg k-h
