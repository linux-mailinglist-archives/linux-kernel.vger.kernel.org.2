Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628253C3A19
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 06:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhGKEZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 00:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhGKEZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 00:25:26 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB42C0613DD;
        Sat, 10 Jul 2021 21:22:39 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id w15-20020a056830144fb02904af2a0d96f3so14506765otp.6;
        Sat, 10 Jul 2021 21:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o8LT6XJ5bF28jziqUqh4TdDSBHyFb1iTqzdwN1Ha+XM=;
        b=M4I3R3v4e8ka38W1eujf0EDMhfZ7PNO1wkDMpwzi4M7nAPQFC9i1CjaFdRMRVaE//Z
         m3ZhxqCa/kNJf0r3xmE25y4eGH2R4+Wb47/B9xhwBCFHuE/myxcE3lj4ApMOo9bBvZ17
         l22pd3O7/OVC1ywc7dq6nHc/+xTuE+6mBq8bdjOO8PTTqa9u8G7iEUFF4pDXDgQoqRX2
         Om5vnG1vbxmxKa85apQYVfL+1UyKNaGhWr8YLc/nqWIphAk+/by+XY/egtsLMqunD0LB
         lhZXBZwaW6L6TEYXAG6xFgTTrubozeLuiDgXWLWCwRPZ9IoN4Se9UHWCLVvwR8kz4BZK
         3J2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o8LT6XJ5bF28jziqUqh4TdDSBHyFb1iTqzdwN1Ha+XM=;
        b=XgItoSthUZx1M8/zo0MhbAKuvak2M/6Z62LjXEQ1W57domBbO8hjvNr6ZswSeQEOBG
         Z41JoMEFh/MCgjwzF5xLKFXH79D+k8tD6EoQeNdfFsf/E3H3d5BnFtDd3wQ1hQ7/LOzd
         3GaeSKn785UAfeQ1GtpR439bbuoBJ0rE3Y7z0COmHEo2Q+hs6RvNbZ5NgijIl/iO/NlL
         oV+1J/Zzo1WyOUeDXKMQeLaUPRgKaglEmTjLLFMWPowm0UZPJ+NMMWalCtujxu4okBkz
         d5IQtc+iCi+7YKQoAABEowcvdr6eLvBAyC26mGN63My2yhyKcky93ZI1LS4IQsKEalHH
         bnFw==
X-Gm-Message-State: AOAM531p+ZmERUCiwnq1IBpCxQ3gmBo2tG/J1lVtYV2CIcQqIHhlM6nn
        tzp6qx33j22el8AHeGmXAw5DjrGHhQU=
X-Google-Smtp-Source: ABdhPJy3z4BIyCl6th/yWjNhruNol3nHZ3vv4OIj0/RtbqIQzOi8WL2KuN+toBXMVuISKjW5OebNoQ==
X-Received: by 2002:a05:6830:1402:: with SMTP id v2mr13502948otp.125.1625977358224;
        Sat, 10 Jul 2021 21:22:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r204sm2284335oih.11.2021.07.10.21.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jul 2021 21:22:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Vincent Pelletier <plr.vincent@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
References: <c06db13bb5076a8ee48e38a74caf3b81e4a2d1f8.1625662290.git.plr.vincent@gmail.com>
 <2c24ef5953401e80d92c907704bffeff1d024de0.1625662290.git.plr.vincent@gmail.com>
 <20210710160813.GA3560663@roeck-us.net> <20210711025502.347af8ff@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 2/3] hwmon: da9063: HWMON driver
Message-ID: <d41a36e4-c36e-b5ab-429a-91506768bf3e@roeck-us.net>
Date:   Sat, 10 Jul 2021 21:22:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210711025502.347af8ff@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/21 7:55 PM, Vincent Pelletier wrote:
> Hello,
> 
> Thanks a lot for this new review (and sorry for the previous
> very-incomplete send, unfortunate keyboard shortcut and sleepy fingers).
> 
> On Sat, 10 Jul 2021 09:08:13 -0700, Guenter Roeck <linux@roeck-us.net> wrote:
>> Unnecessary include.
> [...]
>> I don't immediately see where this include is needed. Is this a
>> leftover ?
> [...]
>> Same here.
> 
> Are there ways to systematically tell which includes are useless
> besides commenting them out all and uncommenting until it compiles ?
> (if that is even a good idea)
> 

I am sure there are, but I don't know any pointers. Either case, commenting
out include files until it fails to compile is not a good idea.
The driver then may compile with one architecture but fail with another.

>>> +enum da9063_adc {
>>> +	DA9063_CHAN_VSYS = DA9063_ADC_MUX_VSYS,
>>> +	DA9063_CHAN_ADCIN1 = DA9063_ADC_MUX_ADCIN1,
>>> +	DA9063_CHAN_ADCIN2 = DA9063_ADC_MUX_ADCIN2,
>>> +	DA9063_CHAN_ADCIN3 = DA9063_ADC_MUX_ADCIN3,
>>> +	DA9063_CHAN_TJUNC = DA9063_ADC_MUX_T_SENSE,
>>> +	DA9063_CHAN_VBBAT = DA9063_ADC_MUX_VBBAT,
>>> +	DA9063_CHAN_LDO_G1 = DA9063_ADC_MUX_LDO_G1,
>>> +	DA9063_CHAN_LDO_G2 = DA9063_ADC_MUX_LDO_G2,
>>> +	DA9063_CHAN_LDO_G3 = DA9063_ADC_MUX_LDO_G3
>>
>> Many of the above defines are not used. Do you plan a follow-up commit
>> to use them ? Otherwise please drop unused defines.
> 
> I'm not sure (would like to, but for this I think I need to add
> devicetree controls, and I am not sure how this should look like), so in
> doubt I will drop them from this patch set.
> 
> There are also #defines in this patchset related to ADCIN channels,
> which are hence unused. Should I also drop these ? In my (short)
> experience, there seem to regularly be unused #defines in headers, so I
> left them be.
> 

Please drop them. They can be added back as needed.

>>> +struct da9063_hwmon {
>>> +	struct da9063 *da9063;
>>> +	struct mutex hwmon_mutex;
>>> +	struct completion adc_ready;
>>> +	signed char tjunc_offset;
>>
>> I am curious: 'char' implies 'signed'. Any reason for using 'signed' ?
> 
> We are again getting into my "erring on the status-quo side" as this
> comes from the original patchset. My reading of this is that using a
> char for holding an integer is somewhat unusual (as opposed to a holding
> character) and the non-essential "signed" would signal that there is
> something maybe a bit unusual going on here.
> 
> But this all becomes moot with your next point:
> 
>> Also, note that on most architectures the resulting code is more complex
>> when using 'char' instead of 'int'. This is seen easily by compiling the
>> driver for arm64: Replacing the above 'signed char' with 'int' reduces
>> code size by 32 bytes.
> 
> This is reaching outside of the parts of C that I am comfortable in:
> what is the correct way to sign-extend an 8-bits value into an int ?
> 
> In regmap_read() fills "int *value" with the read bytes, not
> sign-extended (which looks sane):
> 	ret = regmap_read(da9063->regmap, DA9063_REG_T_OFFSET, &tmp);
> 	dev_warn(&pdev->dev, "da9063_hwmon_probe offset=%d\n", tmp);
> ->
> [Jul11 01:53] da9063-hwmon da9063-hwmon: da9063_hwmon_probe offset=247
> 
> My naïve "(int)((char)tmp)" produces 247, instead of -9.
> "(int)hwmon->tjunc_offset" does sign-extend, but going through an
> intermediate variable looks overcomplex to me (for a tiny definition of
> "overcomplex").
> I see sign_extend*() functions but seeing their bitshift arguments I
> feel these may not be intended for such no-shift-needed use.
> 
Sorry, you lost me there. Those functions use shift operations to move
the sign bit where it belongs, and the shift back retains the sign bit.
What is wrong with that ?

Also:

int main()
{
         unsigned int v1 = 247;
         int v2;
         int v3;

         v2 = (char)v1;
         v3 = (int)((char)v1);

         printf("%d %d %d\n", v1, v2, v3);

         return 0;
}

produces 247 -9 -9, so I don't fully follow what your (int)((char)tmp)
looks like. Besides, the outer typecast is not necessary.
In general,
	v2 = (char)v1;
is good enough since the char -> int conversion is automatic (and sign_extend32()
is indeed overkill for this situation).

Either case, please feel free to use 'char' if you like; I won't insist
on a change to int. However, please drop the "signed".

>>> +static int da9063_adc_manual_read(struct da9063_hwmon *hwmon, int channel)
> [...]
>>> +	ret = wait_for_completion_timeout(&hwmon->adc_ready,
>>> +					  msecs_to_jiffies(100));
>>> +	reinit_completion(&hwmon->adc_ready);
>>
>> This is unusual. Normally I see init_completion() or reinit_completion()
>> ahead of calls to wait functions.
>>
>> If a request timed out and an interrupt happened after the timeout,
>> the next request would return immediately with the previous result,
>> since complete() would be called on the re-initialized completion
>> handler. That doesn't seem to be correct to me.
> 
> To confirm my comprehension: the issue is that if somehow the irq
> handler fires outside a conversion request, it will mark adf_ready as
> completed, so wait_for_completion_timeout() will immediately return.
> The follow-up consequences being that the ADC, having just been asked
> to do a new conversion, will still be busy, leading to a spurious
> ETIMEDOUT.
> Is this correct ?
> 
I don't know what exactly happens. Why don't you try by setting the
timeout to a really small value, one that _does_ result in this
situation ?

> With this in mind, could the time from regmap_update_bits() to
> {,re}init_completion() be longer than the time the IRQ could take to
> trigger ? In which case adc_ready would be marked as completed, then it
> would be cleared, and wait_for_completion_timeout() would reach its
> timeout despite the conversion being already over.
> 
... but what I do know is that I don't understand why you insist having
the reinit_completion() _after_ the  wait call. The above doesn't explain
that. I see it as potentially racy, so if you want to keep the code as-is
I'll want to see a comment in the code explaining why it has to be done
this way, and how it is not racy.

Also: a return value of 0 from wait_for_completion_timeout()
already indicates a timeout. The subsequent regmap_read() to check
if the conversion is complete should not be necessary. If it does,
it really indicates a non-timeout problem. Are there situations
(other than the race condition I am concerned about) where
an interrupt can happen but DA9063_ADC_MAN is still set ?

If so, I think this needs a comment in the code, especially since there
is an extra i2c read which, after all, is costly. Also, this should
probably generate a different error code (-EIO, maybe), and
-ETIMEDOUT should be the result of wait_for_completion_timeout()
returning 0.

>>> +static int da9063_hwmon_probe(struct platform_device *pdev)
> [...]
>>> +	ret = regmap_read(da9063->regmap, DA9063_REG_T_OFFSET, &tmp);
>>> +	if (ret < 0) {
>>> +		tmp = 0;
>>> +		dev_warn(&pdev->dev,
>>> +			 "Temperature trimming value cannot be read (defaulting to 0)\n");
>>> +	}
>>> +	hwmon->tjunc_offset = (signed char) tmp;
>>
>> Nit: Unnecessary space after typecast (checkpatch --strict would tell you).
>>
>> Also, I am curious: The temperature offset is a standard hwmon attribute.
>> Is it an oversight to not report it, or is it on purpose ?
> 
> It was an oversight, but now that I know about it I am not sure this
> should be used: the offset is in chip-internal ADC units, so userland
> cannot make use of it for temperature measurement unless the raw ADC
> output is also exposed.

One would not report the raw value, but convert it to m°C.

> Is this attribute used to give an insight as to how the chip was
> calibrated in-factory or otherwise good practice to expose ?
> 

It can be exposed as read-only value if it is a read-only
register/value. Ultimately it is your call if it is indeed read-only.
It still provides some value in that case, but not much.

Thanks,
Guenter
