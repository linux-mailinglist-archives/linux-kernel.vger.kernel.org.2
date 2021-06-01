Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECEFA396E79
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbhFAIEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:04:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29703 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232963AbhFAIEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622534578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nC6vJCqg2xcsbPsrocgrlXG+kt6WskzJ0DDl/gOMrrs=;
        b=eJQrVCGXgHEartomrT/dvO+F7BWHMZm+N1o0JvtJwjYMg8kouKCVCt77N1qDp7OGOS1l8n
        vY+G+h7nuUaG9L7PYKc1FWS/Nf1gUylXiv5Z0mBd8c5Ybzyp/8x08JCjhlSOzdktf1KV7l
        TZyx3XhpwmVqmOgIaZVSBCmEwh4yOF0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-pduosfQYPLKDHnzMYUE1zA-1; Tue, 01 Jun 2021 04:02:57 -0400
X-MC-Unique: pduosfQYPLKDHnzMYUE1zA-1
Received: by mail-wr1-f72.google.com with SMTP id q15-20020adfc50f0000b0290111f48b865cso4544478wrf.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 01:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nC6vJCqg2xcsbPsrocgrlXG+kt6WskzJ0DDl/gOMrrs=;
        b=lidfHYV/er9eQrfGDWyntN+DYLuxqgC2GYu5UuFXxrC39R1tcciNSLH2mNsbmxtst4
         qIB1VaFmAdiOgCKk869x1/cmEmOnnW1Fy9hW2Ck8N+vsxLx3IjvzaP4udChXTROhSyUw
         i9CkdP2xaXVkvwx5zpcmc6AhQOL2F8M2KtRFXcDzfiROvunASOlnsrfYW1DTXvUGqeJq
         KcZNcQ76BrlwAUUPdATge54hwDtxpuVi8zkmuvCJnsoNOP8rnLqO07SIoy8UWOjJTu2o
         5OSvvx957rXoALvqIz+6LUgeIw51E62/G2E2Hy3PP567wzFGabUlFSqNqexa0WB8hgU3
         bDUg==
X-Gm-Message-State: AOAM532gff++FwRVIi8Rf/xv++hBck3cWRWQQkBYyt5/vj+MrlzfIzs7
        56+YaPMwKDEEjDTMS9UnippLBUmrjY0x0tcZvaEMl4qJh/gdF6UZUjuXONn3Yg7JRXvULasa7J0
        vqrquIBGq8tZ8NPS9Par73udz7pB6JeP407zTD/G1W42UiNjTYMtvvaI2t77ZaMlQ/JxsYaBN
X-Received: by 2002:a1c:4b13:: with SMTP id y19mr3306533wma.102.1622534575024;
        Tue, 01 Jun 2021 01:02:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMMEa9JGVFtvJcqXTvaDxvwVIh9UeQ7EkpoSGCk3UjM8vH/hWyW39dr7lxbyqGDPq4wImaWQ==
X-Received: by 2002:a1c:4b13:: with SMTP id y19mr3306503wma.102.1622534574837;
        Tue, 01 Jun 2021 01:02:54 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c69ce.dip0.t-ipconnect.de. [91.12.105.206])
        by smtp.gmail.com with ESMTPSA id w13sm2611037wrc.31.2021.06.01.01.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 01:02:54 -0700 (PDT)
Subject: Re: [PATCH] mm,memory_hotplug: Drop unneeded locking
To:     Oscar Salvador <osalvador@suse.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210531093958.15021-1-osalvador@suse.de>
 <679d311a-8ad4-bb53-18f0-11190a2bf1b5@arm.com> <20210601074737.GA30768@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <f655ced2-281e-33ee-e1ea-89a0e13fc7a3@redhat.com>
Date:   Tue, 1 Jun 2021 10:02:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210601074737.GA30768@linux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.06.21 09:47, Oscar Salvador wrote:
> On Tue, Jun 01, 2021 at 10:47:31AM +0530, Anshuman Khandual wrote:
>> Should also just drop zone_span_write[lock|unlock]() helpers as there
>> are no users left ?
> 
> Yes, definitely.
> Andrew, can you squash this on top? Thanks:
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index a7fd2c3ccb77..27d8ba1d32cb 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -67,10 +67,6 @@ struct range mhp_get_pluggable_range(bool need_mapping);
>   
>   /*
>    * Zone resizing functions
> - *
> - * Note: any attempt to resize a zone should has pgdat_resize_lock()
> - * zone_span_writelock() both held. This ensure the size of a zone
> - * can't be changed while pgdat_resize_lock() held.
>    */
>   static inline unsigned zone_span_seqbegin(struct zone *zone)
>   {
> @@ -80,14 +76,6 @@ static inline int zone_span_seqretry(struct zone *zone, unsigned iv)
>   {
>   	return read_seqretry(&zone->span_seqlock, iv);
>   }
> -static inline void zone_span_writelock(struct zone *zone)
> -{
> -	write_seqlock(&zone->span_seqlock);
> -}
> -static inline void zone_span_writeunlock(struct zone *zone)
> -{
> -	write_sequnlock(&zone->span_seqlock);
> -}

If there is no writer anymore, why do we have to protect readers?



-- 
Thanks,

David / dhildenb

