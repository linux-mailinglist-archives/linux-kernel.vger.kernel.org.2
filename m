Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D19429FAD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbhJLIXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbhJLIXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:23:42 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BF0C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:21:40 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id j21so66889201lfe.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zoYjW5j+sOrn45B5pRctVsrBAhO/9eEsS+3u6fho2Es=;
        b=iH9n8IVXMan4pahTGmYgbHfDX2n55rghvdRMD7PAz/2G/49LjrPUasa4rV+IbSDXBS
         2vg9lBag0gxo4RS1QF8NFgwxput17DFWURK55PolzkVaXI6JxPP9epyuF7i2duu5kto5
         j7hvghtZ2rpknFt12zP57iX8/d/1r0LR73mlcKe0wYXFEjicd3ZUHR5crJzwNXWYvQXu
         HigrwWHxh6qT9UuWHZeZAxkjqQ88VsFDHCfOuoAiy9r3au48J3jFFjTdkw95BQzUledi
         f5khu2yrnclGRewhz/t+dT7/yMSRlPsQa+py5xqg4Go9IwrRjUIUGEk28j23wDCvw2yC
         Yd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zoYjW5j+sOrn45B5pRctVsrBAhO/9eEsS+3u6fho2Es=;
        b=D99tNgFf0xvaduQqlTXJxzHBqKQhFRM08XmeFp8V8KTLafnFeO75AX2JwAK/uNmkCB
         RTMT0k9UW8omDan5+PaIVhex3URDiOrNE9SMZpLswuAOhif2lBKuwRJ3yDv782sUld0+
         7/qb1btLEpNDB2AbKphx1wljP3Zfb2n5VcINa6wB65lq3+284LE6zwGFTyB+9lPNl4R/
         kDwZh+FeRi/V4z4KoPFE3R6MFlzqokS9TgdXvo/l51R1+9RFhZgyB7P8jvJEo6J7a7O5
         uFkeI7CN94qfnhLmKs2gV/Deta30Y5Enz+EkZyMKRfHBKm5jEZwGcNJ3emAfrOl0UQhF
         eejg==
X-Gm-Message-State: AOAM533eCmW6teJSUaP9XFO8GQWbmcgyDeK/7uZ8HHSLreF+PBrIZAYS
        TlyU+P9cyJEhP/vUQIVd3NqHmQ==
X-Google-Smtp-Source: ABdhPJysh8x5oAFbj2l+BgJU9qDGKJz1aeMCrdcOwGpbmUdPka+KdREsXae0Z/KZntv2x0MCMPfBQg==
X-Received: by 2002:a19:5e0d:: with SMTP id s13mr30948604lfb.174.1634026898712;
        Tue, 12 Oct 2021 01:21:38 -0700 (PDT)
Received: from [192.168.1.102] (62-248-207-242.elisa-laajakaista.fi. [62.248.207.242])
        by smtp.gmail.com with ESMTPSA id p18sm1087057ljc.114.2021.10.12.01.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 01:21:38 -0700 (PDT)
Subject: Re: Panic on kmemleak scan
To:     Mike Rapoport <rppt@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>
References: <8ade5174-b143-d621-8c8e-dc6a1898c6fb@linaro.org>
 <YWUmaV7pDBX9zSOl@kernel.org>
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Message-ID: <147cd17b-7cba-e015-ce94-ad4b9c3f07e6@linaro.org>
Date:   Tue, 12 Oct 2021 11:21:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YWUmaV7pDBX9zSOl@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 10/12/21 9:08 AM, Mike Rapoport wrote:
> (added Catalin)
> 
> On Mon, Oct 11, 2021 at 02:23:31PM +0300, Vladimir Zapolskiy wrote:
>> Hello Mike,
>>
>> commit a7259df767 ("memblock: make memblock_find_in_range method private") [1]
>> invokes a kernel panic while running kmemleak on OF platforms with nomaped
>> regions, basically it's similar to an issue reported and fixed earlier by [2]:
>>
>>    Unable to handle kernel paging request at virtual address ffff000021e00000
> 
> Does this virtual address correspond to a nomap area?

Yes, it does:

   OF: reserved mem: allocated memory for 'rmtfs@86700000' node: base 0x00000000a1e00000, size 2 MiB

and 'rmtfs@86700000' device node has a 'no-map' property.

Also:

# echo dump=0xffff000021e00000 > /sys/kernel/debug/kmemleak
[   35.679096] kmemleak: Object 0xffff000021e00000 (size 2097152):
[   35.679172] kmemleak:   comm "swapper", pid 0, jiffies 4294892296
[   35.683860] kmemleak:   min_count = 0
[   35.690106] kmemleak:   count = 0
[   35.693752] kmemleak:   flags = 0x1
[   35.697050] kmemleak:   checksum = 0
[   35.700350] kmemleak:   backtrace:
[   35.704170]      kmemleak_alloc_phys+0x2c/0x40
[   35.707381]      memblock_alloc_range_nid+0x150/0x170
[   35.711810]      memblock_phys_alloc_range+0xb8/0xc8
[   35.716931]      early_init_dt_alloc_reserved_memory_arch+0x40/0x94
[   35.721968]      __reserved_mem_alloc_size+0x200/0x308
[   35.727955]      fdt_init_reserved_mem+0x154/0x284
[   35.733164]      early_init_fdt_scan_reserved_mem+0x80/0xfc
[   35.737939]      arm64_memblock_init+0x23c/0x278
[   35.743406]      setup_arch+0x18c/0x228
[   35.748266]      start_kernel+0x94/0x610
[   35.751825]      __primary_switched+0xc0/0xc8

> Can you check if this patch helps:
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 184dcd2e5d99..5c3503c98b2f 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -936,7 +936,12 @@ int __init_memblock memblock_mark_mirror(phys_addr_t base, phys_addr_t size)
>    */
>   int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
>   {
> -	return memblock_setclr_flag(base, size, 1, MEMBLOCK_NOMAP);
> +	int ret = memblock_setclr_flag(base, size, 1, MEMBLOCK_NOMAP);
> +
> +	if (!ret)
> +		kmemleak_free_part_phys(base, size);
> +
> +	return ret;
>   }
>   
>   /**
> 

The change fixes the issue, thank you!

The object is also gone from being under kmemleak:

# echo dump=0xffff000021e00000 > /sys/kernel/debug/kmemleak
kmemleak: Unknown object at 0xffff000021e00000

Please feel free to add my

Tested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

>>    [...]
>>      scan_block+0x64/0x170
>>      scan_gray_list+0xe8/0x17c
>>      kmemleak_scan+0x270/0x514
>>      kmemleak_write+0x34c/0x4ac
>>
>> I believe it would be a trivial problem to correct for you, thank you in
>> advance!
>>
>> [1] https://lore.kernel.org/all/20210816122622.30279-1-rppt@kernel.org/T/#u
>> [2] https://lore.kernel.org/lkml/20190119132832.GA29881@MBP.local/t/#m032124f36c07

--
Best wishes,
Vladimir
