Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666E345B722
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 10:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhKXJLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 04:11:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56731 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229521AbhKXJLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 04:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637744881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tftmt6HhLzStOQXQxU8JhNVyqnYphErDEgqq9XZYR6Y=;
        b=Yvi6ukoBXARGVLfhQA3rAzPceLuB8/ke81qhbRfWW4IwEIewnxkgw75NG6voBpoGDWd9wi
        rNGPuW2O3Tr5fp007/E/0egj4J4BEH4st10Pa+G1GDAF4qenKQakr7biRDWQxdYJn5dv56
        2ILvZCmZ4CH2d86tjH8Jf3mUoTYChLk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-Zjq3Z5GyPsaPOxhY8EKAwg-1; Wed, 24 Nov 2021 04:08:00 -0500
X-MC-Unique: Zjq3Z5GyPsaPOxhY8EKAwg-1
Received: by mail-wm1-f70.google.com with SMTP id m18-20020a05600c3b1200b0033283ea5facso1447835wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 01:08:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=tftmt6HhLzStOQXQxU8JhNVyqnYphErDEgqq9XZYR6Y=;
        b=s7TG8AG0uo0fQ+mSh2Z3M0zIGeyQT9jLFgXPCR/iFdPkxxjMG4/9dbCFmzivNLGQME
         3+OOghdGggDwshFgyCuKL+H5r7q6AnEWuFK74QiEIxCA24C8gpRDndDxfgwhVrnGo8Xp
         LaQ81YrRsOyLFVjcx2FIAuuXnpXmxPc3c0+e/HC7dXE5Z4tQCc/l8h5a563z0Dz21Usz
         l6AXz9qc9Rw+nzUFnNsb0ViU/YXgnc66McR9lS9vYYtRh6P4Xin0+UBmBINvh0bXOckL
         bqJv4/cEtZBhbcL38L7BFBNZ8+/f1Z0e0n/VTI1e1jfFyVgyGk0CcbJjA1s+/NQkVRlH
         C9Hw==
X-Gm-Message-State: AOAM530XuLRhBztQ+f8/uuAPrVfBn1rSAUKphGDkQzan05769rmgf24u
        8ZyH8HCpqOdHBjUEjPNClYoO8vx0RS0KoAm8wBQLib83nyax+HNef4pPOWMgMOqKL3qjNbLlA6g
        FA0T6QcEJbTDc5DPspfAemIjU
X-Received: by 2002:a05:600c:1ca4:: with SMTP id k36mr12908217wms.169.1637744879367;
        Wed, 24 Nov 2021 01:07:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYzthtvsHZ0z9GA0UiSAAW87dOdxEC+19gD61VAW+aMuvp8UG/w5WA1kKpBpPvqEB2sTJLiw==
X-Received: by 2002:a05:600c:1ca4:: with SMTP id k36mr12908180wms.169.1637744879122;
        Wed, 24 Nov 2021 01:07:59 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6380.dip0.t-ipconnect.de. [91.12.99.128])
        by smtp.gmail.com with ESMTPSA id g19sm4178268wmg.12.2021.11.24.01.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 01:07:58 -0800 (PST)
Message-ID: <8bca8139-8a6c-77b2-c295-9698d3662251@redhat.com>
Date:   Wed, 24 Nov 2021 10:07:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] mm/kmemleak: Avoid scanning potential huge holes
Content-Language: en-US
To:     Lang Yu <lang.yu@amd.com>, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20211108140029.721144-1-lang.yu@amd.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211108140029.721144-1-lang.yu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.11.21 15:00, Lang Yu wrote:
> When using devm_request_free_mem_region() and devm_memremap_pages()
> to add ZONE_DEVICE memory, if requested free mem region's end pfn
> were huge(e.g., 0x400000000), the node_end_pfn() will be also huge
> (see move_pfn_range_to_zone()). Thus it creates a huge hole between
> node_start_pfn() and node_end_pfn().
> 
> We found on some AMD APUs, amdkfd requested such a free mem region
> and created a huge hole. In such a case, following code snippet was
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
> watchdog: BUG: soft lockup - CPU#6 stuck for 26s! [bash:1221]
> CPU: 6 PID: 1221 Comm: bash Not tainted 5.15.0-custom #1
> RIP: 0010:pfn_to_online_page+0x5/0xd0
> Call Trace:
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
> v2:
> - Only scan pages belonging to the zone.(David Hildenbrand)
> - Use __maybe_unused to make compilers happy.
> 
> Signed-off-by: Lang Yu <lang.yu@amd.com>
> ---
>  mm/kmemleak.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index b57383c17cf6..adbe5aa01184 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1403,7 +1403,8 @@ static void kmemleak_scan(void)
>  {
>  	unsigned long flags;
>  	struct kmemleak_object *object;
> -	int i;
> +	struct zone *zone;
> +	int __maybe_unused i;
>  	int new_leaks = 0;
>  
>  	jiffies_last_scan = jiffies;
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
> @@ -1454,8 +1455,8 @@ static void kmemleak_scan(void)
>  			if (!page)
>  				continue;
>  
> -			/* only scan pages belonging to this node */
> -			if (page_to_nid(page) != i)
> +			/* only scan pages belonging to this zone */
> +			if (page_zone(page) != zone)
>  				continue;
>  			/* only scan if page is in use */
>  			if (page_count(page) == 0)
> 

I think in theory we could optimize further, there really isn't that
much need to skip single pages ... we can usually skip whole 
pageblocks. (in some corner cases we might have to back off 
one pageblock and continue the search page-wise). But that's a
different story and there might not be need to optimize.


Also, I wonder if we should adjust the cond_resched() logic instead.
While your code makes the "sparse node" case faster, I think we could
still run into the same issue in the "sparse zone" case now.

Acked-by: David Hildenbrand <david@redhat.com>

to this patch.


diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index b57383c17cf6..1cd1df3cb01b 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1451,6 +1451,9 @@ static void kmemleak_scan(void)
                for (pfn = start_pfn; pfn < end_pfn; pfn++) {
                        struct page *page = pfn_to_online_page(pfn);
 
+                       if (!(pfn & 63))
+                               cond_resched();
+
                        if (!page)
                                continue;
 
@@ -1461,8 +1464,6 @@ static void kmemleak_scan(void)
                        if (page_count(page) == 0)
                                continue;
                        scan_block(page, page + 1, NULL);
-                       if (!(pfn & 63))
-                               cond_resched();
                }
        }
        put_online_mems();


What do you think?

-- 
Thanks,

David / dhildenb

