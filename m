Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2EF338AEA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbhCLLD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbhCLLCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:02:54 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A7AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:02:54 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g20so3545135wmk.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dihNwmS8eg72fB7m8NAEuzih9r4cxSiPgspyafvWSkU=;
        b=EVuw7+TenJ9xISL4BCYhMltGJemyMiBtTLqkDq7oFLcfKFjApbRCYCRS7/6ty8/TZZ
         NA1jPbDyU16KQpW2yr7P8fP7q9sSS3aZ2dtMpEzAWOfRLPjJNnrocjA3LajtTQi4eMA0
         QFnSH1pWZ4OPERi4W1zrtP067BygVQ30XXHR2zbuEhP2KBIz2ymp5g373bj4pnr1FCrM
         RQbxxXAvwUpiGzK+qEG74AQOgM0w2xhkizZMj/CXis44uDexQsNBKilLcxj89MXOpfLC
         kP57Nh11zdStlSx+P+dSPMVVTWPh0EbPzp8+qwK2ZW9OdztSOuHsRZxrR7cfgjKNxA0S
         1n/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dihNwmS8eg72fB7m8NAEuzih9r4cxSiPgspyafvWSkU=;
        b=NyzACnUvShkBAtDUnT7zKMG6ATugLYW4tJOME2nr/Vn3jtvog1ir9XeEQ17Y26cmzI
         tBy7b2jXe29kSqh8cfwH1o+htynloODOokEyixOIUwFmiYChpQPR7AyqYdotlMr22JPv
         d9J2wXURCdgSfnQuQ+jRZ89cQxAivyR8buzMdPsE3+29n8nlllIgXO8u6qBsBiRpt3IC
         wNOJa4cvD6jFKRnW1a9Y5at0zE11WCvo9m++32vQ07LigGpf5LswZaqLgiaQp15f/CBp
         PJlVE7trjBVn+alVFzxtLLIwMEuH+1AnZj9R0VrGC1t9JZd08ekrWrFSUgMLtQtBjqAU
         mzJw==
X-Gm-Message-State: AOAM532TdK8P0ER5n4+nvovnnKWkp1s4ykqTBZIkKYMAPOIi/88MA4r9
        ul3//JXcujPbA6Hgs05plqfkdg==
X-Google-Smtp-Source: ABdhPJzp5NiW4hK7picdw41X37Rb1IMy0ShXi7mmGt03dC34zZfOhHkBCRveJv0mWQpHlDFrnpMfdA==
X-Received: by 2002:a1c:730f:: with SMTP id d15mr12347734wmb.135.1615546972704;
        Fri, 12 Mar 2021 03:02:52 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:d5de:d45f:f79c:cb62])
        by smtp.gmail.com with ESMTPSA id j11sm7373970wro.55.2021.03.12.03.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 03:02:51 -0800 (PST)
Date:   Fri, 12 Mar 2021 12:02:45 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] kasan: docs: update ignoring accesses section
Message-ID: <YEtKVYVeUycUKySP@elver.google.com>
References: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
 <c0f6a95b0fa59ce0ef502f4ea11522141e3c8faf.1615498565.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0f6a95b0fa59ce0ef502f4ea11522141e3c8faf.1615498565.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 10:37PM +0100, Andrey Konovalov wrote:
[...]  
> +Other parts of the kernel might access metadata for allocated objects. Normally,
> +KASAN detects and reports such accesses, but in certain cases (e.g., in memory
> +allocators) these accesses are valid. Disabling instrumentation for memory
> +allocators files helps with accesses that happen directly in that code for
> +software KASAN modes. But it does not help when the accesses happen indirectly
> +(through generic function calls) or with the hardware tag-based mode that does
> +not use compiler instrumentation.
> +
> +To disable KASAN reports in a certain part of the kernel code:
> +
> +- For software modes, add a
> +  ``kasan_disable_current()``/``kasan_enable_current()`` critical section.

Should we mention function attribute __no_sanitize_address (and noinstr,
which just applies to any kind of instrumentation) here? Perhaps with
the note that called functions may still be instrumented, and in such
cases would require combining with kasan_{disable,enable}_current().

> +- For tag-based modes, use ``kasan_reset_tag()`` or ``page_kasan_tag_reset()``.

