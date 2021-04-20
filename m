Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6820365C03
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbhDTPTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:19:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52586 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232450AbhDTPTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618931939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=770vz2JVGNnIzK29NwyJrUqxj03tbV5pp2hzoWbqGVw=;
        b=B00qNGXaCcKzIddryeMiUCpTXMChX1xz/S+beTUztm9lM7WjotKtUZDF9TsHm9gQQ4/RrA
        zqah0CjtRywrtxen1xUAedOK4RRyYwBoBXUEdG/UcsiPM9CumXnFAvSe+PSJ8kIeyvmoq6
        PoL4+Cqbqp6sQ8LcXwfdo0rnxs5UCUo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-4ToiPjmvPcqUpQ_zC-VBRw-1; Tue, 20 Apr 2021 11:18:58 -0400
X-MC-Unique: 4ToiPjmvPcqUpQ_zC-VBRw-1
Received: by mail-ed1-f71.google.com with SMTP id c15-20020a056402100fb029038518e5afc5so5765822edu.18
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 08:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=770vz2JVGNnIzK29NwyJrUqxj03tbV5pp2hzoWbqGVw=;
        b=bTEDxU4C9htRrGeCBUUd+HBIaBHZMdj0ZdlDynvK8sNtnkBDG2WQIzsFku7O5PxcfG
         RWLOunTY+Dm6fQ36plMP0ygR0geDGxtI5o1d4kU4QPMPRDhm2/8YnhXx15YMRDM/wspw
         Otr941HL/ouw943Xgzv6494/VP2JsGUvIpoXFTu5BMMi63Vfl3xBA+7Umf+ynp9Cx9oU
         oeSavFvGkzn70a8plwaZiWBEutpVuMm5kXJ5ddvRnA9YT7U4Vsw6Q4titOxRBvZXkM16
         ecmt84ipz1+ybjmIwMo5cZHxiQhZ6vpVimedCNiVyqvM5WUjlkLYQM9UgrpnjcfJ/jPD
         FB2w==
X-Gm-Message-State: AOAM533nX/lmmkQqB2BDrQr21K0EjqFyFI/ZRprnLm+rZpTOGJ6ZNIvQ
        kAASQmH3laUi9Ly58PuaYNR7YtmHrL2YtDkw8Oqr5emcMo4mhQfFDF+Xwcs0jrFzELoeeCm13la
        jU8bbeftN3hNUvJ0D1R+ZAhB0
X-Received: by 2002:a17:906:6d48:: with SMTP id a8mr28828654ejt.92.1618931936819;
        Tue, 20 Apr 2021 08:18:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwX0gjV1YOL8zIlogJIXvYhztp20fRFlx1w9hSqe5B3fLMvw1anl4MLNbGH45aEpi3l71uCRQ==
X-Received: by 2002:a17:906:6d48:: with SMTP id a8mr28828644ejt.92.1618931936653;
        Tue, 20 Apr 2021 08:18:56 -0700 (PDT)
Received: from [192.168.3.132] (p4ff2390a.dip0.t-ipconnect.de. [79.242.57.10])
        by smtp.gmail.com with ESMTPSA id v8sm16154073edc.30.2021.04.20.08.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 08:18:56 -0700 (PDT)
Subject: Re: [PATCH v1 2/4] memblock: update initialization of reserved pages
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210420090925.7457-1-rppt@kernel.org>
 <20210420090925.7457-3-rppt@kernel.org>
 <ed8f10a0-9b68-1d12-0305-90fd378af6b9@redhat.com>
 <YH7tL77Z9UzTAFca@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <45a7e13d-3e44-3b94-a253-2df72649a83d@redhat.com>
Date:   Tue, 20 Apr 2021 17:18:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YH7tL77Z9UzTAFca@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.04.21 17:03, Mike Rapoport wrote:
> On Tue, Apr 20, 2021 at 03:56:28PM +0200, David Hildenbrand wrote:
>> On 20.04.21 11:09, Mike Rapoport wrote:
>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>
>>> The struct pages representing a reserved memory region are initialized
>>> using reserve_bootmem_range() function. This function is called for each
>>> reserved region just before the memory is freed from memblock to the buddy
>>> page allocator.
>>>
>>> The struct pages for MEMBLOCK_NOMAP regions are kept with the default
>>> values set by the memory map initialization which makes it necessary to
>>> have a special treatment for such pages in pfn_valid() and
>>> pfn_valid_within().
>>
>> Just a general question while thinking about it:
>>
>> Would we right now initialize the memmap of these pages already via
>> memmap_init_zone()->memmap_init_range()? (IOW, not marking the
>> PageReserved?)
> 
> Yep. These pages are part of memblock.memory so they are initialized in
> memmap_init_zone()->memmap_init_range() to the default values.
> 

So instead of fully initializing them again, we mostly would only have 
to set PageReserved(). Not sure how big that memory usually is -- IOW, 
if we really care about optimizing the double-init.

-- 
Thanks,

David / dhildenb

