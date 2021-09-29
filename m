Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E8341C2FE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 12:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245132AbhI2Kvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 06:51:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27412 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231859AbhI2Kvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 06:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632912602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yJblBAUdTZrLkVKfqN+ayro8jHtoL/NDcs5t2+YAybQ=;
        b=glZX5MPiJ9HRaDtiyoiR0rxY5vyxvMtlrmR1HygKWUHbLbNiCwPcIPoFB+dtTg5l7fFWQF
        2/jNufLysmN+VM7O45Wv7rUsZmpQ5WgnVcamLd4MX1hDM6mHmKbdJpCo5mjWB3/tia7oL6
        9DGeuutCi5BVdCjHo3pxlYbyMm0YRNg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-q7n6i1fbM4K1FIoiGxdXUw-1; Wed, 29 Sep 2021 06:50:00 -0400
X-MC-Unique: q7n6i1fbM4K1FIoiGxdXUw-1
Received: by mail-wr1-f71.google.com with SMTP id w2-20020a5d5442000000b0016061c95fb7so470948wrv.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 03:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yJblBAUdTZrLkVKfqN+ayro8jHtoL/NDcs5t2+YAybQ=;
        b=BGzbH+9YcN3nWFfKCEnA0hkzLh7svvgbHiGPX6mnGDXyrOeUTlVtCpnMlHqYDfm1SM
         WvdjQpwZzutcjXrlaZIJpbaP7OVvyAWe107ePqkTLcFUBh++xY+F8NIUCYOir69PBKX4
         JUrsaReOCexT+sF92OsOAxSw0CBp7KLaEcgMFHZ31EtjD6HV3Yc7Q710sxuBpINiklwr
         FiqyfQpZNetX8GNWELl6WChJXPGJn578GAyHWrgueBCp19QC5CnF0A7LokntKNesu3Kw
         yp/VARsPJ7p011ODAymAofkldc1+3ckcuNPm/rEzZyTC52+qnOLK+Aiyq0OrQ6n5w8+9
         bGUQ==
X-Gm-Message-State: AOAM533PnDNyXnkyq5LO7MeQTEpG5l3LB7PoB/inx91GbzZLoOtvDEht
        5Yo+/o6W0E70YKc5YVivQJF9O5kPoOQ3jUyTijPFBH8Kh17WSrWVl14XtKUscssemSOHcC1do/7
        9Y1emqtIgDdMMWvGQgC1qD5uY
X-Received: by 2002:adf:f550:: with SMTP id j16mr5695871wrp.41.1632912599480;
        Wed, 29 Sep 2021 03:49:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyknjYCV5/YucYyqK4ttxf6YGqpj8j308QRLIXJZmn9/PSm0vTiWuliJiNn3t91IEkFJLZUYQ==
X-Received: by 2002:adf:f550:: with SMTP id j16mr5695853wrp.41.1632912599276;
        Wed, 29 Sep 2021 03:49:59 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23c3b.dip0.t-ipconnect.de. [79.242.60.59])
        by smtp.gmail.com with ESMTPSA id o16sm1884830wrx.11.2021.09.29.03.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 03:49:58 -0700 (PDT)
Subject: Re: [RFC] arm64: mm: update max_pfn after memory hotplug
To:     Will Deacon <will@kernel.org>
Cc:     Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
References: <cover.1632437225.git.quic_cgoldswo@quicinc.com>
 <595d09279824faf1f54961cef52b745609b05d97.1632437225.git.quic_cgoldswo@quicinc.com>
 <20210929101028.GB21057@willie-the-truck>
 <13f56b37-afc7-bf6f-d544-8d6433588bf9@redhat.com>
 <20210929104241.GA21395@willie-the-truck>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <b0717829-c8dd-c7c0-47bb-5392ed22f700@redhat.com>
Date:   Wed, 29 Sep 2021 12:49:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210929104241.GA21395@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.21 12:42, Will Deacon wrote:
> On Wed, Sep 29, 2021 at 12:29:32PM +0200, David Hildenbrand wrote:
>> On 29.09.21 12:10, Will Deacon wrote:
>>> On Thu, Sep 23, 2021 at 03:54:48PM -0700, Chris Goldsworthy wrote:
>>>> From: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
>>>>
>>>> After new memory blocks have been hotplugged, max_pfn and max_low_pfn
>>>> needs updating to reflect on new PFNs being hot added to system.
>>>>
>>>> Signed-off-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
>>>> Signed-off-by: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
>>>> ---
>>>>    arch/arm64/mm/mmu.c | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>>> index cfd9deb..fd85b51 100644
>>>> --- a/arch/arm64/mm/mmu.c
>>>> +++ b/arch/arm64/mm/mmu.c
>>>> @@ -1499,6 +1499,11 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>>>    	if (ret)
>>>>    		__remove_pgd_mapping(swapper_pg_dir,
>>>>    				     __phys_to_virt(start), size);
>>>> +	else {
>>>> +		max_pfn = PFN_UP(start + size);
>>>> +		max_low_pfn = max_pfn;
>>>> +	}
>>>
>>> We use 'max_pfn' as part of the argument to set_max_mapnr(). Does that need
>>> updating as well?
>>>
>>> Do we have sufficient locking to ensure nobody is looking at max_pfn or
>>> max_low_pfn while we update them?
>>
>> Only the write side is protected by memory hotplug locking. The read side is
>> lockless -- just like all of the other pfn_to_online_page() machinery.
> 
> Hmm. So the readers can see one of the variables updated but the other one
> stale?

Yes, just like it has been on x86-64 for a long time:

arch/x86/mm/init_64.c:update_end_of_memory_vars()

Not sure if anyone really cares about slightly delayed updates while 
memory is getting hotplugged. The users that I am aware of don't care.

-- 
Thanks,

David / dhildenb

