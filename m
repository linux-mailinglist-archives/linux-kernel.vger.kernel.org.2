Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A1F41A9B9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 09:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239308AbhI1HfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 03:35:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40306 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239099AbhI1HfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 03:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632814422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OYz+v29nGxeHeDCVuishN/mp+dYCX8a4fOHFuVjh5gs=;
        b=OR0EGBELV62S3xFoabAwfXuT3L2tiMc5OLYL1fvE2NT/ct/5NrcnhXh0N0rhCew2pIHrKi
        ezJhhfGuX/kosjZXq01Ta7IuP7NFLEXZ0omp31GcyNBDTmX4Hyhxe7/iL4NrTZzGYxSuZv
        YAV73N+q/x03BoS0efmYTmG6sj6JV6g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-sCFdw7FXMpeoOwUkahdvCw-1; Tue, 28 Sep 2021 03:33:40 -0400
X-MC-Unique: sCFdw7FXMpeoOwUkahdvCw-1
Received: by mail-wr1-f71.google.com with SMTP id w2-20020a5d5442000000b0016061c95fb7so4036066wrv.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 00:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OYz+v29nGxeHeDCVuishN/mp+dYCX8a4fOHFuVjh5gs=;
        b=NU/+q7XA+4xSMEc5yE6sPCVq8rA+dhjI0CEv5Ags8denXxCZkwmmvHwQx14GsMRwak
         YeIbBVEqHYnxsQ79yJ/MuD9oatId1wFN3x3XYCLD8XmNpe2GdMGs0qpTiieanpmmV5/P
         VOOSxl8W4XY3k2K9ExGQTo7TRnLFCgwsKx8RTC+DEP6/ZdKt/3lpPjUg+LHYvkd2pPyr
         wY3SQ7NdGX11iKqenpuSRx520ijzkZSsm6RjfMH1MLrScmK2KpUN2B/NxkaoObChWQnk
         VMehAS4zayaiEeSGup+emDMagKSEy1LWajf/zRs3vR5SXqETY0GxQqCppjsZjR/Bqpmf
         2LLg==
X-Gm-Message-State: AOAM533V5/XItRjtMVhcJOP7CuJrvyrXF/HIT5UGa2Flu/ESamkweP7n
        Lg1JgjQShIJ7iVIvxuibT1BjvqAMOeJtX8mgtbtWV2l6iH6zyTcCOw3ipzWiL/4wWtic/EpG5UZ
        kfmvT0QJRwxo1zxFt4eDpPR2m
X-Received: by 2002:a1c:7508:: with SMTP id o8mr3225584wmc.104.1632814419727;
        Tue, 28 Sep 2021 00:33:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxWXiGZvnB6GUJwp2DOW/nbkfRswJql3lOq0+lQkDQGwa+PRs4wC1QT/i6WPZ62UWk/FJ+6w==
X-Received: by 2002:a1c:7508:: with SMTP id o8mr3225559wmc.104.1632814419395;
        Tue, 28 Sep 2021 00:33:39 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23aaf.dip0.t-ipconnect.de. [79.242.58.175])
        by smtp.gmail.com with ESMTPSA id g25sm18544739wrc.88.2021.09.28.00.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 00:33:38 -0700 (PDT)
Subject: Re: [RFC] arm64: mm: update max_pfn after memory hotplug
To:     Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
References: <cover.1632437225.git.quic_cgoldswo@quicinc.com>
 <595d09279824faf1f54961cef52b745609b05d97.1632437225.git.quic_cgoldswo@quicinc.com>
 <833493d2-d585-47ee-c258-79eae5deff36@redhat.com>
 <ed2f59dc-ecd3-ae9c-e44c-81e903c6f08f@quicinc.com>
 <20210928061016.GA28837@hu-cgoldswo-sd.qualcomm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <94d477d0-5d05-b2c3-850e-0a749c888f3b@redhat.com>
Date:   Tue, 28 Sep 2021 09:33:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210928061016.GA28837@hu-cgoldswo-sd.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.09.21 08:12, Chris Goldsworthy wrote:
> On Tue, Sep 28, 2021 at 02:22:59AM +0300, Georgi Djakov wrote:
>> On 9/27/2021 6:51 PM, David Hildenbrand wrote:
>>> On 24.09.21 00:54, Chris Goldsworthy wrote:
>>>> From: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
>>>>
>>>> After new memory blocks have been hotplugged, max_pfn and max_low_pfn
>>>> needs updating to reflect on new PFNs being hot added to system.
>>>>
>>>> Signed-off-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
>>>> Signed-off-by: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
>>>> ---
>>>>    arch/arm64/mm/mmu.c | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>>> index cfd9deb..fd85b51 100644
>>>> --- a/arch/arm64/mm/mmu.c
>>>> +++ b/arch/arm64/mm/mmu.c
>>>> @@ -1499,6 +1499,11 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>>>        if (ret)
>>>>            __remove_pgd_mapping(swapper_pg_dir,
>>>>                         __phys_to_virt(start), size);
>>>> +    else {
>>>> +        max_pfn = PFN_UP(start + size);
>>>> +        max_low_pfn = max_pfn;
>>>> +    }
>>>> +
>>>>        return ret;
>>>
>>> Note: didn't verify if updating max_low_pfn is correct here.
>>
>> My understanding is that max_low_pfn defines the low/high memory
>> boundary and it should be also updated.
>>
>> Thanks,
>> Georgi
> 
> To build more on Georgi's response, our assumption here after an offline
> discussion is that max_low_pfn would not be equal to max_pfn only if there is
> high memory - another assumption is that arm64 kernels will not need high memory
> due to their large logical mappings. Under these two assumptions, the patch is
> correct. Perhaps Catalin can ack or critique this, as he initially set max_pfn =
> max_low_pfn in the first arm64 mm initialization code:

Makes sense to me, thanks.


-- 
Thanks,

David / dhildenb

