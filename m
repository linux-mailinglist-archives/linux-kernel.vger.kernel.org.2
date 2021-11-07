Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E274471FC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 08:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbhKGHPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 02:15:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50876 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229510AbhKGHPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 02:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636269186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vDFK4DQn9aozfzSTpRLPEP7Y2pv1h7xDJpMzzU0xL2E=;
        b=TgQu85TFFcI1GYi145daH/C24VV6KH51tbJ4QSk824iIOVVM3z/FOFqhelYBShnnQgeIB2
        zzEkIEF4M5Mgwur5NeYfG/TkxkGHk8D1cKzbpnVwCpJb5yaas4sDiecXROJ6njB6NcpMvp
        X+x7PE1UPvUrLjphlckC5ppW9GrvyZI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-oyQSy7qBOJClXAtQeBT1tQ-1; Sun, 07 Nov 2021 02:13:03 -0500
X-MC-Unique: oyQSy7qBOJClXAtQeBT1tQ-1
Received: by mail-ed1-f69.google.com with SMTP id s6-20020a056402520600b003e2dea4f9b4so9297403edd.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 00:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vDFK4DQn9aozfzSTpRLPEP7Y2pv1h7xDJpMzzU0xL2E=;
        b=rDDEATHgIMINGRIm7T+Ep1rgWkqzTiDlPJuQkUz3JyMTKkdUmfUIWjLYcTt49OSUkx
         lnWqS4OYQ9RimUl7MWb0tNG3HIpDiOFvEVzOVwnkriDh10MamrNQBSpgkiIkMDq8QwL8
         FZjdtM6F5NuNcj7kSZHFnCNEy8l7OaWshW9GH89P4wYp91AnmBFizOfnpJGTVg53b/FH
         H5oB6/bwVYWfiOnnrF3rjeFJgigPriL17TSSdPtRswnOO1cIH2jD+r5qzoZJ3OxM+4/q
         DQrQvfhpPmOxq2vrF1cGCL/2zirapTCU4xjOf1Ox7alDM8TtdFnEsvIRQOfr0xebn99B
         fKrg==
X-Gm-Message-State: AOAM533ZvidN/GBIAALRQZVexbp6fH4SGCQEL5UNzEV9YRITUVr0hKRp
        tygHNyUTJKURnQp1+jqPY42jrBOSiMP9GWV9xrcKAg5xuNXfchq3j5rvEf5wmQEzbvR7jH+a1Fn
        +cWbY2hjvTvpJOnpSS096Esryoy6cLjsWo46k/JQd
X-Received: by 2002:a05:6402:50ce:: with SMTP id h14mr56552162edb.228.1636269182851;
        Sun, 07 Nov 2021 00:13:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0RnDZMu6KOmWFnlJgGjwa6lcFRu6lQ1A/f5D/m43sCA5y6L7mOgJfGHJgDdZWFeczlvmbPOV4l6ovhsCleG0=
X-Received: by 2002:a05:6402:50ce:: with SMTP id h14mr56552126edb.228.1636269182667;
 Sun, 07 Nov 2021 00:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211025040607.92786-1-wefu@redhat.com> <mhng-ac32ff92-86cb-4377-ba63-de1856e84fb1@palmerdabbelt-glaptop>
 <CAJF2gTT90V6gQw12XZEXB1TJXb5QNdXM6qcfXh1yzWzDPExgPQ@mail.gmail.com>
 <20211102055857.GB26925@lst.de> <CAJF2gTSfp+JZ4YxiynVA4KO0Z4PwJ4_uF8UO3Tx3mDOHPnFTeQ@mail.gmail.com>
In-Reply-To: <CAJF2gTSfp+JZ4YxiynVA4KO0Z4PwJ4_uF8UO3Tx3mDOHPnFTeQ@mail.gmail.com>
From:   Wei Fu <wefu@redhat.com>
Date:   Sun, 7 Nov 2021 15:12:51 +0800
Message-ID: <CA+YCwK=vMtKC0DrhSJ7apgZ4s4_8fzGoRxY2mKEjjyJZjNW2QQ@mail.gmail.com>
Subject: Re: [RESEND PATCH V3 0/2] riscv: add RISC-V Svpbmt Standard Extension supports
To:     Guo Ren <guoren@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        liush <liush@allwinnertech.com>,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        "Xinhaoqu (Freddie)" <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Guo=EF=BC=8C Christoph,

Thanks for your suggestion.

On Tue, Nov 2, 2021 at 4:51 PM Guo Ren <guoren@kernel.org> wrote:
>
> Thx Christoph,
>
> On Tue, Nov 2, 2021 at 1:59 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Tue, Nov 02, 2021 at 10:07:58AM +0800, Guo Ren wrote:
> > >
> > > To separate MMU & no-MMU clearly, I suggest fuwei add
> > > #if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
> >
> > Actually - for documentation purposes a new CONFIG_RISCV_SVPBMT that
> > depends on 64BIT && MMU would probably much better as it clearly
> > documents the intent here.
> Okay

How about

config RISCV_SVPBMT
bool
depends on 64BIT && MMU
default y


>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/
>

