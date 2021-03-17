Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E77533EE5A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhCQKdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbhCQKcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:32:51 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A788DC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 03:32:51 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id m6so964895ilh.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 03:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oqqgjjy0YWzSfTvxYTLofKTklhyvD17RDEYJDR28ejI=;
        b=IpRcg/+jx8PdZst8xvRvgNDjDWBtoJXG01rpFgAI2ssW+vHhZblzX/WGc8kX/svhDq
         wjqWw7IaXOh65z62CgBRPUogmCR9wG0576oZZnDevAP0drTMF++Jaq+TrsFC32i/Wiwr
         nLTBIxCNbMBD24C12F/kBjNKJnu1s0he+m7jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oqqgjjy0YWzSfTvxYTLofKTklhyvD17RDEYJDR28ejI=;
        b=b2pdq+ck3pp6twUWZ+ylAHKNZLdZXrgsAefzhGMcUXvlgw8/qp5x/iS5z5xlL7Otb0
         SH5KGPsteLChiSy9M2QMXRu0/3y07doOATyzaUwEDKfYYqb/PmymbVGnhK+DR3dVYyM1
         /plGOAW12U/IvyeyhiGXsQgENr21jXeaVtQ1vgQIYUgQJjzEA33BBFSNsiTnIYqpQPt6
         rb9v2byv6l36pVTA20ag8V19+xv24qw1fGv2DffgSpWZ3u5xrWmNONnk05FFlS1fMl+4
         Cb+R2iCgNQLIRMDPgMc9JRPQnZVc3lzJ2Z1zRchrfnOyfuN2EuQJ6SRMCNr/IYdW/sdI
         2Pvg==
X-Gm-Message-State: AOAM531iLhpoT0m+eCwAQEz3WhblZgTfIB57YfypZRRmOtCkgh4sx8k9
        E8nh2gszbp4p8ZLqJ3IaT9akAP9GI0bM/fgoZgec8Q==
X-Google-Smtp-Source: ABdhPJxbyBoFfx9KfRMI9Hlmn2f1dJjKSTH5TF5bIvpIC52QAk7wKLeHXMiUH5hO/nkLuZtf7TemZDcuoS5ZZKelBss=
X-Received: by 2002:a05:6e02:12b4:: with SMTP id f20mr6987446ilr.220.1615977171186;
 Wed, 17 Mar 2021 03:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210310220211.1454516-1-revest@chromium.org> <20210310220211.1454516-2-revest@chromium.org>
 <CAEf4BzZ6Lfmn9pEJSLVhROjkPGJO_mT4nHot8AOjZ_9HTC1rEQ@mail.gmail.com>
 <CABRcYmJ3W88bTKwuO9Aav8A+TXmSE=SpxX++6OR77n=ya9hfgw@mail.gmail.com>
 <CAEf4BzZD52S8rjvgKAxssfD8c2Ke-_89nUjxOt2E_pgDt5AaNg@mail.gmail.com>
 <CABRcYm+6By6_j+BaRMkw2-fnrJHKQYsoBMGkUKDXxYnm_AH88Q@mail.gmail.com> <CAEf4BzbiK8vTO_-rgwr43+auTsSfNuTc_zLyR9qH9Dz4NLWsXA@mail.gmail.com>
In-Reply-To: <CAEf4BzbiK8vTO_-rgwr43+auTsSfNuTc_zLyR9qH9Dz4NLWsXA@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 17 Mar 2021 11:32:40 +0100
Message-ID: <CABRcYmJSPsW9QRJywH6dLB2mb4aqZPnR9QnWsWhXQ3NGF9OWLQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Add a ARG_PTR_TO_CONST_STR argument type
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 2:02 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Tue, Mar 16, 2021 at 5:46 PM Florent Revest <revest@chromium.org> wrote:
> > On Wed, Mar 17, 2021 at 1:35 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > On Tue, Mar 16, 2021 at 4:58 PM Florent Revest <revest@chromium.org> wrote:
> > > > On Tue, Mar 16, 2021 at 2:03 AM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > On Wed, Mar 10, 2021 at 2:02 PM Florent Revest <revest@chromium.org> wrote:
> > > > > > +       } else if (arg_type == ARG_PTR_TO_CONST_STR) {
> > > > > > +               struct bpf_map *map = reg->map_ptr;
> > > > > > +               int map_off, i;
> > > > > > +               u64 map_addr;
> > > > > > +               char *map_ptr;
> > > > > > +
> > > > > > +               if (!map || !bpf_map_is_rdonly(map)) {
> > > > > > +                       verbose(env, "R%d does not point to a readonly map'\n", regno);
> > > > > > +                       return -EACCES;
> > > > > > +               }
> > > > > > +
> > > > > > +               if (!tnum_is_const(reg->var_off)) {
> > > > > > +                       verbose(env, "R%d is not a constant address'\n", regno);
> > > > > > +                       return -EACCES;
> > > > > > +               }
> > > > > > +
> > > > > > +               if (!map->ops->map_direct_value_addr) {
> > > > > > +                       verbose(env, "no direct value access support for this map type\n");
> > > > > > +                       return -EACCES;
> > > > > > +               }
> > > > > > +
> > > > > > +               err = check_helper_mem_access(env, regno,
> > > > > > +                                             map->value_size - reg->off,
> > > > > > +                                             false, meta);
> > > > >
> > > > > you expect reg to be PTR_TO_MAP_VALUE, so probably better to directly
> > > > > use check_map_access(). And double-check that register is of expected
> > > > > type. just the presence of ref->map_ptr might not be sufficient?
> > > >
> > > > Sorry, just making sure I understand your comment correctly, are you
> > > > suggesting that we:
> > > > 1- skip the check_map_access_type() currently done by
> > > > check_helper_mem_access()? or did you implicitly mean that we should
> > > > call it as well next to check_map_access() ?
> > >
> > > check_helper_mem_access() will call check_map_access() for
> > > PTR_TO_MAP_VALUE and we expect only PTR_TO_MAP_VALUE, right? So why go
> > > through check_helper_mem_access() if we know we need
> > > check_map_access()? Less indirection, more explicit. So I meant
> > > "replace check_helper_mem_access() with check_map_access()".
> >
> > Mhh I suspect there's still a misunderstanding, these function names
> > are really confusing ahah.
> > What about check_map_access*_type*. which is also called by
> > check_helper_mem_access (before check_map_access):
> > https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/kernel/bpf/verifier.c#n4329
> >
> > Your message sounds like we should skip it so I was asking if that's
> > what you also implicitly meant or if you missed it?
>
> ah, you meant READ/WRITE access? ok, let's keep
> check_helper_mem_access() then, never mind me

Ah cool, then we are on the same page :)
