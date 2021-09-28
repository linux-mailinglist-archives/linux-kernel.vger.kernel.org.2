Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E0941AD27
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240229AbhI1KlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:41:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39949 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240177AbhI1KlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632825563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DYyRP8f2WSPXLKn2r0atH4kHz0+e95PC/BIsP+3v9Vg=;
        b=dNvu07C0YQMgYpXij1bVVnC+V9H/2xi4CPgIjZcHJw0vxUKwXJ5SSyn1LOSN5hJAOYGbB2
        zUzHuueOaxOrm5iG4tLpPfPYjj0eBJEVhWiCoCh2LCl48mZpG5UH7+VXDE8Z0QvTbNfG3i
        c9JwzLlM0h7fXNLSXdzGBa7qcjcj9oE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-edxOmMNuOdWQ_ArM1DV1pA-1; Tue, 28 Sep 2021 06:39:22 -0400
X-MC-Unique: edxOmMNuOdWQ_ArM1DV1pA-1
Received: by mail-wr1-f71.google.com with SMTP id x2-20020a5d54c2000000b0015dfd2b4e34so14959733wrv.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 03:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DYyRP8f2WSPXLKn2r0atH4kHz0+e95PC/BIsP+3v9Vg=;
        b=1jTGKbtEMI0C7d25Hs2OHDX3jsHo7lIGnY3yN5v7TEeL65162yMV2llmmxdjEsb4/Z
         UtegXoXPWIsar9SXrDMVby6HoijCsYCjBXEIYRD17FDfSvyPHqe5mStLdy6nIut25qMw
         TIxqjX4D5tXf3kgdWpETrZ0tKfM/BtDVoHX7+sMqdS82SfcZtI4fX/5ftBssKBRK1DWk
         9DDhNs81yrOvKTZD0eaYOxHtNL5CBUUwUMLrUqf8q5bemFMckUuzZT8IN/VVWJoWJasW
         9yELF9AUj55KRKweFGymoq9iBQkwTcKJoKWGp0AMKPVBg6g4H4hyp/X7OvEWd2ra66K1
         T70A==
X-Gm-Message-State: AOAM530tYtMlwSsAggFnvFHedOqCTKRChGx1VIRoadWOd69PFWDWmGY3
        nY6tMPAK2CMIpDQeNUjIiI3Yk9ixr6GnD5062YeqedeV7pF/u3Hd5qjCQrimYtrTZDEf5tg3tV5
        NB+zOOk6sbiFJjK0FZJy6InlB
X-Received: by 2002:a1c:9a07:: with SMTP id c7mr3955088wme.106.1632825560826;
        Tue, 28 Sep 2021 03:39:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzCY0Hdy7y3Kl5ZYiOJTlyBidLUskdQBMThtPvr1/Xa9GGJ57rzbqXIsDlLSvJOnzI3ScMsg==
X-Received: by 2002:a1c:9a07:: with SMTP id c7mr3955070wme.106.1632825560558;
        Tue, 28 Sep 2021 03:39:20 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23aaf.dip0.t-ipconnect.de. [79.242.58.175])
        by smtp.gmail.com with ESMTPSA id x17sm19856317wrc.51.2021.09.28.03.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 03:39:20 -0700 (PDT)
Subject: Re: [PATCH v1] mm: page_alloc: Add debug log in free_reserved_area
 for static memory
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     guptap@codeaurora.org
References: <1632819849-511-1-git-send-email-faiyazm@codeaurora.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <248ec931-7c16-3e2d-cc8f-8ce0dd4e923b@redhat.com>
Date:   Tue, 28 Sep 2021 12:39:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1632819849-511-1-git-send-email-faiyazm@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.09.21 11:04, Faiyaz Mohammed wrote:
> For INITRD and initmem memory is reserved through "memblock_reserve"
> during boot up but it is free via "free_reserved_area" instead
> of "memblock_free".
> For example:
> [    0.294848] Freeing initrd memory: 12K.
> [    0.696688] Freeing unused kernel memory: 4096K.
> 
> To get the start and end address of the above freed memory and to account
> proper memblock added memblock_dbg log in "free_reserved_area".
> After adding log:
> [    0.294837] memblock_free: [0x00000083600000-0x00000083603000] free_initrd_mem+0x20/0x28
> [    0.294848] Freeing initrd memory: 12K.
> [    0.695246] memblock_free: [0x00000081600000-0x00000081a00000] free_initmem+0x70/0xc8
> [    0.696688] Freeing unused kernel memory: 4096K.
> 
> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
> ---
>   mm/page_alloc.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b37435c..f85c3b2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8129,6 +8129,11 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
>   		pr_info("Freeing %s memory: %ldK\n",
>   			s, pages << (PAGE_SHIFT - 10));
>   
> +#ifdef CONFIG_HAVE_MEMBLOCK
> +		memblock_dbg("memblock_free: [%#016llx-%#016llx] %pS\n",
> +			__pa(start), __pa(end), (void *)_RET_IP_);
> +#endif

IMHO, the "memblock_free" part is misleading. Something was allocated 
early via memblock, then we transitioned to the buddy, now we're freeing 
that early allocation via the buddy.

I would not expect memblock_dbg once memblock might not actually be 
alive anymore.

-- 
Thanks,

David / dhildenb

