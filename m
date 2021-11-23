Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D344145A750
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237771AbhKWQQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:16:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:39592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235243AbhKWQQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:16:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7EED60187;
        Tue, 23 Nov 2021 16:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637684014;
        bh=E5pA6PdwDF22Spc5ZX2szyBC40AyI6yucaz1XeUZuFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Or0TWRPvG0ijxchBUVrJSXAbASTD+vfQqcgB5q2fJYtWpD0HBhG9leb0ip/lGy/bN
         inasYINuIajDDpUW7SXzEPiLNErhmMEy6t/PhhGce/8S5+eMpdQDG0nzbabvkcaLSR
         p01NR8yFZ30mKiYTG2mjbVj9vtyAUmtXG6zn6FNwklyhjnrlWRl09wC8Fu6UHMNVr6
         qNdVf/JtmGsn73kBiPgeTFHbflvl48754hUajap2Ct4rD+SQ8MGZnGDbmUQDHJD08h
         +YXXX6Rk2h4GU+Y7LCav4h7Wd9BCKKTOu+mpu6kw/MnK0mYuQBFfaX82m2eIlh3YRS
         LtCxmCWAb3Unw==
Received: by pali.im (Postfix)
        id 589218A3; Tue, 23 Nov 2021 17:13:32 +0100 (CET)
Date:   Tue, 23 Nov 2021 17:13:32 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: (dell-smm) Simplify ioctl handler
Message-ID: <20211123161332.discv3bfx4rkowah@pali>
References: <20211120170319.72369-1-W_Armin@gmx.de>
 <20211120170319.72369-2-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120170319.72369-2-W_Armin@gmx.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 November 2021 18:03:18 Armin Wolf wrote:
> The second switch-case has no real purpose:
> 
> - for I8K_BIOS_VERSION, val does not represent a return value,
>   making the check for error values unnecessary.
> - for I8K_MACHINE_ID, val remains zero, so the error check is
>   unnecessary too.
> 
> Remove the switch-case and move the calls to copy_to_user()
> into the first switch-case for I8K_BIOS_VERSION/_MACHINE_ID.
> Omit buff[] since data->machineid already contains the string

s/->machineid/->bios_machineid/

> with the necessary zero padding.

data is allocated by devm_kzalloc() so data->bios_machineid is really
zero padded.

> Tested on a Dell Inspiron 3505.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/hwmon/dell-smm-hwmon.c | 30 +++++++++---------------------
>  1 file changed, 9 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 5596c211f38d..b5d1703faa62 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -454,7 +454,6 @@ i8k_ioctl_unlocked(struct file *fp, struct dell_smm_data *data, unsigned int cmd
>  {
>  	int val = 0;
>  	int speed, err;
> -	unsigned char buff[16];
>  	int __user *argp = (int __user *)arg;
> 
>  	if (!argp)
> @@ -468,15 +467,19 @@ i8k_ioctl_unlocked(struct file *fp, struct dell_smm_data *data, unsigned int cmd
> 
>  		val = (data->bios_version[0] << 16) |
>  				(data->bios_version[1] << 8) | data->bios_version[2];
> -		break;
> 
> +		if (copy_to_user(argp, &val, 4))
> +			return -EFAULT;
> +
> +		return 0;
>  	case I8K_MACHINE_ID:
>  		if (restricted && !capable(CAP_SYS_ADMIN))
>  			return -EPERM;
> 
> -		strscpy_pad(buff, data->bios_machineid, sizeof(buff));
> -		break;
> +		if (copy_to_user(argp, data->bios_machineid, 16))

What about usage of sizeof(data->bios_machineid) instead of hardcoded
constant 16? And maybe same for constant 4?

> +			return -EFAULT;
> 
> +		return 0;
>  	case I8K_FN_STATUS:
>  		val = i8k_get_fn_status();
>  		break;
> @@ -527,23 +530,8 @@ i8k_ioctl_unlocked(struct file *fp, struct dell_smm_data *data, unsigned int cmd
>  	if (val < 0)
>  		return val;
> 
> -	switch (cmd) {
> -	case I8K_BIOS_VERSION:
> -		if (copy_to_user(argp, &val, 4))
> -			return -EFAULT;
> -
> -		break;
> -	case I8K_MACHINE_ID:
> -		if (copy_to_user(argp, buff, 16))
> -			return -EFAULT;
> -
> -		break;
> -	default:
> -		if (copy_to_user(argp, &val, sizeof(int)))
> -			return -EFAULT;
> -
> -		break;
> -	}
> +	if (copy_to_user(argp, &val, sizeof(int)))
> +		return -EFAULT;
> 
>  	return 0;
>  }
> --
> 2.30.2
> 
