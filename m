Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A950A3AB36E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 14:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbhFQMXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:23:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28011 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231896AbhFQMXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623932492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b+ZA+9M/AmhePxqH5FjdT2vnXD7QZ2wr0TxXhZ8hko8=;
        b=AlIedg+omGjJ9asRhZoRRT92Q1RrmwDFzcCws1gsXAFuqfVgwUGnzMt5m7QjFi6N66aa2z
        kLRX4VWWrYhZq/hIp5LilaOWKh2z7d+hzbyh2H7X7f8kBmXopyKobD75B4BfpCBb11WZbs
        qmOlXwV1Jgi5srnBzpnEap7TvgU+38s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-YbHwqRnDOmSGzvRsQdWUOA-1; Thu, 17 Jun 2021 08:21:31 -0400
X-MC-Unique: YbHwqRnDOmSGzvRsQdWUOA-1
Received: by mail-wr1-f71.google.com with SMTP id x5-20020adff0c50000b029011a7be832b7so475474wro.18
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 05:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=b+ZA+9M/AmhePxqH5FjdT2vnXD7QZ2wr0TxXhZ8hko8=;
        b=rsDNx5ez2Jv/UKQRDT4OGQostsJ0O0wz/EWikXgyEq0vUTB97bbiHIRvRq3T3jM/Ma
         X9lKaXPuP4aNbSVvvdLFBcVh4h9eCCl6KH/PVPeDwg+4HqWPeLjGK8t4TdY/gLHBo3Uk
         JsZsAh2CPHlIQ3VYQQs0BnO6kf6kXIvzgbyqmjER/2YHXW6iDnKPhc0j05NIMkyIVC7c
         Vb/UDlYZ4vDvIDCOa/UUZzOTCx1ZYJxOz4u/STIhXcAlt918Fm+ZU0byHytuQVLCRhtJ
         n/GFiF0ijPsOuwEb7cXToWPhOoKVa6czL1yYn5j5SWAoVPDati0WIKu0/Eb5lONjHNI3
         SVSA==
X-Gm-Message-State: AOAM530917K/QRovv2Hx4p52t/O4KW+uXXKCybVR2/GBC0viRO8If4ue
        JR4pt4W3zJE57Y7JHLi9yKMI50ReyW/6vBnBc2jrn1nTJbyfW4MjLunhhTIHqacwwJjP+c2qLwB
        pL42Jg6CT8WBBdk59D9tQWQU45QJwGSDDdn2q0hE0AyD3UIHJNQk4ecCcM0V8ZPippmwShyg0
X-Received: by 2002:adf:a15c:: with SMTP id r28mr5365198wrr.224.1623932490297;
        Thu, 17 Jun 2021 05:21:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqJL0EYpqAbfb4wADtQH3JAlpChlOd/ZwGNouIltZHrNRyNdsXvH15xqHi5x3gbAiCG6Gwhw==
X-Received: by 2002:adf:a15c:: with SMTP id r28mr5365166wrr.224.1623932490037;
        Thu, 17 Jun 2021 05:21:30 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6170.dip0.t-ipconnect.de. [91.12.97.112])
        by smtp.gmail.com with ESMTPSA id p23sm7828685wmi.26.2021.06.17.05.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 05:21:29 -0700 (PDT)
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20210617092626.291006-1-nao.horiguchi@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH mmotm v1] mm/hwpoison: disable pcp for
 page_handle_poison()
Message-ID: <a7367b3b-f772-f147-36fe-fdf67a7aaa60@redhat.com>
Date:   Thu, 17 Jun 2021 14:21:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210617092626.291006-1-nao.horiguchi@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.06.21 11:26, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> Recent changes by patch "mm/page_alloc: allow high-order pages to be
> stored on the per-cpu lists" makes kernels determine whether to use pcp
> by pcp_allowed_order(), which breaks soft-offline for hugetlb pages.
> 
> Soft-offline dissolves a migration source page, then removes it from
> buddy free list, so it's assumed that any subpage of the soft-offlined
> hugepage are recognized as a buddy page just after returning from
> dissolve_free_huge_page().  pcp_allowed_order() returns true for
> hugetlb, so this assumption is no longer true.
> 
> So disable pcp during dissolve_free_huge_page() and
> take_page_off_buddy() to prevent soft-offlined hugepages from linking to
> pcp lists.  Soft-offline should not be common events so the impact on
> performance should be minimal.  And I think that the optimization of
> Mel's patch could benefit to hugetlb so zone_pcp_disable() is called
> only in hwpoison context.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>   mm/memory-failure.c | 19 ++++++++++++++++---
>   1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git v5.13-rc6-mmotm-2021-06-15-20-24/mm/memory-failure.c v5.13-rc6-mmotm-2021-06-15-20-24_patched/mm/memory-failure.c
> index 1842822a10da..593079766655 100644
> --- v5.13-rc6-mmotm-2021-06-15-20-24/mm/memory-failure.c
> +++ v5.13-rc6-mmotm-2021-06-15-20-24_patched/mm/memory-failure.c
> @@ -66,6 +66,19 @@ int sysctl_memory_failure_recovery __read_mostly = 1;
>   
>   atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
>   
> +static bool __page_handle_poison(struct page *page)
> +{
> +	bool ret;
> +
> +	zone_pcp_disable(page_zone(page));
> +	ret = dissolve_free_huge_page(page);
> +	if (!ret)
> +		ret = take_page_off_buddy(page);
> +	zone_pcp_enable(page_zone(page));
> +
> +	return ret;
> +}
> +
>   static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, bool release)
>   {
>   	if (hugepage_or_freepage) {
> @@ -73,7 +86,7 @@ static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, boo
>   		 * Doing this check for free pages is also fine since dissolve_free_huge_page
>   		 * returns 0 for non-hugetlb pages as well.
>   		 */
> -		if (dissolve_free_huge_page(page) || !take_page_off_buddy(page))
> +		if (!__page_handle_poison(page))
>   			/*
>   			 * We could fail to take off the target page from buddy
>   			 * for example due to racy page allocation, but that's
> @@ -986,7 +999,7 @@ static int me_huge_page(struct page *p, unsigned long pfn)
>   		 */
>   		if (PageAnon(hpage))
>   			put_page(hpage);
> -		if (!dissolve_free_huge_page(p) && take_page_off_buddy(p)) {
> +		if (__page_handle_poison(p)) {
>   			page_ref_inc(p);
>   			res = MF_RECOVERED;
>   		}
> @@ -1441,7 +1454,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>   		res = get_hwpoison_page(p, flags);
>   		if (!res) {
>   			res = MF_FAILED;
> -			if (!dissolve_free_huge_page(p) && take_page_off_buddy(p)) {
> +			if (__page_handle_poison(p)) {
>   				page_ref_inc(p);
>   				res = MF_RECOVERED;
>   			}
> 

Just to make sure: all call paths are fine that we are taking a mutex, 
right?

I can see that get_hwpoison_page() already disables the PCP.

LGTM

-- 
Thanks,

David / dhildenb

