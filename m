Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8601445D2F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 02:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhKEBJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 21:09:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231133AbhKEBJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 21:09:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FE0861245
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 01:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636074423;
        bh=e16Mi+K8f8A1YlnrwXmStFNz6CID+giZJVpBpRE2tTc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vLKs/+rnOTf+GHM+en71ZdfWoZ9LCvkd38uhyWZZBnqkLkjgBOGFEuC7BbS8IcnDd
         AlXw78dsDT0hksruuO8HtBrbLdE+IOJCNRkHnbmvP1eL2FAwrZy08nGZGRvlaRqMWc
         IP9Zb92RRZGuT4hUGhkXQkTPbNHSeHJpfFn0m198OuLz1Kmhzjx3Aju2t/6wsz3rZ4
         IjRzhBwjdbK+0SJodYU4NuhOfKDQMKdnbA6zrQuIwCNmN69vEWBzjFXF3zhjxYsApi
         TJhDC3iCWb2AlBj46anhftyZJtAPHrZkeU1cyQD/XMnmmJdUfTB882X8++cAnm2pwi
         HPTnDpYjxL4WA==
Received: by mail-vk1-f180.google.com with SMTP id 84so2056565vkc.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 18:07:03 -0700 (PDT)
X-Gm-Message-State: AOAM530BLc0iguGkA6p3PC76mE4sU9Zuop6Ov0WX7EAhNi/PCLurUWXG
        xta0qpDgpLwGEhVs3kkUweLddEUVYwoEwSgWibc=
X-Google-Smtp-Source: ABdhPJwvGbRaXLEYfAh9ZSkqQVjXrx0y4PslYQqJ2YKH8KiIhxPspAOtMRvTVeoQRt/X55tBRbhbwatt3wcno5mwOU8=
X-Received: by 2002:a05:6122:d07:: with SMTP id az7mr20321320vkb.22.1636074422159;
 Thu, 04 Nov 2021 18:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211101131736.3800114-1-guoren@kernel.org> <CAAhSdy29qhF4JHuMOqwctn+=HQNBbR3X0gsymqD8OAF1pXE43A@mail.gmail.com>
 <871r3w9df1.wl-maz@kernel.org>
In-Reply-To: <871r3w9df1.wl-maz@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 5 Nov 2021 09:06:51 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTa4uA6Zv5bvnfiQNQax3OikAPJynktwDr-00hqX8FPzQ@mail.gmail.com>
Message-ID: <CAJF2gTTa4uA6Zv5bvnfiQNQax3OikAPJynktwDr-00hqX8FPzQ@mail.gmail.com>
Subject: Re: [PATCH V6] irqchip/sifive-plic: Fixup EOI failed when masked
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 4, 2021 at 10:57 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 04 Nov 2021 14:40:42 +0000,
> Anup Patel <anup@brainfault.org> wrote:
> >
> > On Mon, Nov 1, 2021 at 6:47 PM <guoren@kernel.org> wrote:
> > >
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > When using "devm_request_threaded_irq(,,,,IRQF_ONESHOT,,)" in the driver,
> > > only the first interrupt could be handled, and continue irq is blocked by
> > > hw. Because the riscv plic couldn't complete masked irq source which has
> > > been disabled in enable register. The bug was firstly reported in [1].
> > >
> > > Here is the description of Interrupt Completion in PLIC spec [2]:
> > >
> > > The PLIC signals it has completed executing an interrupt handler by
> > > writing the interrupt ID it received from the claim to the claim/complete
> > > register. The PLIC does not check whether the completion ID is the same
> > > as the last claim ID for that target. If the completion ID does not match
> > > an interrupt source that is currently enabled for the target, the
> > >                          ^^ ^^^^^^^^^ ^^^^^^^
> > > completion is silently ignored.
> > >
> > > [1] http://lists.infradead.org/pipermail/linux-riscv/2021-July/007441.html
> > > [2] https://github.com/riscv/riscv-plic-spec/blob/8bc15a35d07c9edf7b5d23fec9728302595ffc4d/riscv-plic.adoc
> > >
> > > Reported-by: Vincent Pelletier <plr.vincent@gmail.com>
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Cc: Anup Patel <anup@brainfault.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Marc Zyngier <maz@kernel.org>
> > > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > > Cc: Atish Patra <atish.patra@wdc.com>
> > > Cc: Nikita Shubin <nikita.shubin@maquefel.me>
> > > Cc: incent Pelletier <plr.vincent@gmail.com>
> >
> > Please include a Fixes: tag
Okay

> >
> > Also, I see that you have dropped the DT bindings patch. We still
> > need separate compatible string for T-HEAD PLIC because OpenSBI
> > will use it for other work-arounds.
> >
> > I suggest to include to more patches in this series:
> > 1) Your latest T-HEAD PLIC DT bindings patch
> > 2) Separate patch to use T-HEAD PLIC compatible in PLIC driver
Thx for the suggestion, and I would put above in 5.17 as Mark suggested.

>
> No, please keep things separate. The PLIC is broken *today*, and I
> want to take a patch for -rc1. The rest (compatible and such) is a new
> feature and can wait until 5.17.
Okay

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
