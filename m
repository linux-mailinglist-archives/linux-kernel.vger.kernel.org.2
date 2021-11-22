Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8426E459292
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 17:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbhKVQEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 11:04:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:52972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229911AbhKVQEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 11:04:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4DB26044F;
        Mon, 22 Nov 2021 16:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637596884;
        bh=H2oSmLBlYC0pyLwuEp1gnOlHn7RG14lRw0UmEgSeHXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J0od3oFyTDrRFSx2OarDv8QhCmhU8ngVfDVJDEpmrlC+KVItOcv+AQwVuBpuN7Fxq
         VN/9EQ5wuMw6+ILd7GwYAcnu46O0v4IfDD/ysvSpjlPTV71bslbKU5KHVTLF3KKia4
         AqXX7YPpXO7tduXiK1h9F50YT1x1RBHfVCCU8AzkP+2GVtmgY+IBFh0I08o9Z1SO6X
         lOQcjG3/y2hUYEKzx8/32wQyhfz5+dL6eZo65lJCdMzvYyF0nCu7gvs84kRZU1AkvS
         0LmudGD9yoFPfDoFOs1laqLbKOXEG1qjgZ8BGtBD9bM/N94TxYM76IrGWbFr9+feTy
         tKETiutT9Vgsw==
Received: by pali.im (Postfix)
        id 6D4CCA87; Mon, 22 Nov 2021 17:01:22 +0100 (CET)
Date:   Mon, 22 Nov 2021 17:01:22 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (dell-smm) Unify i8k_ioctl() and
 i8k_ioctl_unlocked()
Message-ID: <20211122160122.gf6i3qj6dnwi6wla@pali>
References: <20211120170319.72369-1-W_Armin@gmx.de>
 <20211120170319.72369-3-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120170319.72369-3-W_Armin@gmx.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 November 2021 18:03:19 Armin Wolf wrote:
> The only purpose of i8k_ioctl() is to call i8k_ioctl_unlocked()
> with i8k_mutex held. Judging from the hwmon code, this mutex
> only needs to be held when setting the fan speed/mode.

Really? I think that there is no difference between setting and getting
fan speed/mode. At least I do not see why 'set' needs mutex and 'get' do
not need it. Some more explanation is needed...

I'm not sure here but SMM call consist of two 'out' instructions and we
probably need to ensure that interrupt does not happen between them.

> Unify both functions and reduce the locking of i8k_mutex
> to I8K_SET_FAN.
> 
> Tested on a Dell Inspiron 3505.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
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
