Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2113644EAE2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 16:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbhKLP6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 10:58:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:45104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229841AbhKLP6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 10:58:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD59560F45;
        Fri, 12 Nov 2021 15:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636732556;
        bh=ZdLwxjYgTxXkalzhkw/k7vZBpw+xVc13rs6AD5fASgg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cQA3hSJ/X2TBdwjuoxUmnkSL6ITzQys0CR8b/iU6eQ26IdEpgaNxux1vkFl/dIktW
         6ZiP+5iM10fkF4fkC01690EwYySFOfhsSYKbe2kQbyt+zSPOi9US5uq885mzxwrdSO
         9cFBE8Hb9uLd1DmZwmP+b0SFq1Z2mv60HviDp2++lREtH3M+MGLXK+/+fYgnIpDh9S
         +1KzFkfT4rZwfTcca7Szi2PKxjMlftOi6cM8STEgfB2Ym1OmhCiyonOQcN00PZSOiq
         4SeF9vuUjkNpLY1kXghrQy36jyTTryn/roosmloa2kx2+EZSHUiEql9ul5t5RqbS3j
         l08sR7g5HM73Q==
Received: by mail-ed1-f46.google.com with SMTP id e3so3060916edu.4;
        Fri, 12 Nov 2021 07:55:56 -0800 (PST)
X-Gm-Message-State: AOAM530kzn1FA24yk1oRsIzFk1PsXpbZnn17hmSW3MGTzH2LFll276au
        HzRmqLtr3AlVfJHeftfnLuO1N3gaODIx+BE50g==
X-Google-Smtp-Source: ABdhPJxMSbQEPedZftdSDnp2XKnzGwwj8IAex8jyauOxAcT5jmt9rQALJLlQpj+ehikSpWj59+z0u9Zvy82e2SfjGbs=
X-Received: by 2002:a17:907:7f25:: with SMTP id qf37mr20901805ejc.147.1636732555191;
 Fri, 12 Nov 2021 07:55:55 -0800 (PST)
MIME-Version: 1.0
References: <20211112143644.434995-1-maz@kernel.org> <20211112150415.GA1401861@bhelgaas>
 <87fss18kb5.wl-maz@kernel.org>
In-Reply-To: <87fss18kb5.wl-maz@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 12 Nov 2021 09:55:43 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLumnN6bExJ22SkngCiYsN8LwD=q8ov8wk0zvE3-UKdzg@mail.gmail.com>
Message-ID: <CAL_JsqLumnN6bExJ22SkngCiYsN8LwD=q8ov8wk0zvE3-UKdzg@mail.gmail.com>
Subject: Re: [PATCH] of/irq: Don't ignore interrupt-controller when
 interrupt-map failed
To:     Marc Zyngier <maz@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 9:28 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 12 Nov 2021 15:04:15 +0000,
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Fri, Nov 12, 2021 at 02:36:44PM +0000, Marc Zyngier wrote:
> > > Since 041284181226 ("of/irq: Allow matching of an interrupt-map local
> > > to an interrupt controller"), the irq code favors using an interrupt-map
> > > over a interrupt-controller property if both are available, while the
> > > earlier behaviour was to ignore the interrupt-map altogether.
> > >
> > > However, we now end-up with the opposite behaviour, which is to
> > > ignore the interrupt-controller property even if the interrupt-map
> > > fails to match its input. This new behaviour breaks the AmigaOne
> > > X1000 machine, which ships with an extremely "creative" (read:
> > > broken) device tree.
> > >
> > > Fix this by allowing the interrupt-controller property to be selected
> > > when interrupt-map fails to match anything.
> > >
> > > Fixes: 041284181226 ("of/irq: Allow matching of an interrupt-map local to an interrupt controller")
> > > Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > Link: https://lore.kernel.org/r/78308692-02e6-9544-4035-3171a8e1e6d4@xenosoft.de
> > > Cc: Rob Herring <robh@kernel.org>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> >
> > I'm not qualified to review this, but since 041284181226 was merged
> > via my tree along with the rest of the Apple stuff, let me know if
> > you'd like me to merge this.
> >
> > I see Rob has a comment, so if you want to take care merging it
> > yourself, that's certainly fine with me.
>
> I have a couple of IRQ patches that need to go in, so happy to route
> it via the irqchip tree if Rob gives his blessing.

I have stuff for rc1 too, but feel free to take it:

With the WARN added,

Reviewed-by: Rob Herring <robh@kernel.org>
