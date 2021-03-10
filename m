Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7D9334B99
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbhCJW33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbhCJW31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:29:27 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E818AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:29:26 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id o10so12354670pgg.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M1LQocdyrILdN3y2ftG88hya3R5bASNZBW6DmO/mx8w=;
        b=rRAmlYnwokFCMZCfoI41jeWTl58ratOsNSgKi9c2hJ4iln8AOVIAJ1+sWavIS+bF9F
         RNOplYoZJCumLg3mMmS5S4WrbITN/O4aM04wtiU6Qz6YkQsLI0wt/IeoUK5gv+P/fya5
         bBUBJ450uOGclJLMkLxutYWB/fEU3nJq+32Dia7+h4lbgtaxaaHz28VRIWPclkq29NC+
         BtIusP4jp19RDVX3/94PKsfLZK53vRlitB2aaxPhIKHyLsrK6rJRZtDGSl/LufXIYep8
         nz41na5a5VlyNaQ5NZHTo/NFqcoQA8LcEXueAQLmQHr6xurHFzhRZbLkEAsEHVKBGHsa
         TJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M1LQocdyrILdN3y2ftG88hya3R5bASNZBW6DmO/mx8w=;
        b=P3wn1LeznKPSXX+dtwujZQ3JIWOdwfRL+AokuD4qbNgXiAkW+uxBHlA39g81wctRPE
         GojQnOpjBX3D6OluYB1zfaAgbvTms8LZfbQZG7ygXPSEHZSxpfByyLmzbB3M+ilI0NBh
         xB5XSgNQviEes0DHU4LF4HRNVUVWHlWLYv+Autv1o3PiO9nMz51tLylLzY2Xih9Z9TNO
         vOr+SCkh8SF6mnQrxnYQfc3h8eQmw32KI6IkRakkEK4qtyFHLjX7oI3zs3+LfUns99MS
         n31L+L9TXN02ac2DDHA5raNXGZ+mPeBYnEcuEImZWL9AV7uBxO/SkaKbwrCRnwV4cz8u
         nDSg==
X-Gm-Message-State: AOAM532V3wtfTzKPB0xoiGxjlhQJBMy7qqdSIF/oPWMK7YL2ZMWthWW5
        B2ADR2hd5lcExboIAl6owY6snQ==
X-Google-Smtp-Source: ABdhPJwpjGZgnpdrKpm/0s9dytIZYfRa0f6S1OLEGLXaeGLYa/sHF51cyL2rnC+D4J9/KhIpJB2jrQ==
X-Received: by 2002:a63:170e:: with SMTP id x14mr4600946pgl.245.1615415366310;
        Wed, 10 Mar 2021 14:29:26 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:6ded:c9f:3996:6bc8])
        by smtp.gmail.com with ESMTPSA id j21sm450003pfc.114.2021.03.10.14.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:29:25 -0800 (PST)
Date:   Wed, 10 Mar 2021 14:29:21 -0800
From:   Fangrui Song <maskray@google.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Scull <ascull@google.com>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        David Brazdil <dbrazdil@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] [RFC] arm64: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Message-ID: <20210310222921.t7tf7cjr7po5dlay@google.com>
References: <20210225112122.2198845-1-arnd@kernel.org>
 <20210226211323.arkvjnr4hifxapqu@google.com>
 <CAK8P3a2bLKe3js4SKeZoGp8B51+rpW6G3KvpbJ5=y83sxHSu6g@mail.gmail.com>
 <1614559739.p25z5x88wl.astroid@bobo.none>
 <CAK7LNATUSJ5T6bs-aA3sMQgXKWfcyWJLDfhmteBhQ5FuUR52Zg@mail.gmail.com>
 <CAK8P3a3yF+JV3+Xq5QtD_59JqxA7akz=u=0t05Gv-isHD9Kv4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK8P3a3yF+JV3+Xq5QtD_59JqxA7akz=u=0t05Gv-isHD9Kv4A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-10, Arnd Bergmann wrote:
>On Wed, Mar 10, 2021 at 9:50 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>> On Mon, Mar 1, 2021 at 10:11 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>> > Excerpts from Arnd Bergmann's message of February 27, 2021 7:49 pm:
>
>>
>> masahiro@oscar:~/ref/linux$ echo  'void this_func_is_unused(void) {}'
>> >>  kernel/cpu.c
>> masahiro@oscar:~/ref/linux$ export
>> CROSS_COMPILE=/home/masahiro/tools/powerpc-10.1.0/bin/powerpc-linux-
>> masahiro@oscar:~/ref/linux$ make ARCH=powerpc  defconfig
>> masahiro@oscar:~/ref/linux$ ./scripts/config  -e EXPERT
>> masahiro@oscar:~/ref/linux$ ./scripts/config  -e LD_DEAD_CODE_DATA_ELIMINATION
>> masahiro@oscar:~/ref/linux$
>> ~/tools/powerpc-10.1.0/bin/powerpc-linux-nm -n  vmlinux | grep
>> this_func
>> c000000000170560 T .this_func_is_unused
>> c000000001d8d560 D this_func_is_unused
>> masahiro@oscar:~/ref/linux$ grep DEAD_CODE_ .config
>> CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION=y
>> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y
>>
>>
>> If I remember correctly,
>> LD_DEAD_CODE_DATA_ELIMINATION dropped unused functions
>> when I tried it last time.

--gc-sections drops unused sections.
If the unused function is part of a larger section which is retained due to other symbols (-fno-function-sections),
the unused section will be retained as well.

>>
>>
>> I also tried arm64 with a HAVE_LD_DEAD_CODE_DATA_ELIMINATION hack.
>> The result was the same.
>>
>>
>>
>> Am I missing something?
>
>It's possible that it only works in combination with CLANG_LTO now
>because something broke. I definitely saw a reduction in kernel
>size when both options are enabled, but did not try a simple test
>case like you did.
>
>Maybe some other reference gets created that prevents the function
>from being garbage-collected unless that other option is removed
>as well?
>
>         Arnd

I believe with LLVM regular LTO, --gc-sections has very little benefit
on compiler generated sections. It is still useful for assembly generated sections
(but most such sections are probably needed):

* Target specific optimizations can drop references on constants (e.g. `memcpy(..., &constant, sizeof(constant));`)
* Due to phase ordering issues some definitions are not discarded by the optimizer.

For ThinLTO there are more compiler generated sections discarded by `--gc-sections`:

* ThinLTO can cause a definition to be imported to other modules. The original definition may be unneeded after imports.
* The definition may survive after intra-module optimization. After imports, a round of (inter-module) IR optimizations after `computeDeadSymbolsWithConstProp` may make the definition unneeded.
* Symbol resolution is conservative.

Regarding symbol resolution, symbol resolution happens before LTO and LTO happens before --gc-sections. The symbol resolution process may be conservative: it may communicate to LTO that some symbols are referenced by regular object files while in the GC stage the references turn out to not exist because of discarded sections with more precise GC roots.

(I've added the above points to my https://maskray.me/blog/2021-02-28-linker-garbage-collection#link-time-optimization )
