Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63B745751C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 18:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbhKSRSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 12:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbhKSRSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 12:18:47 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74801C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 09:15:45 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id n26so9899715pff.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 09:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ms77oC+QvtLAqlsepFm9oHgV4DN6qUXsSkO4qYaCRRo=;
        b=RNMyWFmyz2c2tnF9JvzahSHZKORJYKdVb3mCTQxJE/LoBLkn9rEBpHsJxLvKM2AXdl
         puy3KfNKxGgeKzpMy3wHyNV2J+gYtL1FAFnBLwxprkLxSawZ5DfQMoNyJV8y7LUatoI8
         ean9BpK8LFDhaHIDL+ERLD0yOzfHgaJXh6P5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ms77oC+QvtLAqlsepFm9oHgV4DN6qUXsSkO4qYaCRRo=;
        b=0CY9oZAGWZiKjfPcwKMxV3n+AuRX9hpVBmKb9yUvr0sqtnh73DYIQc/yvAlXek31pX
         bjhzQbzJIXruVK6O4j9NR5+opQAIIbwiX+G8JPB6EWQJzb5pFHanB8IgGYqlR0QiOeLy
         9BYbfiQ/4slGKuyBAqEA3pcPZG65WnvCFj+xNL9JTxbmQhUQD8eJN8N78pJGa6u8F7CG
         lpe2FTiGHj6TjcnM8hL1LvCICgdRvlpADsCFo/pwj+dWgp6nHmAR99oSPopZlF1OElAh
         mR5wn/nUbFAH91a3l6MSijIQuLpYYg940rzYzO/FFPpaW78oi7280JJgo4SvyF8CgG9d
         UZtw==
X-Gm-Message-State: AOAM533271IKJMSgZuEAEX9D5Bb7wGghLsVkc05jxYhjw4urO3Gf5p0z
        gh+aH0WMe/hq0nNIr7v+f1ZpXg==
X-Google-Smtp-Source: ABdhPJyTv0T5Lh5Syw2LmX6wuT2l5WrFMIqZ7Dcx1Ek92Duf30JbjnrR04sLQjf5pwG5WszhaTQqBQ==
X-Received: by 2002:a63:dc13:: with SMTP id s19mr18214369pgg.233.1637342144967;
        Fri, 19 Nov 2021 09:15:44 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w37sm226549pgk.87.2021.11.19.09.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 09:15:44 -0800 (PST)
Date:   Fri, 19 Nov 2021 09:15:43 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, mark.rutland@arm.com, will@kernel.org,
        ndesaulniers@google.com
Subject: Re: [PATCH 3/3] x86: Add straight-line-speculation mitigation
Message-ID: <202111190911.1F5CEA6DA@keescook>
References: <20211119165023.249607540@infradead.org>
 <20211119165630.334945680@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119165630.334945680@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 05:50:26PM +0100, Peter Zijlstra wrote:
> This little patch makes use of an upcomming GCC feature to mitigate
> straight-line-speculation for x86:
> 
>   https://gcc.gnu.org/g:53a643f8568067d7700a9f2facc8ba39974973d3
>   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102952
>   https://bugs.llvm.org/show_bug.cgi?id=52323
> 
> It's built tested on x86_64-allyesconfig using GCC-12 and GCC-11.
> It's also been boot tested on x86_64-defconfig+kvm_guest.config using
> GCC-12.
> 
> Maintenace overhead of this should be fairly low due to objtool
> validation.
> 
> Size overhead of all these additional int3 instructions comes to:
> 
>    text	   data	    bss	    dec	    hex	filename
> 22267751	6933356	2011368	31212475	1dc43bb	defconfig-build/vmlinux
> 22804126	6933356	1470696	31208178	1dc32f2	defconfig-build/vmlinux.sls
> 
> Or roughly 2.4% additional text.

Thanks for adding the size details. (I remain surprised it's so much.)

> [...]
>  125 files changed, 441 insertions(+), 386 deletions(-)

I wonder if this patch should be split into a few pieces:

- objtool validation
- asm macro definitions
- mechanical ret/RET replacement
- Kconfig & Makefile

Personally I'd find that much easier to review, but either way:

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

-- 
Kees Cook
