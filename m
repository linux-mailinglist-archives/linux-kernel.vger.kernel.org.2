Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2D23CAA63
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 21:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241926AbhGOTNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 15:13:08 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:47879 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238189AbhGOTBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 15:01:09 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MxVbb-1lBL7S1zKL-00xoSD for <linux-kernel@vger.kernel.org>; Thu, 15 Jul
 2021 20:58:11 +0200
Received: by mail-wr1-f42.google.com with SMTP id f17so9119499wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 11:58:11 -0700 (PDT)
X-Gm-Message-State: AOAM531iMxsjIg3ef0QQOU4tdZX2LlgS45rDXKsx3CWJilVHd5c7GuIW
        hQwRR0g58x4VxMuXeVEr9BbmAv4RNNrR3e8bU28=
X-Google-Smtp-Source: ABdhPJxRfFiHWQIAbu3auwz0Hq05xsUgcT5A8M1672fGma0M6fvhJ+XTaVphJl2w9qdjJlmYeTmPco2qiYaSab4YwIw=
X-Received: by 2002:a5d:438c:: with SMTP id i12mr7450714wrq.99.1626375491174;
 Thu, 15 Jul 2021 11:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <5729424.lOV4Wx5bFT@iron-maiden> <2591466.mvXUDI8C0e@iron-maiden>
 <5481808.DvuYhMxLoT@iron-maiden> <4331271.LvFx2qVVIh@iron-maiden>
In-Reply-To: <4331271.LvFx2qVVIh@iron-maiden>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 15 Jul 2021 20:57:55 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0LCZmHjwTjr6bWQ+uuO_3MentMfnHy2M_6iysyN9fP1g@mail.gmail.com>
Message-ID: <CAK8P3a0LCZmHjwTjr6bWQ+uuO_3MentMfnHy2M_6iysyN9fP1g@mail.gmail.com>
Subject: Re: [PATCH] include: linux: Reorganize timekeeping and ktime headers
To:     Carlos Bilbao <bilbao@vt.edu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, jianyong.wu@arm.com,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:aRQFBRdLX78Vaf62mCE3sUJcO9zSSgFFVefwWiaiyFv2oxJxNOP
 nx5Syl/MaWNvHUg5IJxFRPHxJ20rDtGpe4Py1GtCyhsQaAV9HWebozwRCNiz8e6rjpSbEbC
 zu8CPwAHMeHu5Hc9lcg8LCM45rqWSU1smMK8Jrrg8sgiiV+bm4kXCNztFkrvZZoiu8VZ2mo
 c0HJuJ43UvRDJ9mzuzifw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Omt4Xtoa34o=:F6GKmCFbHSDhjwb/TO9Ysv
 qiRB7kjN2coNh+0CnxVrY5unSYGvm3HU+m5jQYkq1luVh0W3CO9viuX9S7fVbatcspWKPi6vW
 lCrN6pccm1EgWsLfTWy/9io0KqV+dmZmG2vxtLwanxcSxu6Qy9IydinGzbbrmhEP+RtUTYDZ3
 CksGTGtENtEJU23us4nGngvxHA4H6A8KKl7tpoBjdJR5aJbpVntGSOcEQTc8LVaAK13Q6Bk9N
 ajbNB2nr+ckNKEbORtMdpaSQlUIbK4YBMumRPMTmQolFXEgOI2ksONIMZTCEC1rxofDfxpyW0
 N+bNWtELxYJJhzNZDkoNWZ+sP8pdXsVpvPuQQd5pFU2SsfTwp9GIyRfms1BAnEg0VPK4q15I0
 ss2ybl73B0GN0kixNsgno2JZZ8O/FMxE1enT5ieY+1teqTZKzF6Jwp349iKJ1lZei1SmO/HZq
 +40THvcAQX+O+Ni1EfrNTpibE88d8Vm6lHJvX99kHYWfg6ncc1EseMtSmxstdVBNQCW29hy6/
 Rf0wbead98eKgAzrge7oFxgB9KbO1rkPCEp/VoUuyRM+rs3aO7BHict1LIolDjuTQ8Cm/fMRZ
 iglm5a7uiKBSMWWK/dNPIX8URgp4NX9+vsL6kIS0vyMTnGKo+cGgFYJz/BoP6rRHzAVupzRjs
 dx9TIOF3wScSsGAUYvMW5q728ZlKkEkX3QxNm/zjH96cdxz+swIUA11iXR/LQjkSKZ0SKSLcY
 IZNPlzdVSPc6rZlapnD8Ygdg2K0aN61FcwHdPAGDLdZJ8OMaxnSftxJIgmVxLVypv+T1R8QpJ
 3pImkb3JscBFP2nnsFq/vAI4LUbU/hkJspxGZuKYO5XpIpIPOQNW9DJq8TzepV1ciUxuxTQqX
 ekHMf6VXoFIjKujGJ8tfOHUYWQHmQklo2SKej4E/qPP7IXU8s6KjMfBLh8isK4iGGNqNEzqx4
 FlPTNGOQ5wRRNDv26psDKVN1N4zaa+O7U4xjaGMer5NPN5ASRIRSS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 6:12 PM Carlos Bilbao <bilbao@vt.edu> wrote:
>
> Reorganize and separate the headers by making ktime.h take care of the
> ktime_get() family of functions, and reserve timekeeping.h for the actual
> timekeeping. This also helps to avoid implicit function errors and strengthens
> the header dependencies, since timekeeping.h was using ktime_to_ns(), a static
> function defined in a header it does no include, ktime.h. This patch also
> includes the header timekeeping.h wherever it is necessary for a successful
> compilation after the header code reorganization.
>
> Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
> ---
>  arch/x86/kernel/tsc.c       |   1 +
>  include/linux/ktime.h       | 196 +++++++++++++++++++++++++++++++++++-
>  include/linux/sched_clock.h |   2 +
>  include/linux/timekeeping.h | 196 +-----------------------------------
>  init/main.c                 |   1 +
>  kernel/time/ntp.c           |   1 +
>  kernel/time/time.c          |   1 +
>  kernel/time/timekeeping.c   |   1 +
>  8 files changed, 202 insertions(+), 197 deletions(-)

This looks reasonable overall. I'm not sure if Thomas has other plans for this
header, as he created the timekeeping.h one originally. There is also the
potential for build regressions when additional files depend on timekeeping.h
but don't include it directly. Hopefully the kbuild bot will warn us about
any of those.

       Arnd
