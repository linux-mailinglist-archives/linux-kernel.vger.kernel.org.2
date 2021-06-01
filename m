Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5BF396EBD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbhFAIVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:21:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35713 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233406AbhFAIVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622535575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7PN8OYvVf5PYlxGFSvbIGKPtNNYZewqVjzezwL1VmKA=;
        b=H/IrEUeSwuCMt7XOdptFpIv3WhXniDQBjHEDfmFxYerie4QHh8AJta0dSXhwKso5Yi/4yt
        qGo7L9ny+MBlIG5QhnGj8j0CEtWpxbtUOFFjpGtYQF80W78Lis9k7D60W31QgZAg26Db+b
        uG4iAm4EfOQ/mgKY9q9hU+qDGpU5u3g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-okcQSou3MzmTO_EcxcT3IA-1; Tue, 01 Jun 2021 04:19:34 -0400
X-MC-Unique: okcQSou3MzmTO_EcxcT3IA-1
Received: by mail-wm1-f71.google.com with SMTP id z25-20020a1c4c190000b029019f15b0657dso287742wmf.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 01:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7PN8OYvVf5PYlxGFSvbIGKPtNNYZewqVjzezwL1VmKA=;
        b=I49JhfCjBTyFwl+3UwQSd0kwKoE4eHRsMd03N0xbmFPu/GkQO/+mMBsX0gOq9RLjyX
         c9hJY7OFdPhREFRH/N9QZU+jYAsqi3/6TuDyvxL7EXX4g88AdJWm1Af9sA6DviPr0+4K
         pVb9H7VqXYk9VWJLDG9iCSdNTIGKOMZDgdY66yjyUybC5b6I8eJwBGsxCp1KAkenhv4M
         CM3FJLsn1lypr1lNJwNncTcuiCsr4YFO0Iv/UXE8xZL0+c/9Buu9mRSOAvvMY4YIknfR
         PzmAd7gU2UwNvS/0pk3lOp/zzEQvAAOjc3NqW8i4eq8ppTdTBlf6r1ZIovuGxomQuwCY
         8v8A==
X-Gm-Message-State: AOAM532xcUbr0bDW9rz7P5LtAG93ofq0H8I6JVK/gogROUaFqEnvbuzB
        T/vfXUAoKcbD0BEqHNYPetFornM3KIWTIr/jzWJUDX6/Jtc1bojd1WjCzx4At65v54LptuE8dDW
        TUQ2nRNzVEEWtvlBn4rqYn8XH
X-Received: by 2002:adf:a28c:: with SMTP id s12mr27767491wra.105.1622535572881;
        Tue, 01 Jun 2021 01:19:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRcEWrovG4h2mJ73cBwCYtUMmKAdj1CXv3zAIs/79bVgymoxh5ufpS3HJPneHupP7bqrV9Nw==
X-Received: by 2002:adf:a28c:: with SMTP id s12mr27767482wra.105.1622535572730;
        Tue, 01 Jun 2021 01:19:32 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c69ce.dip0.t-ipconnect.de. [91.12.105.206])
        by smtp.gmail.com with ESMTPSA id m132sm903398wmf.10.2021.06.01.01.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 01:19:32 -0700 (PDT)
Subject: Re: [PATCH V2 2/6] mm/sparse: free section usage memory in case
 populate_section_memmap failed
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, dongas86@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
References: <20210531091908.1738465-1-aisheng.dong@nxp.com>
 <20210531091908.1738465-3-aisheng.dong@nxp.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <953557a5-f5cf-8780-ec60-73bff418650e@redhat.com>
Date:   Tue, 1 Jun 2021 10:19:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210531091908.1738465-3-aisheng.dong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.05.21 11:19, Dong Aisheng wrote:
> Free section usage memory in case populate_section_memmap failed.
> We use map_count to track the remain unused memory to be freed.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> ChangeLog:
> v1->v2:
>   * using goto + lable according to Mike's suggestion
> ---
>   mm/sparse.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 7ac481353b6b..408b737e168e 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -533,7 +533,7 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
>   			mem_section_usage_size() * map_count);
>   	if (!usage) {
>   		pr_err("%s: node[%d] usemap allocation failed", __func__, nid);
> -		goto failed;
> +		goto failed1;
>   	}
>   	sparse_buffer_init(map_count * section_map_size(), nid);
>   	for_each_present_section_nr(pnum_begin, pnum) {
> @@ -548,17 +548,20 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
>   			pr_err("%s: node[%d] memory map backing failed. Some memory will not be available.",
>   			       __func__, nid);
>   			pnum_begin = pnum;
> -			sparse_buffer_fini();
> -			goto failed;
> +			goto failed2;
>   		}
>   		check_usemap_section_nr(nid, usage);
>   		sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage,
>   				SECTION_IS_EARLY);
>   		usage = (void *) usage + mem_section_usage_size();
> +		map_count--;
>   	}
>   	sparse_buffer_fini();
>   	return;
> -failed:
> +failed2:
> +	sparse_buffer_fini();
> +	memblock_free_early(__pa(usage), map_count * mem_section_usage_size());
> +failed1:
>   	/* We failed to allocate, mark all the following pnums as not present */
>   	for_each_present_section_nr(pnum_begin, pnum) {
>   		struct mem_section *ms;
> 

I still don't think we need this. Did you even manage to trigger this to 
test your patch?

-- 
Thanks,

David / dhildenb

