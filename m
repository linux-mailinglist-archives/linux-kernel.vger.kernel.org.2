Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773C63A6E42
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 20:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbhFNSeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 14:34:44 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:41960 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbhFNSen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 14:34:43 -0400
Received: by mail-pg1-f169.google.com with SMTP id l184so9352589pgd.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 11:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=eUF3264n62uzUx9rkiqoGBgY8xRBhVB4mGb1+HtIFno=;
        b=p2qfgkHVAUcNCcVaw8o15PttnsGmEc4NbgHzJ4iU9HjbUbK3b17aa9O3Q8Ymz9Zvh0
         QCJfajhVb+1IbWEco/A76rayHh8+fv6vyPyMqPSIG6LcHu/iLr174pVGGoVH9cTqKwjh
         X1Pdcf4zrhn4sDqs1W2bNyP6ZnBd9pUvuthvfVSbO32qacF9Lo9ljNkSo/VYelmFngNO
         kPKEvxVQ67tLG9+uAnv3ELuyp6NVV58VL4pami2Secxv/sV0gR5ya2OFUwm57COXAQni
         KvB0antOZjNttjvpq8R4R4+cs16tIxPEk8OP56WJo/5LsUh9PyrmsSPKetAS9l6nVKmn
         xV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=eUF3264n62uzUx9rkiqoGBgY8xRBhVB4mGb1+HtIFno=;
        b=fZmcihxGWRNN404kh/AVx1rh8eZnpYI1TgA1zzl8ilb672DumenJEh6MN+hSibZXy3
         FRpAqNvi35l+QwIGDnaCN3nSr21p6xOXv0TAn1h3R1apkE28gQpn0fHUslKWlIy5aEQP
         xP+i4lqafYK52cAGByGFSfP13OHWmRAGnyqF+W/CMok1kACaLzuFA9IkqugWwCWqkdFR
         6+0WXr1kmlbVmRX6h+eF1NkWLZrxoqscoIp2ESo6tdt4K0A6emPlsGO3A+uHeoKD2CW2
         bNzb5yQHKHqeqRGoF2enGX4/VpdqmDqYrfT0ZOCSaT/a2hXHIyTXomLo9/u+gkqtlbiu
         +wng==
X-Gm-Message-State: AOAM533W08Il3C81uUldovr2wir13XOvhGFWZxtRoU8pPzk5H6iAyzus
        AfwX9BSurPTG4givmCiQXCNA6w==
X-Google-Smtp-Source: ABdhPJyYyGilLV3nxlj/fXaG6XZCNTSqT7ydEX13p72NSsbR9qF6qKiZlLFKY7EQqdm2FJRt6M8ULg==
X-Received: by 2002:a63:2f05:: with SMTP id v5mr18202741pgv.449.1623695500521;
        Mon, 14 Jun 2021 11:31:40 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:bf8f:9f62:a11c:7829])
        by smtp.gmail.com with ESMTPSA id b21sm10815125pgj.74.2021.06.14.11.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 11:31:40 -0700 (PDT)
Date:   Mon, 14 Jun 2021 11:31:35 -0700
From:   Fangrui Song <maskray@google.com>
To:     Peter Zijlstra <peterz@infradead.org>, ndesaulniers@google.com
Cc:     x86@kernel.org, oberpar@linux.ibm.com,
        linux-kernel@vger.kernel.org, johannes.berg@intel.com,
        nathan@kernel.org, keescook@chromium.org, elver@google.com,
        mark.rutland@arm.com
Subject: Re: [PATCH] gcov,x86: Mark GCOV broken for x86
Message-ID: <20210614183135.hfuaowojnq4alo44@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKwvOdmPTi93n2L0_yQkrzLdmpxzrOR7zggSzonyaw2PGshApw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Jun 14, 2021 at 9:20 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Jun 14, 2021 at 09:05:04AM -0700, Nick Desaulniers wrote:
> > > On Mon, Jun 14, 2021 at 3:17 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > >
> > > > As recently discovered, there is no function attribute to disable the
> > > > -fprofile-generate instrumentation. As such, GCOV is fundamentally
> > > > incompatible with architectures that rely on 'noinstr' for correctness.
> > >
> > > Is there context for comment, or is this patch meant as a joke?
> >
> > Only if you think recursion in exception entry code is funny.
> >
> > noinstr *MUST* disable any and all compiler generated instrumentation,
> > currently it that isn't the case for -fprofile-gnerate, nor
> > -fprofile-arc.
> >
> > Look for all the fun we had with KCOV back then. Luckily KCOV
> > instrumentation was trivial to patch out using objtool, so that's what
> > x86 is currently doing.
> >
> > Luckily both compilers grew a __no_sanitize_coverage recently and we no
> > longer have to rely on objtool fixing up the compiler output for much
> > longer.
> >
> >   https://lkml.kernel.org/r/20210527194448.3470080-1-elver@google.com
> >
> > Now all we need is one more such attribute to kill -fprofile-* stuff.
> 
> __attribute__((no_instrument_function)) is already wired to not emit
> calls to mcount()/fentry().  I think extending it to also apply to
> coverage (-fprofile-arcs) and instrumentation based profiling
> (-fprofile-generate) is reasonable.

__attribute__((no_instrument_function)) seems specific to
-finstrument-functions.  Somehow -pg uses it as well. The name may not be
generic, so it may be odd to exclude various instrumentations (there are a ton)
under this generic attribute.

I'd like to understand the definition of notrace and noinstr.

With value profiling disabled, clang -fprofile-generate/gcc -fprofile-arcs
don't add function calls. They just increment a counter in a writable section.
Why isn't that allowed for noinstr functions?

I can understand why -fpatchable-function-entry= is excluded: -fpatchable-function-entry=
causes the section __patchable_function_entries and the kernel may change the nops into call
instructions. And a function call may not be suitable for certain functions.
But I don't understand why incrementing a counter should be disallowed.
