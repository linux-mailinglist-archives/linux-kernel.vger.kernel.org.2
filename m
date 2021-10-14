Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A9A42D23A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 08:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhJNGTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 02:19:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhJNGTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 02:19:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2280A60FF2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 06:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634192256;
        bh=9oRf2ywKUYIx9o4P7Z9GQDY/5yvvnyq8Qo14mUHKz6o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U8wjJoIKV5Hx3aW6Q6rZnn35Yrjt/wE6irpvl5z5PZSmYEfRYGANoemBq4D81hXsY
         UFuEZCYi2sQyM3ZkpoSXxSPoJwRG5HCFctBFG+2bZ6c9WntS4FWwnbQCYWP6y0yD/0
         i7F0rJeKF3Xku0aN3iFMjzDfp9+v3ZX1/NR0V04TCPT2MqP4u8xOH6bG4izJIZyHzU
         MBw/3gpOjDMeK+vX+PlgL1zR496NCZ8G7lAHzYvE9mXB2TJx10J9EO9mtIk5JG8jgz
         gHyrRLV6nvlL3NXZWmMY359+hlRSTnCrkmXsEsSmAxo8VMHFpdbgRVhgMQZ43QtF5g
         aoTSrelBZ8TGQ==
Received: by mail-ua1-f54.google.com with SMTP id u5so9121862uao.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 23:17:36 -0700 (PDT)
X-Gm-Message-State: AOAM532JfsXDZFbDIj/4EkSyqPEs06o1Ih6R/n3od85YJH610fuAcox0
        nKqpqDKqY1JJ2NifOjjblvqv3HONA/9Z1jt1f54=
X-Google-Smtp-Source: ABdhPJy6HcIxxoCBhV2jnJFZEl6tEFCL7dsdKK3UdQZLgOOtj3+j/A82aXHYoUu1VLFxDyTnn++CBhliEQ++2d2v460=
X-Received: by 2002:a05:6102:32cd:: with SMTP id o13mr4702722vss.50.1634192255197;
 Wed, 13 Oct 2021 23:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211013012149.2834212-1-guoren@kernel.org> <4245323.jvX0RauA9x@diego>
 <CAAhSdy29WAXfBz6Ag-kAjNo_uhJO+AuC0e-UyWhwhaCmrw7pjw@mail.gmail.com>
 <4027415.QZv1u5a1DM@diego> <CAJF2gTTDZ0QjY9JL=U61=ubWrGWVOe2VBbW6hgzsHqsePgN0Ww@mail.gmail.com>
 <693a609c-4278-84ab-8a9b-448936bb13d0@sholland.org>
In-Reply-To: <693a609c-4278-84ab-8a9b-448936bb13d0@sholland.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 14 Oct 2021 14:17:24 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTpxq_mdVtKZo6DG0CJcawJbZaWnHGokDDgm0WewWi3XA@mail.gmail.com>
Message-ID: <CAJF2gTTpxq_mdVtKZo6DG0CJcawJbZaWnHGokDDgm0WewWi3XA@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: update riscv plic compatible string
To:     Samuel Holland <samuel@sholland.org>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Rob Herring <robh@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 12:21 PM Samuel Holland <samuel@sholland.org> wrote:
>
> On 10/13/21 7:49 AM, Guo Ren wrote:
> >>>>>>>>        - const: sifive,plic-1.0.0
> >>>>>>>
> >>>>>>> The PLIC DT node requires two compatible string:
> >>>>>>> <implementation_compat>, <spec_compat>
> >>>>>>>
> >>>>>>> The C9xx PLIC is not RISC-V PLIC so, the DT node should
> >>>>>>> be: "thead,c900-plic", "thead,c9xx-plic"
> >>>>>>>
> >>>>>>> You need to change "- const: sifive,plic-1.0.0" to
> >>>>>>> - enum:
> >>>>>>>     - sifive,plic-1.0.0
> >>>>>>>     - thead,c9xx-plic
> >>
> >> isn't XuanTie the series containing the c906 and c910?
> > XuanTie contain two CPU series:
> > riscv: c906, c910
> > csky: c807, c810, c860
> >
> >> So maybe
> >>         thead,xuantie-plic
> >> for the spec compatible.
> >>
> >> So doing in full
> >>         compatible = "thead,c906-plic", "thead,xuantie-plic"
> > How about:
> > compatible = "allwinner,d1-plic", "thead,c900-plic"
>
> To follow the <family>-<soc>-<device> pattern of existing Allwinner
> compatibles, the first string should be "allwinner,sun20i-d1-plic".
Thx, Got it.
> Otherwise, this looks to me like the right thing to do.
>
> Regards,
> Samuel



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
