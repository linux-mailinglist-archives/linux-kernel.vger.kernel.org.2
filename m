Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3631B392AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbhE0JnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:43:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235675AbhE0Jmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:42:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D4F1613E9;
        Thu, 27 May 2021 09:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622108481;
        bh=4xVJXPa7VlFF52HmWIoRuIgF7KKFuNeS/i1lX4FoDlE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eH0PUMohDmqbgUkqLzeGPPawhTu7XvNI29tR/bmmkT/DmTiPQWk6v9oV6hy2Np0hR
         Of2z0DCqlqDu6pXjGDnleIikqaLA5ktTItS7G2JK7GjXX9k4jaySwqNOUF5R/vSjTT
         zXOEqrLOpglTrUAm2X7O3lT+ELslouFyjzOXezlg=
Date:   Thu, 27 May 2021 11:41:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        weiyongjun1@huawei.com, yuehaibing@huawei.com,
        yangjihong1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH -next] driver core: Remove set but not used variable
 'no_warn'
Message-ID: <YK9pPlItu+l9OROk@kroah.com>
References: <20210527091453.3880695-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210527091453.3880695-1-libaokun1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 05:14:53PM +0800, Baokun Li wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/base/module.c: In function 'module_create_drivers_dir':
> drivers/base/module.c:36:6: warning:
>  variable ‘no_warn’ set but not used [-Wunused-but-set-variable]
> 
> It never used since introduction.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  drivers/base/module.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/module.c b/drivers/base/module.c
> index 46ad4d636731..07ecd66b12b0 100644
> --- a/drivers/base/module.c
> +++ b/drivers/base/module.c
> @@ -33,7 +33,6 @@ static void module_create_drivers_dir(struct module_kobject *mk)
>  void module_add_driver(struct module *mod, struct device_driver *drv)
>  {
>  	char *driver_name;
> -	int no_warn;
>  	struct module_kobject *mk = NULL;
>  
>  	if (!drv)
> @@ -59,12 +58,12 @@ void module_add_driver(struct module *mod, struct device_driver *drv)
>  		return;
>  
>  	/* Don't check return codes; these calls are idempotent */
> -	no_warn = sysfs_create_link(&drv->p->kobj, &mk->kobj, "module");
> +	sysfs_create_link(&drv->p->kobj, &mk->kobj, "module");
>  	driver_name = make_driver_name(drv);
>  	if (driver_name) {
>  		module_create_drivers_dir(mk);
> -		no_warn = sysfs_create_link(mk->drivers_dir, &drv->p->kobj,
> -					    driver_name);
> +		sysfs_create_link(mk->drivers_dir, &drv->p->kobj,
> +				  driver_name);
>  		kfree(driver_name);
>  	}
>  }
> -- 
> 2.25.4
>

And now you have a build warning :(

Please always test-build your patches before sending them out.

greg k-h
