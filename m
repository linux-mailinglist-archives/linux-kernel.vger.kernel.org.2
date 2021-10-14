Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC81342D37B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 09:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhJNHY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 03:24:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229985AbhJNHY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 03:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634196173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kHcFBMxXEj4gQtebrr/FX+9RNlxk3znvBGKf36PqXtU=;
        b=W9cWnZRiR97LyCI30n9k+c8UwuNoGYzj/QvuqB+/NFCl4fNL0cr1xTy2mD24Awvqotn8uW
        8dT6SRwPAmd67A/dRE9/jVZFuU9FtqNbGX30IIQ/ZRmNd4hisHQpnDE8mfllCgwuNx5Kvr
        FlQRG3NtbkIcNUXSFLwP6R+suy2jF8o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-my9k1utnMPC6zi4rALRiSQ-1; Thu, 14 Oct 2021 03:22:52 -0400
X-MC-Unique: my9k1utnMPC6zi4rALRiSQ-1
Received: by mail-wr1-f71.google.com with SMTP id 41-20020adf812c000000b00160dfbfe1a2so3861114wrm.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 00:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=kHcFBMxXEj4gQtebrr/FX+9RNlxk3znvBGKf36PqXtU=;
        b=ybLvBqVcofXz683nvPVrEb1FZLp2d05fNe3fPGP7Zpj6O6KGwk5MbqQpQmI+yLnKp9
         1ZGKOTAJ50uOnjeeMDEe110+IFWn3i9eUATVpus7UGdARBZw6q/F7MYV+Ko1lsDS03eB
         pH5NMnW388TZVsAMIaaMPuLIadioaDcYLNr2bMiwuk93M4damNiyzJOmpg7QeCf8v6mb
         VTz0yZgTIS7zwrngiOOK3n0ndfy0ob45WmPE/G1VzvT/qDbW2AVRIHBjRLcGApsRK1/u
         CwFllwwjMxqyZn5eZFh6QqFHofLSXR8jwh6+A/UT+TpOHWA6It1dN+jLQopFkk2ZYJCH
         Z3wg==
X-Gm-Message-State: AOAM530x3fq9FzX8oz053N9L/BLWp4iW+UBhQkd/E83fwbtNjLbLwulK
        nA24I+6ruTP0llKkB8yTKM2gTbfnvSmVzjpcLG39rYSxa1j0MbS/+8fcPHUmqSk6IGQQg4NJrUx
        34Ere2CnMGGcs6sUrYexrScKc
X-Received: by 2002:adf:a1d3:: with SMTP id v19mr4894545wrv.268.1634196171434;
        Thu, 14 Oct 2021 00:22:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKgtAl6WuzA6b7U/Gu0v0IdejF+vRj1cUe73lne1ZL1KOhTQKOLLM1jmflLE2twyZP5k+KYw==
X-Received: by 2002:adf:a1d3:: with SMTP id v19mr4894528wrv.268.1634196171252;
        Thu, 14 Oct 2021 00:22:51 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c694e.dip0.t-ipconnect.de. [91.12.105.78])
        by smtp.gmail.com with ESMTPSA id z1sm1623191wrt.94.2021.10.14.00.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 00:22:50 -0700 (PDT)
Message-ID: <64195d6f-09e3-9ab6-bcb2-d68a79665fcf@redhat.com>
Date:   Thu, 14 Oct 2021 09:22:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v3] mm: page_alloc: Add debug log in free_reserved_area
 for static memory
Content-Language: en-US
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     guptap@codeaurora.org
References: <1634195564-14048-1-git-send-email-faiyazm@codeaurora.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <1634195564-14048-1-git-send-email-faiyazm@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.10.21 09:12, Faiyaz Mohammed wrote:
> For INITRD and initmem memory is reserved through "memblock_reserve"
> during boot up but it is free via "free_reserved_area" instead
> of "memblock_free".
> For example:
> [    0.294848] Freeing initrd memory: 12K.
> [    0.696688] Freeing unused kernel memory: 4096K.
> 
> To get the start and end address of the above freed memory and to account
> proper memblock added pr_debug log in "free_reserved_area".
> After adding log:
> [    0.294837] 0x00000083600000-0x00000083603000 free_initrd_mem+0x20/0x28
> [    0.294848] Freeing initrd memory: 12K.
> [    0.695246] 0x00000081600000-0x00000081a00000 free_initmem+0x70/0xc8
> [    0.696688] Freeing unused kernel memory: 4096K.
> 
> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
> ---
> changes in v3:
> 	- Update the format specifier.
> changes in v2:
> 	- To avoid confusion, remove the memblock_dbg print and drop the
> 	memblock_free string, now using pr_debug to print the address ranges.
> 
>  mm/page_alloc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b37435c..13adda5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8097,6 +8097,8 @@ EXPORT_SYMBOL(adjust_managed_page_count);
>  
>  unsigned long free_reserved_area(void *start, void *end, int poison, const char *s)
>  {
> +	const phys_addr_t pstart = __pa(start);
> +	const phys_addr_t pend = __pa(end);
>  	void *pos;
>  	unsigned long pages = 0;
>  
> @@ -8125,9 +8127,12 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
>  		free_reserved_page(page);
>  	}
>  
> -	if (pages && s)
> +	if (pages && s) {
>  		pr_info("Freeing %s memory: %ldK\n",
>  			s, pages << (PAGE_SHIFT - 10));
> +		pr_debug("[%pa-%pa] %pS\n", &pstart, &pend,
> +			(void *)__RET_IP_);
> +	}
>  
>  	return pages;
>  }
> 

Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

-- 
Thanks,

David / dhildenb

