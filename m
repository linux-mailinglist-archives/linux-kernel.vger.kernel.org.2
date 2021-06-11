Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EB23A4051
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 12:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhFKKmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 06:42:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhFKKmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 06:42:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEC61613E9;
        Fri, 11 Jun 2021 10:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623408002;
        bh=MYUJWhPp3HEvERW7H4uZGlgJHlDtwi5x6YdmBFvAfpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1taqFB/tgZcFpWEA3vdD/fsQbxQZfPuJSfBqFyoB3bDZv8hZdfH3e9gBOHDylsu8j
         7YFtTlLaaB67dBP4AG8lt2D/fLLRjpAQ1dRcMZtjt8xhD1uqfy+m6Z6euxmQuQMqeQ
         DPXlw2SEwaw23jqSGwiOrZYZspvTZN4NAMjO45k8=
Date:   Fri, 11 Jun 2021 12:39:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usbip: tools: usbipd: use ARRAY_SIZE for sockfdlist
Message-ID: <YMM9f6yM6IIyjx16@kroah.com>
References: <1623406510-50900-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623406510-50900-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 06:15:10PM +0800, Jiapeng Chong wrote:
> Use ARRAY_SIZE instead of dividing sizeof array with sizeof an
> element.
> 
> Clean up the following coccicheck warning:
> 
> ./tools/usb/usbip/src/usbipd.c:536:19-20: WARNING: Use ARRAY_SIZE.

Why are you assuming that coccicheck should be run on userspace code?

> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
> Changes in v2:
>   -Add ARRAY_SIZE definition to usbip_common.h file.
> 
>  tools/usb/usbip/libsrc/usbip_common.h | 2 ++
>  tools/usb/usbip/src/usbipd.c          | 3 +--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/usb/usbip/libsrc/usbip_common.h b/tools/usb/usbip/libsrc/usbip_common.h
> index 73a367a..4e12dc4 100644
> --- a/tools/usb/usbip/libsrc/usbip_common.h
> +++ b/tools/usb/usbip/libsrc/usbip_common.h
> @@ -101,6 +101,8 @@
>  		abort();				\
>  	} while (0)
>  
> +#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))

Why is this needed?

And if it really really is, why not define it in a way that ALL tools
can use it.

And then fix it up be correct for cases when you might call this when it
is not an array.  This is a very naive implementation.

> +
>  struct usbip_usb_interface {
>  	uint8_t bInterfaceClass;
>  	uint8_t bInterfaceSubClass;
> diff --git a/tools/usb/usbip/src/usbipd.c b/tools/usb/usbip/src/usbipd.c
> index 48398a7..4826d13 100644
> --- a/tools/usb/usbip/src/usbipd.c
> +++ b/tools/usb/usbip/src/usbipd.c
> @@ -532,8 +532,7 @@ static int do_standalone_mode(int daemonize, int ipv4, int ipv6)
>  		usbip_driver_close(driver);
>  		return -1;
>  	}
> -	nsockfd = listen_all_addrinfo(ai_head, sockfdlist,
> -		sizeof(sockfdlist) / sizeof(*sockfdlist));
> +	nsockfd = listen_all_addrinfo(ai_head, sockfdlist, ARRAY_SIZE(sockfdlist));

The code here is correct, right?  So this is not necessary unless you do
this for all in-tree userspace tools at the same time.

thanks,

greg k-h
