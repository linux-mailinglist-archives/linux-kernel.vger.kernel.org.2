Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B18930550F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 08:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhA0HxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 02:53:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:52590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231911AbhA0HvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 02:51:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61F312074D;
        Wed, 27 Jan 2021 07:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611733832;
        bh=yIs3OZHTJiiiSOQYkGjk7LcLfBtlVTwr9Qy0+2JGkHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n3bvzBqcQyxN4PZHN+iNOjpgx1aT2nXg9/BaImVGkzH+86LMxRDKHNb2MJ6dpc6FZ
         x88jluRsiQe28G2bOujetTD+eCUWY0yEsnM+iQxnHtRGpjxi8p8skmPPG6zLbzp9Ne
         qVUsKeroQnjJQNtuQpn3h6pnQfUl6ExxWZt8mIQY=
Date:   Wed, 27 Jan 2021 08:50:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Orson Zhai <orsonzhai@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Joe Perches <joe@perches.com>,
        Denis Efremov <efremov@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Orson Zhai <orson.zhai@unisoc.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include: sysfs: Add macro to assign show for RO
 attributes
Message-ID: <YBEbRDOQhczI5/yC@kroah.com>
References: <1611721162-29982-1-git-send-email-orsonzhai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611721162-29982-1-git-send-email-orsonzhai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 12:19:22PM +0800, Orson Zhai wrote:
> In some circumstances, multiple __ATTR_RO attributes need to be assigned
> with a single show function.
> 
> Add this macro to make life easier with simple code.
> 
> Signed-off-by: Orson Zhai <orsonzhai@gmail.com>
> ---
>  Documentation/filesystems/sysfs.rst | 2 ++
>  include/linux/sysfs.h               | 5 +++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/Documentation/filesystems/sysfs.rst b/Documentation/filesystems/sysfs.rst
> index 004d490..0e2274a 100644
> --- a/Documentation/filesystems/sysfs.rst
> +++ b/Documentation/filesystems/sysfs.rst
> @@ -141,6 +141,8 @@ __ATTR_RO_MODE(name, mode):
>  	         fore more restrictive RO access currently
>                   only use case is the EFI System Resource Table
>                   (see drivers/firmware/efi/esrt.c)
> +__ATTR_RO_SHOW(name, show):
> +		 assumes default mode 0444 with specified show.
>  __ATTR_RW(name):
>  	         assumes default name_show, name_store and setting
>                   mode to 0644.
> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index 2caa34c..c851592 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -117,6 +117,11 @@ struct attribute_group {
>  	.show	= _name##_show,						\
>  }
>  
> +#define __ATTR_RO_SHOW(_name, _show) {					\
> +	.attr	= { .name = __stringify(_name), .mode = 0444 },		\
> +	.show	= _show,						\
> +}

Do you have a real user for this?  Using "raw" kobject attributes is
rare and should not be used often, so who needs this?

thanks,

greg k-h
