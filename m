Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CE23EFFF0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 11:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhHRJHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 05:07:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25513 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229780AbhHRJHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 05:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629277626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z7/mvtfcZ2rmcrwIghqjzyz+StJTihtx+ZfjdJRUNWc=;
        b=I6QnOkyumNY2DCp7/IdZXka14sgShZtu0X+GbXqv3DZA+zmvac0MDzzdHHmlZhHJwCX9xo
        HlztsZQv7h6+RmYVt4coOCXqCscLhSh7lya7CcqifFpmsHY8aLX7MoJvyLxeSHqlq75pzN
        m9TcMfq0f4txeKTPH00yXlPWNtgOb/o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-Ui5rt8egMwWcUYmgq3RXfw-1; Wed, 18 Aug 2021 05:07:05 -0400
X-MC-Unique: Ui5rt8egMwWcUYmgq3RXfw-1
Received: by mail-wr1-f70.google.com with SMTP id a13-20020adfed0d000000b00156fd70137aso251000wro.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 02:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Z7/mvtfcZ2rmcrwIghqjzyz+StJTihtx+ZfjdJRUNWc=;
        b=ApsVFJFTSIjuRm38Pd47y+M4MqMdKItxzxvaAmxVQmMS0kSuRuI/9hr2pQsQsYPVzT
         HCczCqPTpJNI3L8zSGIM4bvc8hVVhKzFsk5UBXbhFk9gmOhMTFJOa4aPdZL5dJhOqlTl
         fzKpo27/CxF9+6gt/1wnw6vjOL7lPbFwGtZmXj9IckZNZMhshxMr+QrdpTBXOzu8CPu1
         pZWdzUbek2y4M8EZrv5SkEL2oE6nd4++WIetjphU6oOAGrmMXuCJvAlfnggQ9Ql+bxV8
         6lL3vb5vYqnHLHOKig4vnVsQT9KAepZs4+BmBIwRnrkQRdRWY2dCoeJu+SBFk40LTA1U
         gswQ==
X-Gm-Message-State: AOAM530ov6bB1eM4hxtCv14Yfd8zH/d9y7bl8X8XFRRHcpy/OLZLtBhj
        6yPKV74zIOBNCF2+HSwfVHZe76ySpqVtHQB7ZlvYJX8Hlwi7DDwruwb2IbVs9N7tw04bHvpLbyJ
        fTbr390ekioJRVR5WNWy17LHq79JthiyZHMnSdLGYWkQLNGjEkMtLZPqpAevHsLSXspXX4z3i
X-Received: by 2002:adf:f7c5:: with SMTP id a5mr9102304wrq.355.1629277624520;
        Wed, 18 Aug 2021 02:07:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz62/eBRg0M/ow0o61HeyVcOy1CMFYUzzF2BEZfaW89NwDVS4uw9M9X6LH4Gi1AE6ONCbAl3Q==
X-Received: by 2002:adf:f7c5:: with SMTP id a5mr9102269wrq.355.1629277624326;
        Wed, 18 Aug 2021 02:07:04 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6417.dip0.t-ipconnect.de. [91.12.100.23])
        by smtp.gmail.com with ESMTPSA id o207sm2386351wme.16.2021.08.18.02.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 02:07:03 -0700 (PDT)
Subject: Re: [PATCH] mm: Changed leading spaces to tabs
To:     Vishal Aslot <os.vaslot@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210817203827.54586-1-os.vaslot@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <35c12536-46a2-7ef4-beb8-cd35e51d8361@redhat.com>
Date:   Wed, 18 Aug 2021 11:07:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210817203827.54586-1-os.vaslot@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.08.21 22:38, Vishal Aslot wrote:
> This patch cleans up two ERRORs produced by checkpatch.pl in internal.h.

s/produced/reported/ :)

> 
> Signed-off-by: Vishal Aslot <os.vaslot@gmail.com>
> ---
>   mm/internal.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 31ff935b2547..c97fe964ab15 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -557,8 +557,8 @@ extern u64 hwpoison_filter_memcg;
>   extern u32 hwpoison_filter_enable;
>   
>   extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
> -        unsigned long, unsigned long,
> -        unsigned long, unsigned long);
> +	unsigned long, unsigned long,
> +	unsigned long, unsigned long);
>   
>   extern void set_pageblock_order(void);
>   unsigned int reclaim_clean_pages_from_list(struct zone *zone,
> @@ -647,11 +647,11 @@ struct migration_target_control {
>    */
>   #ifdef CONFIG_MMU
>   int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
> -                pgprot_t prot, struct page **pages, unsigned int page_shift);
> +		pgprot_t prot, struct page **pages, unsigned int page_shift);
>   #else
>   static inline
>   int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
> -                pgprot_t prot, struct page **pages, unsigned int page_shift)
> +		pgprot_t prot, struct page **pages, unsigned int page_shift)
>   {
>   	return -EINVAL;
>   }
> 


-- 
Thanks,

David / dhildenb

