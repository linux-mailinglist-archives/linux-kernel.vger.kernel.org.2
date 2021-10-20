Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94203434621
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 09:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhJTHtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 03:49:03 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54338 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229544AbhJTHtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 03:49:02 -0400
X-UUID: 391e0a9f321e4572aaeb44daab13c9a6-20211020
X-UUID: 391e0a9f321e4572aaeb44daab13c9a6-20211020
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2121538419; Wed, 20 Oct 2021 15:46:46 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 20 Oct 2021 15:46:41 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 20 Oct
 2021 15:46:40 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 20 Oct 2021 15:46:40 +0800
Message-ID: <c0d7c2aa14cc569d5ad95dc750bb6cc1727a042c.camel@mediatek.com>
Subject: Re: [PATCH v2] kasan: add kasan mode messages when kasan init
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
Date:   Wed, 20 Oct 2021 15:46:40 +0800
In-Reply-To: <CANpmjNNxQRM5rSxcdxNOicpOvwQ=vsutQO3j1hUmGAfS9+pQDA@mail.gmail.com>
References: <20211020061248.13270-1-Kuan-Ying.Lee@mediatek.com>
         <CANpmjNNxQRM5rSxcdxNOicpOvwQ=vsutQO3j1hUmGAfS9+pQDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-10-20 at 15:23 +0800, Marco Elver wrote:
> On Wed, 20 Oct 2021 at 08:13, Kuan-Ying Lee <
> Kuan-Ying.Lee@mediatek.com> wrote:
> > 
> > There are multiple kasan modes. It makes sense that we add some
> > messages
> > to know which kasan mode is when booting up. see [1].
> > 
> > Link: 
> > https://urldefense.com/v3/__https://bugzilla.kernel.org/show_bug.cgi?id=212195__;!!CTRNKA9wMg0ARbw!yylpqk8mnd0N8w6pn4Mn4sIeu-GGlKXcA4I4yXlmstFsuqmpkhaM2V_uu2c6oPMFpZRqoQ$
> > $  [1]
> > Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> > ---
> > change since v2:
> >  - Rebase to linux-next
> >  - HW-tags based mode need to consider asymm mode
> >  - Thanks for Marco's suggestion
> > 
> >  arch/arm64/mm/kasan_init.c |  2 +-
> >  mm/kasan/hw_tags.c         |  4 +++-
> >  mm/kasan/kasan.h           | 10 ++++++++++
> >  mm/kasan/sw_tags.c         |  2 +-
> >  4 files changed, 15 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/mm/kasan_init.c
> > b/arch/arm64/mm/kasan_init.c
> > index 5b996ca4d996..6f5a6fe8edd7 100644
> > --- a/arch/arm64/mm/kasan_init.c
> > +++ b/arch/arm64/mm/kasan_init.c
> > @@ -309,7 +309,7 @@ void __init kasan_init(void)
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
> > index dc892119e88f..1d5c89c7cdfe 100644
> > --- a/mm/kasan/hw_tags.c
> > +++ b/mm/kasan/hw_tags.c
> > @@ -177,7 +177,9 @@ void __init kasan_init_hw_tags(void)
> >                 break;
> >         }
> > 
> > -       pr_info("KernelAddressSanitizer initialized\n");
> > +       pr_info("KernelAddressSanitizer initialized (hw-tags,
> > mode=%s, stacktrace=%s)\n",
> > +               kasan_mode_info(),
> > +               kasan_stack_collection_enabled() ? "on" : "off");
> >  }
> > 
> >  void kasan_alloc_pages(struct page *page, unsigned int order,
> > gfp_t flags)
> > diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> > index aebd8df86a1f..387ed7b6de37 100644
> > --- a/mm/kasan/kasan.h
> > +++ b/mm/kasan/kasan.h
> > @@ -36,6 +36,16 @@ static inline bool
> > kasan_sync_fault_possible(void)
> >  {
> >         return kasan_mode == KASAN_MODE_SYNC || kasan_mode ==
> > KASAN_MODE_ASYMM;
> >  }
> > +
> > +static inline const char *kasan_mode_info(void)
> > +{
> > +       if (kasan_mode == KASAN_MODE_ASYNC)
> > +               return "async";
> > +       else if (kasan_mode == KASAN_MODE_ASYMM)
> > +               return "asymm";
> > +       else
> > +               return "sync";
> > +}
> 
> This creates an inconsistency, because for
> kasan_stack_collection_enabled(), kasan_async_fault_possible(), and
> kasan_sync_fault_possible() there are !KASAN_HW_TAGS stubs.
> 
> A stub for kasan_mode_info() if !KASAN_HW_TAGS appears useless
> though,
> and I wouldn't know what its return value should be.
> 
> Do you expect this helper to be used outside hw_tags.c? If not,
> perhaps just move it into hw_tags.c.

The helper will be used only in hw_tags.c.
I will move it into hw_tags.c in v3.

Thanks.

> 
> Thanks,
> -- Marco

