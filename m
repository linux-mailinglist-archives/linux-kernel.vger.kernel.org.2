Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3A335F87E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbhDNPyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:54:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44288 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352425AbhDNPxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618415581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5YzCxsnnijC//XX+MlJqJz04Lu4zT3zQq8qLb1/6PL8=;
        b=N3azEr1ngxbg5Okfzokn3K+Vj8x1YT1chtg/3cPj88jYlzCSUj97TjSeFM+icr/ZSz9UjK
        n8nyxXERFsZid/76ryc48rtDYfhUgd7Hr2CH7xzLpw/rKyfA3OsHjkzjaOEmzgCxy6r5Dc
        8gRIO4EFpV1RVIW6vdrADRh67QLnPbg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-GidRiZGwPLqdQKAyLMlfrw-1; Wed, 14 Apr 2021 11:53:00 -0400
X-MC-Unique: GidRiZGwPLqdQKAyLMlfrw-1
Received: by mail-wr1-f70.google.com with SMTP id t18-20020adfdc120000b02900ffe4432d8bso1259543wri.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5YzCxsnnijC//XX+MlJqJz04Lu4zT3zQq8qLb1/6PL8=;
        b=AkFx2Ygit4SrXmu+B8aB7VJBGmZQ6ce5gK36nkVlqiSVlJC+gX6fq57e+zQTmzg3tm
         L+6C7bVbxH7RNrwXIEGFpk0kF9A86QEbSrl9rXRfYvr3KGQIMyVuGVloOdP0ou0q7r60
         a7ir9vyWPJDnCR0/wXmdBsiuEZfEqHKhgJcxvGAc4h1fvbCFPgiGKlY6GOfjt7LY/Xae
         vQYRFgKE3xMzxqRjb/dQc3NnsbL2bVwe42q9hO/maqBdCxq9PRI6cM6K9M6iu2k8ZbIS
         a8gE+pX/m56j7G6MIgD5wqFjWqXf1UoL/LnxbY12fBCvvkfwG5rTi4ea9hYyhM9E9uMP
         N+wA==
X-Gm-Message-State: AOAM532mh+hEtInP9EuxZxJ1i9bFI29/EI3O72tjfpvPc95xHmQgYeKs
        bvsyQJTGQM3mTgoTuvFtl8sUPFwtrpkD5TQ4u9j1OZ0jTXP2YghObYfYSrsylLKi31MHUqh/LfO
        Wg9vd3ytZsvhd+gKmc7hLv2G6
X-Received: by 2002:a05:6000:1449:: with SMTP id v9mr19611098wrx.295.1618415578933;
        Wed, 14 Apr 2021 08:52:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwrSOMpK/YVN66pneA+j1TjD57EZ3NUFrkJFb4IkiDMz2r4seRtxhdfypbvJbPgTdVs+mLkw==
X-Received: by 2002:a05:6000:1449:: with SMTP id v9mr19611079wrx.295.1618415578737;
        Wed, 14 Apr 2021 08:52:58 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6470.dip0.t-ipconnect.de. [91.12.100.112])
        by smtp.gmail.com with ESMTPSA id u3sm5657582wmg.48.2021.04.14.08.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 08:52:58 -0700 (PDT)
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <20210407172607.8812-1-rppt@kernel.org>
 <20210407172607.8812-2-rppt@kernel.org>
 <0c48f98c-7454-1458-15a5-cc5a7e1fb7cd@redhat.com>
 <CAMj1kXGw97epyP2HdHjA8Yp6+VF1j5xmd0AgVBBv3k+h_B610w@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC/RFT PATCH 1/3] memblock: update initialization of reserved
 pages
Message-ID: <3811547a-9057-3c80-3805-2e658488ac99@redhat.com>
Date:   Wed, 14 Apr 2021 17:52:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAMj1kXGw97epyP2HdHjA8Yp6+VF1j5xmd0AgVBBv3k+h_B610w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.04.21 17:27, Ard Biesheuvel wrote:
> On Wed, 14 Apr 2021 at 17:14, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 07.04.21 19:26, Mike Rapoport wrote:
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
>> I assume these pages are never given to the buddy, because we don't have
>> a direct mapping. So to the kernel, it's essentially just like a memory
>> hole with benefits.
>>
>> I can spot that we want to export such memory like any special memory
>> thingy/hole in /proc/iomem -- "reserved", which makes sense.
>>
>> I would assume that MEMBLOCK_NOMAP is a special type of *reserved*
>> memory. IOW, that for_each_reserved_mem_range() should already succeed
>> on these as well -- we should mark anything that is MEMBLOCK_NOMAP
>> implicitly as reserved. Or are there valid reasons not to do so? What
>> can anyone do with that memory?
>>
>> I assume they are pretty much useless for the kernel, right? Like other
>> reserved memory ranges.
>>
> 
> On ARM, we need to know whether any physical regions that do not
> contain system memory contain something with device semantics or not.
> One of the examples is ACPI tables: these are in reserved memory, and
> so they are not covered by the linear region. However, when the ACPI
> core ioremap()s an arbitrary memory region, we don't know whether it
> is mapping a memory region or a device region unless we keep track of
> this in some way. (Device mappings require device attributes, but
> firmware tables require memory attributes, as they might be accessed
> using misaligned reads)

Using generically sounding NOMAP ("don't create direct mapping") to 
identify device regions feels like a hack. I know, it was introduced 
just for that purpose.

Looking at memblock_mark_nomap(), we consider "device regions"

1) ACPI tables

2) VIDEO_TYPE_EFI memory

3) some device-tree regions in of/fdt.c


IIUC, right now we end up creating a memmap for this NOMAP memory, but 
hide it away in pfn_valid(). This patch set at least fixes that.

Assuming these pages are never mapped to user space via the struct page 
(which better be the case), we could further use a new pagetype to mark 
these pages in a special way, such that we can identify them directly 
via pfn_to_page().

Then, we could mostly avoid having to query memblock at runtime to 
figure out that this is special memory. This would obviously be an 
extension to this series. Just a thought.

-- 
Thanks,

David / dhildenb

