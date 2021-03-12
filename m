Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726503390D6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhCLPJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbhCLPJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:09:45 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB12AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:09:44 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id o16so1965623wrn.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8Z7mWKRFjAgMHFPpQ+htbK5SeLG117LB/ZqDOLBkzko=;
        b=GN9pLSpi3YCNTpgANO+7rX766QSIhZiETPjIHdAcvhw2o3kkA0lkQByD9RxfwKGBYD
         JlysH6HcLqwf7YVC1tjBR3+rT41+pvKS/csFuswhwrLe95DRcbCO2iS7DSy6k9ULJKOP
         anA1AxHBgJc2RhS2a6bHqeCCqbuAaKf9E8TpserEPhaDO0QOmjUvDswQMS1CspoDzlmR
         HNp76MfvTanTS1gRVNnlTv7XzcwLLZmIZfEgGnyxkb4lssd1rrrWAvryfHGYFn4CW3nr
         ojAsOdkbYRI3noTd1byVW0gEgKy+Da8b30axgPTDlh3MftY14U2YGDOGihqEYT5G6KFn
         YXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8Z7mWKRFjAgMHFPpQ+htbK5SeLG117LB/ZqDOLBkzko=;
        b=pkrTy5YSDiwewpS+VwkE8bK3XR7cj1vQnyHS+qs+f164odoxrzTbov7CVupvlN8hRg
         zWReX4zhlgipux2hiSUeIH7GlH8LrFjx4TJ1HCcZ7HSfsmM9Y3tV/gbg/peRtCE3KVRC
         drtHzqz13TM+2wIbZBHk15bMzqlNwihob7jh0sU7cM95vDdpaUBpPYTQmPduMWA8dI13
         YsxuSvZh91AVywJSHV3WW2LuYIt9yvscBITDrS9S+P2ZTTJe9mIQZdu4NIkybooDI6v/
         h9C1fqW+gvq1aG2KMIrB5oH3oxTjnqIMLYmLWVXCHWsYiZC5/65tYcVzbnJ8/qGWDwi1
         H+2A==
X-Gm-Message-State: AOAM532GerH+SEcLz8iI9LNoSUbnjkp6myvZhvVAsgo3NSCi4uGTedvQ
        iQLNmxddE9TZlRmmgt/AXnUYsg==
X-Google-Smtp-Source: ABdhPJwJjQjJst3vjmz6Ah0vBzklDd8fCYc12y27KinnLTgrEUUIYdqNTtTtdBhKe5YU8SrCqOqY0g==
X-Received: by 2002:a5d:6049:: with SMTP id j9mr14291212wrt.117.1615561783490;
        Fri, 12 Mar 2021 07:09:43 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:d5de:d45f:f79c:cb62])
        by smtp.gmail.com with ESMTPSA id e8sm2374802wme.14.2021.03.12.07.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 07:09:42 -0800 (PST)
Date:   Fri, 12 Mar 2021 16:09:37 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/11] kasan: docs: update HW_TAGS implementation
 details section
Message-ID: <YEuEMajjvbyByzJA@elver.google.com>
References: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
 <ee2caf4c138cc1fd239822c2abefd5af6c057744.1615559068.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee2caf4c138cc1fd239822c2abefd5af6c057744.1615559068.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 03:24PM +0100, Andrey Konovalov wrote:
> Update the "Implementation details" section for HW_TAGS KASAN:
> 
> - Punctuation, readability, and other minor clean-ups.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  Documentation/dev-tools/kasan.rst | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index 5873d80cc1fd..2744ae6347c6 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -270,35 +270,35 @@ memory.
>  Hardware tag-based KASAN
>  ~~~~~~~~~~~~~~~~~~~~~~~~
>  
> -Hardware tag-based KASAN is similar to the software mode in concept, but uses
> +Hardware tag-based KASAN is similar to the software mode in concept but uses
>  hardware memory tagging support instead of compiler instrumentation and
>  shadow memory.
>  
>  Hardware tag-based KASAN is currently only implemented for arm64 architecture
>  and based on both arm64 Memory Tagging Extension (MTE) introduced in ARMv8.5
> -Instruction Set Architecture, and Top Byte Ignore (TBI).
> +Instruction Set Architecture and Top Byte Ignore (TBI).
>  
>  Special arm64 instructions are used to assign memory tags for each allocation.
>  Same tags are assigned to pointers to those allocations. On every memory
> -access, hardware makes sure that tag of the memory that is being accessed is
> -equal to tag of the pointer that is used to access this memory. In case of a
> -tag mismatch a fault is generated and a report is printed.
> +access, hardware makes sure that the tag of the memory that is being accessed is
> +equal to the tag of the pointer that is used to access this memory. In case of a
> +tag mismatch, a fault is generated, and a report is printed.
>  
>  Hardware tag-based KASAN uses 0xFF as a match-all pointer tag (accesses through
> -pointers with 0xFF pointer tag aren't checked). The value 0xFE is currently
> +pointers with the 0xFF pointer tag are not checked). The value 0xFE is currently
>  reserved to tag freed memory regions.
>  
> -Hardware tag-based KASAN currently only supports tagging of
> -kmem_cache_alloc/kmalloc and page_alloc memory.
> +Hardware tag-based KASAN currently only supports tagging of slab and page_alloc
> +memory.
>  
> -If the hardware doesn't support MTE (pre ARMv8.5), hardware tag-based KASAN
> -won't be enabled. In this case all boot parameters are ignored.
> +If the hardware does not support MTE (pre ARMv8.5), hardware tag-based KASAN
> +will not be enabled. In this case, all KASAN boot parameters are ignored.
>  
> -Note, that enabling CONFIG_KASAN_HW_TAGS always results in in-kernel TBI being
> -enabled. Even when kasan.mode=off is provided, or when the hardware doesn't
> +Note that enabling CONFIG_KASAN_HW_TAGS always results in in-kernel TBI being
> +enabled. Even when ``kasan.mode=off`` is provided or when the hardware does not
>  support MTE (but supports TBI).
>  
> -Hardware tag-based KASAN only reports the first found bug. After that MTE tag
> +Hardware tag-based KASAN only reports the first found bug. After that, MTE tag
>  checking gets disabled.
>  
>  Shadow memory
> -- 
> 2.31.0.rc2.261.g7f71774620-goog
> 
