Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1863390D3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhCLPJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhCLPJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:09:23 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0008DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:09:22 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id g8so4017633wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gtvZkycLjntznV5+6tLS7tFxXM/9IJvZKgaaSBlNSTQ=;
        b=R1RmWkGT1x3hbCJUbRvCXQ89MYHdUlI1InTiHA94uSD3kBkHraP9FJuQ5AOdPyYNjI
         CxpdxKcbYtXwFSWerFivcZMkUpprYKgsrOx4rtyLl2XG4hm8pZp1ZB4AJaZu7BXMYkrv
         IZkdoO2UOBQZ9q4Bd59/0/QGnknnVLD2C3KPkdQ/kxctcFUGo/Tl5pN53hBQ6U4Mhi6n
         T2OW+xMGVCI0a7Dt2rBmfxSR46OJj2xqbKVXy6eEWHau9t10ygndE2xB0n/NmJVxdUF2
         ldgER97oDBp2llh6cKLStXwDOtZ0iAgaSks7I8kVjt2BYdnrN93CYS2bKkJ3KBiSm3NO
         gpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gtvZkycLjntznV5+6tLS7tFxXM/9IJvZKgaaSBlNSTQ=;
        b=R05BjIuImyMX/M+WE/exI9lrLPbgKecXJFpojpbZxd5pi7FK1mmBnrBlz77HF0JFcJ
         aaJuDh9WM2ivE4xnzfkMyfeuRyIzc5uKM0LXTzNslwdRMj8gCTGQH++PwWh9+Wd/uexb
         yM/Qjs3kor25ZYQoeggvpMdGwoosaV+cT/S69BEmdGpJNm/hPzZSvGMhY0RYPVPhCQX2
         KLXniDi2TowmYCrhtPYWPpyExO77CgM8t8NhC8kLnl4RxpC7ZB92duyTT4hAILme9Ctx
         sT/VSXArIBV63Y6Fwr1Apjl6r4UHj8no1P8k9aOGTivCHdCQcA5y1iSAekMq3/mPYLNB
         ambA==
X-Gm-Message-State: AOAM530AtmSzf8Rrt5KdB0Aa7nrJ1UvpqaXUKXd8ohrnV0A+4Pm3HSRt
        VFaZWZEaObssz1nkpS93YFTknQ==
X-Google-Smtp-Source: ABdhPJwBfXueLJBMCj23l7EQ07XOv08i1is4PTUitFfFu5xK0O1WheNDM1Dolhaht3ud+Qzv7dg38Q==
X-Received: by 2002:a1c:4986:: with SMTP id w128mr13516548wma.37.1615561761555;
        Fri, 12 Mar 2021 07:09:21 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:d5de:d45f:f79c:cb62])
        by smtp.gmail.com with ESMTPSA id m3sm2303932wmc.48.2021.03.12.07.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 07:09:20 -0800 (PST)
Date:   Fri, 12 Mar 2021 16:09:15 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/11] kasan: docs: update SW_TAGS implementation
 details section
Message-ID: <YEuEG+K4/V4zn9l4@elver.google.com>
References: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
 <69b9b2e49d8cf789358fa24558be3fc0ce4ee32c.1615559068.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69b9b2e49d8cf789358fa24558be3fc0ce4ee32c.1615559068.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 03:24PM +0100, Andrey Konovalov wrote:
> Update the "Implementation details" section for SW_TAGS KASAN:
> 
> - Clarify the introduction sentence.
> - Punctuation, readability, and other minor clean-ups.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  Documentation/dev-tools/kasan.rst | 39 +++++++++++++++----------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index 986410bf269f..5873d80cc1fd 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -235,38 +235,37 @@ quarantine (see mm/kasan/quarantine.c for implementation).
>  Software tag-based KASAN
>  ~~~~~~~~~~~~~~~~~~~~~~~~
>  
> -Software tag-based KASAN requires software memory tagging support in the form
> -of HWASan-like compiler instrumentation (see HWASan documentation for details).
> -
> -Software tag-based KASAN is currently only implemented for arm64 architecture.
> +Software tag-based KASAN uses a software memory tagging approach to checking
> +access validity. It is currently only implemented for the arm64 architecture.
>  
>  Software tag-based KASAN uses the Top Byte Ignore (TBI) feature of arm64 CPUs
> -to store a pointer tag in the top byte of kernel pointers. Like generic KASAN
> -it uses shadow memory to store memory tags associated with each 16-byte memory
> -cell (therefore it dedicates 1/16th of the kernel memory for shadow memory).
> +to store a pointer tag in the top byte of kernel pointers. It uses shadow memory
> +to store memory tags associated with each 16-byte memory cell (therefore, it
> +dedicates 1/16th of the kernel memory for shadow memory).
>  
> -On each memory allocation software tag-based KASAN generates a random tag, tags
> -the allocated memory with this tag, and embeds this tag into the returned
> +On each memory allocation, software tag-based KASAN generates a random tag, tags
> +the allocated memory with this tag, and embeds the same tag into the returned
>  pointer.
>  
>  Software tag-based KASAN uses compile-time instrumentation to insert checks
> -before each memory access. These checks make sure that tag of the memory that
> -is being accessed is equal to tag of the pointer that is used to access this
> -memory. In case of a tag mismatch software tag-based KASAN prints a bug report.
> +before each memory access. These checks make sure that the tag of the memory
> +that is being accessed is equal to the tag of the pointer that is used to access
> +this memory. In case of a tag mismatch, software tag-based KASAN prints a bug
> +report.
>  
> -Software tag-based KASAN also has two instrumentation modes (outline, that
> -emits callbacks to check memory accesses; and inline, that performs the shadow
> +Software tag-based KASAN also has two instrumentation modes (outline, which
> +emits callbacks to check memory accesses; and inline, which performs the shadow
>  memory checks inline). With outline instrumentation mode, a bug report is
> -simply printed from the function that performs the access check. With inline
> -instrumentation a brk instruction is emitted by the compiler, and a dedicated
> -brk handler is used to print bug reports.
> +printed from the function that performs the access check. With inline
> +instrumentation, a ``brk`` instruction is emitted by the compiler, and a
> +dedicated ``brk`` handler is used to print bug reports.
>  
>  Software tag-based KASAN uses 0xFF as a match-all pointer tag (accesses through
> -pointers with 0xFF pointer tag aren't checked). The value 0xFE is currently
> +pointers with the 0xFF pointer tag are not checked). The value 0xFE is currently
>  reserved to tag freed memory regions.
>  
> -Software tag-based KASAN currently only supports tagging of
> -kmem_cache_alloc/kmalloc and page_alloc memory.
> +Software tag-based KASAN currently only supports tagging of slab and page_alloc
> +memory.
>  
>  Hardware tag-based KASAN
>  ~~~~~~~~~~~~~~~~~~~~~~~~
> -- 
> 2.31.0.rc2.261.g7f71774620-goog
> 
