Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D28D38E840
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 16:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbhEXOEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 10:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbhEXOEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 10:04:44 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4D7C061574;
        Mon, 24 May 2021 07:03:16 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso3418337otl.13;
        Mon, 24 May 2021 07:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vy3r3yrYoUL2EOsemlGK+6+OLXYvaDk1ocevfdIT9BM=;
        b=uE+aMqkVrgorgcnGCnWyOLaprYqOg8NXJNERuxtsSO5CJhF3A1dYtbVar5Xy+W4jvP
         oGQGvoK+pMhgDEo8YB82ci209SimUZqjSZ47KwfDfPUEb6bnU0PJolwEWbN69CaGqdXk
         Lu93Xxeibe8OCd8x7Mk1y34khU8yG3EoA9WSUe+/ugYIs6adKZuLY7VwQ7BuMTeYNfwP
         gF2URBURsYTOpZjs2x28OnG0ALyVAWY8asnFmOacyqbPaltgKYvcFAaHfMalJUZBn8+C
         AMBZ4AfTZ0pv/I9G8mZvJc5HJbfke5laJ3Mq/8uKCqCRw2WOzvaOSqbEDzXdprsfx8u2
         n4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vy3r3yrYoUL2EOsemlGK+6+OLXYvaDk1ocevfdIT9BM=;
        b=OHNIihZpj3ylozGnnV8bSeYCg8PHVSnyZ9WlHvKsxnImYgix7GcAdJT+wuM4zUj6rH
         oUraoIdbKXTzleRbJolDcQDxEToZyfnEHFAfJHZZ7x+slZTA08obmhIcn9O4U2o56Hm1
         LU50tae0oBWVK3/6YqY2Hl/DBLSCK/OSEXSdAVYrw6CaJvTxAYdKpteK3B31YhHuz9nD
         rwkl9+a/LSeUuQHEIShKY/SlRKYnpydX8o7Ew/in9P8sUr00itVQZ/8SwrH4y8I4jHoF
         AHMOA8Ii/7WA5bLTNShPOOcHhv4li4XbV+NSvxLu0m5xy9ATRFPIi3EY9QBhXV8XuTMz
         QhLQ==
X-Gm-Message-State: AOAM532yQ1W1cZf1kRcJhkFjL3XjO6cSSgFsd2emdJ687S1e35eSyfo5
        saDF3umR6KHTMSXkgEf8CWKtA5wqtY0=
X-Google-Smtp-Source: ABdhPJwOprLimf8g6lvc6337dfL3y8Tc/sZ/KQ0ZLzS0z68k25k10bu+66xxLrfIifhjfWEdj/S1UA==
X-Received: by 2002:a05:6830:308a:: with SMTP id f10mr19003679ots.147.1621864995870;
        Mon, 24 May 2021 07:03:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i133sm2670412oia.2.2021.05.24.07.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 07:03:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     =?UTF-8?B?5Y2i5pel5paH?= <luriwen@kylinos.cn>, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Chen <chenxin@kylinos.cn>
References: <v3besyi6n3-v3coqrx8gw@nsmail6.0>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogUmU6IFtQQVRDSCB2MV0gaHdtb246IChzY3BpLWh3?=
 =?UTF-8?Q?mon=29_shows_the_negative_temperature_properly?=
Message-ID: <6639297e-5e71-81c9-c9a5-bd4b00810d2e@roeck-us.net>
Date:   Mon, 24 May 2021 07:03:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <v3besyi6n3-v3coqrx8gw@nsmail6.0>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/21 6:48 PM, 卢日文 wrote:
>  > What did you test ? Did you really manage to run the system
>  > in such an environment ?
> 
>  > 'value' is declared as u64, not as s64.
>  > I can not evaluate what the firmware actually reports. The API
>  > reports an u64. Do you have any evidence for your claim that
>  > it returns a signed value under any circumstances ?
> 
> 
> Yes, the comsumer of my company test their machines in harsh environment including the very low temperature.
> 
I tried to look this up, but the ARM developer documentation is vague when
it comes to describing the content of sensor readings. Is it documented
somewhere that the temperature is actually returned as signed value ?
If so, can you point me to it ?

I'll need to have some confirmation that this is legitimate.

> The first picture below shows that the temp returned as a unsigned value when it is a negtive value with sensors tool.
> 
> And the second picture shows the real value after applyed my changes in scpi hwmon.
> 
> 1234.jpg
> 
> 2345.jpg
> 
Pictures are not attached.

> 
>  > On top of that, your change affects not only temperature values,
>  > but all attributes. It is highly unlikely that the firmware would
>  > report negative power or energy values. It is, however, possible
>  > that energy values have the upper bit of an u64 set after a
>  > long runtime. Your change would result in a negative energy value
>  > if that is ever the case.
> 
> 
> Sorry for not considered this situation before.
> 
> But I think it can be judged by sensor->info.class. if it is TEMPERATURE situation, return the value as a signed value,  otherwise it returned as a unsigned value.
> 
Correct.

Thanks,
Guenter
