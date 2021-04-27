Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E0436C172
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 11:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbhD0JGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 05:06:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51284 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235073AbhD0JGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 05:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619514322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BcjMISn7V/DVN17pgvTQsJjmuRI26S5gt2Wqek6aFi4=;
        b=dHjstjCMkMfhEQCVLXaaGKhFboHazGGHyE2ZRlXfRB10KVSAx8lrLy7HjbxeQe7/8f+v6S
        qaNgLsIrRon0wxippoU8ULSaFQLXyBaATaX2QH0aLZXHG3G8RhsY5NIcSTBUhC/s/L8tRi
        UD8Vru0TrlBeyP6w7We1zKp6wfbhl6w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-TD-UIP_UNhyUjDpcsNLDJw-1; Tue, 27 Apr 2021 05:05:20 -0400
X-MC-Unique: TD-UIP_UNhyUjDpcsNLDJw-1
Received: by mail-wm1-f72.google.com with SMTP id n9-20020a1c40090000b02901401bf40f9dso2481640wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 02:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BcjMISn7V/DVN17pgvTQsJjmuRI26S5gt2Wqek6aFi4=;
        b=B+pqQrFcrcOuMaGVhs04YfszDz4YRn98w0m/zGxTaIHFMt+p8edMZN7aZPNK0lwXFy
         2PeBaDDhJXC16on2MfhmrkEyjn/GrT5i7KPzUDL/NMsR64eO6i5gTarlcrp/5kLhFEl6
         fbVDIyCNjgxB/w/e7Ue428+fdqcHldNhZXQcYScrx+t7WxerXKrgIKL16nrZ/AA5L+ax
         swLGqEKTbcaFnakFcbduT/NEX0RhI5itNBe+3zTbtsTWSNUH8Rt9R0w4Tjt5nMc+tST/
         7H+KSlGoBupTIHL4MT39BJrFBJsTnCO4XgXBn5Gx2DFGSVPbxdhFhL6c4xKKGzihXOWe
         W0Jw==
X-Gm-Message-State: AOAM533LrVLXg9+Wnsc2rQo5bu1XJto5HHGRlvbIethkb7tAY/oSeYeF
        iaX7NiRams/UiTIzJIr+cKe1J+wksOcMwmpAv5P6Skg7poQwS/SUG7T0ZASXbAO1Us/eZSf5/os
        z15bpgkUdEyQByUvf1k495KfE
X-Received: by 2002:a5d:5141:: with SMTP id u1mr28151128wrt.207.1619514319106;
        Tue, 27 Apr 2021 02:05:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqgxvydwTKfDMMf1+J0sldSQLjLwqRj7z342B9/MovDRGLgaf70ey0MXxd7bl4GOIiLYrLcg==
X-Received: by 2002:a5d:5141:: with SMTP id u1mr28151110wrt.207.1619514318911;
        Tue, 27 Apr 2021 02:05:18 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f38:2400:62f4:c5fa:ba13:ac32? (p200300d82f38240062f4c5faba13ac32.dip0.t-ipconnect.de. [2003:d8:2f38:2400:62f4:c5fa:ba13:ac32])
        by smtp.gmail.com with ESMTPSA id m67sm2204003wme.27.2021.04.27.02.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 02:05:18 -0700 (PDT)
Subject: Re: [PATCH] mm/sparse: Fix flags overlap in section_mem_map
To:     Wang Wensheng <wangwensheng4@huawei.com>,
        akpm@linux-foundation.org, osalvador@suse.de,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     rui.xiang@huawei.com
References: <20210427083019.110184-1-wangwensheng4@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <e838d8b5-84f1-5532-6f22-e4b729124e1c@redhat.com>
Date:   Tue, 27 Apr 2021 11:05:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210427083019.110184-1-wangwensheng4@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.04.21 10:30, Wang Wensheng wrote:
> The section_mem_map member of struct mem_section stores some flags and
> the address of struct page array of the mem_section.
> 
> Additionally the node id of the mem_section is stored during early boot,
> where the struct page array has not been allocated. In other words, the
> higher bits of section_mem_map are used for two purpose, and the node id
> should be clear properly after the early boot.
> 
> Currently the node id field is overlapped with the flag field and cannot
> be clear properly. That overlapped bits would then be treated as
> mem_section flags and may lead to unexpected side effects.
> 
> Define SECTION_NID_SHIFT using order_base_2 to ensure that the node id
> field always locates after flags field. That's why the overlap occurs -
> forgetting to increase SECTION_NID_SHIFT when adding new mem_section
> flag.
> 
> Fixes: 326e1b8f83a4 ("mm/sparsemem: introduce a SECTION_IS_EARLY flag")
> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
> ---
>   include/linux/mmzone.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 47946ce..b01694d 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1325,7 +1325,7 @@ extern size_t mem_section_usage_size(void);
>   #define SECTION_TAINT_ZONE_DEVICE	(1UL<<4)
>   #define SECTION_MAP_LAST_BIT		(1UL<<5)
>   #define SECTION_MAP_MASK		(~(SECTION_MAP_LAST_BIT-1))
> -#define SECTION_NID_SHIFT		3
> +#define SECTION_NID_SHIFT		order_base_2(SECTION_MAP_LAST_BIT)
>   
>   static inline struct page *__section_mem_map_addr(struct mem_section *section)
>   {
> 

Well, all sections around during boot that have an early NID are early 
... so it's not an issue with SECTION_IS_EARLY, no? I mean, it's ugly, 
but not broken.

But it's an issue with SECTION_TAINT_ZONE_DEVICE, AFAIKT. 
sparse_init_one_section() would leave the bit set if the nid happens to 
have that bit set (e.g., node 2,3). It's semi-broken then, because we 
force all pfn_to_online_page() through the slow path.


That whole section flag setting code is fragile.

-- 
Thanks,

David / dhildenb

