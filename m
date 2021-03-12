Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAC33390CB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbhCLPIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhCLPIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:08:12 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAC9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:08:12 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so15394923wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=11LkVFc2ai96+FS3xzLxLBdovdC4Bzzrs8ahU7qpmeI=;
        b=lUp7M+IiivkbRqlrmnLkQeZkCcfqBJxzLShB6QIW1KqBf1fb0GVlVGCijS5s31b96N
         lARfpP7EUB8sKtlYdlbHiAio0Y+Us6d6ZZERyoLmxXKMQS6qJ1yS7w4lzgujFBBFIaGp
         lvG5zEeHeoE58lBSZNVXTJYzxVlH86jwQ9nDxKWibmozu+8Ck/UwbJ1NpJC07KbexKR3
         aJ0QGmrmdKWcl77uJE8gPJtCQHycRWIjnR8TE0RamD0Py5WYFtPvi05XYIJLOHjEfYUb
         jscaR2ipeCPeefxKgQlqWDTbuAD6W+NjAqGyiPYcGDPrT0wOGCol3lF3ikm5J/ac5n0f
         zNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=11LkVFc2ai96+FS3xzLxLBdovdC4Bzzrs8ahU7qpmeI=;
        b=cDEVsY2P06pFCLlmkijkb/uUeFqUGt+FyzvGImLKW9hdsETDIn6bms7txgR2+Y4GLB
         Xo74XbPWfUdVE80GRfDIr2RfcB5YHBft/VhDwbxLg6uhhvjZ8MK7M2qKY1K4ETzX1DRQ
         lxxrhUFfyChTU6Qhs39LIVt6yfw7mDpx2G7MiBs78Q/U9HzEPadLNOOoy9tnsyT994mf
         g+UzVs5dnRZVZ3soC7I2o71yBGBs4STPojKXSQFHwLdMK6dSur3FbW8uEHh8+fWUjNm0
         Bgtb5hMZkPIoclrlEWUKwiPHhZOe+yfhkvQsmSr0iLa6Vxb5RYf0jKF7tJupkFxI9gCy
         i+dQ==
X-Gm-Message-State: AOAM531hhUZt4D9sMt5wqFKtxELmvK+67xg+PRZ3HF3hMyMo8iWv52iF
        JcWqKXnM6tERw8fFTP0jGdIfqA==
X-Google-Smtp-Source: ABdhPJxMj+nON4YnTgXAyWfAAEBbOaJIKzefApKvXJINUWhVIyEe28Hvb/8UyqT2wS9MzYtINtwgrg==
X-Received: by 2002:a05:600c:289:: with SMTP id 9mr13639929wmk.135.1615561690926;
        Fri, 12 Mar 2021 07:08:10 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:d5de:d45f:f79c:cb62])
        by smtp.gmail.com with ESMTPSA id w131sm2400544wmb.8.2021.03.12.07.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 07:08:10 -0800 (PST)
Date:   Fri, 12 Mar 2021 16:08:04 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/11] kasan: docs: update error reports section
Message-ID: <YEuD1Ghn+5bf0TJO@elver.google.com>
References: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
 <3531e8fe6972cf39d1954e3643237b19eb21227e.1615559068.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3531e8fe6972cf39d1954e3643237b19eb21227e.1615559068.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 03:24PM +0100, Andrey Konovalov wrote:
> Update the "Error reports" section in KASAN documentation:
> 
> - Mention that bug titles are best-effort.
> - Move and reword the part about auxiliary stacks from
>   "Implementation details".
> - Punctuation, readability, and other minor clean-ups.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  Documentation/dev-tools/kasan.rst | 46 +++++++++++++++++--------------
>  1 file changed, 26 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index 46f4e9680805..cd12c890b888 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -60,7 +60,7 @@ physical pages, enable ``CONFIG_PAGE_OWNER`` and boot with ``page_owner=on``.
>  Error reports
>  ~~~~~~~~~~~~~
>  
> -A typical out-of-bounds access generic KASAN report looks like this::
> +A typical KASAN report looks like this::
>  
>      ==================================================================
>      BUG: KASAN: slab-out-of-bounds in kmalloc_oob_right+0xa8/0xbc [test_kasan]
> @@ -133,33 +133,43 @@ A typical out-of-bounds access generic KASAN report looks like this::
>       ffff8801f44ec400: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>      ==================================================================
>  
> -The header of the report provides a short summary of what kind of bug happened
> -and what kind of access caused it. It's followed by a stack trace of the bad
> -access, a stack trace of where the accessed memory was allocated (in case bad
> -access happens on a slab object), and a stack trace of where the object was
> -freed (in case of a use-after-free bug report). Next comes a description of
> -the accessed slab object and information about the accessed memory page.
> +The report header summarizes what kind of bug happened and what kind of access
> +caused it. It is followed by a stack trace of the bad access, a stack trace of
> +where the accessed memory was allocated (in case a slab object was accessed),
> +and a stack trace of where the object was freed (in case of a use-after-free
> +bug report). Next comes a description of the accessed slab object and the
> +information about the accessed memory page.
>  
> -In the last section the report shows memory state around the accessed address.
> -Internally KASAN tracks memory state separately for each memory granule, which
> +In the end, the report shows the memory state around the accessed address.
> +Internally, KASAN tracks memory state separately for each memory granule, which
>  is either 8 or 16 aligned bytes depending on KASAN mode. Each number in the
>  memory state section of the report shows the state of one of the memory
>  granules that surround the accessed address.
>  
> -For generic KASAN the size of each memory granule is 8. The state of each
> +For generic KASAN, the size of each memory granule is 8. The state of each
>  granule is encoded in one shadow byte. Those 8 bytes can be accessible,
> -partially accessible, freed or be a part of a redzone. KASAN uses the following
> -encoding for each shadow byte: 0 means that all 8 bytes of the corresponding
> +partially accessible, freed, or be a part of a redzone. KASAN uses the following
> +encoding for each shadow byte: 00 means that all 8 bytes of the corresponding
>  memory region are accessible; number N (1 <= N <= 7) means that the first N
>  bytes are accessible, and other (8 - N) bytes are not; any negative value
>  indicates that the entire 8-byte word is inaccessible. KASAN uses different
>  negative values to distinguish between different kinds of inaccessible memory
>  like redzones or freed memory (see mm/kasan/kasan.h).
>  
> -In the report above the arrows point to the shadow byte 03, which means that
> -the accessed address is partially accessible. For tag-based KASAN modes this
> -last report section shows the memory tags around the accessed address
> -(see the `Implementation details`_ section).
> +In the report above, the arrow points to the shadow byte ``03``, which means
> +that the accessed address is partially accessible.
> +
> +For tag-based KASAN modes, this last report section shows the memory tags around
> +the accessed address (see the `Implementation details`_ section).
> +
> +Note that KASAN bug titles (like ``slab-out-of-bounds`` or ``use-after-free``)
> +are best-effort: KASAN prints the most probable bug type based on the limited
> +information it has. The actual type of the bug might be different.
> +
> +Generic KASAN also reports up to two auxiliary call stack traces. These stack
> +traces point to places in code that interacted with the object but that are not
> +directly present in the bad access stack trace. Currently, this includes
> +call_rcu() and workqueue queuing.
>  
>  Boot parameters
>  ~~~~~~~~~~~~~~~
> @@ -214,10 +224,6 @@ function calls GCC directly inserts the code to check the shadow memory.
>  This option significantly enlarges kernel but it gives x1.1-x2 performance
>  boost over outline instrumented kernel.
>  
> -Generic KASAN also reports the last 2 call stacks to creation of work that
> -potentially has access to an object. Call stacks for the following are shown:
> -call_rcu() and workqueue queuing.
> -
>  Generic KASAN is the only mode that delays the reuse of freed object via
>  quarantine (see mm/kasan/quarantine.c for implementation).
>  
> -- 
> 2.31.0.rc2.261.g7f71774620-goog
> 
