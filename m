Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7553992AC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 20:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhFBSjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 14:39:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30644 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229468AbhFBSjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 14:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622659084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mdvTs07LMgFf85cjcKT6lBxwefQ32Na7wsSXKwDVKtc=;
        b=NebevsHka/3IBxkYW3/rWf6Lk+NIqjDXoCAgfRKY/ljQc8d9RuTtVB8dfttSVmTK4Xfpeh
        ALK4yYP8ssUyxtBqCXkljWpKg4jPo8ODvIRUSOzPs9OfOhU89j9VN0KydSrjMz0r8x8H9P
        mEBBqTR4PzsOaJnI0RcPB7lypFlLPfQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489--9kw2sCiPuu4QNfddw-JBA-1; Wed, 02 Jun 2021 14:38:03 -0400
X-MC-Unique: -9kw2sCiPuu4QNfddw-JBA-1
Received: by mail-wm1-f72.google.com with SMTP id h18-20020a05600c3512b029018434eb1bd8so2561895wmq.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 11:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mdvTs07LMgFf85cjcKT6lBxwefQ32Na7wsSXKwDVKtc=;
        b=PYJVYfvSxVrninnzdak6iQprnyIC75GG2nIKYO3IIb1dI13lJW4vpwTc99qdbBKN5+
         ZZnKGeX0MQbBWEZHe8geoaJoRrhuLBxpgK1MKGomc5OL5qofq8pHkAxDSvpNqn1nnQQ1
         y3JyNPWtIXtT0L9tZApNXORbSu+K/vWgLm04gjdGegrqJDwBjiSR7Rb+sMHtYW73IYlo
         QpOTGrInPSKb/m49KOQvkhKia/Yw7cB+j9hEvkPxyWR+pYPio510u5xRkLP8CWXmf2ep
         +H5ptsew/TA5Zfs1IiwTsbp5tbD/y2IKEKP8HAL7k3vNK5Y1bsMW/WcRsYgi+jU73SJG
         ebeg==
X-Gm-Message-State: AOAM530D9XZ0LHEe4EiAPMI1mAAfKS03Kg1cTBxc7kcj3LeMXb6qGmTw
        S2dBQHcy5HkThkvYK5iKeyZVNdeLqwHN/ptz5HxPZAV1BGf2IwsfLBSRQaYRVXGHn6TZ4s/9ub5
        4S56Pd6HnIJ9tumxOQ3NXWA5yQcvcZDtixoQwBMd9intDp6WSk2DMz47EztYtpf3G1N6Nrlde
X-Received: by 2002:adf:eac3:: with SMTP id o3mr18326629wrn.157.1622659082090;
        Wed, 02 Jun 2021 11:38:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuyef6KiBAlsn74PrPiXXROCnyunw+ZL/ZOZ/+jpYJUWZ39koRwxeHgGsq8eHVAhNJdVmnrA==
X-Received: by 2002:adf:eac3:: with SMTP id o3mr18326603wrn.157.1622659081808;
        Wed, 02 Jun 2021 11:38:01 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6b6d.dip0.t-ipconnect.de. [91.12.107.109])
        by smtp.gmail.com with ESMTPSA id w8sm822572wre.70.2021.06.02.11.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 11:38:01 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] mm,memory_hotplug: Remove unneeded declarations
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210602091457.17772-1-osalvador@suse.de>
 <20210602091457.17772-4-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <87f5c05b-f107-26b9-8c5d-d2394bee2002@redhat.com>
Date:   Wed, 2 Jun 2021 20:38:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210602091457.17772-4-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.06.21 11:14, Oscar Salvador wrote:
> include/linux/memory_hotplug.h has the following declarations:
> 
> extern int zone_grow_free_lists(struct zone *zone, unsigned long new_nr_pages);
> extern int zone_grow_waitqueues(struct zone *zone, unsigned long nr_pages);
> extern int add_one_highpage(struct page *page, int pfn, int bad_ppro);
> 
> These declarations were added by the following commit:
> 
> commit 3947be1969a9ce455ec30f60ef51efb10e4323d1
> Author: Dave Hansen <haveblue@us.ibm.com>
> Date:   Sat Oct 29 18:16:54 2005 -0700
> 
>      [PATCH] memory hotplug: sysfs and add/remove functions
> 
> It seems that zone_grow_free_lists() and zone_grow_waitqueues() were
> never used, and add_one_highpage() was always declared as static in
> arch/i386/mm/init.c and later on in arch/x86/mm/init_32.c, and was
> later removed in:
> 
> commit 5e7ccf8635c93b493f7d378a57ce300fbe1484e8
> Author: Jiang Liu <liuj97@gmail.com>
> Date:   Mon Apr 29 15:07:12 2013 -0700
> 
>      mm/x86: use free_highmem_page() to free highmem pages into buddy system
> 
> So remove these declarations.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>   include/linux/memory_hotplug.h | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 0d837ce6ec11..9a19e97d4f1a 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -80,9 +80,6 @@ struct range mhp_get_pluggable_range(bool need_mapping);
>   /*
>    * Zone resizing functions
>    */
> -extern int zone_grow_free_lists(struct zone *zone, unsigned long new_nr_pages);
> -extern int zone_grow_waitqueues(struct zone *zone, unsigned long nr_pages);
> -extern int add_one_highpage(struct page *page, int pfn, int bad_ppro);
>   extern void adjust_present_page_count(struct zone *zone, long nr_pages);
>   /* VM interface that may be used by firmware interface */
>   extern int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
> 

Right, that's a blast from the past. Thanks!

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

