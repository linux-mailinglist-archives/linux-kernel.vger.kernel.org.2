Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B9A314E95
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 13:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhBIMBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 07:01:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:52362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229813AbhBIMAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 07:00:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6C6364E6F;
        Tue,  9 Feb 2021 11:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612871972;
        bh=6xtapKw7KSUTnW2dJX6/c2jdOgxA/82XY6L3LG5I8Ew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zDAsfff7NgEiwnUn3hJ5hk3eXcxBFfBRDbrkiRD1M7guOL3jknRK6/KlJHGScA+dt
         bq8NZG9qLGNqG1f6HOlMSFezotfU47SUsI8MDM9R6a1RlsFRRHR18iTAL8mlV0c9Bc
         3gsizCBzog+cfJBvOqLiRbKYzHWEo3VnKdJV0MYc=
Date:   Tue, 9 Feb 2021 12:59:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Paul Cercueil <paul@crapouillou.net>, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: misc: usb3503: Fix logic in usb3503_init()
Message-ID: <YCJ5IXNmcGOMDAOB@kroah.com>
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
> +		return err;

You just left a i2c driver registered :(

