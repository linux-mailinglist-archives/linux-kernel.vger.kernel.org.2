Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6962E3390D9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhCLPKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbhCLPKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:10:04 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3551C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:10:03 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id g25so4007324wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q9bPQXFsE5NHB3Ewyjn3BKLWEisEUyEGFLv0VSHg4OQ=;
        b=TQB5C6l4OeABWHlvhNhcWyrxqsv8C5QqNwZAyjKBcdX4BE0mTAHDSS5KczD4DVscFY
         oEeMrljq4zm4xmSq5u5jDjffWqLEs5i0GqJ+4ZRe5FC0NziHFBTQvGkx7QAUhHMEHYkp
         12yQhaakrbwFPoci6sX2/uKuLi9rDFnKtNWszi/eR8cbsdS5NWnr21AWJzF64dooYlQT
         1f0LyNEj8qTzwl+i6gqqR05RRq9MLqYnFpXbyNdTH2kf6T6+bG6s6xDEphFoFAXQrP/U
         Hw0x3631EZJQGSz8MJsvQweXwbT+JDe2ndTPUXf5S3Xah5t4kezG4UzQex3V7Rz+umzX
         3rrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q9bPQXFsE5NHB3Ewyjn3BKLWEisEUyEGFLv0VSHg4OQ=;
        b=g8BwVFZk+/iMZaOMBYU25ZQU76P73zqJ1MEX/sUPYOu28QuUYZVfksWHSCdkdJbIkW
         N9gyPHvLk6vQ6NfTZkgigMcrkKfqg3QGF4x1v9hJAPvEiOv4BAbozl5lcqgbdF4YwnHx
         vwKlz8sfo5gqXvIm7V17Hvb5nheFKBeeqql//rAwt1h1pWj27PZ7EQPvPZQa0YkzTKhG
         7wfHGLFH1RtSOO7EbryLDj5rFv9riZkN6nvK0gJAItrdB1oM4ynSb9kg57nOLVRAyQko
         3FCfpRXvEMIMGfjbmzxHeDN7dWQowkU6VRbw1AHq7KAI5WSEf+mPkqfKJlFi4lwMiRUr
         D9Zg==
X-Gm-Message-State: AOAM532cjlrWSoXMUUiGP5LKi5hjgth0AYFEXCd5U/+zAOnNkX4JQGE0
        9/iKt3Cd8SUrZIK9xbxEvMgYFw==
X-Google-Smtp-Source: ABdhPJz5IH7Ok3UON2hlkoU2lpeCCjiad8g3I7jy472VKyfIa2m7Uio36UODP+qSoYfFrknHPzUbTA==
X-Received: by 2002:a1c:c20a:: with SMTP id s10mr13423275wmf.144.1615561802386;
        Fri, 12 Mar 2021 07:10:02 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:d5de:d45f:f79c:cb62])
        by smtp.gmail.com with ESMTPSA id q4sm2523647wma.20.2021.03.12.07.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 07:10:01 -0800 (PST)
Date:   Fri, 12 Mar 2021 16:09:55 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/11] kasan: docs: update shadow memory section
Message-ID: <YEuEQ79AE0+BoV87@elver.google.com>
References: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
 <00f8c38b0fd5290a3f4dced04eaba41383e67e14.1615559068.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00f8c38b0fd5290a3f4dced04eaba41383e67e14.1615559068.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 03:24PM +0100, Andrey Konovalov wrote:
> Update the "Shadow memory" section in KASAN documentation:
> 
> - Rearrange the introduction paragraph do it doesn't give a
>   "KASAN has an issue" impression.
> - Update the list of architectures with vmalloc support.
> - Punctuation, readability, and other minor clean-ups.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  Documentation/dev-tools/kasan.rst | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index 2744ae6347c6..d0c1796122df 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -304,14 +304,11 @@ checking gets disabled.
>  Shadow memory
>  -------------
>  
> -The kernel maps memory in a number of different parts of the address
> -space. This poses something of a problem for KASAN, which requires
> -that all addresses accessed by instrumented code have a valid shadow
> -region.
> -
> -The range of kernel virtual addresses is large: there is not enough
> -real memory to support a real shadow region for every address that
> -could be accessed by the kernel.
> +The kernel maps memory in several different parts of the address space.
> +The range of kernel virtual addresses is large: there is not enough real
> +memory to support a real shadow region for every address that could be
> +accessed by the kernel. Therefore, KASAN only maps real shadow for certain
> +parts of the address space.
>  
>  Default behaviour
>  ~~~~~~~~~~~~~~~~~
> @@ -323,10 +320,9 @@ page is mapped over the shadow area. This read-only shadow page
>  declares all memory accesses as permitted.
>  
>  This presents a problem for modules: they do not live in the linear
> -mapping, but in a dedicated module space. By hooking in to the module
> -allocator, KASAN can temporarily map real shadow memory to cover
> -them. This allows detection of invalid accesses to module globals, for
> -example.
> +mapping but in a dedicated module space. By hooking into the module
> +allocator, KASAN temporarily maps real shadow memory to cover them.
> +This allows detection of invalid accesses to module globals, for example.
>  
>  This also creates an incompatibility with ``VMAP_STACK``: if the stack
>  lives in vmalloc space, it will be shadowed by the read-only page, and
> @@ -337,9 +333,10 @@ CONFIG_KASAN_VMALLOC
>  ~~~~~~~~~~~~~~~~~~~~
>  
>  With ``CONFIG_KASAN_VMALLOC``, KASAN can cover vmalloc space at the
> -cost of greater memory usage. Currently this is only supported on x86.
> +cost of greater memory usage. Currently, this is supported on x86,
> +riscv, s390, and powerpc.
>  
> -This works by hooking into vmalloc and vmap, and dynamically
> +This works by hooking into vmalloc and vmap and dynamically
>  allocating real shadow memory to back the mappings.
>  
>  Most mappings in vmalloc space are small, requiring less than a full
> @@ -358,10 +355,10 @@ memory.
>  
>  To avoid the difficulties around swapping mappings around, KASAN expects
>  that the part of the shadow region that covers the vmalloc space will
> -not be covered by the early shadow page, but will be left
> -unmapped. This will require changes in arch-specific code.
> +not be covered by the early shadow page but will be left unmapped.
> +This will require changes in arch-specific code.
>  
> -This allows ``VMAP_STACK`` support on x86, and can simplify support of
> +This allows ``VMAP_STACK`` support on x86 and can simplify support of
>  architectures that do not have a fixed module region.
>  
>  For developers
> -- 
> 2.31.0.rc2.261.g7f71774620-goog
> 
