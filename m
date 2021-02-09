Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141FF314EA0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 13:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhBIMDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 07:03:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:52760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229992AbhBIMBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 07:01:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B38FC64E8C;
        Tue,  9 Feb 2021 12:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612872058;
        bh=ENHk19c20GqiLUebme+RmW7wZA6VOHChW92hTBetcKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m4dM5ezGBHqdHskfPYGBARkvUZr+uZwSx6PPdwYKMnnkfk3F5E1ljxj08vKKRQPTC
         cGhUNtXOTd1R/agDbegkTXhroxjg0K4R37Dhmt5KJ7lODbGrYWXdHqw/JEI13/1/6L
         +Glkfv4QcZrSQmg26BUudus2lVX1oYazNL7bg3SV7bfl6/dUpv6qBB1rPkK1In1DUi
         VMPMGIVxP1eaG74bKCX0YrqXZ56rO3JZwhkiwdTZBqQ+4TKTPk1qIMWZPJB2tt19zQ
         x4zM4NfQPSbuAxx4mpAC2+KfI3/bN9xK4p32cyBVjH0sO/aLWR6R1QasgYV+oA5mtn
         jD1BG+BWfzlnw==
Received: from johan by xi with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l9Rhf-00021y-BS; Tue, 09 Feb 2021 13:01:12 +0100
Date:   Tue, 9 Feb 2021 13:01:11 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Cercueil <paul@crapouillou.net>, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: misc: usb3503: Fix logic in usb3503_init()
Message-ID: <YCJ5h889zBrzVzji@hovoldconsulting.com>
References: <4ae929dc31c170252154352d04e89c8456d91ca3.1612870239.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae929dc31c170252154352d04e89c8456d91ca3.1612870239.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 12:30:42PM +0100, Michal Simek wrote:
> Based on
> https://lore.kernel.org/linux-arm-kernel/YCJv59g3Tq2haDSa@kroah.com/
> initialization should fail if any registration fails.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  drivers/usb/misc/usb3503.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/misc/usb3503.c b/drivers/usb/misc/usb3503.c
> index 48099c6bf04c..3aae83fbebae 100644
> --- a/drivers/usb/misc/usb3503.c
> +++ b/drivers/usb/misc/usb3503.c
> @@ -409,13 +409,17 @@ static int __init usb3503_init(void)
>  	int err;
>  
>  	err = i2c_add_driver(&usb3503_i2c_driver);
> -	if (err != 0)
> +	if (err) {
>  		pr_err("usb3503: Failed to register I2C driver: %d\n", err);
> +		return err;
> +	}
>  
>  	err = platform_driver_register(&usb3503_platform_driver);
> -	if (err != 0)
> +	if (err) {
>  		pr_err("usb3503: Failed to register platform driver: %d\n",
>  		       err);

You forgot to deregister the i2c driver.

> +		return err;
> +	}
>  
>  	return 0;
>  }

Johan
