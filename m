Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DFC3130B6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 12:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbhBHLYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 06:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbhBHLHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:07:31 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA908C0617AA
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 03:06:49 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id i5so4135847wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 03:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YCKQyJ5X4pSKK2TbNsb8boRdw0GR7LFT4BRguWXjjyI=;
        b=NG8H9UUSvX43gPqT7atIFiGW1Hf53RneCc9N82ovlTQDtkdhQjLF8xI+K74EFIihsg
         0hgVdQ/g29wTbAtYid5lHzGLlbCzDYlJL6GyhxueutxhN+/5WNFvx5HCs0dTlhw71siV
         uuIDAMP0uwNGhGygPzSU9wnnEx69GfK/+J1RTqLjPrimI9+07hU43gHJsbYkOx1AQcZ2
         QurDBUSrVL80e3UI0evOOFZeGalicP4M7F8d5q8T6TohLso4uyBzQokgCwFoNhWqLHYB
         vt99Fiavcx0CnqAJBspQ8tdIsUQD+5UKuzyp8SXKkv/HRvDcmoJ28ZTuC0+3G+Cnu9g8
         FCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YCKQyJ5X4pSKK2TbNsb8boRdw0GR7LFT4BRguWXjjyI=;
        b=H6S2jVKerKVf/RQemBGs9SjKaCqnjGxBCF0BjiKgVdyGVFDq0pYD5unKlVHMdrwBJP
         3OgfAwC9KJwLiMywKRCDMQV05LLjKVELrH06KbKfWHyzn3ysZKhmfz8HWsCpe4Cigr0Z
         uohgXBvBpO4Al+aRIUgM+j6LTtxW1e3FAqL+SHvGiPoug6eVBdZHYd7wU0olRj8ZD9yB
         HnUX0SUwOtxzO1sO4yMnUoUFIcX7A3gLOGhFZFxGN9m1m8woOecp0mqJOZSw4SiUeYBE
         UjrG+klUrkw0IrXWLzF1yGALbsWx82H1ec9SbIEXUE1FkjUMy7u3J3maZCTv2PLgEUc6
         KmuA==
X-Gm-Message-State: AOAM530peNxT3GuxE95tOiasA/9sm3cZo131zLuNNG45KCVuQOB3yYxo
        52FAH3XPmR26bIc6kpW0G7MECw==
X-Google-Smtp-Source: ABdhPJycTndKfO4Hva6eoih56akIcC3ZddjnlFN+i/+r1mkgFIHQuNb7jnV4Lpigvq1x76HTJHnLOg==
X-Received: by 2002:a05:600c:4f4d:: with SMTP id m13mr14358030wmq.118.1612782408117;
        Mon, 08 Feb 2021 03:06:48 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:497f:76ef:2e62:d028])
        by smtp.gmail.com with ESMTPSA id g16sm19401367wmi.30.2021.02.08.03.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 03:06:47 -0800 (PST)
Date:   Mon, 8 Feb 2021 12:06:41 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 mm 13/13] kasan: clarify that only first bug is
 reported in HW_TAGS
Message-ID: <YCEbQdE8FfUUFvuo@elver.google.com>
References: <cover.1612546384.git.andreyknvl@google.com>
 <00383ba88a47c3f8342d12263c24bdf95527b07d.1612546384.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00383ba88a47c3f8342d12263c24bdf95527b07d.1612546384.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 06:34PM +0100, Andrey Konovalov wrote:
> Hwardware tag-based KASAN only reports the first found bug. After that MTE
> tag checking gets disabled. Clarify this in comments and documentation.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  Documentation/dev-tools/kasan.rst | 8 ++++++--
>  mm/kasan/hw_tags.c                | 2 +-
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index e022b7506e37..1faabbe23e09 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -155,7 +155,7 @@ Boot parameters
>  ~~~~~~~~~~~~~~~
>  
>  Hardware tag-based KASAN mode (see the section about various modes below) is
> -intended for use in production as a security mitigation. Therefore it supports
> +intended for use in production as a security mitigation. Therefore, it supports
>  boot parameters that allow to disable KASAN competely or otherwise control
>  particular KASAN features.
>  
> @@ -166,7 +166,8 @@ particular KASAN features.
>    ``off``).
>  
>  - ``kasan.fault=report`` or ``=panic`` controls whether to only print a KASAN
> -  report or also panic the kernel (default: ``report``).
> +  report or also panic the kernel (default: ``report``). Note, that tag
> +  checking gets disabled after the first reported bug.
>  
>  For developers
>  ~~~~~~~~~~~~~~
> @@ -296,6 +297,9 @@ Note, that enabling CONFIG_KASAN_HW_TAGS always results in in-kernel TBI being
>  enabled. Even when kasan.mode=off is provided, or when the hardware doesn't
>  support MTE (but supports TBI).
>  
> +Hardware tag-based KASAN only reports the first found bug. After that MTE tag
> +checking gets disabled.
> +
>  What memory accesses are sanitised by KASAN?
>  --------------------------------------------
>  
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index e529428e7a11..6c9285c906b8 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -48,7 +48,7 @@ EXPORT_SYMBOL(kasan_flag_enabled);
>  /* Whether to collect alloc/free stack traces. */
>  DEFINE_STATIC_KEY_FALSE(kasan_flag_stacktrace);
>  
> -/* Whether panic or disable tag checking on fault. */
> +/* Whether to panic or print a report and disable tag checking on fault. */
>  bool kasan_flag_panic __ro_after_init;
>  
>  /* kasan=off/on */
> -- 
> 2.30.0.365.g02bc693789-goog
> 
