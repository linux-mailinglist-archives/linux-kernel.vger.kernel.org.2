Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E56538FC01
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 09:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhEYHyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 03:54:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35119 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231640AbhEYHyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 03:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621929152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nHZzxf+ytlYjm3d6c5CzbDAImZNM1V4d4EFj0tNGWZg=;
        b=FF65hrx3iJ4qDgN50UY3LgYuSjAAY2OcNMCUdNhmROB62LUB+qFNVmqr4yAblReJvVaw2+
        Ac3lR79Tx3QLZlN4zPQ4RK6nQEGBAYrvqAWei6RnVR4RdWlmcvGqfyOqbhgwDfpsB5t/M5
        NMqZ6+srLWRgzN+ylZ75GVoxDtWTq3M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-Iw8HnBU4P6aNdw7Y44VAmA-1; Tue, 25 May 2021 03:52:30 -0400
X-MC-Unique: Iw8HnBU4P6aNdw7Y44VAmA-1
Received: by mail-wr1-f70.google.com with SMTP id q15-20020adfc50f0000b0290111f48b865cso10707249wrf.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 00:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nHZzxf+ytlYjm3d6c5CzbDAImZNM1V4d4EFj0tNGWZg=;
        b=aX2Kha9Nkrv7tgF6uBksRUA/aQNRnk8cjKQT/iJflFRt+d9ZPHV+cKFtPsLW4W3VOp
         EuYFB1vEZ0lKMuMafzVPLQPlWe8vi0eeWaKJePavcZ0Xf4ziH9W5uPVQQ7PSfTFzSEeq
         0O/lvkA8q0gc6gw/7C4DbLzkifn5wEN+h1fCOeT0hrJwUGjcokrkam53QDQjwvR/i5cU
         CBN6HvrmU1zFzPDcCht+rT+1GwZEdRn/YjuoaFrMVhTBFYF2fp7ZSAW+CXN7LsEq2hWj
         yNOPGkpuqNK/XbxAa8gP9hEJegF/IZG9cN1chtEsK4hrwgLIb8UvCdYteGaVhg+cKBeb
         wg6w==
X-Gm-Message-State: AOAM532vCkHWn2+4CVhlvciIARNbOokC70CI6LF3Y4zdQlfVKCYJcGXI
        M6oB5LbEg4m1nXBqRoe8pCCQmbv5M5Mx44TU/+uzdnjN2xsWYgJNQtM7NGWJh/XkeDFoHr0h0PY
        nOhZB+mCeRCF2UDhB+U9pIIrX
X-Received: by 2002:adf:ee86:: with SMTP id b6mr18948543wro.53.1621929149447;
        Tue, 25 May 2021 00:52:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxHwIj/9rOfNndM5jJAWHzg448cYs0giNs6SHGBNZGGeed+ecAft4vmApavUXRAVUkm647vQ==
X-Received: by 2002:adf:ee86:: with SMTP id b6mr18948527wro.53.1621929149216;
        Tue, 25 May 2021 00:52:29 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f38:2400:62f4:c5fa:ba13:ac32? (p200300d82f38240062f4c5faba13ac32.dip0.t-ipconnect.de. [2003:d8:2f38:2400:62f4:c5fa:ba13:ac32])
        by smtp.gmail.com with ESMTPSA id d9sm14504444wrx.11.2021.05.25.00.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 00:52:28 -0700 (PDT)
Subject: Re: [PATCH 2/5] mm/sparse: free section usage memory in case
 populate_section_memmap failed
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, dongas86@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210517112044.233138-1-aisheng.dong@nxp.com>
 <20210517112044.233138-3-aisheng.dong@nxp.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <01356cc7-61c3-fb15-1c85-939b6366a636@redhat.com>
Date:   Tue, 25 May 2021 09:52:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210517112044.233138-3-aisheng.dong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.21 13:20, Dong Aisheng wrote:
> Free section usage memory in case populate_section_memmap failed.
> We use map_count to track the remain unused memory to be freed.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>   mm/sparse.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 7ac481353b6b..98bfacc763da 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -549,12 +549,14 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
>   			       __func__, nid);
>   			pnum_begin = pnum;
>   			sparse_buffer_fini();
> +			memblock_free_early(__pa(usage), map_count * mem_section_usage_size());
>   			goto failed;
>   		}
>   		check_usemap_section_nr(nid, usage);
>   		sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage,
>   				SECTION_IS_EARLY);
>   		usage = (void *) usage + mem_section_usage_size();
> +		map_count--;
>   	}
>   	sparse_buffer_fini();
>   	return;
> 

Why care about optimizing something that literally never fails, and if 
it would fail, leave the system in a sub-optimal, mostly unusable state?

-- 
Thanks,

David / dhildenb

