Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351D83390CA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhCLPIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbhCLPHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:07:52 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39342C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:07:52 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso15991254wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fwNR/esNVxm8bvX0S5OWeZlTokgAgw+YxcDuubZWv9Y=;
        b=PVXNJnwSGwoevssUnEh1inCzRSXjHaDhS0l9Lxkb6lXzwyiMvsKzhOdQ1oktcEVyl0
         HyN/+lCS9c98sOlX263sV7lUUA/1p7VXOZMd0kwZOwKO6yA1qwJaWGjOkWtC3zeRQPGr
         uPO6pDotO3NhEjO0FS2rxtztT9GZ7LdqlHWCd432Mnj1MCUYYblWDWwNhHGHV0fYHipP
         8DA87GJH0O9rFV6lsfyJdgcZYLda9E2jvYecRbiIFOMSqH41rF77dpj7o4t4dVpg5jUX
         XasF4PC1gALbaTVx41DjHjgd+28cmG6iVRXzhQmkwyd4uC/I7biUEEmiovtvd161vEXy
         lPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fwNR/esNVxm8bvX0S5OWeZlTokgAgw+YxcDuubZWv9Y=;
        b=spVtpFrsU6dX9I0wpYa0rQb1hCDFMy09egyHaw6UYp4e5mz1oC2lDXHu9PfsfEbWnq
         79DNYthhH+KB/CJwxR70D+x/X0a6v+pWK2CxXGvsmNdOfEsgn1R+6LqZ/FjRfE9s545p
         vROAhB7X+4h0tzhQ42FIMou+ZP8dY560q4sTwKW/H7nkp/IGle3AK3m/h1hCxWSsYAB6
         J6PdNirr2fH7+eYR1EqGjIs28ngtXR1LkPRluYuVdywz0LX5M8UsU34+jxNN++qw5GpS
         5cG+458PRpmn5dbbvEc7YnYKSO2NdQscfHFrMdZ/XVMrHpS89tq965Zzow7dsXnwCamT
         RRig==
X-Gm-Message-State: AOAM532GldMqGJNIJvuQqDGz6bQmbUfyTG1s2KayYlfOZuh8e+W3lrM8
        s7ZV7qwFcbfSDfxfokPelEJwJg==
X-Google-Smtp-Source: ABdhPJxnpebHGFV0Q4Eu8cs3Jth8EBcbH5bjBDK71GUH5UHkJB1w1j2kgjPd33zgfnq0afxfAxD5uQ==
X-Received: by 2002:a7b:c931:: with SMTP id h17mr13781890wml.4.1615561670668;
        Fri, 12 Mar 2021 07:07:50 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:d5de:d45f:f79c:cb62])
        by smtp.gmail.com with ESMTPSA id h10sm8125546wrp.22.2021.03.12.07.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 07:07:49 -0800 (PST)
Date:   Fri, 12 Mar 2021 16:07:44 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/11] kasan: docs: update usage section
Message-ID: <YEuDwG6NqbNlCXL/@elver.google.com>
References: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
 <48427809cd4b8b5d6bc00926cbe87e2b5081df17.1615559068.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48427809cd4b8b5d6bc00926cbe87e2b5081df17.1615559068.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 03:24PM +0100, Andrey Konovalov wrote:
> Update the "Usage" section in KASAN documentation:
> 
> - Add inline code snippet markers.
> - Reword the part about stack traces for clarity.
> - Other minor clean-ups.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  Documentation/dev-tools/kasan.rst | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index 2f2697b290d5..46f4e9680805 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -41,22 +41,21 @@ and riscv architectures, and tag-based KASAN modes are supported only for arm64.
>  Usage
>  -----
>  
> -To enable KASAN configure kernel with::
> +To enable KASAN, configure the kernel with::
>  
> -	  CONFIG_KASAN = y
> +	  CONFIG_KASAN=y
>  
> -and choose between CONFIG_KASAN_GENERIC (to enable generic KASAN),
> -CONFIG_KASAN_SW_TAGS (to enable software tag-based KASAN), and
> -CONFIG_KASAN_HW_TAGS (to enable hardware tag-based KASAN).
> +and choose between ``CONFIG_KASAN_GENERIC`` (to enable generic KASAN),
> +``CONFIG_KASAN_SW_TAGS`` (to enable software tag-based KASAN), and
> +``CONFIG_KASAN_HW_TAGS`` (to enable hardware tag-based KASAN).
>  
> -For software modes, you also need to choose between CONFIG_KASAN_OUTLINE and
> -CONFIG_KASAN_INLINE. Outline and inline are compiler instrumentation types.
> -The former produces smaller binary while the latter is 1.1 - 2 times faster.
> +For software modes, also choose between ``CONFIG_KASAN_OUTLINE`` and
> +``CONFIG_KASAN_INLINE``. Outline and inline are compiler instrumentation types.
> +The former produces a smaller binary while the latter is 1.1-2 times faster.
>  
> -For better error reports that include stack traces, enable CONFIG_STACKTRACE.
> -
> -To augment reports with last allocation and freeing stack of the physical page,
> -it is recommended to enable also CONFIG_PAGE_OWNER and boot with page_owner=on.
> +To include alloc and free stack traces of affected slab objects into reports,
> +enable ``CONFIG_STACKTRACE``. To include alloc and free stack traces of affected
> +physical pages, enable ``CONFIG_PAGE_OWNER`` and boot with ``page_owner=on``.
>  
>  Error reports
>  ~~~~~~~~~~~~~
> -- 
> 2.31.0.rc2.261.g7f71774620-goog
> 
