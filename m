Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD6C441CFA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 15:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbhKAPAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 11:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhKAPAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 11:00:08 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A28C061714;
        Mon,  1 Nov 2021 07:57:35 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id n13-20020a9d710d000000b005558709b70fso19193628otj.10;
        Mon, 01 Nov 2021 07:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZoWUChLrSkcmoiG2opWpA+k/rTmSsnlHqI6Ys9fdYFQ=;
        b=YD8Fs32WPQSObOB1EMMjztceewOji595D/by2Rf3Hy9vWfEchilncMgTk30b++xVa2
         eFpkfZL/0hN8UO8u8Xo92Y5ul4hjbYjuIj0jRnYW//6YzcVD5bC79M823HNr/scbDnAk
         nVe2t4HdzurIDlC2625xiEap0NPGHIyVXn8ggqxNUZdYQGFGijHj/gMQn5pKiEYuX6Iz
         ZwMsgHQ/5HUOgecViuxZeUutEKmYzUdy0BuFPFL8CaST3QFscdXjeJbxeVnvwJgJz2EI
         HcmsH6otTWevP3/qG+q6WW+03Km7KCafSpacdolp8SX++9Tlda6f5aGcTOUK6OYKw4V7
         xPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZoWUChLrSkcmoiG2opWpA+k/rTmSsnlHqI6Ys9fdYFQ=;
        b=SyyYOdLrlURUM4cd0uIGJnUoZubYBS91yjdEDm4CY+5YSuRgpXUGKOLcMRD2tNhGjW
         rHZEre7N+dCPQ22g4rI9DBpKCIwJXYhhCvz9zd91fR9NOLTuOu7BRH85iWwESEHvHhLT
         +ZsgP0GW79UfMaGnVQFfaz6hT52gymJSYH4Whm26Xv+ZYKfEhYZPbxD8P2HxUWmP2Kgj
         zCpmRoHuU05nOo5cOhmTrG+BJOmjPrEyxhAmcBfL6xctm6I4rLsklWLoZDHeT1h46M0i
         9xvNCjlO8cW6BBrEYUzHl297t5Fj61TK6KgpC+/qSJ1lZWHL0waEVWCw6ILdIn8RNg4k
         WM4g==
X-Gm-Message-State: AOAM5310FD6wlrJcz0Qm/8XBZv7NnNTKEGDlVa8P8zAhPvIt91G7urST
        BpzEYW0KNCFeD4X2GDAHvFvIJe3RfnI=
X-Google-Smtp-Source: ABdhPJyaB53F07+sWCX8irAOTSGg96G6xPWDKZVp1NjxQGUw+Rept/0xa1fKk7G6I0rbtmxfbtnaVA==
X-Received: by 2002:a05:6830:4033:: with SMTP id i19mr20894327ots.320.1635778654812;
        Mon, 01 Nov 2021 07:57:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q11sm1117459ota.54.2021.11.01.07.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 07:57:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v3 3/3] hwmon: Driver for Texas Instruments INA238
To:     Nathan Rossi <nathan@nathanrossi.com>
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nathan Rossi <nathan.rossi@digi.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <20211028081030.719265-0-nathan@nathanrossi.com>
 <20211028081030.719265-3-nathan@nathanrossi.com>
 <7b6764bf-4978-60ec-b1e6-8d59077c3023@roeck-us.net>
 <CA+aJhH1aGJXwYSCU8RC275G5=qGLyZRK94g9ic24wxKuRGCwEA@mail.gmail.com>
 <43c17bba-d4bd-1f9d-5034-1f5a9279d751@roeck-us.net>
 <CA+aJhH0EBUjQhjQhxj-kfJzmpqGN6ZMNn_M-pAae_V9yPQhs3A@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <5569b2b8-ac67-757b-f7cb-302c9f663e80@roeck-us.net>
Date:   Mon, 1 Nov 2021 07:57:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CA+aJhH0EBUjQhjQhxj-kfJzmpqGN6ZMNn_M-pAae_V9yPQhs3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/21 10:55 PM, Nathan Rossi wrote:
> On Mon, 1 Nov 2021 at 13:48, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 10/31/21 7:20 PM, Nathan Rossi wrote:
>> [ ... ]
>>>>> +
>>>>> +     if (attr != hwmon_in_max && attr != hwmon_in_min)
>>>>> +             return -EOPNOTSUPP;
>>>>> +
>>>>> +     /* convert decimal to register value */
>>>>> +     switch (channel) {
>>>>> +     case 0:
>>>>> +             /* signed value, clamp to max range +/-163 mV */
>>>>> +             regval = clamp_val(val, -163, 163);
>>>>> +             regval = (regval * 1000L * (4 - (int)data->gain + 1)) /
>>>>
>>>> nit: The typecast "(int)" is not needed here.
>>>
>>> Due to the unsigned type of gain, it causes promotion of regval (and
>>> the rest of the numerator) to unsigned long which causes issues with
>>> negative numbers on the divide. It makes more sense for gain to be an
>>> int to begin with, I will change it to int to avoid the need for type
>>> casting.
>>>
>>
>> Are you sure ? I initially thought that as well and wrote a little test
>> program with that expression, but it didn't do the promotion to unsigned.
>>
> 
> It definitely calculates incorrectly at run time (on an arm 32-bit
> platform), looking at the gcc output from -fdump-tree-original reveals
> some more insight. Which is that the promotion to long overrides the
> unsigned (from the 1000L) on long=64 but not on long=32.
> 
> Where regval is int, and gain is unsigned int (u32).
> 
> regval = (regval * 1000L * (4 - gain + 1)) / 5;
> -> armv7-a (invalid)
> regval = (int) ((((long unsigned int) regval * (long unsigned int) (5
> - gain)) * 1000) / 5);
> -> x86-64 (valid result)
> regval = (int) ((unsigned int) (gain * 4294967096 + 1000) * (unsigned
> int) regval);
> 
> note: 4294967096 is -800, 1000 * (4 - gain + 1) => (-800 * gain) + 1000
> 
> Slight variation without the 1000 being long.
> 
> regval = (regval * 1000 * (4 - gain + 1)) / 5;
> -> armv7-a (invalid)
> regval = (int) ((((unsigned int) regval * (5 - gain)) * 1000) / 5);
> -> x86-64 (invalid)
> regval = (int) ((((unsigned int) regval * (5 - gain)) * 1000) / 5);
> 
> regval = (regval * 1000LL * (4 - gain + 1)) / 5;
> -> armv7-a (valid)
> regval = (int) ((unsigned int) (gain * 4294967096 + 1000) * (unsigned
> int) regval);
> -> x86-64 (valid)
> regval = (int) ((unsigned int) (gain * 4294967096 + 1000) * (unsigned
> int) regval);
> 
> I think it still makes sense to change gain to be int, and avoid the
> unsigned type issues.
> 

Thanks for the details. I agree, changing gain to int makes sense.

Thanks,
Guenter
