Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A243F4426FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 07:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhKBGKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 02:10:14 -0400
Received: from verein.lst.de ([213.95.11.211]:54538 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhKBGKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 02:10:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 811A468AFE; Tue,  2 Nov 2021 07:07:34 +0100 (CET)
Date:   Tue, 2 Nov 2021 07:07:34 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Wei Fu <wefu@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>, guoren@kernel.org,
        christoph.muellner@vrull.eu,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        Liu Shaohua <liush@allwinnertech.com>,
        Wei Wu =?utf-8?B?KOWQtOS8nyk=?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        heinrich.schuchardt@canonical.com, gordan.markus@canonical.com,
        guoren@linux.alibaba.com, Arnd Bergmann <arnd@arndb.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Lustig <dlustig@nvidia.com>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>
Subject: Re: [RESEND PATCH V3 2/2] riscv: add RISC-V Svpbmt extension
 supports
Message-ID: <20211102060734.GB27015@lst.de>
References: <20211025040607.92786-1-wefu@redhat.com> <20211025040607.92786-3-wefu@redhat.com> <YXZU/3/YmRGFrOXK@infradead.org> <CA+YCwKkX64A8p9vfLJHC3+LqOWyDg99eDBR0mjfB=H45BOyJLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+YCwKkX64A8p9vfLJHC3+LqOWyDg99eDBR0mjfB=H45BOyJLQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 06:55:09PM +0800, Wei Fu wrote:
> How about this macro:
> #define _SVPBMT_PMA         0x0UL
> #define _SVPBMT_NC         BIT(61)
> #define _SVPBMT_IO         BIT(62)
> #define _SVPBMT_MASK         GENMASK(62, 61)

Personally I find these macros highly confusing. 

#define _SVPBMT_PMA	0UL
#define _SVPBMT_NC	(1UL << 61)
#define _SVPBMT_IO	(1UL << 62).
#define _SVPBMT_MASK	(_SVPBMT_NC  | _SVPBMT_IO)

is much eaier to follow.  Note that we can probably just drop
_SVPBMT_PMA entirely to make this even more readable.

> > Also why not use the standard names for these _PAGE bits used by
> > most other architectures?
> 
> Which names are you suggesting? Would you mind providing an example ?
> _PAGE_BIT_   for _PAGE_KERNEL_ ??

Use _PAGE_NOCACHE for _SVPBMT_NC, and _PAGE_IO for _SVPBMT_IO.
