Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D71D30F2E9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbhBDMKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:10:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:47074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235780AbhBDMKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:10:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5ED3364F51
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 12:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612440594;
        bh=p8vSskYqOsv6bZvVFVd5EON0K9djVlROo0TSOXH8ykE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fCziKORU9VZAe8LXVNrtEyLjb/rMJSkJNHQICQE40DlJjduUZreHZYjast/33TSl8
         Z9mRhjHf4i+AdPbuvxiXxZ0BhZKKFgmOp2Z71O+398icOd7oIVmi6tj0VfIeK9nyHd
         uih8cH533rJEI4azKTEn7eZAlB4OpVEtdJshEMj7ZiyXxUlFP5Hhxn3DnGxcMk+6Ze
         Cid5sIXz3cg9tbuI+VzIAl+Jgra67/J1ONBUvPo6xdAtimMAsJSjMoxYfhU+lyIBe+
         ohW6l3GHlCv3EcGoBDkMzwskXDHrA7hV28ayXoLQ5MAG6q7ahon5PRa6QSHVhiUh+r
         Cl2eW6P76BM6w==
Received: by mail-ot1-f43.google.com with SMTP id 63so3175316oty.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 04:09:54 -0800 (PST)
X-Gm-Message-State: AOAM533yx4fqM3HnoMwDmSmGRBUG/43HTEAVcPPJCCVZhAaLWeO4666s
        WZx9UgpnVr5rrs+3+vNxOQUp2BhokFaerf0M1oY=
X-Google-Smtp-Source: ABdhPJzel27Ua+hp7HvW83uTj/m5zHu6KsfiJuUkr6+U4NN2XBK/HYOoL1m0n773hU2e83j9XOdicqkWvc3FiHuLsgQ=
X-Received: by 2002:a05:6830:1614:: with SMTP id g20mr5327010otr.77.1612440593620;
 Thu, 04 Feb 2021 04:09:53 -0800 (PST)
MIME-Version: 1.0
References: <601b773a.1c69fb81.9f381.a32a@mx.google.com> <6c65bcef-d4e7-25fa-43cf-2c435bb61bb9@collabora.com>
 <CAMj1kXHMw5hMuV5VapcTeok3WJu1B79=Z3Xho0qda0nCqBFERA@mail.gmail.com>
 <20210204100601.GT1463@shell.armlinux.org.uk> <CAMj1kXFog3=5zD7+P=cRfRLj1xfD1h1kU58iifASBSXkRe-E6g@mail.gmail.com>
 <c0037472-75c8-6cf9-6ecf-e671fce9d636@collabora.com> <46373679-a149-8a3d-e914-780e4c6ff8be@collabora.com>
 <20210204114420.GW1463@shell.armlinux.org.uk>
In-Reply-To: <20210204114420.GW1463@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 4 Feb 2021 13:09:42 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH1U72-3i1F=i-FjYrC_mv9S7ypeA835JMubb=-yKjxOg@mail.gmail.com>
Message-ID: <CAMj1kXH1U72-3i1F=i-FjYrC_mv9S7ypeA835JMubb=-yKjxOg@mail.gmail.com>
Subject: Re: next/master bisection: baseline.login on rk3288-rock2-square
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        "kernelci-results@groups.io" <kernelci-results@groups.io>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Feb 2021 at 12:45, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Thu, Feb 04, 2021 at 11:32:05AM +0000, Guillaume Tucker wrote:
> > Yes it does fix the issue:
> >
> >   https://lava.collabora.co.uk/scheduler/job/3173819
> >
> > with Ard's fix applied to this test branch:
> >
> >   https://gitlab.collabora.com/gtucker/linux/-/commits/next-20210203-ard-fix/
> >
> >
> > +clang +Nick
> >
> > It's worth mentioning that the issue only happens with kernels
> > built with Clang.  As you can see there are several other arm
> > platforms failing with clang-11 builds but booting fine with
> > gcc-8:
>
> My gut feeling is that it isn't Clang specific - it's likely down to
> the exact code/data placement, how things end up during decompression,
> and exactly what state the cache ends up in.
>
> That certainly was the case with the original regression.
>

Agreed.

So given that my queued fix turns this

cache_clean
cache_off

into this

cache_off
cache_clean

for v7 only, and considering that turning this into

cache_clean
cache_off
cache_clean

(as the diff tested by Guillaume does) fixes the reported issue, it
seems like the safest option to me at this point.

Reverting both patches, one of which has been in mainline since v5.7,
seems unwise to me at this point in the cycle.
