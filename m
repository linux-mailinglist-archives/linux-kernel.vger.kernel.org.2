Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39C8327C38
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 11:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbhCAKct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 05:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbhCAKc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 05:32:28 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB034C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 02:31:47 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id o186so8371821vso.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 02:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xFv45qWThA3Rjn4ljY+82rfar89CIR6t8XWRXVdabnc=;
        b=ZIIXkz9Cx4Gw2jhbEfE3JH+vLrCGsb0W/G7oTB4Yy85Kn9I/WGM+W6mmfnLyi16I24
         Gy0b73NS/d4X1crjl/gokRAlAbi/jFMW55KalZvLguT/xH+MoR3EqJmqdJVCu7uNksxJ
         GflWDvi1d8+MwLAnwttlMDYiozJkrnsFZBVJFE1K8wTvYxNZUDwt5Z1bcOB2vYperga3
         JOvuCO+2QVrIOxpQWPMeObzbzXXC8sMUONcU73//cQCCewp4N++Qnn/+0o8tsYgid1a8
         +WJqXt1Q/udPueV7aUt6098F+KScnntZAxkI+knTRcr5XZdZ4pp5CS4goq1Ze5lggOGk
         I76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xFv45qWThA3Rjn4ljY+82rfar89CIR6t8XWRXVdabnc=;
        b=EiDILKsXXhMCVtJ6fn2/DifIDK+A6POkWDx7VppccTpu2gBJLWP+kVVSn/VFpy0zox
         LHGLl6XWLmcsdaUFiJBYJ/V4CJXNWby4j2CIJ7AtOE15637OZjqm/6niYS24zpU2SIdY
         cI0kg3FMaTCVdmWwAan3hZ60hnHOYmjxJaMGvoCg9PW1AT9H3Fcma8oNI1QP8W+YQsuS
         97VSs6I0FlioxTQOAHb7WFtx9toMS68T7HZma6KVMpUrhP5x7n0/gZdBnEhUGxgmeTyA
         OgQHc/FGdy3uiihp6mTYcGM5Jtu6reqP6T+rhg9FoFumprMENH46qEuKDCvKRv6WFhws
         JULQ==
X-Gm-Message-State: AOAM533RS0A1e0zPnW+pJ7P7KmjZ9p7JLWT4GfQKa/r0zfLSXoPodOcb
        Zxkmlb3oxlbjDvzROU+CUHlin7uUgLdSRzsVh9M=
X-Google-Smtp-Source: ABdhPJwMfaaPGRlUz+KAHB8wVXwWhpkkvh8WBFiLZ4xfqznN2op+dcopIdCYiDvUsxu533VAPAi973Vd7ZGYCef1sbI=
X-Received: by 2002:a67:8ec7:: with SMTP id q190mr7888624vsd.10.1614594706979;
 Mon, 01 Mar 2021 02:31:46 -0800 (PST)
MIME-Version: 1.0
References: <1597061872-58724-1-git-send-email-xlpang@linux.alibaba.com>
 <CAOJsxLE9SkLY5V=D=Ot1oyLkbAORagfozYqxk1iNDW6b7QZrwg@mail.gmail.com> <f0355157-d70a-893b-5b85-b8cb90e03361@linux.alibaba.com>
In-Reply-To: <f0355157-d70a-893b-5b85-b8cb90e03361@linux.alibaba.com>
From:   Shu Ming <sming56@gmail.com>
Date:   Mon, 1 Mar 2021 18:31:35 +0800
Message-ID: <CANt8P=sOsYUsvJk-KfL8FvxuZm0aoJG6YM5foiierphM3Qjf2Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] mm/slub: Fix count_partial() problem
To:     xlpang@linux.alibaba.com
Cc:     Pekka Enberg <penberg@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any progress on this?  The problem addressed by this patch has also
made jitters to our online apps which are quite annoying.

On Mon, Aug 24, 2020 at 6:05 PM xunlei <xlpang@linux.alibaba.com> wrote:
>
> On 2020/8/20 =E4=B8=8B=E5=8D=8810:02, Pekka Enberg wrote:
> > On Mon, Aug 10, 2020 at 3:18 PM Xunlei Pang <xlpang@linux.alibaba.com> =
wrote:
> >>
> >> v1->v2:
> >> - Improved changelog and variable naming for PATCH 1~2.
> >> - PATCH3 adds per-cpu counter to avoid performance regression
> >>   in concurrent __slab_free().
> >>
> >> [Testing]
> >> On my 32-cpu 2-socket physical machine:
> >> Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz
> >> perf stat --null --repeat 10 -- hackbench 20 thread 20000
> >>
> >> =3D=3D original, no patched
> >>       19.211637055 seconds time elapsed                               =
           ( +-  0.57% )
> >>
> >> =3D=3D patched with patch1~2
> >>  Performance counter stats for 'hackbench 20 thread 20000' (10 runs):
> >>
> >>       21.731833146 seconds time elapsed                               =
           ( +-  0.17% )
> >>
> >> =3D=3D patched with patch1~3
> >>  Performance counter stats for 'hackbench 20 thread 20000' (10 runs):
> >>
> >>       19.112106847 seconds time elapsed                               =
           ( +-  0.64% )
> >>
> >>
> >> Xunlei Pang (3):
> >>   mm/slub: Introduce two counters for partial objects
> >>   mm/slub: Get rid of count_partial()
> >>   mm/slub: Use percpu partial free counter
> >>
> >>  mm/slab.h |   2 +
> >>  mm/slub.c | 124 +++++++++++++++++++++++++++++++++++++++++++----------=
---------
> >>  2 files changed, 89 insertions(+), 37 deletions(-)
> >
> > We probably need to wrap the counters under CONFIG_SLUB_DEBUG because
> > AFAICT all the code that uses them is also wrapped under it.
>
> /sys/kernel/slab/***/partial sysfs also uses it, I can wrap it with
> CONFIG_SLUB_DEBUG or CONFIG_SYSFS for backward compatibility.
>
> >
> > An alternative approach for this patch would be to somehow make the
> > lock in count_partial() more granular, but I don't know how feasible
> > that actually is.
> >
> > Anyway, I am OK with this approach:
> >
> > Reviewed-by: Pekka Enberg <penberg@kernel.org>
>
> Thanks!
>
> >
> > You still need to convince Christoph, though, because he had
> > objections over this approach.
>
> Christoph, what do you think, or any better suggestion to address this
> *in production* issue?
>
> >
> > - Pekka
> >
