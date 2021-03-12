Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1D53390DE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhCLPLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbhCLPKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:10:45 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1A0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:10:44 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so15392466wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2dVcHDhdrF5JaCCByrKqwImhRd8nHqVH/GMv12NMUYc=;
        b=uEkUsdXAu+3Wx+LRPimdLz9bK3tbRru648YN/jwPSMVdxB8GoaEms5SDU8Wz9SkEBV
         4weqGxsSfCwlq4PeJGDCPfbPApyLGJZl8PxjauX1j6nJBL/YkfTjwBJmI1ueTUM+StO/
         cN9q0mC4icX821DCux7c+cqYJtrqbli92JoH+6HkfMZpA0Wsb+CboYn57kirYgtqAQsn
         huQWVtqllgVNdpj/MKW3UhRJyzbgzWKJ78S9v3K8GjPdKxH80fjBDo+1IXNUvS6rcn7t
         W4jT263n6qgBPyqgIOpDNDHB7wPx6YuoPPwzRyuZpBm94maI3HoKgfHh2iBBvfvc0fEK
         3aTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2dVcHDhdrF5JaCCByrKqwImhRd8nHqVH/GMv12NMUYc=;
        b=AUyI9WL/Hm4GuNvWIbYCVPF/213anpwvanU8p7TRRCX8m/n8uH8XGU0xBtSGG2hXtU
         1ywN1uy86CTFcqc1qE50H/4nqsd++I9woq7Zu8lRtJWU5f3BjM9llKw7sv1JRJYnEVTY
         PE2RJ3lBC8iXzxhzM5PUQfzi38vR0sWI5Y/Oy0LHTIBGgCBWadqQHveipLdYqKBh/Sog
         sm+7/kGgUF/4Fd+tHX9eVoO/77mXjgCer+BkXjXEnDjrEM3uBVovcQtsU7nphjZfBdKM
         p3HMq54VjsiNkdmWV/FtVC4z4ylpvvVmgOD+EtM1LJ6BCHFcB9/GJYDjyrdOyHTiUaUg
         dcGQ==
X-Gm-Message-State: AOAM530VpMglWxaifkZzfonxZbfbtt/fqz/YcKilQjUHVD2XVjNzKoSt
        coTfQugQY5AgdtLIDCHP1mVW6Q==
X-Google-Smtp-Source: ABdhPJzz6EK+f9gBf+L2EFDROJ+8DMjsJCOvqJgP6GqIlly74JOmBbw2twO6HDCMDb8AGCH54xqM3g==
X-Received: by 2002:a7b:c303:: with SMTP id k3mr13820769wmj.100.1615561843302;
        Fri, 12 Mar 2021 07:10:43 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:d5de:d45f:f79c:cb62])
        by smtp.gmail.com with ESMTPSA id c131sm2481968wma.37.2021.03.12.07.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 07:10:42 -0800 (PST)
Date:   Fri, 12 Mar 2021 16:10:37 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/11] kasan: docs: update ignoring accesses section
Message-ID: <YEuEbRvzdf9x1yNI@elver.google.com>
References: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
 <4531ba5f3eca61f6aade863c136778cc8c807a64.1615559068.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4531ba5f3eca61f6aade863c136778cc8c807a64.1615559068.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 03:24PM +0100, Andrey Konovalov wrote:
> Update the "Ignoring accesses" section in KASAN documentation:
> 
> - Mention __no_sanitize_address/noinstr.
> - Mention kasan_disable/enable_current().
> - Mention kasan_reset_tag()/page_kasan_tag_reset().
> - Readability and punctuation clean-ups.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> 
> Changes in v1->v2:
> - Mention __no_sanitize_address/noinstr.
> - Reword the whole section to make it clear which method works for which
>   mode.
> ---
>  Documentation/dev-tools/kasan.rst | 34 +++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index d0c1796122df..5749c14b38d0 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -368,12 +368,18 @@ Ignoring accesses
>  ~~~~~~~~~~~~~~~~~
>  
>  Software KASAN modes use compiler instrumentation to insert validity checks.
> -Such instrumentation might be incompatible with some part of the kernel, and
> -therefore needs to be disabled. To disable instrumentation for specific files
> -or directories, add a line similar to the following to the respective kernel
> +Such instrumentation might be incompatible with some parts of the kernel, and
> +therefore needs to be disabled.
> +
> +Other parts of the kernel might access metadata for allocated objects.
> +Normally, KASAN detects and reports such accesses, but in some cases (e.g.,
> +in memory allocators), these accesses are valid.
> +
> +For software KASAN modes, to disable instrumentation for a specific file or
> +directory, add a ``KASAN_SANITIZE`` annotation to the respective kernel
>  Makefile:
>  
> -- For a single file (e.g. main.o)::
> +- For a single file (e.g., main.o)::
>  
>      KASAN_SANITIZE_main.o := n
>  
> @@ -381,6 +387,26 @@ Makefile:
>  
>      KASAN_SANITIZE := n
>  
> +For software KASAN modes, to disable instrumentation on a per-function basis,
> +use the KASAN-specific ``__no_sanitize_address`` function attribute or the
> +generic ``noinstr`` one.
> +
> +Note that disabling compiler instrumentation (either on a per-file or a
> +per-function basis) makes KASAN ignore the accesses that happen directly in
> +that code for software KASAN modes. It does not help when the accesses happen
> +indirectly (through calls to instrumented functions) or with the hardware
> +tag-based mode that does not use compiler instrumentation.
> +
> +For software KASAN modes, to disable KASAN reports in a part of the kernel code
> +for the current task, annotate this part of the code with a
> +``kasan_disable_current()``/``kasan_enable_current()`` section. This also
> +disables the reports for indirect accesses that happen through function calls.
> +
> +For tag-based KASAN modes (include the hardware one), to disable access
> +checking, use ``kasan_reset_tag()`` or ``page_kasan_tag_reset()``. Note that
> +temporarily disabling access checking via ``page_kasan_tag_reset()`` requires
> +saving and restoring the per-page KASAN tag via
> +``page_kasan_tag``/``page_kasan_tag_set``.
>  
>  Tests
>  ~~~~~
> -- 
> 2.31.0.rc2.261.g7f71774620-goog
> 
