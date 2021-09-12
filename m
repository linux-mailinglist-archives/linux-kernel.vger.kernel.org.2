Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94858407B70
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 06:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbhILEEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 00:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhILEED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 00:04:03 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A7FC061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 21:02:50 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 6so9234862oiy.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 21:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dSoAS7+ImeuUBX/zrBuKdj1UHOEbgNL8W1ywFSOISG8=;
        b=PJvoX3VDNm3a2LixckrrueHjtgwWcPZ/zlqdxvxklgiDjdwcfdRTHQ4gmfz/D8pHYc
         SMI8o0ryRahkjz1cK2WGqxSN0AL4+vH952p5061pNuEZhWi0F/j7jcDMksSeAWt5EJAC
         UVT+b886cgg3dXdoZi1ixL6zxNUHT5mzFT2aFwgXvym+nis89h/FoYsH1B1scQd9lvCm
         A87s6XFcH8hbRwPfRgkTKumVwAfD9W5JaaJ54vQ+kq9cuVI5CgRpjz+s4bJdHwrmOu7H
         xkz6S+kSzKfXCTyII+W/w/1hVFCgNUCzMT/74seEYqUVlDvNY1Xw+CfTx27ik/SsvxAM
         T5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dSoAS7+ImeuUBX/zrBuKdj1UHOEbgNL8W1ywFSOISG8=;
        b=oJCJA6VWhGp8ZdVAh7FV/IQRkCDV3VKgJq5iTDCH0n4/9OSh5yrNUTKh2sG+zJzh7X
         BErxpNYsuWiMyP7C/OcXeijVR2nGJY4eIE4EChhphZ3n7lS0BUaFmDu8oX09v7orLSfk
         MzNDaPRkgZgb8qcNXveixaxuFge3hKmOddxIF5UuAJcUkPhYZFARVKTmLkIrk2kW3XwQ
         789ab0XF66JDG42ePCiDC3cZvwSs+456juylcvHWpvKKpMQkCxTOqXF2r0qzeOAI3kCR
         B9yJD6/Nw1E1B5+Gybwcj6/bM7pFO2aY04Y9tzKauWyyqy1tW5gkBZjevH1kWE734mGI
         yAZg==
X-Gm-Message-State: AOAM5310k5UBJAzmdUKUZcNHdK6QkKp1n2ucPN9V/svHCqUZhS8qxN/6
        Mds7fJqEYzVqE+yHI/gtp30=
X-Google-Smtp-Source: ABdhPJypCxNFY1FPwd5omy5MwwUMR5ZV71BhzOeGIziuWBDFA9mSDHGZ/kDmIhFnUizF3uejPnye5g==
X-Received: by 2002:a05:6808:14c9:: with SMTP id f9mr3349507oiw.163.1631419369522;
        Sat, 11 Sep 2021 21:02:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o8sm802125oiw.55.2021.09.11.21.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Sep 2021 21:02:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>
References: <20210912025235.3514761-1-linux@roeck-us.net>
 <CAMo8BfJ8f+4AmBD1B7J9vOp0xQbB=zRW-NyGZP6gTPTA-74OPQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] xtensa: Increase size of gcc stack frame check
Message-ID: <49f8f332-a964-5b98-64c6-9fa5d028731a@roeck-us.net>
Date:   Sat, 11 Sep 2021 21:02:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAMo8BfJ8f+4AmBD1B7J9vOp0xQbB=zRW-NyGZP6gTPTA-74OPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/21 8:05 PM, Max Filippov wrote:
> On Sat, Sep 11, 2021 at 7:52 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> xtensa frame size is larger than the frame size for almost all other
>> architectures. This results in more than 50 "the frame size of <n> is
>> larger than 1024 bytes" errors when trying to build xtensa:allmodconfig.
>>
>> Increase frame size for xtensa to 1536 bytes to avoid compile errors
>> due to frame size limits.
>>
>> Cc: Chris Zankel <chris@zankel.net>
>> Cc: Max Filippov <jcmvbkbc@gmail.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   lib/Kconfig.debug | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index ed4a31e34098..afad11e57d6b 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -346,7 +346,7 @@ config FRAME_WARN
>>          int "Warn for stack frames larger than"
>>          range 0 8192
>>          default 2048 if GCC_PLUGIN_LATENT_ENTROPY
>> -       default 1536 if (!64BIT && PARISC)
>> +       default 1536 if (!64BIT && (PARISC || XTENSA))
>>          default 1024 if (!64BIT && !PARISC)
> 
> Shouldn't that line also be changed to
>    default 1024 if (!64BIT && !(PARISC || XTENSA))
> ?

I could do that, but I tested it and it looks like the evaluation
is top-down, so it didn't seem necessary or useful. For example,
the default value is 2048 for 32-bit systems (such as arm, riscv32,
or i386) if GCC_PLUGIN_LATENT_ENTROPY is enabled, even though the
line with the default of 1024 matches as well.

Thanks,
Guenter
