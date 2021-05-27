Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A90C392E38
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbhE0MrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:47:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234699AbhE0MrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:47:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0726613CA;
        Thu, 27 May 2021 12:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622119547;
        bh=obxY3g3Pvz5hktXnvNYEQGWnAc5NDQMbt6CGMvG/iiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mU345z5/NtGoQ5A7UDTkNIhJFl0DuHVPs+2t9ree/OKhEBgtSWmaWQ8rtMmI1jtM0
         HjIFNygo5XrirovQZfaSOOm80yfFxz6Ac3OZZ2UOhndQAQjx8ecix0j5W6/nM5C/GK
         UrOFV+iraIvEx1Kwao9XERN9mFBJ2QheSnl1fIZY=
Date:   Thu, 27 May 2021 14:45:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     nizamhaider786@gmail.com
Cc:     laforge@gnumonks.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] char: pcmcia: cm4040_cs: Fix failure handling
Message-ID: <YK+UeEK0iyLPl0tg@kroah.com>
References: <20210524230235.571-1-nizamhaider786@gmail.com>
 <20210524230235.571-2-nizamhaider786@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524230235.571-2-nizamhaider786@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 04:32:35AM +0530, nizamhaider786@gmail.com wrote:
> From: Nijam Haider <nizamhaider786@gmail.com>
> 
> Handled failure cases of device_create()
> 
> Signed-off-by: Nijam Haider <nizamhaider786@gmail.com>
> ---
> V1 -> V2: Added description and changelog
> ---
>  drivers/char/pcmcia/cm4040_cs.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/pcmcia/cm4040_cs.c b/drivers/char/pcmcia/cm4040_cs.c
> index d5e43606339c..526198be91fa 100644
> --- a/drivers/char/pcmcia/cm4040_cs.c
> +++ b/drivers/char/pcmcia/cm4040_cs.c
> @@ -558,6 +558,7 @@ static void reader_release(struct pcmcia_device *link)
>  static int reader_probe(struct pcmcia_device *link)
>  {
>  	struct reader_dev *dev;
> +	struct device *dev_ret;
>  	int i, ret;
>  
>  	for (i = 0; i < CM_MAX_DEV; i++) {
> @@ -593,8 +594,14 @@ static int reader_probe(struct pcmcia_device *link)
>  		return ret;
>  	}
>  
> -	device_create(cmx_class, NULL, MKDEV(major, i), NULL, "cmx%d", i);
> -
> +	dev_ret = device_create(cmx_class, NULL, MKDEV(major, i), NULL, "cmx%d", i);
> +	if (IS_ERR(dev_ret)) {
> +		dev_err(&link->dev, "device_create failed for %d\n", i);
> +		reader_release(link);
> +		dev_table[i] = NULL;
> +		kfree(dev);
> +		return -ENODEV;
> +	}

Same comment as on patch 1/2.

thanks,

greg k-h
