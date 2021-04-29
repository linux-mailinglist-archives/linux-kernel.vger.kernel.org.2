Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A301E36E768
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 10:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240121AbhD2IxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 04:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240062AbhD2IxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 04:53:12 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6E2C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 01:52:24 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a4so66014123wrr.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 01:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nXLJ5tx4I5RvtzsCbmzZK9Lpxaqm0WKzKj5pd8iwmQo=;
        b=amzpAJVpeJkeraW0pn507yYn3T6yu0dYXiuYetFqZkngEdUAZG4yYU0kOPus06Crg8
         xqcn1xiYdhu8D4m2d0WscPP/S0rLJ/jc/FMc/w3Qm3sokncG+sLfU2/cyB/lonY5ziJJ
         rLtuLQgY+eoGh4uhOpY2cLjA4CeZKB3YhUggo6/MSRvbS6UUbzrg2iLo7OAhocZTSk7r
         Cxyk17UFLlO6zWc1zPCKzuIDpuKpQ3SdS2ULBxPAaicf1q2SNnPZMuLSJzVZCRDDUtlG
         axdO5CWANACoBrKPAbC4Cv9f87fEvG4+Zt8fF0SY19UAD/cejEtY0Cpi1q0rm8wk3zAR
         DLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nXLJ5tx4I5RvtzsCbmzZK9Lpxaqm0WKzKj5pd8iwmQo=;
        b=TG07TujDNglhWrTu5wdj1q+DbCaWDNlXYhOgismM5uRbe5vAFK+d2a/vRe2qtHMetp
         SQVFSpSK8dw5qwrGSDLOWpifCZ/uSS3RGFYL3xKGG/ntcJIJq/2uSdIwxHJPUqgRUZml
         nGZl+xjfepow66Gz7ttXvESnLdKYZPXxICC/Kq30gLL/DNvYV48DkkkG5f8EQM0Jllyz
         oCtiPTJ4H9OpENL0GpWwamZ2vDhBD13c9SzzKGQH/7fgHE7DAnwWPxDPBsTlydsnX4G8
         gZ411bAXP7yRRRyr8BRAN3Ri797RNT3uPhOXIIx9zYZxB23vYgeC3ivZhUwWKMokJVoF
         9icg==
X-Gm-Message-State: AOAM530lJ24QmB34uDa/31v+GCzuP4qdo8E0an8tgFDys21FihlifbrU
        GqRemPrS4/uDX5QTJ6I1gls=
X-Google-Smtp-Source: ABdhPJzSBOJAZQSIGoyECppUW2sF9AMEl56jzRkS1Ot9sB/ApqdudHaQlNZwjRmeSPm+UirJcQSbsg==
X-Received: by 2002:adf:ffc4:: with SMTP id x4mr1978162wrs.415.1619686343451;
        Thu, 29 Apr 2021 01:52:23 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:cd3e:54f2:98f5:2e97? (p200300ea8f384600cd3e54f298f52e97.dip0.t-ipconnect.de. [2003:ea:8f38:4600:cd3e:54f2:98f5:2e97])
        by smtp.googlemail.com with ESMTPSA id x8sm3718892wrs.25.2021.04.29.01.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 01:52:23 -0700 (PDT)
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <c197724b-3d16-45bd-d71b-0a016196ca40@gmail.com>
 <4d6aa2dd-92df-4f36-10ac-cd003a0229f7@gmail.com>
 <45556f52-cd2f-5512-ba65-81e4acee21ff@rasmusvillemoes.dk>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: wait_for_initramfs warning from kernel_init_freeable()
Message-ID: <9849be80-cfe5-b33e-8224-590a4c451415@gmail.com>
Date:   Thu, 29 Apr 2021 10:52:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <45556f52-cd2f-5512-ba65-81e4acee21ff@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.04.2021 10:18, Rasmus Villemoes wrote:
> On 29/04/2021 09.16, Heiner Kallweit wrote:
>> On 29.04.2021 08:46, Heiner Kallweit wrote:
>>> Since 97f8172f9a98 ("init/initramfs.c: do unpacking asynchronously") I get
>>> the following warning early in the boot process from umh:
>>> "wait_for_initramfs() called before rootfs_initcalls"
>>> Some debugging lead me to the following call chain:
>>>
>>> kernel_init_freeable()
>>> -> do_basic_setup()
>>>    -> driver_init()
>>>       -> platform_bus_init()
>>>          -> bus_register()
>>>             -> kset_register()
>>>                -> kobject_uvent()
>>>
>>
>> Sorry, this is the first umh call, but at this time UMH_DISABLED is still set.
>> The first umh call where UMH is enabled is the following:
>>
>> kernel_init_freeable()
>> -> do_basic_setup()
>>    -> do_initcalls()
>>       -> do_one_initcall()
>>          -> wq_sysfs_init()         <- core_initcall()
>>             -> subsys_virtual_register()
>>                -> bus_register()
>>
> 
> Thanks for the report. Do you have CONFIG_UEVENT_HELPER=y and
> CONFIG_UEVENT_HELPER_PATH set to a non-empty string? Assuming yes:
> 

Thanks for the prompt response. Yes, that's the config here:

CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"

I now disabled CONFIG_UEVENT_HELPER and don't have the warning
any longer. Maybe, what could be done so that you don't have to
explain the same thing a hundred times to people like me:

In case the warning is harmless, make it info or notice and add
a hint like this to the message "please reconsider whether you
really need config option CONFIG_UEVENT_HELPER".

> I did notice that on backporting those patches to an old BSP of ours,
> but the other platforms I had done those patches for didn't have
> UEVENT_HELPER set, so didn't know about until about a week ago.
> 
> Emitting calls to /sbin/hotplug before the initramfs has had a chance to
> begin being unpacked is a complete waste of cycles (it's a _lot_ of
> kernel threads being forked only to fail with -ENOENT because there's no
> such binary, or any other fs contents for that matter). Just keeping
> CONFIG_UEVENT_HELPER set but clearing CONFIG_UEVENT_HELPER_PATH (if
> actually needed, userspace can set it appropriately later) made booting
> quite noticably faster on that old and slow cpu.
> 
> So in a sense, that warning has served its purpose: drawing attention to
> a deficiency in the boot process (at least with such a .config).
> 
> A few options:
> 
> (1) Do nothing, have people reconsider whether they really need
> UEVENT_HELPER_PATH set.
> 
> (2) Move the usermodehelper_enable() call from do_basic_setup() to
> around rootfs_initcall time. Perhaps in populate_rootfs() itself, right
> after scheduling do_populate_rootfs(). And a similar call would need to
> be added in default_rootfs() in noinitramfs.c for the
> CONFIG_BLK_DEV_INITRD=n case. Or a separate rootfs_initcall() in
> kernel/umh.c itself, if we can rely on link order to put that after
> populate_rootfs.
> 
> I think (2) would eliminate the warning, but then the very first uevent
> from some random device probe will cause that wait_for_initramfs(), i.e.
> it will effectively end up making the initramfs unpacking synchronous
> for anybody with CONFIG_UEVENT_HELPER_PATH!="". I can live with that, of
> course, but OTOH it's a bit sad that they'd never have a way to know
> that they could boot faster by eliminating a legacy setting from their
> .config.
> 
> Rasmus
> 

Heiner
