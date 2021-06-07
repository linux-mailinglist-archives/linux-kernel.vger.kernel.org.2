Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B1D39D582
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 09:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFGHBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 03:01:45 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:54761 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229436AbhFGHBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 03:01:44 -0400
X-UUID: e2d4cd33c0544e2c9a862bef06d87a8e-20210607
X-UUID: e2d4cd33c0544e2c9a862bef06d87a8e-20210607
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1830994713; Mon, 07 Jun 2021 14:59:49 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 7 Jun 2021 14:59:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Jun 2021 14:59:47 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <ardb@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <mark-pk.tsai@mediatek.com>,
        <matthias.bgg@gmail.com>, <mhelsley@vmware.com>,
        <rostedt@goodmis.org>, <samitolvanen@google.com>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH] recordmcount: avoid using ABS symbol as reference
Date:   Mon, 7 Jun 2021 14:59:48 +0800
Message-ID: <20210607065948.31632-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAMj1kXE3faN7nSSdoSU=ed+OPruefD_vJuhyRnsMuNiRygZZbg@mail.gmail.com>
References: <CAMj1kXE3faN7nSSdoSU=ed+OPruefD_vJuhyRnsMuNiRygZZbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Mon, 7 Jun 2021 at 04:42, Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:
> >
> > Avoid using ABS symbol, which won't be relocate, as reference.
> >
> > On arm64 platform, if there's shndx equals SHN_ABS(0xfff1).
> >
> > Section Headers:
> > [Nr]    Name                         Type      Address          Off      Size   ES  Flg Lk     Inf    Al
> > [65521] .text.n_tty_receive_buf      PROGBITS  0000000000000000 3cdab520 000054 00  AX  0      0      4
> > [65522] .rela.text.n_tty_receive_buf RELA      0000000000000000 3cdab578 000030 18  I   152076 65521  8
> >
>
> A RELA section's r_info field points to the section to which it
> applies. This is why in the example above section #65522 points to
> section #65521. This has nothing to do with the numerical value of
> SHN_ABS.

If the r_info of RELA section is 65521(0xfff1),
find_secsym_ndx() will use it to find the base symbol.

And in the symbol search loop in find_secsym_ndx(), get_symindex will
return 0xfff1 if the symbol is in ABS section.

In this case, find_secsym_ndx() will return a absolute symbol as
base, which won't be relocate, if an ABS symbol is found before the
real symbol in section 65521.

>
> > find_secsym_ndx, which use r_info in rela section to find the reference
> > symbol, may take ABS symbol as base.
> >
> > Symbol table '.symtab' contains 453285 entries:
> >    Num:    Value          Size Type    Bind   Vis       Ndx Name
> >      6: 0000000000000002     0 NOTYPE  LOCAL  DEFAULT   ABS section_count
> >
> > Which cause an invalid address in __mcount_loc.
> >
>
> Could you give a better account of the error you are trying to address?
>
> Also, arm64 no longer defines a section_count symbol (since v5.11), so
> please make sure that the diagnostics of the issue you are addressing
> are accurate for mainline.
>

My kernel version is 5.4.61.
But as I explained, I suppose mainline also have this issue.

>
> > Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> > ---
> >  scripts/recordmcount.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
> > index f9b19524da11..9b69167fb7ff 100644
> > --- a/scripts/recordmcount.h
> > +++ b/scripts/recordmcount.h
> > @@ -526,6 +526,10 @@ static int find_secsym_ndx(unsigned const txtndx,
> >         for (symp = sym0, t = nsym; t; --t, ++symp) {
> >                 unsigned int const st_bind = ELF_ST_BIND(symp->st_info);
> >
> > +               /* avoid absolute symbols */
> > +               if (symp->st_shndx == SHN_ABS)
> > +                       continue;
> > +
> >                 if (txtndx == get_symindex(symp, symtab, symtab_shndx)
> >                         /* avoid STB_WEAK */
> >                     && (STB_LOCAL == st_bind || STB_GLOBAL == st_bind)) {
