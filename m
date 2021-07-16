Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9463CB5AE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 12:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbhGPKIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 06:08:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24558 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234095AbhGPKIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626429947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d+47a2m62uOqKTxHt/Ok6yZAAE0QOF2ZStyoz2+5Ezo=;
        b=L1WMxsF+XS40Ueb2bmZ7uzuW1J0t7QeQ8YhwUD06SPnoviuSibSO9Z0xFRZ6zjFxIomwX0
        jvbGCvvZ2xmjoBcvyF+jnUDZxhhRqY2TA/Um7WyCo41cA0le9vYZzBiOlsFyvDvyeyE1D3
        cWE4bZy6D7/Bg8e+0Nz4sKBlc2VTQho=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-5qU2YFczP-aLxUaPDnR6Gw-1; Fri, 16 Jul 2021 06:05:46 -0400
X-MC-Unique: 5qU2YFczP-aLxUaPDnR6Gw-1
Received: by mail-wm1-f69.google.com with SMTP id b26-20020a7bc25a0000b0290218757e2783so2973081wmj.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 03:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=d+47a2m62uOqKTxHt/Ok6yZAAE0QOF2ZStyoz2+5Ezo=;
        b=mqBFG/ZajyJ2F9BcTu2nRFPhgfqRxS7X9ffF6rtKhhAphFLy/fDlmmD2oYXDDc16Bh
         XeHG7p4OYvjHI4rw7HrydKubaMbCqeE02llBxftm8B3q8mYMv82YQfnkUODivxq7cLWj
         ee37+XCjiFK9nnwYfmOzJ2n63Vas4B9GRn2RQ13XyoaXGD8XeSQU3BYXnfJSvk6mYy/x
         g1nSR4GYesPGJecsNpxWkaUuQOIrLDRn/WLjX9Xe+AEilv6szrP2jUAZILeUHA1ja//w
         CfnGg4wvLZ4hrb186JRNEVshMH5TxxR+rI5LB16lhCpbNK/RDxmr6Yh2RqRQE2+Xv2wh
         3fIg==
X-Gm-Message-State: AOAM532dDVZu/rsb/31JoqkIRwFjZ8RXH2wpm+g/j3GlUg63OuxXbBpf
        YmvRyqQEiwMCBWQD+DBG2hID6lOGjrTCpJUS8WZ9TmkTLHFCJ4rrgZopdINnZ+k9sT2WTE6uqcB
        xhWSbRcfXq3G9mUNP5+PCEakUYoXMuTk0QcBXZ4Bnw0k+XdhcLNTcPv/B7OENzC4AopkwtpV+
X-Received: by 2002:adf:9d88:: with SMTP id p8mr11718864wre.409.1626429945368;
        Fri, 16 Jul 2021 03:05:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbCXasxdeDcHr9sKxyFrSXAWSG40s1WMX8Y45RxCT00l50KFWUWt0ncWOiKWOqa8XfRu5ADw==
X-Received: by 2002:adf:9d88:: with SMTP id p8mr11718842wre.409.1626429945183;
        Fri, 16 Jul 2021 03:05:45 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c621f.dip0.t-ipconnect.de. [91.12.98.31])
        by smtp.gmail.com with ESMTPSA id f13sm10196399wrt.86.2021.07.16.03.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 03:05:44 -0700 (PDT)
Subject: Re: [PATCH] mm/secretmem: wire up ->set_page_dirty
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210716063933.31633-1-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <c8977f73-d7eb-9a81-4667-ad9302130200@redhat.com>
Date:   Fri, 16 Jul 2021 12:05:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716063933.31633-1-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.07.21 08:39, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Make secretmem up to date with the changes done in commit 0af573780b0b
> ("mm: require ->set_page_dirty to be explicitly wired up") so that
> unconditional call to this method won't cause crashes.
> 
> Fixes: 0af573780b0b ("mm: require ->set_page_dirty to be explicitly wired up")
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>   mm/secretmem.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index f77d25467a14..030f02ddc7c1 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -152,6 +152,7 @@ static void secretmem_freepage(struct page *page)
>   }
>   
>   const struct address_space_operations secretmem_aops = {
> +	.set_page_dirty	= __set_page_dirty_no_writeback,
>   	.freepage	= secretmem_freepage,
>   	.migratepage	= secretmem_migratepage,
>   	.isolate_page	= secretmem_isolate_page,
> 
> base-commit: e73f0f0ee7541171d89f2e2491130c7771ba58d3
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

