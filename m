Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3AC1365B64
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 16:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbhDTOoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 10:44:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56067 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231758AbhDTOoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 10:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618929823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=suIGX8gxDAa1NnElSORJBHL/+yMG1ICjZh8iApb4hRQ=;
        b=JoCJZO/iq7ysWqjYMEAS4F3n/avRPETV5fuXhPzx64f/MlIv9hZUU+w80aNDW84c5ziM/7
        A+BmP+gK9hqcknrdw2hieYeFaucudMc54K+drl0C7q+00t2Tb1ah1d2WvRSht2xh7697vf
        NNEENh3hiWeDRWR3yaqlVqY8xRogjAM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-SuYUx5quMl2oVFNGcZAn9g-1; Tue, 20 Apr 2021 10:43:39 -0400
X-MC-Unique: SuYUx5quMl2oVFNGcZAn9g-1
Received: by mail-ej1-f69.google.com with SMTP id r17-20020a1709069591b029037cf6a4a56dso4901579ejx.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 07:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=suIGX8gxDAa1NnElSORJBHL/+yMG1ICjZh8iApb4hRQ=;
        b=fXOlfNOXH1ts6c34WZU3nLFlzcsEFWuZ44z+dDIT3IpVilVWszN7g0S4RFRQ9v5Cnc
         P7WT5x4ULcCVmMw4VthAryY1Yz6CfJXid7SEhVnnJa+AUo15YpH/feXw9knrloQLUXwQ
         Rg38JASsj7KlD9wXSQm3bmiHAg4cTKOBfy1CEMH+DWboHOErPk9UhVpBWK683z9mas4b
         S9vgT5cd4RWZh9tpFY3fB2E/7Pp/mv5DdspToFRR1MwlkP8Aj+2L3+dVxJGb03X6K42K
         3/DNNLdCqkKwcpRuxv/R/0Vs3CZDQAtVq2GWrD0J9XnCxRTrF8SK7pk9GPvnU5o3B1XH
         MYOA==
X-Gm-Message-State: AOAM532LXRS8nq6hFgGfQZX7vsgdAdhdC8UZstoeAK/HDfV++oje4gHc
        i0/abnFp9Rn7HekdPiZpw6a2MjS/CHOiNeFBJI9CFSJk6yPu+OHrQiV9/Gi4U0QejdClrngFgwp
        wlW+wUz4wP03sWmIndT775pZ5
X-Received: by 2002:aa7:cb4c:: with SMTP id w12mr32367868edt.181.1618929818002;
        Tue, 20 Apr 2021 07:43:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycKxTX6uIvzg4SlHy5vEivTK5R28RJSkXNygI/D6/70trVtgRV/7yyyDFHnPHVinXCN//pAA==
X-Received: by 2002:aa7:cb4c:: with SMTP id w12mr32367855edt.181.1618929817824;
        Tue, 20 Apr 2021 07:43:37 -0700 (PDT)
Received: from [192.168.3.132] (p4ff2390a.dip0.t-ipconnect.de. [79.242.57.10])
        by smtp.gmail.com with ESMTPSA id x20sm3359873edd.58.2021.04.20.07.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 07:43:37 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] kernel/resource: Refactor __request_region to
 allow external locking
To:     Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        daniel.vetter@ffwll.ch, dan.j.williams@intel.com,
        gregkh@linuxfoundation.org, jhubbard@nvidia.com,
        jglisse@redhat.com, bsingharora@gmail.com, smuchun@gmail.com
References: <20210419070109.4780-1-apopple@nvidia.com>
 <20210419070109.4780-2-apopple@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <935515a6-7f9e-5622-36f8-3205f0cc0690@redhat.com>
Date:   Tue, 20 Apr 2021 16:43:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210419070109.4780-2-apopple@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.04.21 09:01, Alistair Popple wrote:
> Refactor the portion of __request_region() done whilst holding the
> resource_lock into a separate function to allow callers to hold the
> lock.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>   kernel/resource.c | 52 +++++++++++++++++++++++++++++------------------
>   1 file changed, 32 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 736768587d2d..75f8da722497 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1181,31 +1181,16 @@ struct address_space *iomem_get_mapping(void)
>   	return smp_load_acquire(&iomem_inode)->i_mapping;
>   }
>   
> -/**
> - * __request_region - create a new busy resource region
> - * @parent: parent resource descriptor
> - * @start: resource start address
> - * @n: resource region size
> - * @name: reserving caller's ID string
> - * @flags: IO resource flags
> - */
> -struct resource * __request_region(struct resource *parent,
> +static int __request_region_locked(struct resource *res, struct resource *parent,
>   				   resource_size_t start, resource_size_t n,
>   				   const char *name, int flags)
>   {
>   	DECLARE_WAITQUEUE(wait, current);
> -	struct resource *res = alloc_resource(GFP_KERNEL);
> -	struct resource *orig_parent = parent;
> -
> -	if (!res)
> -		return NULL;
>   
>   	res->name = name;
>   	res->start = start;
>   	res->end = start + n - 1;
>   
> -	write_lock(&resource_lock);
> -
>   	for (;;) {
>   		struct resource *conflict;
>   
> @@ -1241,13 +1226,40 @@ struct resource * __request_region(struct resource *parent,
>   			continue;
>   		}
>   		/* Uhhuh, that didn't work out.. */
> -		free_resource(res);
> -		res = NULL;
> -		break;
> +		return -EBUSY;
>   	}
> +
> +	return 0;
> +}
> +
> +/**
> + * __request_region - create a new busy resource region
> + * @parent: parent resource descriptor
> + * @start: resource start address
> + * @n: resource region size
> + * @name: reserving caller's ID string
> + * @flags: IO resource flags
> + */
> +struct resource *__request_region(struct resource *parent,
> +				  resource_size_t start, resource_size_t n,
> +				  const char *name, int flags)
> +{
> +	struct resource *res = alloc_resource(GFP_KERNEL);
> +	int ret;
> +
> +	if (!res)
> +		return NULL;
> +
> +	write_lock(&resource_lock);
> +	ret = __request_region_locked(res, parent, start, n, name, flags);
>   	write_unlock(&resource_lock);
>   
> -	if (res && orig_parent == &iomem_resource)
> +	if (ret) {
> +		free_resource(res);
> +		return NULL;
> +	}
> +
> +	if (parent == &iomem_resource)
>   		revoke_iomem(res);

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

