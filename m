Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C02A3ED206
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 12:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhHPKey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 06:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22061 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230064AbhHPKeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 06:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629110050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o56kFl5Q5JRPj00nvRvdyzY+Pmj2K5yYLBsvpdrfXvw=;
        b=H6UJRbi9U4ZRRhsYtr0Y6DaSflieOZwWoVlGP3VCXTc2vMWSZg7/t3lSW5AYIP4fFsqXow
        ORXzLvh6H62IKTu4kWNlvyoPAWCVTS2QOHeQg+HfMFpoDJf2UFfZzwvkKm0L/mCKuujMbB
        cNQ6VtUEjSEltfo9NQzvOt6JJTrlpvQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-GE0e0L6IMGKKMN6ghBp91Q-1; Mon, 16 Aug 2021 06:34:09 -0400
X-MC-Unique: GE0e0L6IMGKKMN6ghBp91Q-1
Received: by mail-ej1-f71.google.com with SMTP id gg1-20020a170906e281b029053d0856c4cdso4514702ejb.15
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 03:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o56kFl5Q5JRPj00nvRvdyzY+Pmj2K5yYLBsvpdrfXvw=;
        b=r7RGvvPaHiDK8fwZrF1BDDoi5U1CFqBLdwzm0RJ4+FfHULI7uW8QLT+1mOffn6ZeSX
         XB44pMy5vO64bkpvZrt2QUU59jAEx8ina0JHhYWIEMIy2V3uiEzIUqY3UzXbI7apYcJt
         pwTi0OX7DC7Wk0PocD3C7wbpE45Jq5Uh9GRgPYDMR1LMeOYdMYQboKesQk9WWsJNz8bi
         reTqpsESiOvoCGpmy9/kUbYyUFRbsVGFXR2PxBsWJGoyq2WXkEXoBklh+a1pbZ/m/xFK
         1dZAj/Y8XlZpXW8lUAaS5ZR/bw8wXUQTQ457oWRU6Sxz+x2WFmIAso6d/BlWWharSxCP
         kZrQ==
X-Gm-Message-State: AOAM5325cMNe29Kqf8Tnx6YuJxgxVqbEE6SBKAXrbtFjHM/tGw6Q5HQu
        OD6L3AH8xI0WQP/JGllm4Vof8XcuzHXGGxj+uAChyaU4iMEh31oGeARWy4NR2Ebg6P21jEI52do
        s/Z2OvgqyBFvkOfg8/zxN5qtBcgpYFxM26xoyPkZDUAOfHzSvi+ZU/YA6neeVD/QZNHb30ubbrr
        FW
X-Received: by 2002:a17:906:4c8c:: with SMTP id q12mr15471556eju.254.1629110047847;
        Mon, 16 Aug 2021 03:34:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6IwEDCl7PI2ndYdWGeb/zTJgMPtufIMxffeaVGBWYu8pAxTCTS/9YLBFhzdYlw1He9oe73A==
X-Received: by 2002:a17:906:4c8c:: with SMTP id q12mr15471541eju.254.1629110047668;
        Mon, 16 Aug 2021 03:34:07 -0700 (PDT)
Received: from x1.localdomain ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id r16sm4621263edt.15.2021.08.16.03.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 03:34:07 -0700 (PDT)
Subject: Re: Dell laptop function keys stopped working between 5.10.46 and
 5.13.9
To:     Paul Menzel <pmenzel@molgen.mpg.de>, Dell.Client.Kernel@dell.com,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b8ff8f68-4d5a-7ec6-4c4f-9f5be6e70ab5@molgen.mpg.de>
 <1d4ce7d6-3213-45af-0467-7548f69b7d9e@molgen.mpg.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7857ead5-6ccf-3290-9e86-4f16d2bf360f@redhat.com>
Date:   Mon, 16 Aug 2021 12:34:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1d4ce7d6-3213-45af-0467-7548f69b7d9e@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/16/21 12:22 PM, Paul Menzel wrote:
> [attach Linux 5.13.9 messages (output of `dmesg`)]

Does "lsmod" output include any Dell modules like dell-laptop or
dell-wmi ?

How about on the 5.10 kernel?  It looks like the 5.13 kernel simply
does not have these modules enabled / loaded.

Regards,

Hans


> 
> Am 16.08.21 um 11:48 schrieb Paul Menzel:
>> Dear Linux folks,
>>
>>
>> On a Dell Latitude E7250, updating Linux from 5.10.46 to 5.13.9 (Debian sid/unstable) the two function keys to (un-)mute the microphone, and enable/disable Wifi stopped working. The other function keys continue to work. The `evtest` output did not change.
>>
>>      Linux version 5.10.0-8-amd64 (debian-kernel@lists.debian.org) (gcc-10 (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #1 SMP Debian 5.10.46-4 (2021-08-03)
>>
>>      Event: time 1629104514.184947, type 4 (EV_MSC), code 4 (MSC_SCAN), value 88
>>      Event: time 1629104514.184947, type 1 (EV_KEY), code 240 (KEY_UNKNOWN), value 2
>>
>>      Linux version 5.13.0-trunk-amd64 (debian-kernel@lists.debian.org) (gcc-10 (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #1 SMP Debian 5.13.9-1~exp2 (2021-08-10)
>>
>>      Event: time 1629103829.341409, type 4 (EV_MSC), code 4 (MSC_SCAN), value 88
>>      Event: time 1629103829.341409, type 1 (EV_KEY), code 240 (KEY_UNKNOWN), value 2
>>
>> The output of `acpi_listen` also did not change.
>>
>>      $ acpi_listen
>>       9DBB5994-A997- 000000d0 00000000
>>
>> Are you aware of such reports?
>>
>>
>> Kind regards,
>>
>> Paul

