Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C2E34D84E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 21:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhC2Tdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 15:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhC2TdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 15:33:17 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E466C061574;
        Mon, 29 Mar 2021 12:33:16 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id f9so14136094oiw.5;
        Mon, 29 Mar 2021 12:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jPScsdRkQfFjP+HYKirx6Bz5sPBqP9dzj9KzBot1OO8=;
        b=l1LjTiWsLuGSCfzvRxju8eWyfJE4nZL1WoqxzQ8O34pXA1i0vlyCjNUSO9h2xF9m5q
         5nYg4U8dnZrOFN21WSOa2uTPaLiJeiI5szmYPORfqoHI02xv89GCQqBrDeLbmnhi4Ulh
         3qLDJW+w21l4Jz0t6zBKmZEc5Nc+ki3lpkTAqyfyZsqtQbBmE503rZJKzwmyknYFKydr
         uEZE4I1dvAO29bxjfppYRguWpw/4T5f+/rj3TljaRFboDknP5/rWDUim8ldKN30xjQKA
         oKWJdO3UMACEre6HqNx2cdf1MUvyLa05djhX09K+Y1VTqZ9uBgjpgbkQFD9N+seDynDq
         fNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jPScsdRkQfFjP+HYKirx6Bz5sPBqP9dzj9KzBot1OO8=;
        b=KpyYj1SqR+1kpa6hqBj/SZ2F070v2Ks7EKqQ3WAHybSkuQlNbiCFlsCJDoQSg/2pm5
         eE0GDp4gcaSosIhNz6ow212XxAiFgC1jM85TLSzrareF6ChmJrpHPJ4a5Iqrkki6XvgH
         riL/gRB79BWWxE75zSxIHPMmi3/Dm7dEgPTlWFNPbKwthc/mSgaIDXBa3RPuDkwU4vKM
         6yrlAsDLkZjMSCgwNdNu4qjnl9LdgIuJ02RPgZvu0clUB+4aKNqw9bKrKaczMwWsZCVk
         jdlvWNdIO+ImTXeCiA2gMyGugCILe4fPzQau84EhKkloMThmJM+ykDXOomuhu+YHN3G5
         QBgg==
X-Gm-Message-State: AOAM5315Jl/CjAy+aBkk3lX/DCOnUoJ7Rb9eVWZuKyWyOlYq1IYoLVia
        Lko5FAMuwWp9cjWlMsE5XkRxZW539aQ=
X-Google-Smtp-Source: ABdhPJxmz6VMDuVEjaxY+xsVkCuL589ETKpl8DRnRVp55MLg4ryeGtf1JXVpHEuOrwa2nUn/RaQeHg==
X-Received: by 2002:aca:1204:: with SMTP id 4mr508824ois.92.1617046395435;
        Mon, 29 Mar 2021 12:33:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g84sm3701155oia.45.2021.03.29.12.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 12:33:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] of/fdt: Improve error checking
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210327224116.69309-1-linux@roeck-us.net>
 <CAL_JsqK6r=hfXdSZhsWb72O0QMDaOPnWTiYnOjp1fvztRj865A@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <9d720238-fd72-f38e-be3c-ec9f66d95ebb@roeck-us.net>
Date:   Mon, 29 Mar 2021 12:33:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqK6r=hfXdSZhsWb72O0QMDaOPnWTiYnOjp1fvztRj865A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/21 11:21 AM, Rob Herring wrote:
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
No. I checked. Quite surprisingly, it is 4. sizeof(unsigned long long)
is 8, though.

> Specifically, the problem is here is the unittest DT is copied with
> kmemdup(). I don't think there are other allocations which could be a
> problem.
> 

Plus, as Frank points out, there is a copy in overlays, and I wasn't
sure if the other uses of kmalloc()/kmemdup() in devicetree code are safe.
That is why I didn't try to fix that.

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
> 
Plus overlays.

Thanks,
Guenter
