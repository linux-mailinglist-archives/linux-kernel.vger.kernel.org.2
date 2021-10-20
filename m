Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C031434E73
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 17:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhJTPCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 11:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhJTPCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 11:02:14 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B559EC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 07:59:59 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id k29so2217965qve.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 07:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluespec-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=j/3Lv9j5XzeFoUK9c1kkMM7KIVmL+kIELhS5/SrGfhA=;
        b=YjVtXyEvQFtd4T9i9G5ZZZiAj2qe//i+Ji5oXF9x/MnnQgZGzMzR/fvzW8tVjWuEWA
         JBtkOs8i1VkDvOEakUBdoRkl5A81jjmgHjy08+5til/e8qH3bUQUtYd2v01yosHlJZRV
         RrzAF/j3m9L1upbUvYqHP1pVKTGn9fGJKevh6Z/i9J5lTHpnyThfEQYVl+PSVGmgJ6UK
         UZS4FykPD2Rgzi4vC5OZr3EAMQGRjjw7rGgo4fFZvz0w1AdSYaB0arRctp7Cs4q304FE
         vRZMJ1sDbpXwcHoI+lWn1puf0iJO5A/3ADOEJzZbR+nzf5luddUM7qSLllk0cespH7WS
         eY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=j/3Lv9j5XzeFoUK9c1kkMM7KIVmL+kIELhS5/SrGfhA=;
        b=PGaR8ZB7+eqYi6S8uZFk9dRlV+mZ54Zij8xuGV1loFaC+2TOnwnwPDKTaST4pjH+H2
         61GKP6PZXS68rDk/Un3APYatmqYKGzVbWSRcUVNBSiPqdjOvD6OHoNOkZgzI+PcYMuah
         D7x+hLnFoMpjJneBjaryjy2zaTWJ8dw47NzCM0AbaD8ORx94TrztfuLd1cVOmQdTQNoR
         RBFyqHGgWfZ3+rnCe+tkIB40AsVFq2R7CC+cUoAHiZbbwV20+jOA8dmjIMHNhPZVCqwg
         lEkqsBGQE81vB4K+GZWxS3qoXKeM3mToSde//ZziVqWC9prSGTgCYJYT9qSNHc0dRw64
         7AmQ==
X-Gm-Message-State: AOAM5326hebOnkrvBy/Z77ieQt13AV/Xss4DCyuCYJRAvCag9zy6tgCY
        dcMZ15T98/eDJXBXoF/7eD+U
X-Google-Smtp-Source: ABdhPJzZ/4QzxOv7PQ5H1OdzxglnPuk0q2J/oj5pG9FIBpfMSqvpv6BInjM3vQzOlGhHxM3XTO1B0Q==
X-Received: by 2002:a0c:e210:: with SMTP id q16mr153314qvl.46.1634741998834;
        Wed, 20 Oct 2021 07:59:58 -0700 (PDT)
Received: from bruce.bluespec.com ([154.3.44.94])
        by smtp.gmail.com with ESMTPSA id e13sm1083272qka.117.2021.10.20.07.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 07:59:58 -0700 (PDT)
Date:   Wed, 20 Oct 2021 10:59:56 -0400
From:   Darius Rad <darius@bluespec.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V4 1/3] irqchip/sifive-plic: Add thead,c900-plic support
Message-ID: <YXAu7OS82G1k28bZ@bruce.bluespec.com>
Mail-Followup-To: Guo Ren <guoren@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Samuel Holland <samuel@sholland.org>,
        Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
References: <20211016032200.2869998-1-guoren@kernel.org>
 <20211016032200.2869998-2-guoren@kernel.org>
 <8be1bdbd-365d-cd28-79d7-b924908f9e39@sholland.org>
 <f850af365f2ac77af79ec59f92e6434a@kernel.org>
 <CAJF2gTShT8Tvk0z6B52zKEi0vq_toc-7mAKWFKj3j-zg=OhpYQ@mail.gmail.com>
 <8735oxuxlq.wl-maz@kernel.org>
 <CAJF2gTSmyu9nA5M3QLeR1LdGMkeGb7jE93Z9zjixcpb_freLMw@mail.gmail.com>
 <875ytrddma.wl-maz@kernel.org>
 <CAJF2gTRfBxXnG57Y+9z0O+GfwgoB9POmb=HL=CMCpu=uwfYY3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJF2gTRfBxXnG57Y+9z0O+GfwgoB9POmb=HL=CMCpu=uwfYY3w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 10:19:06PM +0800, Guo Ren wrote:
> On Wed, Oct 20, 2021 at 9:34 PM Marc Zyngier <maz@kernel.org> wrote:
> >
> > On Tue, 19 Oct 2021 14:27:02 +0100,
> > Guo Ren <guoren@kernel.org> wrote:
> > >
> > > On Tue, Oct 19, 2021 at 6:18 PM Marc Zyngier <maz@kernel.org> wrote:
> > > >
> > > > On Tue, 19 Oct 2021 10:33:49 +0100,
> > > > Guo Ren <guoren@kernel.org> wrote:
> > > >
> > > > > > If you have an 'automask' behavior and yet the HW doesn't record this
> > > > > > in a separate bit, then you need to track this by yourself in the
> > > > > > irq_eoi() callback instead. I guess that you would skip the write to
> > > > > > the CLAIM register in this case, though I have no idea whether this
> > > > > > breaks
> > > > > > the HW interrupt state or not.
> > > > > The problem is when enable bit is 0 for that irq_number,
> > > > > "writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM)" wouldn't affect
> > > > > the hw state machine. Then this irq would enter in ack state and no
> > > > > continues irqs could come in.
> > > >
> > > > Really? This means that you cannot mask an interrupt while it is being
> > > > handled? How great...
> > > If the completion ID does not match an interrupt source that is
> > > currently enabled for the target, the completion is silently ignored.
> > > So, C9xx completion depends on enable-bit.
> >
> > Is that what the PLIC spec says? Or what your implementation does? I
> > can understand that one implementation would be broken, but if the
> > PLIC architecture itself is broken, that's far more concerning.
> 
> Here is the description of Interrupt Completion in PLIC spec [1]:
> 
> The PLIC signals it has completed executing an interrupt handler by
> writing the interrupt ID it received from the claim to the claim/complete
> register. The PLIC does not check whether the completion ID is the same
> as the last claim ID for that target. If the completion ID does not match
> an interrupt source that is currently enabled for the target, the
>                                       ^^ ^^^^^^^^^ ^^^^^^^
> completion is silently ignored.
> 
> [1] https://github.com/riscv/riscv-plic-spec/blob/master/riscv-plic.adoc
> 
> Did we misunderstand the PLIC spec?
> 

That clause sounds to me like it is due to the SiFive implementation, which
the RISC-V PLIC specification is based on.  Since the PLIC spec is still a
draft I would expect it to change before release.                                                                                                                      
