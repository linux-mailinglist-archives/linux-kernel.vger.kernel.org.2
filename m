Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080713F5354
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 00:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbhHWWW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 18:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhHWWWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 18:22:24 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF14C061575;
        Mon, 23 Aug 2021 15:21:41 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id m21so20937568qkm.13;
        Mon, 23 Aug 2021 15:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HLncdCZm4AaQl837iBmELtagHV4+U9f/suIhohULQ1Y=;
        b=VEjFZmeoeNXqx8JnC17/FpduiINrAlEL0FnNf0hgWHwqQR52abwWUzDQyD6s507fy9
         N2EhGo74RNW9It4YmpZyercXf+5KTNJ1xlV9RAhhxAwD8dbDFeBg1Rp4xFj58pDmXX8S
         y0SiQA8E0WLy1IyH49md9aR8NZQE0m7Bcf1m8d6+PKpsDuWMjuxzZTc7dOz403uQFJDN
         2mJFKO9ba4mbi4PlLTpKjAYV/seVit+ci1vzi08h3F4YOwYC6udKWJNftqrBORDe1LVw
         FnZ+wLQvHYHL5u9AVjBCf6OX/73CFiutPOAxVoMCCLXNAq2lc684b/3NbIx1mbkW4pzi
         LYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HLncdCZm4AaQl837iBmELtagHV4+U9f/suIhohULQ1Y=;
        b=CojenJ4yQZEDXimkpg7tlNY0vsQY7IJhq3MVtFPCdrxYurGTtZbAq1RpoI1/ZriL3b
         OHhfiIghY6ZV5O6Me7UH+KDZ1hCl+3TfwL140heWWrX1hs7+5ZvDAr9Ucii7orp0MSDA
         7RUJ3lhFwve31v/ZlFmcSBQ1dDf+/pdHdjv0Emqny33nuTtMZYFo9ujtt6DOnOQI8SnO
         JBjY+7iYACs1xLTCvRuzfBmYWC2XMpohAVowe4DPWml9IA23Bm2tIlzcmMuPYatxcR1N
         PO4tOehQC/cattIfu6SxujbpBx2TKf1Qx2yE5sP7Dq/C+Vkv4jsO8AQSEGySSx3HTvIF
         8mXA==
X-Gm-Message-State: AOAM533dQW00aSx358Nb9djoSnuKbZGEY9xMgw5ZgQgiBtX9/uF8WJDh
        Sg0k7V92EaN3H8sWnuIlaDQ=
X-Google-Smtp-Source: ABdhPJwEodtAaD+p7AhXCVw7kvMQjWSk4ixD7xWKv2gVTMLBxAOIinPiHWq4RHIz6owPMyICGfPdhA==
X-Received: by 2002:a37:b586:: with SMTP id e128mr23417705qkf.43.1629757300431;
        Mon, 23 Aug 2021 15:21:40 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id m8sm9268077qkk.130.2021.08.23.15.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 15:21:40 -0700 (PDT)
Subject: Re: [PATCH] of: Don't allow __of_attached_node_sysfs() without
 CONFIG_SYSFS
To:     Rob Herring <robh@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>
References: <20210820144722.169226-1-maz@kernel.org>
 <a67743f9-869b-28df-d714-db15da4ebe06@gmail.com>
 <YSPtI//SJh1CpHRP@robh.at.kernel.org>
 <bcb2e89f-9768-8435-35d9-d02140628b9a@gmail.com>
 <CAL_JsqJs2ayHFpOo7kS4K96Sy3xDkxeWYNMTDF9Ssd9D79LKng@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <d7548302-7e70-9a93-750c-a4de359eac0b@gmail.com>
Date:   Mon, 23 Aug 2021 17:21:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJs2ayHFpOo7kS4K96Sy3xDkxeWYNMTDF9Ssd9D79LKng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/21 5:14 PM, Rob Herring wrote:
> On Mon, Aug 23, 2021 at 4:27 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 8/23/21 1:46 PM, Rob Herring wrote:
>>> On Sun, Aug 22, 2021 at 11:01:15PM -0500, Frank Rowand wrote:
>>>> Hi Marc,
>>>>
>>>> On 8/20/21 9:47 AM, Marc Zyngier wrote:
>>>>> Trying to boot without SYSFS, but with OF_DYNAMIC quickly
>>>>> results in a crash:
>>>>>
>>>>> [    0.088460] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070
>>>>> [...]
>>>>> [    0.103927] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.14.0-rc3 #4179
>>>>> [    0.105810] Hardware name: linux,dummy-virt (DT)
>>>>> [  0.107147] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
>>>>> [    0.108876] pc : kernfs_find_and_get_ns+0x3c/0x7c
>>>>> [    0.110244] lr : kernfs_find_and_get_ns+0x3c/0x7c
>>>>> [...]
>>>>> [    0.134087] Call trace:
>>>>> [    0.134800]  kernfs_find_and_get_ns+0x3c/0x7c
>>>>> [    0.136054]  safe_name+0x4c/0xd0
>>>>> [    0.136994]  __of_attach_node_sysfs+0xf8/0x124
>>>>> [    0.138287]  of_core_init+0x90/0xfc
>>>>> [    0.139296]  driver_init+0x30/0x4c
>>>>> [    0.140283]  kernel_init_freeable+0x160/0x1b8
>>>>> [    0.141543]  kernel_init+0x30/0x140
>>>>> [    0.142561]  ret_from_fork+0x10/0x18
>>>>>
>>>>> While not having sysfs isn't a very common option these days,
>>>>> it is still expected that such configuration would work.
>>>>>
>>>>> Paper over it by bailing out from __of_attach_node_sysfs() if
>>>>> CONFIG_SYSFS isn't enabled.
>>>>
>>>> CONFIG_SYSFS should be automatically selected when CONFIG_OF_DYNAMIC
>>>> is enabled, and it should not be possible to disable CONFIG_SYSFS
>>>> in this case.
>>>
>>> That used to be true, but isn't now.
>>
>> OK.  I agree with you, but when I investigated the original patch
>> email I came to a different conclusion because of the way that I
>> used make menuconfig to debug the situation.
>>
>> It is true when I start with a .config created from 'make qcom_defconfig',
>> then select OF_UNITTEST, which is the only way I can see OF_DYNAMIC.  It
>> is the "if OF_UNITTEST" that means SYSFS can not be disabled.
> 
> Not really. Disabling SYSFS has nothing to do with the DT code. It's
> not super easy though. It required setting EXPERT and disabling
> CONFIGFS_FS and things selecting it (PCIE endpoint and USB gadget).
> 
>> If I start with the .config that Marc supplied, then make menuconfig
>> still does not show the OC_DYNAMIC option, but leaves it set since
>> it was already set.  In this case SYSFS remains disabled because
>> OF_UNITTEST is also disabled.
> 
> I don't see the relationship between SYSFS and OF_UNITTEST.

I don't either.  Other than the results of experimenting showing
that if I enable OF_UNITTEST then I can no long disable SYSFS.

> 
>> Using '/OF_DYNAMIC' from within make menuconfig, to get more info
>> about OF_DYNAMIC tells me that the prompt for OF_DYNAMIC is visible
>> if OF && OF_UNITTEST.  This is due to the "if OF_UNITTEST" in line 58
>> of drivers/of/Kconfig in the OF_DYNAMIC specification.
>>
>> Thus I can't figure out how to use make menuconfig to set OF_DYNAMIC
>> without setting OF_UNITTEST.  I tried setting OF_UNITTEST, then setting
>> OF_DYNAMIC, saving the changes, then another make menuconfig to
>> disable OF_UNITTEST, which then has the side effect of unsetting
>> OF_DYNAMIC.
> 
> Selecting OF_OVERLAY also.
> 
>> Would you accept a patch that removes the "if OF_UNITTEST" from
>> the Kconfig entry for OF_DYNAMIC?
> 
> I guess. The purpose of making it visible was for compile testing, so
> maybe make it 'if COMPILE_TEST' instead?

After thinking a bit, I didn't like my original suggestion.
I'll think some more, but I think that I will not follow up
on my original suggestion.

> 
> 
> Looking at occurrences of CONFIG_OF_DYNAMIC, there's more than I'd
> like. This for example is a common pattern:
> 
> drivers/spi/spi.c:      if (IS_ENABLED(CONFIG_OF_DYNAMIC))
> drivers/spi/spi.c-
> WARN_ON(of_reconfig_notifier_register(&spi_of_notifier));
> 
> Really, of_reconfig_notifier_register() should just return 0 if
> !IS_ENABLED(CONFIG_OF_DYNAMIC).

I'll add researching use of CONFIG_OF_DYNAMIC to my todo list.

-Frank

> 
> Rob
> 

