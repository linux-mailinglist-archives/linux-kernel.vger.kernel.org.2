Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1881D38C934
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 16:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236761AbhEUO2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 10:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhEUO2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 10:28:48 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3F8C061574;
        Fri, 21 May 2021 07:27:25 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so18145459oth.8;
        Fri, 21 May 2021 07:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xMj1qXfK8gsMQ7PPQfGr1WuTZEPbUqRoUDWXdTdkR+M=;
        b=JeE7sdzcEAXWmWfLzJ+PEk/lemZoWz2eLGCOcaqBxiY1YbIkPf+OJXTcwEwMIRcrUY
         DPD800oG7+TE2jpouIV0xX/T+jiGZ40bwJAE7/GFcrsBcytshIRtYlB9pJfU2TlOsjbH
         6Kr3ZAD36jFzwUEIHiYcNESYtQOJ8fqPF8pXKVslbMzB1FPjILsts3avlFODx92o9Q+5
         DIhgq3QQFI3MZ0jDl9FF6J27ujiAT/MMoLS1IfUl/sp1IoM90e6p6TpYCIBLk6w4dKvP
         NiPXxz0YU8On3E+TL+6qYl+7B4TqTlmzrHylOlWS/gaNwp6HiRI8wQHCuecxJ4C2qjHM
         Np4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xMj1qXfK8gsMQ7PPQfGr1WuTZEPbUqRoUDWXdTdkR+M=;
        b=FYYvLDsvcklO/4GOT26c/rqVbsmc8f0dWFDNwVUa/RI+7Tv0jzbxaA0dGRgC+TpWzU
         t1QQmzAt9hc1Ipa5jEVENL7zPbE1iEsosyxSTaFKQFODSXUPsrYysgd05O+5v+S40HGx
         To9ViwjQoVRb5yK/jJWPX5E9f3jBe3kt7qSa6qh6qzhv+o6V5yQjECefH/ECVmGwVu+r
         fY0hJUPsOiL88X32wL25Od/9fnn/GaHTeJ0WEF47aIF/R95M5P5gdyXnkhTuhIImFBn2
         NIB39uF66Bs4tAOYjKbQ656Yb1pjc2RvGavmIarwb/X/mzJtnX/WG9FiJYYzyvmnhrEF
         7qDQ==
X-Gm-Message-State: AOAM532Qk9T3gIt4aL7xU4vfgpsSVCDOntSJxPzjc246GMUhYxj/91U0
        g4cbUuiiCzGAyv0LmWVUEBY=
X-Google-Smtp-Source: ABdhPJxWvWf5bmeC+ab68EWtCWKPccLiRC8nlfaZxh2g6ryciLhgEGn1Jmt+3HCU5nwApUE/IhjPtQ==
X-Received: by 2002:a05:6830:1e54:: with SMTP id e20mr8681834otj.227.1621607244973;
        Fri, 21 May 2021 07:27:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p1sm1365607otk.58.2021.05.21.07.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 07:27:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 1/3] hwmon: (pmbus) Add driver for Delta DPS-920AB PSU
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luka Perkov <luka.perkov@sartura.hr>, jmp@epiphyte.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Donald Buczek <buczek@molgen.mpg.de>
References: <20210430132735.127342-1-robert.marko@sartura.hr>
 <20210430134810.GA2714262@roeck-us.net>
 <CA+HBbNH+gQOmu_Ho0ivFuGHdu0zBtOrr1474z+7FA1zmNb4bug@mail.gmail.com>
 <2b990feb-dc26-debb-4f81-430bbc89b51c@roeck-us.net>
 <CA+HBbNHQHqD-wgryaBLZ5M2Lxafb0OwNcbiQJmRQPcZfprmUEg@mail.gmail.com>
 <cfbe487f-8d01-e9b7-0aae-f93a27aff023@roeck-us.net>
 <CA+HBbNHQrZRcz-3qBn1RkqLxOn_+sNH8VKJVihkaaiFoAy=d7g@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <5a11415f-4c0f-b073-6325-2e9b4078655c@roeck-us.net>
Date:   Fri, 21 May 2021 07:27:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CA+HBbNHQrZRcz-3qBn1RkqLxOn_+sNH8VKJVihkaaiFoAy=d7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/21 5:33 AM, Robert Marko wrote:
> On Fri, May 21, 2021 at 1:41 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 5/21/21 1:36 AM, Robert Marko wrote:
>> [ ... ]
>>>> In this context, I have a hard time finding a reference for
>>>> this power supply. Do you have a datasheet or some other documents
>>>> you can share ?
>>>
>>> Unfortunately, I don't have a datasheet as that would have made this way easier.
>>> It was all based on the vendor "driver" from DENT:
>>> https://github.com/dentproject/dentOS/blob/main/packages/platforms/delta/arm64/tn48m/tn48m-poe/modules/builds/src/arm64-delta-tn48m-poe-psu.c
>>>
>>
>> Ah, so this is not a driver for a power supply from DeltaPSU,
>> but a power supply from Delta Networks Technology Corporation,
>> as used in that company's TN48M-POE switch. That is a world
>> of difference, even though the parent company seems to be the
>> same. I am not sure if, based on this information, the driver
>> should claim to be for "Delta DPS-920AB PSU" in the first place.
> 
> It's actually a PSU from Delta Electronics INC, Delta Networks are just using
> it inside of the Delta Networks TN48M-DN-P switch.
> I checked the label on the PSU-s.

Ok, thanks. Guess we'll have to live with that.

>>
>> Can you run a block read on MFR_MODEL and MFG_SERIAL ?
>> That might give us an idea about the actual manufacturer
>> and model of this power supply.
> 
> MFG_SERIAL is just a bunch of 0xf-s, but MFR_MODEL has something.
> However, the Armada 7040 I2C adapter cannot do block reads although
> it returns 11 bytes but it's just zeros.

Hmm, it seems more likely that the field is empty. Block read
isn't really different from other read operations.

Thanks,
Guenter

>>
>> Also, isn't that the same power supply for which you were
>> trying to add another hwmon driver to display some of its
>> status information, obtained from some CPLD ?
> 
> This and one more as the non-PoE version of the TN48M-DN switch
> has a single 150W PSU that does not support PMBus, but the CPLD
> always provides presence information and Power Good status.
>>
>> Thanks,
>> Guenter
> 
> 
> 

