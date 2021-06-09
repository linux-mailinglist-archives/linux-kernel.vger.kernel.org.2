Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837D73A11A5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbhFIKy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:54:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34737 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238461AbhFIKyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623235935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VZPPxlVuFpma5nN0KBwsgNEj1D60a3U+wCT7M5MPOro=;
        b=Km5r1M+sxIq4QxvZF6wtjHOv+NX0GD/tnBHzME3FShlP42FQZPxI28LSs2skwcRMKR6KJh
        0XJz2rmTh/jJT0lX2DtPOYM/XEAPwKAOmVwutgOGYzNlj3DmYYtDvRxwcjs6H58IXcjOxC
        UvVr5TV7PvMy2NUxlLSDVJZr9BvC36k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-fUuC5ajmPkes6N6xmHySGA-1; Wed, 09 Jun 2021 06:52:14 -0400
X-MC-Unique: fUuC5ajmPkes6N6xmHySGA-1
Received: by mail-wm1-f70.google.com with SMTP id l32-20020a05600c1d20b02901a82ed9095dso803180wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 03:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VZPPxlVuFpma5nN0KBwsgNEj1D60a3U+wCT7M5MPOro=;
        b=Y1Y6EiGZhg6DuRctpIN8GsQ9s07mVdtzufXWiVlm/vQVK4rA1q5z269TwCOrXILEGx
         d2v9oKAVplxzniA/sO8T6Q0UR7HhxZ28nvmEJBiqxRQBzwCfTe1pBv/ysaqwpi/fZ5Ii
         7YPxDzUN0od4XpF0uAG+DyllT7eRp3z0wsAincYUxWNJ6WYak2ZwkZy4HM5dy0LHNpng
         5lr9szOy66stsJpDIOAhXuj6Z9nw25UdMKKzZK0AZ+MPJYF5rvtdFUvS9YFI0xarxYdr
         xfnRm37+BTJhtJJN0Amk/PoOL2Ul0g1AYRg6+0cBJNOs95Sb/359ncLC4chdCiDMkEEQ
         aMBQ==
X-Gm-Message-State: AOAM530EIBbc4rjWEWlvYFoCEYGvIBTDQIys/tU6Bd7sI6GZMUEzGo41
        zbKx1BfF2T2Ekjkar3jq5ULCSTNGsMPcdhaSGt1xc22htvacbdS2qMWgtIeB4Ha34yrk4zrCcqN
        gGZFGw/KJvOlMI5Ar+6WJExT2
X-Received: by 2002:a05:600c:c9:: with SMTP id u9mr26528274wmm.156.1623235933557;
        Wed, 09 Jun 2021 03:52:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOhpm0kR/qb02GnRlZAdwrQqqdavzoWPuk2BGBrMztminfq9lmdrK+j2M/FH+Xh9QtwaeMHg==
X-Received: by 2002:a05:600c:c9:: with SMTP id u9mr26528228wmm.156.1623235933268;
        Wed, 09 Jun 2021 03:52:13 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c611d.dip0.t-ipconnect.de. [91.12.97.29])
        by smtp.gmail.com with ESMTPSA id 89sm25391165wrq.14.2021.06.09.03.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 03:52:13 -0700 (PDT)
Subject: Re: [PATCH 2/9] arc: update comment about HIGHMEM implementation
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        Vineet Gupta <vgupta@synopsys.com>, kexec@lists.infradead.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
References: <20210602105348.13387-1-rppt@kernel.org>
 <20210602105348.13387-3-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <2764dca8-f395-f76a-0939-215eccdfd82e@redhat.com>
Date:   Wed, 9 Jun 2021 12:52:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210602105348.13387-3-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.06.21 12:53, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Arc does not use DISCONTIGMEM to implement high memory, update the comment
> describing how high memory works to reflect this.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>   arch/arc/mm/init.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
> index e2ed355438c9..397a201adfe3 100644
> --- a/arch/arc/mm/init.c
> +++ b/arch/arc/mm/init.c
> @@ -139,16 +139,13 @@ void __init setup_arch_memory(void)
>   
>   #ifdef CONFIG_HIGHMEM
>   	/*
> -	 * Populate a new node with highmem
> -	 *
>   	 * On ARC (w/o PAE) HIGHMEM addresses are actually smaller (0 based)
> -	 * than addresses in normal ala low memory (0x8000_0000 based).
> +	 * than addresses in normal aka low memory (0x8000_0000 based).
>   	 * Even with PAE, the huge peripheral space hole would waste a lot of
> -	 * mem with single mem_map[]. This warrants a mem_map per region design.
> -	 * Thus HIGHMEM on ARC is imlemented with DISCONTIGMEM.
> -	 *
> -	 * DISCONTIGMEM in turns requires multiple nodes. node 0 above is
> -	 * populated with normal memory zone while node 1 only has highmem
> +	 * mem with single contiguous mem_map[].
> +	 * Thus when HIGHMEM on ARC is enabled the memory map corresponding
> +	 * to the hole is freed and ARC specific version of pfn_valid()
> +	 * handles the hole in the memory map.
>   	 */
>   #ifdef CONFIG_DISCONTIGMEM
>   	node_set_online(1);
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

