Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5737C41004E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 22:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbhIQUcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 16:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhIQUb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 16:31:59 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8656CC061574;
        Fri, 17 Sep 2021 13:30:36 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id p24so10689336vsg.0;
        Fri, 17 Sep 2021 13:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DRfdtzIjDxzUKkdHhPK2760DU2hKEPxerMtTWBC6Qi8=;
        b=UGTkVasKUcEJcoMUHNmvJQxalvNu4TdrKDNFJZY7W6XAIySyXZPWFr94yeHT/zhbd+
         SldGXkce/BFUQyRAVvSlRBOu0L2L1ctpFa30dEApZtH2ZxFQdm/CfrEgYNxkH4KbObv8
         2bQ+BmLBJ2rUNtb1hHsqj+COKjG/rHBo9dScJ5V5wahGod+/FMrSCkLWmxtdua6vdhFf
         I/CE01zFdcdFYqaM/jbP4vXUSj5i74ygLJEGnTMGk0eMWv+M6CePlPfuo6596xTw+xL2
         SUNBhezuQXblX1afA3BB68xgSyW+BkM14hRdHK5tM0seGLe1mpE0zjsfRg0s5TnKszb0
         Siyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DRfdtzIjDxzUKkdHhPK2760DU2hKEPxerMtTWBC6Qi8=;
        b=sDZ/Vf83meyv6p3fgiAZsfIro+0EiA/MJsgjW62qYlzcUFTCWn8SqCRITH0/Yh5ZtE
         kxqAlAXubKmTqVyu5UROQqXa8zD/8EB5Z6sK55DlfnQeoXCjtjGnWZgTZq1mATz02JLP
         PIqnEEhm+NR0KTKwdLszXLrRTyULx0Ft0kr2RVzG+6rGWa3WxQNGI42I2lb0w2hdHlgF
         XX8uj38S+mZpofSUJRdlNJQAyXX2VdqaoBlNMC4zJM8sjn8eAekfMO/RqMLh9GVwxAE0
         ad+CALKm6PlxWeanuGq57/B/uHiCNnQ/PYlD67WZ9CRqA/TxOtInNVU+bHcnvTv6vDvb
         gQsg==
X-Gm-Message-State: AOAM5330PpVeVZDK5HrbyD9VA+MpOyfd9BfP4H8Qh91hRQS6MYDgwX5A
        jIuhyM/Lc262wAPi+zOyQUb9GAisXL2NcOEaQcI=
X-Google-Smtp-Source: ABdhPJx40RoI4+/ZG75rCSCO+3hgIs47xfnC7dB9UtBEmeDks2LVW1xZyhVj7nS/hvmN3Cp3RDP8mN8M2+CV7mR8TVk=
X-Received: by 2002:a67:2f52:: with SMTP id v79mr3570530vsv.53.1631910635043;
 Fri, 17 Sep 2021 13:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210913222440.731329-1-ahalaney@redhat.com> <20210913222440.731329-4-ahalaney@redhat.com>
 <ff05cae4-8fa7-d1b6-795e-3bd85316774d@akamai.com>
In-Reply-To: <ff05cae4-8fa7-d1b6-795e-3bd85316774d@akamai.com>
From:   jim.cromie@gmail.com
Date:   Fri, 17 Sep 2021 14:30:09 -0600
Message-ID: <CAJfuBxzrJwr17-RWZzhw90pKXZ1hL5kepuzvt1Di=JyekMJf4A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] Documentation: dyndbg: Improve cli param examples
To:     Jason Baron <jbaron@akamai.com>
Cc:     Andrew Halaney <ahalaney@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 1:50 PM Jason Baron <jbaron@akamai.com> wrote:
>
>
>
> On 9/13/21 6:24 PM, Andrew Halaney wrote:
> > Jim pointed out that using $module.dyndbg= is always a more flexible
> > choice for using dynamic debug on the command line. The $module.dyndbg
> > style is checked at boot and handles if $module is a builtin. If it is
> > actually a loadable module, it is handled again later when the module is
> > loaded.
> >
> > If you just use dyndbg="module $module +p" dynamic debug is only enabled
> > when $module is a builtin.
> >
> > It was recommended to illustrate wildcard usage as well.
> >
> > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > Suggested-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> >   Documentation/admin-guide/dynamic-debug-howto.rst | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
> > index d0911e7cc271..4bfb23ed64ec 100644
> > --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> > +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> > @@ -357,7 +357,10 @@ Examples
> >     Kernel command line: ...
> >       // see whats going on in dyndbg=value processing
> >       dynamic_debug.verbose=1
> > -    // enable pr_debugs in 2 builtins, #cmt is stripped
> > -    dyndbg="module params +p #cmt ; module sys +p"
> > +    // Enable pr_debugs in the params builtin
> > +    params.dyndbg="+p"
>
> If we are going out of our way to change this to indicate that it works
> for builtin and modules, it seems like the comment above should reflect
> that? IE, something like this?
>
> '// Enable pr_debugs in the params module or if params is builtin.
>

I dont think params can be a loadable module, so its not a great
example of this.
it should be one that "everyone" knows is usually loaded.

conversely, bare dyndbg example should have only builtin modules,
then the contrast between 2 forms is most evident.


> The first two patches look fine to me, so if you agree maybe just
> re-spin this one?
>
> Thanks,
>
> -Jason
>
> > +    // enable pr_debugs in all files under init/
> > +    // and the function pc87360_init_device, #cmt is stripped
> > +    dyndbg="file init/* +p #cmt ; func pc87360_init_device +p"
> >       // enable pr_debugs in 2 functions in a module loaded later
> >       pc87360.dyndbg="func pc87360_init_device +p; func pc87360_find +p"
>
