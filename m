Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0E0A365530
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 11:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhDTJXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 05:23:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49460 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230168AbhDTJXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 05:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618910582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ix5YDMmXJ3C1/BneKisaiFbJVja4N1CpmLxhrOr+FWA=;
        b=T1xvWNeIyPYaVf+bM3mQQVaoA6vxGazYBlLgonCy4muMVFcRrWzpfN8StGG3MScwQIVM/V
        QApTTDlHR1L0OWW3miL0omBknCOXRpuBTPjuOaQlOFYiAlfGTcDf37dJ1tw2A1amfLZUKQ
        P1qfmiK/AZ1pQRvHvPCOE8kZTM9ZYI4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-rAO9C1eoMH-_bq_8J2uv9w-1; Tue, 20 Apr 2021 05:22:55 -0400
X-MC-Unique: rAO9C1eoMH-_bq_8J2uv9w-1
Received: by mail-wm1-f69.google.com with SMTP id n67-20020a1c59460000b0290114d1a03f5bso5672782wmb.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 02:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ix5YDMmXJ3C1/BneKisaiFbJVja4N1CpmLxhrOr+FWA=;
        b=B8VOffcQmaImwtEAQuCJbpYH/7lRofbnXT4mZKuokc5gNdXnhHLfCpds5GUEyiv9rG
         wp8/e0NaRgonYTVZzMrQnUhz4jiXMaq5VyYeab6LwSANe9BkX++wAvnLfFuaeXOwXH7P
         Y72Tx5S1pg+LnegxI4LYyV4xIXxxa+09ruCoV3EV4klsOg1ZYQPt5lVIsNxoqj0KdGcv
         azP1h47RgZGmiAZvy/UdB9uHr2/P5YOnHimTj2M8fYUgQee4KTbPCdGqDKqVs9oq6bQo
         R3aqYa2jl0qtNPnBywGlu5VYuLYkuRh3dSrUBXgSfbg7ZH0XEHA8fq2mHOLh5dHGrq2b
         ccBw==
X-Gm-Message-State: AOAM533sfG4BEf8fc0DyHhS0/uhnMd2hBYCym4LPG7s8fMoC9R4KjB6l
        dGiv3cGY3RT0p76mWZN56A+skOp58EYqfuCYxBoc8qEY/aOB6j+HwS6zlfRmiwkkvQYmn7ZDuOz
        0djQRahAmRHGlzYE0xymnL8oQ
X-Received: by 2002:a1c:c911:: with SMTP id f17mr3456338wmb.45.1618910574425;
        Tue, 20 Apr 2021 02:22:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyds3aZGiGfNhY717LR9Fd18v+z+0WjKZswcFhDMLESmpRmh8l/f3c9okYjlf6HDlj+DWj7Ug==
X-Received: by 2002:a1c:c911:: with SMTP id f17mr3456313wmb.45.1618910574180;
        Tue, 20 Apr 2021 02:22:54 -0700 (PDT)
Received: from [192.168.3.132] (p4ff2390a.dip0.t-ipconnect.de. [79.242.57.10])
        by smtp.gmail.com with ESMTPSA id g13sm30774192wrr.9.2021.04.20.02.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 02:22:53 -0700 (PDT)
Subject: Re: [PATCH v1 1/4] include/linux/mmzone.h: add documentation for
 pfn_valid()
To:     Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210420090925.7457-1-rppt@kernel.org>
 <20210420090925.7457-2-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <f900f889-f059-7d48-dfc7-145c8cd54cf6@redhat.com>
Date:   Tue, 20 Apr 2021 11:22:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210420090925.7457-2-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.04.21 11:09, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Add comment describing the semantics of pfn_valid() that clarifies that
> pfn_valid() only checks for availability of a memory map entry (i.e. struct
> page) for a PFN rather than availability of usable memory backing that PFN.
> 
> The most "generic" version of pfn_valid() used by the configurations with
> SPARSEMEM enabled resides in include/linux/mmzone.h so this is the most
> suitable place for documentation about semantics of pfn_valid().
> 
> Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>   include/linux/mmzone.h | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 47946cec7584..961f0eeefb62 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1410,6 +1410,17 @@ static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
>   #endif
>   
>   #ifndef CONFIG_HAVE_ARCH_PFN_VALID
> +/**
> + * pfn_valid - check if there is a valid memory map entry for a PFN
> + * @pfn: the page frame number to check
> + *
> + * Check if there is a valid memory map entry aka struct page for the @pfn.
> + * Note, that availability of the memory map entry does not imply that
> + * there is actual usable memory at that @pfn. The struct page may
> + * represent a hole or an unusable page frame.
> + *
> + * Return: 1 for PFNs that have memory map entries and 0 otherwise
> + */
>   static inline int pfn_valid(unsigned long pfn)
>   {
>   	struct mem_section *ms;
> 

I'd rephrase all "there is a valid memory map" to "there is a memory 
map" and add "pfn_valid() does to indicate whether the memory map as 
actually initialized -- see pfn_to_online_page()."

pfn_valid() means that we can do a pfn_to_page() and don't get a fault 
when accessing the "struct page". It doesn't state anything about the 
content.

-- 
Thanks,

David / dhildenb

