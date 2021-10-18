Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2134327EB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 21:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhJRTtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 15:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhJRTtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 15:49:18 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3835AC061745
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 12:47:07 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id np13so12936125pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 12:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N/UkEqZsUw28dgpf+wkDefjIGznCOnGAPbrDklw8cgA=;
        b=fuCYcYo2n82pYTF+DVXCIH4nE3CtGx+HswPWG0KsiHpVTzjKFTYzPkcT6QfijE2gwa
         Zu2go9G/Y0e8y4ZWf3NCWh7HMPgTbhR1PLein6lGvTB8q6+4m/QAV03lMSaFAacS8EjW
         0JQUa1nv0yvXLNKSt/M2Hylr/p2ymVxA7ZWCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N/UkEqZsUw28dgpf+wkDefjIGznCOnGAPbrDklw8cgA=;
        b=ht155z5PvGU7NamI4Q83tlsPIkFefBJbRoKI50QzOUnS/cAgUIJHMao6bhq1G4g8mH
         GuZaO4CliGo6Rg7w2Vi2npN8MOkM6f2h8AL0u93gf2i2sc6EBW/raHA84jk2l+W0wEvD
         q99nKHIvW8wLQzidGsjp05DX4CwTeVArJFTyijJeB82l+s0uI/yg1Bk228FBlSuBqi1c
         LpetpQZcRk55O4B+BqY4YlzMBU1E8wz9gukYODTFfdIKhGnU6NogtlXsANkb5V38grn6
         sDfunq1Da6SmPYt/F+joTrkqFVwV+b/5rWOA4MQL1oBq1reovzi0OL5yb5Njf/Fe6JzU
         Yy/w==
X-Gm-Message-State: AOAM531bnGj2uAeWqEioTEj+ixSaxOlniSp2uL0MC50pnGqvCDdL7yJQ
        JpziQp9b64RcU8L+U/n0FPVT7w==
X-Google-Smtp-Source: ABdhPJzX8CQAwD/mJwgjVQdV6Mg7IJJYAARp4Rvgh95u1dpIgNI9xmthkbybS6i4kyeu0jA9JgRTGQ==
X-Received: by 2002:a17:903:2287:b0:13e:5d9f:1ebf with SMTP id b7-20020a170903228700b0013e5d9f1ebfmr28807432plh.75.1634586426677;
        Mon, 18 Oct 2021 12:47:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s8sm13500519pfh.186.2021.10.18.12.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 12:47:06 -0700 (PDT)
Date:   Mon, 18 Oct 2021 12:47:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-hardening@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kasan: test: use underlying string helpers
Message-ID: <202110181245.499CB7594B@keescook>
References: <20211013150025.2875883-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013150025.2875883-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 05:00:05PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Calling memcmp() and memchr() with an intentional buffer overflow
> is now caught at compile time:
> 
> In function 'memcmp',
>     inlined from 'kasan_memcmp' at lib/test_kasan.c:897:2:
> include/linux/fortify-string.h:263:25: error: call to '__read_overflow' declared with attribute error: detected read beyond size of object (1st parameter)
>   263 |                         __read_overflow();
>       |                         ^~~~~~~~~~~~~~~~~
> In function 'memchr',
>     inlined from 'kasan_memchr' at lib/test_kasan.c:872:2:
> include/linux/fortify-string.h:277:17: error: call to '__read_overflow' declared with attribute error: detected read beyond size of object (1st parameter)
>   277 |                 __read_overflow();
>       |                 ^~~~~~~~~~~~~~~~~
> 
> Change the kasan tests to wrap those inside of a noinline function
> to prevent the compiler from noticing the bug and let kasan find
> it at runtime.

Is this with W=1 ? I had explicitly disabled the read overflows for
"phase 1" of the overflow restriction tightening...

(And what do you think of using OPTIMIZER_HIDE_VAR() instead[1]?

-Kees

[1] https://lore.kernel.org/linux-hardening/20211006181544.1670992-1-keescook@chromium.org/T/#u

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  lib/test_kasan.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 67ed689a0b1b..903215e944f1 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -852,6 +852,21 @@ static void kmem_cache_invalid_free(struct kunit *test)
>  	kmem_cache_destroy(cache);
>  }
>  
> +/*
> + * noinline wrappers to prevent the compiler from noticing the overflow
> + * at compile time rather than having kasan catch it.
> + * */
> +static noinline void *__kasan_memchr(const void *s, int c, size_t n)
> +{
> +	return memchr(s, c, n);
> +}
> +
> +static noinline int __kasan_memcmp(const void *s1, const void *s2, size_t n)
> +{
> +	return memcmp(s1, s2, n);
> +}
> +
> +
>  static void kasan_memchr(struct kunit *test)
>  {
>  	char *ptr;
> @@ -870,7 +885,7 @@ static void kasan_memchr(struct kunit *test)
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>  
>  	KUNIT_EXPECT_KASAN_FAIL(test,
> -		kasan_ptr_result = memchr(ptr, '1', size + 1));
> +		kasan_ptr_result = __kasan_memchr(ptr, '1', size + 1));
>  
>  	kfree(ptr);
>  }
> @@ -895,7 +910,7 @@ static void kasan_memcmp(struct kunit *test)
>  	memset(arr, 0, sizeof(arr));
>  
>  	KUNIT_EXPECT_KASAN_FAIL(test,
> -		kasan_int_result = memcmp(ptr, arr, size+1));
> +		kasan_int_result = __kasan_memcmp(ptr, arr, size+1));
>  	kfree(ptr);
>  }
>  
> -- 
> 2.29.2
> 

-- 
Kees Cook
