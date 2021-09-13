Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0FB4090C3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 15:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243905AbhIMNzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 09:55:32 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:40337 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244553AbhIMNxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 09:53:00 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MBUZr-1mCtG53Tmp-00CveN for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021
 15:51:42 +0200
Received: by mail-wm1-f46.google.com with SMTP id 196-20020a1c04cd000000b002fa489ffe1fso7035323wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 06:51:42 -0700 (PDT)
X-Gm-Message-State: AOAM532ayd+HqLywpRQ9YyBoUcRbBdbm6VdTYJULrweLog9q6QCEaO5R
        vu9L/AaUIodMGb2EOqW2c6ON3df8MSeURUE9zbM=
X-Google-Smtp-Source: ABdhPJxdXwJ/q0NvYGhCmKITlhCmrj72X71DkFBLVmOSPolza9CFfWNG5FqWwHIu1iWFObsqtN4fNwgoD4+6N+66mTs=
X-Received: by 2002:a1c:7413:: with SMTP id p19mr11490099wmc.98.1631541102470;
 Mon, 13 Sep 2021 06:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <202109040635.GB2sRCvY-lkp@intel.com> <6f0aad67-7c3e-95c5-e4b4-d563e180c6ee@infradead.org>
 <CAMuHMdWaoXOxC=wqUfC-9UTN+0QedGLqvZCr3rJjYmM2K9SZHQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWaoXOxC=wqUfC-9UTN+0QedGLqvZCr3rJjYmM2K9SZHQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 13 Sep 2021 15:51:26 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3mMH8s3tzeUhO4Z22-YYzRv5mExj=yY9hBwkGoMriSpg@mail.gmail.com>
Message-ID: <CAK8P3a3mMH8s3tzeUhO4Z22-YYzRv5mExj=yY9hBwkGoMriSpg@mail.gmail.com>
Subject: Re: sound/isa/es1688/es1688_lib.c:384:79: error: 'DMA_AUTOINIT' undeclared
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:PNzAlKO/LQdqwQz5qUgxrxu+tf5VywjKZWfFFvGWO4iWWoLsL4N
 OMJox3Il0hn1E+brm33GixSN/TC4jlJtU6/RkFNJWohSCq21COi0P0giZP3awTFRd/PN3HS
 Yg2pt7QroJarhFcAbFFTdwiDZyE0vPh9BIbOc9ASREmQV6It96cEU6mNPFBld1TtIG+5f2K
 uN4lhfEmjHD67Dce7YY8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fPeMtRJNRD8=:uXl6z47X7MZUrP5PYym59L
 xybJ0FIG4PM16oAsWbNXFc9+1mGehNrvf0BiHFPnSyptYtff4FaxBvw908JeUP1rUgKH1PcnD
 PeUM5hGfh3bGLA8GwsK5oRgahXej/9famptY0YCR04+C30QOScBMtH2K2PTJGt8ic6IiX2hPs
 HakBntRJk1gEbrQyj/Kj6h82Yj3lNOyYRH0pUjKigxeFQNdBazouOSHB2KUjOi2WtwuastvKV
 pQEV/SvLcmNM1q6Kf62QAhEZWzEJzrB3BJM+h+AYaL0SO1cxVe3u5zqQ7LNSmbkQW6/EjF70f
 WJ9ISUKDWrGaxOjM/kEUe5EJgN6z3HeRlfrFjm3FOvmYJQ8yxFmfQMsPIibl192qUvX5Fd8bk
 3OS4PIo85T1UEI8Q1jZ+39US18uZ0rv1YEiQBLeKXpPzayAp1aqJva74nOZ/wpGz4daCF17fV
 CKL4TskaR5rAO83E+nOOxGZOWtRlQbAUXH2H3hfh0nee7PjeNVCdzl3CZQL+0MfdNvuj8sksf
 wqQwQtzBKTRpxJpOhHhHug1TAzBT0O6WFdN2UYbHMEd29I8VTiuOz/GWS2220Uzc5tKpDGXg2
 sYY+EwZSZJW3UlGcDwqXM1LHObRp5dajFuhAuX4CiTG/Trr8Om96QIohFrUH12YpeVTUyz2To
 UQJpGSu+oNjDvEeZQhsINMyqqbTLS4FnoPFaoBkW6OJia6rnMdKNbElBeuHlAIguDbz3ScYfj
 61j+2ZkibjqnLp2ZILUJ4/Q6adv5coe4BCnJ8k9utzSAn2aOvORO9pq3cxHrzF3UxQ9BAOY+L
 1ShyK7+VPm7nv9ORxTuc8mdhEdOufb7D2sSI+jqD6y4boXoH6AcD0LJ4hfYcSHb+eBATRiKf2
 dNRwWSz2Da4fdhGCWMBg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 9:55 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> > CONFIG_ISA_DMA_API=y
> > but CONFIG_ISA is not set.
> > (Yes, this is ColdFire.)
> >
> > menuconfig SND_ISA
> >         bool "ISA sound devices"
> >         depends on ISA || COMPILE_TEST
> >         depends on ISA_DMA_API
> >         default y
> >
> > I suppose that we could drop the "|| COMPILE_TEST" part.
>
> Or "... || (COMPILE_TEST && !M68K)"?

I think both approaches still fail for Q40 and AMIGA_PCMCIA,
which also set CONFIG_ISA, but still don't provide that
symbol.

AFAICT, we instead need

          depends on ISA_DMA_API && !M68K

The COMPILE_TEST can stay then, though it would
not be a huge loss to remove that.

       Arnd
