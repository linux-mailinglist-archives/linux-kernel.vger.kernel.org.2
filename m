Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFA7358665
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 16:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbhDHOLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 10:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbhDHOKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:10:21 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9096EC0613E4;
        Thu,  8 Apr 2021 07:09:28 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id q26so2263230qkm.6;
        Thu, 08 Apr 2021 07:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D35vG+GFQnJEkJROe6CeINxAyK+vyOjFLJcd1IZ+fyM=;
        b=mMpn4+ea2tGeJuZko6smebAWsLPuBt4B+73VF+2hGlFZ0FI/TShU3oKIte3vPCNW84
         NUbvTK9fLuZlhQgcfQ5IwjZ2FpWu04X2f5VweR8UgHLF0/phmSirQKz4sIERD5k510KX
         VE/XTcS+vOGt2g+fPnYKrgIdzxDkLWdl9QsYvlrzOaH4LTwq6uQ03tjs36QosWYdnSho
         ij8YBfqmTJwKKdzZf6ByoieZXESlHHkIaFtSdgYcVPnV4yMfxW5AQvgX7s+bUZAikgL7
         WS65QGrD7KR41um963v+7I3nTukXQb/BKyTu4n6GaBy+RwUs4onR6mP3kPYe3D9snRy/
         Hrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D35vG+GFQnJEkJROe6CeINxAyK+vyOjFLJcd1IZ+fyM=;
        b=dKwwa/OGt9wn49Jy5afGS4hyM8qgEVouuCjASTwgCk7H6Zy+yeTBeoEmDKiT3YyI17
         EOZ9ZRoYnWkytDuD0ImzUDR18fPz3S8298LL/U2FFa+xq3RTo8d0jVeOFOUbVX4xLHPr
         qcJp1oWKXX8yoZCjVdMmu9hI+MdO8DqIpiuYc+eEux8NIEsV8Go4jWB5ETSHbBU4Noc8
         /A75tMDo3KlpWlcoJlbcKKlmz8hLQBvgkJQD+hepUCxU914jiBsGNm8zwFwRZ8APfF0a
         j3QzguW0gYmkktw2QkqawliBP7Y3Rm/WmJsOWYgVooPuu6nErsfvyR6sv/y6UzqVAAcI
         1HSw==
X-Gm-Message-State: AOAM531I9fOVmqHDeYSsXRgyVHcimQYjlo+cCiFBEBUkYyIAP5CaFolE
        R/5LOMEzVKfGrQP6liJKIUk=
X-Google-Smtp-Source: ABdhPJwUcu7pILU4/dP2shOPap0HHxubwQ4oTD5yiHRyUmpA3QnJCmNCzvBCvPzbk/5sxDnZE9o6gw==
X-Received: by 2002:a05:620a:244f:: with SMTP id h15mr2572178qkn.235.1617890967110;
        Thu, 08 Apr 2021 07:09:27 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id z89sm19259990qtd.5.2021.04.08.07.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 07:09:26 -0700 (PDT)
Subject: Re: [PATCH 1/1] of: unittest: overlay: ensure proper alignment of
 copied FDT
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210407205110.2173976-1-frowand.list@gmail.com>
 <CAL_Jsq+UORLXYh_v8WzAq_hH+-s0qjp0r_jObmaEK+yAh299hw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <4024cca5-b32c-6705-d97a-55b0bdca6c41@gmail.com>
Date:   Thu, 8 Apr 2021 09:09:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+UORLXYh_v8WzAq_hH+-s0qjp0r_jObmaEK+yAh299hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/21 4:34 PM, Rob Herring wrote:
> On Wed, Apr 7, 2021 at 3:51 PM <frowand.list@gmail.com> wrote:
>>
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> The Devicetree standard specifies an 8 byte alignment of the FDT.
>> Code in libfdt expects this alignment for an FDT image in memory.
>> kmemdup() returns 4 byte alignment on openrisc.  Replace kmemdup()
>> with kmalloc(), align pointer, memcpy() to get proper alignment.
>>
>> The 4 byte alignment exposed a related bug which triggered a crash
>> on openrisc with:
>> commit 79edff12060f ("scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9")
>> as reported in:
>> https://lore.kernel.org/lkml/20210327224116.69309-1-linux@roeck-us.net/
>>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>  drivers/of/of_private.h | 2 ++
>>  drivers/of/overlay.c    | 8 ++++++--
>>  drivers/of/unittest.c   | 9 +++++++--
>>  3 files changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
>> index d9e6a324de0a..d717efbd637d 100644
>> --- a/drivers/of/of_private.h
>> +++ b/drivers/of/of_private.h
>> @@ -8,6 +8,8 @@
>>   * Copyright (C) 1996-2005 Paul Mackerras.
>>   */
>>
>> +#define FDT_ALIGN_SIZE 8
>> +
>>  /**
>>   * struct alias_prop - Alias property in 'aliases' node
>>   * @link:      List node to link the structure in aliases_lookup list
>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>> index 50bbe0edf538..8b40711ed202 100644
>> --- a/drivers/of/overlay.c
>> +++ b/drivers/of/overlay.c
>> @@ -1014,7 +1014,7 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
>>  int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
>>                          int *ovcs_id)
>>  {
>> -       const void *new_fdt;
>> +       void *new_fdt;
>>         int ret;
>>         u32 size;
>>         struct device_node *overlay_root;
>> @@ -1036,10 +1036,14 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
>>          * Must create permanent copy of FDT because of_fdt_unflatten_tree()
>>          * will create pointers to the passed in FDT in the unflattened tree.
>>          */
>> -       new_fdt = kmemdup(overlay_fdt, size, GFP_KERNEL);
>> +       size += FDT_ALIGN_SIZE;
>> +       new_fdt = kmalloc(size, GFP_KERNEL);
>>         if (!new_fdt)
>>                 return -ENOMEM;
>>
>> +       new_fdt = PTR_ALIGN(new_fdt, FDT_ALIGN_SIZE);
>> +       memcpy(new_fdt, overlay_fdt, size);
>> +
>>         of_fdt_unflatten_tree(new_fdt, NULL, &overlay_root);
>>         if (!overlay_root) {
>>                 pr_err("unable to unflatten overlay_fdt\n");
>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>> index eb100627c186..edd6ce807691 100644
>> --- a/drivers/of/unittest.c
>> +++ b/drivers/of/unittest.c
>> @@ -22,6 +22,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/device.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/kernel.h>
>>
>>  #include <linux/i2c.h>
>>  #include <linux/i2c-mux.h>
>> @@ -1415,7 +1416,7 @@ static int __init unittest_data_add(void)
>>          */
>>         extern uint8_t __dtb_testcases_begin[];
>>         extern uint8_t __dtb_testcases_end[];
>> -       const int size = __dtb_testcases_end - __dtb_testcases_begin;
>> +       u32 size = __dtb_testcases_end - __dtb_testcases_begin;
>>         int rc;
>>
>>         if (!size) {
>> @@ -1425,10 +1426,14 @@ static int __init unittest_data_add(void)
>>         }
>>
>>         /* creating copy */
>> -       unittest_data = kmemdup(__dtb_testcases_begin, size, GFP_KERNEL);
>> +       size += FDT_ALIGN_SIZE;
>> +       unittest_data = kmalloc(size, GFP_KERNEL);
>>         if (!unittest_data)
>>                 return -ENOMEM;
>>
>> +       unittest_data = PTR_ALIGN(unittest_data, FDT_ALIGN_SIZE);
>> +       memcpy(unittest_data, __dtb_testcases_begin, size);
>> +
>>         of_fdt_unflatten_tree(unittest_data, NULL, &unittest_data_node);
>>         if (!unittest_data_node) {
>>                 pr_warn("%s: No tree to attach; not running tests\n", __func__);
> 
> The next line here is a kfree(unittest_data) which I assume will fail
> if the ptr address changed. Same issue in the overlay code.

Thanks for catching this.

> 
> The error path is easy to fix. Freeing the memory later on, not so
> much... 

The overlay subsystem retains ownership of the allocated memory and
responsibility for any subsequent kfree(), so actually not very
difficult.

New version of the patch should be out this morning.

-Frank

> One solution is always alloc a power of 2 size, that's
> guaranteed to be 'size' aligned:
> 
>  * The allocated object address is aligned to at least ARCH_KMALLOC_MINALIGN
>  * bytes. For @size of power of two bytes, the alignment is also guaranteed
>  * to be at least to the size.
> 
> Rob
> .
> 

