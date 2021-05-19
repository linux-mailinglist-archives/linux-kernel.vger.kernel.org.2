Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC603892D3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354945AbhESPn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:43:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34792 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242076AbhESPnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:43:55 -0400
Received: from mail-qk1-f199.google.com ([209.85.222.199])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1ljOLD-0005oO-3i
        for linux-kernel@vger.kernel.org; Wed, 19 May 2021 15:42:35 +0000
Received: by mail-qk1-f199.google.com with SMTP id 78-20020a3703510000b02903a5be8eaaadso1991510qkd.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y58HNIGfyjO1NHrX6PUICkpjj0HsKsC4MLHocdrJRYk=;
        b=KtWxNKrJbM/u9vprpb3RhSKk+30WbuszzwcbbyOdYK3js/ENSl8qonfVwQK/0dSK8r
         HQQhNYOOf3PiaCcw9fEK3beGtwidW+sU4T4HxtxYuf9yUz+yCgXo4URM9S7ZLKeMmEYg
         Y6g+ekDTGhuPflKSWHjijgCSEo553Q7xh2iMERtOKaNbA/ZNSq5na5aXSBzeG4FaEHBt
         6N033taZE/nhAocukqIM+RiuZtr7oLGfLoDSqyc0G1nb/pNWaFpzWwBEkFgkBvPMhxG5
         xHBONuAr//ni09q6Nw4shUiZErrPSN60tCdwGrE97TAR1APs9C4wQwemLnSjP2jhCLcM
         6Ssg==
X-Gm-Message-State: AOAM531vyrztN2SvkBwowcWLyGFp81RsXrAP/o5hsn4BAod3Z2pULKq7
        6ejO5N4AOv4S3rnrfkm4OfODU3zGfXB0FK1KKcp3KhFBwLQKfuP0ZZgqOCi8fI4UdC5xCoJPKnL
        eMF0jXB9AGEZWQj/xi5Fgdk9TzRiy2CSQTZ+aloo7Sw==
X-Received: by 2002:a05:6214:148a:: with SMTP id bn10mr54285qvb.40.1621438954267;
        Wed, 19 May 2021 08:42:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzM3qJR3wRrIB8QCZlm0Kqj1eQyfF0OiKakSDAmRtrZDGKvkzveVMOvfO4jeZ8NFVcIbMF/dw==
X-Received: by 2002:a05:6214:148a:: with SMTP id bn10mr54270qvb.40.1621438954117;
        Wed, 19 May 2021 08:42:34 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.3])
        by smtp.gmail.com with ESMTPSA id h2sm22576qkf.106.2021.05.19.08.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 08:42:33 -0700 (PDT)
Subject: Re: [PATCH] mm, page_alloc: really disable DEBUG_PAGEALLOC with
 hibernation
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Akinobu Mita <akinobu.mita@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Guilherme Piccoli <gpiccoli@canonical.com>
References: <20210519152804.27063-1-krzysztof.kozlowski@canonical.com>
 <b0cf875b-6ff5-2b5c-8b3d-6dc6c75b8be8@redhat.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <e5d9f4f1-c27f-63f5-0681-85b0697f5480@canonical.com>
Date:   Wed, 19 May 2021 11:42:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <b0cf875b-6ff5-2b5c-8b3d-6dc6c75b8be8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2021 11:30, David Hildenbrand wrote:
> On 19.05.21 17:28, Krzysztof Kozlowski wrote:
>> The documentation of DEBUG_PAGEALLOC states that it cannot be used with
>> hibernation, however the Kconfig entry would allow it if
>> ARCH_SUPPORTS_DEBUG_PAGEALLOC && !PPC && !SPARC.
>>
>> Fixes: ee3b4290aec0 ("generic debug pagealloc: build fix")
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>   mm/Kconfig.debug | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
>> index 1e73717802f8..0ace5b2a9d04 100644
>> --- a/mm/Kconfig.debug
>> +++ b/mm/Kconfig.debug
>> @@ -11,7 +11,7 @@ config PAGE_EXTENSION
>>   config DEBUG_PAGEALLOC
>>   	bool "Debug page memory allocations"
>>   	depends on DEBUG_KERNEL
>> -	depends on !HIBERNATION || ARCH_SUPPORTS_DEBUG_PAGEALLOC && !PPC && !SPARC
>> +	depends on !HIBERNATION && ARCH_SUPPORTS_DEBUG_PAGEALLOC && !PPC && !SPARC
>>   	select PAGE_POISONING if !ARCH_SUPPORTS_DEBUG_PAGEALLOC
>>   	help
>>   	  Unmap pages from the kernel linear mapping after free_pages().
>>
> 
> I remember this should be working now, as we temporarily map the pages 
> in the direct map when hibernating?

Let me actually test it on x86_64...


Best regards,
Krzysztof
