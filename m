Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12EA8415DDC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 14:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240706AbhIWMIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 08:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240858AbhIWMHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 08:07:37 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C65BC061757
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 05:06:06 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i24so586863wrc.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 05:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rPN5T8McA7k2kKqTy/pX4dMxB3JbwuoA2CsK4OIX2IU=;
        b=b/i2Clm8A/XY3P2W28k7FN2YuIBtKZ7tcWOwVYykFI9EdNgZjPR/Ivgd5zKs5gsI6E
         g1iO6MXP9quXi+Ekq/k/GGaKKCoLTafSgD1HaX5efKOAa3x1R9uuR3rdE9UsZMy+j3YI
         Gb6G2YdgHGmvhGWRuC/dRRcCXCdkXRRqMWbp6k1rEtJVtPZr0LcsqDG/lsP87YnbUZnG
         pQ2arww96S6GsmcZsT7bjvIZDq9xJ2YHXExnS8K9UM9mPT1ZzFo04qla3UCnG22JXacq
         MXvjr/A1IcK15HIQ7iq+4EHLfRgyXCO8JZRQULJ928R/hCaBqxaaRy2UiGRp8WSz1PvX
         SlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rPN5T8McA7k2kKqTy/pX4dMxB3JbwuoA2CsK4OIX2IU=;
        b=t6ftMl3VKnXcGZDb2gwUyffxWYTOsZuDl2o+fCgV9mkMVGwfKhW+i3y1BLxDG0zlR8
         0ahDQLflF6KkYEHX7/QD/f1DT9F3Hj2Yr87e4QqH+EHtxMKVgRVNQkus2zN1v+4cCr/T
         FHESU0JBILlGcdICygS2oV7BhYJ1oFtEVK4eiTurAI4qNfrELVilRIodypI7Ti9O73ui
         UiDGPvI/eFTmoaGLnw8MgkaBThGC1X7RRDPQ86/pB+3aBmfEBIhmiVDg3l5eh7NcxaRF
         T2P+w+llfq3CgZWyjwx0nGlF8xbBm7Xx7ZA5sjidRAoOZUSsMWrh43xua7TakNTEtc1t
         sJZQ==
X-Gm-Message-State: AOAM533jHVhhLX39K+GRLineHEueDbCk993v7eFrzT/ER9yX1woRZFoq
        br8yWE485rJJa0lmBenEH0bQJS6p8vgdjEKksjUHKQ==
X-Google-Smtp-Source: ABdhPJztAa9QV5a3smRdCo5yzpkoWiLnhcXejcYMcH6FG+eEnDoOBG6Oa9aE0D4i69HYDPtOL5YRtHruqzti1svHBmM=
X-Received: by 2002:a7b:c20f:: with SMTP id x15mr4163615wmi.59.1632398764412;
 Thu, 23 Sep 2021 05:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210923072716.913826-1-guoren@kernel.org> <6d7b1668c1f562a5ef426bb2519f9784@mailhost.ics.forth.gr>
 <CAAhSdy0YDP3Nk8N9fnrKgS+3Rjt=5tLCh20upmUGK9SK67nNvg@mail.gmail.com>
 <0861cc74d3886e685e9aa5d13ddcd781@mailhost.ics.forth.gr> <16de95480d279b086cf0c612461e4235@mailhost.ics.forth.gr>
 <CAAeLtUDu0yaDBcuC06nX1WUQC9k4eNuWjvAFrpkP_h0nf5BZAw@mail.gmail.com>
 <88696248a0c19a5dff660354b837514d@mailhost.ics.forth.gr> <CA+zEjCsO2CyhrfGGA4ceAH=LBOyqWF4U7F91VheTdr6wEJj1pw@mail.gmail.com>
In-Reply-To: <CA+zEjCsO2CyhrfGGA4ceAH=LBOyqWF4U7F91VheTdr6wEJj1pw@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 23 Sep 2021 17:35:52 +0530
Message-ID: <CAAhSdy3C8LQNm=Jby1BcMU-xLXB-GiW076QO3QqRVvDQh7zPkA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add RISC-V svpbmt extension
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Guo Ren <guoren@kernel.org>, Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com,
        Aniket Ponkshe <aniket.ponkshe@canonical.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Gordan Markus <gordan.markus@canonical.com>,
        Guo Ren <guoren@linux.alibaba.com>,
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

On Thu, Sep 23, 2021 at 5:21 PM Alexandre Ghiti
<alexandre.ghiti@canonical.com> wrote:
>
> On Thu, Sep 23, 2021 at 12:11 PM Nick Kossifidis <mick@ics.forth.gr> wrot=
e:
> >
> > =CE=A3=CF=84=CE=B9=CF=82 2021-09-23 13:04, Philipp Tomsich =CE=AD=CE=B3=
=CF=81=CE=B1=CF=88=CE=B5:
> > >
> > > How if we expand this to a mmu subnode in cpu@x and add a booleans fo=
r
> > > adornments like svnapot and svpbmt?
> > > The older mmu-type could then treated to indicate a mmu w/o any
> > > adornments specified.  I am aware that this generates an additional
> > > parsing-path that will be maintained, but it will allow future
> > > properties to be grouped.
> > >
> > > cpu@0 {
> > > ...
> > > mmu {
> > > type =3D "riscv,sv39";
> > > supports-svpbmt;
> > > }
> > > ...
> > > }
> >
> > I was about to propose the same thing, we can do this now without
> > breaking backwards compatibility, we don't really use mmu-type property
> > at this point, we are either sv39 or nommu.
>
> Indeed, this property is only informative and not useful since we can
> directly "ask" the hw what it supports (cf sv48 patchset). And it
> cannot actually be used to force a certain svXX since reading the
> device tree happens way too late in the boot process (I have this
> issue with my sv48 patchset where I used to read the device tree to
> set the size of the address space, but it actually breaks KASAN).
>
> Isn't there a way to know if it supports svPBMT at runtime?

Unfortunately, we can't detect Svpmbt through CSR read/write
or traps.

A DT property seems to be the only way for Svpmbt.

Regards,
Anup

>
> Alex
>
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
