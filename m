Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E469E4429DB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 09:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhKBIyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 04:54:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhKBIyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 04:54:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEF7360E98
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 08:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635843095;
        bh=YPf6/M2ebb35G16XuM5VQwFjUhWRcpJIy1yYwPnDS7k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fftVrso7Ja5UMZ/cbC8pu8j060xZaMp+R9hjaMQX/jKNo14P80ODhhm5+xz0UFVA/
         7UipisfN12J1h8YB2OOwWUhmwqtipcxsG6nKRQRkq06YlmdQ7ONJz08r7ipTfYfhor
         WG3DLzoZ/J9MPfm7es/RvjCPGXo9JUNyBAtoeCGOC3MP/6IzBmQNs+WyFoVUjIb8du
         Xj/ftxfJ/+4IeS4rPi9F/Ban684Wqg3hUD3tfCn49e+JAw97UhIfi/Kpi9TyqVjr2W
         ofeAGDV6u2wjiZYT4WET+AjIvA4ErmybIBRzB9BnMm29wPJZRjvXjtEWxNAwz0QK8X
         OuIubCCa8omkg==
Received: by mail-vk1-f178.google.com with SMTP id n201so9223528vkn.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 01:51:35 -0700 (PDT)
X-Gm-Message-State: AOAM531I/ukEkRv4xbZJpq5R4sjQwr3qflY4fUrcIOcaBjzLf537eyfs
        eyCHBi1fogOgTU7en4seuh8Mcm7KBeDM91M8p3M=
X-Google-Smtp-Source: ABdhPJwrbsKCWw5C3jjAJ84DekQMMCaOINyBIVGKEkLsFaB1DnX4bVGP0b6bJeIeLpHfeJtl0x0CE5eVBWVKtgr6KEs=
X-Received: by 2002:a05:6122:1682:: with SMTP id 2mr36158634vkl.22.1635843094957;
 Tue, 02 Nov 2021 01:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211025040607.92786-1-wefu@redhat.com> <mhng-ac32ff92-86cb-4377-ba63-de1856e84fb1@palmerdabbelt-glaptop>
 <CAJF2gTT90V6gQw12XZEXB1TJXb5QNdXM6qcfXh1yzWzDPExgPQ@mail.gmail.com> <20211102055857.GB26925@lst.de>
In-Reply-To: <20211102055857.GB26925@lst.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 2 Nov 2021 16:51:23 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSfp+JZ4YxiynVA4KO0Z4PwJ4_uF8UO3Tx3mDOHPnFTeQ@mail.gmail.com>
Message-ID: <CAJF2gTSfp+JZ4YxiynVA4KO0Z4PwJ4_uF8UO3Tx3mDOHPnFTeQ@mail.gmail.com>
Subject: Re: [RESEND PATCH V3 0/2] riscv: add RISC-V Svpbmt Standard Extension supports
To:     Christoph Hellwig <hch@lst.de>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Wei Fu <wefu@redhat.com>, Anup Patel <Anup.Patel@wdc.com>,
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Christoph,

On Tue, Nov 2, 2021 at 1:59 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Nov 02, 2021 at 10:07:58AM +0800, Guo Ren wrote:
> >
> > To separate MMU & no-MMU clearly, I suggest fuwei add
> > #if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
>
> Actually - for documentation purposes a new CONFIG_RISCV_SVPBMT that
> depends on 64BIT && MMU would probably much better as it clearly
> documents the intent here.
Okay


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
