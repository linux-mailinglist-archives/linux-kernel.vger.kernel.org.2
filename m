Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936AA3BC44A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 02:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhGFAHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 20:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhGFAHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 20:07:15 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C0DC061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 17:04:37 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id h4so19742685pgp.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 17:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=B0opPtpn0MNnkL5QbMS6eUOeWPJf+0ldaSgcF59HYA4=;
        b=rDvuIPBcKPjkepsgjPn44C4yQRaf+WLhKR4W/De1j6JU3nv7+1hd/0rYG0LUC2yAK6
         S5xY/5rVenP0Xg0JVAJNaqWNRIUsd/FxtcC0+QhuCZHgfNqRm7t9SLgmFdv8LV7l2z4Y
         s/WWD7nyzEbPtvFmRsJyYKkDg6Y8MMbIOKFWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=B0opPtpn0MNnkL5QbMS6eUOeWPJf+0ldaSgcF59HYA4=;
        b=Zw8G/nBluFONH79bgfTM/ITezIQCMGEDwz9XzQNowzjiCsMQHO1u5JMj8hMNhOD7VH
         nPxEmJdrup1ahzNYBng9U6dbwoSzrfhNlwWfKnCtHdpp4Uv7Sf2iwJI5vtB8b3qjwRO8
         l4r0i3D+Zx/ULSKnutHMUKKa94yrdi/DA5rEJOtq9nWacyRY+OWn+ifVvvGJSY2FBRCe
         HoBywWpabRoWHle8OFGdnnwuJz+UPigwq5tOOzvZzhjs0oh0K4Xm7sjm6Wsp4gd6+o9G
         9iMrFUBy1GeQX4jX1OkEO8a6pd9V37cK/ouRDuS4ufg8QMCVllO//ksw/Upxj4W+DHOR
         qIww==
X-Gm-Message-State: AOAM532exVgQkEA4/FR5fSKzgwjAKTsGtSCVTSLm627Mhp98/TlvJ1nO
        6todrBR63aNIFMEptZmTQx8xEg==
X-Google-Smtp-Source: ABdhPJzsW453AAcxAxcneEUrf/hQOKjTL0dsqQy+AVo4DrwoM4eBEPWI17dzJRLwl18dB7vcWF6ggA==
X-Received: by 2002:a63:1d42:: with SMTP id d2mr18120359pgm.21.1625529876564;
        Mon, 05 Jul 2021 17:04:36 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id 199sm13077375pfy.203.2021.07.05.17.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 17:04:35 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Marco Elver <elver@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Subject: Re: [PATCH -next 3/3] kasan: arm64: Fix pcpu_page_first_chunk crash
 with KASAN_VMALLOC
In-Reply-To: <YOMfcE7V7lSE3N/z@elver.google.com>
References: <20210705111453.164230-1-wangkefeng.wang@huawei.com>
 <20210705111453.164230-4-wangkefeng.wang@huawei.com>
 <YOMfcE7V7lSE3N/z@elver.google.com>
Date:   Tue, 06 Jul 2021 10:04:31 +1000
Message-ID: <87bl7gxq7k.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Marco Elver <elver@google.com> writes:

> On Mon, Jul 05, 2021 at 07:14PM +0800, Kefeng Wang wrote:
> [...]
>> +#ifdef CONFIG_KASAN_VMALLOC
>> +void __init __weak kasan_populate_early_vm_area_shadow(void *start,
>> +						       unsigned long size)
>
> This should probably not be __weak, otherwise you now have 2 __weak
> functions.
>
>> +{
>> +	unsigned long shadow_start, shadow_end;
>> +
>> +	if (!is_vmalloc_or_module_addr(start))
>> +		return;
>> +
>> +	shadow_start = (unsigned long)kasan_mem_to_shadow(start);
>> +	shadow_start = ALIGN_DOWN(shadow_start, PAGE_SIZE);
>> +	shadow_end = (unsigned long)kasan_mem_to_shadow(start + size);
>> +	shadow_end = ALIGN(shadow_end, PAGE_SIZE);
>> +	kasan_map_populate(shadow_start, shadow_end,
>> +			   early_pfn_to_nid(virt_to_pfn(start)));
>> +}
>> +#endif
>
> This function looks quite generic -- would any of this also apply to
> other architectures? I see that ppc and sparc at least also define
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK.

So I checked with my latest KASAN ppc64 series and my code also breaks
in a very similar way if you boot with percpu_alloc=page. It's not
something I knew about or tested with before!

Unfortunately kasan_map_populate - despite having a very
generic-sounding name - is actually arm64 specific. I don't know if
kasan_populate_early_shadow (which is generic) would be able to fill the
role or not. If we could keep it generic that would be better.

It looks like arm64 does indeed populate the kasan_early_shadow_p{te,md..}
values, but I don't really understand what it's doing - is it possible
to use the generic kasan_populate_early_shadow on arm64?

If so, should we put the call inside of vm_area_register_early?

Kind regards,
Daniel

>
>>  void __init kasan_init(void)
>>  {
>>  	kasan_init_shadow();
>> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
>> index 5310e217bd74..79d3895b0240 100644
>> --- a/include/linux/kasan.h
>> +++ b/include/linux/kasan.h
>> @@ -49,6 +49,8 @@ extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
>>  int kasan_populate_early_shadow(const void *shadow_start,
>>  				const void *shadow_end);
>>  
>> +void kasan_populate_early_vm_area_shadow(void *start, unsigned long size);
>> +
>>  static inline void *kasan_mem_to_shadow(const void *addr)
>>  {
>>  	return (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
>> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
>> index cc64ed6858c6..d39577d088a1 100644
>> --- a/mm/kasan/init.c
>> +++ b/mm/kasan/init.c
>> @@ -279,6 +279,11 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
>>  	return 0;
>>  }
>>  
>> +void __init __weak kasan_populate_early_vm_area_shadow(void *start,
>> +						       unsigned long size)
>> +{
>> +}
>
> I'm just wondering if this could be a generic function, perhaps with an
> appropriate IS_ENABLED() check of a generic Kconfig option
> (CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK ?) to short-circuit it, if it's
> not only an arm64 problem.
>
> But I haven't looked much further, so would appeal to you to either
> confirm or reject this idea.
>
> Thanks,
> -- Marco
