Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B06326948
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 22:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhBZVOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 16:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhBZVOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 16:14:09 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AD3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:13:28 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id b21so6960982pgk.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qtfEoqhvDCcQyVPF7DeFpyDmdnF0fDJbf85f4uUlLxM=;
        b=XcOK4eUEEAYMv/3EYh+zqAf04PURG3fljBOvjGZ6XcUF4DGuaAPGmn4p3Sh2i4umw0
         bkK6FOccxmDNK/Xz6wGqeCvw70LKefcbPmQXz6+7mp2dgsAcXhp0YwpLFxdEnhmVQtKh
         MLYJqIqSEh77UIDhSLqexm98Penen9Y0AUg9YN/iDnU5TbLM62Y+kGmKAO6bm8DH+bPP
         OkLSUqxKgIYbUsukDgZ7Kd8CccsAFIV7h2ysKScI/Os75VimsoVgFJSFqfgyj4qJUN6s
         5Zvb0RNEhEKEt4HVIKgrYIgcvGKan+kYoRPA0CGuJ3rsXyb/PSM0r5jk3cMAoOPZg4Pq
         61aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qtfEoqhvDCcQyVPF7DeFpyDmdnF0fDJbf85f4uUlLxM=;
        b=UsZpA2LUwUqzCkz9xI7Ug8CoYk4SXSwI7c0qGprSE9tpL7uv2JRFuv2jus39nYVK7n
         Ua1sJ8ptFpjWYyRvojNn3BJByw9mjih5vjNKPVP+/SQ+h6XFn39/Zl+oRCFbO4TZ0HeV
         TZK9yiVsBDmIT/avvVsi2V6GmA+5ExZQ/gGQHGFVNHvYp8dGpnx8sYSqMYGkqeQdpqFQ
         RZYa4Fd5mD4xCKKrTPDS/PpxAFJaxGVG5nKusYgQdzbGNvdo0ukB3IvB4BkYRVpseCLv
         pLuVTVMUC2XWOgzh88tV7Djr5asZpGxuGMZBEsjESJzcDV5cD/3dk2GAl+zQYI8tSWdI
         9icw==
X-Gm-Message-State: AOAM532jVmJtmafVcc4ln71H1EgqXAXaj+1gNxsDsETXdEXkgS4l9mQx
        xrxEHv6dP+dkAmyR4GchsaxOSw==
X-Google-Smtp-Source: ABdhPJymeuZ3c+LiTM4B4Vh6OYwsa9+/xQfrGfh3h1nGET+jGPRa64V9FT2ZHFopYMEHhnrYW6a7Iw==
X-Received: by 2002:a63:4d52:: with SMTP id n18mr4411963pgl.237.1614374007943;
        Fri, 26 Feb 2021 13:13:27 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:48ad:d4d0:f627:c01f])
        by smtp.gmail.com with ESMTPSA id u11sm3638376pjx.28.2021.02.26.13.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 13:13:27 -0800 (PST)
Date:   Fri, 26 Feb 2021 13:13:23 -0800
From:   Fangrui Song <maskray@google.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Scull <ascull@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] [RFC] arm64: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Message-ID: <20210226211323.arkvjnr4hifxapqu@google.com>
References: <20210225112122.2198845-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210225112122.2198845-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-25, Arnd Bergmann wrote:
>From: Arnd Bergmann <arnd@arndb.de>
>
>When looking at kernel size optimizations, I found that arm64
>does not currently support HAVE_LD_DEAD_CODE_DATA_ELIMINATION,
>which enables the --gc-sections flag to the linker.
>
>I see that for a defconfig build with llvm, there are some
>notable improvements from enabling this, in particular when
>combined with the recently added CONFIG_LTO_CLANG_THIN
>and CONFIG_TRIM_UNUSED_KSYMS:
>
>   text    data     bss     dec     hex filename
>16570322 10998617 506468 28075407 1ac658f defconfig/vmlinux
>16318793 10569913 506468 27395174 1a20466 trim_defconfig/vmlinux
>16281234 10984848 504291 27770373 1a7be05 gc_defconfig/vmlinux
>16029705 10556880 504355 27090940 19d5ffc gc+trim_defconfig/vmlinux
>17040142 11102945 504196 28647283 1b51f73 thinlto_defconfig/vmlinux
>16788613 10663201 504196 27956010 1aa932a thinlto+trim_defconfig/vmlinux
>16347062 11043384 502499 27892945 1a99cd1 gc+thinlto_defconfig/vmlinux
>15759453 10532792 502395 26794640 198da90 gc+thinlto+trim_defconfig/vmlinux
>
>I needed a small change to the linker script to get clean randconfig
>builds, but I have not done any meaningful boot testing on it to
>see if it works. If there are no regressions, I wonder whether this
>should be autmatically done for LTO builds, given that it improves
>both kernel size and compile speed.
>
>Link: https://lore.kernel.org/lkml/CAK8P3a05VZ9hSKRzVTxTn+1nf9E+gqebJWTj6N23nfm+ELHt9A@mail.gmail.com/
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For folks who are interested in --gc-sections on metadata sections,
I want to bring you awareness of the implication of __start_/__stop_ symbols and C identifier name sections.
You can see https://github.com/ClangBuiltLinux/linux/issues/1307 for a summary.
(Its linked blog article has some examples.)

In the kernel linker scripts, most C identifier name sections begin with double-underscore __.
Some are surrounded by `KEEP(...)`, some are not.

* A `KEEP` keyword has GC root semantics and makes ld --gc-sections ineffectful.
* Without `KEEP`, __start_/__stop_ references from a live input section
   can unnecessarily retain all the associated C identifier name input
   sections. The new ld.lld option `-z start-stop-gc` can defeat this rule.

As an example, a __start___jump_table reference from a live section
causes all `__jump_table` input section to be retained, even if you
change `KEEP(__jump_table)` to `(__jump_table)`.
(If you change the symbol name from `__start_${section}` to something
else (e.g. `__start${section}`), the rule will not apply.)


There are a lot of KEEP usage. Perhaps some can be dropped to facilitate
ld --gc-sections.
