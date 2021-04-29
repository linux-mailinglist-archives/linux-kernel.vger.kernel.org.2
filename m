Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8B336E6FA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 10:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239837AbhD2ITm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 04:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238725AbhD2ITk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 04:19:40 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB0BC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 01:18:52 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i24so17903515edy.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 01:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0t3/AYWwDnstmvfhJm8OB4YaFoO54SBXvv5g9I4msnw=;
        b=AK7jAWwfpfDTLOpHzwPJ+JRl2KtbcbWJFym7JDw+kc1v36D9GAwql5IQD15/+xf8UW
         B0MSaivLhcilgxlFpCnNvKyYUR7w9w0RQIo7XXRW2RamOZuuJicdMkAB7zUVnXS1H8CE
         czRnDdRJ65G5G/YhSA3UYv9RSg9F6nogGSI/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0t3/AYWwDnstmvfhJm8OB4YaFoO54SBXvv5g9I4msnw=;
        b=eB16Wzct6EQSLqDCuVixcIA96BKUrJLWzuvsu2+K5zqo0slSYdsjbDyLADYNlUbZrq
         uUvCAVBFkj76gUrnNTorjpgR4yHxaUaVtXzvudzyDB1Srkz9/9Hp9oMlcOK5w1kZ/rXL
         LddYGucvksQblOdByPr1hvhPSVjuIy8s6ScxZ0mEvWMJ26ChEWGs78WOGnA/qItpvB8Z
         d3NTrNfLJqw2/15iQt95kQ/fe3nMW5Jtelld13hcaNHRJlLi2x38AxWPtvGkqw2MXXVK
         8SccaVrhwRoTscOqcXGyrucxZO9yKTJFxbPyVI7CuzUkSEOVuZEjFNkvoNdhvifXpQwP
         AzrQ==
X-Gm-Message-State: AOAM532lob5O/tznHvXElehIssskZVogH2IcRXYD1bFN0jRZW7LdxrQh
        3LOUjQ7/ViKmmiHFhwhqdyzs4avYqiEBDgnP
X-Google-Smtp-Source: ABdhPJy1HDWFyp2do0SAwho+T1W3rbzZtVKkcELtFSkUnnJoI0FD79SeOA0X7G3AbS5U7dSR1LkjPQ==
X-Received: by 2002:aa7:ce8f:: with SMTP id y15mr991813edv.148.1619684331474;
        Thu, 29 Apr 2021 01:18:51 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id z11sm1332507ejc.122.2021.04.29.01.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 01:18:50 -0700 (PDT)
Subject: Re: wait_for_initramfs warning from kernel_init_freeable()
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <c197724b-3d16-45bd-d71b-0a016196ca40@gmail.com>
 <4d6aa2dd-92df-4f36-10ac-cd003a0229f7@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <45556f52-cd2f-5512-ba65-81e4acee21ff@rasmusvillemoes.dk>
Date:   Thu, 29 Apr 2021 10:18:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <4d6aa2dd-92df-4f36-10ac-cd003a0229f7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2021 09.16, Heiner Kallweit wrote:
> On 29.04.2021 08:46, Heiner Kallweit wrote:
>> Since 97f8172f9a98 ("init/initramfs.c: do unpacking asynchronously") I get
>> the following warning early in the boot process from umh:
>> "wait_for_initramfs() called before rootfs_initcalls"
>> Some debugging lead me to the following call chain:
>>
>> kernel_init_freeable()
>> -> do_basic_setup()
>>    -> driver_init()
>>       -> platform_bus_init()
>>          -> bus_register()
>>             -> kset_register()
>>                -> kobject_uvent()
>>
> 
> Sorry, this is the first umh call, but at this time UMH_DISABLED is still set.
> The first umh call where UMH is enabled is the following:
> 
> kernel_init_freeable()
> -> do_basic_setup()
>    -> do_initcalls()
>       -> do_one_initcall()
>          -> wq_sysfs_init()         <- core_initcall()
>             -> subsys_virtual_register()
>                -> bus_register()
> 

Thanks for the report. Do you have CONFIG_UEVENT_HELPER=y and
CONFIG_UEVENT_HELPER_PATH set to a non-empty string? Assuming yes:

I did notice that on backporting those patches to an old BSP of ours,
but the other platforms I had done those patches for didn't have
UEVENT_HELPER set, so didn't know about until about a week ago.

Emitting calls to /sbin/hotplug before the initramfs has had a chance to
begin being unpacked is a complete waste of cycles (it's a _lot_ of
kernel threads being forked only to fail with -ENOENT because there's no
such binary, or any other fs contents for that matter). Just keeping
CONFIG_UEVENT_HELPER set but clearing CONFIG_UEVENT_HELPER_PATH (if
actually needed, userspace can set it appropriately later) made booting
quite noticably faster on that old and slow cpu.

So in a sense, that warning has served its purpose: drawing attention to
a deficiency in the boot process (at least with such a .config).

A few options:

(1) Do nothing, have people reconsider whether they really need
UEVENT_HELPER_PATH set.

(2) Move the usermodehelper_enable() call from do_basic_setup() to
around rootfs_initcall time. Perhaps in populate_rootfs() itself, right
after scheduling do_populate_rootfs(). And a similar call would need to
be added in default_rootfs() in noinitramfs.c for the
CONFIG_BLK_DEV_INITRD=n case. Or a separate rootfs_initcall() in
kernel/umh.c itself, if we can rely on link order to put that after
populate_rootfs.

I think (2) would eliminate the warning, but then the very first uevent
from some random device probe will cause that wait_for_initramfs(), i.e.
it will effectively end up making the initramfs unpacking synchronous
for anybody with CONFIG_UEVENT_HELPER_PATH!="". I can live with that, of
course, but OTOH it's a bit sad that they'd never have a way to know
that they could boot faster by eliminating a legacy setting from their
.config.

Rasmus
