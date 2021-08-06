Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB963E2B44
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 15:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343998AbhHFNXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 09:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbhHFNXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 09:23:37 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23136C061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 06:23:21 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id u13so11891557lje.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 06:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MmjOBkvHIeBd9bWc/MfmhkUI2rLK9E02S7b9Xp9vELk=;
        b=seMEqqju9ELt8C3WomJfex6C+ZrixSzyKjl/CLP7LjcVT/hY4kbhbgLAozwy3WlAFz
         KHNhtwmtMh4HrrlC8KM8z3InUPwmuooFw/il2YvYxoCaIONvI6QVDIuJHk88Z5Rr67Gc
         oz/Y9qBcuSjIuRL1toOgCReryGDLPxMZtNp55wtUy7R4m0cM+en2paQIyb5NiK1MxyoT
         OdeQsuEzFIpW6ajCdlUWB2SFpW9qRWW/prONePl8yverNyXqephSCzdTUd6fC8C6ALNa
         23DsBya8Uhr5pG8Odsxs4OA6I3I1jg7vmcIUWgRaiNt5Xo0D7wwBzuVimIBzuOPeOhX4
         qfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MmjOBkvHIeBd9bWc/MfmhkUI2rLK9E02S7b9Xp9vELk=;
        b=QwiFrmMqqDFiZBoyp8OZeeZ3mplba7wZbhBdiFwwK2QWcOcnLhZ29zMVr+XeqsgbjN
         GWPPLXfMPnRbxlNGUPQ8NnFibibEs5PDpREV1tfQF1oKhZPx0Crk4snIKzKS+DYLNfJE
         7+FCEvLt7kIEILRy0NOa4SzGEvHJaHBb/TuLuUcANw9h/fB2f9u+BexzQ8Vb2Kalfc8B
         /0WZsrGGkJCtJD++5FayDeiMYd7gTK17dHt6IbSoR0WyZsAp/rylgmpbXgNveMPuRyiJ
         5I87CanZtq1hpwZ0KXByRriLupsV06JVl14rNQFtVuUYYEdXDUJ2djXygKG/LCtUchX3
         KK4g==
X-Gm-Message-State: AOAM532/jSdAE2F4GEVf7A5/glX4k3WfNaCosF0vX1xoba0rvAsp2I94
        FmrO/DKRWJ7hOXPcUaFs2mK9DKuu2Y4EtmaEtNc=
X-Google-Smtp-Source: ABdhPJza1iLxbvbx1iQeCXHWd/NwaNS5mAAI0qpL5CCtMKnhsx7SiYz6f9ccvbMatJGDImPjnkvSMIENLa0OmJ5Rn2A=
X-Received: by 2002:a2e:4e09:: with SMTP id c9mr6441037ljb.11.1628256199556;
 Fri, 06 Aug 2021 06:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210726143053.532839-1-sxwjean@me.com> <5e2336aa-90bf-b820-b5e4-e9a63088930f@csgroup.eu>
 <CAEVVKH-rht+xpwTUL=ny6qENe2Fb0n=3e7DEmc5qzpSq2_1gTA@mail.gmail.com> <26814448-c30a-1de1-bad4-79e2bffc3054@csgroup.eu>
In-Reply-To: <26814448-c30a-1de1-bad4-79e2bffc3054@csgroup.eu>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Fri, 6 Aug 2021 21:22:52 +0800
Message-ID: <CAEVVKH8wjaR3JqgkWX=X6n00nmPEjcUCHU=_5w_xxjsAWHFcUg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] powerpc: Optimize register usage for esr register
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Xiongwei Song <sxwjean@me.com>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>, oleg@redhat.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, ravi.bangoria@linux.ibm.com,
        npiggin@gmail.com, aneesh.kumar@linux.ibm.com,
        sandipan@linux.ibm.com, efremov@linux.com, peterx@redhat.com,
        akpm@linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 6, 2021 at 3:32 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 06/08/2021 =C3=A0 05:16, Xiongwei Song a =C3=A9crit :
> > On Thu, Aug 5, 2021 at 6:06 PM Christophe Leroy
> > <christophe.leroy@csgroup.eu> wrote:
> >>
> >>
> >>
> >> Le 26/07/2021 =C3=A0 16:30, sxwjean@me.com a =C3=A9crit :
> >>> From: Xiongwei Song <sxwjean@gmail.com>
> >>>
> >>> Create an anonymous union for dsisr and esr regsiters, we can referen=
ce
> >>> esr to get the exception detail when CONFIG_4xx=3Dy or CONFIG_BOOKE=
=3Dy.
> >>> Otherwise, reference dsisr. This makes code more clear.
> >>
> >> I'm not sure it is worth doing that.
> > Why don't we use "esr" as reference manauls mentioned?
> >
> >>
> >> What is the point in doing the following when you know that regs->esr =
and regs->dsisr are exactly
> >> the same:
> >>
> >>   > -    err =3D ___do_page_fault(regs, regs->dar, regs->dsisr);
> >>   > +    if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
> >>   > +            err =3D ___do_page_fault(regs, regs->dar, regs->esr);
> >>   > +    else
> >>   > +            err =3D ___do_page_fault(regs, regs->dar, regs->dsisr=
);
> >>   > +
> > Yes, we can drop this. But it's a bit vague.
> >
> >> Or even
> >>
> >>   > -    int is_write =3D page_fault_is_write(regs->dsisr);
> >>   > +    unsigned long err_reg;
> >>   > +    int is_write;
> >>   > +
> >>   > +    if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
> >>   > +            err_reg =3D regs->esr;
> >>   > +    else
> >>   > +            err_reg =3D regs->dsisr;
> >>   > +
> >>   > +    is_write =3D page_fault_is_write(err_reg);
> >>
> >>
> >> Artificially growing the code for that makes no sense to me.
> >
> > We can drop this too.
> >>
> >>
> >> To avoid anbiguity, maybe the best would be to rename regs->dsisr to s=
omething like regs->sr , so
> >> that we know it represents the status register, which is DSISR or ESR =
depending on the platform.
> >
> > If so, this would make other people more confused. My consideration is
> > to follow what the reference
> > manuals represent.
>
> Maybe then we could rename the fields as regs->dsisr_esr and regs->dar_de=
ar

I still prefer my method.

>
> That would be more explicit for everyone.
>
> The UAPI header however should remain as is because anonymous unions are =
not supported by old
> compilers as mentioned by Michael.

Sure. Will update in v2.

>
> But nevertheless, there are also situations where was is stored in regs->=
dsisr is not what we have
> in DSISR register. For instance on an ISI exception, we store a subset of=
 the content of SRR1
> register into regs->dsisr.

Can I think my method has better expansibility here;-)?
Let me finish esr and dear first. Thank you for the reminder.

Regards,
Xiongwei
>
> Christophe
