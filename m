Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960E1438214
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 08:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhJWGt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 02:49:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhJWGty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 02:49:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6284760ED3;
        Sat, 23 Oct 2021 06:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634971656;
        bh=VVJVb6DAVVrifwKr6DnERAf3xG2cPuAA/yaGHeyqtfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VJmmQhw90JR00cTnLLtNwCPsIAjHph+v1vo2Nponk6tU8mUi0IViIjYuLL3XeQeYA
         aUyr3tbDMGb2T8W85xaGex7HPfeiVNNz5+woX/W72+Nd/Wa3q2qDkx4TXzHf1aakVh
         kpvA5SGqgP8wOOKr311Zm83YaV5oUmRZOWK3tJIo=
Date:   Sat, 23 Oct 2021 08:47:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH] usb: usb-skeleton: Add hint to find __init and __exit
Message-ID: <YXOwA6N2ffVIcA7L@kroah.com>
References: <20211023052538.GA5141@matrix-ESPRIMO-P710>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211023052538.GA5141@matrix-ESPRIMO-P710>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2021 at 07:25:38AM +0200, Philipp Hortmann wrote:
> Comment to find __init and __exit.
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
>  drivers/usb/usb-skeleton.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/usb-skeleton.c b/drivers/usb/usb-skeleton.c
> index 2dc58766273a..80338a50dcde 100644
> --- a/drivers/usb/usb-skeleton.c
> +++ b/drivers/usb/usb-skeleton.c
> @@ -641,6 +641,7 @@ static struct usb_driver skel_driver = {
>  	.supports_autosuspend = 1,
>  };
>  
> +/* __init and __exit */
>  module_usb_driver(skel_driver);

This comment makes no sense, sorry.  __init and __exit are things that
the linker uses, why would you need to "find" them?

thanks,

greg k-h
