Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D3633AF8A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhCOKEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhCOKEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:04:49 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64502C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:04:49 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t9so5358168wrn.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 03:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jkZ02T2BJegmsix35OU5eYN8wUDGnZfwIYIhms9Bp9w=;
        b=W5Ke2/Pj2T9EicF1ORskdaNrC3LHoli+LihZpIFdxbZw/Q0h9HfRraVojRfPSD8use
         7ub68bdYfI/KIApUviCOhl/dRNk04CNM8udUMn+Kgi/3qrvprWHRh2CiXh1S6sEJyqQ/
         C1lRgFZsyoz0CoFMe4mkoaCCCOXNVfUvbLa5sN6ycL+OEFH/3OFLuVBXNNAjUPIuVtFz
         /86dh88eqon3kSVa8UuNOv+yp20eCE759tv08K2LO/420X4+RzJyzYaEIqphRzLMtvOK
         BVTtTQhOr9CEuctJ4nnc3kPj4ueP6j80f8PHLp6eD/7Bg5Oly1k89wDaupgBCMm0G6Et
         ROZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jkZ02T2BJegmsix35OU5eYN8wUDGnZfwIYIhms9Bp9w=;
        b=gRAyDaKZZlywX8G7uGLF0geYBEl/l4ZlNmgA5N5NlGJFamCzNMwuwEU/rXhM+Bvqhi
         Lkngh3h9cNKuefhaGBkBbKhWhDQBcCT6hCfSykM1g4XE5PxoHiAF3G1CZKiGoSH+jm3b
         W6hjOyXRkK2bGOJxDggLA+Rfdb5OqamGTseHAi/udxcOxTaeCL7uFpEjJEji0d2G36Mk
         +usz1151y7VefbM0DLSBs2lNpWb+DYQLYMmxXHUO3+pS4bNMwfeyK5eQ+FSCWph2F6Jy
         fltElzjB17ZY+NjocPhPmGKgrd5I9e61fRpMeoHYAFwjq34/0Tvl3Lxiocq3I0FdmO9f
         lFqQ==
X-Gm-Message-State: AOAM5321qCa0nI3YCAQn88lhj4doL7Vg9lWHcCzVS/Z6k721uvgv3TSH
        9xsjYjjaDNMEeOcsKtUcEkHyQA==
X-Google-Smtp-Source: ABdhPJz+6ktpW9oFvyi0twxihfVovojX60okBC3Y1HycuDbLRPKBgNRVsqqYxuEh9En0hEnky05Lzw==
X-Received: by 2002:adf:c40b:: with SMTP id v11mr26186217wrf.320.1615802687982;
        Mon, 15 Mar 2021 03:04:47 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id m9sm17960412wro.52.2021.03.15.03.04.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Mar 2021 03:04:47 -0700 (PDT)
Subject: Re: [PATCH 4/7] ASoC: codecs: wcd938x: add basic controls
To:     Mark Brown <broonie@kernel.org>
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com
References: <20210311173416.25219-1-srinivas.kandagatla@linaro.org>
 <20210311173416.25219-5-srinivas.kandagatla@linaro.org>
 <20210312155547.GJ5348@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <509b836d-520d-4528-0f1a-da0c21e86c68@linaro.org>
Date:   Mon, 15 Mar 2021 10:04:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210312155547.GJ5348@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Mark for review,

On 12/03/2021 15:55, Mark Brown wrote:
> On Thu, Mar 11, 2021 at 05:34:13PM +0000, Srinivas Kandagatla wrote:
> 
>> +	if (wcd938x->variant == WCD9380) {
> 
> switch statements please.
> 
>> +		if (mode_val == CLS_H_HIFI || mode_val == CLS_AB_HIFI) {
>> +			dev_info(component->dev,
>> +				"%s:Invalid HPH Mode, default to CLS_H_ULP\n",
>> +				__func__);
>> +			mode_val = CLS_H_ULP;
>> +		}
> 
> If the value can't be set an error should be returned rather than the
> input ignored.

I agree with all the comments related to switch statements and ignoring 
return values, will address them in next version.

> 
>> +static int wcd938x_ear_pa_gain_get(struct snd_kcontrol *kcontrol,
>> +				   struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
>> +
>> +	ucontrol->value.integer.value[0] = snd_soc_component_read_field(component,
>> +						WCD938X_ANA_EAR_COMPANDER_CTL,
>> +						WCD938X_EAR_GAIN_MASK);
>> +
>> +	return 0;
>> +}
> 
> This just looks like a normal operation?
> 
Yes, this can probably go into a TLV control, will fix this in next version.


--srini
>> +static int wcd938x_ear_pa_gain_put(struct snd_kcontrol *kcontrol,
>> +				   struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
>> +	struct wcd938x_sdw_priv *wcd = snd_soc_component_get_drvdata(component);
>> +	struct wcd938x_priv *wcd938x = wcd->wcd938x;
>> +
>> +	if (!wcd938x->comp1_enable) {
>> +		snd_soc_component_write_field(component,
>> +				WCD938X_ANA_EAR_COMPANDER_CTL,
>> +				WCD938X_EAR_GAIN_MASK,
>> +				ucontrol->value.integer.value[0]);
>> +	}
> 
> Again, values should not be ignored on error.
> 
>> +	if (wcd938x->variant == WCD9380) {
>> +		ret = snd_soc_add_component_controls(component, wcd9380_snd_controls,
>> +					ARRAY_SIZE(wcd9380_snd_controls));
>> +		if (ret < 0) {
>> +			dev_err(component->dev,
>> +				"%s: Failed to add snd ctrls for variant: %d\n",
>> +				__func__, wcd938x->variant);
>> +			goto err;
>> +		}
>> +	}
>> +	if (wcd938x->variant == WCD9385) {
> 
> Again, switch statements - I'll never understand why people seem so
> intent on writing if trees :(
> 
