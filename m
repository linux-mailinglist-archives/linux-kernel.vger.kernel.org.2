Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4004A3609B3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 14:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhDOMp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 08:45:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232926AbhDOMpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 08:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618490721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZqHGFCvK29UwMdI5PwYAwX9JWMxR/Nky/E74KukpUQs=;
        b=Mm7KXQFqXGELYOKD8kRV8ic5945LMy0yDb4IeTtBZVWULDHAc1hteAXfX7RoU1Bn0tO7yA
        Zn+3Yp7Jg7QmdBQCsp56tu3fQ3MU8x9IRzLnALV/UZHwvaW9L/irqcaSFhaAKDGHplaZ6R
        63Bn/RW1uDmBPUa4bLBKKq+q8ETWYJ4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-dOBQ_N-EONGU2hTiLjeOGA-1; Thu, 15 Apr 2021 08:45:19 -0400
X-MC-Unique: dOBQ_N-EONGU2hTiLjeOGA-1
Received: by mail-wr1-f69.google.com with SMTP id y13-20020adfdf0d0000b02901029a3bf796so2708405wrl.15
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 05:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZqHGFCvK29UwMdI5PwYAwX9JWMxR/Nky/E74KukpUQs=;
        b=SOJo12r3Q9PPGsncCzduNe68JsXb/QqgvDks3J/YglXDfnJRoELo764bGPvbXi+h81
         iFuSuvXLbRXHxZdEk414bXPyj7s2jerDXUfDCkaDYQJUv2puFeeha84X2skY7xjXlZae
         r3trMncBZsfEzIfr0GEYh2K0DfQOxT12Yhlh0LEJeWA7DgQpzGk/yNAtm5x+lFAqWfJD
         7Qsy6T6IUsqMfgLFyhOQYbWKUM50oudqIjuRT9MWOrfQFVY5gQlWu8oA19v095MfH/pe
         YcPRVVY+V4CB7LED4kr8tzOqEp9MMqE9PZj4opjD66QflR2VfYqU8YxGiTjT1sZY+lkF
         Pf1A==
X-Gm-Message-State: AOAM5300EtqOUryI9JvSu3kck+aWH7De8OnWz4CrFzIyLzFjr4AgGg9h
        ZcXQnE2uZ74hTjeoI0CoxBOMhSfj0dcypifi9ARREghDqeIxxoGVe36p1eDtNP+OU5R6kxAf4L1
        /JKAnjhd+DDDycHL6KKzTT/tR
X-Received: by 2002:a5d:63c9:: with SMTP id c9mr3359370wrw.425.1618490712139;
        Thu, 15 Apr 2021 05:45:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMaAmTfm/cuiA0oqyYDs9Eyq2Ea+4iqwmTuqJrN3WSA1Zy0Qpi7vwNSaCPUWitC79QjKiNDg==
X-Received: by 2002:a5d:63c9:: with SMTP id c9mr3359351wrw.425.1618490711936;
        Thu, 15 Apr 2021 05:45:11 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6392.dip0.t-ipconnect.de. [91.12.99.146])
        by smtp.gmail.com with ESMTPSA id u2sm3028556wmm.5.2021.04.15.05.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 05:45:11 -0700 (PDT)
Subject: Re: [PATCH v8 5/7] mm: Make alloc_contig_range handle free hugetlb
 pages
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
References: <20210415103544.6791-1-osalvador@suse.de>
 <20210415103544.6791-6-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <84268789-379e-2b45-1637-1877652cd6c9@redhat.com>
Date:   Thu, 15 Apr 2021 14:45:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210415103544.6791-6-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +		if (PageHuge(page) && cc->alloc_contig) {
> +			ret = isolate_or_dissolve_huge_page(page);
> +
> +			/*
> +			 * Fail isolation in case isolate_or_dissolve_huge_page()
> +			 * reports an error. In case of -ENOMEM, abort right away.
> +			 */
> +			if (ret < 0) {
> +				/*
> +				 * Do not report -EBUSY down the chain.
> +				 */

Nit: can fit this into a single line.

> +				if (ret != -ENOMEM)
> +					ret = 0;

Nit: I wonder if ret == -EBUSY would be clearer.

> +				low_pfn += (1UL << compound_order(page)) - 1;
> +				goto isolate_fail;
> +			}
> +
> +			/*
> +			 * Ok, the hugepage was dissolved. Now these pages are
> +			 * Buddy and cannot be re-allocated because they are
> +			 * isolated. Fall-through as the check below handles
> +			 * Buddy pages.
> +			 */
> +		}
> +

[...]

> +/*
> + * alloc_and_dissolve_huge_page - Allocate a new page and dissolve the old one
> + * @h: struct hstate old page belongs to
> + * @old_page: Old page to dissolve
> + * Returns 0 on success, otherwise negated error.
> + */
> +

nit: remove that line

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

