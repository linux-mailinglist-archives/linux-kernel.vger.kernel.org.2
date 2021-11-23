Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D58459A71
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 04:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbhKWDYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 22:24:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:39990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229955AbhKWDYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 22:24:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA7BF61040;
        Tue, 23 Nov 2021 03:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637637689;
        bh=uM3YE0EFKILeiI9sS9IYkVOqnYUtuahejNsRMrq//j8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vE5f1pkhSARmEgiNQAOmDvxu+O0PTWjxOkFugVXelICnkW8tekKrlPnpkN1ZyS51r
         wTxWXOKkclJeMtN8HAyxIKof3ojxgGYjiAJJ+NooCBAoHqKI+76m0mdcGu1MDRehnh
         +kPLhYmFv9ppEcMSBAbOrTs9Wz0aM9InyyRmoVf79h/Gy+ZbAQh4p6ovhpXBe+lE1N
         DR3ureDTSD397GRuuNyATCFPOEh2zbnjAIEsg1+F3k6SpHcataMx76oQp6vL3M6n3K
         zalsm19/QtegF8+Q1ei87bfmq2zsHHrVWrFA/eDi5JPa37syoI+GSOTcyHUO5tdjGS
         4Thl4TssJDL5g==
Received: by mail-vk1-f181.google.com with SMTP id q21so11563937vkn.2;
        Mon, 22 Nov 2021 19:21:28 -0800 (PST)
X-Gm-Message-State: AOAM531jKzcNKAsQ3/9aZbuu+aGMgjMg90medbyC2cwiZ8DmivtuQvZo
        3b2ADZ82Kifgm5nIHe8rCz/Y7YGE23bL1ZIfX1U=
X-Google-Smtp-Source: ABdhPJy862Zsy3ulVJkjx/gF8AytwTIhCOrJMHzbKbnmG+hAJ1LiJlNdqcqMfMQe5k7uB3wZjZZehhzZEpY+am7KEws=
X-Received: by 2002:a05:6122:1788:: with SMTP id o8mr3481188vkf.8.1637637688053;
 Mon, 22 Nov 2021 19:21:28 -0800 (PST)
MIME-Version: 1.0
References: <20211123015717.542631-1-guoren@kernel.org> <20211123015717.542631-4-guoren@kernel.org>
 <ac5613d9-913e-ff07-5802-21e1771112f9@infradead.org>
In-Reply-To: <ac5613d9-913e-ff07-5802-21e1771112f9@infradead.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 23 Nov 2021 11:21:17 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTeeg1Dzfi94EYmjx5cUdpm7+C77R9yOf-PfpfZVD8=nA@mail.gmail.com>
Message-ID: <CAJF2gTTeeg1Dzfi94EYmjx5cUdpm7+C77R9yOf-PfpfZVD8=nA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] riscv: Add riscv.fwsz kernel parameter
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, atishp@rivosinc.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-doc@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <anup.patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 10:34 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 11/22/21 5:57 PM, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The firmware of riscv (such as opensbi) occupy 2MB(64bit) /
> > 4MB(32bit) in Linux. It's very wasteful to small memory footprint
> > soc chip such as Allwinner D1s/F133. The kernel parameter gives a
> > chance to users to set the proper size of the firmware and get
> > more than 1.5MB of memory.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Anup Patel <anup.patel@wdc.com>
> > Cc: Atish Patra <atishp@rivosinc.com>
> > ---
> >   Documentation/admin-guide/kernel-parameters.txt | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 9725c546a0d4..ee505743c8f4 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -4964,6 +4964,9 @@
> >                       [KNL] Disable ring 3 MONITOR/MWAIT feature on supported
> >                       CPUs.
> >
> > +     riscv.fwsz=nn[KMG]
> > +                     [RISC-V] Determine firmware size to save memory
>
> Is "Determine" like "Set"?  The user is setting (telling the software)
> the firmware size?
I mean "Set" here, thx for pointing it out.

>
> "Determine" makes it sound to me like the Linux software is somehow
> helping to determine the firmware size.
>
> > +
> >       ro              [KNL] Mount root device read-only on boot
> >
> >       rodata=         [KNL]
> >
>
>
> --
> ~Randy



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
