Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A5043174F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 13:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhJRLbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 07:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhJRLbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:31:34 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7DBC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 04:29:23 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id o184so3794108iof.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 04:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1fgJvh7+bSF88TXWBTb/Xbqee/xjp/eoCpakVfL7f8k=;
        b=pWR+cmdqQ1S+sZU5CD0esrs+zcURncs679mesQuijLeN5ded7WKFnBdG6+Zg0WRwWH
         ND5pVMDMpWqUmmY7di1XpHqH5GYUsEBIoRAiH1NMma73ilsx+FCbZdHGcCiyRbwQloKr
         paVmuDod1wt3S/koS4qg5EOE5n1YxbIGSjpEaZc7+VWGk4sPlk4hL0uKXdl8y31mZs49
         lcfQcmsgPagPDiNsjXCtnN8CS+Vul4hjVYSLxCwgTmBjkQ8BRv+l2UsN7tm0cLO16LRg
         Ap2wS5iZ/LZcE2a14sFwD5tR0IgWMTX41D4JoNec53D7pHb6F3dceerygigbOfT8juNz
         aGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1fgJvh7+bSF88TXWBTb/Xbqee/xjp/eoCpakVfL7f8k=;
        b=MmXSqasVo+6mjq4PYKagIIwmhwekLhWNcz2SPr10lKz/WsiPoz9R4Ytdu2g/c5JcT+
         cb3gItZfWqbBTuA31AXrIxedIXufaZPzPxLIwhDN15Wpf7yeSM8Uhbmz76VyEzcNjpuD
         kQW9f+FQj7/x/4pfN6VwnKYFGtzyCHcrufpYDTR4MZ99V8wwnG9NxB9PzFUnF4EMBqFP
         jf6vuy8H3kh/VeqyuheaqssH1aN5CZ74UbKhTb27pGeow3nkmCihyzzDsR6hRm3JF0fP
         GnOEdrx3p5jAMbod9C2i22Js4hzF7HyxfG5xFtcaLWDlPHXHj+yKBC28Yf20ML7Ho8dN
         ptGw==
X-Gm-Message-State: AOAM532GETO8QLp+iOeMEBTdZmOEJRuX7t0Q8UVBA+1IP3R1OtllsFPA
        3/77GLEcDmxFZHj0NDYtqMDfqu7rRQomGxGb91o=
X-Google-Smtp-Source: ABdhPJyKHIqYxcEDOJxIFDZU83YefWRmmA+KsfpFKY2bNjgfLFOxQC2TZSNcX1Hug3OgkqMQa0rCxachvW80MfZnTWE=
X-Received: by 2002:a02:9149:: with SMTP id b9mr17887225jag.46.1634556562990;
 Mon, 18 Oct 2021 04:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
 <20211014033414.16321-1-jiangshanlai@gmail.com> <CAKwvOd=znqwGT_FmUPbWPodjrnFHf+FtHMaYCTfvUeukBCM3xw@mail.gmail.com>
 <CANiq72k7E2ahWoFQWSUo6CWNd7iWVh-5sdqtTQ=5JPTHN_tzyw@mail.gmail.com> <8d2f0a4f-80e0-36c1-9421-d2c1af282a12@linux.alibaba.com>
In-Reply-To: <8d2f0a4f-80e0-36c1-9421-d2c1af282a12@linux.alibaba.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 18 Oct 2021 13:29:11 +0200
Message-ID: <CANiq72kkk6-eN3hN7OfSA5r03df42j7pAueMZurY_rTvq518Dw@mail.gmail.com>
Subject: Re: [PATCH V3 06/49] compiler_types.h: Add __noinstr_section() for noinstr
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 11:16 AM Lai Jiangshan <laijs@linux.alibaba.com> wrote:
>
> I will use __section(section) in the updated patch.
>
> I don't know whether it is worth for a new version for a relatively large patchset
> with almost 50 patches since the feedback becomes less or I should wait for more
> reviews from the x86 maintainers.  Especially the second half of the patchset which
> is all about IST exceptions has no feedback since V2.

Yeah, what I meant by independent patch is that you may avoid worrying
about that fix within the series, and send it as a completely
different patch (we can also do it for you, if you prefer). It is,
after all, not really related to either this commit nor the series.

Cheers,
Miguel
