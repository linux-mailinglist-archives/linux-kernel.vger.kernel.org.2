Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD24458067
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 22:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbhKTVI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 16:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbhKTVI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 16:08:57 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB531C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 13:05:53 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id b11so10777231pld.12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 13:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=accesio-com.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vDEG37suVi75RS0zoThuG5W/DdcswDDvnaTC9lfOtYo=;
        b=1MAKU4JtvWic+ABL5KMPohFpM3lTZx9/afM680norQFa56JjW2NB2a7CiqMpKjCFjV
         WrKUnQi9j+JavN6iTNyh7q/OTzOcMMJuoxpEHTEIYuRvc7/k2AdaHGIzYbHZAL8trkiB
         WRwkTrsUQTmdL1pWfqmGvKBcX3BzWI0KicXlhk1yB3bkLD+Cpl1WVEUSeVGwk2dtoikx
         fjTDIRqspS809WajHJQQHcLeRyYF2FJCYqSl8oA+r6Vs4RR3WPShU8IFUP7ANjyMmuUx
         xh26dQytT9Qe//B2EkvmxyPyQypMWl7DpG+NgEKfCZLrQpLYNnn1RB/bvw2IP8qYWpIZ
         Ho4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vDEG37suVi75RS0zoThuG5W/DdcswDDvnaTC9lfOtYo=;
        b=VWfE6uYXU8AOFi81bU3lHP6uIp+/SzeiDlo9WZVbrUj0YcLfYswAEFdvjPJ13BKHxW
         q+P4LsuHI+uH8Boqs3Tj6qFMWvS1Fy26xywqVt5scUl/HrW0aZv8IRmY+2FIiVHX9aUo
         xXUtERm+4MUylilxUAoBflcXo+LksXsDHoo5N9rdKc395jKv+CSStEUo361xS4g4yi2B
         SXJujMmVpAumxIPX+rqLdQcqj4s/5kcM36knTv7J6NR9+vnxd9lNC/J45hqLRjHfxaiN
         JmHOfNpsjAMKz1TgBnqwtmHpTb2FJE3ef5r9xwslJiTLgMV3ItHrehLOmWkB6biTnJs2
         +Nlg==
X-Gm-Message-State: AOAM530FGki16gVgOOe1dHreGO5oqd7iM9Ro0xOI9iOvOkEpJVvZMz93
        WARokx1w1ok1RxgP1UAbz+ws
X-Google-Smtp-Source: ABdhPJyGqd/pof6wxDVgAjd+gF4aPblsWhfrtDZcVZyDgAZdAjWsIU9A1qWeEDO4OzQeEkiPOntd6A==
X-Received: by 2002:a17:903:248f:b0:143:8e81:4d7c with SMTP id p15-20020a170903248f00b001438e814d7cmr89641295plw.1.1637442353113;
        Sat, 20 Nov 2021 13:05:53 -0800 (PST)
Received: from [172.16.8.241] ([98.149.220.160])
        by smtp.gmail.com with ESMTPSA id k22sm3529496pfi.149.2021.11.20.13.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Nov 2021 13:05:52 -0800 (PST)
Subject: Re: [PATCH v1 0/2] serial: 8250_pci: Split Pericom driver
From:   Jay Dolan <jay.dolan@accesio.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
References: <20211117145750.43911-1-andriy.shevchenko@linux.intel.com>
 <b99aabbe-add9-9c1e-ed4b-8850c69233de@accesio.com>
 <YZdfAdOcH2Bn1K+W@smile.fi.intel.com>
 <633bbad1-7b13-7299-a570-2bf1a87c47a5@accesio.com>
Message-ID: <7e83c01f-1aa4-56ef-e28f-9e7421864183@accesio.com>
Date:   Sat, 20 Nov 2021 13:05:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <633bbad1-7b13-7299-a570-2bf1a87c47a5@accesio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/19/21 6:33 AM, Jay Dolan wrote:
> 
> 
> On 11/19/21 12:23 AM, Andy Shevchenko wrote:
>> On Thu, Nov 18, 2021 at 10:32:51PM -0800, Jay Dolan wrote:
>>> On 11/17/21 6:57 AM, Andy Shevchenko wrote:
>>>> Split Pericom driver to a separate module.
>>>> While at it, re-enable high baud rates.
>>>>
>>>> Jay, can you, please, test this on as many hardware as you have?
>>>>
>>>> The series depends on the fix-series: 
>>>> https://lore.kernel.org/linux-serial/20211117145502.43645-1-andriy.shevchenko@linux.intel.com/T/#u 
>>>>
>>
>>> I have my current state here: 
>>> https://github.com/accesio/linux/blob/split-pericom-driver/drivers/tty/serial/8250/8250_pericom.c 
>>>
>>>
>>> * Change port type to UPIO_PORT
>>> * Add in pericom_do_startup() because the UPF_MAGIC_MULTIPLIER doesn't
>>> stick.
>>
>> Thanks, I have updated my local tree with these changes.
>>
>>> When I'm testing baud rates greater than baud_base I'm seeing strange 
>>> things
>>> on the scope.
>>
>> Can you confirm that there are no issues with the first (fixes) series?
> Yes. The fixes series has no issues, and was tested up to baud_base for 
> both 14 and 24 MHz crystals.
>> I have slightly changed your set_divisor() refactoring, it may be that 
>> issue
>> is there.
>>
>>> Maybe I'm just tired, and it's human error. I should be able
>>> to get back to it and get it done on Saturday.
>>
>> Thank you.
>>

Latest code is still here 
https://github.com/accesio/linux/blob/split-pericom-driver/drivers/tty/serial/8250/8250_pericom.c

Changes from last update:
* Avoid divide by zero when initializing delta

I retested and verified on the scope that speeds are now being set 
correctly.

I have also confirmed that all of the ACCES four port cards in the 
driver do have the offset fourth port. The item I raised about PCI was a 
misunderstanding that was all on my end.

Are there any other action items I should be handling?

Thank you for your work so far.
