Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE5D3191B6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhBKR6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbhBKRbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 12:31:07 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C4FC06178B
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:30:24 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id a22so8289658ljp.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a0sLUNT5ihF6g2jXFc7aCUKZ679+kNYXd0ZfZV5p2dc=;
        b=dAcQsC5HYrfkZM/GE98EwdI2y0mWsIusVAq9JtSCwl3f13U/wivhWy2MzuVR4Y8+wL
         8sAq6u7NV1XDgpQWmg/11xriebzmckL/eOBPIXYjS7hUpW8GD7fpDSABx42mxfSrEskT
         K6XrCOzBiwice33qsStLWYj0WFj0i7Yxx+g1o18bujh9Hi4O7CCyv++wX7SkeEPxkOzT
         TXNH2oM36HoCELx8+qIF0MKMuOTIrSVlgIdqgtgBAy5ViRy1AMglX633EvHsk0FxOwY2
         J3eW7BTDgxmsK3+kITJb+JBAxXqIF7uJTKOaGnrh18sy3YlzctuDtZuT+OxlQrEtHJR5
         lRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a0sLUNT5ihF6g2jXFc7aCUKZ679+kNYXd0ZfZV5p2dc=;
        b=YukzpXjTPb0MP+Y0v+m5ryqqZKqbSOmSpTTRAFIVeHZQ6nrEiPcx8HK5lt3mcAY/+2
         096weTmV3SMi5YYWraV5dDox5Be1DWLWORcwADGk8hM2/bq9/q1K7ZYqkxcvKWqcUOJm
         qAR1jTlmK64Pn35WRSBCjS+P1NoDpD69dfDtUqwFG5uvT/pIGHDPO7JYhR71YnzgBLJo
         dypR1J/SY2kL/B+7poRg7xBP6Vr0pMFlSb0gJO+P1Pl3taZQmBjbcPZ9FNzEtFtn21Ns
         UN42PuQcNYUZ3MtJRQctK+GK+nXHRKL2fHOS/YG3tebJzZDzrNYIptB4JizXOuevnadf
         YyrQ==
X-Gm-Message-State: AOAM530KKxSmOLhDev+HJmVwR05nV9SezsS8hh9RU7CWVgHF9oGm88rc
        fJpnwnxWHtpEELp8eZJOXkk5zNTsN/g40fryj+pF4g==
X-Google-Smtp-Source: ABdhPJzJII1LCTkHS23ScyYW8lJwDEJ68Mx8ChMjGfa1JLZXX7P66uGIoUR5RgRI/nLWC1bpECVT27hN4PFJDk+uMKg=
X-Received: by 2002:a05:651c:233:: with SMTP id z19mr5391008ljn.486.1613064622185;
 Thu, 11 Feb 2021 09:30:22 -0800 (PST)
MIME-Version: 1.0
References: <dd36936c3d99582a623c8f01345f618ed4c036dd.1612884525.git.andreyknvl@google.com>
 <20210209170255.GG1435@arm.com> <20210209104515.75eaa00dea03175e49e70d6c@linux-foundation.org>
In-Reply-To: <20210209104515.75eaa00dea03175e49e70d6c@linux-foundation.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 11 Feb 2021 18:30:10 +0100
Message-ID: <CAAeHK+wuvYDhswWp3VZ+C8uDUVjsZgssWQYnP7CzuoUDgr6=bg@mail.gmail.com>
Subject: Re: [PATCH mm] arm64: kasan: fix MTE symbols exports
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 9, 2021 at 7:45 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 9 Feb 2021 17:02:56 +0000 Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> > On Tue, Feb 09, 2021 at 04:32:30PM +0100, Andrey Konovalov wrote:
> > > diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> > > index a66c2806fc4d..788ef0c3a25e 100644
> > > --- a/arch/arm64/kernel/mte.c
> > > +++ b/arch/arm64/kernel/mte.c
> > > @@ -113,13 +113,17 @@ void mte_enable_kernel(void)
> > >     sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
> > >     isb();
> > >  }
> > > +#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
> > >  EXPORT_SYMBOL_GPL(mte_enable_kernel);
> > > +#endif
> > >
> > >  void mte_set_report_once(bool state)
> > >  {
> > >     WRITE_ONCE(report_fault_once, state);
> > >  }
> > > +#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
> > >  EXPORT_SYMBOL_GPL(mte_set_report_once);
> > > +#endif
> >
> > Do we actually care about exporting them when KASAN_KUNIT_TEST=n? It
> > looks weird to have these #ifdefs in the arch code. Either the
> > arch-kasan API requires these symbols to be exported to modules or not.
> > I'm not keen on such kasan internals trickling down into the arch code.

Understood.

> > If you don't want to export them in the KASAN_KUNIT_TEST=n case, add a
> > wrapper in the kasan built-in code (e.g. kasan_test_enable_tagging,
> > kasan_test_set_report_once) and conditionally compile them based on
> > KASAN_KUNIT_TEST.

This might be a better approach indeed.

> In other words, the patch's changelog was poor!  It told us what the
> patch does (which is often obvious from the code) but it failed to
> explain why the patch does what it does.
>
> The same goes for code comments, folks - please explain "why it does
> this" rather than "what it does".

I'm sorry, Andrew.

Could you please drop the "arm64: kasan: export MTE symbols for KASAN
tests" patch from the mm tree (but keep the rest of that series)?

I'll post a separate patch with a fix.

Thanks!
