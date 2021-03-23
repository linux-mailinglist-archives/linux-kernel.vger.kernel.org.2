Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AE634609C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 14:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhCWN6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 09:58:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231881AbhCWN5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:57:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABE806199F;
        Tue, 23 Mar 2021 13:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616507834;
        bh=TVlze4Ab3R9NxO0b358rAs/k/6d4Gmhz6b1U2HphJ+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D4D/x9Yq0Rfe5UJtw5Ra2qU7dFcxXurblXVfdt398AuH5ocJBxjVUdrpVhsqgua8S
         bQVsTOwfmxj5Tl0O13tHS3rqLbDDDW2qrNcJ2KP+Afv4Sru2+P3FKbpB67Rrop5h+K
         VX3IGGSFHAXbj5zRCwU/243cHUqAa8AG8vjpdi30=
Date:   Tue, 23 Mar 2021 14:57:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] base: dd: fix error return code of driver_sysfs_add()
Message-ID: <YFnztyaTn47fjlnr@kroah.com>
References: <20210305102405.14940-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305102405.14940-1-baijiaju1990@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 02:24:05AM -0800, Jia-Ju Bai wrote:
> When device_create_file() fails and returns a non-zero value, 
> no error return code of driver_sysfs_add() is assigned.
> To fix this bug, ret is assigned with the return value of
> device_create_file(), and then ret is checked.
> 
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/base/dd.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 9179825ff646..f94bbef95258 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -413,8 +413,11 @@ static int driver_sysfs_add(struct device *dev)
>  	if (ret)
>  		goto rm_dev;
>  
> -	if (!IS_ENABLED(CONFIG_DEV_COREDUMP) || !dev->driver->coredump ||
> -	    !device_create_file(dev, &dev_attr_coredump))
> +	if (!IS_ENABLED(CONFIG_DEV_COREDUMP) || !dev->driver->coredump)
> +		return 0;
> +	

Trailing whitespace :(

