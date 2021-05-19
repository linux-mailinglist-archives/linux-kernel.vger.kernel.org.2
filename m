Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68793899AE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 01:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhESXMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 19:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhESXM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 19:12:29 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A0DC061574;
        Wed, 19 May 2021 16:11:09 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id q6so7732713qvb.2;
        Wed, 19 May 2021 16:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FBlJ7zHI3Or7VFLQpssqmkjDcIseDEE83biZBzESico=;
        b=RX6Vp/sg6U76hUaUzi1uRe/vb7sDYqAIS/Tp73pNu4DmP35kqjrR4WYUJpBvh2bWHr
         NNsB1HIsWPdPdNIg5kc1oguCE9DACFFQ/+a6Iw5LecotB6TUaEdfXM2K9JXPNQHE2JLe
         LVhbMx9TjDNs+ncK3pTjaGWiodda1/fp7l1e75GW0lHCB7fiou+kwbnp1d0P7aVwYeJD
         xPlcCIB749Imejr6JPKlHryRQqMBRAyueNxaMbBsjOQ7ex3rZWiuYYSl4dLKtjlQoPak
         SfblH6KbnOUZM6lRhZQs0UMzzo4Ivmt4WED9fctJAWv85EB4edGYyDphmALyskI2aagH
         W3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FBlJ7zHI3Or7VFLQpssqmkjDcIseDEE83biZBzESico=;
        b=ol2gW38s4ps6CmI6iEuvyf9hicLQ/87ptRLXETH/6hnVquuhkwK0EPOebOm8N2ZXYC
         C3HKpwo6YmCiJ7V41BSwOGlmOiEkdlc46j7zYhf3tKnsFVR7Mi8BIhwqA7oLyzi7+0fO
         uKDtQaebwcJnQP3Q1TsIGFmDmPmy0wr4zH8tgFdG0Pc+2BdX9Znh/0IRCygoTnvMI1X5
         PeJb1nzpChgmkNIWvAC45EFaiuWZgoN0h4BjVoYe5wyN9I66ZQ9jASnTxhK8UuZK12CZ
         AQf1xnXi8s+eknZIywbhTJdSwknIxBLbYktJ/mjmrLLiAdpgmhg2wHoOtKA8HTBB9ik2
         wllw==
X-Gm-Message-State: AOAM530lOFi+ba5IOdlSJ0hp2K1TGWtTo2qQ16IYXEB8dkaQa5cLYwt2
        J9C1MO9y/GVQihsTsKOjqLSMjL1nQG8=
X-Google-Smtp-Source: ABdhPJzaJCuf6cdduhXPHGqfojZ/Y1FzyQWczY+r+pR0cpAPA5Iq9cbA++1eUkd3lYR3flaauTpcmQ==
X-Received: by 2002:a0c:d80b:: with SMTP id h11mr2141688qvj.10.1621465867783;
        Wed, 19 May 2021 16:11:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y9sm792583qki.66.2021.05.19.16.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 16:11:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     =?UTF-8?B?VsOhY2xhdiBLdWJlcm7DoXQ=?= <kubernat@cesnet.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210512013052.903297-1-kubernat@cesnet.cz>
 <20210512013052.903297-2-kubernat@cesnet.cz>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 2/5] hwmon: (max31790) Fix and split pwm*_enable
Message-ID: <d5053aca-14a4-d896-e2cd-5cfa2ed83d04@roeck-us.net>
Date:   Wed, 19 May 2021 16:11:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512013052.903297-2-kubernat@cesnet.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/21 6:30 PM, Václav Kubernát wrote:
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
The above is an indication that the current code is simply wrong.
pwmX_enable does not and should not have anything to do with
fan speed monitoring (even though it may implicitly enable it).

Fixing pwmX_enable therefore needs to be a separate patch from
introducing fanX_enable, and like the other fixes it needs to come
first, before changing the code to use regmap (to enable backporting).

More comments below.

Thanks,
Guenter

> Signed-off-by: Václav Kubernát <kubernat@cesnet.cz>
> ---
>   Documentation/hwmon/max31790.rst | 10 ++--
>   drivers/hwmon/max31790.c         | 78 +++++++++++++++++++++-----------
>   2 files changed, 58 insertions(+), 30 deletions(-)
> 
> diff --git a/Documentation/hwmon/max31790.rst b/Documentation/hwmon/max31790.rst
> index f301385d8cef..d2ac4e926905 100644
> --- a/Documentation/hwmon/max31790.rst
> +++ b/Documentation/hwmon/max31790.rst
> @@ -34,10 +34,14 @@ also be configured to serve as tachometer inputs.
>   Sysfs entries
>   -------------
>   
> -================== === =======================================================
> +================== === =============================================================
> +fan[1-12]_enable   RW  enable fan speed monitoring
>   fan[1-12]_input    RO  fan tachometer speed in RPM
>   fan[1-12]_fault    RO  fan experienced fault
>   fan[1-6]_target    RW  desired fan speed in RPM
> -pwm[1-6]_enable    RW  regulator mode, 0=disabled, 1=manual mode, 2=rpm mode
> +pwm[1-6]_enable    RW  regulator mode, 0=no control, sets 0% PWM,
> +				       1=manual (pwm) mode,
> +				       2=rpm mode
> +                       setting rpm mode sets fan*_enable to 1
>   pwm[1-6]           RW  fan target duty cycle (0-255)
> -================== === =======================================================
> +================== === =============================================================
> diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
> index e3765ce4444a..5d4c551df010 100644
> --- a/drivers/hwmon/max31790.c
> +++ b/drivers/hwmon/max31790.c
> @@ -30,6 +30,7 @@
>   #define MAX31790_FAN_CFG_RPM_MODE	0x80
>   #define MAX31790_FAN_CFG_TACH_INPUT_EN	0x08
>   #define MAX31790_FAN_CFG_TACH_INPUT	0x01
> +#define MAX31790_FAN_CFG_CTRL_MON	0x10

This define should be above MAX31790_FAN_CFG_TACH_INPUT_EN
to maintain sequence/order.

>   
>   /* Fan Dynamics register bits */
>   #define MAX31790_FAN_DYN_SR_SHIFT	5
> @@ -191,6 +192,9 @@ static int max31790_read_fan(struct device *dev, u32 attr, int channel,
>   		else
>   			*val = !!(fault & (1 << channel));
>   		return 0;
> +	case hwmon_fan_enable:
> +		*val = !!(data->fan_config[channel] & MAX31790_FAN_CFG_TACH_INPUT_EN);
> +		return 0;
>   	default:
>   		return -EOPNOTSUPP;
>   	}
> @@ -233,6 +237,15 @@ static int max31790_write_fan(struct device *dev, u32 attr, int channel,
>   				     MAX31790_REG_TARGET_COUNT(channel),
>   				     target_count);
>   		break;
> +	case hwmon_fan_enable:
> +		if (val == 0)
> +			data->fan_config[channel] &= ~MAX31790_FAN_CFG_TACH_INPUT_EN;
> +		else
> +			data->fan_config[channel] |= MAX31790_FAN_CFG_TACH_INPUT_EN;
> +		err = regmap_write(regmap,
> +				   MAX31790_REG_FAN_CONFIG(channel),
> +				   data->fan_config[channel]);
> +		break;
>   	default:
>   		err = -EOPNOTSUPP;
>   		break;
> @@ -260,6 +273,11 @@ static umode_t max31790_fan_is_visible(const void *_data, u32 attr, int channel)
>   		    !(fan_config & MAX31790_FAN_CFG_TACH_INPUT))
>   			return 0644;
>   		return 0;
> +	case hwmon_fan_enable:
> +		if (channel < NR_CHANNEL ||
> +		    (fan_config & MAX31790_FAN_CFG_TACH_INPUT))
> +			return 0644;
> +		return 0;
>   	default:
>   		return 0;
>   	}
> @@ -281,12 +299,12 @@ static int max31790_read_pwm(struct device *dev, u32 attr, int channel,
>   		*val = read >> 8;
>   		return 0;
>   	case hwmon_pwm_enable:
> -		if (data->fan_config[channel] & MAX31790_FAN_CFG_RPM_MODE)
> +		if (data->fan_config[channel] & MAX31790_FAN_CFG_CTRL_MON)
> +			*val = 0;
> +		else if (data->fan_config[channel] & MAX31790_FAN_CFG_RPM_MODE)
>   			*val = 2;
> -		else if (data->fan_config[channel] & MAX31790_FAN_CFG_TACH_INPUT_EN)
> +		else
>   			*val = 1;
> -		else
> -			*val = 0;
>   		return 0;
>   	default:
>   		return -EOPNOTSUPP;
> @@ -298,35 +316,41 @@ static int max31790_write_pwm(struct device *dev, u32 attr, int channel,
>   {
>   	struct max31790_data *data = dev_get_drvdata(dev);
>   	struct regmap *regmap = data->regmap;
> -	u8 fan_config;
> +	u8 fan_config = data->fan_config[channel];
>   	int err = 0;
>   
>   	mutex_lock(&data->update_lock);
>   
>   	switch (attr) {
>   	case hwmon_pwm_input:
> -		if (val < 0 || val > 255) {
> +		if (fan_config & MAX31790_FAN_CFG_CTRL_MON || val < 0 || val > 255) {

No. It has to be possible to set the target pwm value before enabling pwm control.

>   			err = -EINVAL;
>   			break;
>   		}
> +
>   		err = write_reg_word(regmap, MAX31790_REG_PWMOUT(channel), val << 8);
>   		break;
>   	case hwmon_pwm_enable:
>   		fan_config = data->fan_config[channel];
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
>   		} else if (val == 2) {
> -			fan_config |= MAX31790_FAN_CFG_TACH_INPUT_EN |
> -				      MAX31790_FAN_CFG_RPM_MODE;
> +			fan_config &= ~(MAX31790_FAN_CFG_CTRL_MON);

Unnecessary ( )

> +			fan_config |= MAX31790_FAN_CFG_RPM_MODE;
>   		} else {
>   			err = -EINVAL;
>   			break;
>   		}
> +
> +		/*
> +		 * RPM mode implies enabled TACH input, so enable it in RPM
> +		 * mode.
> +		 */
> +		if (val == 2)
> +			fan_config |= MAX31790_FAN_CFG_TACH_INPUT_EN;
> +

The datasheet says this is automatically enabled in rpm mode, meaning there
is no need to explicitly set the bit. I don't know if the bit is set
automatically. If not, it should not be set here. Either case, there is
already an "if (val ==2)" check above. If needed, this bit should be set there.

>   		data->fan_config[channel] = fan_config;
>   		err = regmap_write(regmap,
>   				   MAX31790_REG_FAN_CONFIG(channel),
> @@ -400,18 +424,18 @@ static umode_t max31790_is_visible(const void *data,
>   
>   static const struct hwmon_channel_info *max31790_info[] = {
>   	HWMON_CHANNEL_INFO(fan,
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
>   	HWMON_CHANNEL_INFO(pwm,
>   			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>   			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> 

