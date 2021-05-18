Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED443881F7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 23:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352362AbhERVRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 17:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbhERVRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 17:17:31 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF63C061573;
        Tue, 18 May 2021 14:16:12 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id t20so8634953qtx.8;
        Tue, 18 May 2021 14:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=7+eNeJ+TKdTi8wnmOcoiITdcEPnd2MOxEqR6qRx/5JQ=;
        b=hSybrGr+djkX5fv1LYE0ggweAVwQrTi5eADmylVFD08pQQihI63YgpvjrXBOfktw7m
         gspQhMEH974zJuDimOtjf5aB2IeV+LSPayiRuI8Bfh7fsTyxypiDVuDyOcQXTZEnvM0M
         VsA/DdYWb0T2xNhF6yZQHDazUWXPRBSiJL7C4sA2lalbohVKnyurB0t6abVKzjdVKNDI
         5QduEWLVM80ZX82c8UG3eeBMFDGAKGmusgQniuSNbbg7Yop/l4zk7NTtMk3vMS2rlfcn
         zgYJ8n2Vqh4VQRDAoEOl7SF984137RqDQFFNQlbkzNg47hcGHetN75QATstrrs7KtBkv
         dXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding;
        bh=7+eNeJ+TKdTi8wnmOcoiITdcEPnd2MOxEqR6qRx/5JQ=;
        b=pvsSzvLjsfhUWhkC/oH/ZPEcWOYV5vmkOxkIMFB5JSrrUocgv8BrpN+46HrolqEC3f
         +xLyUvaL+NzFivZ+mbPQ4GVwsEqGCKx6Q0VmiO+tf2+DsPakhgdaEJdOtcl1XSY1NGml
         gtf6NpJvz81qhiFyAy3dtZzpEBvCYCUY6iSALYmLSRycibaEqHcbQ0Zo3ube1ZAJgLev
         BD0frWNtdUHQEl1K0KKvpdSk9QCc9AIJuBlrgtLp7vvo72avqH06/A16gM1uB779nC5l
         f4Odp2WKmMSae+3nh5XqFoX7WIDlafOzvuduNWeLQjMbzvrTILYYmgIbMx4N4XpMOCSz
         FLpA==
X-Gm-Message-State: AOAM531xMmkx+p0o0C6YJISnd13LSmxE2XlvIyepADIhGCXTkd+aGnNJ
        NuMOD/2TcYJmNWLv3ZNnDDE=
X-Google-Smtp-Source: ABdhPJxaC7BKOzF0N+gqaVXXRUdClhvvcrUL+EHfgM4eQD7kO1FVtdYbX6rUylwW1s9czaoIBgFvBA==
X-Received: by 2002:ac8:5fc2:: with SMTP id k2mr7146308qta.131.1621372571420;
        Tue, 18 May 2021 14:16:11 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g5sm15577661qtm.2.2021.05.18.14.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 14:16:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 18 May 2021 14:16:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     =?iso-8859-1?Q?V=E1clav_Kubern=E1t?= <kubernat@cesnet.cz>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] hwmon: (max31790) Fix and split pwm*_enable
Message-ID: <20210518211609.GA3532746@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 03:30:48AM +0200, Václav Kubernát wrote:
> In the old code, pwm*_enable does two things. Firstly, it sets whether
> the chip should run in PWM or RPM mode. Secondly, it tells the chip
> whether it should monitor fan RPM. However, these two settings aren't
> tied together, so they shouldn't be set with a single value. In the new
> code, fan*_enable now controls fan RPM monitoring (pwm*_enable no longer
> controls that).
> 
> According to the sysfs hwmon documentation, pwm*_enable has three
> possible values, 0 for "no control / full-speed", 1 for manual mode, and
> 2+ for automatic. The old code works fine for 1 and 2, but 0 only
> differs from 1 in that it just turns off fan speed monitoring. The chip
> actually does have a way to turn off fan controls (and only monitor),
> and what that does is that it sets PWM to 0% duty cycle. In the new
> code, 0 in pwm*_enable turns off the "control" feature of the chip.
> 
> These two changes are closely connected together, mainly because the
> detection of the pwm*_enable value depended on whether fan speed
> monitoring is enabled (which is now controlled as written in the first
> paragraph).
> 
> Signed-off-by: Václav Kubernát <kubernat@cesnet.cz>
> ---
>  Documentation/hwmon/max31790.rst | 10 ++--
>  drivers/hwmon/max31790.c         | 78 +++++++++++++++++++++-----------
>  2 files changed, 58 insertions(+), 30 deletions(-)
> 
> diff --git a/Documentation/hwmon/max31790.rst b/Documentation/hwmon/max31790.rst
> index f301385d8cef..d2ac4e926905 100644
> --- a/Documentation/hwmon/max31790.rst
> +++ b/Documentation/hwmon/max31790.rst
> @@ -34,10 +34,14 @@ also be configured to serve as tachometer inputs.
>  Sysfs entries
>  -------------
>  
> -================== === =======================================================
> +================== === =============================================================
> +fan[1-12]_enable   RW  enable fan speed monitoring
>  fan[1-12]_input    RO  fan tachometer speed in RPM
>  fan[1-12]_fault    RO  fan experienced fault
>  fan[1-6]_target    RW  desired fan speed in RPM
> -pwm[1-6]_enable    RW  regulator mode, 0=disabled, 1=manual mode, 2=rpm mode
> +pwm[1-6]_enable    RW  regulator mode, 0=no control, sets 0% PWM,
> +				       1=manual (pwm) mode,
> +				       2=rpm mode
> +                       setting rpm mode sets fan*_enable to 1
>  pwm[1-6]           RW  fan target duty cycle (0-255)
> -================== === =======================================================
> +================== === =============================================================
> diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
> index e3765ce4444a..5d4c551df010 100644
> --- a/drivers/hwmon/max31790.c
> +++ b/drivers/hwmon/max31790.c
> @@ -30,6 +30,7 @@
>  #define MAX31790_FAN_CFG_RPM_MODE	0x80
>  #define MAX31790_FAN_CFG_TACH_INPUT_EN	0x08
>  #define MAX31790_FAN_CFG_TACH_INPUT	0x01
> +#define MAX31790_FAN_CFG_CTRL_MON	0x10
>  
>  /* Fan Dynamics register bits */
>  #define MAX31790_FAN_DYN_SR_SHIFT	5
> @@ -191,6 +192,9 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
>  		else
>  			*val = !!(fault & (1 << channel));
>  		return 0;
> +	case hwmon_fan_enable:
> +		*val = !!(data->fan_config[channel] & MAX31790_FAN_CFG_TACH_INPUT_EN);

fan_config array size is 6, and there are up to 12 fans ... so this won't
work for fans 7..12.

> +		return 0;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -233,6 +237,15 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
>  				     MAX31790_REG_TARGET_COUNT(channel),
>  				     target_count);
>  		break;
> +	case hwmon_fan_enable:
> +		if (val == 0)
> +			data->fan_config[channel] &= ~MAX31790_FAN_CFG_TACH_INPUT_EN;
> +		else
> +			data->fan_config[channel] |= MAX31790_FAN_CFG_TACH_INPUT_EN;
> +		err = regmap_write(regmap,
> +				   MAX31790_REG_FAN_CONFIG(channel),
> +				   data->fan_config[channel]);
> +		break;

Same as above.

As it turns out, even the current code doesn't really work for fans 7..12.
		sr = get_tach_period(data->fan_dynamics[channel]);
However, the data->fan_dynamics array has only 6 entries, not 12, so
reading fan[7-12]_input will result in bad/random values.

>  	default:
>  		err = -EOPNOTSUPP;
>  		break;
> @@ -260,6 +273,11 @@ static umode_t max31790_fan_is_visible(const void *_data, u32 attr, int channel)
>  		    !(fan_config & MAX31790_FAN_CFG_TACH_INPUT))
>  			return 0644;
>  		return 0;
> +	case hwmon_fan_enable:
> +		if (channel < NR_CHANNEL ||
> +		    (fan_config & MAX31790_FAN_CFG_TACH_INPUT))
> +			return 0644;
> +		return 0;
>  	default:
>  		return 0;
>  	}
> @@ -281,12 +299,12 @@ static int max31790_read_pwm(struct device *dev, u32 attr, int channel,
>  		*val = read >> 8;
>  		return 0;
>  	case hwmon_pwm_enable:
> -		if (data->fan_config[channel] & MAX31790_FAN_CFG_RPM_MODE)
> +		if (data->fan_config[channel] & MAX31790_FAN_CFG_CTRL_MON)
> +			*val = 0;
> +		else if (data->fan_config[channel] & MAX31790_FAN_CFG_RPM_MODE)
>  			*val = 2;
> -		else if (data->fan_config[channel] & MAX31790_FAN_CFG_TACH_INPUT_EN)
> +		else
>  			*val = 1;
> -		else
> -			*val = 0;
>  		return 0;
>  	default:
>  		return -EOPNOTSUPP;
> @@ -298,35 +316,41 @@ static int max31790_write_pwm(struct device *dev, u32 attr, int channel,
>  {
>  	struct max31790_data *data = dev_get_drvdata(dev);
>  	struct regmap *regmap = data->regmap;
> -	u8 fan_config;
> +	u8 fan_config = data->fan_config[channel];
>  	int err = 0;
>  
>  	mutex_lock(&data->update_lock);
>  
>  	switch (attr) {
>  	case hwmon_pwm_input:
> -		if (val < 0 || val > 255) {
> +		if (fan_config & MAX31790_FAN_CFG_CTRL_MON || val < 0 || val > 255) {
>  			err = -EINVAL;
>  			break;
>  		}
> +
>  		err = write_reg_word(regmap, MAX31790_REG_PWMOUT(channel), val << 8);
>  		break;
>  	case hwmon_pwm_enable:
>  		fan_config = data->fan_config[channel];
> -		if (val == 0) {
> -			fan_config &= ~(MAX31790_FAN_CFG_TACH_INPUT_EN |
> -					MAX31790_FAN_CFG_RPM_MODE);
> -		} else if (val == 1) {
> -			fan_config = (fan_config |
> -				      MAX31790_FAN_CFG_TACH_INPUT_EN) &
> -				     ~MAX31790_FAN_CFG_RPM_MODE;
> +		if (val == 0)
> +			fan_config |= MAX31790_FAN_CFG_CTRL_MON;
> +		else if (val == 1) {
> +			fan_config &= ~(MAX31790_FAN_CFG_RPM_MODE | MAX31790_FAN_CFG_CTRL_MON);
>  		} else if (val == 2) {
> -			fan_config |= MAX31790_FAN_CFG_TACH_INPUT_EN |
> -				      MAX31790_FAN_CFG_RPM_MODE;
> +			fan_config &= ~(MAX31790_FAN_CFG_CTRL_MON);
> +			fan_config |= MAX31790_FAN_CFG_RPM_MODE;
>  		} else {
>  			err = -EINVAL;
>  			break;
>  		}
> +
> +		/*
> +		 * RPM mode implies enabled TACH input, so enable it in RPM
> +		 * mode.
> +		 */
> +		if (val == 2)
> +			fan_config |= MAX31790_FAN_CFG_TACH_INPUT_EN;
> +
>  		data->fan_config[channel] = fan_config;
>  		err = regmap_write(regmap,
>  				   MAX31790_REG_FAN_CONFIG(channel),
> @@ -400,18 +424,18 @@ static umode_t max31790_is_visible(const void *data,
>  
>  static const struct hwmon_channel_info *max31790_info[] = {
>  	HWMON_CHANNEL_INFO(fan,
> -			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> -			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> -			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> -			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> -			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> -			   HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> -			   HWMON_F_INPUT | HWMON_F_FAULT,
> -			   HWMON_F_INPUT | HWMON_F_FAULT,
> -			   HWMON_F_INPUT | HWMON_F_FAULT,
> -			   HWMON_F_INPUT | HWMON_F_FAULT,
> -			   HWMON_F_INPUT | HWMON_F_FAULT,
> -			   HWMON_F_INPUT | HWMON_F_FAULT),
> +			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> +			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> +			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> +			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> +			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> +			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGET | HWMON_F_FAULT,
> +			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
> +			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
> +			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
> +			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
> +			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT,
> +			   HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_FAULT),
>  	HWMON_CHANNEL_INFO(pwm,
>  			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>  			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
