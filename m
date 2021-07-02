Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDBA3BA3C6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 19:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhGBR5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 13:57:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60915 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229499AbhGBR53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 13:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625248496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pbkNyJDGj/8iXe0TBDEAUMiCkg9SviOFzgrnNXTZons=;
        b=ON8yPlKVKCIJIvWISsnVtCnIo4IZ//qC134YZdrXuvtZGyglPx2PrlXJMu71nX2FSWxL6s
        L4WeW2kO0wSYA/6KOZKsTXHF2bfN+k+hxouzFLPVDtc0aUR/fHYDFt/BOVJNBM81sKdlDx
        BcX4+AS0rFrZhS8JW0BMOpm0tjJBfMc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-CO5QLA3gMuC8gzdw-18nyQ-1; Fri, 02 Jul 2021 13:54:55 -0400
X-MC-Unique: CO5QLA3gMuC8gzdw-18nyQ-1
Received: by mail-wr1-f71.google.com with SMTP id j2-20020a0560001242b029012c82df4dbbso3293752wrx.23
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 10:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pbkNyJDGj/8iXe0TBDEAUMiCkg9SviOFzgrnNXTZons=;
        b=N4jjVum++7jqq2IJEwP1//iGWhk+VABw1w7kn1RP1R/rW6RfM0QUpBcfOu9d+eM79N
         +gVx0Dg/wc4W7H1qKmwp3vwXrPT8MsJeKQbiCvjoBfFjIk7o9pWfs09E4M2pUHrzkpnN
         ietdXQjf4DaJPQ1XMRE1zJEfQldLdwWERA5ismTXykV+9YJr9tOGBMcOUUEMik0H0YS6
         W/xjVuVj2GAmkllpRdfDfUajoOxGcsVOTkBCuilq5jbWjiIrxHJx4nwJdE+FVCJXkHeD
         PfgYfLZ79Y2YfxQrvvRmUW3vPzQH11/3ThmV2DvYljXJh0DqWhskALg6Pb6XZmN7CL4o
         /C1A==
X-Gm-Message-State: AOAM5313Le4g572a1B+cEcc8Pm4slODIg5gCtTSmYb8BkVAMNs6aUDYx
        Mob5L0pXlS43JyDpsETm2uyQ41rUHInkHYTqSogA+/8pY/1LL7l0CEvjFcdwtvYuFqA5Afgaqiq
        WT1IvJq8bZF7alRLp0WPHlROMGNTi46IXBCGgLDYwW4ROEOUhPtXxT4hhS37kYV1woMDsz1bh
X-Received: by 2002:a5d:64ca:: with SMTP id f10mr927474wri.178.1625248494526;
        Fri, 02 Jul 2021 10:54:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9jF5LRPmzSEe/NyTfPh5kL45cRM6XILkCgx2GtLpLbrvUG5J4flBCB2S8jIFb348/NuS/kA==
X-Received: by 2002:a5d:64ca:: with SMTP id f10mr927451wri.178.1625248494313;
        Fri, 02 Jul 2021 10:54:54 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23afb.dip0.t-ipconnect.de. [79.242.58.251])
        by smtp.gmail.com with ESMTPSA id l9sm3949679wrp.14.2021.07.02.10.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 10:54:53 -0700 (PDT)
Subject: Re: [PATCH 1/3] mm: sparse: pass section_nr to section_mark_present
To:     Ohhoon Kwon <ohoono.kwon@samsung.com>, akpm@linux-foundation.org,
        mhocko@suse.com
Cc:     bhe@redhat.com, rppt@linux.ibm.com, ohkwon1043@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210702094132.6276-1-ohoono.kwon@samsung.com>
 <CGME20210702094457epcas1p3ddac76bd3cc3e5b93fadb897cdb6dfd0@epcas1p3.samsung.com>
 <20210702094132.6276-2-ohoono.kwon@samsung.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <b0d49715-b90f-7e9e-34f3-337557eac71c@redhat.com>
Date:   Fri, 2 Jul 2021 19:54:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210702094132.6276-2-ohoono.kwon@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.07.21 11:41, Ohhoon Kwon wrote:
> With CONFIG_SPARSEMEM_EXTREME enabled, __section_nr() which converts
> mem_section to section_nr could be costly since it iterates all
> section roots to check if the given mem_section is in its range.
> 
> On the other hand, __nr_to_section() which converts section_nr to
> mem_section can be done in O(1).
> 
> Let's pass section_nr instead of mem_section ptr to
> section_mark_present() in order to reduce needless iterations.
> 
> Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>
> ---
>   mm/sparse.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 55c18aff3e42..4a2700e9a65f 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -186,13 +186,14 @@ void __meminit mminit_validate_memmodel_limits(unsigned long *start_pfn,
>    * those loops early.
>    */
>   unsigned long __highest_present_section_nr;
> -static void section_mark_present(struct mem_section *ms)
> +static void section_mark_present(unsigned long section_nr)
>   {
> -	unsigned long section_nr = __section_nr(ms);
> +	struct mem_section *ms;
>   
>   	if (section_nr > __highest_present_section_nr)
>   		__highest_present_section_nr = section_nr;
>   
> +	ms = __nr_to_section(section_nr);
>   	ms->section_mem_map |= SECTION_MARKED_PRESENT;
>   }
>   
> @@ -279,7 +280,7 @@ static void __init memory_present(int nid, unsigned long start, unsigned long en
>   		if (!ms->section_mem_map) {
>   			ms->section_mem_map = sparse_encode_early_nid(nid) |
>   							SECTION_IS_ONLINE;
> -			section_mark_present(ms);
> +			section_mark_present(section);
>   		}
>   	}
>   }
> @@ -933,7 +934,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
>   
>   	ms = __nr_to_section(section_nr);
>   	set_section_nid(section_nr, nid);
> -	section_mark_present(ms);
> +	section_mark_present(section_nr);
>   
>   	/* Align memmap to section boundary in the subsection case */
>   	if (section_nr_to_pfn(section_nr) != start_pfn)
> 

Fine for me either like this, or as Michal suggested. It's an internal 
helper either way.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

