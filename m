Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841C234B704
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 13:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhC0MIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 08:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhC0MIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 08:08:42 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C96CC0613B1;
        Sat, 27 Mar 2021 05:08:42 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z3so8087939ioc.8;
        Sat, 27 Mar 2021 05:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=XuEnKOn4+9ajla2twdMRKW9Wun88ZLfU/3trClmSCoQ=;
        b=gwVPvOT99yclo1Ia7pfeoFRmDhWhtrfGrNmkzynzPS/aHVVmaHMI+NykIZHj0+Vvqy
         /rPZv9d1DKzK7sYR9zERhqocl4zU+4K0r2kiZSzKsXTKvExr0/4uIUMpkvyAKviXV9DW
         iV2WahO+QRM5BRhJeor+reLYyiHkPsvGSSCA4vBEotrBG9TH8zhMdLfpJSoIHc5EO1qG
         3eBULtBBY+jOFydGFTKOZZ+EdQWMFhCA8nQhfBShLJ8sSgvbYvICvu/NBBKNdFkz+mFo
         gh9+CyCa/rQQo7RzZWzxv6P3KjE0931+CVgEUhAMAu6zNS7peOWrgq/TaCxBeLVXT/nB
         lqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=XuEnKOn4+9ajla2twdMRKW9Wun88ZLfU/3trClmSCoQ=;
        b=oHsBRssoZG7jBj9SN2YjtvF85IaR86q4AtH3xcJl7tKViRz7B6ZiyoS/f4d0CJZ8Rs
         hXbdbHeQEZ25g2GeRpgyfEA1tSwB3umi3bQgX4VSzBfxvOf0++pWeOR2PqAVzNJh1tVT
         4IPa1HO0e4MaMz/0yw3TeUmLipcG7v1bQAIh8ZjPkzLcIakIzLXGQuZsc5I1/D78uGZg
         OnEL5+c4YPGGQqxzYUYZZ+B1xKOwezLDY/TKsjy2CzqTFZ7pGldGQvmdKZvjze2KDokZ
         trPSriLItwEQe8Onsz+iCHb7rOT0KyV/EPiKu06Kgh6PFRdoDQGPDIS5gAO1EcpqeozY
         Ld5g==
X-Gm-Message-State: AOAM533MIT1E+VuFzltBF6JIUhPu2eqGxuIQn9YXV2xBxpE/3EmPDjXX
        U+iMc0oJlBbcBGR+pCvj/z8OTHeBigcVnojezHGhPq7bwFF8DA==
X-Google-Smtp-Source: ABdhPJzscjYk8NNV3FAKg5ptEnsSyh0G7HsVhfJ6jzoKd6dXrqSgYw1S0yUClL5RcfrIpr0/eGugR4UZhavtBzO6WcI=
X-Received: by 2002:a6b:d80d:: with SMTP id y13mr13948614iob.75.1616846921761;
 Sat, 27 Mar 2021 05:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUVEkA6+5d3NGy7_G8eiaPvJkO_JCAX=XQwT1qpiGkLMWw@mail.gmail.com>
 <20210313121541.GC16144@zn.tnic> <CA+icZUXrJHHDNOC+DAcr9iw4MXn5cBDj-JrDkxeumk978Gtdcg@mail.gmail.com>
 <20210313124919.GD16144@zn.tnic> <CA+icZUWXuknBMdxTQXjJH2JiOgZbWcbk1U=dk6Zp2FgygU5Nyg@mail.gmail.com>
 <20210313132927.GF16144@zn.tnic> <CA+icZUWTSo2vkQO_tRggDFvvF_Q6AdzhvhQvmAsNxKnpGXHi0Q@mail.gmail.com>
 <CA+icZUXLyFqq0y_GnKca8MS4wO2kcj4K-D1kBHLa8u_pnLZ7eQ@mail.gmail.com>
 <YE+i/VWITCCb37tD@hirez.programming.kicks-ass.net> <CA+icZUWQ1kH6muAQbNuVAPj4Cn=8ssDAJfYLKht8ezAgJKWApA@mail.gmail.com>
 <YE/cMeO+oC/5JEC6@hirez.programming.kicks-ass.net> <CA+icZUXko_Nxh-9_qgjMYyGsh8E1rj2cWmQh0OHjuZECMZxp6Q@mail.gmail.com>
In-Reply-To: <CA+icZUXko_Nxh-9_qgjMYyGsh8E1rj2cWmQh0OHjuZECMZxp6Q@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 27 Mar 2021 13:08:05 +0100
Message-ID: <CA+icZUXu7ZNdrv6gTFCRri1ReF2e_87mX5D3Sex7tN+0GBpJ1Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86: Remove ideal_nops[]
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        rostedt@goodmis.org, hpa@zytor.com, torvalds@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        jpoimboe@redhat.com, alexei.starovoitov@gmail.com,
        mhiramat@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Out of curiosity I tried in my build-environment and my testing-rules
to have comparable numbers...

..without passing "V=1" and "KBUILD_VERBOSE=1" as make-options:

NOTE: Identical linux-config plus LLVM/Clang v12.0.0-rc3.

debian-5.10.19 as host-kernel:
11655.755564957 seconds time elapsed

dileks-5.12-rc3 plus x86-nops as host-kernel:
11941.439350080 seconds time elapsed

I compared the build-times only:
Approx. 04:45 [mm:ss] in the worst case.
( Brewing time of a strong Turkish tea-bag ~5mins. )

I will keep both make-options to see what's going on in my builds.

- Sedat -
