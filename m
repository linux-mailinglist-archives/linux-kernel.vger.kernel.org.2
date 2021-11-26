Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD4445F1D1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 17:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhKZQ3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 11:29:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58703 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231395AbhKZQ1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 11:27:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637943835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=keITFTEdFi5E9hp2LFE/RvLMU4rsiAlnNkpkNDD9Jvo=;
        b=a79KN8bEvfvP26dqUGgmeb33FtW0/klaUV+7uEm/HW3xHsfdvc9i7nTWd9HXFr1DiuQW5q
        UWv9C5lsFnAXAV396SkRwEsFwbodpWzQxCXQIDQl1Wk3Muuzr4G/pcErKcRYKzyv4H1+gW
        BGNl7fZOjcikxrimdTVWTgXzeBXLU8Q=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-291-SPsyeWzeMg2oNkRjPw7ZIA-1; Fri, 26 Nov 2021 11:23:54 -0500
X-MC-Unique: SPsyeWzeMg2oNkRjPw7ZIA-1
Received: by mail-ed1-f69.google.com with SMTP id a3-20020a05640213c300b003e7d12bb925so8446124edx.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 08:23:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=keITFTEdFi5E9hp2LFE/RvLMU4rsiAlnNkpkNDD9Jvo=;
        b=4PkCMeUpiObyTgQs+MO5DmyNONOSekPh97hRoAMkRBHKRAHNlynCbHG4RoJTq7mvzT
         lbCvhan/FxP9EvMhV9GPDx7Ug3PFXdrffwAKDkGGl3XHsWDUXRNs0OUopDA14ZH9iVum
         heV3yFCgRgGUY0FdZGAfrZxeJZ0AaIoHRYBeBZifxDaf7BDKfvN+6rPf4Eh40GEes7YN
         fM3RlPHS7fg2R9n2ymNJUAwJDjI+OTTfVJCHydXIpeHoythBLue6BOys/gyDABwRpWAF
         meb74gGmlpxZRUDUCExF08yNdgbFxVFV8hUGdlvWevCshwdo29SG8z+y6cSQu4QCtaVG
         4zfg==
X-Gm-Message-State: AOAM532xRVTUCyD/rNwV2OpGAKQwJZBIKdFCsw5Nud+UnPCbPJ5NzZjt
        6fh72+QoZd4yfoZDhoUjmLvwC57bDvTSkUfu0UbJ7OzW+n4p7u7lNW4wGtFrn6dYicmuCnUeeB9
        dEzb6rBUKD1wyZp0ILG63sgG/q2I0esK+xy7++mka
X-Received: by 2002:a17:906:390:: with SMTP id b16mr38618832eja.522.1637943833293;
        Fri, 26 Nov 2021 08:23:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/5Lm7haoggq+jLsvlVThHn5G2U/wwavJ0uSjFE0xk77eTpLkcug+uMs/Exh4ce7XHzo8pTVY4fEMtNQHx6II=
X-Received: by 2002:a17:906:390:: with SMTP id b16mr38618800eja.522.1637943833142;
 Fri, 26 Nov 2021 08:23:53 -0800 (PST)
MIME-Version: 1.0
References: <20211025040607.92786-1-wefu@redhat.com> <mhng-ac32ff92-86cb-4377-ba63-de1856e84fb1@palmerdabbelt-glaptop>
 <CAJF2gTT90V6gQw12XZEXB1TJXb5QNdXM6qcfXh1yzWzDPExgPQ@mail.gmail.com>
 <20211102055857.GB26925@lst.de> <CAJF2gTSfp+JZ4YxiynVA4KO0Z4PwJ4_uF8UO3Tx3mDOHPnFTeQ@mail.gmail.com>
 <CA+YCwK=vMtKC0DrhSJ7apgZ4s4_8fzGoRxY2mKEjjyJZjNW2QQ@mail.gmail.com> <20211108075244.GA26350@lst.de>
In-Reply-To: <20211108075244.GA26350@lst.de>
From:   Wei Fu <wefu@redhat.com>
Date:   Sat, 27 Nov 2021 00:23:42 +0800
Message-ID: <CA+YCwKke6ER=Sv6O3zGkqvtfOvw+1VBR3-7w_SS_PTQyGBN=_w@mail.gmail.com>
Subject: Re: [RESEND PATCH V3 0/2] riscv: add RISC-V Svpbmt Standard Extension supports
To:     Christoph Hellwig <hch@lst.de>
Cc:     Guo Ren <guoren@kernel.org>, Anup Patel <Anup.Patel@wdc.com>,
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
        Richard Trauben <rtrauben@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Mon, Nov 8, 2021 at 3:52 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Sun, Nov 07, 2021 at 03:12:51PM +0800, Wei Fu wrote:
> > How about
> >
> > config RISCV_SVPBMT
> > bool
> > depends on 64BIT && MMU
> > default y
>
> Yes.  You can shorten this a bit more using def_bool if you want.
Sorry for the late reply, OK, fixing it now
>

