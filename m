Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C633ECA2A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 18:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhHOQU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 12:20:26 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:37805 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhHOQU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 12:20:26 -0400
Received: by mail-qt1-f170.google.com with SMTP id l24so12458655qtj.4
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 09:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OaNQ6551YB6VfeSIvU4gCRECoZk+ivSmQBMFFOyoA7A=;
        b=oUW4QhdAG8a1aWwq2zRGwogh0XASQeBm83Ew8DrG+FxPgPVH+MzPeylQBFAqRbRlsR
         mjl7RS/nTmidLu2vvB7sOVs7xtgSGkweUXdVaWUd7k/3T/I9CVEfSPTosQotN+pQc0JB
         0bjjtn3JaB5LhMXdOfqw4pIRmUwWImgj8cAIgscORVXxzlu5HRQiVlsBgImgTNIA6+rX
         1FFfiOSaK8lSWslt2dLw4y5kA0R8cm6F6UZtBQmpyiOWYVCjShG1lEmmH+KXrG5DTg4d
         hMFV+ljBONcvg1trCaHIsv5UIrvDfZmkHXof1DCz6gHJinFAF1eO5k5oVMvJimdd37dq
         5wOg==
X-Gm-Message-State: AOAM530N7ntyjhZawZu1f1bJfnjtx4/Me0bg6tT4RFFaXWVdeirilZ82
        Pcxq3Tsk2Hmnc//nCYzaP5U=
X-Google-Smtp-Source: ABdhPJxGVvS5NbEYWUnJkaGcvEG0NzY9tNoDbx1wL5Hydy7J7RKfQWbIfbpM/YNCsOCPv4TjtmgCHQ==
X-Received: by 2002:ac8:7612:: with SMTP id t18mr7100667qtq.324.1629044395471;
        Sun, 15 Aug 2021 09:19:55 -0700 (PDT)
Received: from fedora (pool-173-68-57-129.nycmny.fios.verizon.net. [173.68.57.129])
        by smtp.gmail.com with ESMTPSA id j185sm4804942qkf.28.2021.08.15.09.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 09:19:55 -0700 (PDT)
Date:   Sun, 15 Aug 2021 12:19:53 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Junhua Huang <junhuahuangdream@163.com>
Cc:     dennis@kernel.org, tj@kernel.org, cl@linux.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Junhua Huang <huang.junhua@zte.com.cn>
Subject: Re: [PATCH] percpu: remove the unnecessary operation for bitmaps in
 finding suitable region
Message-ID: <YRk+qQ2Z7jqC8Pvl@fedora>
References: <20210815032018.192334-1-junhuahuangdream@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210815032018.192334-1-junhuahuangdream@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, Aug 14, 2021 at 08:20:18PM -0700, Junhua Huang wrote:
> From: Junhua Huang <huang.junhua@zte.com.cn>
> 
> We use pcpu_next_fit_region to find the next fit region for alloc. Once
> return, the region fit the request and then break the loop, or get the
> next start offset from pcpu_is_populated. So there is no necessary to
> add bits to bit_off. At the same time, bits will set 0 in 
> pcpu_next_fit_region each time, so I think it is unnecessary to 
> set bits zero in pcpu_for_each_fit_region loops.
> 

I think you're right in this instance, but I don't think this change is
correct as a whole.

> Signed-off-by: Junhua Huang <huang.junhua@zte.com.cn>
> ---
>  mm/percpu.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 7f2e0151c4e2..ec7a5d10f6c9 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -489,7 +489,6 @@ static void pcpu_next_fit_region(struct pcpu_chunk *chunk, int alloc_bits,
>  	for (pcpu_next_fit_region((chunk), (alloc_bits), (align), &(bit_off), \
>  				  &(bits));				      \
>  	     (bit_off) < pcpu_chunk_map_bits((chunk));			      \
> -	     (bit_off) += (bits),					      \

Removing this makes the iterator by itself wrong. While correct in the
current usage, it could potentially be wrong for the next.

>  	     pcpu_next_fit_region((chunk), (alloc_bits), (align), &(bit_off), \
>  				  &(bits)))
>  
> @@ -1126,7 +1125,6 @@ static int pcpu_find_block_fit(struct pcpu_chunk *chunk, int alloc_bits,
>  			break;
>  
>  		bit_off = next_off;
> -		bits = 0;
>  	}
>  
>  	if (bit_off == pcpu_chunk_map_bits(chunk))
> -- 
> 2.25.1
> 
> 

Thanks,
Dennis
