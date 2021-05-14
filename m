Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938D9380869
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhENLY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhENLY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:24:57 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F322C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 04:23:45 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id s20-20020a4ae9940000b02902072d5df239so3797789ood.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 04:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nrX7Y1hC+nFf54KNExFqPzRBO4yUoXGtLaJKecZ8/sc=;
        b=byJy0nDw+WqgW95ExtKsQ3rg4UBjy6ux1T+CdQOIMFWLD/q77VMDkIQzPsl8dKRHtB
         lMyKc2AAkRlOi2ap5m3knKT/qSP4z3UE/vxEDoITO6/Lm2I6GQZ2x/SsmXiQD7n6Cckd
         8F2cfgXHxHW+BOI30xx4Q5Kqrp+UkkpvdJ6AXTOr5T+KCPBWc+EhZyzrKPoSTe2k/CLo
         NH0tSRxv35Q2AtmFgb0RYrxWR9mjEw031AcJDkweApN7ZRZEcQW6N8ecN8XKUidTkv+z
         oKdUyAlddLAuzXIOGKa8xts9Ync8onDKKYRoBEXvnlL2kM79kZuK8mmr/FMZ/Y88CGOE
         2HoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nrX7Y1hC+nFf54KNExFqPzRBO4yUoXGtLaJKecZ8/sc=;
        b=k5ZzNukYYIXelWfxlFfuan2odpkgcWSjMpwVP7ntFJropAbRvPW3SXykrW3GMVHIAV
         Bz+FL01UqpWxoY32vvTuoYFuIohB9hEq5hC36+fVvwxAAAGdWQ92oJsCITK9QjIpzFLp
         z+BUsK4KnAhmV+uLmOL6Ag2XTJo9LciMM2LdJdeHEiGm7VsyA1yi008RQwd8gFyxk7PB
         00YJWqFybvy+LIJJKlbxObnCY7WvghLxUeo1FyzelPFbPt0RnOTzw5WHO2tQarqIPjuY
         GIRi50RpKs3blZ+S++11engDn//Vi+7Vi4LQVVBIwosT3VahgkhoJOLV04vUqpe+mcVA
         DK1Q==
X-Gm-Message-State: AOAM530DCEZTVSY3z0AlnIjKfn5Wc9nNrEqQYxwDT/iSBWAzWvkhaEFu
        OF3b/4+57131senqeioqSlv9bosKbNO9oRR5Wqpxx2RQsMG/gA==
X-Google-Smtp-Source: ABdhPJxN9zAXrJF7szxVELtHZSUJpP1auywZkOn9A+9bbNFFbAQ4SxlmG+ypTQ71KahM/fH50SXIy2UML/dkQsSARs0=
X-Received: by 2002:a4a:6202:: with SMTP id x2mr35903358ooc.36.1620991424458;
 Fri, 14 May 2021 04:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210514092139.3225509-1-svens@linux.ibm.com> <20210514092139.3225509-2-svens@linux.ibm.com>
 <CANpmjNNB=KTDBb65qtNwrPbwnbD2ThAFchA1HSCg9HKETkQvCg@mail.gmail.com> <yt9dfsypinlk.fsf@linux.ibm.com>
In-Reply-To: <yt9dfsypinlk.fsf@linux.ibm.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 14 May 2021 13:23:33 +0200
Message-ID: <CANpmjNPAS5kDsADb-DwvdFR9nRnX47-mFuEG2vmMPn5U3i3sGQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kfence: add function to mask address bits
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 at 13:03, Sven Schnelle <svens@linux.ibm.com> wrote:
>
> Marco Elver <elver@google.com> writes:
>
> >> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> >> index e18fbbd5d9b4..bc15e3cb71d5 100644
> >> --- a/mm/kfence/core.c
> >> +++ b/mm/kfence/core.c
> >> @@ -50,6 +50,11 @@ static unsigned long kfence_sample_interval __read_mostly = CONFIG_KFENCE_SAMPLE
> >>  #endif
> >>  #define MODULE_PARAM_PREFIX "kfence."
> >>
> >> +unsigned long __weak kfence_arch_mask_addr(unsigned long addr)
> >> +{
> >> +       return addr;
> >> +}
> >
> > I don't think this belongs here, because it's test-specific,
> > furthermore if possible we'd like to put all arch-specific code into
> > <asm/kfence.h> (whether or not your arch will have 'static inline'
> > functions only, like x86 and arm64, or not is up to you).
> >
> > Because I don't see this function being terribly complex, also let's
> > just make it a macro.
> >
> > Then in kfence_test.c, we can have:
> >
> > #ifndef kfence_test_mask_address
> > #define kfence_test_mask_address(addr) (addr)
> > #endif
> >
> > and then have it include <asm/kfence.h>. And in your <asm/kfence.h>
> > you can simply say:
> >
> > #define kfence_test_mask_address(addr) (.........)
> >
> > It also avoids having to export kfence_test_mask_address, because
> > kfence_test can be built as a module.
>
> Ok, i'll change my patch accordingly. Thanks!

Sounds good. Also please add a brief comment on top of the
"kfence_test_mask_address" part in kfence_test, like "/* May be
overridden by <asm/kfence.h>. */" -- we have something similar in
mm/kfence/report.c. Also, I think we want to call the macro
"arch_kfence_test_address" -- the "mask" part is very much
arch-dependent, and might not even be a mask on some other weird
hypothetical architecture.

Thanks,
-- Marco
