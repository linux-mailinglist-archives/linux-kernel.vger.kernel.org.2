Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE29C45F1C1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 17:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbhKZQZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 11:25:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37500 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbhKZQXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 11:23:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95DE9622DE
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 16:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68770C93056;
        Fri, 26 Nov 2021 16:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637943637;
        bh=hHzRt7omLgTYdRrbsO+/umgidnNO13xR556zj8JayD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OU7kIkqGCRQBVPSI8iC61SEzs/vzOLWDmnGz10io8BXjvDU9j+zY5r3vswzII2Kxx
         LTCO1RYfvy38jA4a9Cp9AoYfhiT9DAAErpUYq7wRz6KgZ1PsBOuGCkz0vebzthKBdJ
         TblfX41vmjawq79ENmCy+7uDI9eune4sK1upJjzo=
Date:   Fri, 26 Nov 2021 17:20:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform: finally disallow IRQ0 in platform_get_irq()
 and its ilk
Message-ID: <YaEJUiZRhkGRZqpt@kroah.com>
References: <5e001ec1-d3f1-bcb8-7f30-a6301fd9930c@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e001ec1-d3f1-bcb8-7f30-a6301fd9930c@omp.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2021 at 11:26:47PM +0300, Sergey Shtylyov wrote:
> The commit a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is
> invalid") only calls WARN() when IRQ0 is about to be returned, however
> using IRQ0 is considered invalid (according to Linus) outside the arch/
> code where it's used by the i8253 drivers. Many driver subsystems treat
> 0 specially (e.g. as an indication of the polling mode by libata), so
> the users of platform_get_irq[_byname]() in them would have to filter
> out IRQ0 explicitly and this (quite obviously) doesn't scale...
> Let's finally get this straight and return -EINVAL instead of IRQ0!
> 
> Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> ---
> The patch is against the 'driver-core-linus' branch of Greg Kroah-Hartman's
> 'driver-core.git' repo.
> 
>  drivers/base/platform.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> Index: driver-core/drivers/base/platform.c
> ===================================================================
> --- driver-core.orig/drivers/base/platform.c
> +++ driver-core/drivers/base/platform.c
> @@ -231,7 +231,8 @@ int platform_get_irq_optional(struct pla
>  out_not_found:
>  	ret = -ENXIO;
>  out:
> -	WARN(ret == 0, "0 is an invalid IRQ number\n");
> +	if (WARN(!ret, "0 is an invalid IRQ number\n"))
> +		return -EINVAL;

You need to get approval from the interrrupt developers for this type of
change, as it is a change and might break existing platforms, right?

thanks,

greg k-h
