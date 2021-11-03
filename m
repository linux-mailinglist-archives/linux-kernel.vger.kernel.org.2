Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAED4443B23
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 02:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhKCByv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 21:54:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230185AbhKCByu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 21:54:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D6AC60EDF
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 01:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635904335;
        bh=GaFgSiGy9kAy7Yn9X8sF343u7JFI75FGbA1WsYDXMLc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LaJWHbYESYL1bOiAhHg1NJDL3eegy1nslt2I4q4AeicVc9GcbqVUVvMxJt5wV+2km
         r//I+asOFcX+b/aBUM+bSlBnJUv+eHzSWB8wjwHEE/li6/BDiFzi9JTAuyBLlcgmDQ
         /syw7gbaMwg5wi7n/QC68PfFul/On1I3eVHFRBGPXus2TxWxvUUq1qvUJ4KymIZNHE
         FLN6nwgdZE1uPf1RuiuUKo2n7qCd5a+H4GXumwIQp6Tlk3W2w6ob320o0oqi1gG4TG
         SWj3D5w+w6LeL0oM2y1BSZgaSmDOc3agUlO6oDwDnWOj7krZi3jgLoGa5bPP9ytdM6
         oogrDYrGdx9IA==
Received: by mail-vk1-f176.google.com with SMTP id u130so577400vku.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 18:52:15 -0700 (PDT)
X-Gm-Message-State: AOAM531ML2N49ntrSzf6UUosoMSRP4t/IRjXQkN1tX9lw0DttC/X/dXy
        i8qpmVmW8Rba2q+w3tfXDoJL5ZKQWLdiykHniLY=
X-Google-Smtp-Source: ABdhPJzfpWtVC3prOps6URHAro8Kyf0Vv19yRBoMep6kB+ZgpRAESNiCnCBxD9+MlDpvPjnNb3DCAscnC47d3CRnR8g=
X-Received: by 2002:a05:6122:1682:: with SMTP id 2mr44599788vkl.22.1635904334250;
 Tue, 02 Nov 2021 18:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211024013303.3499461-1-guoren@kernel.org> <20211024013303.3499461-2-guoren@kernel.org>
 <CAJF2gTSDTXu7HsABTHfTbCd2TNpHBpzSMqYGh9Av8kzJ+6AOPw@mail.gmail.com> <CAL_JsqKRizEaqmgVnfMWr2A_AHMFLjDpYNTHahTLPgSAtGYCLg@mail.gmail.com>
In-Reply-To: <CAL_JsqKRizEaqmgVnfMWr2A_AHMFLjDpYNTHahTLPgSAtGYCLg@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 3 Nov 2021 09:52:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR8YrHEP+yZc61-4uqxJTk6OYifBf-+xmyjQppnSAXuqw@mail.gmail.com>
Message-ID: <CAJF2gTR8YrHEP+yZc61-4uqxJTk6OYifBf-+xmyjQppnSAXuqw@mail.gmail.com>
Subject: Re: [PATCH V5 1/3] dt-bindings: vendor-prefixes: add T-Head Semiconductor
To:     Rob Herring <robh@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 8:59 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Nov 1, 2021 at 9:21 PM Guo Ren <guoren@kernel.org> wrote:
> >
> > Hi Rob,
> >
> > ping? If there is no problem, could you help pick up this patch into your tree?
>
> Generally DT patches go with the rest of the series. And you need to
> send them to the DT list so that automated checks run and they are in
> my review queue.
This patch would be separated from these patch sets. I would send it
to you separately next.

>
> >
> > On Sun, Oct 24, 2021 at 9:33 AM <guoren@kernel.org> wrote:
> > >
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > Add vendor prefix for T-Head Semiconductor [1] [2]
> > >
> > > [1] https://github.com/T-head-Semi
> > > [2] https://www.t-head.cn/
> > >
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Cc: Rob Herring <robh@kernel.org>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > ---
> > >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > > index a867f7102c35..f532a8830693 100644
> > > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > > @@ -1169,6 +1169,8 @@ patternProperties:
> > >      description: Terasic Inc.
> > >    "^tfc,.*":
> > >      description: Three Five Corp
> > > +  "^thead,.*":
> > > +    description: T-Head Semiconductor Co., Ltd.
> > >    "^thine,.*":
> > >      description: THine Electronics, Inc.
> > >    "^thingyjp,.*":
> > > --
> > > 2.25.1
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
