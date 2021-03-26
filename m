Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3522A34A710
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 13:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhCZMWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 08:22:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47683 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230046AbhCZMVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 08:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616761298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fMyV3C/bwONchMfMn2MDgpfGyQf093AX0oer1CIbxNk=;
        b=KChrrIZWsEe/kK+9gtLB/Woa8q3FoSp+olAHdtL/hmzlG2MYqOjm8Ic1UWe3uV+FFpQZoK
        uHhk6kh4LU7e+sDkJ4SRyGolDEZZTQ2lCq0E4pRVSCqYuxD1jujyxhu/0qYhACvnd+GVXC
        v5CBKq9cwx3qzkfUvPcg0cVsSaS9ewI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-tj8f_3fkNC6L5tBO71ZkJw-1; Fri, 26 Mar 2021 08:21:36 -0400
X-MC-Unique: tj8f_3fkNC6L5tBO71ZkJw-1
Received: by mail-ej1-f71.google.com with SMTP id mj6so4015401ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 05:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fMyV3C/bwONchMfMn2MDgpfGyQf093AX0oer1CIbxNk=;
        b=MhIUdy6v2mD+vukcLazh6o7Tj4p/fNvkItt02b021WemxMn+gDMD4oqapILSANOhAW
         pReVHuR81B1uJYKRxRBqLIae4xf4f4OUpVQCAYceNHf+7WLnWEfNksGDJoIbOYMFHtN1
         iaCpO37KW5l6QB1+8k7Gxz8xoNUve71CS95TH8VH5Zr9Gg/TqWSqxVOExNuyGrMPIJBy
         RUA7ulxNFg2wx+H60Xk+yzCgIzuelHaseHKqR6smphaf07Yf5CAuLwnmP0lJXrn2Dc6X
         eDH55+0yjLxxZlLWx/pFzPpzTumfXt/UAt/pDOKcVzVesxChEbn574FckhJrdFO+mge+
         +nEw==
X-Gm-Message-State: AOAM531Uz7V6l8NahotwcmZG6n+ZGgc8m3Snx7JwopCKtweD2E4PpPcv
        IB6z4FqwtY3uQOxGUY8q/QmGvPx0kFm8YvqNVmJ2fkpdX7AClqJLSBaxIFnJU3J6Sv3yXg+qdhh
        mFGF4Px1THIAF4djXJMKvHoCs
X-Received: by 2002:a17:906:3d62:: with SMTP id r2mr14778349ejf.488.1616761295713;
        Fri, 26 Mar 2021 05:21:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzI4OtUFv+5vU1twiQQXe7KhjbLwVohnPqGQXuYWCX7NlPZVkM/b44V2qUiPJDsQQuRSfVgKg==
X-Received: by 2002:a17:906:3d62:: with SMTP id r2mr14778320ejf.488.1616761295501;
        Fri, 26 Mar 2021 05:21:35 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id u16sm4254099edq.4.2021.03.26.05.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 05:21:35 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] platform/x86: simatic-ipc: add main driver for
 Siemens devices
To:     Henning Schild <henning.schild@siemens.com>
Cc:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-watchdog@vger.kernel.org,
        Srikanth Krishnakar <skrishnakar@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Gross <mgross@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>
References: <20210315095710.7140-1-henning.schild@siemens.com>
 <20210315095710.7140-2-henning.schild@siemens.com>
 <CAHp75VdXDcTfNL9QRQ5XE-zVLHacfMKHUxhse3=dAfJbOJdObQ@mail.gmail.com>
 <20210317201311.70528fd4@md1za8fc.ad001.siemens.net>
 <92080a68-9029-3103-9240-65c92d17bf16@redhat.com>
 <6c7d165d-1332-2039-0af3-9875b482894b@metux.net>
 <420f0e08-bec8-f85a-d9af-b9900072df66@redhat.com>
 <20210326105542.10122edd@md1za8fc.ad001.siemens.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ec400dc9-58dd-52be-13c2-4a56d2bb57b0@redhat.com>
Date:   Fri, 26 Mar 2021 13:21:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210326105542.10122edd@md1za8fc.ad001.siemens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/26/21 10:55 AM, Henning Schild wrote:
> Am Thu, 18 Mar 2021 12:45:01 +0100
> schrieb Hans de Goede <hdegoede@redhat.com>:
> 
>> Hi,
>>
>> On 3/18/21 12:30 PM, Enrico Weigelt, metux IT consult wrote:
>>> On 17.03.21 21:03, Hans de Goede wrote:
>>>
>>> Hi,
>>>   
>>>>> It just identifies the box and tells subsequent drivers which one
>>>>> it is, which watchdog and LED path to take. Moving the knowledge
>>>>> of which box has which LED/watchdog into the respective drivers
>>>>> seems to be the better way to go.
>>>>>
>>>>> So we would end up with a LED and a watchdog driver both
>>>>> MODULE_ALIAS("dmi:*:svnSIEMENSAG:*");  
>>>
>>> Uh, isn't that a bit too broad ? This basically implies that Siemens
>>> will never produce boards with different configurations.  
>>
>> There is a further check done in probe() based on some Siemens
>> specific DMI table entries.
>>
>>>>> and doing the identification with the inline dmi from that header,
>>>>> doing p2sb with the support to come ... possibly a
>>>>> "//TODO\ninline" in the meantime.
>>>>>
>>>>> So no "main platform" driver anymore, but still central platform
>>>>> headers.
>>>>>
>>>>> Not sure how this sounds, but i think making that change should be
>>>>> possible. And that is what i will try and go for in v3.  
>>>>
>>>> Dropping the main drivers/platform/x86 driver sounds good to me,
>>>> I was already wondering a bit about its function since it just
>>>> instantiates devs to which the other ones bind to then instantiate
>>>> more devs (in the LED case).  
>>>
>>> hmm, IMHO that depends on whether the individual sub-devices can be
>>> more generic than just that specific machine. (@Hanning: could you
>>> tell us more about that ?).
>>>
>>> Another question is how they're actually probed .. only dmi or maybe
>>> also pci dev ? (i've seen some refs to pci stuff in the led driver,
>>> but missed the other code thats called here).
>>>
>>> IMHO, if the whole thing lives on some PCI device (which can be
>>> probed via pci ID), and that device has the knowledge, where the
>>> LED registers actually are (eg. based on device ID, pci mmio
>>> mapping, ...) then there should be some parent driver that
>>> instantiates the led devices (and possibly other board specific
>>> stuff). That would be a clear separation, modularization. In that
>>> case, maybe this LED driver could even be replaced by some really
>>> generic "register-based-LED" driver, which just needs to be fed
>>> with some parameters like register ranges, bitmasks, etc.
>>>
>>> OTOH, if everything can be derived entirely from DMI match, w/o
>>> things like pci mappings involved (IOW: behaves like directly wired
>>> to the cpu's mem/io bus, no other "intelligent" bus involved), and
>>> it's all really board specific logic (no generic led or gpio
>>> controllers involved), then it might be better to have entirely
>>> separate drivers.  
> 
> In fact it does dmi and not "common" but unfortunately vendor-specific.
> On top it does pci, so it might be fair to call it "intelligent" and
> keep it.
> 
>> FWIW I'm fine with either solution, and if we go the "parent driver"
>> route I'm happy to have that driver sit in drivers/platform/x86
>> (once all the discussions surrounding this are resolved).
>>
>> My reply was because I noticed that the Led driver seemed to sort of
>> also act as a parent driver (last time I looked) and instantiated
>> a bunch of stuff, so then we have 2 parent(ish) drivers. If things
>> stay that way then having 2 levels of parent drivers seems a bit too
>> much to me, esp. if it can all be done cleanly in e.g. the LED driver.
> 
> One "leds" driver doing multiple leds seems to be a common pattern. So
> that "1 parent N children" maybe does not count as parentish.
> 
>> But as said I'm fine either way as long as the code is reasonably
>> clean and dealing with this sort of platform specific warts happens
>> a lot in drivers/platform/x86 .
> 
> I thought about it again and also prefer the "parent driver" idea as it
> is. That parent identifies the machine and depending on it, causes
> device drivers to be loaded. At the moment LED and watchdog, but with
> nvram, hwmon to come.
> 
> I will stick with "platform" instead of "mfd" because it is really a
> machine having multiple devices. Not a device having multiple functions.

Ok, sticking with the current separate "platform" parent driver design
is fine by me.

Regards,

Hans

