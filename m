Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341A04426FB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 07:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhKBGHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 02:07:09 -0400
Received: from verein.lst.de ([213.95.11.211]:54514 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhKBGHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 02:07:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4400D68AFE; Tue,  2 Nov 2021 07:04:25 +0100 (CET)
Date:   Tue, 2 Nov 2021 07:04:24 +0100
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
Message-ID: <20211102060424.GA27015@lst.de>
References: <20211025040607.92786-1-wefu@redhat.com> <20211025040607.92786-3-wefu@redhat.com> <YXZU/3/YmRGFrOXK@infradead.org> <CA+YCwKn1VA8=NSa=bdhP99jfpokYGHBvqVSKvZmdndQOz6UUPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+YCwKn1VA8=NSa=bdhP99jfpokYGHBvqVSKvZmdndQOz6UUPA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 10:49:11PM +0800, Wei Fu wrote:
> > > +                                             >> _PAGE_PFN_SHIFT);
> >
> > >  static inline unsigned long _pmd_pfn(pmd_t pmd)
> > >  {
> > > -     return pmd_val(pmd) >> _PAGE_PFN_SHIFT;
> > > +     return (pmd_val(pmd) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT;
> > >  }
> >
> > The "(pud_val(pud) & _PAGE_CHG_MASK) >> _PAGE_PFN_SHIFT" expression begs
> > for readable and well-documented helper.
> 
> How about these:
> #define _chg_of_pmd(pmd)  (pmd_val(pmd) & _PAGE_CHG_MASK)
> #define _chg_of_pud(pud)  (pud_val(pud) & _PAGE_CHG_MASK)

I'd use inline functions instead of macros if possible, but otherwise
yes.

> How about :
> 
> extern unsigned long  _svpbmt_mask
> extern unsigned long _svpbmt_mt_pma
> extern unsigned long _svpbmt_mt_nc
> extern unsigned long _svpbmt_mt_io
> 
> #define _PAGE_MT_MASK              _svpbmt_mask
> #define _PAGE_MT_PMA        _svpbmt_mt_pma
> #define _PAGE_MT_NC          _svpbmt_mt_nc
> #define _PAGE_MT_IO           _svpbmt_mt_io

Looks much better.
