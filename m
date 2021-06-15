Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB193A755F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 05:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhFODuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 23:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhFODt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 23:49:58 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED206C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 20:47:53 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id b9so18484151ybg.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 20:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=honLpRS5BN/c2OkeqRE0xa+BxqCXma5P6oZc4YqSaPE=;
        b=Mg+8v23pivt6Zp5p5+GDfXoaCDNdSAUyb5ugGA1H4TvgXOxNuc3e+P73Ee2LrcGqdr
         Q9cKeOEF020LWaK3asdbZwnCBnswvyl7yJqQw5+ewetqrkt0XodouzDJ0Zi7RlYLeg7z
         82S9yycBLPt5+WPIiWkXXEdxWaWns8XQoEzBxpdgqREQeYFsVISK2s5zrJ9MNBrcO3Uk
         22qUxIfTZBp55zMJfWyLPHiQqixxk873ENISYpesziAAWVrvcZuoWmr44+G4rE4hcFRL
         PORcweIU8HS0Hp8aVdRi2uVVscqlBX3Sj6FRiGGWZ5A73TRoUMx0jQgKZCRpJE1w2fV4
         l5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=honLpRS5BN/c2OkeqRE0xa+BxqCXma5P6oZc4YqSaPE=;
        b=Q/BfwU0porbM7B8NDhcohWeFEGv9MhC6DgR5zjm+Z0WoJW7oByOOjdubXQXlEz+0NQ
         bV4FKG0y7ilvD51p7F5YqPJsjM0C2Dj93EJfznomTwoPvZqns3bS0JMdCAQYSlUVQ+Xw
         uhEQdKvVAH4PWY6CTqPQ5wS5v9pQZAP37shGh/tMXiO5NON5eCng0MVLgEMw09fov5Gj
         Eo6OEWMY8DinRkPAIkxA7icoK+fQCrITPQ7KONYPo3xSINJDPbma3sYqrqj6UBMD1E6A
         4XqTSRKbEv/H+oxfJtLa04VQiYZeuDSH/hciCivZjao/O2J40+SVyUYUV+dUstBPuZpd
         t2EA==
X-Gm-Message-State: AOAM532HRWLKihVYJhdPPT1RcrhnEeLn1hIdwfjgpgG/34Du2NhbMUEK
        laNnHUp5/FvPPoq9marE3gfXAXeOSm6xHj2D/iE=
X-Google-Smtp-Source: ABdhPJx60/JHwFkAApq2VGhT0raLJZpQSP3Rn44dJUEOtivCEVQESrJ+p6+YiIgMvdLOSAxeMzaxSeSzrDsQsOhh/3Y=
X-Received: by 2002:a25:694d:: with SMTP id e74mr4751923ybc.377.1623728872887;
 Mon, 14 Jun 2021 20:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621516826.git.christophe.leroy@csgroup.eu>
 <7062722b087228e42cbd896e39bfdf526d6a340a.1621516826.git.christophe.leroy@csgroup.eu>
 <871r93vqcb.fsf@mpe.ellerman.id.au>
In-Reply-To: <871r93vqcb.fsf@mpe.ellerman.id.au>
From:   Jordan Niethe <jniethe5@gmail.com>
Date:   Tue, 15 Jun 2021 13:47:41 +1000
Message-ID: <CACzsE9pajbu70rm4AAk8=S1zDj6LCfSwemEd+dhRyPw2F4WF+A@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] powerpc: Don't use 'struct ppc_inst' to
 reference instruction location
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 12:01 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> > diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
> > index 5a0740ebf132..32d318c3b180 100644
> > --- a/arch/powerpc/include/asm/inst.h
> > +++ b/arch/powerpc/include/asm/inst.h
> > @@ -139,7 +139,7 @@ static inline int ppc_inst_len(struct ppc_inst x)
> >   * Return the address of the next instruction, if the instruction @value was
> >   * located at @location.
> >   */
> > -static inline struct ppc_inst *ppc_inst_next(void *location, struct ppc_inst *value)
> > +static inline unsigned int *ppc_inst_next(unsigned int *location, unsigned int *value)
> >  {
> >       struct ppc_inst tmp;
> >
>
> It's not visible in the diff, but the rest of the function is:
>
>         tmp = ppc_inst_read(value);
>
>         return location + ppc_inst_len(tmp);
> }
>
> And so changing the type of location from void * to int * changes the
> result of that addition, ie. previously it was in units of bytes, now
> it's units of 4 bytes.
>
> To fix it I've kept location as unsigned int *, and added a cast where
> we do the addition. That way users of the function just see unsigned int *,
> the cast to void * is an implementation detail.
>
> We only have a handful of uses of ppc_inst_len(), so maybe that should
> change name and return a result in units of int *. But that can be a
> separate change.
>
> > diff --git a/arch/powerpc/platforms/86xx/mpc86xx_smp.c b/arch/powerpc/platforms/86xx/mpc86xx_smp.c
> > index 87f524e4b09c..302f2a1e0361 100644
> > --- a/arch/powerpc/platforms/86xx/mpc86xx_smp.c
> > +++ b/arch/powerpc/platforms/86xx/mpc86xx_smp.c
> > @@ -83,7 +83,7 @@ smp_86xx_kick_cpu(int nr)
> >               mdelay(1);
> >
> >       /* Restore the exception vector */
> > -     patch_instruction((struct ppc_inst *)vector, ppc_inst(save_vector));
> > +     patch_instruction(vector, ppc_inst(save_vector));
> >
> >       local_irq_restore(flags);
> >
>
> There was another usage in here:
>
>         /* Setup fake reset vector to call __secondary_start_mpc86xx. */
>         target = (unsigned long) __secondary_start_mpc86xx;
> -       patch_branch((struct ppc_inst *)vector, target, BRANCH_SET_LINK);
> +       patch_branch(vector, target, BRANCH_SET_LINK);
>
>         /* Kick that CPU */
>         smp_86xx_release_core(nr);
>
> I fixed it up.
>
> cheers
fwiw
Reviewed by: Jordan Niethe <jniethe5@gmail.com>
