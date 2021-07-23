Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39F53D350F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 09:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbhGWGa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 02:30:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57054 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234089AbhGWGa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 02:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627024257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yQQEn4AJk4jpfjaQyvDLnuQEm5eCkpcI1tfMEOwcZwY=;
        b=G/CEcc01rfEO3ccNf5+973RfnSy58PoRVp8bTVGi0QvHZJLe/LMAexgfrZOD13RUEUASBA
        TJg03Ed8m4xBs27ZcnV3SB6Scjg0T6qfyKWs+TrRfMQMOtIYXKALlWddmMHaaxvzm1jIOQ
        scClPWEuMz12ieKJetUZpcBt49WpaZ0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-yhGbjeMsNgOim7ImQqk7mA-1; Fri, 23 Jul 2021 03:10:56 -0400
X-MC-Unique: yhGbjeMsNgOim7ImQqk7mA-1
Received: by mail-wm1-f71.google.com with SMTP id g21-20020a1c20150000b0290205f5e73b37so475105wmg.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 00:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yQQEn4AJk4jpfjaQyvDLnuQEm5eCkpcI1tfMEOwcZwY=;
        b=sK0AeaAQY/T0auoDh15Z0/06iElpwDfCAceO1aZDSW82u/DnSdsNvzTdSP6XjEx3DI
         Vyweuc8FrPqeFx/VWE/1QWNe997vK1zyHNHRf8wTk8XG2VoaWlDHT5I+QaoX6J8Khw9j
         0N/rmVRMLx6vKBILOjfhrmAqvsnaurWOLEpTyadx5bxdHr/G6NVnBEXxu9jOm0EOQrrK
         g+dO6oiuBW1/ndxG5P6TXdtbdhFX+hgC2iUnZgHaFqYZhCv1Wx1BM/sN83RHhhsWxvPe
         jEwcrH/bzBDqmEQ/G6xYteLlgwKk19nrlpwQftX/2QfklmqaoTcCcMVrYaBBh+ehdR1R
         AsjQ==
X-Gm-Message-State: AOAM532sBeKbdvfg0RRHGPCUEUyAoC3unOZuHBVbi2iCzaSdXvX/FGTq
        Pblm4ZXn/iZGqcUOfrczaZDVaVqDnFvjkfApc6mPVW2MAXtapIwv1ae7Lfy9VqtxdAsfUlWmdb8
        oflNga0NFSTe2meOgUCWmT7wN
X-Received: by 2002:a1c:5419:: with SMTP id i25mr3030821wmb.71.1627024255010;
        Fri, 23 Jul 2021 00:10:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWxbBRVGgAi+ozrhBgrntbx1X/RgUw72RP8WBiXPq3KSVreuWRGEjszp3XAGBZRo8PxJt5BQ==
X-Received: by 2002:a1c:5419:: with SMTP id i25mr3030796wmb.71.1627024254780;
        Fri, 23 Jul 2021 00:10:54 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c676e.dip0.t-ipconnect.de. [91.12.103.110])
        by smtp.gmail.com with ESMTPSA id 6sm4458632wmi.3.2021.07.23.00.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 00:10:54 -0700 (PDT)
Subject: Re: [RESEND PATCH v2] mm/sparse: clarify pgdat_to_phys
To:     Miles Chen <miles.chen@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
References: <20210723070137.23321-1-miles.chen@mediatek.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <a042906d-7d07-d1af-57d2-ab4cbdc53f36@redhat.com>
Date:   Fri, 23 Jul 2021 09:10:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210723070137.23321-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.07.21 09:01, Miles Chen wrote:
> Clarify pgdat_to_phys() by testing if
> pgdat == &contig_page_data when CONFIG_NUMA=n.
> 
> contig_page_data is only available when CONFIG_NUMA=n
> so we have to use #ifndef here.
> 
> No functional change intended.
> 
> Comment from Mark [1]:
> "
> ... and I reckon it'd be clearer and more robust to define
> pgdat_to_phys() in the same ifdefs as contig_page_data so
> that these, stay in-sync. e.g. have:
> 
> | #ifdef CONFIG_NUMA
> | #define pgdat_to_phys(x)	virt_to_phys(x)
> | #else /* CONFIG_NUMA */
> |
> | extern struct pglist_data contig_page_data;
> | ...
> | #define pgdat_to_phys(x)	__pa_symbol(&contig_page_data)
> |
> | #endif /* CONIFIG_NUMA */
> "
> 
> Comment from Mike [2]:
> "
> I'm not sure a macro is better than a static inline.
> 
> Maybe we'd want to warn if pgdat passed to pgtat_to_phys() is not
> &contig_page_data, e.g something like
> 
> static inline phys_addr_t pgdat_to_phys(struct pglist_data *pgdat)
> {
> 	if (!IS_ENABLED(CONFIG_NUMA)) {
> 		if (pgdat == &contig_page_data)
> 			return __pa_symbol(&contig_page_data);
> 		else
> 			pr_warn("Unexpected pglist_data pointer!\n");
> 	}
> 
> 	return __pa(pgdat);
> }
> "
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20210615131902.GB47121@C02TD0UTHF1T.local/
> [2] https://lore.kernel.org/patchwork/patch/1452903/#1650759
> 
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> 
> ---
> 
> Change since v1:
> Thanks for Mike's comment, check if pgdat == &contig_page_data,
> so it is clearer that we only expect contig_page_data when
> CONFIG_NUMA=n.
> ---
>   mm/sparse.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 6326cdf36c4f..f73ff3c124c5 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -348,10 +348,11 @@ size_t mem_section_usage_size(void)
>   static inline phys_addr_t pgdat_to_phys(struct pglist_data *pgdat)
>   {
>   #ifndef CONFIG_NUMA
> -	return __pa_symbol(pgdat);
> -#else
> +	if (pgdat == &contig_page_data)
> +		return __pa_symbol(&contig_page_data);
> +	pr_warn("Unexpected pglist_data pointer!\n");

Shouldn't this rather be a VM_BUG_ON()?

Because it looks like something that should barely happen and we might 
not want to perform runtime checks on each and every system?


-- 
Thanks,

David / dhildenb

