Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3223EE712
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 09:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbhHQHSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 03:18:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232999AbhHQHSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 03:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629184671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rf3UZ1ygefepa0+9j6MzSobnoEcFqDpKQ7TfnlJhrFM=;
        b=YHD4RXmSaIBAETtBkB0x6hAiwPVMMDGLyzyklqRmf7Rt1d/N5THAxi+DTtZbB6sJQwLNTZ
        2STKKE89QEiTb7fAujk+v8qXZA/WNHJMqYVcn3AljIxZnawY13qlYBQqZKvuVsBFGHD1vD
        aQc75txXyIK094JxYz9CyL21Fvbgmtg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-bLhqOK-BOquP-CJflxVMTg-1; Tue, 17 Aug 2021 03:17:50 -0400
X-MC-Unique: bLhqOK-BOquP-CJflxVMTg-1
Received: by mail-wm1-f69.google.com with SMTP id z15-20020a7bc7cf0000b02902e6a68ffd3cso586957wmk.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 00:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Rf3UZ1ygefepa0+9j6MzSobnoEcFqDpKQ7TfnlJhrFM=;
        b=mc6rlG86VmHVe4CWqLSTDGN/I1Szbv4mthUR0L8DRRm+wzWqbfylR9RuRyiDRPiAdk
         vXcl4B4E/J09foqYv/Q89q8cfQvxrsvZgf/5xSEn7XgLAoPFeUGP+XQphEhsJJ+R+i2q
         dnRsxZkVgtEJFDn0ftk3VCVUGc2tT26p339+WtSiEn+Y0mQFNkOuqHMdifbtX0QfEtm8
         lJy2OOiFXcgvANmbvfM263FicIjPKlz0SflKSlPZlPoH9rHKno6FpgspogSvGHX0Obeh
         QFdZKCR5Pfjgzul3cyQcLISY29ebkNOc4Ew/jLxAEhES6111xwU4asUXDyrYXOcmAbdK
         xU6g==
X-Gm-Message-State: AOAM532MIen6fAgwbTs2quuxCpQ8AfsC7htCI2VEnQALF1rFlhuLk+6K
        bB9c6fk+SLpTnvTT/UovKCQWWsThd07si1xj4xCNChXKLKIJswpJadIBYmSIf2Dp7MgThky/Bni
        SEMSQPuOsJM4AH8vl0eeHSone2lXLFfAmLiBymlizAYVdsiqq8KRYuKAet0VQogwyOmYkEqTX
X-Received: by 2002:a1c:4e08:: with SMTP id g8mr1880527wmh.116.1629184669094;
        Tue, 17 Aug 2021 00:17:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxneaey6sOYZDvyNBPB+IbsKnxSHyfSd/4LlE95bb2u+osxqFP6LfAkCvBDN8Ofav3kjei/mQ==
X-Received: by 2002:a1c:4e08:: with SMTP id g8mr1880497wmh.116.1629184668820;
        Tue, 17 Aug 2021 00:17:48 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c65c6.dip0.t-ipconnect.de. [91.12.101.198])
        by smtp.gmail.com with ESMTPSA id v1sm1263581wrt.93.2021.08.17.00.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 00:17:48 -0700 (PDT)
Subject: Re: [PATCH] mm: bootmem_info: mark __init on
 register_page_bootmem_info_section
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210817042221.77172-1-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <9198523b-a049-1c92-1818-989bab30628b@redhat.com>
Date:   Tue, 17 Aug 2021 09:17:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210817042221.77172-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.08.21 06:22, Muchun Song wrote:
> The register_page_bootmem_info_section() is only called from __init
> functions, so mark __init on it as well.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   mm/bootmem_info.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
> index 5b152dba7344..f03f42f426f6 100644
> --- a/mm/bootmem_info.c
> +++ b/mm/bootmem_info.c
> @@ -39,7 +39,7 @@ void put_page_bootmem(struct page *page)
>   }
>   
>   #ifndef CONFIG_SPARSEMEM_VMEMMAP
> -static void register_page_bootmem_info_section(unsigned long start_pfn)
> +static void __init register_page_bootmem_info_section(unsigned long start_pfn)
>   {
>   	unsigned long mapsize, section_nr, i;
>   	struct mem_section *ms;
> @@ -74,7 +74,7 @@ static void register_page_bootmem_info_section(unsigned long start_pfn)
>   
>   }
>   #else /* CONFIG_SPARSEMEM_VMEMMAP */
> -static void register_page_bootmem_info_section(unsigned long start_pfn)
> +static void __init register_page_bootmem_info_section(unsigned long start_pfn)
>   {
>   	unsigned long mapsize, section_nr, i;
>   	struct mem_section *ms;
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

