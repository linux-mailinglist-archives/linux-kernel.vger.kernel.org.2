Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012A64532B3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 14:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbhKPNRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 08:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbhKPNRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 08:17:38 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E92CC061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 05:14:41 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id g1so12048705qvd.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 05:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uZ1JuaUurJ9x7hs8AmvOJPLM2vmz4I11pNUxZE6cU4A=;
        b=GYhuZckZyPch3cWPxRwVuhSACCyfJ9LvSvEOmEoKHNzsFW3RjCtI/rYEQhBt0MIfJ6
         z0vsuWNxbti9RSCG6M6jSYp09YO9FUvvpg3cQIgZqj+2eKocH7GdxWM8bhkiWbER11Qi
         ruAB3xwON1CIKqPCwUsAKQE69+ObohnVciVrRTwZsqcypeA0bsxu/qPg9Th/D56O76PQ
         AoYDgBVDOBnWVqe1llr5qsa01yQWEHLznmqNS8FniM0O0IBgGBqV0oBuD/apSSo/PhQY
         yd+NF3cLaxMqWLncyg/z6XAXEBIEQCXfliSX8srvAWFsK8rEWyc/mvxzRpJSZcETHdE7
         MdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uZ1JuaUurJ9x7hs8AmvOJPLM2vmz4I11pNUxZE6cU4A=;
        b=zH5Mnp0geoY8DDAFP5nWFpp2XqqeX9BYAhNLoS5yrXhPqi/8KLZCpShPdop+n23NHn
         ryt/ikMZHjSPK29bAeDLSxzhb/yxG46n11WWhrYnsjpFEVq+XGNoZlx0nVnXNMScCkIW
         X+ZXwiCipu4vr179lLlzj8zSFDNevzMvwus1GO8WYx0xfl5evbZ1D7Brias7m888rV7Z
         XqtPBuEWumrryNX/Fi365KnQYXqpW9wWtmC1ILjchSLbc10JXpCqE25hesdBxSLWbJoe
         YLJTl9aQnvsxn43rNbnTJoOa8Rf3lvoVspbqo6gJiolvbArbLbpJ1e5tw7uoNie13vFU
         teGA==
X-Gm-Message-State: AOAM530RcF0KkJyd5Chi0i/X9080z3ltomihxb6MCan3BiwmfeqcBL6w
        WcC3zahYEPqSkXCX2guPoG5NkofqVfgiYT46Ftk9GbDUEYc=
X-Google-Smtp-Source: ABdhPJyIYcXYXWAl1wi6t8pJ+NbgIFtrqgJBffDghsKj2nKZd2NnxnFgZbgG5dz3q/GKi2TWlP21zEdimL5TohOPvOo=
X-Received: by 2002:a05:6214:529e:: with SMTP id kj30mr46523085qvb.50.1637068480091;
 Tue, 16 Nov 2021 05:14:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1636362169.git.greentime.hu@sifive.com> <3c0297d8335e4cac54a4397c880092c1c983e04e.1636362169.git.greentime.hu@sifive.com>
 <2d08f105-64fd-a43a-1dea-24870ff7c5b0@codethink.co.uk>
In-Reply-To: <2d08f105-64fd-a43a-1dea-24870ff7c5b0@codethink.co.uk>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Tue, 16 Nov 2021 21:14:29 +0800
Message-ID: <CAHCEehLnX6hAr6uRYy4BxzuBhTp64wn0yCVGJ85+0aS88OeKtA@mail.gmail.com>
Subject: Re: [PATCH v9 16/17] riscv: Fix an illegal instruction exception when
 accessing vlenb without enable vector first
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Dooks <ben.dooks@codethink.co.uk> =E6=96=BC 2021=E5=B9=B411=E6=9C=8810=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:38=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 09/11/2021 09:48, Greentime Hu wrote:
> > It triggered an illegal instruction exception when accessing vlenb CSR
> > without enable vector first. To fix this issue, we should enable vector
> > before using it and disable vector after using it.
> >
> > Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > ---
> >   arch/riscv/include/asm/vector.h        | 2 ++
> >   arch/riscv/kernel/cpufeature.c         | 2 ++
> >   arch/riscv/kernel/kernel_mode_vector.c | 6 ++++--
> >   3 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/v=
ector.h
> > index 5d7f14453f68..ca063c8f47f2 100644
> > --- a/arch/riscv/include/asm/vector.h
> > +++ b/arch/riscv/include/asm/vector.h
> > @@ -8,6 +8,8 @@
> >
> >   #include <linux/types.h>
> >
> > +void rvv_enable(void);
> > +void rvv_disable(void);
> >   void kernel_rvv_begin(void);
> >   void kernel_rvv_end(void);
> >
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index 8e7557980faf..0139ec20adce 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -159,7 +159,9 @@ void __init riscv_fill_hwcap(void)
> >       if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
> >               static_branch_enable(&cpu_hwcap_vector);
> >               /* There are 32 vector registers with vlenb length. */
> > +             rvv_enable();
> >               riscv_vsize =3D csr_read(CSR_VLENB) * 32;
> > +             rvv_disable();
> >       }
> >   #endif
>
> Would it be better to enable this here, and then restore the original
> state instead of calling rvv_disable? If it was enabled then maybe
> something else is going to rely on that state?
>
> Maybe something like:
>
>                 prev =3D rvv_enable()
>                 riscv_vsize =3D csr_read(CSR_VLENB) * 32;
>                 rvv_restore(prev);
>
>
Hi Ben,

Thank you for reviewing this. The rvv won't be enabled here because we
disable it in head.S at beginning and this stage is still doing some
initialization work for rvv to set riscv_vsize, so we can assume that
kernel mode vector should not be allowed to use vector yet.

> >   }
> > diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel=
/kernel_mode_vector.c
> > index 8d2e53ea25c1..1ecb6ec5c56d 100644
> > --- a/arch/riscv/kernel/kernel_mode_vector.c
> > +++ b/arch/riscv/kernel/kernel_mode_vector.c
> > @@ -71,15 +71,17 @@ static void put_cpu_vector_context(void)
> >       preempt_enable();
> >   }
> >
> > -static void rvv_enable(void)
> > +void rvv_enable(void)
> >   {
> >       csr_set(CSR_STATUS, SR_VS);
> >   }
> > +EXPORT_SYMBOL(rvv_enable);
> >
> > -static void rvv_disable(void)
> > +void rvv_disable(void)
> >   {
> >       csr_clear(CSR_STATUS, SR_VS);
> >   }
> > +EXPORT_SYMBOL(rvv_disable);
> >
> >   /*
> >    * kernel_rvv_begin(): obtain the CPU vector registers for use by the=
 calling
> >
>
>
> --
> Ben Dooks                               http://www.codethink.co.uk/
> Senior Engineer                         Codethink - Providing Genius
>
> https://www.codethink.co.uk/privacy.html
