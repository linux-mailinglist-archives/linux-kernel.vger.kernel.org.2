Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353D33A3CAE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 09:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhFKHQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 03:16:21 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:43808 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhFKHQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 03:16:19 -0400
Received: by mail-ed1-f45.google.com with SMTP id s6so35920993edu.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 00:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mnVuJPXKTdEwY7O6bd33gsWO3BDV2gsole1M9DM/dMY=;
        b=OTC0Ybpca01gVjblMmlalhiAIMZYtpJxs3MR1hzta+gsyJgy2zxOngqH+j9yjkbkJx
         c4jJHvuv/03vWqn97t117vhqkfv+hE0FxFu/Yh0SOftt7PGtqcn07r5VZzcIzBTKw1rM
         hANgYmnu5RQ9XsIlIvNpmW0/9qzisCymN4NgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mnVuJPXKTdEwY7O6bd33gsWO3BDV2gsole1M9DM/dMY=;
        b=iWOTWVU7hjcd22L9/CYpzOKqrd2yUYbjCchmM8wHSVaceEkLHWDoqEWTE3R5gpT/1/
         330SeXIatK0xubCnWHkxgk5HE7rZquPxq1rqchkU9uareNyQDaEg56FyUUUe43UJVkB9
         S/bicBGtmPdAqJGKb/cLdKpDAwKQQPjxg2Hl5DptQqSiYET5BmZCmJI+K5lSbQKrCI1I
         yrviIatqRh7k1lAddo8of+r8QoF2noy+0TBeDVN7LS36Fr7+ZVrxlsENwo1iASGvyyxp
         h2llDa1qGBRbfXw3S6qZcS3ADHhzOUbkPwBelGzgoGzLu/CRNJkAQQXjWvBOgr0TB/cq
         s1jQ==
X-Gm-Message-State: AOAM533szGJBoGTw4X4zKKSuE5nXdVhd2Wq0mjuSZDubPPRQ3zltMg2D
        9owx2vjW8EZO1gPdRPKJA3hW1Q==
X-Google-Smtp-Source: ABdhPJxJ9FPEyKtZ0BCfsSvgPQ5ro3hP0rEg+kY/ozF7bGCKbB6xMTB/4xQ/9ea9IfAldT9FVR39rg==
X-Received: by 2002:a05:6402:1d0f:: with SMTP id dg15mr2186797edb.137.1623395601406;
        Fri, 11 Jun 2021 00:13:21 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.64.110])
        by smtp.gmail.com with ESMTPSA id i15sm1836897ejk.30.2021.06.11.00.13.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 00:13:20 -0700 (PDT)
Subject: Re: Panic on ppc64le using kernel 5.13.0-rc3
To:     Bruno Goncalves <bgoncalv@redhat.com>
Cc:     linux-kernel@vger.kernel.org, CKI Project <cki-project@redhat.com>
References: <CA+QYu4qxf2CYe2gC6EYnOHXPKS-+cEXL=MnUvqRFaN7W1i6ahQ@mail.gmail.com>
 <d13db73d-0806-00cd-ff84-5f5b03ffbef6@rasmusvillemoes.dk>
 <CA+QYu4oFGkP1G+9TqGtqffgOEBycSMKtFbV-1X+kL4NeTyEegg@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <45ea5042-9136-6f0c-144c-f09d05cd69ed@rasmusvillemoes.dk>
Date:   Fri, 11 Jun 2021 09:13:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CA+QYu4oFGkP1G+9TqGtqffgOEBycSMKtFbV-1X+kL4NeTyEegg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2021 17.14, Bruno Goncalves wrote:
> On Thu, Jun 10, 2021 at 3:02 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> On 10/06/2021 13.47, Bruno Goncalves wrote:
>>> Hello,
>>>
>>> We've observed in some cases kernel panic when trying to boot on
>>> ppc64le using a kernel based on 5.13.0-rc3. We are not sure if it
>>> could be related to patch
>>> https://lore.kernel.org/lkml/20210313212528.2956377-2-linux@rasmusvillemoes.dk/
>>>
>>
>> Thanks for the report. It's possible, but I'll need some help from you
>> to get more info.
>>
>> First, can you send me the .config?
> 
> The .config is on
> https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2021/06/09/317881801/build_ppc64le_redhat:1332368174/kernel-block-ppc64le-d3f02e52f5548006f04358d407bbb7fe51255c41.config

Thanks.

>>
>>>
>>> [    1.516075] wait_for_initramfs() called before rootfs_initcalls
>>
>> This is likely because you have CONFIG_UEVENT_HELPER_PATH set to some
>> non-empty path (/sbin/hotplug perhaps). This did get reported once before:
>>
> 
> CONFIG_UEVENT_HELPER_PATH is not set. In the .config we have "#
> CONFIG_UEVENT_HELPER is not set"

OK. Then I assume some quite early initcall does a request_module() or
request_firmware() (or similar). I don't think this matters - that call
would be done before the initramfs was unpacked with or without my
patch, so it won't find anything in the empty rootfs. It's just my patch
added a note. But just to figure out where that triggers, can you do

-               pr_warn_once("wait_for_initramfs() called before
rootfs_initcalls\n");
+               WARN_ONCE(1, "wait_for_initramfs() called before
rootfs_initcalls\n");

in init/initramfs.c.

>>> [    1.764430] Initramfs unpacking failed: no cpio magic
>>
>> Whoa, that's not good. Did something scramble over the initramfs memory
>> while it was being unpacked? It's been .2 seconds since the start of the
>> unpacking, so it's unlikely the very beginning of the initramfs is corrupt.
>>
>> Can you try booting with initramfs_async=0 on the command line and see
>> if the kernel still crashes?
> 
> We are not able to reproduce it 100% of the time, but sure I can try
> with this option and see what happens.
> 
> We've also seen:
> Initramfs unpacking failed: junk within compressed archive
> 
> This can be seen on the other 2 console logs that I provided the link to.

Yes, I saw that. This, and the fact that it's not 100% reproducible, is
consistent with the problem being some race that happens to write over
the compressed initramfs image - sometimes, the decompressor can still
make sense of the bits, but the output is no longer a valid cpio
archive, and sometimes already the decompressor notices the corruption.

I wonder if there is some way to mark the pages occupied by the
compressed initramfs as read-only - what would hopefully trigger a nice
crash with a backtrace to whoever writes to that memory.

Rasmus
