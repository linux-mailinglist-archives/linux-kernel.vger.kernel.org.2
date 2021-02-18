Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F8631E98C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 13:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhBRMHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 07:07:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:50162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231564AbhBRJkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 04:40:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2F4964D9C;
        Thu, 18 Feb 2021 09:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613641163;
        bh=nAUhkT0wUd/wJ/k3Y88bx0GkXeajCCVI6lcV/Kg1tRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b2TM2VZQsgF9iPVLT7FlE/izkIBxsUYR4XsU+r6aaHPucz9ycskc+TLA8AbOOyh23
         ISl9yDUC7L1FY3dTpSUZRrNsdsogDkjb3XqHQOB/KwQIolsMB4UHUnRu/cgfVtIMs2
         8+qHhr/WdHp+j53EXyedJ9zFdcWXFsA7B913mwls=
Date:   Thu, 18 Feb 2021 10:39:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pritthijit Nath <pritthijit.nath@icloud.com>
Cc:     nsaenzjulienne@suse.de, arnd@arndb.de, dan.carpenter@oracle.com,
        amarjargal16@gmail.com, phil@raspberrypi.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] staging: vc04_services: Fixed address type mismatch in
 vchiq_arm.c
Message-ID: <YC41yC7+TYXaD/R+@kroah.com>
References: <20210218091015.92467-1-pritthijit.nath@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218091015.92467-1-pritthijit.nath@icloud.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 02:40:15PM +0530, Pritthijit Nath wrote:
> This change fixes a sparse address type mismatch warning "incorrect type
> in assignment (different address spaces)".
> 
> Signed-off-by: Pritthijit Nath <pritthijit.nath@icloud.com>
> ---
>  .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c   | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index 59e45dc03a97..3c715b926a57 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -1214,11 +1214,7 @@ static int vchiq_ioc_await_completion(struct vchiq_instance *instance,
>  		    !instance->use_close_delivered)
>  			unlock_service(service);
>  
> -		/*
> -		 * FIXME: address space mismatch, does bulk_userdata
> -		 * actually point to user or kernel memory?
> -		 */
> -		user_completion.bulk_userdata = completion->bulk_userdata;
> +		user_completion.bulk_userdata = (void __user *)completion->bulk_userdata;

So, this pointer really is user memory?

How did you determine that?

If so, why isn't this a __user * in the first place?

You can't just paper over the FIXME by doing a cast without doing the
real work here, otherwise someone wouldn't have written the FIXME :)

thanks,

greg k-h
