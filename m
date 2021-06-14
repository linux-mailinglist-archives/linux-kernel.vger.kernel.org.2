Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C67D3A5E8D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 10:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbhFNIvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 04:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbhFNIu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 04:50:58 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFE5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 01:48:40 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id l12so5922884oig.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 01:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g5pXCAj2QuRES1o2pFYr1kobiKA7QQMUK/Q0IqCq9h8=;
        b=VWEYtLKRoyzykCKCWKAnyyeFrhGqGLwAOXy2u3vartWNSYoGumsrbuXEw3exPA57bA
         S5OQDe8cZc6Mmh2yHw/F3JzUdhVWvLB+6MNC3tQZ2Yxls847Ssku94TD0W0mWL8kDITn
         CMQUqIG/gyOF8G+UA5KZE5oeGGcu9+kgbqY8O4ICYygUfnxb2S0Y2wNlWg6fRyqj3tPg
         JZS+ZsUUEJR65v1WYyKCEuPQitf1oAilKEVRt3DPfTOBv9J9GPzt+uRK2cHF0tR/1F2N
         ndXXMhMJx2wCiryXN7Y3zvVr/hblikY3DQS/7Bn6G3redPtk55bc6+YxS4m8iiyxcUdn
         vKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g5pXCAj2QuRES1o2pFYr1kobiKA7QQMUK/Q0IqCq9h8=;
        b=TWVzpqg2MGcNF9NZrrH9YL05mP7SUxabJ7jtuQ0CgC4pPyQVdC8yU85u0J3v5I+vSm
         JyJ7TyLR6qFssxrKxxhSqX2VwIJMyH5fLxmUd8evjTRVsHgES3rgOis1DyELOe5+gBXK
         J+0SUx/bzFwhTlAHmqqo4SeQw61z7AlawIrv92RE99XVGoVA80pyo4H6nF4tA2NdUPCh
         i71ODKDl2U4l3Ffa02gfaC309wrEleMGtVAMwGzGgBT7qeYfPn3FrpkQKFOmSwbxA1QY
         5jVOXpVXbVykB0VsM2MQjraw7flEg5OinFeNruE+abZDOHFfr5CI/4XLG46Y6BF4rHa2
         vv6g==
X-Gm-Message-State: AOAM530hWwbJmzxSgd8vlxV6QFAviUwEB0L8YKF+frS5jq/D1eHrgz+3
        TmhaHmpVSv2tGBc/SAAfF4xjKeLdGflJTvjStx34hg==
X-Google-Smtp-Source: ABdhPJxqyqU5dcuuO+/JAQ+RVrrvsoRJk9Qzh/PRxas95xERvwPgPwTvMclro7vWYNOlKSzHVGjCwjK2iC5MreUI250=
X-Received: by 2002:aca:120f:: with SMTP id 15mr3849142ois.172.1623660519486;
 Mon, 14 Jun 2021 01:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210612045156.44763-1-kylee0686026@gmail.com>
 <20210612045156.44763-3-kylee0686026@gmail.com> <CANpmjNMLzxMO0k_kvGaAvzyGoyKxBTtjx4PH=-MKKgDb1-dQaA@mail.gmail.com>
 <20210612155108.GA68@DESKTOP-PJLD54P.localdomain>
In-Reply-To: <20210612155108.GA68@DESKTOP-PJLD54P.localdomain>
From:   Marco Elver <elver@google.com>
Date:   Mon, 14 Jun 2021 10:48:27 +0200
Message-ID: <CANpmjNOf8i6HPxFb3gjTrUWMh_6c4zdsh29izrSrHDi9ud4+gw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kasan: integrate the common part of two KASAN
 tag-based modes
To:     Kuan-Ying Lee <kylee0686026@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jun 2021 at 17:51, Kuan-Ying Lee <kylee0686026@gmail.com> wrote:
[...]
> > > diff --git a/mm/kasan/report_tags.h b/mm/kasan/report_tags.h
> > > new file mode 100644
> > > index 000000000000..4f740d4d99ee
> > > --- /dev/null
> > > +++ b/mm/kasan/report_tags.h
> > > @@ -0,0 +1,56 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef __MM_KASAN_REPORT_TAGS_H
> > > +#define __MM_KASAN_REPORT_TAGS_H
> > > +
> > > +#include "kasan.h"
> > > +#include "../slab.h"
> > > +
> > > +#ifdef CONFIG_KASAN_TAGS_IDENTIFY
> > > +const char *kasan_get_bug_type(struct kasan_access_info *info)
> > > +{
> > [...]
> > > +       /*
> > > +        * If access_size is a negative number, then it has reason to be
> > > +        * defined as out-of-bounds bug type.
> > > +        *
> > > +        * Casting negative numbers to size_t would indeed turn up as
> > > +        * a large size_t and its value will be larger than ULONG_MAX/2,
> > > +        * so that this can qualify as out-of-bounds.
> > > +        */
> > > +       if (info->access_addr + info->access_size < info->access_addr)
> > > +               return "out-of-bounds";
> >
> > This seems to change behaviour for SW_TAGS because it was there even
> > if !CONFIG_KASAN_TAGS_IDENTIFY. Does it still work as before?
> >
>
> You are right. It will change the behavior.
> However, I think that if !CONFIG_KASAN_TAG_IDENTIFY, it should be reported
> "invalid-access".

There's no reason that if !CONFIG_KASAN_TAG_IDENTIFY it should be
reported as "invalid-acces" if we can do better without the additional
state that the config option introduces.

It's trivial to give a slightly better report without additional
state, see the comment explaining why it's reasonable to infer
out-of-bounds here.

> Or is it better to keep it in both conditions?

We want to make this patch a non-functional change.

[...]
> > > diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> > > new file mode 100644
> > > index 000000000000..9c33c0ebe1d1
> > > --- /dev/null
> > > +++ b/mm/kasan/tags.c
> > > @@ -0,0 +1,58 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * This file contains common tag-based KASAN code.
> > > + *
> > > + * Author: Kuan-Ying Lee <kylee0686026@gmail.com>
> >
> > We appreciate your work on this, but this is misleading. Because you
> > merely copied/moved the code, have a look what sw_tags.c says -- that
> > should either be preserved, or we add nothing here.
> >
> > I prefer to add nothing or the bare minimum (e.g. if the company
> > requires a Copyright line) for non-substantial additions because this
> > stuff becomes out-of-date fast and just isn't useful at all. 'git log'
> > is the source of truth.
>
> This was my first time to upload a new file.
> Thanks for the suggestions. :)
> I will remove this author tag and wait for Greg's process advice.
>
> >
> > Cc'ing Greg for process advice. For moved code, does it have to
> > preserve the original Copyright line if there was one?

Greg responded, see his emails. Please preserve the original header
from the file the code was moved from (hw_tags.c/sw_tags.c).

Thanks,
-- Marco
