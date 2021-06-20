Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB1A3ADD46
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 07:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhFTFnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 01:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhFTFmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 01:42:55 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576B4C061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 22:40:43 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id r16so20150828ljk.9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 22:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kod/UNIt91aPIUpImt44CWWa4ugThLpApxbuRLL0+7M=;
        b=HxQmiAwolvOOCAFhZH4PveJiF99ozmwNPXW17rsO1vMb1y0ZQ603tVOzKjw00NvzZa
         2LM9zAnAfOXXvZdr9xsP9rYCNe0pri0CvlAv128Lkf/xPrYpSabohnMo97Rekvmf7CR2
         bUb2feK6qchwNWAahoXkCY6W8OVBp78JfuMhnzgbHYDyxpSY1TnPMdfwxhb4UEVcSgp2
         tvik6eUxl1gHRBUgvOAJzFblKOiYDTVKO6NsdqGJ+d25vpmBl1oRrZrL9/8znkmoIq2d
         FXWNpFV2arRn9BkpyfcTIM3+kBUfnoMkz01jcg0O6rvXA7pKI+kvxwgik+87Qc3RuIiI
         PySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kod/UNIt91aPIUpImt44CWWa4ugThLpApxbuRLL0+7M=;
        b=hpXAYcJznSXwDkhm6KQhYW6D21oPxM+UeYrxQAyO7aPly6wc0uqQlzFtXQs7ZIIl5k
         uo+dkbXy1wCfDhuctc0UOgHzLmh/Hqinsbpz3zlziggkWiFrjOLsxrNjO+kNenOH2K1m
         qfeMoM3h7dgHEyulNmaelDS5fOWmUQmrM6Ex4gH5O9IkrMeLPHeQi9h47VDx13q16+B2
         64LlAaM8hwdZWO8+ERJEGvsH6jGBa0j49zR1JN2gIri72XiT6WGX0GxQKlYU/DVK9cqj
         BVsZ+DE2Thscw02ayKowbKPnj18t0ifCvJ8aaKT5HTre185DGYG87HWBOMOIqlwc40/M
         SiWA==
X-Gm-Message-State: AOAM533aOXjBcE/d6h3R5MsfU08+LAGbEEvlKor3B85F+eWwrqMmarST
        FjQw//0wgglMyMibhDses6JcSKl5kKzxAv465VeuvQ==
X-Google-Smtp-Source: ABdhPJyuEwk4Qge8Qj6DCnv4dmfDyubmVhvY95dEz+TwKadvaYxzLyNUpHpB9dr7F4QezXWVF7bT0AgZsWjPSTi4O6g=
X-Received: by 2002:a2e:9152:: with SMTP id q18mr16368345ljg.493.1624167641761;
 Sat, 19 Jun 2021 22:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210617071027.60278-1-hexin.op@bytedance.com> <CAE-0n51T9ZGADCk6LaKJdnQwPvMCawSvjwUP+AF0hFohAFom0A@mail.gmail.com>
In-Reply-To: <CAE-0n51T9ZGADCk6LaKJdnQwPvMCawSvjwUP+AF0hFohAFom0A@mail.gmail.com>
From:   =?UTF-8?B?5L2V6ZGr?= <hexin.op@bytedance.com>
Date:   Sun, 20 Jun 2021 13:40:30 +0800
Message-ID: <CACKzwjkjO6mbzx4wB_JzaP=qumw=LOpGjfDiUyLJyz1TVeUkGA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] debugobjects: add missing empty function debug_object_active_state()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Boyd <swboyd@chromium.org> =E4=BA=8E2021=E5=B9=B46=E6=9C=8819=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=881:03=E5=86=99=E9=81=93=EF=BC=9A
>
> Quoting Xin He (2021-06-17 00:10:27)
> > All other functions are defined for when CONFIG_DEBUG_OBJECTS
> > is not set.
> >
> > Signed-off-by: Xin He <hexin.op@bytedance.com>
> > ---
> >  include/linux/debugobjects.h | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/include/linux/debugobjects.h b/include/linux/debugobjects.=
h
> > index 8d2dde23e9fb..af0d73d8d29b 100644
> > --- a/include/linux/debugobjects.h
> > +++ b/include/linux/debugobjects.h
> > @@ -99,6 +99,9 @@ static inline void
> >  debug_object_free      (void *addr, const struct debug_obj_descr *desc=
r) { }
> >  static inline void
> >  debug_object_assert_init(void *addr, const struct debug_obj_descr *des=
cr) { }
> > +static inline void
> > +debug_object_active_state(void *addr, const struct debug_obj_descr *de=
scr,
> > +                         unsigned int expect, unsigned int next) { }
>
> I suppose it's a landmine that may go off at some point, but this isn't
> fixing anything that's broken at the moment, correct?

Yes, you are rigth.

Thanks.

>
> >
> >  static inline void debug_objects_early_init(void) { }
> >  static inline void debug_objects_mem_init(void) { }
