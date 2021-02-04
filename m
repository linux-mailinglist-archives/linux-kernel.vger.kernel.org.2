Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE20C30F74D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237783AbhBDQJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 11:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237770AbhBDQHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 11:07:03 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CAEC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 08:06:22 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id b21so2414785pgk.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 08:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W/NQRUXI9589A4ZazyD5B/LtPSn045ZMqU/tdzMr9Nk=;
        b=JgOhI2CE0T4LUdKT1fNmcpcfxpFaTbmeD/PHPA8CRSr65dVrRds/cSyg4PeLsHi9va
         rb7k1a2QLMjZtQ2EAuXDIB2suLVzIChIynDNg1JqBJZ0XWotXWgks2h3Ppmr7OJbBc0J
         gMNEwgEFZr1r4B5ixaJ7iinkzL3hyF+FPYENCvP7td6ajRt2oFj01nI5vO/6LEjRjXa+
         iwV5wknuqwIRHrL47qipSp5mBVWsOZdnW9MU8yTWzGs8NaA4ruqnpzqd/FR4wlWPDajT
         s1onThyOpAw1/tmUqbLwvNgkyUAUszcwINQreZmG33C3ONiOJYm3yrAw4E9y7991+vFQ
         zkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W/NQRUXI9589A4ZazyD5B/LtPSn045ZMqU/tdzMr9Nk=;
        b=kkUx1/Da0QLUNO5X7mUzio3IibF1EOhRvHX297ehIVD4EUZKIpbcr6qjwtjTs0Dg8w
         KvMYvrYrDVGHb69vgQ+N5kks5btGuFs7su6vZv21ruJFwOGMKKaHsi6Q3KcmZUfMyjPK
         Rogt+MEwDlt7Frgo9wPRasOcB8TrTtEVeLV0vZeEwdkPDdQhY3coQVnwuE8gJthVD/wx
         4EmyTuT4gK/ZE0tVvoVoBpQ6SH24YxDx6Lu5Eke5OUPb5dXMkb1mNiCoTQLaZARkSwSG
         Gt6hsab57hOPWENXMRTBsMEt63m99DoLmjz9cOrcu61f8FSvCxOw/tz8vcLMjusxe5ys
         RnIg==
X-Gm-Message-State: AOAM531NJxaBUiW8YNYhPMuJCZVC8187+7JA+Qsodc8QKGA9Clz1gNtD
        Bg5HhOiqqdn0FFmpyrGadUvqpoCyiW88qwV622M=
X-Google-Smtp-Source: ABdhPJxjFrtCvT2r/ewWjgUTbJGr+6RgPWro771pobQ/EYHPZG4jzCn1uGBr8IE5HSf2YkMBmWchslziqzV5pz8gl0w=
X-Received: by 2002:a63:5c0a:: with SMTP id q10mr9681668pgb.277.1612454781557;
 Thu, 04 Feb 2021 08:06:21 -0800 (PST)
MIME-Version: 1.0
References: <20210204124658.GB20468@willie-the-truck> <20210204145127.75856-1-lecopzer@gmail.com>
 <20210204145547.GD20815@willie-the-truck>
In-Reply-To: <20210204145547.GD20815@willie-the-truck>
From:   Lecopzer Chen <lecopzer@gmail.com>
Date:   Fri, 5 Feb 2021 00:06:10 +0800
Message-ID: <CANr2M1-=ONun5fLNoODftmfcuWw49hj9yXsrxkqrfCEtELX1hw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] arm64: kasan: abstract _text and _end to KERNEL_START/END
To:     Will Deacon <will@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>, ardb@kernel.org,
        aryabinin@virtuozzo.com, broonie@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        dan.j.williams@intel.com, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>, gustavoars@kernel.org,
        kasan-dev@googlegroups.com,
        Jian-Lin Chen <lecopzer.chen@mediatek.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-mm@kvack.org,
        linux@roeck-us.net, robin.murphy@arm.com, rppt@kernel.org,
        tyhicks@linux.microsoft.com, vincenzo.frascino@arm.com,
        yj.chiang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think it would be better to leave this for you since I'm not
familiar with the relationship
between vmemmap() and NUMA_NO_NODE.

So I would just keep this patch in next version, is this fine with you?


Thanks for your help:)

Lecopzer



Will Deacon <will@kernel.org> =E6=96=BC 2021=E5=B9=B42=E6=9C=884=E6=97=A5 =
=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8810:55=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, Feb 04, 2021 at 10:51:27PM +0800, Lecopzer Chen wrote:
> > > On Sat, Jan 09, 2021 at 06:32:50PM +0800, Lecopzer Chen wrote:
> > > > Arm64 provide defined macro for KERNEL_START and KERNEL_END,
> > > > thus replace them by the abstration instead of using _text and _end=
.
> > > >
> > > > Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> > > > ---
> > > >  arch/arm64/mm/kasan_init.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.=
c
> > > > index 39b218a64279..fa8d7ece895d 100644
> > > > --- a/arch/arm64/mm/kasan_init.c
> > > > +++ b/arch/arm64/mm/kasan_init.c
> > > > @@ -218,8 +218,8 @@ static void __init kasan_init_shadow(void)
> > > >   phys_addr_t pa_start, pa_end;
> > > >   u64 i;
> > > >
> > > > - kimg_shadow_start =3D (u64)kasan_mem_to_shadow(_text) & PAGE_MASK=
;
> > > > - kimg_shadow_end =3D PAGE_ALIGN((u64)kasan_mem_to_shadow(_end));
> > > > + kimg_shadow_start =3D (u64)kasan_mem_to_shadow(KERNEL_START) & PA=
GE_MASK;
> > > > + kimg_shadow_end =3D PAGE_ALIGN((u64)kasan_mem_to_shadow(KERNEL_EN=
D));
> > > >
> > > >   mod_shadow_start =3D (u64)kasan_mem_to_shadow((void *)MODULES_VAD=
DR);
> > > >   mod_shadow_end =3D (u64)kasan_mem_to_shadow((void *)MODULES_END);
> > > > @@ -241,7 +241,7 @@ static void __init kasan_init_shadow(void)
> > > >   clear_pgds(KASAN_SHADOW_START, KASAN_SHADOW_END);
> > > >
> > > >   kasan_map_populate(kimg_shadow_start, kimg_shadow_end,
> > > > -                    early_pfn_to_nid(virt_to_pfn(lm_alias(_text)))=
);
> > > > +                    early_pfn_to_nid(virt_to_pfn(lm_alias(KERNEL_S=
TART))));
> > >
> > > To be honest, I think this whole line is pointless. We should be able=
 to
> > > pass NUMA_NO_NODE now that we're not abusing the vmemmap() allocator =
to
> > > populate the shadow.
> >
> > Do we need to fix this in this series? it seems another topic.
> > If not, should this patch be removed in this series?
>
> Since you're reposting anyway, you may as well include a patch doing that=
.
> If you don't, then I will.
>
> Will
