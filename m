Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83530373CBC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 15:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbhEEN4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 09:56:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25563 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233423AbhEEN4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 09:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620222948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wv7DtyHcfs2ySeIED82K+Ecm25ixAiJSXxqrEGIMQCg=;
        b=fgzIgTIEFNNhKhrYWC1s14gP2YeIk37o4C78gK1DdHB3CtLU3eIkMQfnY57TO2Kki9GVfY
        L28mElasnPE0dhOiIaYO0OL3uYaCarK3sXaHj07UbmWlRx22VLWAUgN12zg70+KHQCBn8U
        y1TS0jJ3VdM3wGgl+F0SRrs3g42ghHQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-ek7D1aa8OIyO9TTLXD-Jhg-1; Wed, 05 May 2021 09:55:44 -0400
X-MC-Unique: ek7D1aa8OIyO9TTLXD-Jhg-1
Received: by mail-ed1-f71.google.com with SMTP id r19-20020a05640251d3b02903888eb31cafso883459edd.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 06:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wv7DtyHcfs2ySeIED82K+Ecm25ixAiJSXxqrEGIMQCg=;
        b=OLUFNeVkfNaXC6b4TCf945lHowIoQfbPhRLsx06T1aFsy63dvzajb+0nWKfVMdEZME
         NeGmd3qLMmlg2QoZB3wQWXtF4bN2DwttYMDuPS+z3N4M3d2fKCIYwu3UvpuMQ71HEZ+Y
         JoD2quiRbL1+BiTmDH+o9AUvNslg8kdGx3HE//SUyRoKu0aGHRN5SoyQDOGqu/r/u5wX
         PkI1XG/sWuNLX81arKuuALnZyYAUjTm8vbZ4kZHGfTS72qOTgmWly1tUxgP7Ml+0pFxf
         i+bJ1YlvmU9//mq+Bnh6Tg1uoIswzcc2TSV7hjQCRpCtoS2sCips9JNi5xDX2dHszBIq
         jleA==
X-Gm-Message-State: AOAM530+a3t+qvUF0Z0UbPA22sfgseqivG8980drktRpfpEFuV0W5uAJ
        5zuBtAvi/Yo68LD+Dqlwy0n51KxlxAmwmJFLoZrqPGJmnkE+0ACtQjz8EA8dA1W93qzIaDXx2aS
        jN6WtzgxPBeMCPBu4MLgHppdW
X-Received: by 2002:a05:6402:2750:: with SMTP id z16mr33268678edd.355.1620222943464;
        Wed, 05 May 2021 06:55:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytQVZt8vhG6EO2lG3Vi8QO/JWBTW2KMCExDOxIjfJW7nJy8h6I1m7TMVaMeBYyq3lDQvQNcQ==
X-Received: by 2002:a05:6402:2750:: with SMTP id z16mr33268659edd.355.1620222943254;
        Wed, 05 May 2021 06:55:43 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c63bc.dip0.t-ipconnect.de. [91.12.99.188])
        by smtp.gmail.com with ESMTPSA id k9sm16961732edv.69.2021.05.05.06.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 06:55:43 -0700 (PDT)
Subject: Re: [PATCH] Revert "mm/gup: check page posion status for coredump."
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Aili Yao <yaoaili@kingsoft.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
References: <20210505135407.31590-1-mhocko@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <bedd4817-5b2e-4041-3b55-f8ebfd98505f@redhat.com>
Date:   Wed, 5 May 2021 15:55:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210505135407.31590-1-mhocko@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.05.21 15:54, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> While reviewing http://lkml.kernel.org/r/20210429122519.15183-4-david@redhat.com
> I have crossed d3378e86d182 ("mm/gup: check page posion status for
> coredump.") and noticed that this patch is broken in two ways. First it
> doesn't really prevent hwpoison pages from being dumped because hwpoison
> pages can be marked asynchornously at any time after the check.
> Secondly, and more importantly, the patch introduces a ref count leak
> because get_dump_page takes a reference on the page which is not
> releases.
> 
> It also seems that the patch was merged incorrectly because there were
> follow up changes not included as well as discussions on how to address
> the underlying problem http://lkml.kernel.org/r/57ac524c-b49a-99ec-c1e4-ef5027bfb61b@redhat.com
> 
> Therefore revert the original patch.
> 
> Fixes: d3378e86d182 ("mm/gup: check page posion status for coredump.")
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>   mm/gup.c      |  4 ----
>   mm/internal.h | 20 --------------------
>   2 files changed, 24 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 71e546e279fc..a33abe9048ed 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1592,10 +1592,6 @@ struct page *get_dump_page(unsigned long addr)
>   				      FOLL_FORCE | FOLL_DUMP | FOLL_GET);
>   	if (locked)
>   		mmap_read_unlock(mm);
> -
> -	if (ret == 1 && is_page_poisoned(page))
> -		return NULL;
> -
>   	return (ret == 1) ? page : NULL;
>   }
>   #endif /* CONFIG_ELF_CORE */
> diff --git a/mm/internal.h b/mm/internal.h
> index ef5f336f59bd..43c4a2f8d4cc 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -96,26 +96,6 @@ static inline void set_page_refcounted(struct page *page)
>   	set_page_count(page, 1);
>   }
>   
> -/*
> - * When kernel touch the user page, the user page may be have been marked
> - * poison but still mapped in user space, if without this page, the kernel
> - * can guarantee the data integrity and operation success, the kernel is
> - * better to check the posion status and avoid touching it, be good not to
> - * panic, coredump for process fatal signal is a sample case matching this
> - * scenario. Or if kernel can't guarantee the data integrity, it's better
> - * not to call this function, let kernel touch the poison page and get to
> - * panic.
> - */
> -static inline bool is_page_poisoned(struct page *page)
> -{
> -	if (PageHWPoison(page))
> -		return true;
> -	else if (PageHuge(page) && PageHWPoison(compound_head(page)))
> -		return true;
> -
> -	return false;
> -}
> -
>   extern unsigned long highest_memmap_pfn;
>   
>   /*
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

