Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AB138FC3A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhEYIKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:10:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33926 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231935AbhEYIIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621929943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KdzzhH9MuT9PQyoXnAFbYsHqkL1GMnixyvsQG0pApvo=;
        b=Zo3DuhE4AwTD+mj2JaO/TetI3XwNsQ5rMeLHk8MXhXtTehltqnnjikOKi5A0DxQXjYcilP
        qrPQ7B73gt2LPgWR5iRktkpwte/PZfJm9Tv/ArLYcc8fjF8Y5mh5seRnDXAOMvPCYu2F4A
        vpa0nYK/UUOt0E09TNntp60JiJ9etaI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-M4eXO7MgPoirTHzc5Q9u6w-1; Tue, 25 May 2021 04:02:32 -0400
X-MC-Unique: M4eXO7MgPoirTHzc5Q9u6w-1
Received: by mail-wr1-f72.google.com with SMTP id 7-20020adf95070000b02901104ad3ef04so14223666wrs.16
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 01:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KdzzhH9MuT9PQyoXnAFbYsHqkL1GMnixyvsQG0pApvo=;
        b=trEfJanJyO0kCkIh0EGQDZWalnd7go8Hr+ChwhcI1bJoZcUI7NFe4fa6EfZapAWm73
         ihwY9xlSi08Ofl5X9EKWY7VLkkOYfw0p0SkBSHzu51ksf/glvCCv+uIKbuXsq/tEyWYy
         CFfF8yUd3Q/PfuEUKl6r1jFeRE77QBeKAaDqlXnmEaW5Oh/6hdUM3SLOjH5BNa4KdooS
         KvATHbaIVTen0CAy6ua9pTKlN8kpAmUgT+u3WDSbD8ekWF78iCa6u+3I0Tc9NCO8zfa2
         z0068y9Xf9GP6OMOl8nuwQCwD0CZ5jH22/ofusAKXWv6KcCKWa3h3OHzHPY5ywVibgrV
         +i0w==
X-Gm-Message-State: AOAM5327Lu0NloSKmnY7rV6/1+KbzjhfC6y/HtW86yZRj54s3TKAFlN1
        dMC35InCuZYMNq9eejg+nwfzEurABTKI2cphbkL+1jN5QgIiHJm01Aq+obPprSJ9LO66Qs5vpG1
        Wqy2q0WW70Cbhe7TKgPgUNvv4
X-Received: by 2002:a5d:62cb:: with SMTP id o11mr27147133wrv.28.1621929751637;
        Tue, 25 May 2021 01:02:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyILXAUQzZsT2VXvr8oVAB6PdFxRbJxA8RVksfNvjtxZNA4CkQSxiw1nUjhoXCdfw35muvm8w==
X-Received: by 2002:a5d:62cb:: with SMTP id o11mr27147120wrv.28.1621929751465;
        Tue, 25 May 2021 01:02:31 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f38:2400:62f4:c5fa:ba13:ac32? (p200300d82f38240062f4c5faba13ac32.dip0.t-ipconnect.de. [2003:d8:2f38:2400:62f4:c5fa:ba13:ac32])
        by smtp.gmail.com with ESMTPSA id t204sm1922750wmg.38.2021.05.25.01.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 01:02:31 -0700 (PDT)
Subject: Re: [PATCH] mm/huge_memory.c: Remove unused variable unmap_success
To:     Souptick Joarder <jrdr.linux@gmail.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20210518200927.69011-1-jrdr.linux@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <39cd7470-2c45-ba3a-166a-b7285c7d7282@redhat.com>
Date:   Tue, 25 May 2021 10:02:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210518200927.69011-1-jrdr.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.05.21 22:09, Souptick Joarder wrote:
> Kernel test robot throws below warning ->
> 
>     mm/huge_memory.c: In function 'unmap_page':
>>> mm/huge_memory.c:2345:7: warning: variable 'unmap_success' set but not used [-Wunused-but-set-variable]
>      2345 |  bool unmap_success;
>           |       ^~~~~~~~~~~~~
> 
> Remove the unused variable unmap_success.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>   mm/huge_memory.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 52ca04b905cf..ff79a12993c9 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2342,14 +2342,13 @@ static void unmap_page(struct page *page)
>   {
>   	enum ttu_flags ttu_flags = TTU_IGNORE_MLOCK |
>   		TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD;
> -	bool unmap_success;
>   
>   	VM_BUG_ON_PAGE(!PageHead(page), page);
>   
>   	if (PageAnon(page))
>   		ttu_flags |= TTU_SPLIT_FREEZE;
>   
> -	unmap_success = try_to_unmap(page, ttu_flags);
> +	try_to_unmap(page, ttu_flags);
>   }
>   
>   static void remap_page(struct page *page, unsigned int nr)
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

