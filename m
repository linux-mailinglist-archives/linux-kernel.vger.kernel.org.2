Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF57459B83
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 06:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhKWFWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 00:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhKWFWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 00:22:18 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA29C061714
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 21:19:11 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id n85so18244659pfd.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 21:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=accesio-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vNZyp2NQ1twrNJ+vuo7dt/GkHiTpJ1nvwpWmCyyWEh4=;
        b=J06BfGg5QuVkcG7zmvrRdBsHnMOrExC+lypYhNdLk3yCmQmzIJQPsDaVG1IxN/D2wZ
         4TNo+jRwG74i8cpLpPNFX7kI40B+3O7lYe+21rv8HboJNX/5OajYqFRAaYbQw8EwrbiS
         gzW2ABEujGiEN9dZ9+hWqkkRuMLecnKIEUY97jv9RWGMM9boo1h37nmrI+vLmWeBv/26
         FrILhBkevnaZJGC49rGvUWtbCF07g3LQatjUprSGpdDNkLgJ7JW8Rsj8xBUybuKqoAYC
         OG3w/b9mesMQLYHhT2jZRRq/Pc35DSQlx0t3BNdrqmCkDoa01h/rqotNUx8j8SHaI5c4
         Nc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vNZyp2NQ1twrNJ+vuo7dt/GkHiTpJ1nvwpWmCyyWEh4=;
        b=Kbx+Rvdra2yi40lPIN1ZiiduwfqS6/gEyjC7ygBR1nTDpANeA7oMm3k2XPk0o9dt7o
         GG/8+b27/DXx31VIeRTMRGsWEdVEO+yFr0IJx59qVzD30MBQkviasK4ow1qjQ+MTNKuN
         X/k5zORAlnmb2Tz8op00DsQU0sQI/SZfO8Tx84ajRIr+BFw+E1x4hqcefBT6J/l4dsJ3
         JT2DRX8LYkIF450/KiRYfgKdh4ZBe5a1pekJGGDLdHYdHUUDvhThurp4utJ/oXLLuoTm
         mMXV03daD2b5C/z9/0tRmrFsUUuLn9ygs/6lJy7SG8NYUVlM0gs1d++9Ld+R0pP6fRQx
         1QbQ==
X-Gm-Message-State: AOAM533hCE6igFq/1CCsw2TJYnK7SkUjoN2+G5yUpCeiwiH3dQzBiz0S
        lE3Pz/3BYLM/f5WJp8lWw74H
X-Google-Smtp-Source: ABdhPJwLRY/XIPlwmbmj71W47VxXsiYXwqBom9DO0ooaoBA+2m6YXD4BScpy7Vg1jlq4hoOtx1Ji7w==
X-Received: by 2002:a65:50c6:: with SMTP id s6mr1867661pgp.352.1637644750670;
        Mon, 22 Nov 2021 21:19:10 -0800 (PST)
Received: from [172.16.8.241] ([98.149.220.160])
        by smtp.gmail.com with ESMTPSA id nl16sm21370028pjb.13.2021.11.22.21.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 21:19:10 -0800 (PST)
Subject: Re: [PATCH v1 0/2] serial: 8250_pci: Split Pericom driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>
References: <20211117145750.43911-1-andriy.shevchenko@linux.intel.com>
 <b99aabbe-add9-9c1e-ed4b-8850c69233de@accesio.com>
 <YZuRV8ipjcly26HB@smile.fi.intel.com> <YZuRnSaZz04KJIDk@smile.fi.intel.com>
From:   Jay Dolan <jay.dolan@accesio.com>
Message-ID: <ede18fd7-266e-406d-0c9c-570d95ab3673@accesio.com>
Date:   Mon, 22 Nov 2021 21:19:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YZuRnSaZz04KJIDk@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/22/21 4:48 AM, Andy Shevchenko wrote:
> On Mon, Nov 22, 2021 at 02:47:20PM +0200, Andy Shevchenko wrote:
>> On Thu, Nov 18, 2021 at 10:32:51PM -0800, Jay Dolan wrote:
>>> On 11/17/21 6:57 AM, Andy Shevchenko wrote:
>>>> Split Pericom driver to a separate module.
>>>> While at it, re-enable high baud rates.
>>>>
>>>> Jay, can you, please, test this on as many hardware as you have?
>>
>> ...
>>
>>> * Add in pericom_do_startup() because the UPF_MAGIC_MULTIPLIER doesn't
>>> stick.
>>
>> Can't find an evidence that this is the case. Can you recheck this (reading
>> flags back via sysfs or so)? So, for v2 I'll leave my approach.
> 
> Otherwise how the other drivers which are using that flag survive? If it's
> indeed an issue, it should be fixed on generic level.
> 

I modified pericom_do_startup to log when the UPF_MAGIC_MULTIPLIER flag 
was present. Then tried to set the port to 3000000 a few times. The port
stayed at 9600. It looks like pericom_do_startup() is getting called 
twice per port on boot, and the flag is gone with the second one.

[    4.925577] [J4D] flag present
[    4.926121] [J4D[ flag not present
[    4.926843] [J4D] flag present
[    4.927415] [J4D[ flag not present
[    4.928106] [J4D] flag present
[    4.928673] [J4D[ flag not present
[    4.929419] [J4D] flag present
[    4.930447] [J4D[ flag not present

[   49.528504] [J4D[ flag not present
[   51.675240] [J4D[ flag not present
[   59.617954] [J4D[ flag not present

Then I modified it to log when it was adding the flag in. The port was 
set to 3000000. Also the flag only needed to be added in once. It sticks 
after the first time.

[    4.647546] [J4D] flag present
[    4.648119] [J4D] flag not present(adding)
[    4.648778] [J4D] flag present
[    4.649330] [J4D] flag not present(adding)
[    4.650001] [J4D] flag present
[    4.650537] [J4D] flag not present(adding)
[    4.651192] [J4D] flag present
[    4.651718] [J4D] flag not present(adding)

[   96.025668] [J4D] flag present
[  100.130626] [J4D] flag present
[  116.435436] [J4D] flag present

I mostly just guessed at do_startup() being the place to set the magic 
multiplier flag after it didn't stick in quirk in 8250_pci.c.

