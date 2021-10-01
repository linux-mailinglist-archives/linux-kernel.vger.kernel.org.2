Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8322B41E927
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 10:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352828AbhJAIli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 04:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54244 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229683AbhJAIlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 04:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633077593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V061dyxBi+78IoBs/KlOeND72P1bErBsApycGVC5Nng=;
        b=YiJ4R/2aNvCEJ555Z0qnh1A7DFKqJ0zXaSRKTi18WJJYj64jr9BGhCJP0JfJgjVupAgdBi
        qBRfFCSXQJlS+yawOQlvA+uRllDUKGnbsQgj0i0FcicgDHnAHxIVEbX/w4gZx1pSUCY9yb
        jX6BQ2vYu7lcd8JoOZALvUFWScTdfA8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-601-vUbI6Rw_PDWII3As_Sgeiw-1; Fri, 01 Oct 2021 04:39:52 -0400
X-MC-Unique: vUbI6Rw_PDWII3As_Sgeiw-1
Received: by mail-wm1-f70.google.com with SMTP id 10-20020a05600c240a00b0030d403f24e2so1508998wmp.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 01:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=V061dyxBi+78IoBs/KlOeND72P1bErBsApycGVC5Nng=;
        b=WKlY0remNswNB0dZVSD04dJni1asLeRNKYvMmIE9YsUsMKLN8JvZoer8snIKvVvBrw
         BWGtpQkXTxq8LEV/tFMAYWZTEB1u5eFlsMXWmAhhwW/MRNANQnSNyv5PBZjCZyWjiyiZ
         vL0xBcGkDIAuQzHdtPNuoap9/TbmCKvsr/hkGpfqhxSi1fRACLI2NOh6lvzmUPH3m3Jb
         ByqhU0cJgQ3IKUt8/vzteocBqSvJaCHOjcm/cJDd2KtKiWVDQUO54qDTfluq+wFkTU/y
         zNk6renXk7PvIqs0DZ4oQFWvLaRNBFIe5kh3Y9JyqOJzx7hFJwixZHQB75utgZyGI6o+
         +IDQ==
X-Gm-Message-State: AOAM530Ewgc9S9DhnotQmIVfKcV6S+Nr85o12AyoBlObqZetQLxBg65w
        3UAGC8IUp6aPDkaTyRsc1wyBe5dZOy65XGu9o24FmLzCNm6Ur0SRkHwHQ3oONNOfjiLtrEjzJmH
        MpenKjkLU3oAtwYQZc87Om9JK
X-Received: by 2002:a5d:4a85:: with SMTP id o5mr10946229wrq.204.1633077590965;
        Fri, 01 Oct 2021 01:39:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpVtk0bDeSJVGMRLap4VtU1JiiUf/IRw9giqpf8aL3wTncBSOb/fQil1j7msArUuH85CUcyg==
X-Received: by 2002:a5d:4a85:: with SMTP id o5mr10946217wrq.204.1633077590775;
        Fri, 01 Oct 2021 01:39:50 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64da.dip0.t-ipconnect.de. [91.12.100.218])
        by smtp.gmail.com with ESMTPSA id j27sm6025639wms.6.2021.10.01.01.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 01:39:49 -0700 (PDT)
Subject: Re: [PATCH] arm64: mm: update max_pfn after memory hotplug
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Florian Fainelli <f.fainelli@gmail.com>
References: <cover.1632853776.git.quic_cgoldswo@quicinc.com>
 <a51a27ee7be66024b5ce626310d673f24107bcb8.1632853776.git.quic_cgoldswo@quicinc.com>
 <f0ea994c-b3a0-1577-85e3-0620ac5a0de7@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <c3d5b781-c02e-1126-01d5-6c54db320233@redhat.com>
Date:   Fri, 1 Oct 2021 10:39:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f0ea994c-b3a0-1577-85e3-0620ac5a0de7@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.10.21 08:38, Anshuman Khandual wrote:
> 
> 
> On 9/29/21 12:21 AM, Chris Goldsworthy wrote:
>> From: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
>>
>> After new memory blocks have been hotplugged, max_pfn and max_low_pfn
>> needs updating to reflect on new PFNs being hot added to system.
>> Without this patch, debug-related functions that use max_pfn such as
>> get_max_dump_pfn() or read_page_owner() will not work with any page in
>> memory that is hot-added after boot.
>>
>> Fixes: 4ab215061554 ("arm64: Add memory hotplug support")
>> Signed-off-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
>> Signed-off-by: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Cc: Florian Fainelli <f.fainelli@gmail.com>
>> Cc: Georgi Djakov <quic_c_gdjako@quicinc.com>
>> ---
>>   arch/arm64/mm/mmu.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index cfd9deb..fd85b51 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1499,6 +1499,11 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>   	if (ret)
>>   		__remove_pgd_mapping(swapper_pg_dir,
>>   				     __phys_to_virt(start), size);
>> +	else {
>> +		max_pfn = PFN_UP(start + size);
>> +		max_low_pfn = max_pfn;
>> +	}
> 
> Do these variables get updated on *all* platforms that support memory
> hotplug via an arch_add_memory() ? If not, dont they all face similar
> issues as well ? Why not just update these in generic hotplug instead
> , after looking into arch_add_memory() return code.

s390x sets them to the possible maximum (based on the direct mapping 
size) in init code.

Other archs like x86-64 have to update other parameters. So I guess it 
just made sense to let the archs handle updating these 2 variables.

-- 
Thanks,

David / dhildenb

