Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1A44463E8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 14:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbhKENRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 09:17:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31347 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229529AbhKENRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 09:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636118094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cipQgNVTuxKP3IGGvIvJ0OX8skmtJ1D0RKlfG0HMsY4=;
        b=RdhDVrpJr32kuh6LDgyvGlP92ZJrDK3w6dKQsYfzGrci+iijJGcfTG70xm6Tf6YfzKy219
        3nUjuXBxiLIgNmvi6yZ4r23Zh7MgpOMF5bfBWTq2O5XfcsEnHwF+SiNYMVzuMUPPeWL4He
        qvJoXM9PtUf9qCWN53u6UYzXEJWdPG8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-Dga2ZtL3OBiFpxPZ1nBZHQ-1; Fri, 05 Nov 2021 09:14:53 -0400
X-MC-Unique: Dga2ZtL3OBiFpxPZ1nBZHQ-1
Received: by mail-wm1-f69.google.com with SMTP id 145-20020a1c0197000000b0032efc3eb9bcso5696650wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 06:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=cipQgNVTuxKP3IGGvIvJ0OX8skmtJ1D0RKlfG0HMsY4=;
        b=vcIwqi3RKBOVOyp5/yqK/2nWiqn9GVIxWpaKjFu/RjrJ/EutjrWyaRN1fr2F6mS18l
         q2Igv7bq9SWnV4TI8SapbY1uhm4El6LbyBqA/zHlmHgxg4UtYNppJFRzLfSQVml+ncXu
         2x1Mqru98nrggPHKajv4ZqQD3TdcslDKZGAnv6abpY6AGOZJFDmjjrvwVgkVjbI06UJE
         9/MAags4GDj3Xwlw/z9oHetKx21sa50wxbByQajYYdLvwxoMntmvDIK7tzVj9WLrDen5
         IuF6WNv2fVwmGHgGhnSc/3h1uu2R0LpXFSOTZkSsNoSddeHxArUieQPacyTwmbLJiU6U
         B7eQ==
X-Gm-Message-State: AOAM530WKR1yyG1idfzDmmqPXJv4QEbJqIRaWpelJz80dgIy6x1te7hJ
        OBHJnnu+dQeiIWZxHysQ0OKAA7O4/s2wXvwuJu3NViW7v67zWieASnJOVCe0c8Oh8GPwYZ3CEYi
        ma9okuuPFQAsffyNvaYMt3aZ0
X-Received: by 2002:a7b:cbc3:: with SMTP id n3mr30833946wmi.15.1636118092321;
        Fri, 05 Nov 2021 06:14:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjLBuk120ET2AqSLkOFNtaP+Vx9v5XHOJr4E0tU4vBg08W3mnHMCfMWOLtyKXuYkoakLXblA==
X-Received: by 2002:a7b:cbc3:: with SMTP id n3mr30833920wmi.15.1636118092066;
        Fri, 05 Nov 2021 06:14:52 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:a000:3f25:9662:b5cf:73f9? (p200300d82f0ca0003f259662b5cf73f9.dip0.t-ipconnect.de. [2003:d8:2f0c:a000:3f25:9662:b5cf:73f9])
        by smtp.gmail.com with ESMTPSA id 8sm10916174wmg.24.2021.11.05.06.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 06:14:51 -0700 (PDT)
Message-ID: <db19fb83-7a96-605e-65ba-10e01391530d@redhat.com>
Date:   Fri, 5 Nov 2021 14:14:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Lang Yu <lang.yu@amd.com>, linux-mm@kvack.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
References: <20211105035241.1239751-1-lang.yu@amd.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/kmemleak: Avoid scanning potential huge holes
In-Reply-To: <20211105035241.1239751-1-lang.yu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.11.21 04:52, Lang Yu wrote:
> When using devm_request_free_mem_region() and
> devm_memremap_pages() to add ZONE_DEVICE memory, if requested
> free mem region pfn were huge(e.g., 0x0x400000000 ,we found
> on some amd apus, amdkfd svm will request a such free mem region),
> the node_end_pfn() will be also huge(see move_pfn_range_to_zone()).
> It creates a huge hole between node_start_pfn() and node_end_pfn().
> 
> In such a case, following code snippet acctually was
> just doing busy test_bit() looping on the huge hole.
> 
> for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> 	struct page *page = pfn_to_online_page(pfn);
> 		if (!page)
> 			continue;
> 	...
> }
> 
> So we got a soft lockup:
> 
>  watchdog: BUG: soft lockup - CPU#6 stuck for 26s! [bash:1221]
>  CPU: 6 PID: 1221 Comm: bash Not tainted 5.15.0-custom #1
>  RIP: 0010:pfn_to_online_page+0x5/0xd0
>  Call Trace:
>   ? kmemleak_scan+0x16a/0x440
>   kmemleak_write+0x306/0x3a0
>   ? common_file_perm+0x72/0x170
>   full_proxy_write+0x5c/0x90
>   vfs_write+0xb9/0x260
>   ksys_write+0x67/0xe0
>   __x64_sys_write+0x1a/0x20
>   do_syscall_64+0x3b/0xc0
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> I did some tests with the patch.
> 
> (1) amdgpu module unloaded
> 
> before the patch:
> 
> real    0m0.976s
> user    0m0.000s
> sys     0m0.968s
> 
> after the patch:
> 
> real    0m0.981s
> user    0m0.000s
> sys     0m0.973s
> 
> (2) amdgpu module loaded
> 
> before the patch:
> 
> real    0m35.365s
> user    0m0.000s
> sys     0m35.354s
> 
> after the patch:
> 
> real    0m1.049s
> user    0m0.000s
> sys     0m1.042s
> 
> Signed-off-by: Lang Yu <lang.yu@amd.com>
> ---
>  mm/kmemleak.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index b57383c17cf6..d07444613a84 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1403,6 +1403,7 @@ static void kmemleak_scan(void)
>  {
>  	unsigned long flags;
>  	struct kmemleak_object *object;
> +	struct zone *zone;
>  	int i;
>  	int new_leaks = 0;
>  
> @@ -1443,9 +1444,9 @@ static void kmemleak_scan(void)
>  	 * Struct page scanning for each node.
>  	 */
>  	get_online_mems();
> -	for_each_online_node(i) {
> -		unsigned long start_pfn = node_start_pfn(i);
> -		unsigned long end_pfn = node_end_pfn(i);
> +	for_each_populated_zone(zone) {
> +		unsigned long start_pfn = zone->zone_start_pfn;
> +		unsigned long end_pfn = zone_end_pfn(zone);
>  		unsigned long pfn;
>  
>  		for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> @@ -1455,7 +1456,7 @@ static void kmemleak_scan(void)
>  				continue;
>  
>  			/* only scan pages belonging to this node */
> -			if (page_to_nid(page) != i)
> +			if (page_to_nid(page) != zone_to_nid(zone))

With overlapping zones you might rescan ranges ... instead we should do:

/* only scan pages belonging to this zone */
if (zone != page_zone(page))
	...

Or alternatively:

/* only scan pages belonging to this node */
if (page_to_nid(page) != zone_to_nid(zone))
	continue;
/* only scan pages belonging to this zone */
if (page_zonenum(page) != zone_idx(zone))
	continue;
-- 
Thanks,

David / dhildenb

