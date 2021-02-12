Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8ADC31A70E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 22:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhBLVpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 16:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhBLVpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:45:43 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E95C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 13:45:03 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id d2so378182pjs.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 13:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9lL2r/Ey+YYeyZvvoc/iJkTezo+Dg1gXvxnIcJaEP3o=;
        b=fqnpY2LTk6Zsf/0+gk4cZNkiRQa9ox4GWv28mE+3MrRnQ3ZfHCbkJ1FsxOJDLTbT/5
         lg9DkNp9poT4rzBrcie54CgkuC7jJqbLnaq7nFUbUdzH3BR3e1wVi47kGPALDqvFui+8
         RJPGrCqA73nJPeDsR7aVEBjJiBTbIiiEp/h1vApnRiXRvOorZdPU7ILlBfC2SwCsYH0g
         U3jo/lC0FDaJYub6uo3nZM6RlUQKi1Y3EXmNWh1F/3xLZwbJShTWqVi6iOcMtwVIzbQV
         n7LCOHzPzAjDZAySpkXtBLiTQ4Hrc2OqXVRDbkAt/BsheLfj05oNw7kRfY+6Yfgv0P6u
         sWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9lL2r/Ey+YYeyZvvoc/iJkTezo+Dg1gXvxnIcJaEP3o=;
        b=PkwFcOOuqrh5POFvvbgBkyzFfxWPGYZHwWDINUpyjaJXlPv1XIKM8Pc12hA0e85uf1
         5JAR2DTQNWG84ZYFtIq8PWa4a56v8vQioJ76NKJXPuG8n8PawTBpbDI7AEfB+dKdhfy5
         D1GD+8dzof4i7kptQmrtWqykGs+bTVaVNvthbPfWXNPxdw3FGFsO2g7xu1dVaNjNlg1T
         orRp2dRhNuRgHxiOmelouy+40hdRewMBkP76nxHsDnK5fmpLSVt0za8Q6WyoYRCF51pJ
         nwpq/BEbr2CPuzyTzhvKkhwkqQeD4M1JA7WAm/Fq5iH2Ysj9xG1Dt60NvR93SE9lp/fA
         12Dw==
X-Gm-Message-State: AOAM5320YcwYbiQroy70w+ga8gr7pVSMoskTwv0ri3h8Cm6xK8TuVMJq
        oWRHodX+RlNi4y9F16LiRuYiXU9NngKKHW89sN2/+w==
X-Google-Smtp-Source: ABdhPJwyl+sxMWegLYDQ55g4lZZv0FZ3/Rem6ATplzDrdLDGYqj6dgJfwqJBcasJRBNRT461MnZoqxbrUTWKz0ycL/o=
X-Received: by 2002:a17:90a:9ac:: with SMTP id 41mr4510715pjo.136.1613166302591;
 Fri, 12 Feb 2021 13:45:02 -0800 (PST)
MIME-Version: 1.0
References: <20210211153353.29094-1-vincenzo.frascino@arm.com>
 <20210211153353.29094-8-vincenzo.frascino@arm.com> <20210212172224.GF7718@arm.com>
In-Reply-To: <20210212172224.GF7718@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 12 Feb 2021 22:44:51 +0100
Message-ID: <CAAeHK+zg5aoFfi1Q36NyoaJqorES+1cvn+mRRcZ64uW8s7kAmQ@mail.gmail.com>
Subject: Re: [PATCH v13 7/7] kasan: don't run tests in async mode
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 6:22 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, Feb 11, 2021 at 03:33:53PM +0000, Vincenzo Frascino wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Asynchronous KASAN mode doesn't guarantee that a tag fault will be
> > detected immediately and causes tests to fail. Forbid running them
> > in asynchronous mode.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > ---
> >  lib/test_kasan.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> > index f8c72d3aed64..77a60592d350 100644
> > --- a/lib/test_kasan.c
> > +++ b/lib/test_kasan.c
> > @@ -51,6 +51,10 @@ static int kasan_test_init(struct kunit *test)
> >               kunit_err(test, "can't run KASAN tests with KASAN disabled");
> >               return -1;
> >       }
> > +     if (kasan_flag_async) {
> > +             kunit_err(test, "can't run KASAN tests in async mode");
> > +             return -1;
> > +     }
>
> I think we have time to fix this properly ;), so I'd rather not add this
> patch at all.

Yeah, this patch can be dropped.

I have a prototype of async support for tests working. I'll apply it
on top of the next version Vincenzo posts and share the patch.

Vincenzo, when you post the next version, please make sure you rebase
on top of the mm tree version that includes "kasan: export HW_TAGS
symbols for KUnit tests" (linux-next/akpm doesn't yet have it).
