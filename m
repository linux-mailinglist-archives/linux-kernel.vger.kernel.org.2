Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D8E398923
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 14:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhFBMQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 08:16:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29115 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229579AbhFBMQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 08:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622636092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+WZvzkWyoU33l+EoH2um7bddlB7uqhofjcxdl6V4QOM=;
        b=DrrQhr1R91S2ShJkNeOOWFIK8Co0EQUEvqlap6vdjK5OpwSm0ANJyhHp776LeXNEr4m9Tg
        nhzESGQkwDy1zguZvxAqVYM8JiQ1ZehvJYX+y9mle56aormTzjh4HPp2EPgbLP3rC96rJC
        4ujHSZgH3VQtJyoJWowK9Z3llfVq/TQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-kR6bnAMrP-SAbZlaEkx47w-1; Wed, 02 Jun 2021 08:14:51 -0400
X-MC-Unique: kR6bnAMrP-SAbZlaEkx47w-1
Received: by mail-wr1-f70.google.com with SMTP id g14-20020a5d698e0000b0290117735bd4d3so923451wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 05:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+WZvzkWyoU33l+EoH2um7bddlB7uqhofjcxdl6V4QOM=;
        b=SCQTIMAgz7evSozaWz89zgmPmpdefBbsggNgcw2QUn8ZLjVQf8Bn6hFc8oqwmmVBPn
         lIZ0dFbBnnFz9eQz9DqPjBQQDFsXD/nV85a4/bH4y6V9MMkbarIEn3JLNOiVJV3i8Ui/
         CI90jb+FEOtDBaHkwtHZQ39zsR/vGo7t9IoB9JJ5vcUIOT6qt4gxgt30sjz+BCT+RwoI
         WUkBTpHnFiy86ygR03vgvdv1s16m+0NTm4ISL3L1FFRZqqluVfkl5aQDkODfPvzsyIfQ
         ybfmfimlmg5NRqNL7p9Cefl7PUns+U1hSd4wwN6qYuWzD47y0BLsDfZWlbfInrKW0qSk
         Uv+A==
X-Gm-Message-State: AOAM533+9UTrnx/N5+1MDB9//IL3KSGUt4kYajl1pLH8MK44GNDKoQfh
        oxXQx1YHtN7Hgi4l1QeJNQ36KVFMXHMo44s3H3hmrM6fgkWV6cBM2jjOSpfru5OVw8S+uJzb3x6
        PrCWpTMDyX7oQdiPVdwOO6lLf
X-Received: by 2002:a7b:c396:: with SMTP id s22mr10160296wmj.131.1622636090058;
        Wed, 02 Jun 2021 05:14:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGpbVgDrSlfIRKic51uMtC0PdZNIeN370u1E5fK+jYKeWSaQQbVkV3u6Hl/kPrdrf6iUsjYQ==
X-Received: by 2002:a7b:c396:: with SMTP id s22mr10160274wmj.131.1622636089857;
        Wed, 02 Jun 2021 05:14:49 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6b6d.dip0.t-ipconnect.de. [91.12.107.109])
        by smtp.gmail.com with ESMTPSA id r7sm2581509wmq.3.2021.06.02.05.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 05:14:49 -0700 (PDT)
To:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        linux-nvme@lists.infradead.org, dan.j.williams@intel.com,
        logang@deltatee.com, linux-mm@kvack.org, hch@lst.de
Cc:     sagi@grimberg.me, oren@nvidia.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
References: <20210602111055.10480-1-mgurtovoy@nvidia.com>
 <20210602111055.10480-2-mgurtovoy@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 1/3] mm,memory_hotplug: export mhp min alignment
Message-ID: <283740c3-db3f-3c9a-2954-f1c037a13e86@redhat.com>
Date:   Wed, 2 Jun 2021 14:14:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210602111055.10480-2-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.06.21 13:10, Max Gurtovoy wrote:
> Hotplugged memory has alignmet restrictions. E.g, it disallows all
> operations smaller than a sub-section and only allow operations smaller
> than a section for SPARSEMEM_VMEMMAP. Export the alignment restrictions
> for mhp users.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   include/linux/memory_hotplug.h |  5 +++++
>   mm/memory_hotplug.c            | 33 +++++++++++++++++++--------------
>   2 files changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 28f32fd00fe9..c55a9049b11e 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -76,6 +76,7 @@ struct mhp_params {
>   
>   bool mhp_range_allowed(u64 start, u64 size, bool need_mapping);
>   struct range mhp_get_pluggable_range(bool need_mapping);
> +unsigned long mhp_get_min_align(void);
>   
>   /*
>    * Zone resizing functions
> @@ -248,6 +249,10 @@ void mem_hotplug_done(void);
>   	___page;				\
>    })
>   
> +static inline unsigned long mhp_get_min_align(void)
> +{
> +	return 0;
> +}
>   static inline unsigned zone_span_seqbegin(struct zone *zone)
>   {
>   	return 0;
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 9e86e9ee0a10..161bb6704a9b 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -270,24 +270,29 @@ void __init register_page_bootmem_info_node(struct pglist_data *pgdat)
>   }
>   #endif /* CONFIG_HAVE_BOOTMEM_INFO_NODE */
>   
> +/*
> + * Disallow all operations smaller than a sub-section and only
> + * allow operations smaller than a section for
> + * SPARSEMEM_VMEMMAP. Note that check_hotplug_memory_range()
> + * enforces a larger memory_block_size_bytes() granularity for
> + * memory that will be marked online, so this check should only
> + * fire for direct arch_{add,remove}_memory() users outside of
> + * add_memory_resource().
> + */
> +unsigned long mhp_get_min_align(void)
> +{
> +	if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP))
> +		return PAGES_PER_SUBSECTION;
> +	return PAGES_PER_SECTION;
> +}
> +EXPORT_SYMBOL_GPL(mhp_get_min_align);

We have to main interfaces to "hotplug" memory:

a) add_memory() and friends for System RAM, which have memory block 
alignment requirements.

b) memremap_pages(), which has the alignemnt requirements you mention here.

I feel like what you need would better be exposed in mm/memremap.c, for 
example, via "memremap_min_alignment" so it matches the "memremap_pages" 
semantics.

And then, memremap_pages() is only available with CONFIG_ZONE_DEVICE, 
which depends on SPARSEMEM_VMEMMAP. So you'll always have 
PAGES_PER_SUBSECTION.

I can already spot "memremap_compat_align", maybe you can reuse that or 
handle it accordingly in there?


-- 
Thanks,

David / dhildenb

