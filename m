Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A08E3FAFFC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 05:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhH3DUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 23:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhH3DU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 23:20:29 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E1EC061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 20:19:36 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id l24so7079294uai.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 20:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WZKEL+DYxx8zIYbkne+SrSuePKCtjNXhSeUmI9JsOeM=;
        b=O5oJHjtKz+yggkpPGDpMQEOBVT5bBw3ohUwP9YGHtMC9mgktEjTuIC9+soJq/WUJ7C
         dFJzqY2/1OnboI565bcw0oRI7en+kO+KQqmB6vI2hw28uRrPfx/fxU/7bvfvBv0cZGCc
         mYwJMAQZON74o7gGo+Jfgf+wsXOxlDaLZZfLiSiVvaWJkyrJydWgb6oH8ibPUDA5TVWC
         hXDlIAnAxk4+Nu9y7YxGJQJzjS2qTuBkwh7IPL3LBBHJEpscgBw3MLQGdGz1kkukpMC0
         rCYgemR5oTWbaQJM6LY3VACFv1l12oodFSXF1aKcWl52jR+0iDrRwyFVmJSpi+3SnsUs
         eEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZKEL+DYxx8zIYbkne+SrSuePKCtjNXhSeUmI9JsOeM=;
        b=ctDBpxj+GFYCmX5w3TWPgZ7UYD57H3Pn9dOKw+GcYBVnUmLlcv75WNFlecKY0o0Vtc
         SWSHj+9QKigTE+oj/x/7XaRhXJuPUete67iWGkA4RW3XZANdctj5N/nA81sbmHU6Gm9C
         ho+RWx/vuOOisM6G7Myw9yENdBuhVQhw8Lz22Ec2IFK6NXuHg/Y8/+X26bsDYpuw0ipp
         Rm6X+FZfC677uj1yT77/i5AadESNqG7XoHA8X673vo4di5HFMUETqD1M0aveCNYUSq8C
         /iwecyC3WRqMzUGRLp0oH//HKrY743/YEUBCKG/2KjRaJtpLJt6TvkkoEjTTAP8CxvKD
         H7Uw==
X-Gm-Message-State: AOAM531idvfdMlk4rjxyXnz8MgdNSnW7qj1RPSmc1N0T79IZKsQV7kbO
        aIZyJ9WVbzRT4Vw//hrkpXWQRecg6quhQTzPjwWg9dHg
X-Google-Smtp-Source: ABdhPJyAhiq+3lhEGCVCzOXp9eVo9ch3uz+cnj2pAAU5xVwgALE9DvALbt3LSxjV3M1pjdYK/T4I5axJIxabCekB9r0=
X-Received: by 2002:a9f:21f1:: with SMTP id 104mr13707292uac.143.1630293575528;
 Sun, 29 Aug 2021 20:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210825061152.3396398-1-chenhuacai@loongson.cn>
 <20210825061152.3396398-9-chenhuacai@loongson.cn> <87pmu1q5ms.wl-maz@kernel.org>
 <CAAhV-H5yadRbTt9a-i-65Mvd6mBxm58R_+mWLfJrauuAe3+qyg@mail.gmail.com>
 <87v93pddzu.wl-maz@kernel.org> <CAAhV-H41rridOo_3Eq5t9LPz-mefketAKNdhgbguFtZ0Cqz5Ng@mail.gmail.com>
 <87tuj8d0ie.wl-maz@kernel.org> <CAAhV-H5cf0N5RAQTRN9MqO-=bsf7YNMCvqVLtwOTpXJ7zaFU=Q@mail.gmail.com>
 <87r1eccy6s.wl-maz@kernel.org>
In-Reply-To: <87r1eccy6s.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 30 Aug 2021 11:19:22 +0800
Message-ID: <CAAhV-H5XpbzTdfYD5s4Tp7UJtjFeG_msH-D84o+5TvZwWuwxdQ@mail.gmail.com>
Subject: Re: [PATCH V3 08/10] irqchip: Add LoongArch CPU interrupt controller support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc,

On Sun, Aug 29, 2021 at 7:01 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sun, 29 Aug 2021 11:34:21 +0100,
> Huacai Chen <chenhuacai@gmail.com> wrote:
> >
> > Hi, Marc,
> >
> > On Sun, Aug 29, 2021 at 6:10 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Sun, 29 Aug 2021 10:37:48 +0100,
> > > Huacai Chen <chenhuacai@gmail.com> wrote:
> > >
> > > > > Are you saying that there is no way for the interrupt controller
> > > > > driver to figure out the hwirq number on its own?  That would seem
> > > > > pretty odd (even the MIPS GIC has that). Worse case, you can provide
> > > > > an arch-specific helper that exposes the current hwirq based on the
> > > > > vector that triggered.
> > > > We can get the hwirq number by reading CSR.ESTAT register, but in this
> > > > way "vectored interrupts" is meaningless.
> > >
> > > Let's face it, the way you use vectored interrupts makes zero sense
> > > already. The whole point of vectored interrupts is that the CPU can
> > > branch to the handler directly, making the interrupt handling cheaper
> > > as there should be no additional decoding and you can run the final
> > > handler immediately. Here, all your interrupts point to the same
> > > "default handler"...
> > The default handler can be overridden by arch code.
>
> How? Do you plan to bypass the whole of the Linux interrupt stack and
> jump straight to the function provided by a driver via request_irq()?
>
> Because that's the *only* way for vectored interrupts to make any
> difference. They otherwise are an antiquated leftover from a time when
> shaving every single instructions was an absolute requirement.
> Vectored interrupts also tend to confuse vectors and priorities (yet
> another bad move).
>
> So let's be serious, the whole vectored interrupts is utter rubbish,
> and you haven't given *any* argument as to why you can't make your
> interrupt handling behave sanely and be maintainable.
>
> Anyhow, we have both wasted enough time on this. I have suggested a
> number of ways you can rework your interrupt handling to be more
> acceptable. You can take or leave my suggestions, but I have no
> intention to give my blessing to patches that have the current level
> of quality.
OK, now I know that vectored interrupts make no sense in the current
linux kernel irq framework. I will take all your suggestions, thanks
for your patience in teaching me so much!

Huacai
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
