Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23F845A71A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbhKWQHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:07:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:37878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231689AbhKWQHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:07:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9D6060F5D;
        Tue, 23 Nov 2021 16:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637683473;
        bh=pB+bkrTCNdtnDDTpC2ieHHfYzQit86MlysKlIqETE5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tOE+lD1pUmXcILxLZE7k0rZoFKGztWxPxEBPkddtoz2ZWp4gCi1m++PiSTuS9NWQp
         vfoNh+OHrqR1ORM8JZyYt2014zDNpVPqB5RJ1KWCNHiC8ow5w/qMqXGZpaojQ7nnGI
         5LVxFZlQrDVGrVQDGPcv/UexrysvgPTBofZyYpTXYlY9FbYG/kSlV1wW5lHINqr/16
         wF+Cymkjs2y4HWbFfaWNLOac2CAQEWVDeEV/4RuEIJ7oC1f1gRF8TQYcco1cJAgvPc
         9T84AHzCM7GWh0NPMRSYDAiUtGo/ZwOGTArk9dkcod0zFTjQtN7Ir+pC6VGLt6yJBZ
         nmgWQvtgY3u1g==
Received: by pali.im (Postfix)
        id 4F9348A3; Tue, 23 Nov 2021 17:04:31 +0100 (CET)
Date:   Tue, 23 Nov 2021 17:04:31 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (dell-smm) Unify i8k_ioctl() and
 i8k_ioctl_unlocked()
Message-ID: <20211123160431.6tegq2jdoifecivd@pali>
References: <20211120170319.72369-1-W_Armin@gmx.de>
 <20211120170319.72369-3-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211120170319.72369-3-W_Armin@gmx.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 November 2021 18:03:19 Armin Wolf wrote:
> The only purpose of i8k_ioctl() is to call i8k_ioctl_unlocked()
> with i8k_mutex held. Judging from the hwmon code, this mutex
> only needs to be held when setting the fan speed/mode.
> Unify both functions and reduce the locking of i8k_mutex
> to I8K_SET_FAN.
> 
> Tested on a Dell Inspiron 3505.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Maybe some more information in commit message could be useful, but now
it is in this email thread.

Anyway, change is correct, so:

Reviewed-by: Pali Rohár <pali@kernel.org>

> ---
>  drivers/hwmon/dell-smm-hwmon.c | 27 +++++++++------------------
>  1 file changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index b5d1703faa62..e2d388f7360e 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -449,12 +449,12 @@ static int i8k_get_power_status(void)
>   * Procfs interface
>   */
> 
> -static int
> -i8k_ioctl_unlocked(struct file *fp, struct dell_smm_data *data, unsigned int cmd, unsigned long arg)
> +static long i8k_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
>  {
> -	int val = 0;
> -	int speed, err;
> +	struct dell_smm_data *data = PDE_DATA(file_inode(fp));
>  	int __user *argp = (int __user *)arg;
> +	int speed, err;
> +	int val = 0;
> 
>  	if (!argp)
>  		return -EINVAL;
> @@ -516,11 +516,14 @@ i8k_ioctl_unlocked(struct file *fp, struct dell_smm_data *data, unsigned int cmd
>  		if (copy_from_user(&speed, argp + 1, sizeof(int)))
>  			return -EFAULT;
> 
> +		mutex_lock(&data->i8k_mutex);
>  		err = i8k_set_fan(data, val, speed);
> -		if (err < 0)
> +		if (err < 0) {
> +			mutex_unlock(&data->i8k_mutex);
>  			return err;
> -
> +		}
>  		val = i8k_get_fan_status(data, val);
> +		mutex_unlock(&data->i8k_mutex);
>  		break;
> 
>  	default:
> @@ -536,18 +539,6 @@ i8k_ioctl_unlocked(struct file *fp, struct dell_smm_data *data, unsigned int cmd
>  	return 0;
>  }
> 
> -static long i8k_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
> -{
> -	struct dell_smm_data *data = PDE_DATA(file_inode(fp));
> -	long ret;
> -
> -	mutex_lock(&data->i8k_mutex);
> -	ret = i8k_ioctl_unlocked(fp, data, cmd, arg);
> -	mutex_unlock(&data->i8k_mutex);
> -
> -	return ret;
> -}
> -
>  /*
>   * Print the information for /proc/i8k.
>   */
> --
> 2.30.2
> 
