Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E821371241
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 10:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhECIIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 04:08:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59867 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229817AbhECIH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 04:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620029225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lQ3DC7AtOQDLcIS5zcoeo9H4pxzVMTr3J/iLQuTR5t4=;
        b=NSJnrhdvykM8Ym//8lkb3B/CbF8jLgJIlfG7QMRIvmUAvdzVA4VHxjAeBKgMfLjyi8qq7U
        t6j06Fj28E7J/Bs55E+o+DCr+3ledwfdeu5w6PiyWbb+sfhDn9LLSWT0izy6sHLpXr6O8n
        kGtqDJcz2N/7sgVpWQzQ0CkcQVzrUBU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-14afXZfgNmqDvjQXV6NrGA-1; Mon, 03 May 2021 04:07:03 -0400
X-MC-Unique: 14afXZfgNmqDvjQXV6NrGA-1
Received: by mail-wm1-f72.google.com with SMTP id n24-20020a7bcbd80000b029014287841063so655774wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 01:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lQ3DC7AtOQDLcIS5zcoeo9H4pxzVMTr3J/iLQuTR5t4=;
        b=Lw4RoPeKykwNkyWmoFF5N8vBrrudCvXBvlqw+ixYOcc6XmLnk5nG/7anDmhMf6gfpM
         oOm4FzbRZJjmEyrLPYAlNVDLLsAzeG2lFokUiNbYGeEiGhMGeXthYouZ4TFjHO5ViS9N
         GENgHURYoYYE9q9USk4Vbh9YW1Oi2viEHT+XMsi2uJ+Qlvx9r/x3OmMg2TllNbRcdyZC
         mYdsB0O9cZDKyUUv5JznXdAhwdrjSSuhtH5B+Cys1N65jQrZ7WlNiIlTHo2Z882IRK2H
         8TG/IQAb5Zkq1Ds02xBLnmVoXLsxYTleEwAfmiIZrAQkpztKKJwjFl30v4DEmSNI7j5M
         mszQ==
X-Gm-Message-State: AOAM532sGe6NVxnARXDomirbOrD7/OQeWYNcD71A4D55LxGC7eS4xbzY
        85T8NkVJv9z6mMWdnHQbklFHoYJQyJVSAF4yxJaOoZGDk7oCVyRYr/AzkKnU5AVMGmAPgoNmH0Q
        Av6M6oyCH4vzeILmp9CA9xz+M
X-Received: by 2002:a5d:53c9:: with SMTP id a9mr23514586wrw.108.1620029222739;
        Mon, 03 May 2021 01:07:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztudGlR+1pwFh0JGWAmGAGZpGgLxmVHb9G+bDK9iqTp0teBnknMNyF222oyWVrdGbBg32OIQ==
X-Received: by 2002:a5d:53c9:: with SMTP id a9mr23514565wrw.108.1620029222505;
        Mon, 03 May 2021 01:07:02 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c649f.dip0.t-ipconnect.de. [91.12.100.159])
        by smtp.gmail.com with ESMTPSA id f6sm13386613wru.72.2021.05.03.01.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 01:07:02 -0700 (PDT)
Subject: Re: arm32: panic in move_freepages (Was [PATCH v2 0/4] arm64: drop
 pfn_valid_within() and simplify pfn_valid())
To:     Mike Rapoport <rppt@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <YIZNq5HMfJ1rWytv@kernel.org>
 <2d879629-3059-fd42-428f-4b7c2a73d698@huawei.com>
 <YIet5X7lgygD9rpZ@kernel.org>
 <259d14df-a713-72e7-4ccb-c06a8ee31e13@huawei.com>
 <YIj5zcbHBHt7CC8B@kernel.org>
 <6ad2956c-70ae-c423-ed7d-88e94c88060f@huawei.com>
 <YIpY8TXCSc7Lfa2Z@kernel.org>
 <0cb013e4-1157-f2fa-96ec-e69e60833f72@huawei.com>
 <YIvTM5Yqit8AB4W8@kernel.org>
 <ca5b00bd-1312-0c69-ab69-a1bd749f51b6@huawei.com>
 <YI+XrAg4KOzOyt7c@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <24b37c01-fc75-d459-6e61-d67e8f0cf043@redhat.com>
Date:   Mon, 3 May 2021 10:07:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YI+XrAg4KOzOyt7c@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.05.21 08:26, Mike Rapoport wrote:
> On Fri, Apr 30, 2021 at 07:24:37PM +0800, Kefeng Wang wrote:
>>
>>
>> On 2021/4/30 17:51, Mike Rapoport wrote:
>>> On Thu, Apr 29, 2021 at 06:22:55PM +0800, Kefeng Wang wrote:
>>>>
>>>> On 2021/4/29 14:57, Mike Rapoport wrote:
>>>>
>>>>>>> Do you use SPARSMEM? If yes, what is your section size?
>>>>>>> What is the value if CONFIG_FORCE_MAX_ZONEORDER in your configuration?
>>>>>> Yes,
>>>>>>
>>>>>> CONFIG_SPARSEMEM=y
>>>>>>
>>>>>> CONFIG_SPARSEMEM_STATIC=y
>>>>>>
>>>>>> CONFIG_FORCE_MAX_ZONEORDER = 11
>>>>>>
>>>>>> CONFIG_PAGE_OFFSET=0xC0000000
>>>>>> CONFIG_HAVE_ARCH_PFN_VALID=y
>>>>>> CONFIG_HIGHMEM=y
>>>>>> #define SECTION_SIZE_BITS    26
>>>>>> #define MAX_PHYSADDR_BITS    32
>>>>>> #define MAX_PHYSMEM_BITS     32
>>>>
>>>>
>>>> With the patch,  the addr is aligned, but the panic still occurred,
>>>
>>> Is this the same panic at move_freepages() for range [de600, de7ff]?
>>>
>>> Do you enable CONFIG_ARM_LPAE?
>>
>> no, the CONFIG_ARM_LPAE is not set, and yes with same panic at
>> move_freepages at
>>
>> start_pfn/end_pfn [de600, de7ff], [de600000, de7ff000] :  pfn =de600, page
>> =ef3cc000, page-flags = ffffffff,  pfn2phy = de600000
>>
>>>> __free_memory_core, range: 0xb0200000 - 0xc0000000, pfn: b0200 - b0200
>>>> __free_memory_core, range: 0xcc000000 - 0xdca00000, pfn: cc000 - b0200
>>>> __free_memory_core, range: 0xde700000 - 0xdea00000, pfn: de700 - b0200
> 
> Hmm, [de600, de7ff] is not added to the free lists which is correct. But
> then it's unclear how the page for de600 gets to move_freepages()...
> 
> Can't say I have any bright ideas to try here...

Are we missing some checks (e.g., PageReserved()) that 
pfn_valid_within() would have "caught" before?

-- 
Thanks,

David / dhildenb

