Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4FC93FF266
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 19:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346701AbhIBRgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 13:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbhIBRgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:36:44 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30CCC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 10:35:45 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id c6so1862852pjv.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 10:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8Ymrvxc+hOIJEGSWo3PUPAKMd1JsWIvPvJEfp5+X584=;
        b=H/8pdIIe2TBQtfzQRnD7oYYk7jZaKgWznptGmMoVViWuM4xi2OPba5RRw8tIlP4HLh
         pNtIMQIsm8tvC1BUfhiVb6ELjbNHTZ8SHKOFsQNy+nvMBSqnEGUur4fb9NC8g7gQVBnJ
         9C6mbdBxZJpOO6aB6a2T3EEbImeayvDHeYEK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Ymrvxc+hOIJEGSWo3PUPAKMd1JsWIvPvJEfp5+X584=;
        b=J9iWQ0m+N232+9zSTEaYfN2BfzdNkAac8krRXPxIE9lZ2l+Yy14WV/6MQ2S4xi4p7m
         CDSM04O9SHhDWG2UUlyKYXNAZXlIDSxXLKT61jLg9ax2Vorg9zdNJWHSB41jy7ofkOHM
         xmvU+DcPmkgIysT7KbU8vaod+eC+rVEdPQM3CgtqXVBLk3/pAF47XMHhPAU1fLrHLoZP
         c/kwxXjfYLYUwr6L1cyLUehkPsTcRCfoTzMjeN+i6K/ebtNa/Z0S/tld0JsI14jcaPYX
         HL3Q5w2uTiXRtiV8utt03M4phGRI4ouLMG1GZ5xj7P1YyJHENKHtR9DtZPcM5W9rlcWt
         sFWA==
X-Gm-Message-State: AOAM533HLC+T3KZdNE8nQXgb7crxNER3WCA+VYAk5PPGjS1aH73XKLZY
        svk4OjbPSCJvGva50g98vPDesw==
X-Google-Smtp-Source: ABdhPJzqW728qM+O5agUjW9liMw4UajwMKdfYWX+2N+wdB0IvIs9YiCLR8LqFwmYvukT66jzbiMAMw==
X-Received: by 2002:a17:90a:c89:: with SMTP id v9mr5176880pja.175.1630604145196;
        Thu, 02 Sep 2021 10:35:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v8sm2848868pjh.24.2021.09.02.10.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 10:35:44 -0700 (PDT)
Date:   Thu, 2 Sep 2021 10:35:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Keith Packard <keithp@keithp.com>, linux-kernel@vger.kernel.org,
        Abbott Liu <liuwenliang@huawei.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Jens Axboe <axboe@kernel.dk>, Jian Cai <jiancai@google.com>,
        Joe Perches <joe@perches.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Maninder Singh <maninder1.s@samsung.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vaneet Narang <v.narang@samsung.com>,
        "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Keith Packard <keithpac@amazon.com>
Subject: Re: [PATCH 0/2]: ARM: Enable THREAD_INFO_IN_TASK
Message-ID: <202109021034.1FA93D2@keescook>
References: <20210902155429.3987201-1-keithp@keithp.com>
 <20210902165353.GI22278@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902165353.GI22278@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 05:53:53PM +0100, Russell King (Oracle) wrote:
> On Thu, Sep 02, 2021 at 08:54:26AM -0700, Keith Packard wrote:
> > Placing thread_info in the kernel stack leaves it vulnerable to stack
> > overflow attacks. This short series addresses that by using the
> > existing THREAD_INFO_IN_TASK infrastructure.
> > 
> > As this is my first patch in this part of the kernel, I'm looking for
> > feedback about the general approach as well as specific comments on
> > places where I've missed something.
> > 
> > I've only run this on armhf running under qemu, so while I've tried to
> > make patches for other code paths, I haven't been able to test those.
> > 
> > (yes, I know checkpatch.pl complains about whitespace in asm-offsets.c, I
> > decided to leave the existing whitespace alone)
> > 
> > Signed-off-by: Keith Packard <keithpac@amazon.com>
> 
> I think you're introducing a circular dependency with this for
> certain kernel configurations:
> 
> E.g. Have you tried running this with CONFIG_CPU_V6 enabled?
> 
> +#define raw_smp_processor_id() this_cpu_read(cpu_number)
> +#define __smp_processor_id() __this_cpu_read(cpu_number)
> +
> +DECLARE_PER_CPU_READ_MOSTLY(unsigned int, cpu_number);
> 
> this_cpu_read() is defined as:
> 
> #define this_cpu_read(pcp) __pcpu_size_call_return(this_cpu_read_, pcp)
> (which will call this_cpu_read_4)
> 
> #define this_cpu_read_4(pcp)            this_cpu_generic_read(pcp)
> => __this_cpu_generic_read_nopreempt()
> =>         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));
> 
> #define raw_cpu_ptr(ptr)                                                \
> ({                                                                      \
>         __verify_pcpu_ptr(ptr);                                         \
>         arch_raw_cpu_ptr(ptr);                                          \
> })
> 
> #ifndef arch_raw_cpu_ptr
> #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
> #endif
> 
> #ifndef __my_cpu_offset
> #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
> #endif
> 
> ... which then leads back to a use of raw_smp_processor_id(), thereby
> creating a circular loop of preprocessor definitions that the compiler
> can't resolve.

If this isn't easy to fix, perhaps this can be a V7-only feature?

-- 
Kees Cook
