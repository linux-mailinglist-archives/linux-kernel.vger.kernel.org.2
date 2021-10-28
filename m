Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB05943E6CB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 19:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhJ1RIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 13:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhJ1RIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 13:08:42 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A47C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 10:06:13 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id t4so9204645oie.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 10:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e5KNPZxNeZtoiEhNDxXzYxF8UtewY2CZGnIOL3VP3EE=;
        b=Z00Rnuis3pg7ZDGh8CeIcmpwWQ1DRNCDOYjd8IDsN2FGNJL0tyZWYiESdckxETpLX6
         keaGl/IujgxJnMvvzZ+v4Clb96u+DLMBAxXTxGz3inxxYAUnZp8w28aAAWxIl0+jby/x
         icYCTUV/htCxF7PoDROn6qmo3PXRIfhUkfy4V+tkJkbsnmpT99cflqPUTlf/oPdSRcfk
         NitPQ6Ij3Ba+PiXH9ZD19ZYyQw3yRe0P5sAZBVANUpYwWtZVrGG7D0mfHrKa6KXiqzVW
         +fzWta51PTNi2WJuHhQ1nummslT25WJEL+k84utoc0gd+9FV2tKceqOFD2imJhAXCO9A
         wmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e5KNPZxNeZtoiEhNDxXzYxF8UtewY2CZGnIOL3VP3EE=;
        b=Yk9I5/kECeimWZP98O2ULaGAJQdA+fC+1hJWin+zvGo3efw4OH12ltfh11V6Vp/J3A
         kRVfxTj3ps34qs+EKuba+n8zd6OUFQ8J3+JgNBaMhy0qRavHMpcih4w1St9CMu9v8BS4
         i9+Dzuaw6IpZioZ7fPrlwAwq6rYKFWwVmmHBO6s+NvAvBmnRHtG9zETlGnYtHr4Gd7IU
         pQ5dnP3bKIrg9+qxJi+W9U3GHC7I5wBkNw6qwdcIcTk6466kzn4zCprrrckKHDKmN3+N
         7blcRJSEpojqzVSoWZiGjn0sT+hK+VpQRbWGjkx9z6TYcntF5ZtrB8MxS7nR7l1O2iGh
         OGag==
X-Gm-Message-State: AOAM531svHeR6sXLZ60pTK3mM4HIcmRYEU4xy3zmumNfGlSnagKk/qMT
        LI79f6YJtSfugyh/N/tHgh/TJ/9j89I=
X-Google-Smtp-Source: ABdhPJyZwdrT2lpGkI5p1bDzcLb262ljBKfvCpWF1bwgTGglus+FRI0SktU9C7PeYiVOqQ9W5M5arQ==
X-Received: by 2002:a05:6808:f8f:: with SMTP id o15mr3747358oiw.137.1635440773153;
        Thu, 28 Oct 2021 10:06:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w22sm226409otp.50.2021.10.28.10.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 10:06:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20211027150324.79827-1-andriy.shevchenko@linux.intel.com>
 <20211028153055.GA440866@roeck-us.net> <YXrIlT+2llnwgRpj@smile.fi.intel.com>
 <20211028162810.GB470146@roeck-us.net> <YXrUu8swbM3BL/4C@smile.fi.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1 1/1] delay: Replace kernel.h with the necessary
 inclusions
Message-ID: <6ddfca96-22d5-49f0-26ee-11ff36e3dac1@roeck-us.net>
Date:   Thu, 28 Oct 2021 10:06:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXrUu8swbM3BL/4C@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/21 9:50 AM, Andy Shevchenko wrote:
> On Thu, Oct 28, 2021 at 09:28:10AM -0700, Guenter Roeck wrote:
>> On Thu, Oct 28, 2021 at 06:58:13PM +0300, Andy Shevchenko wrote:
>>> On Thu, Oct 28, 2021 at 08:30:55AM -0700, Guenter Roeck wrote:
>>>> On Wed, Oct 27, 2021 at 06:03:24PM +0300, Andy Shevchenko wrote:
>>>>> When kernel.h is used in the headers it adds a lot into dependency hell,
>>>>> especially when there are circular dependencies are involved.
>>>>>
>>>>> Replace kernel.h inclusion with the list of what is really being used.
>>>>>
>>>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>>
>>>> In next-20211028:
>>>>
>>>> Building riscv32:defconfig ... failed
>>>> --------------
>>>> Error log:
>>>> arch/riscv/lib/delay.c: In function '__delay':
>>>> arch/riscv/lib/delay.c:77:17: error: implicit declaration of function 'cpu_relax'
>>>>
>>>> Building riscv:defconfig ... failed
>>>> --------------
>>>> Error log:
>>>> arch/riscv/lib/delay.c: In function '__delay':
>>>> arch/riscv/lib/delay.c:77:17: error: implicit declaration of function 'cpu_relax'
>>>>
>>>> Building s390:defconfig ... failed
>>>> --------------
>>>> Error log:
>>>> <stdin>:1559:2: warning: #warning syscall futex_waitv not implemented [-Wcpp]
>>>> In file included from arch/s390/pci/pci_insn.c:12:
>>>> arch/s390/include/asm/facility.h: In function '__stfle':
>>>> arch/s390/include/asm/facility.h:98:22: error: implicit declaration of function 'min_t'
>>>>
>>>> bisect to this patch. Probably more, but it is difficult to find out
>>>> since -next is too badly broken and has build failures all over the place.
>>>
>>> Thanks for the report!
> 
> I'll send the fix for above soon. Hope it will reduce amount of failures.
> 
>>> I have run it on x86_64 with `kcbench -m ...` and no failures.
>>>
>>> Can you share all build errors you found so far? I believe none of them related
>>> to x86* code.
>>>
>>> Above just revealed the problematic places in the first place. Why the
>>> programmers rely on delay.h to include full bloated header pile?! (Yeah, this
>>> is rhetorical, so please share the errors, I'll try to address them)
>>
>> The ones listed above are the ones I was able to identify. As I said, there
>> are so many compile and runtime failures in linux-next that it is difficult
>> to track down individual failures.
> 
> Yeah, for example, I looked into this: https://kerneltests.org/builders/next-mips-next/builds/698/steps/buildcommand/logs/stdio
> 
> I can't see how my patch is related to this...
> 

The missing errno.h in that log is due to missing dependencies in the
fanotify patch - it causes build failures whenever a toolchain without
C library support is used to build the kernel. I already reported this.

The unused variable error bisects to 'irq: mips: simplify do_domain_IRQ()'.
I'll send a report as response to that patch in a minute.

It all adds up ... there seem to be a lot of last minute changes in -next.

Guenter

>> Just to give you an idea (this is for
>> next-20211028):
>>
>> Build results:
>> 	total: 153 pass: 115 fail: 38
>> Failed builds:
>> 	alpha:allmodconfig
>> 	arm:allmodconfig
>> 	arm:omap2plus_defconfig
>> 	arm:davinci_all_defconfig
>> 	arm64:defconfig
>> 	arm64:allmodconfig
>> 	csky:allmodconfig
>> 	h8300:allnoconfig
>> 	h8300:tinyconfig
>> 	h8300:edosk2674_defconfig
>> 	h8300:h8300h-sim_defconfig
>> 	h8300:h8s-sim_defconfig
>> 	m68k:allmodconfig
>> 	mips:defconfig
>> 	mips:allmodconfig
>> 	mips:allnoconfig
>> 	mips:tinyconfig
>> 	mips:bcm47xx_defconfig
>> 	mips:bcm63xx_defconfig
>> 	mips:ath79_defconfig
>> 	mips:ar7_defconfig
>> 	mips:e55_defconfig
>> 	mips:cavium_octeon_defconfig
>> 	mips:malta_defconfig
>> 	mips:rt305x_defconfig
>> 	nds32:allmodconfig
>> 	parisc:allmodconfig
>> 	parisc:generic-32bit_defconfig
>> 	parisc64:generic-64bit_defconfig
>> 	powerpc:allmodconfig
>> 	riscv32:defconfig
>> 	riscv32:allmodconfig
>> 	riscv:defconfig
>> 	riscv:allmodconfig
>> 	s390:defconfig
>> 	s390:allmodconfig
>> 	sparc64:allmodconfig
>> 	xtensa:allmodconfig
>> Qemu test results:
>> 	total: 480 pass: 315 fail: 165
>> Failed tests:
>> 	<too many to list them all>
>>
>> Build and boot logs are as always at https://kerneltests.org/builders
>> in the 'next' column in case you want to do some digging yourself.
> 

