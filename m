Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9281402EDF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346033AbhIGTRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345371AbhIGTRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:17:48 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA51C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:16:41 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id j12so222879ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 12:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1fpdy3b2qMHUETeuDFTFbKg8FYwDRtrIQO5YjCA4iis=;
        b=gvtqQqQ0P76l17nNx5gKAZmX9q0gXmkKiJplZ5GrV0Rp5D/GmeTFvutVYxXDmohdU0
         Rg7GZWtGpo79LRFlloX9NBLbD7hga1UGVHT5sYVxcyx+e++dSBWbGFVZEFJrEiiMD80f
         lT+vaaeWPC4g7dOg7Pm63HBqJdzPD3ESYM7uY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1fpdy3b2qMHUETeuDFTFbKg8FYwDRtrIQO5YjCA4iis=;
        b=o3A6TKkh0FTz8r/MUKxKKXx6oaKPxam82mjo2We8RDMNNjRLpWtIBnC6A6gihPJLz8
         pKDLUIy/3uxt3PhOyUijXRQWDN+4FdpuabIlhJRRhCvVSfoWnwU6ljvXMakc8gtxTmmO
         zkBMbW7YuwnkrVRXKfS5VXyKcExoKJd6P6l6hVB0EppwUowCdJF/agr1ANuJssMbSQkZ
         7+mjuGehLFgKXwUO41R9QPN2Tl0G5elw7U+EiINblLIQLir8kZvIbMZ8bfCRxeGpIQ40
         E6cDSTnQhNqSRHNsEOZY//tplw9ld7U5/zHHnDFA4mkhlgSSRzGRXzj20asO+mhI8S9V
         Quuw==
X-Gm-Message-State: AOAM532LFKzq7MmZ8DkeQURIOnBgFWZ4MOgiYqZRr/o56dl7JziP4WMQ
        6G6ibN4FBN+ctkE8RVOPd8S/MfRcIbYgsmm6Zz4=
X-Google-Smtp-Source: ABdhPJyNSeGHSy1Ni507W/x8kxKZ5D89a3nezXbH4vCAtBceA0HojbwdedR7fd8EasinUIo/JVUi1g==
X-Received: by 2002:a2e:7603:: with SMTP id r3mr15607854ljc.98.1631042199452;
        Tue, 07 Sep 2021 12:16:39 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id x8sm216200lfq.183.2021.09.07.12.16.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 12:16:38 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id l10so72403lfg.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 12:16:38 -0700 (PDT)
X-Received: by 2002:a05:6512:3da5:: with SMTP id k37mr14175340lfv.655.1631042198154;
 Tue, 07 Sep 2021 12:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210907183843.33028-1-ndesaulniers@google.com>
In-Reply-To: <20210907183843.33028-1-ndesaulniers@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Sep 2021 12:16:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=whJOxDefgSA1_ojGbweRJGonWX9_nihA-=fbXFV1DhuxQ@mail.gmail.com>
Message-ID: <CAHk-=whJOxDefgSA1_ojGbweRJGonWX9_nihA-=fbXFV1DhuxQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "Enable '-Werror' by default for all kernel builds"
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     llvm@lists.linux.dev,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-toolchains@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vipin Sharma <vipinsh@google.com>,
        Chris Down <chris@chrisdown.name>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 11:39 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> The above commit seems as though it was merged in response to
> https://lore.kernel.org/linux-hardening/CAHk-=wj4EG=kCOaqyPEq5VXa97kyUHsBpBn3DWwE91qcnDytOQ@mail.gmail.com/.

No. It was merged in response of _years_ of pain, with the last one
just being the final drop.

I'm not going to revert that change. I probably will have to limit it
(by making that WERROR option depend on certain expectations), but
basically any maintainer who has code that causes warnings should
expect that they will have to fix those warnings.

If it's clang that generates bogus warnings, then we'll have to start
disable clang warnings. The clang people tend to be proud of thir
fewer false positives, but so far looking at things, I am not
convinced.

And I'm most definitely not convinced when the "let's finally enable
-Werror after years of talking about it", people end up going "but but
but I have thousands of warnings".

That's the POINT of that commit. That "but but but I have thousands of
warnings" is not acceptable.

I spent hours yesterday getting rid of some warnings. It shouldn't be
on me fixing peoples code. It shouldn't be on me noticing that people
send me crap that warns.

And it really shouldn't be "Linus cares about warnings, so
configurations that Linus doesn't test can continue for years to have
them".

My "no warnings" policy isn't exactly new, and people shouldn't be
shocked when I then say "time to clean up *YOUR* house too".

            Linus
