Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8433A6C93
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 19:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbhFNRBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 13:01:41 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:39786 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbhFNRBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 13:01:35 -0400
Received: by mail-wm1-f48.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso13564820wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=giu5t1ZJoDtjd9HrozCoAGsuGJjanw/vPGOmtscX5Cs=;
        b=tSCWhahZ/W2djqrKDZgEuHhTAr9umg77GxrEpH2qmyK7p9nhaNgs9zWZy6Ge3xTknw
         E+3vsUJJbtCCvg6uea5Mv4omGxu8io+SHMwsYfl8XiR8GbHXEpUAOHjthVHzHjeOXWJ7
         Lga7cglSlw4gWXLy/VCaLU01vhSScHF3VdP/3PikPHbK9MWnjFi/UbP2e+Rd/cgzInu2
         0MSnnuMddFWW2ec0Q0d4Ms374Fy5r/19dI4US427VSUg0RyLPjPcFvJkRiaMzb4eHG93
         qd7hUYO4d+M+qiyiZjPI890GVIoVpHy0hg8rgBFTTmHJoAbvFsyYsNOILXVPO/VvCN3G
         4Tag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=giu5t1ZJoDtjd9HrozCoAGsuGJjanw/vPGOmtscX5Cs=;
        b=JVDe5I7y9W5FEiIB1jdoP6vq5M/u1Hf4NjAPeUmC2tbHXbMtasWQRfaq/L57uMEFRL
         KVkzqGGc9JDMTRekvPBuOlORVDRce68HdAPQCzfUNx0/qJD2AakMJmUNQYBKlSZGzxoy
         Ph5kx9r4+m6GErUowiMgZVNw8uET9qSKHLioKVW+bdDAOFImY8yUwztg1us/Glnyjrrm
         9WLpHzLu2e0/JbSMNP226jR156V6GDoa+BA2Nsf4cJF/qAqbZxotTHYylMPXD2SMuxj1
         dH3IwkJbRpAhstyWZfMPWTLetagP6+vcQ1hJRBZvFoZAT2kSD3DlhKd1FyFhcjdt5OIo
         9LMw==
X-Gm-Message-State: AOAM530IgfGqnehLqA3cpgO3JKez9yTc1Qq3bIUxUSA7lif/CTr89c0e
        VZZFZOsDNN/UdG88xx6tlC2fzA==
X-Google-Smtp-Source: ABdhPJyE/uLFsbeEgXsQzzS+2i1pwKmQNwLMqFWbiLFGX6m0o585ZozMlGPHOwdSfJL+e5AMB6diNw==
X-Received: by 2002:a7b:cc8f:: with SMTP id p15mr39151wma.111.1623689897864;
        Mon, 14 Jun 2021 09:58:17 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9d56:9c35:8a63:312c? ([2a01:e34:ed2f:f020:9d56:9c35:8a63:312c])
        by smtp.googlemail.com with ESMTPSA id r18sm16684407wro.62.2021.06.14.09.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 09:58:17 -0700 (PDT)
Subject: Re: [PATCH v8] thermal: mediatek: add another get_temp ops for
 thermal sensors
To:     Ben Tseng <ben.tseng@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        srv_heupstream@mediatek.com
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, hsinyi@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Michael Kao <michael.kao@mediatek.com>
References: <20210603110042.21688-1-ben.tseng@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <eeb2a96d-5cd0-ef11-b16e-872d9f3dcb09@linaro.org>
Date:   Mon, 14 Jun 2021 18:58:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210603110042.21688-1-ben.tseng@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2021 13:00, Ben Tseng wrote:
> From: Michael Kao <michael.kao@mediatek.com>
> 
> Provide thermal zone to read thermal sensor
> in the SoC. We can read all the thermal sensors
> value in the SoC by the node /sys/class/thermal/
> 
> In mtk_thermal_bank_temperature, return -EAGAIN instead of -EACCESS
> on the first read of sensor that often are bogus values.
> This can avoid following warning on boot:
> 
>   thermal thermal_zone6: failed to read out thermal zone (-13)
> 
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
> 
> ---
> 
> This patchset supports for MT8183 chip to mtk_thermal.c.
> Add thermal zone of all the thermal sensor in SoC for
> another get temperatrue. They don't need to thermal throttle.
> And we bind coolers for thermal zone nodes of cpu_thermal.
> 
> Changes in V8:
>     - Rebase to kernel-v5.13-rc1
>     - Resend
> 
> Changes in v7:
>     - Fix build error in v6.
> 
> Changes in v6:
>     - Rebase to kernel-5.11-rc1.
>     - [1/3]
>         - add interrupts property.
>     - [2/3]
>         - add the Tested-by in the commit message.
>     - [3/3]
>         - use the mt->conf->msr[id] instead of conf->msr[id] in the
>           _get_sensor_temp and mtk_thermal_bank_temperature.
>         - remove the redundant space in _get_sensor_temp and
>           mtk_read_sensor_temp.
>         - change kmalloc to dev_kmalloc in mtk_thermal_probe.
> 
> Changes in v5:
>     - Rebase to kernel-5.9-rc1.
>     - Revise the title of cover letter.
>     - Drop "[v4,7/7] thermal: mediatek: use spinlock to protect PTPCORESEL"
>     - [2/2]
>         -  Add the judgement to the version of raw_to_mcelsius.
> 
> Changes in v4:
>     - Rebase to kernel-5.6-rc1.
>     - [1/7]
>         - Squash thermal zone settings in the dtsi from [v3,5/8]
>           arm64: dts: mt8183: Increase polling frequency for CPU thermal zone.
>         - Remove the property of interrupts and mediatek,hw-reset-temp.
>     - [2/7]
>         - Correct commit message.
>     - [4/7]
>         - Change the target temperature to the 80C and change the commit message.
>     - [6/7]
>         - Adjust newline alignment.
>         - Fix the judgement on the return value of registering thermal zone.
> 
> Changes in v3:
>     - Rebase to kernel-5.5-rc1.
>     - [1/8]
>         - Update sustainable power of cpu, tzts1~5 and tztsABB.
>     - [7/8]
>         - Bypass the failure that non cpu_thermal sensor is not find in thermal-zones
>           in dts, which is normal for mt8173, so prompt a warning here instead of
>           failing.
> 
> 	Return -EAGAIN instead of -EACCESS on the first read of sensor that
>         often are bogus values. This can avoid following warning on boot:
> 
>           thermal thermal_zone6: failed to read out thermal zone (-13)
> 
> Changes in v2:
>     - [1/8]
>         - Add the sustainable-power,trips,cooling-maps to the tzts1~tztsABB.
>     - [4/8]
>         - Add the min opp of cpu throttle.
> 
> Matthias Kaehlcke (1):
>   arm64: dts: mt8183: Configure CPU cooling
> 
> Michael Kao (2):
>   thermal: mediatek: add another get_temp ops for thermal sensors
>   arm64: dts: mt8183: add thermal zone node
> ---
>  drivers/thermal/mtk_thermal.c | 100 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 75 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 97e8678..b6bee451 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -245,6 +245,11 @@ enum mtk_thermal_version {
>  
>  struct mtk_thermal;
>  
> +struct mtk_thermal_zone {
> +	struct mtk_thermal *mt;
> +	int id;
> +};

How does it differ from 'struct mtk_thermal_bank' ?

>  struct thermal_bank_cfg {
>  	unsigned int num_sensors;
>  	const int *sensors;
> @@ -637,6 +642,30 @@ static void mtk_thermal_put_bank(struct mtk_thermal_bank *bank)
>  		mutex_unlock(&mt->lock);
>  }
>  
> +static u32 _get_sensor_temp(struct mtk_thermal *mt, int id)
> +{
> +	u32 raw;
> +	int temp;
> +
> +	raw = readl(mt->thermal_base + mt->conf->msr[id]);
> +
> +	if (mt->conf->version == MTK_THERMAL_V1)
> +		temp = raw_to_mcelsius_v1(mt, id, raw);
> +	else
> +		temp = raw_to_mcelsius_v2(mt, id, raw);

Please add the proper conversion function as a callback and set it at
probe time, instead of checking at every call.

> +	/*
> +	 * The first read of a sensor often contains very high bogus
> +	 * temperature value. Filter these out so that the system does
> +	 * not immediately shut down.
> +	 */

If it happens only once, why not call this function at probe time so
this test won't be needed.

> +	if (temp > 200000)
> +		return -EAGAIN;
> +	else
> +		return temp;
> +}
> +
>  /**
>   * mtk_thermal_bank_temperature - get the temperature of a bank
>   * @bank:	The bank
> @@ -647,28 +676,11 @@ static void mtk_thermal_put_bank(struct mtk_thermal_bank *bank)
>  static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>  {
>  	struct mtk_thermal *mt = bank->mt;
> -	const struct mtk_thermal_data *conf = mt->conf;
>  	int i, temp = INT_MIN, max = INT_MIN;
> -	u32 raw;
> -
> -	for (i = 0; i < conf->bank_data[bank->id].num_sensors; i++) {
> -		raw = readl(mt->thermal_base + conf->msr[i]);
>  
> -		if (mt->conf->version == MTK_THERMAL_V1) {
> -			temp = raw_to_mcelsius_v1(
> -				mt, conf->bank_data[bank->id].sensors[i], raw);
> -		} else {
> -			temp = raw_to_mcelsius_v2(
> -				mt, conf->bank_data[bank->id].sensors[i], raw);
> -		}
> +	for (i = 0; i < mt->conf->bank_data[bank->id].num_sensors; i++) {
>  
> -		/*
> -		 * The first read of a sensor often contains very high bogus
> -		 * temperature value. Filter these out so that the system does
> -		 * not immediately shut down.
> -		 */
> -		if (temp > 200000)
> -			temp = 0;
> +		temp = _get_sensor_temp(mt, i);
>  
>  		if (temp > max)
>  			max = temp;
> @@ -679,7 +691,8 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>  
>  static int mtk_read_temp(void *data, int *temperature)
>  {
> -	struct mtk_thermal *mt = data;
> +	struct mtk_thermal_zone *tz = data;
> +	struct mtk_thermal *mt = tz->mt;
>  	int i;
>  	int tempmax = INT_MIN;
>  
> @@ -698,10 +711,28 @@ static int mtk_read_temp(void *data, int *temperature)
>  	return 0;
>  }
>  
> +static int mtk_read_sensor_temp(void *data, int *temperature)
> +{
> +	struct mtk_thermal_zone *tz = data;
> +	struct mtk_thermal *mt = tz->mt;
> +	int id = tz->id - 1;
> +
> +	if (id < 0)
> +		return -EACCES;

How this can happen ?

> +
> +	*temperature = _get_sensor_temp(mt, id);
> +
> +	return 0;
> +}
> +
>  static const struct thermal_zone_of_device_ops mtk_thermal_ops = {
>  	.get_temp = mtk_read_temp,
>  };
>  
> +static const struct thermal_zone_of_device_ops mtk_thermal_sensor_ops = {
> +	.get_temp = mtk_read_sensor_temp,
> +};
> +
>  static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
>  				  u32 apmixed_phys_base, u32 auxadc_phys_base,
>  				  int ctrl_id)
> @@ -992,6 +1023,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>  	u64 auxadc_phys_base, apmixed_phys_base;
>  	struct thermal_zone_device *tzdev;
>  	void __iomem *apmixed_base, *auxadc_base;
> +	struct mtk_thermal_zone *tz;
>  
>  	mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
>  	if (!mt)
> @@ -1080,11 +1112,29 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, mt);
>  
> -	tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, mt,
> -						     &mtk_thermal_ops);
> -	if (IS_ERR(tzdev)) {
> -		ret = PTR_ERR(tzdev);
> -		goto err_disable_clk_peri_therm;
> +	for (i = 0; i < mt->conf->num_sensors + 1; i++) {
> +		tz = devm_kmalloc(&pdev->dev, sizeof(*tz), GFP_KERNEL);
> +		if (!tz)
> +			return -ENOMEM;
> +
> +		tz->mt = mt;
> +		tz->id = i;
> +
> +		tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, i, tz, (i == 0) ?
> +							     &mtk_thermal_ops :
> +							     &mtk_thermal_sensor_ops);
> +
> +		if (IS_ERR(tzdev)) {
> +			if (PTR_ERR(tzdev) == -ENODEV) {
> +				dev_warn(&pdev->dev,
> +					 "sensor %d not registered in thermal zone in dt\n", i);
> +				continue;
> +			}
> +			if (PTR_ERR(tzdev) == -EACCES) {
> +				ret = PTR_ERR(tzdev);
> +				goto err_disable_clk_peri_therm;
> +			}

If the error is none of the above, the loop continues. Is that what you
want ?

> +		}
>  	}
>  
>  	return 0;
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
