Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8123AAFB0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhFQJbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:31:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29233 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231574AbhFQJbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623922132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZHuAloMa0AoC5AC95gAOi+y4HlERZPMXvHRDbIrYdzQ=;
        b=aN+KqcHqisoqe4FN6dT24Z0qjjPYFouPiTvLMr7sxjAyIwdEHqFbczrVXAFdytRU6GpGlf
        1JRP9cGVJZ8bhfN+3X19KWNEI0q8gRq7+GFEtHe/P7jToEvGOjol9IUwi9nZVcesT3iRzq
        t1Q4/dQp11SD127irwvuL0N+Ad2xLVE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-oWj_O5zuO7S_gG10zKELJQ-1; Thu, 17 Jun 2021 05:28:51 -0400
X-MC-Unique: oWj_O5zuO7S_gG10zKELJQ-1
Received: by mail-wr1-f71.google.com with SMTP id f9-20020a5d64c90000b029011a3c2a0337so2683802wri.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 02:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZHuAloMa0AoC5AC95gAOi+y4HlERZPMXvHRDbIrYdzQ=;
        b=WevsBGxNJnigjIJLVZsQBaCpB0vMpnz4GzBD2ceIcaBipqHsnpErWR6TCfeo+HgfKO
         ilJhf6WPsK2ble1NSeBRVmmP6+zWzdcIzUcmo3Ugr/6AGp7u5noXM0Bgz400YhgPBpGR
         RnSnMUr54VCIZMslz2AJU46tosgUNkDs7M2mIkDg0qNab6hzofekOhLfAu0d0aQca/BP
         /0i8UgMqteqTsd/OEkzsEoBZaENaNw0SSZ+om8VV0IaLYS6ElTvkmyyESl6VC36j69nK
         snw95UOfpDTG96nCaAkwsnrIWNgeuDIt+vPS9/GV0QUoO7NpUc6ozz8+4t4ovnt0nAZa
         /12A==
X-Gm-Message-State: AOAM531flI6cwSXP0ur6m2q2/theSfGw2BPic9aIziRBYCW/vSbV41IV
        kDxcSZraV1Akz7L+Wt1UDYRB/EQEeVeXwCQBRFlSMJv56gj/eKNl18pCe7Z/SYn564y9hjsycHX
        Q5rRIgssVRb57Z2fUVETQrZWcVJxfEHwKdodk8opm14D83Z9RQMKoxoqqt4t+RInPXdT6la1o
X-Received: by 2002:a5d:630f:: with SMTP id i15mr4441976wru.155.1623922130176;
        Thu, 17 Jun 2021 02:28:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbp/CgEWTSA9q+X90xdM1xBCuvBeZxwu3T85kkR9KT3yteRTWZ5b4a5zBMKxntq75+BWb/8Q==
X-Received: by 2002:a5d:630f:: with SMTP id i15mr4441947wru.155.1623922129949;
        Thu, 17 Jun 2021 02:28:49 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6170.dip0.t-ipconnect.de. [91.12.97.112])
        by smtp.gmail.com with ESMTPSA id f14sm4526726wri.16.2021.06.17.02.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 02:28:49 -0700 (PDT)
Subject: Re: [PATCH mmotm v1] mm/hwpoison: disable pcp for
 page_handle_poison()
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
Message-ID: <e7f75111-5b65-8756-2764-f5c98c4747ea@redhat.com>
Date:   Thu, 17 Jun 2021 11:28:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210617092626.291006-1-nao.horiguchi@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Mel, Oscar, does alloc_contig_range() now have similar issues or is it 
avoided because the pageblock(s) are set MIGRATE_ISOLATE?


-- 
Thanks,

David / dhildenb

