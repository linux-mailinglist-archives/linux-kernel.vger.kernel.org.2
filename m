Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7EB430173
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 11:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243901AbhJPJTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 05:19:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235389AbhJPJTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 05:19:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0003F61262
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 09:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634375819;
        bh=lZbCj57sS26PhhEqqLIywo2CTki+igIMS5uTDnO/RQo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fv+uG4YpKUa61aLECR+ZwDU85bj61IhR7WtNAoeQkPHQoUDT+UH+nfe4SF2hAZblC
         p0YE0X9ximkFMLF7Tf32S+yLabOKVX2FJ7AZvRap6xOe9iUI9pNZW3rFaa5My0QVBf
         /NW3I4/B2LSQrPbUFUujU5BmhlROMGPEg7n0lj8uDqEk656F6tr/5iWR51JY7Pf9Sy
         uryq0IPvcffWfka0R5hZUhCXumKwjN2/rIpE1IyqPgnvJEnUVyCfvJymLD+7wQsnDQ
         S7T48keqwLk1cofaYwiHbUoCV1w5ItpdEsNTqXz1YjU+a/jZlkPiVAD8iS43Q0RVP2
         Z6pFRX3XI4gfw==
Received: by mail-vk1-f177.google.com with SMTP id j38so6276988vkd.10
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 02:16:58 -0700 (PDT)
X-Gm-Message-State: AOAM5337OcXUXbiCxsYHWpseWDWSjvj7UzcCCS4v1LgQhGkX9I6Ho6aY
        mdEYzikaXEmLz3rygke6HH6AAOftToKTDnwG5mU=
X-Google-Smtp-Source: ABdhPJy7Dr9uJZRjLPplBn0SwWTsg5Ys8p5qWK0RQe03OuCs93YEQl7H/pLcxBmeE24G/bvo7SZgWy407FkLn5kqPhM=
X-Received: by 2002:a1f:2a4c:: with SMTP id q73mr16680462vkq.8.1634375817984;
 Sat, 16 Oct 2021 02:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211016032200.2869998-1-guoren@kernel.org> <20211016032200.2869998-3-guoren@kernel.org>
 <87mtn9mor9.fsf@linux-m68k.org>
In-Reply-To: <87mtn9mor9.fsf@linux-m68k.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 16 Oct 2021 17:16:45 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRYuo+U1wWaz1jiQTk07-6etNMg-2UBDTYmnrLKzVqH8Q@mail.gmail.com>
Message-ID: <CAJF2gTRYuo+U1wWaz1jiQTk07-6etNMg-2UBDTYmnrLKzVqH8Q@mail.gmail.com>
Subject: Re: [PATCH V4 2/3] dt-bindings: update riscv plic compatible string
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2021 at 3:17 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Okt 16 2021, guoren@kernel.org wrote:
>
> > +  The C9xx PLIC does not comply with the interrupt claim/completion process defined
> > +  by the RISC-V PLIC specification because C9xx PLIC will mask an IRQ when it is
> > +  claimed by PLIC driver (i.e. readl(claim) and the IRQ will be unmasked upon
> > +  completion by PLIC driver (i.e. writel(claim). This behaviour breaks the handling
>
> Missing close paren in both parenthetical remarks above.
Opps, thx. I'll fix it.

>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
