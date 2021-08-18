Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098563EFA22
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 07:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237868AbhHRFen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 01:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237812AbhHRFeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 01:34:02 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB60C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 22:33:28 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id k24so1063830pgh.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 22:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tMoQn8GgqE22a95kT2T9MUT0duyCn/8LEmCKNCJyZFo=;
        b=J+sLV+tiPa32qkx1/OsnH4ufX2n2jfiG0a1/C5JyPfYE9Y5KwJ51+CD+aJRQHylCeW
         WaEiLSFc1Bg1pbEly34GABw0BLorhvxoIG7M960wEooFSSbe0aw3FRufek2ogtSyn6hy
         6yU6RiNozSR9hqREf8B0Mqw7zJfgsThFInbU++Vkuwof/Vhc2n8cWvebfGPxQCOvjIMa
         4citbn0/bosovxhelsZuUOijupOkZUgPPFcg0b7SpFFYvbORN0BA1j/JSBojGjsqUqHt
         PQ8gV/rLaOnjOOgIV7y235JsizKMi9GGWI69xuzxruvaMRxz+S3WHujuoD89N+Wt65Fb
         aB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tMoQn8GgqE22a95kT2T9MUT0duyCn/8LEmCKNCJyZFo=;
        b=ZTBs4Z+DldBSJ2B6kJrFlLY/io0CJqZjLd2OkroUlD+EfE3oqz53KFk80bHS1wZAwY
         VoYWGnxZp8zEv8j0jRk9FW6EIJxl77duIsGMVsSiFdabx9Vm855d9Omps7v895J3kXiW
         rB7bnucXNgLBbIOmtj18V050en0uOiPs2CRyaqHPtZil0br3eqBvbOVZprB7tlgl6vTW
         V+692ReqTKmj0QRXmWqK4Gf7kK7gvLmThzpQFfs96SNiKJ28KtRbjRRf4lHkL4mJHHGh
         mA59UZCiAu6CERCB+n54v3w9B0D9T0Sz9OU9zEVNCK674UGjMb3iwOhdK83ASz6rWYaT
         Vn0w==
X-Gm-Message-State: AOAM533P8MjlNpM0hP/kiYfu8+UgAY/gms5mmW0RSvzafRAyk7IbnAJv
        UxJBuGqOIvarmiKyuQdwegE+lgX93e+Hyhj4Y8pRuw==
X-Google-Smtp-Source: ABdhPJwcl2oZptZbY58B9GgwmQKrzfimZ0zykOVdtmAqRZxvRzAfp/NOW/WGmwWAyLpXb4VlZSWtYhN0GUltRfjoTvI=
X-Received: by 2002:a05:6a00:228d:b0:3e1:aba4:8e3 with SMTP id
 f13-20020a056a00228d00b003e1aba408e3mr7485738pfe.49.1629264807603; Tue, 17
 Aug 2021 22:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210817033032.76089-1-songmuchun@bytedance.com>
 <YRxtZ3X8QGv/bui5@carbon.dhcp.thefacebook.com> <CAMZfGtV4LXDmv=Gyd5bKPy-V-3a4y3R62XGXnvZyeQ_xqCabJg@mail.gmail.com>
 <YRyQNEc79Km6M9xc@carbon.dhcp.thefacebook.com>
In-Reply-To: <YRyQNEc79Km6M9xc@carbon.dhcp.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 18 Aug 2021 13:32:48 +0800
Message-ID: <CAMZfGtXFPD+P=ByLH=ZMc5858fpqhP5JY+LYUu6hYmhQ1E0NVw@mail.gmail.com>
Subject: Re: [PATCH] mm: introduce PAGEFLAGS_MASK to replace ((1UL <<
 NR_PAGEFLAGS) - 1)
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 12:44 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, Aug 18, 2021 at 12:35:08PM +0800, Muchun Song wrote:
> > On Wed, Aug 18, 2021 at 10:16 AM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Tue, Aug 17, 2021 at 11:30:32AM +0800, Muchun Song wrote:
> > > > Instead of hard-coding ((1UL << NR_PAGEFLAGS) - 1) everywhere, introducing
> > > > PAGEFLAGS_MASK to make the code clear to get the page flags.
> > > >
> > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > ---
> > > >  include/linux/page-flags.h      | 4 +++-
> > > >  include/trace/events/page_ref.h | 4 ++--
> > > >  lib/test_printf.c               | 2 +-
> > > >  lib/vsprintf.c                  | 2 +-
> > > >  4 files changed, 7 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > > > index 54c4af35c628..1f951ac24a5e 100644
> > > > --- a/include/linux/page-flags.h
> > > > +++ b/include/linux/page-flags.h
> > > > @@ -180,6 +180,8 @@ enum pageflags {
> > > >       PG_reported = PG_uptodate,
> > > >  };
> > > >
> > > > +#define PAGEFLAGS_MASK               (~((1UL << NR_PAGEFLAGS) - 1))
> > >
> > > Hm, isn't it better to invert it? Like
> > > #define PAGEFLAGS_MASK          ((1UL << NR_PAGEFLAGS) - 1)
> > >
> > > It feels more usual and will simplify the rest of the patch.
> >
> > Actually, I learned from PAGE_MASK. So I thought the macro
> > like xxx_MASK should be the format of 0xff...ff00...00. I don't
> > know if it is an unwritten rule. I can invert PAGEFLAGS_MASK
> > if it's not a rule.
>
> There are many examples of both approached in the kernel tree,
> however I'd say the more common is without "~" (out of my head).
>
> It's definitely OK to define it like
> #define PAGEFLAGS_MASK          ((1UL << NR_PAGEFLAGS) - 1)

Got it. Thanks Roman.

>
> Thanks!
