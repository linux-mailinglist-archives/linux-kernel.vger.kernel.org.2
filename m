Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34919396ECF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbhFAIYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:24:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28975 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233423AbhFAIX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622535738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1HYvwC4LeaG6a/QIntcnBTi0zzKhYzHLInFyrkpV5ac=;
        b=JborPxX4gCbF76H6H2kHLEK+kw+Sb93jjDp4d7+9eZZKuGAKhy25lwm7CFl32MZcspwJZ/
        Iabv+XjmCBgD9NnGilVTR53WwfnXho3GeMSggnath+J0fDXF2tmWWHEYJyWrPd2OFdyY4y
        6q/Eq8vPTjurAd0/fXNoYnL+sKKtO0o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-EuuRh-ITMKiKO1xpmMWdsA-1; Tue, 01 Jun 2021 04:22:17 -0400
X-MC-Unique: EuuRh-ITMKiKO1xpmMWdsA-1
Received: by mail-wm1-f72.google.com with SMTP id y129-20020a1c32870000b029016920cc7087so2451690wmy.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 01:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1HYvwC4LeaG6a/QIntcnBTi0zzKhYzHLInFyrkpV5ac=;
        b=Zuko9vZMUtkYt0q7x/Mje/My957hn4dTOrt9OFk5ck0FAogSGczoIlVvJuFERbftiI
         AqSERxlyIMS7RZrkuQ7EIPobbFtdBVy7CP97+mQZnTXNQKPasYEq7RX6f4rGcIc6QB+i
         vEuaGo8XyJ4cWmmQn7b1v08Wwvj6L8jSJ1fenly2zNJiSPeb8wAlIQlXwrSse86P6JPO
         rdMgspi74TZXTlqoffNF1Kmo8LIAchi7uKbGuyzLT3ldKklAWdKazvthDFftz6VQlG85
         UEEkE/GJDoG97Fqlg52DxvbFAvSQ4Jfa9bZcZNyw25KClqjkIvRNRjUvOCmemhb/m/RJ
         F6Tg==
X-Gm-Message-State: AOAM530tO3U8eiDIluA2AvMD3IX6k0h7MktIbCR8yMHfK5j/Ve7CCRZk
        YEMVW/No7cFXZ24KR1sStsTPH9d+WlFVW8lP+enj5oBF9uTURgmrsTNvJ8Aw0E1nfWCQylI3BAl
        4M7vcpfqyw+xGYh2CqtXwUbS+
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr23696116wrn.398.1622535735899;
        Tue, 01 Jun 2021 01:22:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+CHHKTTiLAMmYpOGvNt15P9iM9jI3x6ac5muDu4VAi6OyM2btTWtASZ/Tm4IUhbSdEh9heQ==
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr23696101wrn.398.1622535735744;
        Tue, 01 Jun 2021 01:22:15 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c69ce.dip0.t-ipconnect.de. [91.12.105.206])
        by smtp.gmail.com with ESMTPSA id e8sm2341767wrt.30.2021.06.01.01.22.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 01:22:15 -0700 (PDT)
Subject: Re: [PATCH V2 3/6] mm/sparse: move mem_sections allocation out of
 memory_present()
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, dongas86@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
 <20210531091908.1738465-4-aisheng.dong@nxp.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <64078986-3f46-9d2a-ee60-5581931eebbc@redhat.com>
Date:   Tue, 1 Jun 2021 10:22:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210531091908.1738465-4-aisheng.dong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.05.21 11:19, Dong Aisheng wrote:
> The only path to call memory_present() is from memblocks_present().
> The struct mem_section **mem_section only needs to be initialized once,
> so no need put the initialization/allocation code in memory_present()
> which will be called multiple times for each section.
> 
> After moving, the 'unlikely' condition statement becomes to be
> meaningless as it's only initialized one time, so dropped as well.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> ChangeLog:
> v1->v2:
>   * split into a helper function and called directly from sparse_init
> ---
>   mm/sparse.c | 29 ++++++++++++++++-------------
>   1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 408b737e168e..d02ee6bb7cbc 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -60,6 +60,18 @@ static inline void set_section_nid(unsigned long section_nr, int nid)
>   #endif
>   
>   #ifdef CONFIG_SPARSEMEM_EXTREME
> +static void __init sparse_alloc_section_roots(void)
> +{
> +	unsigned long size, align;
> +
> +	size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
> +	align = 1 << (INTERNODE_CACHE_SHIFT);
> +	mem_section = memblock_alloc(size, align);
> +	if (!mem_section)
> +		panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
> +		      __func__, size, align);
> +}
> +
>   static noinline struct mem_section __ref *sparse_index_alloc(int nid)
>   {
>   	struct mem_section *section = NULL;
> @@ -107,6 +119,8 @@ static inline int sparse_index_init(unsigned long section_nr, int nid)
>   {
>   	return 0;
>   }
> +
> +static inline void sparse_alloc_section_roots(void) {}
>   #endif
>   
>   #ifdef CONFIG_SPARSEMEM_EXTREME
> @@ -254,19 +268,6 @@ static void __init memory_present(int nid, unsigned long start, unsigned long en
>   {
>   	unsigned long pfn;
>   
> -#ifdef CONFIG_SPARSEMEM_EXTREME
> -	if (unlikely(!mem_section)) {
> -		unsigned long size, align;
> -
> -		size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
> -		align = 1 << (INTERNODE_CACHE_SHIFT);
> -		mem_section = memblock_alloc(size, align);
> -		if (!mem_section)
> -			panic("%s: Failed to allocate %lu bytes align=0x%lx\n",
> -			      __func__, size, align);
> -	}
> -#endif
> -
>   	start &= PAGE_SECTION_MASK;
>   	mminit_validate_memmodel_limits(&start, &end);
>   	for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION) {
> @@ -582,6 +583,8 @@ void __init sparse_init(void)
>   	unsigned long pnum_end, pnum_begin, map_count = 1;
>   	int nid_begin;
>   
> +	sparse_alloc_section_roots();
> +
>   	memblocks_present();
>   
>   	pnum_begin = first_present_section_nr();
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

