Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CF8447B66
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 08:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbhKHHzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 02:55:33 -0500
Received: from verein.lst.de ([213.95.11.211]:44666 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234532AbhKHHzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 02:55:32 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4DAFD6732D; Mon,  8 Nov 2021 08:52:44 +0100 (CET)
Date:   Mon, 8 Nov 2021 08:52:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Wei Fu <wefu@redhat.com>
Cc:     Guo Ren <guoren@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph =?iso-8859-1?Q?M=FCllner?= 
        <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        liush <liush@allwinnertech.com>,
        Wei Wu =?utf-8?B?KOWQtOS8nyk=?= <lazyparser@gmail.com>,
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
Subject: Re: [RESEND PATCH V3 0/2] riscv: add RISC-V Svpbmt Standard
 Extension supports
Message-ID: <20211108075244.GA26350@lst.de>
References: <20211025040607.92786-1-wefu@redhat.com> <mhng-ac32ff92-86cb-4377-ba63-de1856e84fb1@palmerdabbelt-glaptop> <CAJF2gTT90V6gQw12XZEXB1TJXb5QNdXM6qcfXh1yzWzDPExgPQ@mail.gmail.com> <20211102055857.GB26925@lst.de> <CAJF2gTSfp+JZ4YxiynVA4KO0Z4PwJ4_uF8UO3Tx3mDOHPnFTeQ@mail.gmail.com> <CA+YCwK=vMtKC0DrhSJ7apgZ4s4_8fzGoRxY2mKEjjyJZjNW2QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+YCwK=vMtKC0DrhSJ7apgZ4s4_8fzGoRxY2mKEjjyJZjNW2QQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2021 at 03:12:51PM +0800, Wei Fu wrote:
> How about
> 
> config RISCV_SVPBMT
> bool
> depends on 64BIT && MMU
> default y

Yes.  You can shorten this a bit more using def_bool if you want.
