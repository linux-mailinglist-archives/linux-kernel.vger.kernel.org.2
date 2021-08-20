Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949F13F2941
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 11:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbhHTJep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 05:34:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39804 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236384AbhHTJeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 05:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629452046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oj5lPeBAGbuyoGGE5z4/p2o4xyxnrkOwb/UDSLJ14wg=;
        b=QxDOIftqjDGDfDlV9MeMQHHXWi0uKL08zkQbwDxbhJlaxo1bvuNR9LlJo+msEtHt2gk+jY
        fpvMnixPYx90lK/5v+L6Na5SPTLg3wZSyJkWj17H7MRgnKlqyUq3UcdPXexf0vG+cLJ2NZ
        6VbsbWfuSO0kRG0e19w+GKh4AWU3d68=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-AXWLOEaXN5qifsXJAMEWjA-1; Fri, 20 Aug 2021 05:34:04 -0400
X-MC-Unique: AXWLOEaXN5qifsXJAMEWjA-1
Received: by mail-wm1-f71.google.com with SMTP id z15-20020a7bc7cf0000b02902e6a68ffd3cso2268300wmk.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 02:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=oj5lPeBAGbuyoGGE5z4/p2o4xyxnrkOwb/UDSLJ14wg=;
        b=YJoaMy+PHMYDl4GRT928Q64Cr5+lZyF88Frk+8gOhEbHPoj7WrPx0j0hIkNgLusudS
         n9U2tNrSnnGrZQjwbSQzvWCXMVnCegSKFr5GB8QyElYu2LXm20ZQ2mVLwOb6vHVcKT0D
         BoIhgyidHauAQKpLo3oDLIKHDeJiCM8KIiN60KqS37vlnTOWfWs3c9ux1Up2BliPEUJq
         Lm8sNqVsuuMwSBTOpwoiSNUYNyAlLm5pkCbLL+XeBhVL/9M21Fj/W18SMLfFaBcO5RmD
         NwRsDH+m0jOAU2K37j5s8e+BMmht1QZ3QZQKPHIlzd/XWI5Qm7qYqIrWjL6eHl7OyB5R
         04Iw==
X-Gm-Message-State: AOAM530ja6i1m6NEcOprBOe7RJaC8eRUMoxSH3nm2C0vjriJYyOdNXrn
        i+RzqUKj9fvusKEbCvmK9PW4Zpul5QoBDnJiBhg+rn4bgnIT9CnX9EDIvnuax30kZB3QDAXqBGB
        bnYqXnjRUW8SkreefmZju6dr7la6GBQkOV2V+EIFfXj/FdhHrTnp1cxSXxVGrHW2eXCLwhHy3
X-Received: by 2002:a05:600c:290:: with SMTP id 16mr2897472wmk.187.1629452043530;
        Fri, 20 Aug 2021 02:34:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVzF0rjWtuGKhd/O2dwJr299YAZ3UWb3hPWAk5VMqYr9FPfGme1sknLeeqn51GiGFEvmKZQg==
X-Received: by 2002:a05:600c:290:: with SMTP id 16mr2897459wmk.187.1629452043355;
        Fri, 20 Aug 2021 02:34:03 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id g6sm5064515wmq.14.2021.08.20.02.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 02:34:02 -0700 (PDT)
Subject: Re: [v2 PATCH 2/3] doc: hwpoison: correct the support for hugepage
To:     Yang Shi <shy828301@gmail.com>, naoya.horiguchi@nec.com,
        osalvador@suse.de, tdmackey@twitter.com, willy@infradead.org,
        akpm@linux-foundation.org, corbet@lwn.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210819054116.266126-1-shy828301@gmail.com>
 <20210819054116.266126-2-shy828301@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <5f997033-bc14-4dac-91f3-ab50da639823@redhat.com>
Date:   Fri, 20 Aug 2021 11:34:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210819054116.266126-2-shy828301@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.08.21 07:41, Yang Shi wrote:
> The hwpoison support for huge page, both hugetlb and THP, has been in
> kernel for a while, the statement in document is obsolete, correct it.
> 
> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
> v2: * Collected ack from Naoya Horiguchi
> 
>   Documentation/vm/hwpoison.rst | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/vm/hwpoison.rst b/Documentation/vm/hwpoison.rst
> index a5c884293dac..89b5f7a52077 100644
> --- a/Documentation/vm/hwpoison.rst
> +++ b/Documentation/vm/hwpoison.rst
> @@ -180,7 +180,6 @@ Limitations
>   ===========
>   - Not all page types are supported and never will. Most kernel internal
>     objects cannot be recovered, only LRU pages for now.
> -- Right now hugepage support is missing.
>   
>   ---
>   Andi Kleen, Oct 2009
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

