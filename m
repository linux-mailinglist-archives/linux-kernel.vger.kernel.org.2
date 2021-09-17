Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA4C40F14F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 06:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239754AbhIQE2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 00:28:54 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:44470 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230299AbhIQE2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 00:28:53 -0400
X-UUID: 1fe8cc2fda6144719cd5ab068e484217-20210917
X-UUID: 1fe8cc2fda6144719cd5ab068e484217-20210917
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2130152947; Fri, 17 Sep 2021 12:27:26 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Sep 2021 12:27:24 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Sep 2021 12:27:24 +0800
Message-ID: <b96f2415d14bcf00338b036155ea7f54b25d9a6d.camel@mediatek.com>
Subject: Re: [PATCH] scripts/sorttable: riscv: fix undelcred identifier
 'EM_RISCV' error
From:   Miles Chen <miles.chen@mediatek.com>
To:     Michal Kubecek <mkubecek@suse.cz>,
        Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Fri, 17 Sep 2021 12:27:24 +0800
In-Reply-To: <20210915160526.tittz3fewddjrqu3@lion.mk-sys.cz>
References: <20210913030625.4525-1-miles.chen@mediatek.com>
         <20210915215432.02a5e08e@xhacker>
         <20210915160526.tittz3fewddjrqu3@lion.mk-sys.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cc Andrew,

On Wed, 2021-09-15 at 18:05 +0200, Michal Kubecek wrote:
> On Wed, Sep 15, 2021 at 09:54:32PM +0800, Jisheng Zhang wrote:
> > On Mon, 13 Sep 2021 11:06:25 +0800
> > Miles Chen <miles.chen@mediatek.com> wrote:
> > 
> > > Fix the following build break by adding a conditional definition
> > > of EM_RISCV in order to allow cross-compilation on machines
> > > which do not have EM_RISCV definition in their host.
> > > 
> > > build break log from [1]:
> > > scripts/sorttable.c:352:7: error: use of undeclared identifier
> > > 'EM_RISCV'
> > 
> > Looks strange I can't reproduce it. FWICT, this may be seen with
> > some old
> > toolchains.
> 
> I checked the history and EM_RISCV was added to <elf.h> in glibc 2.24
> so
> builds on systems with glibc headers < 2.24 should show this error.
> 
> Michal
> 
> > > [1] 
> > > https://urldefense.com/v3/__https://lore.kernel.org/lkml/e8965b25-f15b-c7b4-748c-d207dda9c8e8@i2se.com/__;!!CTRNKA9wMg0ARbw!2wBeUUDf3Z2m7uJLF51GeZnBFWXRlEQrzGJ72JWIT0MPUcS_RgW98QWTXkEjy9-lhg$
> > >  
> > > 
> > > Cc: Jisheng Zhang <jszhang@kernel.org>
> > > Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
> > > Fixes: 54fed35fd393 ("riscv: Enable BUILDTIME_TABLE_SORT")
> > > Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> > 
> > Reviewed-by: Jisheng Zhang <jszhang@kernel.org>


Hi Andrew,

I cannot find the maintainer for scripts/sorttable.c, would you pick up
this change, please?

thanks
Miles

> > 
> > > ---
> > >  scripts/sorttable.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/scripts/sorttable.c b/scripts/sorttable.c
> > > index f355869c65cd..6ee4fa882919 100644
> > > --- a/scripts/sorttable.c
> > > +++ b/scripts/sorttable.c
> > > @@ -54,6 +54,10 @@
> > >  #define EM_ARCV2	195
> > >  #endif
> > >  
> > > +#ifndef EM_RISCV
> > > +#define EM_RISCV	243
> > > +#endif
> > > +
> > >  static uint32_t (*r)(const uint32_t *);
> > >  static uint16_t (*r2)(const uint16_t *);
> > >  static uint64_t (*r8)(const uint64_t *);
> > 
> > 
> > 
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > 
https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo/linux-mediatek__;!!CTRNKA9wMg0ARbw!2wBeUUDf3Z2m7uJLF51GeZnBFWXRlEQrzGJ72JWIT0MPUcS_RgW98QWTXkH74aYBWQ$
> >  

