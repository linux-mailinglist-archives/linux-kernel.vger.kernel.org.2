Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8680134D7E5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 21:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhC2TMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 15:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbhC2TMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 15:12:25 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2996C061574;
        Mon, 29 Mar 2021 12:12:24 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id x14so13503415qki.10;
        Mon, 29 Mar 2021 12:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E4uTrEptH164MGYFmqYcuDbQfqFNx44uyYKqBu1saK8=;
        b=gDVOKRVj6nXNDFpcmsn08pZsifZ2gNjRha6IVfCnrCXkTHPnef8xKVa1plnjoun4xm
         mD65F33Fl+Mz9up33guEjxSCpTmgtIrn9IS7fGaPg6SNMhZggSkUM3Vlndi8LjlBS2q9
         DmxF6IBt44zrbqzDCkPSvMt/BrM3BpLSf+vn/HjodenSCaItImANlZ0UW7DTJ6Usj/LL
         K7LPMYvGF6zvS+s8hl3mcKSRQmv46+ATz03jaILynemMVVYiex3m58oJ81uOxi7kpxC1
         RulnkYjD+oEO+WTLdo133G3jxs6OOnQO3jr1TZZOa3rwWovYSGMOZ23Mf+lne5L9kQbX
         fuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E4uTrEptH164MGYFmqYcuDbQfqFNx44uyYKqBu1saK8=;
        b=ewoBhOsZLWCwx24tsnBnIZSFU6CTJHaYLYFFEdJdt5Ab4+W5EQZXM4G8hsE7FFwXcz
         Z+Pljxd6Nrs0YbKzJC/8WjoQb8aNfoYrk92lUlox+SFbGaPOY8xCRIO99sMeBVq38CZ2
         aLCtyXJk/YXVMSz9ddUNvHU7I2FBJ9ZIa6b61Hq8XMUV1/0dCfGvi0zVxjbbJ6TwVYZr
         lL5hXosQAQaoz2IMAHi+7x+fwizjwjkPwholZWCuYnTFT3hAy1xSi42j+XaLiOwiOUsk
         whWXP+8yJSqe9WCjehbuF5/oMEav7M/kylJ+jU2JDho2O+K/J6bOuWxAANLY5HHHRrVh
         BvSw==
X-Gm-Message-State: AOAM532q+jhUyZ0FSGYnnyVcWjbwgejKZOYuGupZwfCcpiiUjgS6PtrS
        agbFIviCa7+Fpqh7fW949uw=
X-Google-Smtp-Source: ABdhPJxBMt+4OykSkpCnRhJyHmNMe8jqxlbtT5wIioAU1YEUqSiAgDHVbpvJBO+VOZEG4BFZl7qmUg==
X-Received: by 2002:a37:6348:: with SMTP id x69mr25958003qkb.154.1617045144092;
        Mon, 29 Mar 2021 12:12:24 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id i8sm11420334qtj.16.2021.03.29.12.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 12:12:23 -0700 (PDT)
Subject: Re: [PATCH] of/fdt: Improve error checking
To:     Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210327224116.69309-1-linux@roeck-us.net>
 <CAL_JsqK6r=hfXdSZhsWb72O0QMDaOPnWTiYnOjp1fvztRj865A@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <b3000300-0efe-64b9-8bba-716045b17090@gmail.com>
Date:   Mon, 29 Mar 2021 14:12:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqK6r=hfXdSZhsWb72O0QMDaOPnWTiYnOjp1fvztRj865A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/21 1:21 PM, Rob Herring wrote:
> On Sat, Mar 27, 2021 at 5:41 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> If an unaligned pointer is passed to of_fdt_unflatten_tree(),
>> populate_node() as called from unflatten_dt_nodes() will fail.
>> unflatten_dt_nodes() will return 0 and set *nodepp to NULL.
>> This is not expected to happen in __unflatten_device_tree(),
>> which then tries to write into the NULL pointer, causing a crash
>> on openrisc if CONFIG_OF_UNITTEST=y.
>>
>>  ### dt-test ### start of unittest - you will see error messages
>> Unable to handle kernel NULL pointer dereference
>>  at virtual address 0x00000064
>>
>> Oops#: 0000
>> CPU #: 0
>>    PC: c03a25d4    SR: 0000807f    SP: c102dd50
>> GPR00: 00000000 GPR01: c102dd50 GPR02: c102dd78 GPR03: c1704004
>> GPR04: 00000000 GPR05: c102dc18 GPR06: c102ddc8 GPR07: c102dcf7
>> GPR08: 00000001 GPR09: c03a25a0 GPR10: c102c000 GPR11: c16fd75c
>> GPR12: 0000ffb7 GPR13: 00000000 GPR14: 00000008 GPR15: 00000000
>> GPR16: c16fd75c GPR17: 00000064 GPR18: c1704004 GPR19: 00000004
>> GPR20: 00000000 GPR21: 00000000 GPR22: c102ddc8 GPR23: 00000018
>> GPR24: 00000001 GPR25: 00000010 GPR26: c16fd75c GPR27: 00000008
>> GPR28: deadbeef GPR29: 00000000 GPR30: c0720128 GPR31: 00060000
>>   RES: c16fd75c oGPR11: ffffffff
>> Process swapper (pid: 1, stackpage=c1028ba0)
>>
>> Stack:
>> Call trace:
>> [<(ptrval)>] __unflatten_device_tree+0xe0/0x184
>> [<(ptrval)>] of_fdt_unflatten_tree+0x60/0x90
>> [<(ptrval)>] of_unittest+0xb4/0x3614
>> [<(ptrval)>] ? __kernfs_create_file+0x130/0x188
>> [<(ptrval)>] ? sysfs_add_file_mode_ns+0x13c/0x288
>> [<(ptrval)>] ? of_unittest+0x0/0x3614
>> [<(ptrval)>] ? lock_is_held_type+0x160/0x20c
>> [<(ptrval)>] ? of_unittest+0x0/0x3614
>> [<(ptrval)>] ? ignore_unknown_bootoption+0x0/0x24
>> [<(ptrval)>] do_one_initcall+0x98/0x340
>> [<(ptrval)>] ? parse_args+0x220/0x4e4
>> [<(ptrval)>] ? lock_is_held_type+0x160/0x20c
>> [<(ptrval)>] ? ignore_unknown_bootoption+0x0/0x24
>> [<(ptrval)>] ? rcu_read_lock_sched_held+0x34/0x88
>> [<(ptrval)>] kernel_init_freeable+0x1c0/0x240
>> [<(ptrval)>] ? ignore_unknown_bootoption+0x0/0x24
>> [<(ptrval)>] ? kernel_init+0x0/0x154
>> [<(ptrval)>] kernel_init+0x1c/0x154
>> [<(ptrval)>] ? calculate_sigpending+0x54/0x64
>> [<(ptrval)>] ret_from_fork+0x1c/0x150
>>
>> This problem affects all architectures with a 4-byte memory alignment.
>> Since commit 79edff12060f ("scripts/dtc: Update to upstream version
>> v1.6.0-51-g183df9e9c2b9"), devicetree code in the Linux kernel mandates
>> an 8-byte memory alignment of devicetree pointers, but it does not take
>> into account that functions such as kmalloc() or kmemdup() may not return
>> accordingly aligned pointers.
> 
> AFAICT, openrisc would get:
> 
> #define ARCH_KMALLOC_MINALIGN __alignof__(unsigned long long)
> 
> Is that not 8 bytes?
> 
> Specifically, the problem is here is the unittest DT is copied with
> kmemdup(). I don't think there are other allocations which could be a
> problem.
> 
>> To fix the immediate crash, check if *mynodes is NULL in
>> __unflatten_device_tree() before writing into it.
>>
>> Also affected by this problem is the code calling of_fdt_unflatten_tree().
>> That code checks for errors using the content of the mynodes pointer,
>> which is not set by the devicetree code if the alignment problem is
>> observed. Result is that the callers of of_fdt_unflatten_tree() check
>> if an uninitialized pointer is set to NULL. Preinitialize that pointer
>> to avoid the problem.
>>
>> With this code in place, devicetree code on openrisc (and any other
> 
> "devicetree unittest code"
> 
> The only other dtb copy is unflatten_and_copy_device_tree() which
> should be fine since it gives memblock the alignment requirement.

Plus overlays does at least one other copy.

I'll create a patch this week to properly align copies and to add some
of the checks suggested below based on the principal that a test should
not crash the kernel.

-Frank

> 
>> architecture with 4-byte memory alignment) will still not work properly,
>> but at least it won't crash anymore. The resulting log message is
>>
>>  ### dt-test ### start of unittest - you will see error messages
>>  ### dt-test ### unittest_data_add: No tree to attach; not running tests
>>
>> when trying to run devicetree unittests.
>>
>> Fixes: 79edff12060f ("scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9")
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>  drivers/of/fdt.c      | 2 +-
>>  drivers/of/overlay.c  | 2 +-
>>  drivers/of/unittest.c | 2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index dcc1dd96911a..ab95fdb4461d 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -415,7 +415,7 @@ void *__unflatten_device_tree(const void *blob,
>>                 pr_warn("End of tree marker overwritten: %08x\n",
>>                         be32_to_cpup(mem + size));
>>
>> -       if (detached && mynodes) {
>> +       if (detached && mynodes && *mynodes) {
>>                 of_node_set_flag(*mynodes, OF_DETACHED);
>>                 pr_debug("unflattened tree is detached\n");
>>         }
>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>> index 50bbe0edf538..e12c643b6ba8 100644
>> --- a/drivers/of/overlay.c
>> +++ b/drivers/of/overlay.c
>> @@ -1017,7 +1017,7 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
>>         const void *new_fdt;
>>         int ret;
>>         u32 size;
>> -       struct device_node *overlay_root;
>> +       struct device_node *overlay_root = NULL;
>>
>>         *ovcs_id = 0;
>>         ret = 0;
>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>> index eb100627c186..5dc4d2378bfd 100644
>> --- a/drivers/of/unittest.c
>> +++ b/drivers/of/unittest.c
>> @@ -1408,7 +1408,7 @@ static void attach_node_and_children(struct device_node *np)
>>  static int __init unittest_data_add(void)
>>  {
>>         void *unittest_data;
>> -       struct device_node *unittest_data_node, *np;
>> +       struct device_node *unittest_data_node = NULL, *np;
>>         /*
>>          * __dtb_testcases_begin[] and __dtb_testcases_end[] are magically
>>          * created by cmd_dt_S_dtb in scripts/Makefile.lib
>> --
>> 2.17.1
>>

