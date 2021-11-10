Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847C644BC9B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 09:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhKJIMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 03:12:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229582AbhKJIMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 03:12:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D245B60FDA;
        Wed, 10 Nov 2021 08:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636531799;
        bh=99l+kK4ZWWNuJpJbAvfbVHV9+UA/kzkUk9qUKjWzGdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oxEnBgNgA9HZYOvTO5+VGMC2SE76UN/fo62BdDurSaYPPGQ9kRMeU6KYsPGMAUZ9E
         JoqG+zFiMt/IbCtX37GvSk0Plt4rRz9YVve6Ch1oCkqAJWH9oQYXvYPmdEINUyWHM2
         0QjpZUWdvHBVIUuL354GlCA1x6mXkRCw4QiGdD74=
Date:   Wed, 10 Nov 2021 09:09:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     TheSven73@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jing Yao <yao.jing2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] staging: fieldbus: Replace snprintf in show functions
 with  sysfs_emit
Message-ID: <YYt+VPc5Uc6qeT3p@kroah.com>
References: <20211110023048.135535-1-yao.jing2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110023048.135535-1-yao.jing2@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 02:30:48AM +0000, cgel.zte@gmail.com wrote:
> From: Jing Yao <yao.jing2@zte.com.cn>
> 
> coccicheck complains about the use of snprintf() in sysfs show
> functions:
> WARNING use scnprintf or sprintf
> 
> Use sysfs_emit instead of scnprintf, snprintf or sprintf makes more
> sense.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>

But coccicheck is the thing that is reporting this, right?

And your subject line has two space characters between "with" and
"sysfs_emit" for some odd reason :(


> Signed-off-by: Jing Yao <yao.jing2@zte.com.cn>
> ---
>  drivers/staging/fieldbus/dev_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fieldbus/dev_core.c b/drivers/staging/fieldbus/dev_core.c
> index 5aab734606ea..01862fe8e4cc 100644
> --- a/drivers/staging/fieldbus/dev_core.c
> +++ b/drivers/staging/fieldbus/dev_core.c
> @@ -70,7 +70,7 @@ static ssize_t card_name_show(struct device *dev, struct device_attribute *attr,
>  	 * card_name was provided by child driver, could potentially be long.
>  	 * protect against buffer overrun.
>  	 */
> -	return snprintf(buf, PAGE_SIZE, "%s\n", fb->card_name);
> +	return sysfs_emit(buf, "%s\n", fb->card_name);
>  }
>  static DEVICE_ATTR_RO(card_name);


Your "bot" is not very good, why are you only changing one function in
this file and not all of the places where sysfs_emit() could be used?

Doing this one function at a time is really hard, please do not do it
that way.

thanks,

greg k-h
