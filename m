Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FAA3A328D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 19:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhFJR6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 13:58:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229823AbhFJR6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 13:58:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7865C613BC;
        Thu, 10 Jun 2021 17:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623347807;
        bh=Crpi7Vd8aG1AIzHpP2cG2rG9WGptNGWFx7PZCSlviGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=reWh7csN0s6vc+PhZ1WkeoW4RAJZ7pSsQZDiQxTRShBch2OXN0ick9QZ3t23jUoD2
         bct7RmH806AO3ZG0arO8Z7x3Dz4jg8MN9F8sI/LizgCvD31Fkv9MPl65QozB+WXyRo
         +K+oXhuRuSH5Jn2E4/4H7kZZeN9ITJ6/lxAIngLc=
Date:   Thu, 10 Jun 2021 19:56:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usbip: tools: usbipd: use ARRAY_SIZE for sockfdlist
Message-ID: <YMJSXCRGzJz+Sfqb@kroah.com>
References: <1623232316-89719-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623232316-89719-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 05:51:56PM +0800, Jiapeng Chong wrote:
> Use ARRAY_SIZE instead of dividing sizeof array with sizeof an
> element.
> 
> Clean up the following coccicheck warning:
> 
> ./tools/usb/usbip/src/usbipd.c:536:19-20: WARNING: Use ARRAY_SIZE.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  tools/usb/usbip/src/usbipd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
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

Always test-build your patches before sending them out, otherwise you
just get grumpy maintainers complaining when you break the build :(

Your "robot" needs some serious work here.

greg k-h
