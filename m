Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C48E3E8D50
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 11:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbhHKJgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 05:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236605AbhHKJgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 05:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628674567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fAL7lFqNaCWC9sPJWFoOY2QAZTbHbZLMj6qk/rK8uKs=;
        b=Bx9E5KuNYuBTq5M16xVJKYT9PSy28O86kfajk6zQCGCm8xMrkiK5Mws75AYsi9dgVKvc2q
        f7CrCGUg3KxwrpjXUPCXYiPyk0+VFZCSoizfL+7RcW4Lh6Zqnss3qCwRx02+uXg83IpYLt
        P0S5cPj/SQhIXkzzutnx5Fv0g4mun0Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-Xj5BKai_NdKtSFC_E27gyQ-1; Wed, 11 Aug 2021 05:36:06 -0400
X-MC-Unique: Xj5BKai_NdKtSFC_E27gyQ-1
Received: by mail-wm1-f70.google.com with SMTP id z15-20020a7bc7cf0000b02902e6a68ffd3cso384826wmk.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 02:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fAL7lFqNaCWC9sPJWFoOY2QAZTbHbZLMj6qk/rK8uKs=;
        b=LIE4dHMaCDJUtgUkUwlGbi5woalauXar0piM/CEzQ9UUTIZLoGEj8lpoCoVTCtTbLV
         f0S93Xrip8SXhm2uzyVrHVefBCnsD4S/J9E2J2SEF2bqch3Ufm4cOSFI/I5305OyPssI
         SCqhGf3Sjid3YhPdjlPiB90UabDy9j8h8e9a347lo/qQm+MyzaZ5PPszaVWoeiBAna5C
         99v5a9zxEVC6Z18kRwksK06NuSPHneFRORaX/QfiX+YswQov8QkVU1ef5DImRW06djxt
         IFt3DEAukuTM6epJ54OBmv/FDqXjknKaPh62Kjc88et8Au1LLEHm7WBSMnsT3kj8Q1lR
         xpsA==
X-Gm-Message-State: AOAM531SG4rQBr/26MIqw3v3Xga9MNGZtRjhrXa6+SOzQtr0iZgzUPOD
        ol52epzLHxfnme6c5Rt2krkSDn1fyLgdS+lx3nVL/XGN5aUacZuB/ug88suAd21ToD1d+Hfjb01
        BKG6iEVq9sTn6bU11XdL+9BHefyYzgDdzsJfB91/Usm+wu8YrwIWK+RwanzN/RZpEWU+eXyc1
X-Received: by 2002:a1c:20c5:: with SMTP id g188mr7314405wmg.142.1628674565424;
        Wed, 11 Aug 2021 02:36:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxicKBXa5SX1egzEWmTZsOp4H8+byabbdag6mjhyCrCsn4UXxoDBgtqsTunuMaWIsRg6uEBYA==
X-Received: by 2002:a1c:20c5:: with SMTP id g188mr7314372wmg.142.1628674565128;
        Wed, 11 Aug 2021 02:36:05 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64a0.dip0.t-ipconnect.de. [91.12.100.160])
        by smtp.gmail.com with ESMTPSA id l18sm6275309wmc.30.2021.08.11.02.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 02:36:04 -0700 (PDT)
Subject: Re: [PATCH] memblock: Add missing debug code to memblock_add_node()
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <c45e5218b6fcf0e3aeb63d9a9d9792addae0bb7a.1628672041.git.geert+renesas@glider.be>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <3d2ce3dd-5032-89fc-822d-5288a9c460b9@redhat.com>
Date:   Wed, 11 Aug 2021 11:36:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c45e5218b6fcf0e3aeb63d9a9d9792addae0bb7a.1628672041.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.21 10:54, Geert Uytterhoeven wrote:
> All other memblock APIs built on top of memblock_add_range() contain
> debug code to print their parameters.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>   mm/memblock.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index de7b553baa50004c..57a9849a5d820c34 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -665,6 +665,11 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
>   int __init_memblock memblock_add_node(phys_addr_t base, phys_addr_t size,
>   				       int nid)
>   {
> +	phys_addr_t end = base + size - 1;
> +
> +	memblock_dbg("%s: [%pa-%pa] nid=%d %pS\n", __func__,
> +		     &base, &end, nid, (void *)_RET_IP_);
> +
>   	return memblock_add_range(&memblock.memory, base, size, nid, 0);
>   }
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

