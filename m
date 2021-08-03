Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE803DF128
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 17:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbhHCPNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 11:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbhHCPNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 11:13:10 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA82BC061757;
        Tue,  3 Aug 2021 08:12:58 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id p145so19741390ybg.6;
        Tue, 03 Aug 2021 08:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0MA4yBUv23BbJVAOn10I0A8H8/n6Yml4qJZDjujIkSo=;
        b=JjNxfdKHLCtFD2XS5K70ZXQA2WcJLb5IdcPen4uyEfQUBbimCjc171tfxZeYtP8rM4
         W9ZQg3+D+c81v3CGYG7ucquebzCRHerHH57GzrfHk1wx3KwcRf4KYl7iW0Y7hqH/f2yM
         s5FZcMsUo6tS4xeHdOwu9fUh0HRZH5bmNgcDsASGJ3zsGXSFfd5uEEv06J7Btj/OEz6B
         rNrGMnqAykS8PGrxzAAkX+eTBi5aZ87b3C0OXAs2KyndgwKGaO1IjkaEJu5tC0vmcGdI
         C0F6dweKUaDb/wqnP48Fxj+h4GmLm3pRWDpHPGgMvDmr9k81fuCq6T47L4XfkvWMSIZL
         zfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0MA4yBUv23BbJVAOn10I0A8H8/n6Yml4qJZDjujIkSo=;
        b=lz2DsAw8cIouHxgFkixv3irzu0uBVZQwoVEFsOdww01kMnKqIzjgVndrFaygw6vUbf
         o4CMkCG7U1m6VhHjKGzbiLuGQEFcSxbE+3+4VejrDq3CrZEuWxM43f+6sQPwK6n794r6
         LyMeCB0Ur0LOHeBX0e+hwOJfBkGX7+cyPmpvHq6r/G3ZYJFIF9H6eO2IExR/jiiMpvCC
         kI56guRT0SNcO4TkFudMl7nknFbBvMBxkkQCp3mvSK2qQoZkZ1+LdwbDCUQtF626w+zP
         QcV0VXOvrEOlsnnJoUC96j4Vevcku6wQ2Cvq1ZhHBan721EQ8pgR8VRP16rrfzfYc/Fp
         T9uQ==
X-Gm-Message-State: AOAM533lGBPtTQy+xK2JDfM628Pk2vBb2jVZdsrJQJ3ntag3OFkaZWK7
        WOlxVoIKjsjge/vZPSST8mVRPgpBkHNbNBuyjBs=
X-Google-Smtp-Source: ABdhPJxLLhOuge4lnR2ARgHXuM36tY3HcPDFl47HIWEO4m4676WjV7JTLeLnfVbbWsXbk5W2gMxOcuEvnlYqvQJpYLA=
X-Received: by 2002:a25:3046:: with SMTP id w67mr29095940ybw.134.1628003578010;
 Tue, 03 Aug 2021 08:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210803113531.30720-1-lukas.bulwahn@gmail.com> <f9074e8d-9314-9d7d-7bf5-5b5538c8be8d@intel.com>
In-Reply-To: <f9074e8d-9314-9d7d-7bf5-5b5538c8be8d@intel.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 3 Aug 2021 17:12:47 +0200
Message-ID: <CAKXUXMxQ83T7beOTuZ928=-eo2Tsr94TGxsaYh3+MHOJrDO8Bg@mail.gmail.com>
Subject: Re: [PATCH 0/9] Kconfig symbol clean-up on ./arch/x86/
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Lubomir Rintel <lkundrak@v3.sk>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 4:32 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 8/3/21 4:35 AM, Lukas Bulwahn wrote:
> >   - a reference to STRICT_IOMEM in arch/x86/mm/init.c
> >     unclear to me: which exact config this refers to
>
> Are you referring to the reference in this comment?
>
> > +       /*
> > +        * This must follow RAM test, since System RAM is considered a
> > +        * restricted resource under CONFIG_STRICT_IOMEM.
> > +        */
> > +       if (iomem_is_exclusive(pagenr << PAGE_SHIFT)) {
> > +               /* Low 1MB bypasses iomem restrictions. */
> > +               if (pagenr < 256)
> > +                       return 1;
> ...
>

Yes, that is what I referred to.

> That came from here:
>
> > commit a4866aa812518ed1a37d8ea0c881dc946409de94
> > Author: Kees Cook <keescook@chromium.org>
> > Date:   Wed Apr 5 09:39:08 2017 -0700
> >
> >     mm: Tighten x86 /dev/mem with zeroing reads
>
> Which also added this hunk:
>
> >  #ifdef CONFIG_STRICT_DEVMEM
> > +static inline int page_is_allowed(unsigned long pfn)
> > +{
> > +       return devmem_is_allowed(pfn);
> > +}
>
> and talks about CONFIG_STRICT_DEVMEM in the changelog:
>
> >     mm: Tighten x86 /dev/mem with zeroing reads
> >
> >     Under CONFIG_STRICT_DEVMEM, reading System RAM through /dev/mem is
> >     disallowed. However, on x86, the first 1MB was always allowed for BIOS
> ...
>
> It's a pretty safe guess that STRICT_IOMEM refers to CONFIG_STRICT_DEVMEM.

Thanks, Dave.

If the maintainers consider updates to comments making them consistent
with the code as worth being picked, I will turn your analysis into a
proper commit message and provide a patch to update that comment.

Lukas
