Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06353AD62C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 01:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbhFRXym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 19:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbhFRXyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 19:54:41 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B701C061767
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 16:52:28 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id pf4-20020a17090b1d84b029016f6699c3f2so1763010pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 16:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3QYcwvtyhPnU4XufKlxXAbadnyn0yvfQI9M4GTCqOZc=;
        b=cPWHs2b8m52BLZv7t3tqRbKyB9koU8IBShogTCNe8qX3i2zUvDaiwjUXulMd1ZUCPG
         cyQpL+ovwPpT1u7E04n2hxuP7GXYtcFNFxH9lnpykwL/IUzXZE4Wm0IMFBST2on5ZHPp
         HTSMSMuLbTFMiAUKrtAwuBTjXROUp89Bxf9OwMgbrYyS0A0l74O0jJwIUWr/Rspfgkrl
         cbTcOKVfxnCRZdLfmT7bQmscPIVq1R8uJHW7AWBkdcyXmpbN4kdOR1ET+nttQr8oIT8/
         hn/4oBYYRnHQyU6Af9CEtlGl64Y6sR+79s4pdnxLoXhE1MVUmy+yI3BjLaJge4PSyb/H
         fBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3QYcwvtyhPnU4XufKlxXAbadnyn0yvfQI9M4GTCqOZc=;
        b=dKO76Vd5uIKoJkl19l4DJiLfr8vthWnZF/Ctw8MXnD2HRMNrzJtZRDuJ51cpinIeM8
         XT5kUFLRxNcQZJU6pAFGgjrkq/EskYdzvL0U746D9Q/xBQWTNh2aFfuBRF1V8bE8TJzu
         sqoJq+4Ryz4tzKJTCmdsxtbz9ovkDihNmp50c0XVAeP1ANcGoh0szjL4jWZ+KKWX4I2l
         LFVRIUSYOQ6x+7kSx0/tqr4q25+xQvaBshe3Upgu4dLELXZuCEAwilm21iss7TPBj7Ho
         mpNYB85yxtQyK3YFO4qac0MG6O9j70zGMeEJn0a3Hd3aOPLRgfjcJMQApoMtMMeql2Pr
         Ta9g==
X-Gm-Message-State: AOAM530OCArL7dzTSeLwJ/YHsz1lPquNX+sP4FXrWgEciVYJeMVC24Ji
        gx+DFcFn3cjpv6M+CMvVSkDEBw==
X-Google-Smtp-Source: ABdhPJxkmDEDb99V5Rag5bSuyb8OzH3uPgagDn2It+ROt3XsV+7Qz1fE4DIvkZKbvuXxca1yWN9nTg==
X-Received: by 2002:a17:90b:1946:: with SMTP id nk6mr6004677pjb.86.1624060347511;
        Fri, 18 Jun 2021 16:52:27 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:7718:8bff:acab:aa6b])
        by smtp.gmail.com with ESMTPSA id x22sm8897487pjp.37.2021.06.18.16.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 16:52:26 -0700 (PDT)
Date:   Fri, 18 Jun 2021 16:52:22 -0700
From:   Fangrui Song <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Bill Wendling <wcw@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Martin Liska <mliska@suse.cz>, Marco Elver <elver@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        johannes.berg@intel.com, linux-toolchains@vger.kernel.org
Subject: Re: [PATCH 0/2] no_profile fn attr and Kconfig for GCOV+PGO
Message-ID: <20210618235222.s6l552hpkbfod6sv@google.com>
References: <20210618233023.1360185-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210618233023.1360185-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-18, Nick Desaulniers wrote:
>When we say noinstr, we mean noinstr.  GCOV and PGO can both instrument
>functions. Add a new function annotation __no_profile that expands to
>__attribute__((__no_profile__)) and Kconfig value
>CC_HAS_NO_PROFILE_FN_ATTR.
>
>Base is
>https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=for-next/clang/pgo.
>
>Nick Desaulniers (2):
>  compiler_attributes.h: define __no_profile, add to noinstr
>  Kconfig: CC_HAS_NO_PROFILE_FN_ATTR, depend on for GCOV and PGO
>
> include/linux/compiler_attributes.h | 12 ++++++++++++
> include/linux/compiler_types.h      |  2 +-
> init/Kconfig                        |  3 +++
> kernel/gcov/Kconfig                 |  1 +
> kernel/pgo/Kconfig                  |  3 ++-
> 5 files changed, 19 insertions(+), 2 deletions(-)
>
>
>base-commit: 4356bc4c0425c81e204f561acf4dd0095544a6cb
>-- 
>2.32.0.288.g62a8d224e6-goog
>

Thanks for the attribute work in clang and kernel! Hope we can use clang
PGO in 5.14...  (I am a casual contributor to clang PGO/coverage)
