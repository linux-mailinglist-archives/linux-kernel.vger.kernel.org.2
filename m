Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977B4433875
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 16:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhJSOgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 10:36:14 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:40410 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229524AbhJSOgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 10:36:13 -0400
X-UUID: 3f142819df124a0f9138aa1412034745-20211019
X-UUID: 3f142819df124a0f9138aa1412034745-20211019
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1270553496; Tue, 19 Oct 2021 22:33:55 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 19 Oct 2021 22:33:54 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Oct 2021 22:33:53 +0800
Message-ID: <294ac8c4fa2e7fcad8376a82193b8e2430a4032a.camel@mediatek.com>
Subject: Re: [PATCH] kasan: add kasan mode messages when kasan init
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Marco Elver <elver@google.com>
CC:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chinwen Chang =?UTF-8?Q?=28=E5=BC=B5=E9=8C=A6=E6=96=87=29?= 
        <chinwen.chang@mediatek.com>,
        Yee Lee =?UTF-8?Q?=28=E6=9D=8E=E5=BB=BA=E8=AA=BC=29?= 
        <Yee.Lee@mediatek.com>,
        Nicholas Tang =?UTF-8?Q?=28=E9=84=AD=E7=A7=A6=E8=BC=9D=29?= 
        <nicholas.tang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 19 Oct 2021 22:33:54 +0800
In-Reply-To: <CANpmjNMMQUHhFTdaqfx6HErnv0aXkCJn+eBGN-kfeznN8H+f3g@mail.gmail.com>
References: <20211019120413.20807-1-Kuan-Ying.Lee@mediatek.com>
         <CANpmjNMMQUHhFTdaqfx6HErnv0aXkCJn+eBGN-kfeznN8H+f3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-10-19 at 22:14 +0800, Marco Elver wrote:
> On Tue, 19 Oct 2021 at 14:04, Kuan-Ying Lee <
> Kuan-Ying.Lee@mediatek.com> wrote:
> > 
> > There are multiple kasan modes. It make sense that we add some
> > messages
> > to know which kasan mode is when booting up. see [1].
> > 
> > Link: 
> > https://urldefense.com/v3/__https://bugzilla.kernel.org/show_bug.cgi?id=212195__;!!CTRNKA9wMg0ARbw!374SjX0W47zTqp1xJyIg9CW0T7ggAT1rr981lIRBjQhUk2_495ltG_ZkiW6jmeVDBvu_UA$
> > $  [1]
> > Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> 
> Looks good, however, you need to rebase to -next because of "kasan:
> Extend KASAN mode kernel parameter"...

Thanks Marco.
I will send the v2.

> 
> > ---
> >  arch/arm64/mm/kasan_init.c | 2 +-
> >  mm/kasan/hw_tags.c         | 4 +++-
> >  mm/kasan/sw_tags.c         | 2 +-
> >  3 files changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/mm/kasan_init.c
> > b/arch/arm64/mm/kasan_init.c
> > index 61b52a92b8b6..b4e78beac285 100644
> > --- a/arch/arm64/mm/kasan_init.c
> > +++ b/arch/arm64/mm/kasan_init.c
> > @@ -293,7 +293,7 @@ void __init kasan_init(void)
> >         kasan_init_depth();
> >  #if defined(CONFIG_KASAN_GENERIC)
> >         /* CONFIG_KASAN_SW_TAGS also requires kasan_init_sw_tags().
> > */
> > -       pr_info("KernelAddressSanitizer initialized\n");
> > +       pr_info("KernelAddressSanitizer initialized (generic)\n");
> >  #endif
> >  }
> > 
> > diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> > index 05d1e9460e2e..3e28ecbe1d8f 100644
> > --- a/mm/kasan/hw_tags.c
> > +++ b/mm/kasan/hw_tags.c
> > @@ -168,7 +168,9 @@ void __init kasan_init_hw_tags(void)
> >                 break;
> >         }
> > 
> > -       pr_info("KernelAddressSanitizer initialized\n");
> > +       pr_info("KernelAddressSanitizer initialized (hw-tags,
> > mode=%s, stacktrace=%s)\n",
> > +               kasan_flag_async ? "async" : "sync",
> 
> ... which means this will have a 3rd option "asymm".

Thanks for the reminder.

> 
> > +               kasan_stack_collection_enabled() ? "on" : "off");
> >  }
> > 
> >  void kasan_alloc_pages(struct page *page, unsigned int order,
> > gfp_t flags)
> > diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> > index bd3f540feb47..77f13f391b57 100644
> > --- a/mm/kasan/sw_tags.c
> > +++ b/mm/kasan/sw_tags.c
> > @@ -42,7 +42,7 @@ void __init kasan_init_sw_tags(void)
> >         for_each_possible_cpu(cpu)
> >                 per_cpu(prng_state, cpu) = (u32)get_cycles();
> > 
> > -       pr_info("KernelAddressSanitizer initialized\n");
> > +       pr_info("KernelAddressSanitizer initialized (sw-tags)\n");
> >  }
> > 
> >  /*
> > --
> > 2.18.0
> 
> 

