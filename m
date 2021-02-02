Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E769430C701
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbhBBRHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237024AbhBBREe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:04:34 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D355FC061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 09:03:54 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id e15so2955927wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 09:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LlSpQiAeO5UD+cdMKYJ9CnM6vv6XdQSneSZu18Ir1hY=;
        b=TzVMfjf+ylnuHPTfEahpcfHvrwIKlOzm8kZ6UZxO8/PUZmMCmW8G3Z44hXndw8bnlq
         iIUZ760s/Zccd8nAfCYOIrPjTjWoYL0Ceqdqloz8lSNEmrBORIuJwNhBTaGSjddFDOcQ
         AnurNFHeaF6uVkEG+7173SHWXrgnoxhikvLZAPRZLggeZofIyBxtpGY8TJ+Pvhd1Z5d0
         qtiIyk8KvQ/T8PO0kaJNGgPKxykmMEN1jHJcJE02d/Dbk3BQovpvLFXEzpW1WaF4vTFM
         01cmHL8ufHxB1KMhOszwj2DzfFbsAYUsgg6T6kzX+A5/P3CWnlaLRKMe3W6ZhC3sQAJF
         8DtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LlSpQiAeO5UD+cdMKYJ9CnM6vv6XdQSneSZu18Ir1hY=;
        b=LtW9LL5U9rzJd6T0SEPFnyq8+an0EBZltrbOuEuDCjfPf81JGhI2QSNmjqqKSCzdIc
         0o99WAXYIFvqzYmO+H2VGGtQs8o6kfC3XKn2WXVCmDb9zlI3D2tRgduYjVgfAbvhMi5n
         k4SpLn4AZ5A5Ai8DCXuZl5oWvQP+w8CT7fxcsT7yfCVkx5AALAijzLH9WmBsPIa4dI2W
         9spCZu4V/NMhEiJ8salqg1ZHukZeNBiuKK/DguDoSDnZHYIcPcjqkvJra+gb8/db0UyM
         Zp9ie6DpcJZNkY2gDG1nu0gXYrD/Mf5F7pMv99X6Xa3MGKtHlVkGT+g+bo4KlNn44vDa
         tn0Q==
X-Gm-Message-State: AOAM530rkLS68HfIlc+B3Vn5Xdbson+4BqBFYVY6SXMBT0W707JvWJky
        AHgvpmhvuhADwmYja4BzP+0kxw==
X-Google-Smtp-Source: ABdhPJw7ncqblw1w7tWGFXv9BaZLz89rCTXcutCm2/LmNWfuj4bPNh3PMRTyPZbm2rD1CHhNptWiLA==
X-Received: by 2002:a05:600c:4fc2:: with SMTP id o2mr4462198wmq.90.1612285433466;
        Tue, 02 Feb 2021 09:03:53 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id q63sm4041403wma.43.2021.02.02.09.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 09:03:52 -0800 (PST)
Date:   Tue, 2 Feb 2021 18:03:46 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] kasan: clean up setting free info in
 kasan_slab_free
Message-ID: <YBmF8gCRRdRgJw0/@elver.google.com>
References: <cover.1612208222.git.andreyknvl@google.com>
 <e762958db74587308514341a18622ff350a75d8a.1612208222.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e762958db74587308514341a18622ff350a75d8a.1612208222.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 08:43PM +0100, Andrey Konovalov wrote:
> Put kasan_stack_collection_enabled() check and kasan_set_free_info()
> calls next to each other.
> 
> The way this was previously implemented was a minor optimization that
> relied of the the fact that kasan_stack_collection_enabled() is always
> true for generic KASAN. The confusion that this brings outweights saving
> a few instructions.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kasan/common.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index a7eb553c8e91..086bb77292b6 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -350,13 +350,11 @@ static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
>  
>  	kasan_poison(object, cache->object_size, KASAN_KMALLOC_FREE);
>  
> -	if (!kasan_stack_collection_enabled())
> -		return false;
> -
>  	if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine))
>  		return false;
>  
> -	kasan_set_free_info(cache, object, tag);
> +	if (kasan_stack_collection_enabled())
> +		kasan_set_free_info(cache, object, tag);
>  
>  	return kasan_quarantine_put(cache, object);
>  }
> -- 
> 2.30.0.365.g02bc693789-goog
> 
