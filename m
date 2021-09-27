Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AE4419FEC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 22:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236948AbhI0UQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 16:16:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35959 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236763AbhI0UQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632773668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bvHg/uBwvsvNY/OXqNLlISNWOe/HagnQIQssDsWD3dA=;
        b=eP062b5mhij72Si8HOUBM9YnUPhiFEqkb3Ae5lpg9zxf5J4zHpw1pxe6OEFruSD2Snqnom
        72KoxECycuVu/6Ojl7KqpSrCqQUYOEzZe0gm9E4zDjZO/X6jPCJoX+Ej6dc2HwmOmR1780
        cqY1pPi+veBemHjD76bSdjIuquJI4Mg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-OdCvNAmUNNOUree_qELf7w-1; Mon, 27 Sep 2021 16:14:27 -0400
X-MC-Unique: OdCvNAmUNNOUree_qELf7w-1
Received: by mail-wm1-f71.google.com with SMTP id l42-20020a05600c1d2a00b0030d02f09530so355735wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bvHg/uBwvsvNY/OXqNLlISNWOe/HagnQIQssDsWD3dA=;
        b=KHuM/eg2Lj+albuZ8WmHQ1VaHWgK1JbtGIDq5YeSESU1Q2N6C2QtX6Fd6ueHY2sqjV
         EZyXZ6SHamcqKIrtIYiDFpBNBKx532v609jUVCovIEUuhfN+cP10wSEiHpHPvUWmBygu
         eIt77FZ+QPHfdWR1H4yzZBlLaEG7NkoOXOY38FLdto/X1lGjBZ86Q8Clm7/m20Ae50Xe
         Q63RiiuUmv2mlrsSyrfV77rzb/Nqv+TGHl43RL4oebssz6UHljgiN2kouR2Bnok4Zxqw
         iSJtCp42La69QA26Sa5BGfIH6xZwI9Nf7tN5WQMl4UlZar9MmliK+tE9yHL73DiPGiam
         dvvA==
X-Gm-Message-State: AOAM530nKZx5jyXSZvFpm73iUAdaVhAOg9GIpRGWOZLt2iqZxXT720jj
        sT+MO1v8dovqqni6I1f6H4xfsG4CcyZFQexBYtYES3RX9C4lc5/XscoS/KclWVdiEAhQ1XkeFhZ
        Gnolny5L6Bj8/P236ASWAH4Xf
X-Received: by 2002:a05:6000:1a89:: with SMTP id f9mr2082666wry.19.1632773665902;
        Mon, 27 Sep 2021 13:14:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyN4QKYLs7/bVq6YJ7XOJ00JOhlzDFUGM93dO6ngMGXtGto0IGpFm1da0SdSN7xfl27cmIkFA==
X-Received: by 2002:a05:6000:1a89:: with SMTP id f9mr2082654wry.19.1632773665760;
        Mon, 27 Sep 2021 13:14:25 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c654d.dip0.t-ipconnect.de. [91.12.101.77])
        by smtp.gmail.com with ESMTPSA id s13sm472595wmc.47.2021.09.27.13.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 13:14:25 -0700 (PDT)
Subject: Re: [RFC] arm64: mm: update max_pfn after memory hotplug
To:     Georgi Djakov <quic_c_gdjako@quicinc.com>,
        Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
References: <cover.1632437225.git.quic_cgoldswo@quicinc.com>
 <595d09279824faf1f54961cef52b745609b05d97.1632437225.git.quic_cgoldswo@quicinc.com>
 <4f4f6e93-ddc2-c9bb-ef47-4a40f2c3d0d7@quicinc.com>
 <1b9c4377-0a6b-b7d4-7a6b-a69f9469bb70@redhat.com>
 <c83b7e80-0a16-d83f-f3f4-ab0b32c7753b@quicinc.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <a2712ae7-ecbb-ef74-4b73-d31b152cbab1@redhat.com>
Date:   Mon, 27 Sep 2021 22:14:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c83b7e80-0a16-d83f-f3f4-ab0b32c7753b@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.09.21 22:00, Georgi Djakov wrote:
> On 9/27/2021 8:34 PM, David Hildenbrand wrote:
>> On 27.09.21 19:22, Georgi Djakov wrote:
>>> On 9/24/2021 1:54 AM, Chris Goldsworthy wrote:
>>>> From: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
>>>>
>>>> After new memory blocks have been hotplugged, max_pfn and max_low_pfn
>>>> needs updating to reflect on new PFNs being hot added to system.
>>>>
>>>> Signed-off-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
>>>> Signed-off-by: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
>>>
>>> Thanks for the patch, Chris!
>>>
>>> With this patch, the data in /proc/kpageflags appears to be correct and
>>> memory tools like procrank work again on arm64 platforms.
>>>
>>> Tested-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
>>>
>>> Maybe we should add fixes tag, as it has been broken since the following
>>> commit:
>>> Fixes: abec749facff ("fs/proc/page.c: allow inspection of last section
>>> and fix end detection")
>>
>> Are you sure that that commit broke it?
> 
> Reverting the above commit also "fixes" kpageflags, otherwise
> kpageflags_read() returns 0 in the following check:
> 	if (src >= max_dump_pfn * KPMSIZE)
> 		return 0;
> 
>> I recall that we would naturally run into the limit, because
>>
>> count = min_t(size_t, count, (max_pfn * KPMSIZE) - src);
> 
> The function returns before we reach this line.

That is the old code. I don't see how the behavior of the old code with 
wrong max_pfn was doing what it's supposed to do.

page_idle and page_owner also rely on max_pfn. The root issue is that 
max_pfn wasn't updated properly.

-- 
Thanks,

David / dhildenb

