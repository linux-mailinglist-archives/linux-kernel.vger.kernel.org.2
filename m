Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15A23AD82C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 08:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhFSGmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 02:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbhFSGmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 02:42:02 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F25C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 23:39:51 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 13-20020a17090a08cdb029016eed209ca4so7197383pjn.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 23:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7O6NiC7BTr3eVGuJkmQkcqtgkrwhWl7/Qlj0XvSRQpU=;
        b=Tq/B3MqqSOHiSwlMSBlAYi++SRSc0W8ikCH4QbmMFDYjnsnF22a3XeZ0jTtKi9GMwL
         dAOvvYOsSTxeljnKvWyRuOtiKvrOILA38Nzmja/VETR1+9l32dEWcfmzTa8tvq3+KAe2
         DafAfJEyu1ZEbj7Vl6kbIORMFPKB/JhDDwAm5v7f2h+x7KFEzFK9WQsR2A54xoZS4ZUz
         zIYPkgP747yuEaCG6WxGqiAYqW6uQlg/MDPQkThdkibUlDkiRhPiEhZ+XxtTUtUWiQG8
         CZIdc8EztIAJpu1pH4/WYBUPCMTa3CwEFD7rbw7S5UQkGlSNxJpMQxehLkcR3hFflZIL
         iS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7O6NiC7BTr3eVGuJkmQkcqtgkrwhWl7/Qlj0XvSRQpU=;
        b=tp52qHZz6djC+778k4Scw8Mr/NKmws9s02CYNTFmRCmNzcMISkr0hohJrH3bfYaU3U
         9stos8n1GFiJzZbXRNoFGfhWvqErcdSqT8GUCEbFEL84uGrThGRsAlqKf4ls8hiqXFH3
         kleLfr8yKgxyvXXoIcFN4mKvRu0FkHpFgCAgjGctlilb/cWX7y+LjozUFRRWiiuXEls4
         jrb+MkV/PRQ0RwEvcm4cWXolnC9X6IbDHuEEVxOljGWbqTI0pet2Vo4YUNGJ/bFDwCkX
         KCnSWCEcT9+iJYfK7RqP9In4U8jmmFG7zK/wS0Mk+2nGUfSBD0CWQ+lhvaP70VfBL8bG
         sN+w==
X-Gm-Message-State: AOAM530q7bGAejmd1GNWkvwSn5S3HrWuI5XAy3g1O1VGvZLXLKlL2DZJ
        EANPhG8LD3y9Nh1+1oIK5Ew=
X-Google-Smtp-Source: ABdhPJxymPRDpLaqkWmfArMf2I2OcRGRdxq6Ivh+KwifQhr+qlmJY0IfXNXv54VL/yc69EXfxgbunw==
X-Received: by 2002:a17:902:9a8c:b029:113:d891:2eaf with SMTP id w12-20020a1709029a8cb0290113d8912eafmr8117146plp.61.1624084791379;
        Fri, 18 Jun 2021 23:39:51 -0700 (PDT)
Received: from DESKTOP-PJLD54P.localdomain (122-116-74-98.HINET-IP.hinet.net. [122.116.74.98])
        by smtp.gmail.com with ESMTPSA id t13sm3566599pfq.173.2021.06.18.23.39.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jun 2021 23:39:50 -0700 (PDT)
Date:   Sat, 19 Jun 2021 14:39:42 +0800
From:   Kuan-Ying Lee <kylee0686026@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v2 2/3] kasan: integrate the common part of two KASAN
 tag-based modes
Message-ID: <20210619063942.GA67@DESKTOP-PJLD54P.localdomain>
References: <20210612045156.44763-1-kylee0686026@gmail.com>
 <20210612045156.44763-3-kylee0686026@gmail.com>
 <CANpmjNMLzxMO0k_kvGaAvzyGoyKxBTtjx4PH=-MKKgDb1-dQaA@mail.gmail.com>
 <20210612155108.GA68@DESKTOP-PJLD54P.localdomain>
 <CANpmjNOf8i6HPxFb3gjTrUWMh_6c4zdsh29izrSrHDi9ud4+gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOf8i6HPxFb3gjTrUWMh_6c4zdsh29izrSrHDi9ud4+gw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 10:48:27AM +0200, Marco Elver wrote:
> On Sat, 12 Jun 2021 at 17:51, Kuan-Ying Lee <kylee0686026@gmail.com> wrote:
> [...]
> > > > diff --git a/mm/kasan/report_tags.h b/mm/kasan/report_tags.h
> > > > new file mode 100644
> > > > index 000000000000..4f740d4d99ee
> > > > --- /dev/null
> > > > +++ b/mm/kasan/report_tags.h
> > > > @@ -0,0 +1,56 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +#ifndef __MM_KASAN_REPORT_TAGS_H
> > > > +#define __MM_KASAN_REPORT_TAGS_H
> > > > +
> > > > +#include "kasan.h"
> > > > +#include "../slab.h"
> > > > +
> > > > +#ifdef CONFIG_KASAN_TAGS_IDENTIFY
> > > > +const char *kasan_get_bug_type(struct kasan_access_info *info)
> > > > +{
> > > [...]
> > > > +       /*
> > > > +        * If access_size is a negative number, then it has reason to be
> > > > +        * defined as out-of-bounds bug type.
> > > > +        *
> > > > +        * Casting negative numbers to size_t would indeed turn up as
> > > > +        * a large size_t and its value will be larger than ULONG_MAX/2,
> > > > +        * so that this can qualify as out-of-bounds.
> > > > +        */
> > > > +       if (info->access_addr + info->access_size < info->access_addr)
> > > > +               return "out-of-bounds";
> > >
> > > This seems to change behaviour for SW_TAGS because it was there even
> > > if !CONFIG_KASAN_TAGS_IDENTIFY. Does it still work as before?
> > >
> >
> > You are right. It will change the behavior.
> > However, I think that if !CONFIG_KASAN_TAG_IDENTIFY, it should be reported
> > "invalid-access".
> 
> There's no reason that if !CONFIG_KASAN_TAG_IDENTIFY it should be
> reported as "invalid-acces" if we can do better without the additional
> state that the config option introduces.
> 
> It's trivial to give a slightly better report without additional
> state, see the comment explaining why it's reasonable to infer
> out-of-bounds here.
> 
> > Or is it better to keep it in both conditions?
> 
> We want to make this patch a non-functional change.
>

Got it.

> [...]
> > > > diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> > > > new file mode 100644
> > > > index 000000000000..9c33c0ebe1d1
> > > > --- /dev/null
> > > > +++ b/mm/kasan/tags.c
> > > > @@ -0,0 +1,58 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * This file contains common tag-based KASAN code.
> > > > + *
> > > > + * Author: Kuan-Ying Lee <kylee0686026@gmail.com>
> > >
> > > We appreciate your work on this, but this is misleading. Because you
> > > merely copied/moved the code, have a look what sw_tags.c says -- that
> > > should either be preserved, or we add nothing here.
> > >
> > > I prefer to add nothing or the bare minimum (e.g. if the company
> > > requires a Copyright line) for non-substantial additions because this
> > > stuff becomes out-of-date fast and just isn't useful at all. 'git log'
> > > is the source of truth.
> >
> > This was my first time to upload a new file.
> > Thanks for the suggestions. :)
> > I will remove this author tag and wait for Greg's process advice.
> >
> > >
> > > Cc'ing Greg for process advice. For moved code, does it have to
> > > preserve the original Copyright line if there was one?
> 
> Greg responded, see his emails. Please preserve the original header
> from the file the code was moved from (hw_tags.c/sw_tags.c).

Ok. I will do it in v3.
Thanks.

> 
> Thanks,
> -- Marco
