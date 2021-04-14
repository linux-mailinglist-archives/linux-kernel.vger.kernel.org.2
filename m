Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E0535F2F8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhDNLyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:54:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44392 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233054AbhDNLyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618401261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BPd3Tc8xa+gxQM5oCgLCXFJCGHqB4PosxTMgdrC0TxM=;
        b=jEnnzEqN8uqQjlz2Ey6gcaNQIEHiRJsSYo5OVZhbcGsA6fdyxVquL2O2beaJb82mNtfnUl
        RnhlUoFOIR5Pe5huv7Sf4u4F6Cjr3olHIuSAC0nWrHvyyLGxPI93bVsZvGvm8af6fhMtIr
        TMWnN9R9U1ICp5SIASsI8RlyUi5CdjY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-Tv3T0jYFNqym0eNXpTJ0BQ-1; Wed, 14 Apr 2021 07:54:19 -0400
X-MC-Unique: Tv3T0jYFNqym0eNXpTJ0BQ-1
Received: by mail-wm1-f70.google.com with SMTP id z135-20020a1c7e8d0000b02901297f50f20dso1531859wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 04:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BPd3Tc8xa+gxQM5oCgLCXFJCGHqB4PosxTMgdrC0TxM=;
        b=MCdIt7vFNnrxVqcEQ6S+KSznFGVSgnh5rBYnGFYSXTO7BRU3fTYG0WJFCbn9dmhGwN
         yzlTW2IA9yDVQ3OCZDNnXYgnQwD5+jSj7maJb6lHSLD3xgjfweGjWSPBQwUYsP5ekUqZ
         T5XMohBkmlwbS/OxGiQrT/Sgn2+B+25pjlepigYUcNAMcSCsuACcAcFG/KNbRr26kyyt
         JNQtOFTZoFEnKWDraVU5cbx/wns8TB5MMICcXE+ucmFvMNZp8UNLVXbPiEm4WGM9lnAT
         ZCDjcOkIhNRRqi8qSopYROXxWOA6EhQrkdgfNE5C8vMqwpjCBaNENaqG/AS0HXminNtP
         3dkA==
X-Gm-Message-State: AOAM533WgwyNn2uXZvhfD7/4jNaLwGdrHvDyofve5+GOuG3FrThROWXw
        sS1x5p0OPWy6TOoWIndrhq/gg2FLI5lDM9jSLMVwWI/JiQ2Myp6dYAEI4slo8M3/tK9dy+Gn4Xd
        CUNhwsM7VpklFvA6m71w2/Hmu05tIySPPmWOX2Lk3XJVs0WRQZY+S3sM0lIXpxG2bltVKyqJ1
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr2717559wmj.84.1618401258615;
        Wed, 14 Apr 2021 04:54:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8s6+zOHj71XQOKsE99FIg5enDYL53aeAxSZCEsD2UJkAf9kB58tfryiD7Mb5P/qhhSTDg+w==
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr2717529wmj.84.1618401258242;
        Wed, 14 Apr 2021 04:54:18 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6470.dip0.t-ipconnect.de. [91.12.100.112])
        by smtp.gmail.com with ESMTPSA id u8sm8331509wrp.66.2021.04.14.04.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 04:54:18 -0700 (PDT)
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-3-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v7 2/7] mm,compaction: Let
 isolate_migratepages_{range,block} return error codes
Message-ID: <2628d20e-3304-1a0c-5246-cfc2320cce8b@redhat.com>
Date:   Wed, 14 Apr 2021 13:54:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210413104747.12177-3-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.21 12:47, Oscar Salvador wrote:
> Currently, isolate_migratepages_{range,block} and their callers use
> a pfn == 0 vs pfn != 0 scheme to let the caller know whether there was
> any error during isolation.
> This does not work as soon as we need to start reporting different error
> codes and make sure we pass them down the chain, so they are properly
> interpreted by functions like e.g: alloc_contig_range.
> 
> Let us rework isolate_migratepages_{range,block} so we can report error
> codes.
> Since isolate_migratepages_block will stop returning the next pfn to be
> scanned, we reuse the cc->migrate_pfn field to keep track of that.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>   mm/compaction.c | 54 +++++++++++++++++++++++++++---------------------------
>   mm/internal.h   | 10 ++++++++--
>   mm/page_alloc.c |  7 +++----
>   3 files changed, 38 insertions(+), 33 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 8c5028bfbd56..eeba4668c22c 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -787,15 +787,15 @@ static bool too_many_isolated(pg_data_t *pgdat)
>    *
>    * Isolate all pages that can be migrated from the range specified by
>    * [low_pfn, end_pfn). The range is expected to be within same pageblock.
> - * Returns zero if there is a fatal signal pending, otherwise PFN of the
> - * first page that was not scanned (which may be both less, equal to or more
> - * than end_pfn).
> + * Returns errno, like -EAGAIN or -EINTR in case e.g signal pending or congestion,
> + * or 0.
> + * cc->migrate_pfn will contain the next pfn to scan (which may be both less,
> + * equal to or more that end_pfn).

I failed to parse the last sentence -- e.g., using "both" and then 
listing three options. Also, s/than/than/? Can we simplify to

"cc->migrate_pfn will contain the next pfn to scan"

>    *
>    * The pages are isolated on cc->migratepages list (not required to be empty),
> - * and cc->nr_migratepages is updated accordingly. The cc->migrate_pfn field
> - * is neither read nor updated.
> + * and cc->nr_migratepages is updated accordingly.
>    */
> -static unsigned long
> +static int
>   isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   			unsigned long end_pfn, isolate_mode_t isolate_mode)
>   {
> @@ -809,6 +809,9 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   	bool skip_on_failure = false;
>   	unsigned long next_skip_pfn = 0;
>   	bool skip_updated = false;
> +	int ret = 0;
> +
> +	cc->migrate_pfn = low_pfn;
>   
>   	/*
>   	 * Ensure that there are not too many pages isolated from the LRU
> @@ -818,16 +821,16 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   	while (unlikely(too_many_isolated(pgdat))) {
>   		/* stop isolation if there are still pages not migrated */
>   		if (cc->nr_migratepages)
> -			return 0;
> +			return -EAGAIN;
>   
>   		/* async migration should just abort */
>   		if (cc->mode == MIGRATE_ASYNC)
> -			return 0;
> +			return -EAGAIN;
>   
>   		congestion_wait(BLK_RW_ASYNC, HZ/10);
>   
>   		if (fatal_signal_pending(current))
> -			return 0;
> +			return -EINTR;
>   	}
>   
>   	cond_resched();
> @@ -875,8 +878,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   
>   			if (fatal_signal_pending(current)) {
>   				cc->contended = true;
> +				ret = -EINTR;
>   
> -				low_pfn = 0;
>   				goto fatal_pending;
>   			}
>   
> @@ -1130,7 +1133,9 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   	if (nr_isolated)
>   		count_compact_events(COMPACTISOLATED, nr_isolated);
>   
> -	return low_pfn;
> +	cc->migrate_pfn = low_pfn;
> +
> +	return ret;
>   }
>   
>   /**
> @@ -1139,15 +1144,15 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>    * @start_pfn: The first PFN to start isolating.
>    * @end_pfn:   The one-past-last PFN.
>    *
> - * Returns zero if isolation fails fatally due to e.g. pending signal.
> - * Otherwise, function returns one-past-the-last PFN of isolated page
> - * (which may be greater than end_pfn if end fell in a middle of a THP page).
> + * Returns errno, like -EAGAIN or -EINTR in case e.g signal pending or congestion,

errno is usually positive.

> + * or 0.

I'd be more specific here. Something like

"
Returns 0 if isolation succeeded. Returns -EINTR if a fatal signal is 
pending. Returns -EAGAIN when contended and the caller should retry.

In any case, cc->migrate_pfn is set to one-past-the-last PFN that has 
been isolated.
"

-- 
Thanks,

David / dhildenb

