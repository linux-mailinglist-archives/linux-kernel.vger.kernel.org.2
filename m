Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3154361E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 13:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241670AbhDPLHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 07:07:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43298 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235011AbhDPLHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 07:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618571230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GPi+c282xzGJKGtsxEXKiuYYzkH/n0b1SG5+hHDFjQY=;
        b=WgApvM0b40uNVlkMkytzWlVKqZkCa7LeGfcNxKOWsjkbehjB1lesGsIwj2U1TIU0b0pNy+
        GXozk8SHxjd1lcjRoR5RjK3aNQh3vZmPJeL0QqwguodI7GcBFNuGBVCWwA8M1979p37ZoP
        KzCPl2Usgbz6ALKEoJGwLK0ISxdsqNE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-RlOoPjt6PCyNG30eVHyLhg-1; Fri, 16 Apr 2021 07:07:08 -0400
X-MC-Unique: RlOoPjt6PCyNG30eVHyLhg-1
Received: by mail-wm1-f70.google.com with SMTP id g199-20020a1c9dd00000b02901355dd71edaso86346wme.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 04:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GPi+c282xzGJKGtsxEXKiuYYzkH/n0b1SG5+hHDFjQY=;
        b=Hi5AwY2WooCp97Xh0JcAorGw9WGMc5FVQV06NyeKB0dKKbNgROuVdyGIfrgbr08A6i
         27viON1jnoACM5dMGVyf0T8SKqrJNL1QnHPQC2PlLZxfrsziYElNAtcTJUIorpkCkGlO
         O5n+FsXmgIZ2VQlX7IYEo1nxYwYkPQ2hAx8B0iSSW7uZuXSUb5PMukldWhr+Mu+OzDin
         2kCw5dD9lBXzIsWOWmeBH4E2pl9siRc0DFzBRw7V3+VuQedUEoFq6o/UlwHhlYPV+7DZ
         YLjyi9EQbMKEBHyBBZUkjiPnqGwtgcLLtjgIAQ7bO7wQxhRPo8oHP2g/bt1hqK6VbrPd
         gdBQ==
X-Gm-Message-State: AOAM530tbRV2wNaSu1i9qrm6Gs3CcwyUzrhkRLh87KCXFym7WNeqlrjb
        u5SxaZI+BfkdH+EmaQZMxL+90p7Z948d8EZK/1Q/AXyjpAR1fT7ALm9VhwnRMdFnA8hVEAXDb2u
        PGn7CewJNyBfzE8CvU7N7sKF1M0E2fVpxYoltF/FtJorvG9N9fD+Q/EY1dpxsKjTIIchutk+a
X-Received: by 2002:a1c:e906:: with SMTP id q6mr7688002wmc.138.1618571227580;
        Fri, 16 Apr 2021 04:07:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0mCPuIda0sp2AYe64aqgt78fHBJ/WWgEzW5gY9+iWGAmyRJ/Af2N2BSCTDa29ihnvOvgA1g==
X-Received: by 2002:a1c:e906:: with SMTP id q6mr7687976wmc.138.1618571227301;
        Fri, 16 Apr 2021 04:07:07 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64fb.dip0.t-ipconnect.de. [91.12.100.251])
        by smtp.gmail.com with ESMTPSA id m15sm6348716wrx.32.2021.04.16.04.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 04:07:07 -0700 (PDT)
Subject: Re: [PATCH v8 4/8] mm,memory_hotplug: Allocate memmap from the added
 memory range
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210416102153.8794-1-osalvador@suse.de>
 <20210416102153.8794-5-osalvador@suse.de>
 <df8220ac-4214-5ff6-0048-35553fea8c8c@redhat.com>
 <YHlpAvTPuRZtKo0i@localhost.localdomain>
 <6e659d5b-c3f1-bd72-a3af-235d6bc55b0b@redhat.com>
 <YHlufVk+2O7HsXJh@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <b0f5f87c-af03-173c-17e3-ccf15ccb9cb1@redhat.com>
Date:   Fri, 16 Apr 2021 13:07:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YHlufVk+2O7HsXJh@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
> -		       int online_type, int nid)
> +int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
> +			      struct zone *zone)
> +{
> +	unsigned long end_pfn = pfn + nr_pages;
> +	int ret;
> +
> +	ret = kasan_add_zero_shadow(__va(PFN_PHYS(pfn)), PFN_PHYS(nr_pages));
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Initialize vmemmap pages with the corresponding node, zone links set.

The "set" sounds weird. I'd remove that comment completely.

> +	 */
> +	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_UNMOVABLE);
> +
> +	/*
> +	 * It might be that the vmemmap_pages fully span sections. If that is
> +	 * the case, mark those sections online here as otherwise they will be
> +	 * left offline.
> +	 */
> +	if (nr_pages >= PAGES_PER_SECTION)
> +	        online_mem_sections(pfn, ALIGN_DOWN(end_pfn, PAGES_PER_SECTION));
> +
> +	return ret;
> +}
> +
> +void mhp_deinit_memmap_on_memory(unsigned long pfn, unsigned long nr_pages)
> +{
> +	unsigned long end_pfn = pfn + nr_pages;
> +        /*
> +	 * The pages associated with this vmemmap have been offlined, so
> +	 * we can reset its state here.
> +	 */
> +	remove_pfn_range_from_zone(page_zone(pfn_to_page(pfn)), pfn, nr_pages);
> +	kasan_remove_zero_shadow(__va(PFN_PHYS(pfn)), PFN_PHYS(nr_pages));
> +
> +	/*
> +	 * It might be that the vmemmap_pages fully span sections. If that is
> +	 * the case, mark those sections offline here as otherwise they will be
> +	 * left online.
> +	 */
> +	if (nr_pages >= PAGES_PER_SECTION)
> +		offline_mem_sections(pfn, ALIGN_DOWN(end_pfn, PAGES_PER_SECTION));

It's usually best if you undo stuff in the complete opposite order. For 
example at this point, the memmap might already have been poisoned, yet 
pfn_to_online_page() would return true. You should do that first.

Apart from that, nothing jumped at me :)

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

