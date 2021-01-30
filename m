Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A9830978A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 19:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhA3S2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 13:28:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23047 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229620AbhA3S2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 13:28:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612031197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bMLhJaveBRc7lRWdxOIflNe79Y1svj3iInUTQFcS9uE=;
        b=OD3m7H1NBnvHcumRIjc9KD39/s+hJ8zeqCxQUaOp5Cow2BsqUuRgSGgsguxqQs7Roy7q4M
        Gubrf4Z4beMw1NFcYBFK10WUducWrGHwRgwb+YwRGz27xXDxg08v512lCxcGIldvajkU1p
        axmEFQUIKhQ7QqxgpjRPj6uiAqriNF8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-rFdMq61QPpeFPXoCnuES6w-1; Sat, 30 Jan 2021 13:26:35 -0500
X-MC-Unique: rFdMq61QPpeFPXoCnuES6w-1
Received: by mail-ej1-f69.google.com with SMTP id jg11so5787418ejc.23
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 10:26:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bMLhJaveBRc7lRWdxOIflNe79Y1svj3iInUTQFcS9uE=;
        b=lPkPtICD52GMdeM8paOydDFRp7U83689ryo/xkTM1bXPN5gWg1YJO+GXDx/s1ES+2F
         vI0EktLzjydseXshikK8qaAauH7I8tmmbSlFBnEesd17GGKRbxTqcpZU9DtuOkLBfmjY
         8PnMyMUnPF8QQp79J2os1UMm2vyHelDlqmdAVmEEOY5lyr6uidL/Z4P57J68Qufyv4yD
         tGlA8/ITAbosApw599Av00FjzL/jugLISIBihkF8RKakH141ofptAEYEcZbc5ahFIUfK
         O+jMPaQkUXi4ppBBII/QUW3/x9wEttaD0M1JjhpX2KRkX1/G2I4Cd3EMOZr/XF/Qmcsc
         0D6w==
X-Gm-Message-State: AOAM530hSqooDYlK4Ko6YOP6ZFBA1oMr0TWFXtX7rG2LtTUMl2q6BP8L
        pcWR4roLnlac+A0r5hxD5wTUpusr8VswEl+KimrQjpESumt6nz+blD8EKYQH306WYST9RyYjazu
        S26jD1jXkwGr+cf1JOgQJp/8K
X-Received: by 2002:a17:906:198b:: with SMTP id g11mr10120200ejd.536.1612031194145;
        Sat, 30 Jan 2021 10:26:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyewTalC1oL45I+R9G5vtqxAb67qhsr7XziI+556v3UJy3kBbvg9uZD1OFoMYXNzL2Gs8xDYQ==
X-Received: by 2002:a17:906:198b:: with SMTP id g11mr10120189ejd.536.1612031193998;
        Sat, 30 Jan 2021 10:26:33 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id y1sm584061edq.26.2021.01.30.10.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jan 2021 10:26:33 -0800 (PST)
Subject: Re: [PATCH v4 13/13] ASoC: Intel: bytcr_wm5102: Add jack detect
 support
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        alsa-devel@alsa-project.org
References: <20210123121313.79530-1-hdegoede@redhat.com>
 <20210123121720.79863-1-hdegoede@redhat.com>
 <20210123121720.79863-4-hdegoede@redhat.com>
 <20210130154035.GX106851@ediswmail.ad.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9492d03c-2198-1298-b15c-944b2cdd7876@redhat.com>
Date:   Sat, 30 Jan 2021 19:26:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210130154035.GX106851@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/30/21 4:40 PM, Charles Keepax wrote:
> On Sat, Jan 23, 2021 at 01:17:20PM +0100, Hans de Goede wrote:
>> Add jack detect support by creating a jack and calling
>> snd_soc_component_set_jack to register the created jack
>> with the codec.
>>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> +static struct snd_soc_jack_pin byt_wm5102_pins[] = {
>> +	{
>> +		.pin	= "Headphone",
>> +		.mask	= SND_JACK_HEADPHONE,
>> +	},
>> +	{
>> +		.pin	= "Headset Mic",
>> +		.mask	= SND_JACK_MICROPHONE,
>> +	},
>> +};
>> +
> 
> This patch looks fine to me, but I did have one small question.
> What is the thinking behind punting this to the machine driver?
> 
> I guess you can not register it if there is no jack present
> on the board, or if you have multiple jacks name them
> meaningfully. Although I sort of feel like those applied to
> the old extcon approach that just internally registered all
> the interfaces.

To be honest I'm not 100% sure why this is done this way,
this is how *all* ASoC drivers do it (AFAICT).

I think it is done this way because of 2 reasons:

1. The pins controlled by the jack are what for lack of
a better word I call "end-point" pins. And these get
registered by the machine-driver, so to make sure that
the names match it makes sense to also declare the
snd_soc_jack_pin array in the machine-driver.
For example the "Headphone" pin is a widget registered
by the machine driver as:

        SND_SOC_DAPM_HP("Headphone", NULL),

2. Probe ordering, the jack gets attached to the card and
when the coded driver's probe function runs the card does
not exist yet. But I think that could be worked around by
doing things in the component-probe function.

Regards,

Hans

