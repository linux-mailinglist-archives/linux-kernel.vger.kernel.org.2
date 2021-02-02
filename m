Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779B530C3E4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 16:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbhBBPeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 10:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbhBBPbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 10:31:35 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A177C061573;
        Tue,  2 Feb 2021 07:30:55 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id k25so23123264oik.13;
        Tue, 02 Feb 2021 07:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XmqFBnVw8Z5BVzMl1wyazcl1Jvtbw6bmd9pSmxllmxk=;
        b=PTyJrCLgsf6l031jBUtwOFoMueZx3tApAU5IFIVfz71rujedBC7H6chSt91vHdMrok
         o4wu8m+k7qA8fvbwS8dvAl8OO9MBZNNfSqdLS9mmUsligkO2Ax7XmqNEQiFmPk/3EnYN
         2EVhZ2M7Pl+6CCO6kd43DHEMtYY/Zc5BxM5DVLhkrGWgaIwGm/P33X5xxAnY1AprrVmc
         6toIrWVntI4bciuWnjcnHd8c6dkgwteHp0huLJEKnii0TwM9X1Xi5UouP4Gl+NMR62kT
         KBe3X41M+7y81r8VwigRb4t1KiXp+SFimhnWdG6/VA6xqwEW6RlldTMVl0DVtYRA4afZ
         sOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XmqFBnVw8Z5BVzMl1wyazcl1Jvtbw6bmd9pSmxllmxk=;
        b=C6yPgbIeL/8/rewV6CcEN+Jl7AoRMUfmLSgPbXxl84m9Wi55NzhljkUGkSvo/hb6TK
         +Kz7wdhUTTxiSm1rsE/sIM6pkzyKU7dsjexemn67UscPqU7TQJSiV6aN4sAcJrFIqpZq
         UteADc4hSwDI3nI0HDKWoql9iuP7eOBz6HxXRAyUxPMmT6Aa4nUJSBOqsrKpNQyinnWw
         KWqDzvq2t/MrhHos+uXm3Az+5IWXq9GAnMXYilm/b33hE4rp7rpCqStgeYWyzTA87Bla
         a8DsDzgzTR15Ty9nUHcUZ3IQksSEoEJmns2ZDbae+3lqIJkqDIX9UfisDaokDwinSNvR
         THaQ==
X-Gm-Message-State: AOAM532omfXjkBNMlfmeC0+GM3exi8/bWow9/2KGfLQU3ScB335JY/eL
        x87w2OOIJWtR7bGqWMja7nw=
X-Google-Smtp-Source: ABdhPJze9AktgB+y276Saz+osvm9x7sgkrQcpYGrpcA8BADDq23G5BZq8xgC6Jp3ezgzCbDgQzq+Jg==
X-Received: by 2002:aca:5e46:: with SMTP id s67mr3127269oib.8.1612279850106;
        Tue, 02 Feb 2021 07:30:50 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s49sm4279158otb.39.2021.02.02.07.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 07:30:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 1/1] Add ST STPDDC60 pmbus driver
To:     Erik Rosen <erik.rosen@metormote.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>
References: <20210127084140.35626-1-erik.rosen@metormote.com>
 <20210127084140.35626-2-erik.rosen@metormote.com>
 <20210127173255.GA144627@roeck-us.net>
 <CA+ui0HmbcQe_CD-0d+AMgx_jSuY=AG9Qx4Ab2g71kPVFrMDe_w@mail.gmail.com>
 <ee2a89f6-0f55-9328-b53d-b5893eb625db@roeck-us.net>
 <CA+ui0H=UC495kfZuZeg-ryPh_aSa0wFqf=hnn7oS782qFgh60A@mail.gmail.com>
 <778339a4-501c-d73f-4378-9b0c2a6a03c0@roeck-us.net>
 <CA+ui0H=XW-WSThuYiY0r1-1EhGui1on0UvNYMUD+XsvA+K6ePA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <1dfcdf8d-2388-301d-820f-70a45392efd7@roeck-us.net>
Date:   Tue, 2 Feb 2021 07:30:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+ui0H=XW-WSThuYiY0r1-1EhGui1on0UvNYMUD+XsvA+K6ePA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/21 6:34 AM, Erik Rosen wrote:
> On Mon, Feb 1, 2021 at 10:38 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 2/1/21 8:48 AM, Erik Rosen wrote:
>>> Hi Guenter
>>>
>>>
>>> On Fri, Jan 29, 2021 at 4:50 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> Hi Erik,
>>>>
>>>> On 1/29/21 5:07 AM, Erik Rosen wrote:
>>>> [ ... ]
>>>>>>
>>>>>>> +             break;
>>>>>>> +     case PMBUS_VOUT_OV_FAULT_LIMIT:
>>>>>>> +     case PMBUS_VOUT_UV_FAULT_LIMIT:
>>>>>>> +             ret = pmbus_read_word_data(client, page, phase, reg);
>>>>>>> +             if (ret < 0)
>>>>>>> +                     return ret;
>>>>>>> +             ret &= 0x07ff;
>>>>>>
>>>>>> This needs explanation. The BMR481 datasheet does not suggest that only
>>>>>> 11 bits are valid.
>>>>>
>>>>> Ok, I will add a clarification. These registers use LINEAR11 whereas
>>>>> LINEAR16 is expected for vout-related registers.
>>>>>
>>>> Is that the correct fix, then ? LINEAR11 means that the exponent is flexible,
>>>> while it is fixed for LINEAR16. Just assuming that the exponents always match
>>>> seems risky. Also, bit 11 in LINEAR11 is the sign bit, meaning negative limits
>>>> (which seem at least theoretically be possible) would be reported as large
>>>> positive values.
>>>
>>> The chip actually uses fixed exponents for representing all linear values and
>>> the specification explicitly states the values of the LSB for all registers.
>>> It also states that the limits can be handled as linear format when
>>> writing  _if_
>>> the exponent is the fixed value used for that limit. This means I'll have to
>>> convert all limit writes to use the expected exponent.
>>
>> I understand the datasheet a bit differently. You are correct, the exponent for
>> VOUT limits is always the same (LSB=0.00390625V, exponent -8), as it should be.
>> But it also seems to me that the data format is LINEAR16, not LINEAR11.
>> The datasheet says that the vout limit values are in bit 0..15.
>>
>> For other sensors, the datasheet is a bit ambiguous. I can read it as always
>> using a fixed exponent when reading, or that it expects a fixed exponent when
>> writing. It might make sense to check this with an actual chip instead of
>> guessing. In this context, it is a bit odd that the datasheet keeps talking
>> about a "System Register IOUT_EXP" without actually specifying it.
>>
>> In this context, you might want to watch out for register MFR_SVID_SLOW_SR_SELECTOR.
>> Its value seems to impact the exponents used for IOUT and POUT.
>>
>> Also, I am not sure about the scale of other registers. It almost seems as if
>> limit registers are LINEAR11, but actual READ_xxx registers are LINEAR16.
>> For example, READ_IOUT is supposed to be bit 15:0 with the LSB determined
>> by IOUT_EXP, but IOUT_OC_WARN_LIMIT is in bit 9:0. This would be a problem
>> if READ_IOUT does not include the exponent, since it is interpreted as
>> LINEAR11 and expects the exponent in bit 11..15. With an expected exponent
>> of -1, the reported value would always be wrong. The same might apply
>> to pretty much all READ_xxx registers (what a mess).
> 
> I have tested all commands on a real chip and the behavior is as follows:
> 
> All linear (both limits and READ_XXX) registers return the exponent i.e. use
> the LINEAR11 format (even the vout related ones that really should use LINEAR16
> according to the pmbus standard), so reading registers is quite straightforward.
> 
> I got hold of an excel-document from ST that describes the pmbus
> commands and system registers of the chip in greater detail. Unfortunately
> it has got 'STMicroelectronics Confidential' stamped all over it so I
> can't really
> share it publicly.
> 
> Iout and pout data and limits are described as:
> [15:11]: Encoded/Decoded with N programmed by HC_SUPPORT bit or IOUT_EXP
> [10]: 0b0
> [9:0]: Y mantissa
> 
> Other data and limits (including vout) are described as:
> [15:11]: Encoded/Decoded with N=X, LSB=XX
> [10]: Don't care (returns 0 in read access)
> [9:0]: Y; max XXX
> 
> where X... are fixed values. The sign bit is always zero.
> 
> You are correct in that it is possible to change the fixed exponents used for
> iout and pout by manipulating the system registers accessible via
>  extended commands.
> 
> However, in a footnote on the bottom of the page it says:
> (***) Number format - When Linear, data need to be formatted with N specified.
> Data sent with N different from what reported, will be decoded as if N
> is the one
> reported.
> 

Some chip designers are really quite inventive.

> I can only interpret this as that the chip expects data written to a
> linear register
> to be encoded with the same exponent as it uses when the same register is read.
> 
> So the simplest way of ensuring that the correct exponent is used when
> writing to
> the chip seems to be to first read the value from the chip, extract the exponent
> and then adjust the value to use this exponent before writing it.
> 

Guess so, and the value written needs to be clamped to [0, 0x3ff].

Thanks,
Guenter
