Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F2030DD33
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbhBCOtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbhBCOtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:49:15 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53A8C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 06:48:34 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id m13so24658981wro.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 06:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9VGn7w2tNlFuEz50GpubxUEDNHCrhMt0WO2PGFie8Ao=;
        b=fQIVmx988C8vZV4BdPkzNRAlBu0QDAg8OIpAAYxaSbbZN2O6KeG8QEdXDlWxCxdCXY
         KrpYcmPW5iYelSzb7hKCSLv+9bLhCTwHeB5Ao6mnqbgnTSmj1ZwvFvCRdBUplg6vvpG1
         bVNS98Uhs0Jayhzd6YCFHM64y6tyB8gQxqseQ5jNwmxEFtRJMvki764PRI5MbWZZCYVc
         RcxxeaFl0wgns9OOgtgvBJCu5TzmgL2h/H+AJAvytxKnYpNOs4GMCtzLMu2xzJxyhzVX
         MgV4YfXK5PWzSBKBEJGac0HNHDyzQjB/483/0mV95pzU+ZA/t5fnb6nQgFH9WpiuyHOi
         cZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9VGn7w2tNlFuEz50GpubxUEDNHCrhMt0WO2PGFie8Ao=;
        b=LkdDwi3VGbzb+JSPzumdDF+z5iQ4bk8tsnKPMBucVtkZQ/e1RJiYeoNmto5xIgs0lk
         x2gFJ4/uOcm/aMWA4hZVNr5ZNM9JRxKsoxX8wRjEdsbYQIyhKAWS63qweN0mxRKZNWlb
         rBigzikXUQ+zBVZIev2qlbArfxJc6cbP1x9/wx6+ryYUVz+7reJQ6MJoTLzLNV0/1HS1
         hYyh4sbydE5d51/6/q8ki5DDvLGamoFTlQhF0D491hbBsqlLeEoDlERczyvq9N6m9C0W
         qmejeJGvppJKAnKMvdwnKzpsQpwDj3H22BVtTbPTStSxAo/R98AJGMH5EPoVLy1zm4Nx
         gQ8A==
X-Gm-Message-State: AOAM532x4npt1r+9BwazX67c80VeZ3puvkVsVuD8j2R92InshPY9tvKG
        e58Hsmibjf+2BQD6S0P9K8fIqw==
X-Google-Smtp-Source: ABdhPJyUml8gBjD3JNc7G2wMLNsuJxRp8NFSdxFPy/XjyDzTEC8IZoyZ8vUF/vupgLJpqNGQsCsy1g==
X-Received: by 2002:adf:c109:: with SMTP id r9mr3973330wre.261.1612363713245;
        Wed, 03 Feb 2021 06:48:33 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:b1de:c7d:30ce:1840])
        by smtp.gmail.com with ESMTPSA id 17sm2919952wmk.48.2021.02.03.06.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 06:48:32 -0800 (PST)
Date:   Wed, 3 Feb 2021 15:48:25 +0100
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
Subject: Re: [PATCH 06/12] kasan: rework krealloc tests
Message-ID: <YBq3uZOKeRnW3eBl@elver.google.com>
References: <cover.1612208222.git.andreyknvl@google.com>
 <995edb531f4f976277d7da9ca8a78a96a2ea356e.1612208222.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <995edb531f4f976277d7da9ca8a78a96a2ea356e.1612208222.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 08:43PM +0100, Andrey Konovalov wrote:
> This patch reworks KASAN-KUnit tests for krealloc() to:
> 
> 1. Check both slab and page_alloc based krealloc() implementations.
> 2. Allow at least one full granule to fit between old and new sizes for
>    each KASAN mode, and check accesses to that granule accordingly.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  lib/test_kasan.c | 91 ++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 81 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 5699e43ca01b..2bb52853f341 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -258,11 +258,14 @@ static void kmalloc_large_oob_right(struct kunit *test)
>  	kfree(ptr);
>  }
>  
> -static void kmalloc_oob_krealloc_more(struct kunit *test)
> +static void krealloc_more_oob_helper(struct kunit *test,
> +					size_t size1, size_t size2)
>  {
>  	char *ptr1, *ptr2;
> -	size_t size1 = 17;
> -	size_t size2 = 19;
> +	size_t middle;
> +
> +	KUNIT_ASSERT_LT(test, size1, size2);
> +	middle = size1 + (size2 - size1) / 2;
>  
>  	ptr1 = kmalloc(size1, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
> @@ -270,15 +273,31 @@ static void kmalloc_oob_krealloc_more(struct kunit *test)
>  	ptr2 = krealloc(ptr1, size2, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
>  
> -	KUNIT_EXPECT_KASAN_FAIL(test, ptr2[size2 + OOB_TAG_OFF] = 'x');
> +	/* All offsets up to size2 must be accessible. */
> +	ptr2[size1 - 1] = 'x';
> +	ptr2[size1] = 'x';
> +	ptr2[middle] = 'x';
> +	ptr2[size2 - 1] = 'x';
> +
> +	/* Generic mode is precise, so unaligned size2 must be inaccessible. */
> +	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> +		KUNIT_EXPECT_KASAN_FAIL(test, ptr2[size2] = 'x');
> +
> +	/* For all modes first aligned offset after size2 must be inaccessible. */
> +	KUNIT_EXPECT_KASAN_FAIL(test,
> +		ptr2[round_up(size2, KASAN_GRANULE_SIZE)] = 'x');
> +
>  	kfree(ptr2);
>  }
>  
> -static void kmalloc_oob_krealloc_less(struct kunit *test)
> +static void krealloc_less_oob_helper(struct kunit *test,
> +					size_t size1, size_t size2)
>  {
>  	char *ptr1, *ptr2;
> -	size_t size1 = 17;
> -	size_t size2 = 15;
> +	size_t middle;
> +
> +	KUNIT_ASSERT_LT(test, size2, size1);
> +	middle = size2 + (size1 - size2) / 2;
>  
>  	ptr1 = kmalloc(size1, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
> @@ -286,10 +305,60 @@ static void kmalloc_oob_krealloc_less(struct kunit *test)
>  	ptr2 = krealloc(ptr1, size2, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
>  
> -	KUNIT_EXPECT_KASAN_FAIL(test, ptr2[size2 + OOB_TAG_OFF] = 'x');
> +	/* Must be accessible for all modes. */
> +	ptr2[size2 - 1] = 'x';
> +
> +	/* Generic mode is precise, so unaligned size2 must be inaccessible. */
> +	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> +		KUNIT_EXPECT_KASAN_FAIL(test, ptr2[size2] = 'x');
> +
> +	/* For all modes first aligned offset after size2 must be inaccessible. */
> +	KUNIT_EXPECT_KASAN_FAIL(test,
> +		ptr2[round_up(size2, KASAN_GRANULE_SIZE)] = 'x');
> +
> +	/*
> +	 * For all modes both middle and size1 should land in separate granules

middle, size1, and size2?

> +	 * and thus be inaccessible.
> +	 */
> +	KUNIT_EXPECT_LE(test, round_up(size2, KASAN_GRANULE_SIZE),
> +				round_down(middle, KASAN_GRANULE_SIZE));
> +	KUNIT_EXPECT_LE(test, round_up(middle, KASAN_GRANULE_SIZE),
> +				round_down(size1, KASAN_GRANULE_SIZE));
> +	KUNIT_EXPECT_KASAN_FAIL(test, ptr2[middle] = 'x');
> +	KUNIT_EXPECT_KASAN_FAIL(test, ptr2[size1 - 1] = 'x');
> +	KUNIT_EXPECT_KASAN_FAIL(test, ptr2[size1] = 'x');
> +
>  	kfree(ptr2);
>  }
>  
> +static void krealloc_more_oob(struct kunit *test)
> +{
> +	krealloc_more_oob_helper(test, 201, 235);
> +}
> +
> +static void krealloc_less_oob(struct kunit *test)
> +{
> +	krealloc_less_oob_helper(test, 235, 201);
> +}
> +
> +static void krealloc_pagealloc_more_oob(struct kunit *test)
> +{
> +	/* page_alloc fallback in only implemented for SLUB. */
> +	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB);
> +
> +	krealloc_more_oob_helper(test, KMALLOC_MAX_CACHE_SIZE + 201,
> +					KMALLOC_MAX_CACHE_SIZE + 235);
> +}
> +
> +static void krealloc_pagealloc_less_oob(struct kunit *test)
> +{
> +	/* page_alloc fallback in only implemented for SLUB. */
> +	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB);
> +
> +	krealloc_less_oob_helper(test, KMALLOC_MAX_CACHE_SIZE + 235,
> +					KMALLOC_MAX_CACHE_SIZE + 201);
> +}
> +
>  static void kmalloc_oob_16(struct kunit *test)
>  {
>  	struct {
> @@ -983,8 +1052,10 @@ static struct kunit_case kasan_kunit_test_cases[] = {
>  	KUNIT_CASE(pagealloc_oob_right),
>  	KUNIT_CASE(pagealloc_uaf),
>  	KUNIT_CASE(kmalloc_large_oob_right),
> -	KUNIT_CASE(kmalloc_oob_krealloc_more),
> -	KUNIT_CASE(kmalloc_oob_krealloc_less),
> +	KUNIT_CASE(krealloc_more_oob),
> +	KUNIT_CASE(krealloc_less_oob),
> +	KUNIT_CASE(krealloc_pagealloc_more_oob),
> +	KUNIT_CASE(krealloc_pagealloc_less_oob),
>  	KUNIT_CASE(kmalloc_oob_16),
>  	KUNIT_CASE(kmalloc_uaf_16),
>  	KUNIT_CASE(kmalloc_oob_in_memset),
> -- 
> 2.30.0.365.g02bc693789-goog
> 
