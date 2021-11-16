Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA9F452E45
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 10:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbhKPJqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 04:46:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20395 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233349AbhKPJqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 04:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637055794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/gJI+/Lq5aRkarenKXwAKuBJuvK2Jwl6N6vyetwo1U0=;
        b=Udi22WdAlc6UgluQl284mCihH/BSiekShAeAMcFhaWxk4qxbE61Pwd4iRiegwsDqcqcjbm
        4cifjqwixyjcswaKq7V8p/8C0RW7vS2jGaKc4a+ITizvUDIVG2ALtHMr1rKR1q5cxVUJH1
        6tYy94pFbQ/kMvZ3AhTrln0J9rEGUDs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-TKGQdpA-NDypxiOuURG9hg-1; Tue, 16 Nov 2021 04:43:13 -0500
X-MC-Unique: TKGQdpA-NDypxiOuURG9hg-1
Received: by mail-ed1-f70.google.com with SMTP id v22-20020a50a456000000b003e7cbfe3dfeso4508347edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 01:43:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/gJI+/Lq5aRkarenKXwAKuBJuvK2Jwl6N6vyetwo1U0=;
        b=SrAZA88DRoDJITrfT1nRv0nSyzR6dUv6xuwtfxdyAADAKbd0sY4IFlHh1p33IPFBf7
         rWzc/K0yWZNxZ7/drJf+7keUufA3g0QURf4Z0+FYjDjLWJTce0vuS3WJHSSQLPxWD6zp
         c825XRCIPC5Nnm2kSzJGZyLu7vlc4ESLsd4FX5fxOAcrlHUTOKVr9GiUxm2ApJyiDDEA
         ABO8/dUDiLngqpaO7FWF0r0WputQN6wDDdGA/vBE0yx2SyGOt52dz/a5ucZn/+Alttu4
         2hmstcOFkUSAcTF8jEbazCUHUPf9frbazJvXl4Bks9aCeJa44bI5F8/NBYBJRu4MwQS4
         SiTw==
X-Gm-Message-State: AOAM531f26ld5Hg/u8JUgKuvACJrDwkKvPsHaJl1622Z51SBo0Oxs7aT
        n8nrFBw8sg4rEfFOINCZRDBg3CJpnCLhF6wGMkSEuBz3CGJPaLAa+V/U4G4HUB99BQ7Q+Iwx05T
        DqhQMr13Gos0qj2xGDQIZ30MR
X-Received: by 2002:a17:906:52cf:: with SMTP id w15mr8021773ejn.122.1637055792471;
        Tue, 16 Nov 2021 01:43:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw7mhtY4eET4LN9sV+SnCqEy35FazLPo2t3ghMXBr9Asn6lew1NgsN4r1t0Y/Krk0LJwKbExg==
X-Received: by 2002:a17:906:52cf:: with SMTP id w15mr8021740ejn.122.1637055792248;
        Tue, 16 Nov 2021 01:43:12 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id z25sm7548720ejd.80.2021.11.16.01.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 01:43:11 -0800 (PST)
Message-ID: <2314890c-cec3-7d1a-125d-47fc7b1d2625@redhat.com>
Date:   Tue, 16 Nov 2021 10:43:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 04/20] power: supply: bq25890: Reduce reported
 CONSTANT_CHARGE_CURRENT_MAX for low temperatures
Content-Language: en-US
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
References: <20211114170335.66994-1-hdegoede@redhat.com>
 <20211114170335.66994-5-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211114170335.66994-5-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/14/21 18:03, Hans de Goede wrote:
> From: Yauhen Kharuzhy <jekhor@gmail.com>
> 
> Take into account possible current reduction due to low-temperature when
> reading POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX. As described in
> the datasheet in cool (0-20° Celcius) conditions the current limit is
> decreased to 20% or 50% of ICHG field value depended on JEITA_ISET field.
> 
> Also add NTC_FAULT field value to the debug message in
> bq25890_get_chip_state().
> 
> Changed by Hans de Goede:
> - Fix reading F_CHG_FAULT instead of F_NTC_FIELD for state->ntc_fault
> - Only read JEITA_ISET field if necessary
> - Tweak commit message a bit
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/power/supply/bq25890_charger.c | 33 +++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index b208cc2193b8..617a653221ab 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -94,6 +94,7 @@ struct bq25890_state {
>  	u8 vsys_status;
>  	u8 boost_fault;
>  	u8 bat_fault;
> +	u8 ntc_fault;
>  };
>  
>  struct bq25890_device {
> @@ -383,6 +384,14 @@ enum bq25890_chrg_fault {
>  	CHRG_FAULT_TIMER_EXPIRED,
>  };
>  
> +enum bq25890_ntc_fault {
> +	NTC_FAULT_NORMAL = 0,
> +	NTC_FAULT_WARM = 2,
> +	NTC_FAULT_COOL = 3,
> +	NTC_FAULT_COLD = 5,
> +	NTC_FAULT_HOT = 6,
> +};
> +
>  static bool bq25890_is_adc_property(enum power_supply_property psp)
>  {
>  	switch (psp) {
> @@ -474,6 +483,18 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>  
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
>  		val->intval = bq25890_find_val(bq->init_data.ichg, TBL_ICHG);
> +
> +		/* When temperature is too low, charge current is decreased */
> +		if (bq->state.ntc_fault == NTC_FAULT_COOL) {
> +			ret = bq25890_field_read(bq, F_JEITA_ISET);
> +			if (ret < 0)
> +				return ret;
> +
> +			if (ret)
> +				val->intval /= 5;
> +			else
> +				val->intval /= 2;
> +		}
>  		break;
>  
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> @@ -486,6 +507,10 @@ static int bq25890_power_supply_get_property(struct power_supply *psy,
>  		if (ret < 0)
>  			return ret;
>  
> +		ret = bq25890_field_read(bq, F_JEITA_VSET);
> +		if (ret < 0)
> +			return ret;
> +
>  		/* converted_val = 2.304V + ADC_val * 20mV (table 10.3.15) */
>  		val->intval = 2304000 + ret * 20000;
>  		break;

Ugh, this should not be here. I guess this is a leftover from an attempt to
also apply temperature correction to the POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE
prop.

I'll drop this for v3 of the series. Note I'll first wait a week or so for
other feedback.

Regards,

Hans




> @@ -549,7 +574,8 @@ static int bq25890_get_chip_state(struct bq25890_device *bq,
>  		{F_VSYS_STAT,	&state->vsys_status},
>  		{F_BOOST_FAULT, &state->boost_fault},
>  		{F_BAT_FAULT,	&state->bat_fault},
> -		{F_CHG_FAULT,	&state->chrg_fault}
> +		{F_CHG_FAULT,	&state->chrg_fault},
> +		{F_NTC_FAULT,	&state->ntc_fault}
>  	};
>  
>  	for (i = 0; i < ARRAY_SIZE(state_fields); i++) {
> @@ -560,9 +586,10 @@ static int bq25890_get_chip_state(struct bq25890_device *bq,
>  		*state_fields[i].data = ret;
>  	}
>  
> -	dev_dbg(bq->dev, "S:CHG/PG/VSYS=%d/%d/%d, F:CHG/BOOST/BAT=%d/%d/%d\n",
> +	dev_dbg(bq->dev, "S:CHG/PG/VSYS=%d/%d/%d, F:CHG/BOOST/BAT/NTC=%d/%d/%d/%d\n",
>  		state->chrg_status, state->online, state->vsys_status,
> -		state->chrg_fault, state->boost_fault, state->bat_fault);
> +		state->chrg_fault, state->boost_fault, state->bat_fault,
> +		state->ntc_fault);
>  
>  	return 0;
>  }
> 

