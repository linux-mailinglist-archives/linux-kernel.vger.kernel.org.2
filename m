Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C5730DDC7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbhBCPNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbhBCPLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:11:42 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF0AC06178B
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 07:11:02 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id f16so5871666wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 07:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=euglhQuz1fv7wELuChhUgZYArcEjvEFCsjQV+iKDCRk=;
        b=J8iayzDTtyfBDDGJUiswl39FT/YSRimMN3Ojh7YVQ3kXYwrQ6wcHBHyN1XlXjPNtMs
         vLvbNNlwtONnxgluudgL06DJuouLictOkIE4sWcKWK3rDcsxKhTRKD3z1x6PQ3G5TKrV
         p7Flnyof7dy9PBHUsEMCHPe7nZRS3KmOP6CD6O/+n375Psxd/ENY9onYJUK6eUCe/IC9
         nyrUl0jPV8GJsRhylw/mt8i3QYKjGl137tJSB5/5/KSMd+uiLeNgR3QRAkE9jhuLWRaI
         daUT/gSgJAerAuHcJZFzPLWac6ti1wRFmELN+90Gvyph2KRXUtAeYGH2BtQgQpcVWDms
         Gx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=euglhQuz1fv7wELuChhUgZYArcEjvEFCsjQV+iKDCRk=;
        b=B3SaYGLm7/HAHCwI/iMQXHK9b+8DRp0dfXhWlzA2bfEl7t2BXbCqWOsEf2V31Et9y3
         fz0LPeKDTDCoQ1lICPA6vtIaU0tXpmM1V+mbTWaXbzf5LPUVoCBcKR3TIdiWnP4rqs3W
         d357qyKO6nXJVHxGvCq1qae7cwibwZUTdKbiWtOaitqyYXt4RvxecKTDv/NnRcMyx3Lu
         m0ihvlotK4aPqYhivGnMPBi38Do3tPYHNRxi7Mm0wPpyBREuQXNKYxBhB0BGwgCDhJVJ
         v+mOgWTDSG4TZUX/GUQGvwQV+2FPRtd5+tGIqQfudop/WZYvJ8/U//PzaALeqa/hn2ys
         tigg==
X-Gm-Message-State: AOAM531faQMdlaS5lD69oJGhCf9RgKrUck52PMLlatREWFqNf/JDOZqz
        EUKX+i8ynGrjQeSl3xN9cVzP2w==
X-Google-Smtp-Source: ABdhPJwS2nnuxcVBRpnX7RVIStschZE5w8CiM89OOinne9AdFvGcmsEKiY5PVPt0ClY/N/HzKS+Quw==
X-Received: by 2002:a1c:107:: with SMTP id 7mr1939842wmb.28.1612365060776;
        Wed, 03 Feb 2021 07:11:00 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:b1de:c7d:30ce:1840])
        by smtp.gmail.com with ESMTPSA id i6sm3730145wrs.71.2021.02.03.07.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:10:59 -0800 (PST)
Date:   Wed, 3 Feb 2021 16:10:53 +0100
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
Subject: Re: [PATCH 07/12] kasan, mm: remove krealloc side-effect
Message-ID: <YBq8/e0iUpUFMhvO@elver.google.com>
References: <cover.1612208222.git.andreyknvl@google.com>
 <884e37ddff31b671725f4d83106111c7dcf8fb9b.1612208222.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <884e37ddff31b671725f4d83106111c7dcf8fb9b.1612208222.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 08:43PM +0100, Andrey Konovalov wrote:
> Currently, if krealloc() is called on a freed object with KASAN enabled,
> it allocates and returns a new object, but doesn't copy any memory from
> the old one as ksize() returns 0. This makes a caller believe that
> krealloc() succeeded (KASAN report is printed though).
>
> This patch adds an accessibility check into __do_krealloc(). If the check
> fails, krealloc() returns NULL. This check duplicates the one in ksize();
> this is fixed in the following patch.

I think "side-effect" is ambiguous, because either way behaviour of
krealloc differs from a kernel with KASAN disabled. Something like
"kasan, mm: fail krealloc on already freed object" perhaps?

> This patch also adds a KASAN-KUnit test to check krealloc() behaviour
> when it's called on a freed object.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  lib/test_kasan.c | 20 ++++++++++++++++++++
>  mm/slab_common.c |  3 +++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 2bb52853f341..61bc894d9f7e 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -359,6 +359,25 @@ static void krealloc_pagealloc_less_oob(struct kunit *test)
>  					KMALLOC_MAX_CACHE_SIZE + 201);
>  }
>  
> +/*
> + * Check that krealloc() detects a use-after-free, returns NULL,
> + * and doesn't unpoison the freed object.
> + */
> +static void krealloc_uaf(struct kunit *test)
> +{
> +	char *ptr1, *ptr2;
> +	int size1 = 201;
> +	int size2 = 235;
> +
> +	ptr1 = kmalloc(size1, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
> +	kfree(ptr1);
> +
> +	KUNIT_EXPECT_KASAN_FAIL(test, ptr2 = krealloc(ptr1, size2, GFP_KERNEL));
> +	KUNIT_ASSERT_PTR_EQ(test, (void *)ptr2, NULL);
> +	KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)ptr1);
> +}
> +
>  static void kmalloc_oob_16(struct kunit *test)
>  {
>  	struct {
> @@ -1056,6 +1075,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
>  	KUNIT_CASE(krealloc_less_oob),
>  	KUNIT_CASE(krealloc_pagealloc_more_oob),
>  	KUNIT_CASE(krealloc_pagealloc_less_oob),
> +	KUNIT_CASE(krealloc_uaf),
>  	KUNIT_CASE(kmalloc_oob_16),
>  	KUNIT_CASE(kmalloc_uaf_16),
>  	KUNIT_CASE(kmalloc_oob_in_memset),
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 39d1a8ff9bb8..dad70239b54c 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1140,6 +1140,9 @@ static __always_inline void *__do_krealloc(const void *p, size_t new_size,
>  	void *ret;
>  	size_t ks;
>  
> +	if (likely(!ZERO_OR_NULL_PTR(p)) && !kasan_check_byte(p))
> +		return NULL;
> +
>  	ks = ksize(p);
>  
>  	if (ks >= new_size) {
> -- 
> 2.30.0.365.g02bc693789-goog
> 
