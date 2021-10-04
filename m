Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40E8421123
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 16:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbhJDOPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 10:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbhJDOPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 10:15:06 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C11AC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 07:13:17 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id d20so2980822qvm.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 07:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L+EigblI9CZVllHodJ0Te18frEx7k8TQPFGdDTx1ZMk=;
        b=dN3sI9wi6JeJJtKSMg2tECQmmTe3Sz9G57jImMDlA//qjnJDmEWmjM4yvPAz22exhC
         8hXE0FfZ0Ye0LHI7bX/uNX3+XsxFVmlogAET4kXGSrlqib9i98ig6M2+sYvXwq/LTn6Q
         B4LCiUqe+ZP71TbQXmPACKX8zFnNi36Y0WTtPYN7YiJ61s9cL6DGTLdePmMX67AzB2FI
         jLWXMWoBQKIBHfbdEBts+YA0a2ObWBadYVIT1wefcvp3x5z0GW5XIlplsAM7VhfSfmUq
         h3mByEmhvZBNDffghr/ey2T8KJ1OHkqUG++aAOA02a+2cOyR3KW0vKShj6TssNAAS/2A
         deEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L+EigblI9CZVllHodJ0Te18frEx7k8TQPFGdDTx1ZMk=;
        b=F9121LE0COfPE/nJZ47xgE8KtmrEBUxMHA4F9U9afVcEVUYdZaQQaxPfizs2Hhh3AN
         sGMxQrZTWzapANDOMBidt22k7W3DzDffFPrjrZaMz5bXcTHM6qUj4oBERiFUI6yf6fkG
         d0bsZZktM1v9kfb0FL00cn7qSk5Z6peIFeuiloVa1c6oV2+Mt++RfChtq2tYvzO8jrRm
         hPzu2RxtT8CjLodXE40FCrGEAJaaOE2cJ2KgZQ8ZFgNph10KeZTueaO402jq1Yw6tf3g
         4kfFuUUAdROOY5GhW687tPR53zpX+6SKLY0Dp7G+LT/ENaxorbng12/IKpQ0QrhGlRq1
         1lsw==
X-Gm-Message-State: AOAM530HRMX67qvt7WYGScxh3C0Sq4Icrqghqb/JgPEl5UItbI1DH35v
        pAQYP1Jj11/Wz6O86IYIUewy9giPQqoSoyppXfVlIw==
X-Google-Smtp-Source: ABdhPJzv8CAcyUpu5c1jJtxRXkpX+dENIvXy1k9mVhPqg1+C5B9Epg9UR8/6F5Ssz3WrMGSLYHs4RliEuaqaDggbzfU=
X-Received: by 2002:a0c:b3c9:: with SMTP id b9mr23582577qvf.40.1633356796361;
 Mon, 04 Oct 2021 07:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631121222.git.greentime.hu@sifive.com> <3b2d4ff556d310ed73a6910b89566a195fc28861.1631121222.git.greentime.hu@sifive.com>
 <20210915222937.49066323@xhacker>
In-Reply-To: <20210915222937.49066323@xhacker>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Mon, 4 Oct 2021 22:13:05 +0800
Message-ID: <CAHCEeh+qLpGy9VRKgFw57zNs8J5BWYYArJpTobcz98+mKJW2yQ@mail.gmail.com>
Subject: Re: [RFC PATCH v8 20/21] riscv: Optimize task switch codes of vector
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jisheng Zhang <jszhang3@mail.ustc.edu.cn> =E6=96=BC 2021=E5=B9=B49=E6=9C=88=
15=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:36=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Thu,  9 Sep 2021 01:45:32 +0800
> Greentime Hu <greentime.hu@sifive.com> wrote:
>
> > This patch replacees 2 instructions with 1 instruction to do the same t=
hing
> > . rs1=3Dx0 with rd !=3D x0 is a special form of the instruction that se=
ts vl to
> > MAXVL.
>
> Similarly, the vector.S is newly introduced in this patch set, so could
> this optimization be folded into the __vstate_save and __vstate_restore
> introduction patch? Or it's better to keep this optimizaion in commit log=
?
>
Yeah, I wanted to keep the optimization commit log before, but it's ok
if you think merge code is easier to read.
I'll merge this patch in the next version.

> >
> > Suggested-by: Andrew Waterman <andrew@sifive.com>
> > Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > ---
> >  arch/riscv/kernel/vector.S | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/vector.S b/arch/riscv/kernel/vector.S
> > index 4f0c5a166e4e..f7223c81b11a 100644
> > --- a/arch/riscv/kernel/vector.S
> > +++ b/arch/riscv/kernel/vector.S
> > @@ -27,8 +27,7 @@
> >  #define x_vl     t2
> >  #define x_vcsr   t3
> >  #define incr     t4
> > -#define m_one    t5
> > -#define status   t6
> > +#define status   t5
> >
> >  ENTRY(__vstate_save)
> >       li      status, SR_VS
> > @@ -38,8 +37,7 @@ ENTRY(__vstate_save)
> >       csrr    x_vtype, CSR_VTYPE
> >       csrr    x_vl, CSR_VL
> >       csrr    x_vcsr, CSR_VCSR
> > -     li      m_one, -1
> > -     vsetvli incr, m_one, e8, m8
> > +     vsetvli incr, x0, e8, m8
> >       vse8.v   v0, (datap)
> >       add     datap, datap, incr
> >       vse8.v   v8, (datap)
> > @@ -61,8 +59,7 @@ ENTRY(__vstate_restore)
> >       li      status, SR_VS
> >       csrs    CSR_STATUS, status
> >
> > -     li      m_one, -1
> > -     vsetvli incr, m_one, e8, m8
> > +     vsetvli incr, x0, e8, m8
> >       vle8.v   v0, (datap)
> >       add     datap, datap, incr
> >       vle8.v   v8, (datap)
>
>
