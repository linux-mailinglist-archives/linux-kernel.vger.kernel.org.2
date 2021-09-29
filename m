Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA86E41C2B8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 12:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245495AbhI2KbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 06:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35503 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240310AbhI2KbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 06:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632911377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C57om5FTtgEGHf0KUu9I3TAtRy+1t/YR1bYrwybiKdg=;
        b=ObnAfQC+oZ8P8sQE7XbRP46JkY8iKzU8AWeRQdAqNJYxjW81ojrS5OoF4omZTjqLoh0npi
        xEsQa64UKr4yl5VO+zvC5l6zjo1RyBZj2pG/I9Rc7Isuv/0c5PQiU1YVTSft1/2Zky2VSP
        IqbaXyD9Mw5gp3BX1vcb32hpXom0Xn8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-TcQv7g42NLK_Y__M5a5H4Q-1; Wed, 29 Sep 2021 06:29:35 -0400
X-MC-Unique: TcQv7g42NLK_Y__M5a5H4Q-1
Received: by mail-wm1-f71.google.com with SMTP id j21-20020a05600c1c1500b00300f1679e4dso2506450wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 03:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=C57om5FTtgEGHf0KUu9I3TAtRy+1t/YR1bYrwybiKdg=;
        b=wBlSaW5SsDD3xPIwURTHGwCCugy9EEiD7GkccMNN0jI5ddEl1e9zhXeezNlXHxavRA
         F8brzGs4qFv4+3OqeY7NuQSI3EHPSkE9MENGxA8FiXBfpKRd2VpYDyaNZ3nm+yy9ZXgg
         8kZ4fIXW4P6LQV+M3mvrhqgFWmTEjdl7+xVDnA6VdWnl+mGCWE9pNXFBRW9035S1dEqx
         7RnbQVcZLuvj61FXaLr8oxghOuLjpyXUjJeWWK/HN+u56oCN4VA/IqE3VMTIRPlPOPF+
         gRNo8YDyOXdbZ1c9natBhgTxkTUHjugppSg0fZIS+jzG6e7y9Y6TL3EpWWVIldQJu5E7
         JbVQ==
X-Gm-Message-State: AOAM530rBjDthb1mPMjYR3DuRvQTORNkmapcBTB+M8GSo62DS6gHY4km
        qdZfgExXX0ug6g3ORD5ZDMg+W3+dfiqtWijS8gVFowkQxUZq60unOFcwF5YxzrPyZmReHXBgKzE
        5kXG8v0LBJ3m3MQ1FZkDaExjK
X-Received: by 2002:adf:f550:: with SMTP id j16mr5595988wrp.41.1632911374157;
        Wed, 29 Sep 2021 03:29:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoEJW17D0Lrj3daOOwl1NQdJV/1r6ta6M9qUfNhDLFaw6jkYos9wruOZx63emdJSLA+Xnxvw==
X-Received: by 2002:adf:f550:: with SMTP id j16mr5595975wrp.41.1632911373970;
        Wed, 29 Sep 2021 03:29:33 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23c3b.dip0.t-ipconnect.de. [79.242.60.59])
        by smtp.gmail.com with ESMTPSA id z6sm1654271wmp.1.2021.09.29.03.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 03:29:33 -0700 (PDT)
Subject: Re: [RFC] arm64: mm: update max_pfn after memory hotplug
To:     Will Deacon <will@kernel.org>,
        Chris Goldsworthy <quic_cgoldswo@quicinc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
References: <cover.1632437225.git.quic_cgoldswo@quicinc.com>
 <595d09279824faf1f54961cef52b745609b05d97.1632437225.git.quic_cgoldswo@quicinc.com>
 <20210929101028.GB21057@willie-the-truck>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <13f56b37-afc7-bf6f-d544-8d6433588bf9@redhat.com>
Date:   Wed, 29 Sep 2021 12:29:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210929101028.GB21057@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.21 12:10, Will Deacon wrote:
> On Thu, Sep 23, 2021 at 03:54:48PM -0700, Chris Goldsworthy wrote:
>> From: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
>>
>> After new memory blocks have been hotplugged, max_pfn and max_low_pfn
>> needs updating to reflect on new PFNs being hot added to system.
>>
>> Signed-off-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
>> Signed-off-by: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
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
> We use 'max_pfn' as part of the argument to set_max_mapnr(). Does that need
> updating as well?
> 
> Do we have sufficient locking to ensure nobody is looking at max_pfn or
> max_low_pfn while we update them?

Only the write side is protected by memory hotplug locking. The read 
side is lockless -- just like all of the other pfn_to_online_page() 
machinery.

> 
> Will
> 


-- 
Thanks,

David / dhildenb

