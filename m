Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317463CF4D7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 08:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239908AbhGTGOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 02:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbhGTGN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 02:13:58 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365DBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 23:54:32 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id p17so10971650plf.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 23:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=TGUv40RVMYXOh6KiHqrq6840FSz1qV9wifGkcdU1UIE=;
        b=sdjrxl1Wj0oJ16dSDOf7qCbB4iokjDADNt7X5W/9J1EMuFGZJzg16irOTnAIC4b/FG
         i+5iGCtDUdNOGh0qYXOnwJ6+UiO1w7YtNysblfmGzVNIEQostlRp4bwmzqIXysySqyuB
         e3EIPoWZ6iAbq+/g2uMGj9jlwYeqyA+i0LP78oTm5t5T/OK8driv1/+Ue37uhYN67SNr
         /0LiJRjYFy/SjlCvsCRdmE9u8cLlZ9DEzjWajtY0yzqUnLZ+iSK51Q8jjYkMSKunYYAB
         REDtqeRNGIHbluJM/qJYFVtalRzjrhjP3PWOVR6EoBj9QO0tEa9wTWSRgBz/apw8XckU
         2VkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TGUv40RVMYXOh6KiHqrq6840FSz1qV9wifGkcdU1UIE=;
        b=bTxJpdgqQQXCpa709a7Hkt61qg4Rw1xIhU9xTV3gxjjS0ovXye1MgzQ8hyyw4inyD6
         ty68c4B14hR+oTUOnLJ+9a37iQxWXcgJzkRHIIsNXF1wtk5cjnZPSIrCevtYIxYSpoO3
         cWqL/ySfR7/snKrqGCxsC5cEkV/B925oXaizMV3cbt3NO4JwfOKSE8wSiyqw6dE6E3Hz
         0evU/gSu56ZdRFekKJc+AJRrITjQO9VKgZ5RhoFapkptwf19PgUDHHE9DLHSJ/FHzqWY
         Q3wseet45SpQjf86u2y3YuLr2KYErei/71x1cPf5nysh68TiFDrkXuNLwNrEdJ13Re82
         eBXw==
X-Gm-Message-State: AOAM533B0Z6u9gTY52ZsAw179hWuz9m02DMauw0lN6x4nA+mv0qmg/1o
        jZ3X8VUUeDwSpq5FKpyTB/PY8BILfXg=
X-Google-Smtp-Source: ABdhPJw/zdSDh0HwVmqBC8zH0slokjPAmbpjxwyQGgzcAobkwXE7LX3UdBaMqTX91UiGyNLGKJQcDg==
X-Received: by 2002:a17:90b:128a:: with SMTP id fw10mr28594223pjb.116.1626764071284;
        Mon, 19 Jul 2021 23:54:31 -0700 (PDT)
Received: from [192.168.1.153] (M106072041033.v4.enabler.ne.jp. [106.72.41.33])
        by smtp.gmail.com with ESMTPSA id i18sm23006194pfa.149.2021.07.19.23.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 23:54:30 -0700 (PDT)
Subject: Re: [PATCH v4 1/1] riscv: __asm_copy_to-from_user: Optimize unaligned
 memory access and pipeline stall
To:     Guenter Roeck <linux@roeck-us.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <a7a801d2-13d2-7b5b-66a5-98e7c95b00cc@gmail.com>
 <5e1b5d90-5a1e-5e9f-7b92-6c53b8589c2a@gmail.com>
 <cd14a8b0-0a27-77a8-6dc2-3268f9f09922@roeck-us.net>
 <e1bb4768-5517-8ef3-eaf3-bbfc103fa918@gmail.com>
 <9a2bf544-2aaa-d175-bc0a-c8bcefd8141a@roeck-us.net>
 <718c5a83-de9f-3b5a-ef36-e52ad5bb4d67@gmail.com>
 <c19f05f0-985e-ca6e-7cfc-af5c69e155fd@roeck-us.net>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <616a5e92-4225-6793-fa0c-02ff831e26df@gmail.com>
Date:   Tue, 20 Jul 2021 15:54:27 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c19f05f0-985e-ca6e-7cfc-af5c69e155fd@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/21 00:16, Guenter Roeck wrote:
> On 7/19/21 7:49 AM, Akira Tsukamoto wrote:
>>
>> On 7/19/2021 11:24 PM, Guenter Roeck wrote:
>>> On 7/19/21 7:00 AM, Akira Tsukamoto wrote:
>>>>
>>>> On 7/19/2021 10:51 PM, Guenter Roeck wrote:
>>>>> Hi,
>>>>>
>>>>> On 7/19/21 5:53 AM, Akira Tsukamoto wrote:
>>>>>>
>>>>>> This patch will reduce cpu usage dramatically in kernel space especially
>>>>>> for application which use sys-call with large buffer size, such as
>>>>>> network applications. The main reason behind this is that every
>>>>>> unaligned memory access will raise exceptions and switch between s-mode
>>>>>> and m-mode causing large overhead.
>>>>>>
>>>>>
>>>>> I had to revert the original patch from the mainline kernel prior to applying
>>>>> this patch. Obviously that means that there may be other changes affecting the
>>>>> outcome.
>>>>>
>>>>> riscv64 images work, but riscv32 images still fail with this patch applied.
>>>>> The error is a bit different than before, though.
>>>>>
>>>>> ...
>>>>> [   11.899979] Run /sbin/init as init process
>>>>> [   12.152666] random: fast init done
>>>>> moun: applet not found
>>>>> "�����V�t: applet not found
>>>>> /bi�����V�F-: applet not found
>>>>> moun: applet not found
>>>>> swaon: applet not found
>>>>> hostname-F: applet not found
>>>>>
>>>>> After this, the image hangs.
>>>>>
>>>>> For comparison, the mainline kernel (v5.14-rc2) fails as follows.
>>>>>
>>>>> [   10.788105] Run /sbin/init as init process
>>>>> Starting syslogd: OK
>>>>> Starting klogd: OK
>>>>> /etc/init.d/S02sysctl: line 68: syntax error: EOF in backquote substitution
>>>>> /etc/init.d/S20urandom: line 1: syntax error: unterminated quoted string
>>>>> Starting network: /bin/sh: syntax error: unterminated quoted string
>>>>> sed: unmatched '/'
>>>>> /bin/sh: syntax error: unterminated quoted string
>>>>> FAIL
>>>>> /etc/init.d/S55runtest: line 48: syntax error: EOF in backquote substitution
>>>>>
>>>>> I'll be happy to provide information on how to reproduce the problem
>>>>> if needed. Please let me know.
>>>>
>>>> Yes, I do would like to know the procedure of build instruction of your rv32 image.
>>>> Then I would reproduce the error and look into how to fix it.
>>>>
>>> Please have a look at http://server.roeck-us.net/qemu/riscv32/
>>> and let me know if you need anything else.
>>
>> Thanks for the link. I will work on it tomorrow in my time.
>> Building the kernel with defconfig looks much quicker than the config.
>> I will try it from defconfig and then config.
>>
>> Also I would like to use the same rv32 toolchain. Are you using prebuilt
>> riscv32-linux-gcc? Should not make differences but just in case.
>>
> 
> I use a toolchain built with either buildroot (when building the root file system)
> or with the buildall scripts from https://github.com/jmesmon/buildall.git
> (for the kernel). Either case, it is the default riscv32 toolchain from both.
> 
>> Is there a public reference for the way of building your qemu and opensbi?
>> Not sure which version of qemu with which rv32 to build them, rv32i, rv32imad or else.
> 
> I don't know about rv32i or rv32imad, sorry. I build qemu from source using
>     --disable-user --disable-gnutls --disable-docs \
>         --disable-nettle --disable-gcrypt --disable-vnc-png \
>         --disable-xen --disable-xen-pci-passthrough \
>         --disable-libssh
> configuration options. The firmware image (opensbi) is built as part of that.
> You should be able to use a pre-built version of qemu v6.0 if that is available
> somewhere.
> 
> Hope this helps,

Super, I was perfectly able to reproduce the exactly the same error messages
with the toolchain in buildroot and your rootfs.

There were two bugs, one is overrun copy and second is wrong shifting in .Lshift_copy
for rv32.

Please wait for my fix.

Akira
