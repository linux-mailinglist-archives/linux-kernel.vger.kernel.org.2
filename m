Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057553CF966
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 14:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237079AbhGTLb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 07:31:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47593 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235205AbhGTLbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 07:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626783115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oReIL6acdVDkxRaEqov1JhvUFfGcr08r8jgYKed1STE=;
        b=EWLL2mUB7JpTmVbnaL9yEEZyx5ty/LSyMaHjfPoGutmUG+3K8PWZToRKH+tlQofuxvhFkR
        IXEzEmYzOhplifBhZ8EtrlZgjN6/O3V8paM18Rqe2o4MzmNGUra5RGAM4MbCXOcYJTqQi4
        327XW/qY6lMw0tuvxE5UbV8OcHSgrnQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-bnzNqdaKORWJKJkufYT1BQ-1; Tue, 20 Jul 2021 08:11:54 -0400
X-MC-Unique: bnzNqdaKORWJKJkufYT1BQ-1
Received: by mail-wm1-f69.google.com with SMTP id o21-20020a05600c4fd5b029023448cbd285so1183188wmq.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 05:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=oReIL6acdVDkxRaEqov1JhvUFfGcr08r8jgYKed1STE=;
        b=dXfi9rWpD3kvp8w6T6GMkQUTQWJwidq5iwxstSemvqHpwIl3+zp1mg+9A9XrddZZTQ
         ZX6P11rADUluYnDhY7vJ1yhSucbvAJ8pS2DslbczT1cv56nf475Yv0h10F4IfCD1jzyy
         BIRIH81brjqs6aasCmhbt0Ofezz/RzxTIPrq1DM2m31yPDbt+AAfAfEZemV+rSx/apCr
         LGIoKmCVVa9HcRFZOiJYl/ijowlFaWAsEhpLwQlCfsFzsdhwcpcUrqndzFbzYq6+qQIL
         WKobE2iezVPoGXJMSrEydHcwQa1Yd+4oSbAhHl0Q2+k617lVzUN58x5emM4bseJIM75d
         K9Fg==
X-Gm-Message-State: AOAM530WZwQwXlAP8f4zpXMgnqmCYmBEgSqsfEaJnOeX3ve8ij2RA5rS
        ghvbzq41T10+x/lfRMGB1o0QoeJMpWmytPTe7fRzOoOosQrDJfFbHJxr5WDJPRDOjX8meOWOtxL
        Ut2uNvYx+HN1MNRSQxLjhushr
X-Received: by 2002:a05:6000:1886:: with SMTP id a6mr19531347wri.17.1626783113311;
        Tue, 20 Jul 2021 05:11:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUyH4RPmU2Nt4iB8VUVazFrWJUphlow/MIFR3IlF6/bUWocqsQSCiw4NMPoarv9klOzn3T1g==
X-Received: by 2002:a05:6000:1886:: with SMTP id a6mr19531331wri.17.1626783113131;
        Tue, 20 Jul 2021 05:11:53 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id n5sm22627506wri.31.2021.07.20.05.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 05:11:52 -0700 (PDT)
Subject: Re: [PATCH] mm: make falutaround selectable
To:     Chanho Min <chanho.min@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Gunho Lee <gunho.lee@lge.com>, Juneho Choi <juno.choi@lge.com>,
        Inkyu Hwang <inkyu.hwang@lge.com>
References: <20210719010845.31898-1-chanho.min@lge.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <42adbf38-7b1a-3039-c309-3d7023fc7c6c@redhat.com>
Date:   Tue, 20 Jul 2021 14:11:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210719010845.31898-1-chanho.min@lge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/falutaround/faultaround/


On 19.07.21 03:08, Chanho Min wrote:
> While faultaround can have performance gains, on certain platform it
> increases pss and causes swap to occur more frequently. This patch allows
> to unselect faultaround on platforms that do not want this behavior.
> 
> Signed-off-by: Chanho Min <chanho.min@lge.com>
> ---
>   mm/Kconfig  | 6 ++++++
>   mm/memory.c | 4 ++++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 39a6a977537d..8f834386e7f3 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -750,4 +750,10 @@ config ARCH_HAS_PTE_SPECIAL
>   config ARCH_HAS_HUGEPD
>   	bool
>   
> +config FAULT_AROUND
> +	bool "Enable fault around"
> +	default y
> +	help
> +	 This option enables fault around. If say N, fault_around_bytes set to PAGE_SIZE
> +	 and disables fault around.
>   endmenu
> diff --git a/mm/memory.c b/mm/memory.c
> index 10d2e4734e82..0bb037265dda 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3500,7 +3500,11 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>   }
>   
>   static unsigned long fault_around_bytes __read_mostly =
> +#ifdef CONFIG_FAULT_AROUND
>   	rounddown_pow_of_two(65536);
> +#else
> +	PAGE_SIZE;
> +#endif
>   
>   #ifdef CONFIG_DEBUG_FS
>   static int fault_around_bytes_get(void *data, u64 *val)
> 


-- 
Thanks,

David / dhildenb

