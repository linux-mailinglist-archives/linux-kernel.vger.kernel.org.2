Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83393B927A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 15:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbhGANvD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Jul 2021 09:51:03 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:42691 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbhGANu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 09:50:59 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MbC5g-1lNQNB0bOa-00bea9 for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021
 15:48:05 +0200
Received: by mail-wr1-f42.google.com with SMTP id p8so8363690wrr.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 06:48:05 -0700 (PDT)
X-Gm-Message-State: AOAM530abvLYt3dNOD/5arE1cZwBwYdM4zr81rpx0VP1cP0Q8M6ciRTt
        kQaj4ianmEGomTFyiqAy5+kh8wwpzbkzFIdJywU=
X-Google-Smtp-Source: ABdhPJzw3b2b6fsuurCJEeRsDZyU1MbYpbtSwPK/S0lgAFQS5IXx8aFUcX77Mwd+CzPYFTD4zgr5CUIjZ6Kjx7vWSlc=
X-Received: by 2002:adf:ee10:: with SMTP id y16mr8597924wrn.99.1625147284809;
 Thu, 01 Jul 2021 06:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210701125046.43018-1-wangborong@cdjrlc.com> <f72d43b9-88a1-19f0-c6ca-87fd7a01f379@csgroup.eu>
In-Reply-To: <f72d43b9-88a1-19f0-c6ca-87fd7a01f379@csgroup.eu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 1 Jul 2021 15:47:48 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2LA_MzP=mZ7_QODx5c7qq-r5t-5pZCiThjD_jX_KPXPA@mail.gmail.com>
Message-ID: <CAK8P3a2LA_MzP=mZ7_QODx5c7qq-r5t-5pZCiThjD_jX_KPXPA@mail.gmail.com>
Subject: Re: [PATCH] sched: Use WARN_ON
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Jason Wang <wangborong@cdjrlc.com>, Jeremy Kerr <jk@ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:T09Rvhe+PT3OlD2s3Iy9jYzh4y22x5uM7vjO0+3/kynE5tzBgfA
 /wmC7Kw8iNv7+V0T3+kQUju2V6emdrfy7kTDrf6/oACF7n2qiKA4eO85GhdSzUtab7PoNte
 ak8G3i+fR6Du7wNWsf1yi3HFKHaZetAQDxLPAwZJCeNoB/L+28JNr9nLskWLKvFNsGkhaVK
 e3hjAwalPPzZslNc5p2Gw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HMfnvOWeMtw=:ctzxTlIegXfH15jUH92jKB
 lK3SdnkkaONHwSV894b/cYfwpq1qVubFV5ZiWVVUJ0oprJslQdZcoGSu/a3YcCgy2zGdAhS2R
 qg46AIgUhQH+br167U10WrD4DgvXidjs5+fwl3WrcporFoFuEHcu7tzfip8+8rzjd4tPMXJJ/
 ayVHR5HcLSO7NcW6TdKfmucNXsKCrGVQIBjROE7Stg6gC7e4uk4gViye2xlH2wEhGlYxGefML
 g8wd92UyJzeeb8gyjuUEZ3k8uqLd+rdV7H9zE2HrkOIW/F5n5CU8WyZhjYNUrYEOkyT2m0SMI
 cRttg6Y+jc+Fz8cVyJzpDdej0zkSRvzcA8lpggrx4V7+Vkn5Nz8UY2d0egNK85cE+kctANh9r
 ydUoda7KrmBEoXoPBSPs23ZFz5d4VwSlY9B/Dbulht4kD1TTdDK4QSREoimLK6/tR5nWOTGWl
 RIj1w2StoTK8TlDYYeNIEFZuQH/iWi79/bwAWWQFquhre6Rrfkv5VxctKcJcX5dvDa34U7TZw
 VXz+m2cX0mHWGBwLfwGtAfb6ny4AKPdZ4z8TvUZrWsG7dcLSwyUhItLblg82fbMZj+514vdgV
 uXVQAPSiTqu7hlWMB5xKYbo5oFhahm2FQ34j7wdyz/vhTjYd9WzHc5ypAitKBilBzyYT/+Omk
 mKqSgNEcqwhtLdLVwAKXFSBZX+9bXwjnD80bRvt2SWIntelh7/dSRyT4Y9H6LBjk9AJmVU7x9
 wZH9bFNd4sFxQ8L3eiKtBzzmexPJbEiyhXe28NX7GtYWWTUFKM+gjGDUNnSlHwNIWf3CYruDt
 5TyJpefFrphR1NQlDKPcaEEOe0tN9HxtkbqPpcxhYA/+NdNmnSfiyn8JDeWlXJUj5EF1Ex/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 1, 2021 at 2:57 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 01/07/2021 à 14:50, Jason Wang a écrit :
> > The BUG_ON macro simplifies the if condition followed by BUG, but it
> > will lead to the kernel crashing. Therefore, we can try using WARN_ON
> > instead of if condition followed by BUG.
>
> But are you sure it is ok to continue if spu_acquire(ctx) returned false ?
> Shouldn't there be at least for fallback handling ?
>
> Something like:
>
>         if (WARN_ON(spu_acquire(ctx)))
>                 return;

I think you get a crash in either case:

- with the existing BUG_ON() there is an immediate backtrace and it stops there
- with WARN_ON() and continuing, you operate on a context that is not
  valid
- with the 'return', you get an endless loop, as it keeps calling
spusched_tick()
  without sleeping.

Out of those options, the existing BUG_ON() seems best.

       Arnd
