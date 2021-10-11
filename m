Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805C94288E1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 10:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbhJKIhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 04:37:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235127AbhJKIgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 04:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633941284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Av9k6rWcK0Mzelc/cpt++/TO3lqjdIJG6hSk2ZuzFmw=;
        b=FbNUvnQuyIzcO8ou76X52xLqHewhpXUy+XWYWz6YXRqWTijEDdjGQB7cfsXBPt04g5WjP+
        3dYZDEye94LeVTdqIMxslrZXtoCnteqljKE5jEHTUKVHbR1I5D1JvpEHqwf3xmsFkyQFA+
        nJUW6ZZSR0qQxUc8k6Gm0n7qpuAANKo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-OsYe9DuOPIigit1pEX4Xew-1; Mon, 11 Oct 2021 04:34:42 -0400
X-MC-Unique: OsYe9DuOPIigit1pEX4Xew-1
Received: by mail-wr1-f70.google.com with SMTP id a15-20020a056000188f00b00161068d8461so2327554wri.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 01:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Av9k6rWcK0Mzelc/cpt++/TO3lqjdIJG6hSk2ZuzFmw=;
        b=0YymSoo2MnoV8KJ0m+ifd9kWAp/p6gZciULV/4GNtbBrQgLN2t1WI0V6jPudAAGMWa
         QfpfqKHMvCiEmJ0T5aejjNJnlP8VkmS9/V0OD9bxMtPn2iUHKSUBXZaXRYFwyoV74MU6
         /aQShGxcL9TOTDZQIr6FktA5CYiw5wXw1wjhssakdmCcJ/Lr0NQDjPgQBpfEwvnAlMfs
         RwPNk3hEA70jzlY0Magu0fkT5BV8WReNQGLc8eNapyizFN2gAfxssjA9pKUWoZh3EPHp
         VabLA7vx0VZLFOcYuVdtYlxflzrgv8rtTZHtPGp3xdLYzdUMntSONa1IX6fO6IOdpSEg
         kDQA==
X-Gm-Message-State: AOAM531ZEcrkvb5a6r2CBaYaIyN2MpQEXRjvzSdwBeJRKkJC5N5VAfr/
        RduIJuJXBV5qVkPi462R+I7vk02BAS7gC7uhRLeVFlaTzrzpPUGVJCQiXSIZspf/QrPLlMYwGHT
        0wjsTKmhEQyEr92rberLXJG3k
X-Received: by 2002:adf:a15c:: with SMTP id r28mr23242869wrr.287.1633941281286;
        Mon, 11 Oct 2021 01:34:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwMGVPHnDaGNu4iH5/Oh7YURjzaVOZpfBI3BPOtxfFmYbxV7o0LLHXnbscRCq2aMeh5G30FA==
X-Received: by 2002:adf:a15c:: with SMTP id r28mr23242855wrr.287.1633941281066;
        Mon, 11 Oct 2021 01:34:41 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64ba.dip0.t-ipconnect.de. [91.12.100.186])
        by smtp.gmail.com with ESMTPSA id h22sm7769224wmq.42.2021.10.11.01.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 01:34:40 -0700 (PDT)
To:     Faiyaz Mohammed <quic_faiyazm@codeaurora.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     guptap@codeaurora.org, Faiyaz Mohammed <faiyazm@codeaurora.org>
References: <1633936279-26856-1-git-send-email-quic_faiyazm@codeaurora.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2] mm: page_alloc: Add debug log in free_reserved_area
 for static memory
Message-ID: <7027fa91-296f-01cb-6c5d-d25c81c835d5@redhat.com>
Date:   Mon, 11 Oct 2021 10:34:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1633936279-26856-1-git-send-email-quic_faiyazm@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.21 09:11, Faiyaz Mohammed wrote:
> From: Faiyaz Mohammed <faiyazm@codeaurora.org>
> 
> For INITRD and initmem memory is reserved through "memblock_reserve"
> during boot up but it is free via "free_reserved_area" instead
> of "memblock_free".
> For example:
> [    0.294848] Freeing initrd memory: 12K.
> [    0.696688] Freeing unused kernel memory: 4096K.
> 
> To get the start and end address of the above freed memory and to account
> proper memblock added pr_debug log in "free_reserved_area".
> After adding log:
> [    0.294837] 0x00000083600000-0x00000083603000 free_initrd_mem+0x20/0x28
> [    0.294848] Freeing initrd memory: 12K.
> [    0.695246] 0x00000081600000-0x00000081a00000 free_initmem+0x70/0xc8
> [    0.696688] Freeing unused kernel memory: 4096K.
> 
> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
> ---
> changes in v2:
> 	- To avoid confusion, remove the memblock_dbg print and drop the
> 	memblock_free string, now using pr_debug to print the address ranges.
> 
>   mm/page_alloc.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 668edb1..395df3f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8153,6 +8153,11 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
>   	if (pages && s)
>   		pr_info("Freeing %s memory: %ldK\n", s, K(pages));
>   
> +#ifdef CONFIG_HAVE_MEMBLOCK
> +		pr_debug("%#016llx-%#016llx %pS\n",
> +			__pa(start), __pa(end), (void *)_RET_IP_);
> +#endif
> +

Are we missing parentheses that the code indentation implies?
Further, I think we want to use "%pa" instead of "%llx" and
eventually drop the CONFIG_HAVE_MEMBLOCK dependency. Maybe

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b37435c274cf..e7946e5ca094 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8097,6 +8097,8 @@ EXPORT_SYMBOL(adjust_managed_page_count);
  
  unsigned long free_reserved_area(void *start, void *end, int poison, const char *s)
  {
+       const phys_addr_t pstart = __pa(start);
+       const phys_addr_t pend = __pa(end);
         void *pos;
         unsigned long pages = 0;
  
@@ -8125,9 +8127,11 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
                 free_reserved_page(page);
         }
  
-       if (pages && s)
+       if (pages && s) {
                 pr_info("Freeing %s memory: %ldK\n",
                         s, pages << (PAGE_SHIFT - 10));
+               pr_debug("[%pa-%pa] %pS\n", &pstart, &pend, (void *)_RET_IP_);
+       }
  
         return pages;
  }



-- 
Thanks,

David / dhildenb

