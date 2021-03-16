Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C0633DE6D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 21:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240784AbhCPUHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 16:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240775AbhCPUGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 16:06:52 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39986C06174A;
        Tue, 16 Mar 2021 13:06:52 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id l11so6154256otq.7;
        Tue, 16 Mar 2021 13:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JuEjsE/RQ7aK7Knake7e4xVNMHMxV/R6u7Uv4C4ReeI=;
        b=f2TCyvl1YeRyq3H3nzZL9r4I+omOazRcZfgjwKhHGV5Tqjf7VaFsWv5WBh/O1D4pSr
         sXTd183iEjqtmSV1+K1AdS05ym5eRFPXAYqTUH64jIQGMfD41o2VXvVX6ZPlK3AJoseY
         J4dJ7wwYTAZvAS1tiviyReWoONWblrLHlJKvYb+DynEgIjAH8qd+zE3PiY6SB9E0XtoP
         2bzAewawrwfRiDVcWZwED70gZ9Us634uPlXiUCpsT5A2zhMcwxNsq2MlMCeAM64LO/1Y
         I6HBgVcBsKl8fjc7JgjzZKa8hFAM2rKvJFLoXYhSZJP/i43uHjLDDuj3VxzHPdo/6t/3
         a1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JuEjsE/RQ7aK7Knake7e4xVNMHMxV/R6u7Uv4C4ReeI=;
        b=ec0bZzYDLUKpvkXRSuaiR35P2OBjB6TzM43VUcuhWBDKEpyPF4SFKSaZlBUejfLkYj
         4ljdu9s3qvSMrRFza1Oqt8MGHpkp2ZSEFzt/LRChaJz34dbEvhrlcMpJOIpsJLrUceLC
         olfF/xyO1uICHDTQH55C1xkfSA+TmgGV8lkySzEJeLf8/hI2C7h8J3bxwnrGf/g3JuZm
         DTXklpdnKBpVnE0eLknAf02jKOSpTuzJWLIPBnhs2UVQWgZB/hWpmy7Ou85Sz50uFcCR
         jzn+GDrj3WM4u7WIzJW6lUSm2LT1kQScqYkgRHZLbOzck/t64M0jVwCZ/zkx/JAxy28d
         iUHw==
X-Gm-Message-State: AOAM5317IU/Tm5yQcTqUpTesr1Hmno8AzhLVtuZYmtxt513jDrAu6pfV
        w7dhye145lOPb/OXPFBABPIiFRIeXto=
X-Google-Smtp-Source: ABdhPJwBUXcjX7HUWZUQywrVCsFo5UaV7rajtmCIo9/M40UOU6De2ahKDaQh/QyCnEsJ0XfeVjiYDQ==
X-Received: by 2002:a9d:6a91:: with SMTP id l17mr371897otq.297.1615925211269;
        Tue, 16 Mar 2021 13:06:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g61sm8152898otb.65.2021.03.16.13.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 13:06:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2] hwmon: corsair-psu: add support for critical values
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
References: <YE93HebFD0acwZIX@monster.powergraphx.local>
 <20214c50-5c58-0d3e-5de5-115ed022750e@roeck-us.net>
 <20210315175509.55672ee7@monster.powergraphx.local>
 <f7f2c932-8eac-4f5e-ab81-c59addec4aed@roeck-us.net>
 <20210316152150.5a712927@monster.powergraphx.local>
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
Message-ID: <3141c950-7764-4285-0e60-eef093ba3513@roeck-us.net>
Date:   Tue, 16 Mar 2021 13:06:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210316152150.5a712927@monster.powergraphx.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/21 7:21 AM, Wilken Gottwalt wrote:
> On Mon, 15 Mar 2021 11:00:53 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> On 3/15/21 9:55 AM, Wilken Gottwalt wrote:
>>> On Mon, 15 Mar 2021 08:53:25 -0700
>>> Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>>> On 3/15/21 8:02 AM, Wilken Gottwalt wrote:
>>>>> Adds support for reading the critical values of the temperature sensors
>>>>> and the rail sensors (voltage and current) once and caches them. Updates
>>>>> the naming of the constants following a more clear scheme. Also updates
>>>>> the documentation and fixes a typo.
>>>>>
>>>>> The new sensors output of a Corsair HX850i will look like this:
>>>>> corsairpsu-hid-3-1
>>>>> Adapter: HID adapter
>>>>> v_in:        230.00 V
>>>>> v_out +12v:   12.14 V  (crit min =  +8.41 V, crit max = +15.59 V)
>>>>> v_out +5v:     5.03 V  (crit min =  +3.50 V, crit max =  +6.50 V)
>>>>> v_out +3.3v:   3.30 V  (crit min =  +2.31 V, crit max =  +4.30 V)
>>>>> psu fan:        0 RPM
>>>>> vrm temp:     +46.2°C  (crit = +70.0°C)
>>>>> case temp:    +39.8°C  (crit = +70.0°C)
>>>>> power total: 152.00 W
>>>>> power +12v:  108.00 W
>>>>> power +5v:    41.00 W
>>>>> power +3.3v:   5.00 W
>>>>> curr in:          N/A
>>>>
>>>> What does that mean ? If it isn't supported by the power supply,
>>>> should we drop that entirely ? Maybe drop it via the is_visible
>>>> function if it is available for some variants, but always displaying
>>>> N/A doesn't add value.
>>>>
>>>> This is a bit odd, though, since I would assume it translates
>>>> to the PSU_CMD_IN_AMPS command. Any chance to track down what is
>>>> happening here ?
>>>
>>> I have one of the earliest PSUs of this series, it is just not supported on
>>> mine. I'm not sure if it would be worth the trouble to catch that and turn
>>> it off dynamically.
>>>
>>
>> I think so, because otherwise we'll get complaints about it (people
>> are really picky abut such things lately). Better not display it at all
>> if it is not supported on a given PSU version. This should be relatively
>> easy to catch in the is_visible function.
> 
> So do you have any idea how to do it? The PSU does not tell you what is
> supported or not, you only find out by running the commands. I mean the
> only thing I think of is like I did it for the critical values, but only
> keeping the *_support bits. But if I do it that way, I actually should do
> it for all the commands. This is the point which I ment with "worth the
> trouble."
>

It is not really necessary to do it for all commands; only for those known
to not be supported on all power supplies.

>> Nice PS, anyway. Too bad it is so expensive (and large). Do you know
>> if the HX750i uses the same protocol ?
> 
> All HX_num_i and RM_num_i PSUs support the same protocol. There are only
> small differences in supported commands based on release version. What do
> you mean by "large"? The size of the case? All HXi and RMi should have
> the same size (standard ATX). Maybe you looked at one of the AXi series,

They don't fit into my small mini-ATX chassis, and the "i" series all
seem to be full-size ATX.

[ ... ]
>>
>> Making the code less readable to meet a line limit isn't really that desirable.
>> If you want to stick with one line, you could drop the "hwmon_" from function prefixes
>> instead. Those don't really add any value.
> 
> I know I know, it's a personal taste. I really dislike splitting functions
> headers about serveral lines, especially if indenting is tab based.
> 
Fortunately you can get there by dropping 'hwmon_' from the function names.

Thanks,
Guenter
