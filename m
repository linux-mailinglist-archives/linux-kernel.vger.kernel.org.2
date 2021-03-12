Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0881F3390D1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhCLPJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbhCLPJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:09:08 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EFBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:09:07 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so15396651wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8MLa7BfE7dVLn4tTMKZ+HSLGOdEizmmjEqt3urdruHo=;
        b=YXc7cfUGiDH4BrcqeCbErclE5UpFbj0KRoCqW+CdxyNwQfypBnOQ/JXl/BQWZPYMSf
         5Ot87rpsNwc67IcIMaUT/2mT5iQ6JifR2oOH4+1U/x2JoNkrhbmVOP0/YaoFweuMp7Xz
         9cjsoeb2E5H/+ycRfan42lPk+YhVQV0q9C93ePz3hYTf3vqsa7zhKFLd+0J374z3OvPR
         q6pRk3yb3Fm5X2u5AfJvSoi8ssYpIoIVql9zeUnzsjQwAIsrhkKfqf6SypfcT5+zh6SL
         StmOqnQ0w/Qq6RFrjTQcbTOAerPuU/TSLKo2ozPFpgkU0a0XsO0QSJg8Jy9m9AYJukk+
         DznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8MLa7BfE7dVLn4tTMKZ+HSLGOdEizmmjEqt3urdruHo=;
        b=Uc3IaOOSFE+t0sYr+IWvbt7gZbIshnogw/K6ahy5egUKwDY+OfOzUOwMdvtyDBsLnD
         akdFFOqlpA/MacE8MONIEbQw7obj7hersrSwFn7bDlOjyfhi1vGb6/ca/IpidblK3bdZ
         6uXaW7tEBNUqFWfq2px1CRsPvdVT+xXxGbBXRnWk1D7G+hPIIrTe5M/PM0U01oD6jVlq
         sInf9qyvBiOK1yr9KgycrdF6bskL0VBt6qRDfjMmMsoZXO797iGqfoRVnX50+wHkQijT
         4HsidCvFxU3nPHAXnHLUbJQPMuHvqM/xTmFKettuwTVti2IbI0jxsYn00oDpDjoU8m/J
         AJ5Q==
X-Gm-Message-State: AOAM532H8y97iKSufs3YXKITC9f7+TnLM7oF4eiCfKi1ijYVPwFMfcnt
        qzW6BlsXVC6tK+AnBluHbudPpw==
X-Google-Smtp-Source: ABdhPJzugoYcXn8oExDHUrj07sG0kptHYTO8yEvVKp4/4x1MmKQHsAr23VIN62ownUD9pD+bMeZBnA==
X-Received: by 2002:a05:600c:2053:: with SMTP id p19mr13577526wmg.87.1615561741593;
        Fri, 12 Mar 2021 07:09:01 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:d5de:d45f:f79c:cb62])
        by smtp.gmail.com with ESMTPSA id w131sm2402679wmb.8.2021.03.12.07.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 07:09:00 -0800 (PST)
Date:   Fri, 12 Mar 2021 16:08:55 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/11] kasan: docs: update GENERIC implementation
 details section
Message-ID: <YEuEB3IhoXdixgiP@elver.google.com>
References: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
 <f2f35fdab701f8c709f63d328f98aec2982c8acc.1615559068.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2f35fdab701f8c709f63d328f98aec2982c8acc.1615559068.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 03:24PM +0100, Andrey Konovalov wrote:
> Update the "Implementation details" section for generic KASAN:
> 
> - Don't mention kmemcheck, it's not present in the kernel anymore.
> - Don't mention GCC as the only supported compiler.
> - Update kasan_mem_to_shadow() definition to match actual code.
> - Punctuation, readability, and other minor clean-ups.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  Documentation/dev-tools/kasan.rst | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index 1189be9b4cb5..986410bf269f 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -200,12 +200,11 @@ Implementation details
>  Generic KASAN
>  ~~~~~~~~~~~~~
>  
> -From a high level perspective, KASAN's approach to memory error detection is
> -similar to that of kmemcheck: use shadow memory to record whether each byte of
> -memory is safe to access, and use compile-time instrumentation to insert checks
> -of shadow memory on each memory access.
> +Software KASAN modes use shadow memory to record whether each byte of memory is
> +safe to access and use compile-time instrumentation to insert shadow memory
> +checks before each memory access.
>  
> -Generic KASAN dedicates 1/8th of kernel memory to its shadow memory (e.g. 16TB
> +Generic KASAN dedicates 1/8th of kernel memory to its shadow memory (16TB
>  to cover 128TB on x86_64) and uses direct mapping with a scale and offset to
>  translate a memory address to its corresponding shadow address.
>  
> @@ -214,23 +213,23 @@ address::
>  
>      static inline void *kasan_mem_to_shadow(const void *addr)
>      {
> -	return ((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
> +	return (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
>  		+ KASAN_SHADOW_OFFSET;
>      }
>  
>  where ``KASAN_SHADOW_SCALE_SHIFT = 3``.
>  
>  Compile-time instrumentation is used to insert memory access checks. Compiler
> -inserts function calls (__asan_load*(addr), __asan_store*(addr)) before each
> -memory access of size 1, 2, 4, 8 or 16. These functions check whether memory
> -access is valid or not by checking corresponding shadow memory.
> +inserts function calls (``__asan_load*(addr)``, ``__asan_store*(addr)``) before
> +each memory access of size 1, 2, 4, 8, or 16. These functions check whether
> +memory accesses are valid or not by checking corresponding shadow memory.
>  
> -GCC 5.0 has possibility to perform inline instrumentation. Instead of making
> -function calls GCC directly inserts the code to check the shadow memory.
> -This option significantly enlarges kernel but it gives x1.1-x2 performance
> -boost over outline instrumented kernel.
> +With inline instrumentation, instead of making function calls, the compiler
> +directly inserts the code to check shadow memory. This option significantly
> +enlarges the kernel, but it gives an x1.1-x2 performance boost over the
> +outline-instrumented kernel.
>  
> -Generic KASAN is the only mode that delays the reuse of freed object via
> +Generic KASAN is the only mode that delays the reuse of freed objects via
>  quarantine (see mm/kasan/quarantine.c for implementation).
>  
>  Software tag-based KASAN
> -- 
> 2.31.0.rc2.261.g7f71774620-goog
> 
