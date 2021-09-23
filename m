Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D58415DDB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 14:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240867AbhIWMHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 08:07:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240812AbhIWMHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 08:07:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15D6E610A0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 12:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632398743;
        bh=Sj7Dgzd3HnFxGEbIJASFCGbiMmx0KyzlYpvgK/xgBew=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i+VYDUeFD2tivbwhGzk8BxI4akTP3N2zEYmcYAARd5o8+mEN11O3pPb3nA6cuzdIP
         l2Efc9Cd4iC282ldMogs86+MGxis40AZu7kTVZhONDK2M7+jsQ0gOv+dh/aJP1DRGr
         vypIK10OrcWx9fMyWOdNLO+jgl7VJ+DSRqDn0xOuVLL47Qr2f5vha5TMfLxHlOAhkb
         Ze4kaJuTy4ydrZnzb7tle/pouUomuTL5sHIVAd/a4AySMrMt83MRh4p5bQn8zM6/zx
         2hCLD9xbIWZTYascVMxOXG7idgHhgoOHDA+R34LJX+a8ywFKCy43vRhjQ/6ULquaoi
         256nO7SOxM/Cg==
Received: by mail-vs1-f49.google.com with SMTP id l19so6222634vst.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 05:05:43 -0700 (PDT)
X-Gm-Message-State: AOAM532x6wwse6K2bOuOec2Hz4flkuA5TSVHI1GCHzSIU7g/5Uf2VoVM
        B7jtDqrgeYFW/CkdkQrNJAI4ziZ9QBy4LkItLy8=
X-Google-Smtp-Source: ABdhPJx8OKyPFON+wpQB9ZUDr4Oc12Wg+KDic4wk846BYfugGjm3VhH1VG/mZde8U/+MnVvRZ0DhTb7vAthIw2ZW+d0=
X-Received: by 2002:a67:f9da:: with SMTP id c26mr3568812vsq.50.1632398742315;
 Thu, 23 Sep 2021 05:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210923072716.913826-1-guoren@kernel.org> <6d7b1668c1f562a5ef426bb2519f9784@mailhost.ics.forth.gr>
 <CAAhSdy0YDP3Nk8N9fnrKgS+3Rjt=5tLCh20upmUGK9SK67nNvg@mail.gmail.com>
 <0861cc74d3886e685e9aa5d13ddcd781@mailhost.ics.forth.gr> <16de95480d279b086cf0c612461e4235@mailhost.ics.forth.gr>
 <CAAeLtUDu0yaDBcuC06nX1WUQC9k4eNuWjvAFrpkP_h0nf5BZAw@mail.gmail.com> <88696248a0c19a5dff660354b837514d@mailhost.ics.forth.gr>
In-Reply-To: <88696248a0c19a5dff660354b837514d@mailhost.ics.forth.gr>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 23 Sep 2021 20:05:28 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTwSwgk4qUUEC3LuOGC4jpa9Vu7Pfww=RPAVza90hobOw@mail.gmail.com>
Message-ID: <CAJF2gTTwSwgk4qUUEC3LuOGC4jpa9Vu7Pfww=RPAVza90hobOw@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add RISC-V svpbmt extension
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Anup Patel <anup@brainfault.org>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        gordan.markus@canonical.com, Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Lustig <dlustig@nvidia.com>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 6:09 PM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> =CE=A3=CF=84=CE=B9=CF=82 2021-09-23 13:04, Philipp Tomsich =CE=AD=CE=B3=
=CF=81=CE=B1=CF=88=CE=B5:
> >
> > How if we expand this to a mmu subnode in cpu@x and add a booleans for
> > adornments like svnapot and svpbmt?
> > The older mmu-type could then treated to indicate a mmu w/o any
> > adornments specified.  I am aware that this generates an additional
> > parsing-path that will be maintained, but it will allow future
> > properties to be grouped.
> >
> > cpu@0 {
> > ...
> > mmu {
> > type =3D "riscv,sv39";
> > supports-svpbmt;
> > }
> > ...
> > }
>
> I was about to propose the same thing, we can do this now without
> breaking backwards compatibility, we don't really use mmu-type property
> at this point, we are either sv39 or nommu.

It should be another patch.

--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
