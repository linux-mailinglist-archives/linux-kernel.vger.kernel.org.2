Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AC03E428B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 11:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbhHIJWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 05:22:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28846 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234232AbhHIJWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 05:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628500944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d2MQnKwZsGRoAzDpeTtcqLkuwneJdVDfIOk31bAzcPs=;
        b=Uv8uv29xzHUQC4YveFepV3YBXD4eoH2cVVYcu57C5LqyAmliqvhMuGNw7A7qBEaKOoQEyK
        hrPBa8MuNmNelaFO2cxHlGklY5zon7iroPjCDoQ0bpWaKcwLk3U1Ewz4fusLsJdRLJJjyb
        L1F4hoT5osNAPTBSk11mrDjLP12tPrM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-LFC1dD8NOs2a01a7ggf8Ew-1; Mon, 09 Aug 2021 05:22:22 -0400
X-MC-Unique: LFC1dD8NOs2a01a7ggf8Ew-1
Received: by mail-wm1-f70.google.com with SMTP id y186-20020a1c32c30000b02902b5ac887cfcso5099034wmy.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 02:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=d2MQnKwZsGRoAzDpeTtcqLkuwneJdVDfIOk31bAzcPs=;
        b=WKZqj1zlH9KKGIozJ27Kc7wvLe3Dd6FzcFqHUTThQbkMagBn/Ss8qbmafoECMyZ+8d
         j4BymKzmwIT759ylyDnHbo9LTrmxoZtSRzq7QYF+rQbuVdDsLHK+ypf/oJVrv0W2rBhF
         0QY7blECKYJYBQbira4xl4QOscxIMkhL+2/2JLDyKgIuI5aHvOdp4dxmbIpZcgxuxcKS
         boNTxYNGmJR99Oq61U7YP2jcmIGrE2KnSNugr4SsRyDO+UhSRg0bqoT3QeE2EOWzR83f
         Gkmjv3Rakj6QPU7dISPkL2QMnU3ZXhzL7GezafHLXufrJp4wp/xMRIoEz/0yAZ8a3kcb
         TRBg==
X-Gm-Message-State: AOAM532d5g4HT6oM1BJ9Fo4b0tDhm2ifytJIa3CzoFihGkPbUN3X/+PF
        TuXgYs9lS+mkNogfxpBBLuTGp2gMrxPCVbAAQSfkzE9xfiIcRyw4ma/2tHbq+I1ssCqjlVoKcXA
        CkqmnwKcaAU5240X9tqn3RAwYwDjAhnmEyLm2TEPXGwDOMV/TZRw1jV4Mqh3ZTmnnsQkvBPP6
X-Received: by 2002:a1c:2255:: with SMTP id i82mr15568891wmi.146.1628500940931;
        Mon, 09 Aug 2021 02:22:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRiBjgZvz6ATDRHvOY/FjWvVBU9kMu4H51Dz3FkVdvGcOuXfEcRnOCziQgNF6kZGWFBbLPQg==
X-Received: by 2002:a1c:2255:: with SMTP id i82mr15568864wmi.146.1628500940697;
        Mon, 09 Aug 2021 02:22:20 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id k1sm19352793wrz.61.2021.08.09.02.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 02:22:20 -0700 (PDT)
Subject: Re: [PATCH 2/5] mm: gup: remove unneed local variable orig_refs
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     imbrenda@linux.ibm.com, kirill.shutemov@linux.intel.com,
        jack@suse.cz, jhubbard@nvidia.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210807093620.21347-1-linmiaohe@huawei.com>
 <20210807093620.21347-3-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <6deed9a0-a1fc-161d-b6f7-b1116212fbde@redhat.com>
Date:   Mon, 9 Aug 2021 11:22:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210807093620.21347-3-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.08.21 11:36, Miaohe Lin wrote:
> Remove unneed local variable orig_refs since refs is unchanged now.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   mm/gup.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 430495cb1b91..d6056dcab02c 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -117,8 +117,6 @@ __maybe_unused struct page *try_grab_compound_head(struct page *page,
>   	if (flags & FOLL_GET)
>   		return try_get_compound_head(page, refs);
>   	else if (flags & FOLL_PIN) {
> -		int orig_refs = refs;
> -
>   		/*
>   		 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
>   		 * right zone, so fail and let the caller fall back to the slow
> @@ -150,7 +148,7 @@ __maybe_unused struct page *try_grab_compound_head(struct page *page,
>   			page_ref_add(page, refs * (GUP_PIN_COUNTING_BIAS - 1));
>   
>   		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_ACQUIRED,
> -				    orig_refs);
> +				    refs);
>   
>   		return page;
>   	}
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

