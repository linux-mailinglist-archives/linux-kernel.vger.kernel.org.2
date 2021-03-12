Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2EA3390C3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhCLPHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhCLPGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:06:45 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7A3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:06:44 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id e10so4982252wro.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qBFp/gtR/nkmpiy/tuP54xC4mkMnllk9WWHQ5y9bp+8=;
        b=l0terJNxYkV/+zFklKdMKaNVqV1bPtw1g8NvMZndsJUemdD1envhpUZzRx+8u4hcvI
         wraNb8fJXljCTpMUM2joNzzuE9IaX5ektzNIW2f4g9APQ6tH/jAqaFZWmnbnObagcXiu
         sX+7iM2C+whX4MBjWL8WFCSFS1/f5QVTGpfqCYWp5R5t7XJu21qFxLcLk4Xyh0bfkyku
         MeXlEY3AfvEJk29LpAqDzYAUElEusRESRD39orwpq9EiWziFxlBqOv8mfadvAzMkf7T5
         +ilCSMcT4ynrc1kiza9Wr76Ab5rW86EljbDy/3dtNdkxmkbIl0BjAHRZD3ssDRRt3Z/H
         4XyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qBFp/gtR/nkmpiy/tuP54xC4mkMnllk9WWHQ5y9bp+8=;
        b=ulsFv7jJsxjWItCy3I/r664oy8GK8+XuxcmjaJm7RrV5ChGKlgVxMXBYvDkwAWQRdw
         zWUHKIHNy9YD1JPYoS7GzPLTmi90gJUjm5aLrKoJi+aeF2Gpw6hMKhUwZYXijJIz+wzw
         UovQ8M4axwntSSu3bT1Wp6FwrzeGZpftlmLGgmxuNEgCBJ+0+pGtUzMHi4OT3T2xzdJm
         C2WI3jvY+x/FvxZTyU7zBcoH+osqFRz6XRLPhr+TnRyVhSbmYfnPKr6BEFaNObTej06d
         RY9j3vi8unikqEbjc4f3cbYVCPYHyO9akCvpOyjlP9nmOUSYPpHm8W6lOla/y615yu0F
         eV/w==
X-Gm-Message-State: AOAM533/yzBFMcEXojA6zSr8TpPfJuF2kzwl2Gi+Oea+fZOnWBXwdJBb
        jCC0tckNyvMPn9TiVVVWii1e9CF4+me+xQ==
X-Google-Smtp-Source: ABdhPJzn4ygg7SPkaFeqCJM4x23NqTmcfN68SGDVwhFt0n2atB7O+FT3qRyI1pW2DRw34DHBEuU7Nw==
X-Received: by 2002:a5d:65cd:: with SMTP id e13mr14714985wrw.334.1615561601007;
        Fri, 12 Mar 2021 07:06:41 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:d5de:d45f:f79c:cb62])
        by smtp.gmail.com with ESMTPSA id d7sm7830010wrs.42.2021.03.12.07.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 07:06:40 -0800 (PST)
Date:   Fri, 12 Mar 2021 16:06:34 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/11] kasan: docs: clean up sections
Message-ID: <YEuDevgROKlHyCvB@elver.google.com>
References: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2bbb56eaea80ad484f0ee85bb71959a3a63f1d7.1615559068.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 03:24PM +0100, Andrey Konovalov wrote:
> Update KASAN documentation:
> 
> - Give some sections clearer names.
> - Remove unneeded subsections in the "Tests" section.
> - Move the "For developers" section and split into subsections.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> 
> Changes v1->v2:
> - Rename "By default" section to "Default behaviour".
> ---
>  Documentation/dev-tools/kasan.rst | 54 +++++++++++++++----------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index ddf4239a5890..b3b2c517db55 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -168,24 +168,6 @@ particular KASAN features.
>    report or also panic the kernel (default: ``report``). Note, that tag
>    checking gets disabled after the first reported bug.
>  
> -For developers
> -~~~~~~~~~~~~~~
> -
> -Software KASAN modes use compiler instrumentation to insert validity checks.
> -Such instrumentation might be incompatible with some part of the kernel, and
> -therefore needs to be disabled. To disable instrumentation for specific files
> -or directories, add a line similar to the following to the respective kernel
> -Makefile:
> -
> -- For a single file (e.g. main.o)::
> -
> -    KASAN_SANITIZE_main.o := n
> -
> -- For all files in one directory::
> -
> -    KASAN_SANITIZE := n
> -
> -
>  Implementation details
>  ----------------------
>  
> @@ -299,8 +281,8 @@ support MTE (but supports TBI).
>  Hardware tag-based KASAN only reports the first found bug. After that MTE tag
>  checking gets disabled.
>  
> -What memory accesses are sanitised by KASAN?
> ---------------------------------------------
> +Shadow memory
> +-------------
>  
>  The kernel maps memory in a number of different parts of the address
>  space. This poses something of a problem for KASAN, which requires
> @@ -311,8 +293,8 @@ The range of kernel virtual addresses is large: there is not enough
>  real memory to support a real shadow region for every address that
>  could be accessed by the kernel.
>  
> -By default
> -~~~~~~~~~~
> +Default behaviour
> +~~~~~~~~~~~~~~~~~
>  
>  By default, architectures only map real memory over the shadow region
>  for the linear mapping (and potentially other small areas). For all
> @@ -362,8 +344,29 @@ unmapped. This will require changes in arch-specific code.
>  This allows ``VMAP_STACK`` support on x86, and can simplify support of
>  architectures that do not have a fixed module region.
>  
> -CONFIG_KASAN_KUNIT_TEST and CONFIG_KASAN_MODULE_TEST
> -----------------------------------------------------
> +For developers
> +--------------
> +
> +Ignoring accesses
> +~~~~~~~~~~~~~~~~~
> +
> +Software KASAN modes use compiler instrumentation to insert validity checks.
> +Such instrumentation might be incompatible with some part of the kernel, and
> +therefore needs to be disabled. To disable instrumentation for specific files
> +or directories, add a line similar to the following to the respective kernel
> +Makefile:
> +
> +- For a single file (e.g. main.o)::
> +
> +    KASAN_SANITIZE_main.o := n
> +
> +- For all files in one directory::
> +
> +    KASAN_SANITIZE := n
> +
> +
> +Tests
> +~~~~~
>  
>  KASAN tests consist of two parts:
>  
> @@ -409,21 +412,18 @@ Or, if one of the tests failed::
>  There are a few ways to run KUnit-compatible KASAN tests.
>  
>  1. Loadable module
> -~~~~~~~~~~~~~~~~~~
>  
>  With ``CONFIG_KUNIT`` enabled, ``CONFIG_KASAN_KUNIT_TEST`` can be built as
>  a loadable module and run on any architecture that supports KASAN by loading
>  the module with insmod or modprobe. The module is called ``test_kasan``.
>  
>  2. Built-In
> -~~~~~~~~~~~
>  
>  With ``CONFIG_KUNIT`` built-in, ``CONFIG_KASAN_KUNIT_TEST`` can be built-in
>  on any architecure that supports KASAN. These and any other KUnit tests enabled
>  will run and print the results at boot as a late-init call.
>  
>  3. Using kunit_tool
> -~~~~~~~~~~~~~~~~~~~
>  
>  With ``CONFIG_KUNIT`` and ``CONFIG_KASAN_KUNIT_TEST`` built-in, it's also
>  possible use ``kunit_tool`` to see the results of these and other KUnit tests
> -- 
> 2.31.0.rc2.261.g7f71774620-goog
> 
