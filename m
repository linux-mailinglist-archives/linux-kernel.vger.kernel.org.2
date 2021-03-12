Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019F13390C8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhCLPHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbhCLPHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:07:33 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A64C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:07:33 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so15386020wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NxCzouo00jLfy5JFbVee5vzdNlkY0nXEKiHSuDiLt14=;
        b=OK9FMmpHJViO21TkMjEO0tHh1gvZmPxHyxNM6n5EZKAskK55zEy+TGVcPm2Ki4TupI
         /zVvm0g5OM4ZAzzr283CcoTOEGE5XSc4FEERoD2/YNHFquaUujiJcyXWfuZyd3AiE7is
         X91u2jLsKj0pIuNCX9PbK4fiIL701w+tzEKFCTa4EKZWuHxAnwPPsw7g3zOkRgCCEF/D
         2U48LxKDfIaf7STy+hfy/fe1IBchljs3Fk8vK320YjInqidBU622pW4UZzdMv9gt2pgJ
         Th0eyvCku/uP+hxx3ecKpAbR3kLDQw7yoKOlsQR8EsZNCtnZ8l0r34NYVYKgv9wcA37p
         vu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NxCzouo00jLfy5JFbVee5vzdNlkY0nXEKiHSuDiLt14=;
        b=O6E1kXGXSG1oFRHayoPIB7yd2dwZrHreRwGaXMlZpUxCt8nKlUTkBQ+bmsKuszI6sh
         PmzruoEJ/W6Hp0OYgEiPQ7C8BncjdiKPHAhGJOxh4LVVihYmT6IIRY6bRtdYIdm8gPkw
         4fi0CGKEOM+/70E8vQDRZCYpq43PiqjZqDsuXOBp/xFXBIkkvaHrvsOTIdd/arvwceNa
         5me7oByno5wNjxbm+Gdy3ZQOS04hlI0D4uTPSw1ANijJY1+BPgcTWcwA+XS6r5EePiw7
         J+qFa87e6ZTsOOmi/Q8gqDBkvBEgejZ4GJDkZfnmMv+kir6y/ZhqxzyGsgGFEF+VYln3
         3Fdw==
X-Gm-Message-State: AOAM530RHCEmM2fAQkcnakp7nMjYXtu5cjj+Kg9BoUxhQMEyeRrTVo1q
        fNG0QwS+3Wzgq2kmSrfEloZFOQ==
X-Google-Smtp-Source: ABdhPJwnv1fjgqt6bQERsyk0doi/6CJMOjcR7KExV1Ht4QxZNUfCHWk5FcFIMJQ8s5t8eJ5SzM7Uew==
X-Received: by 2002:a1c:6605:: with SMTP id a5mr13891700wmc.85.1615561651710;
        Fri, 12 Mar 2021 07:07:31 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:d5de:d45f:f79c:cb62])
        by smtp.gmail.com with ESMTPSA id b131sm2441214wmb.34.2021.03.12.07.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 07:07:31 -0800 (PST)
Date:   Fri, 12 Mar 2021 16:07:25 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/11] kasan: docs: update overview section
Message-ID: <YEuDrdCkIjYywuyj@elver.google.com>
References: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
 <1486fba8514de3d7db2f47df2192db59228b0a7b.1615559068.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1486fba8514de3d7db2f47df2192db59228b0a7b.1615559068.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 03:24PM +0100, Andrey Konovalov wrote:
> Update the "Overview" section in KASAN documentation:
> 
> - Outline main use cases for each mode.
> - Mention that HW_TAGS mode need compiler support too.
> - Move the part about SLUB/SLAB support from "Usage" to "Overview".
> - Punctuation, readability, and other minor clean-ups.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> 
> Changes v1->v2:
> - Mention GCC support for HW_TAGS.
> ---
>  Documentation/dev-tools/kasan.rst | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index b3b2c517db55..2f2697b290d5 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -11,17 +11,31 @@ designed to find out-of-bound and use-after-free bugs. KASAN has three modes:
>  2. software tag-based KASAN (similar to userspace HWASan),
>  3. hardware tag-based KASAN (based on hardware memory tagging).
>  
> -Software KASAN modes (1 and 2) use compile-time instrumentation to insert
> -validity checks before every memory access, and therefore require a compiler
> +Generic KASAN is mainly used for debugging due to a large memory overhead.
> +Software tag-based KASAN can be used for dogfood testing as it has a lower
> +memory overhead that allows using it with real workloads. Hardware tag-based
> +KASAN comes with low memory and performance overheads and, therefore, can be
> +used in production. Either as an in-field memory bug detector or as a security
> +mitigation.
> +
> +Software KASAN modes (#1 and #2) use compile-time instrumentation to insert
> +validity checks before every memory access and, therefore, require a compiler
>  version that supports that.
>  
> -Generic KASAN is supported in both GCC and Clang. With GCC it requires version
> +Generic KASAN is supported in GCC and Clang. With GCC, it requires version
>  8.3.0 or later. Any supported Clang version is compatible, but detection of
>  out-of-bounds accesses for global variables is only supported since Clang 11.
>  
> -Tag-based KASAN is only supported in Clang.
> +Software tag-based KASAN mode is only supported in Clang.
>  
> -Currently generic KASAN is supported for the x86_64, arm, arm64, xtensa, s390
> +The hardware KASAN mode (#3) relies on hardware to perform the checks but
> +still requires a compiler version that supports memory tagging instructions.
> +This mode is supported in GCC 10+ and Clang 11+.
> +
> +Both software KASAN modes work with SLUB and SLAB memory allocators,
> +while the hardware tag-based KASAN currently only supports SLUB.
> +
> +Currently, generic KASAN is supported for the x86_64, arm, arm64, xtensa, s390,
>  and riscv architectures, and tag-based KASAN modes are supported only for arm64.
>  
>  Usage
> @@ -39,9 +53,6 @@ For software modes, you also need to choose between CONFIG_KASAN_OUTLINE and
>  CONFIG_KASAN_INLINE. Outline and inline are compiler instrumentation types.
>  The former produces smaller binary while the latter is 1.1 - 2 times faster.
>  
> -Both software KASAN modes work with both SLUB and SLAB memory allocators,
> -while the hardware tag-based KASAN currently only support SLUB.
> -
>  For better error reports that include stack traces, enable CONFIG_STACKTRACE.
>  
>  To augment reports with last allocation and freeing stack of the physical page,
> -- 
> 2.31.0.rc2.261.g7f71774620-goog
> 
