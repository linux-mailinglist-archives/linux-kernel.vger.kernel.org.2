Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B30941266D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 20:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355437AbhITS5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 14:57:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1385804AbhITSw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:52:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DA6A615E5;
        Mon, 20 Sep 2021 17:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632159904;
        bh=eizUbIsjMYN+/U7qxJUDeZOmJ6obtyGbGnTfTb7yHFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=akNnW5dU4Cx5qLoSXfsKOMMVVZHBfSw64ojyQUwciY/dbVxov5yQqNih9bqJdF4sa
         LU9LFjLIT4Q1oI+XF35+yLZ6UmeLvIzrNj4LCoWOrP6/EOgIV6QTx5JYWNDoDuEjYP
         P5SO7qDo/YRjufnMVhVtVYEUgSdSTIHCJYFkczGFb9EWUiTgAxlSllv50sLaS6HbXw
         Lf6MX2irdcNOS6dpDMa5uzOoBZVApoH5wvi68MRjYgnfbw1J2LKF/QG8yPm7ebFvWt
         XlY0ir1kbMIhX5qvxdMOPvg6jsZkfKYK+d7gMwixJ/l4PwQpGkCizDzOsZmVmJM9Pi
         vVbkpcIfjuhsg==
Date:   Mon, 20 Sep 2021 10:45:03 -0700
From:   Mark Gross <markgross@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Matan Ziv-Av <matan@svgalib.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: lg-laptop: Fix possible NULL pointer
 derefence
Message-ID: <YUjInxyfnuo1tZvh@envy17>
References: <20210920095556.1175269-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920095556.1175269-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 11:55:50AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_DMI is disabled, dmi_get_system_info() returns a NULL
> pointer, which is now caught by a warning:
> 
> In function 'strlen',
>     inlined from 'acpi_add.part.0' at drivers/platform/x86/lg-laptop.c:658:6:
> include/linux/fortify-string.h:25:33: error: argument 1 null where non-null expected [-Werror=nonnull]
>    25 | #define __underlying_strlen     __builtin_strlen
>       |                                 ^
> include/linux/fortify-string.h:60:24: note: in expansion of macro '__underlying_strlen'
>    60 |                 return __underlying_strlen(p);
>       |                        ^~~~~~~~~~~~~~~~~~~
> drivers/platform/x86/lg-laptop.c: In function 'acpi_add.part.0':
> include/linux/fortify-string.h:25:33: note: in a call to built-in function '__builtin_strlen'
>    25 | #define __underlying_strlen     __builtin_strlen
>       |                                 ^
> include/linux/fortify-string.h:60:24: note: in expansion of macro '__underlying_strlen'
>    60 |                 return __underlying_strlen(p);
>       |                        ^~~~~~~~~~~~~~~~~~~
> 
> The code in there does not appear essential, so an explicit
> NULL check should be sufficient. The string is also printed
> to the console, but printk() is able to handle NULL pointer
> arguments gracefully.
> 
> Fixes: 8983bfd58d61 ("platform/x86: lg-laptop: Support for battery charge limit on newer models")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/platform/x86/lg-laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
> index 3e520d5bca07..88b551caeaaf 100644
> --- a/drivers/platform/x86/lg-laptop.c
> +++ b/drivers/platform/x86/lg-laptop.c
> @@ -655,7 +655,7 @@ static int acpi_add(struct acpi_device *device)
>  		goto out_platform_registered;
>  	}
>  	product = dmi_get_system_info(DMI_PRODUCT_NAME);
> -	if (strlen(product) > 4)
> +	if (product && strlen(product) > 4)
seems appropriate.

--mark
>  		switch (product[4]) {
>  		case '5':
>  		case '6':
> -- 
> 2.29.2
> 
