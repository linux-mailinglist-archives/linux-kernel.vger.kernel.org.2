Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB71A3892AD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354891AbhESPcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46664 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347056AbhESPb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621438239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nLqovgw38I1s9PDFvH/lHxAGHLB7WoNm6rgCI8LOhXw=;
        b=dQfE/zsdm2Z0DhF9Kr4yes0ohyh+YZzvHFDkkmPHoksO1y8w+0lQHuRxT5T2MoyLc1Kf2j
        DTQqk3e4bfELQWdX1PpvM/qNd8/IgTvYhGk1V8TjbBk9f23jYFmzHTC0vHzlxsbgMp2ewA
        6FrBLlKTwrMD5M5Rgs3is8rMv2VnMbU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-PN-95zsPPZ-LXAMSkpHd_A-1; Wed, 19 May 2021 11:30:37 -0400
X-MC-Unique: PN-95zsPPZ-LXAMSkpHd_A-1
Received: by mail-wm1-f71.google.com with SMTP id o126-20020a1c28840000b0290149b8f27c99so1718580wmo.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nLqovgw38I1s9PDFvH/lHxAGHLB7WoNm6rgCI8LOhXw=;
        b=H+rJm++FGwaDkJfXal30g0b/gyN34USprzbqLIc7OqV4tqqolrw0hFRWLjd78ocPCh
         ZrfD7Jnt236LrYawLx/Au6aIvFu0S66vuP/jJwwwNb56rgSV+67MCATmyDV/F35raibl
         6hS5OkdfCEMdu0HLLKGxs/IK2QbkpMRPa6HRqOalwaPT1kuemQsE8b+4IHJbS7qFgl65
         BWOx/MQKLIerK5thf3HoLxIgXgVn4HN29JtQbKdM6kTV/0nA9RPP6PF/GIm03tvgJVMz
         w5pB6trooOa6Mk5NVESD7tdqRxXWqTsLh7CIvEGemukgE0Gr+ttV4qJg5MPykmC0ZnJe
         UkCQ==
X-Gm-Message-State: AOAM5310AygScCz3/CtVZFTMYotHCgdfaGNyaz0/v7QlHyTShDwsTz9O
        /x/jUEjQyvKPIKV3JY7VWq2OQXqQIz937kl4gopVQyBJAX0p4ntiKKg2FxthWYB10V8QqbveYHh
        OL/mAJB8ee9fGg2PogAXfSrMD
X-Received: by 2002:adf:d231:: with SMTP id k17mr14840655wrh.78.1621438236702;
        Wed, 19 May 2021 08:30:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRYuEK43nmO1YHfcCigSmsZAamcj+zdpnL50T0osnmkHiq2E9iWd2Tk5z17BC+S2plYI7zeg==
X-Received: by 2002:adf:d231:: with SMTP id k17mr14840631wrh.78.1621438236516;
        Wed, 19 May 2021 08:30:36 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6694.dip0.t-ipconnect.de. [91.12.102.148])
        by smtp.gmail.com with ESMTPSA id 6sm24696940wry.60.2021.05.19.08.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 08:30:36 -0700 (PDT)
Subject: Re: [PATCH] mm, page_alloc: really disable DEBUG_PAGEALLOC with
 hibernation
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Akinobu Mita <akinobu.mita@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Guilherme Piccoli <gpiccoli@canonical.com>
References: <20210519152804.27063-1-krzysztof.kozlowski@canonical.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <b0cf875b-6ff5-2b5c-8b3d-6dc6c75b8be8@redhat.com>
Date:   Wed, 19 May 2021 17:30:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210519152804.27063-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.05.21 17:28, Krzysztof Kozlowski wrote:
> The documentation of DEBUG_PAGEALLOC states that it cannot be used with
> hibernation, however the Kconfig entry would allow it if
> ARCH_SUPPORTS_DEBUG_PAGEALLOC && !PPC && !SPARC.
> 
> Fixes: ee3b4290aec0 ("generic debug pagealloc: build fix")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>   mm/Kconfig.debug | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index 1e73717802f8..0ace5b2a9d04 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -11,7 +11,7 @@ config PAGE_EXTENSION
>   config DEBUG_PAGEALLOC
>   	bool "Debug page memory allocations"
>   	depends on DEBUG_KERNEL
> -	depends on !HIBERNATION || ARCH_SUPPORTS_DEBUG_PAGEALLOC && !PPC && !SPARC
> +	depends on !HIBERNATION && ARCH_SUPPORTS_DEBUG_PAGEALLOC && !PPC && !SPARC
>   	select PAGE_POISONING if !ARCH_SUPPORTS_DEBUG_PAGEALLOC
>   	help
>   	  Unmap pages from the kernel linear mapping after free_pages().
> 

I remember this should be working now, as we temporarily map the pages 
in the direct map when hibernating?

-- 
Thanks,

David / dhildenb

