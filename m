Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5D6392E37
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbhE0MrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:47:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234699AbhE0MrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:47:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC70B606A5;
        Thu, 27 May 2021 12:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622119536;
        bh=t+y/6kISVhX7iAjxtBgSAvix/BBCFSFapdY31Z7RDuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VSwD3MTJocLoRQ9cmzr2ZFelsCtrHKfm8hUEXKGGkht8M3UK/VdZFjk4nFDdliY0i
         UOMxIGhpqMMj81nHaDUG7QXfHSeqLUgDz2LTs4JfP31nXqSu0eXF4M30PRd54xsxco
         jl2ddSeAXifFJOvarcuUbvK+XrXITcAUMPOY5Hv4=
Date:   Thu, 27 May 2021 14:45:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     nizamhaider786@gmail.com
Cc:     laforge@gnumonks.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] char: pcmcia: cm4000_cs: Fix failure handling
Message-ID: <YK+UbvNhHBw3H27Z@kroah.com>
References: <20210524230235.571-1-nizamhaider786@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524230235.571-1-nizamhaider786@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 04:32:34AM +0530, nizamhaider786@gmail.com wrote:
> From: Nijam Haider <nizamhaider786@gmail.com>
> 
> Handled failure cases of device_create()
> 
> Signed-off-by: Nijam Haider <nizamhaider786@gmail.com>
> ---
> V1 -> V2: Added description and changelog
> ---
>  drivers/char/pcmcia/cm4000_cs.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
> index 89681f07bc78..1ed4eac6b8ef 100644
> --- a/drivers/char/pcmcia/cm4000_cs.c
> +++ b/drivers/char/pcmcia/cm4000_cs.c
> @@ -1783,6 +1783,7 @@ static int cm4000_probe(struct pcmcia_device *link)
>  {
>  	struct cm4000_dev *dev;
>  	int i, ret;
> +	struct device *dev_ret;
>  
>  	for (i = 0; i < CM4000_MAX_DEV; i++)
>  		if (dev_table[i] == NULL)
> @@ -1814,8 +1815,14 @@ static int cm4000_probe(struct pcmcia_device *link)
>  		return ret;
>  	}
>  
> -	device_create(cmm_class, NULL, MKDEV(major, i), NULL, "cmm%d", i);
> -
> +	dev_ret = device_create(cmm_class, NULL, MKDEV(major, i), NULL, "cmm%d", i);
> +	if (IS_ERR(dev_ret)) {
> +		dev_err(&link->dev, "device_create failed for %d\n", i);
> +		cm4000_release(link);
> +		dev_table[i] = NULL;
> +		kfree(dev);
> +		return -ENODEV;
> +	}

As before, make different err_*: labels and jump to them when cleaning
up.

thanks,

greg k-h
