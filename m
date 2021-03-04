Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4741E32D52B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 15:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239707AbhCDOUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 09:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbhCDOUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 09:20:24 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE444C06175F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 06:19:43 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id a13so30260386oid.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 06:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B6t/iRhxaz6mIiZvKsR4Ph8NTlJXLnsmBsm+Fu3vxVg=;
        b=quhqijAStrtqg5ulDL8MGpWooN+jj/XfkXFrXOHChG+J0Oemh8uM8ai2LV5B+F6Eut
         r8V4BpaHEpFUfLTqPIN+90zfn75GVB3k0S/oQAv2I+Aw36bQ9iYBhAe+h2AZUck6BymN
         VwzSaRmrFMQbf62lgTkidT+fkQ1A0ZZNFOMoopUMlCyOegUrN64rTDSKe1hk7NmpGZ/+
         LsIH6tMgoMpp443DS38ej45RsxzE4oDVXFJnKxX3RW1Qz28u3eivry7XYwcQnsA9kcII
         /H4U+uebWqVm2SL79rMMbIUHw8/AZI8KS4A2yT6RZxp1RcCvIkpGXXXZtMYISNt42k17
         AAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B6t/iRhxaz6mIiZvKsR4Ph8NTlJXLnsmBsm+Fu3vxVg=;
        b=hVL432nGQS5uJ7OJgjTm+Qph6TpN9crZyKFPtlBcCNjpa5BAgoQGFTt6+VQdEHeB4z
         0BBjVb+Kjih3TbAHIStFyYjMXSGlMtLzGk/WI8ZU1+2DWRWojFHsskNkkPaFge9s/s+6
         1ylRAMERyJJAQZNC5VjagWh4Ya7jqzx4T3BpLSmTVIdvuIKnqylTQSPHa6RCSO+juiC2
         kFBazb/yFfqGS+bY++BITZnUpGiuDU8zi6u0wZMj7tJ3dKK2zMSYfojGLHLFnrp6P5Q+
         T/Tw0ScJxXC7UU+2y9FLTqN84QHBNYjV/NXNbPI47k7QFHcDtFjl917R4toewotLiDjo
         3wxw==
X-Gm-Message-State: AOAM530+oslmRgglQo/CjEE7jit5To+8lYYH5dtTbZCEKN89QKUgwfQl
        88TpkgSI5zHNTFOqzu2DvvMyrjmitbuyXGLZC9oxJA==
X-Google-Smtp-Source: ABdhPJzJI7yCwzMLMX1b761deV6PDEKQd9CTsXE0xJshW05ZxAu+oLRYKuaZk9HZRGXQh5jybV4MkzuL1G4A0DLbxoM=
X-Received: by 2002:aca:d515:: with SMTP id m21mr3162609oig.172.1614867583032;
 Thu, 04 Mar 2021 06:19:43 -0800 (PST)
MIME-Version: 1.0
References: <CAG_fn=WFffkVzqC9b6pyNuweFhFswZfa8RRio2nL9-Wq10nBbw@mail.gmail.com>
 <f806de26-daf9-9317-fdaa-a0f7a32d8fe0@csgroup.eu> <CANpmjNPGj4C2rr2FbSD+FC-GnWUvJrtdLyX5TYpJE_Um8CGu1Q@mail.gmail.com>
 <08a96c5d-4ae7-03b4-208f-956226dee6bb@csgroup.eu> <CANpmjNPYEmLtQEu5G=zJLUzOBaGoqNKwLyipDCxvytdKDKb7mg@mail.gmail.com>
 <ad61cb3a-2b4a-3754-5761-832a1dd0c34e@csgroup.eu> <CANpmjNOnVzei7frKcMzMHxaDXh5NvTA-Wpa29C2YC1GUxyKfhQ@mail.gmail.com>
 <f036c53d-7e81-763c-47f4-6024c6c5f058@csgroup.eu> <CANpmjNMn_CUrgeSqBgiKx4+J8a+XcxkaLPWoDMUvUEXk8+-jxg@mail.gmail.com>
 <7270e1cc-bb6b-99ee-0043-08a027b8d83a@csgroup.eu> <YEDXJ5JNkgvDFehc@elver.google.com>
 <4b46ecc9-ae47-eee1-843e-e0638a356b51@csgroup.eu>
In-Reply-To: <4b46ecc9-ae47-eee1-843e-e0638a356b51@csgroup.eu>
From:   Marco Elver <elver@google.com>
Date:   Thu, 4 Mar 2021 15:19:31 +0100
Message-ID: <CANpmjNMMMyvsF23U_5HCUe=k7eGaF-WwKV6=YZ81OJedAd2DBQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] powerpc: Enable KFENCE for PPC32
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Alexander Potapenko <glider@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2021 at 15:08, Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 04/03/2021 =C3=A0 13:48, Marco Elver a =C3=A9crit :
> >  From d118080eb9552073f5dcf1f86198f3d86d5ea850 Mon Sep 17 00:00:00 2001
> > From: Marco Elver <elver@google.com>
> > Date: Thu, 4 Mar 2021 13:15:51 +0100
> > Subject: [PATCH] kfence: fix reports if constant function prefixes exis=
t
> >
> > Some architectures prefix all functions with a constant string ('.' on
> > ppc64). Add ARCH_FUNC_PREFIX, which may optionally be defined in
> > <asm/kfence.h>, so that get_stack_skipnr() can work properly.
>
>
> It works, thanks.
>
> >
> > Link: https://lkml.kernel.org/r/f036c53d-7e81-763c-47f4-6024c6c5f058@cs=
group.eu
> > Reported-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Signed-off-by: Marco Elver <elver@google.com>
>
> Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Thanks, I'll send this to Andrew for inclusion in -mm, since this is
not a strict dependency (it'll work without the patch, just the stack
traces aren't that pretty but still useful). If the ppc patches and
this make it into the next merge window, everything should be good for
5.13.

> > ---
> >   mm/kfence/report.c | 18 ++++++++++++------
> >   1 file changed, 12 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/kfence/report.c b/mm/kfence/report.c
> > index 519f037720f5..e3f71451ad9e 100644
> > --- a/mm/kfence/report.c
> > +++ b/mm/kfence/report.c
> > @@ -20,6 +20,11 @@
> >
> >   #include "kfence.h"
> >
> > +/* May be overridden by <asm/kfence.h>. */
> > +#ifndef ARCH_FUNC_PREFIX
> > +#define ARCH_FUNC_PREFIX ""
> > +#endif
> > +
> >   extern bool no_hash_pointers;
> >
> >   /* Helper function to either print to a seq_file or to console. */
> > @@ -67,8 +72,9 @@ static int get_stack_skipnr(const unsigned long stack=
_entries[], int num_entries
> >       for (skipnr =3D 0; skipnr < num_entries; skipnr++) {
> >               int len =3D scnprintf(buf, sizeof(buf), "%ps", (void *)st=
ack_entries[skipnr]);
> >
> > -             if (str_has_prefix(buf, "kfence_") || str_has_prefix(buf,=
 "__kfence_") ||
> > -                 !strncmp(buf, "__slab_free", len)) {
> > +             if (str_has_prefix(buf, ARCH_FUNC_PREFIX "kfence_") ||
> > +                 str_has_prefix(buf, ARCH_FUNC_PREFIX "__kfence_") ||
> > +                 !strncmp(buf, ARCH_FUNC_PREFIX "__slab_free", len)) {
> >                       /*
> >                        * In case of tail calls from any of the below
> >                        * to any of the above.
> > @@ -77,10 +83,10 @@ static int get_stack_skipnr(const unsigned long sta=
ck_entries[], int num_entries
> >               }
> >
> >               /* Also the *_bulk() variants by only checking prefixes. =
*/
> > -             if (str_has_prefix(buf, "kfree") ||
> > -                 str_has_prefix(buf, "kmem_cache_free") ||
> > -                 str_has_prefix(buf, "__kmalloc") ||
> > -                 str_has_prefix(buf, "kmem_cache_alloc"))
> > +             if (str_has_prefix(buf, ARCH_FUNC_PREFIX "kfree") ||
> > +                 str_has_prefix(buf, ARCH_FUNC_PREFIX "kmem_cache_free=
") ||
> > +                 str_has_prefix(buf, ARCH_FUNC_PREFIX "__kmalloc") ||
> > +                 str_has_prefix(buf, ARCH_FUNC_PREFIX "kmem_cache_allo=
c"))
> >                       goto found;
> >       }
> >       if (fallback < num_entries)
> >
