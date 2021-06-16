Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9EE83A947E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhFPH63 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Jun 2021 03:58:29 -0400
Received: from mail-vk1-f175.google.com ([209.85.221.175]:44749 "EHLO
        mail-vk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhFPH6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:58:22 -0400
Received: by mail-vk1-f175.google.com with SMTP id k71so412214vka.11;
        Wed, 16 Jun 2021 00:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EB2jcZke5QcTU5wwXlL7vPYF1gqQxFBDLVf8D1mXcpw=;
        b=OEhCdb2mnhSI6mi8AQFdim9t+AcQlpOFU7DFNX+WPVl8AIbcBX3VqoFL96Jb4dAurM
         3GZQAKFu3WJfHJLeqYbK92CwBn56yHY3Id9gQL6aCzY/vmfNYscYyZ4Ys9JLG5vqkvEO
         YDnN65+MWJIBMWYP7NYb9QnHhJTjjXR/4QhBaFhtIAuLQ2ErftSdpXY6gs12laaS1sc1
         D0JVoETdj0ObXu10Z0e7VE5bkDUtrhXBPjGxUWl3JGXnfOduVKjVPe8O9VE4arh3C7Me
         VPwVaE/huEY/XzDDizmnDnfUFaupsi7EGGv87pzE1FTJmKC49VSjE6GSHz1HWkXWk5bP
         uDoA==
X-Gm-Message-State: AOAM532ocOTk7fTNfUp/PmNyZop+tdNR73Y3Rsb6CcMNX181lxRjXMcG
        T6P1iT1NG83wlIcyOd4VUMppcAywGTQzmqMAY/0=
X-Google-Smtp-Source: ABdhPJzbtH9lYs1P2YIpodHR7Y8xwDKgAHp+zJhrezZD2vdTjfq6nqFDO1t+7iOrwH2UgTbyfSR62fdm8OgSgPRx4F4=
X-Received: by 2002:a1f:1a41:: with SMTP id a62mr7766158vka.5.1623830176085;
 Wed, 16 Jun 2021 00:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623780059.git.geert+renesas@glider.be> <bcc5c666f4ada9a8bbc26f559751f0da67f769f8.1623780059.git.geert+renesas@glider.be>
 <abadee118c1945c44d9bff7675b12ec4@mailhost.ics.forth.gr> <CAL_JsqLU7GWDxdnR2-Yd2vbj7w=5pNr_fFocDQgPbs17EpBG0g@mail.gmail.com>
 <bdfbf7cc997a10a94331d77332dbe88e@mailhost.ics.forth.gr>
In-Reply-To: <bdfbf7cc997a10a94331d77332dbe88e@mailhost.ics.forth.gr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Jun 2021 09:56:05 +0200
Message-ID: <CAMuHMdVRcN+y0kwxxEH8UGo6bRT9SvxRSLU8VzWJFx=yLQ5S0g@mail.gmail.com>
Subject: Re: [PATCH 2/3] riscv: Remove non-standard linux,elfcorehdr handling
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Wed, Jun 16, 2021 at 1:19 AM Nick Kossifidis <mick@ics.forth.gr> wrote:
> Στις 2021-06-15 22:54, Rob Herring έγραψε:
> > On Tue, Jun 15, 2021 at 12:40 PM Nick Kossifidis <mick@ics.forth.gr>
> > wrote:
> >> Στις 2021-06-15 21:17, Geert Uytterhoeven έγραψε:
> >> > RISC-V uses platform-specific code to locate the elf core header in
> >> > memory.  However, this does not conform to the standard
> >> > "linux,elfcorehdr" DT bindings, as it relies on a reserved memory node
> >> > with the "linux,elfcorehdr" compatible value, instead of on a
> >> > "linux,elfcorehdr" property under the "/chosen" node.
> >> >
> >> > The non-compliant code can just be removed, as the standard behavior is
> >> > already implemented by platform-agnostic handling in the FDT core code.
> >> >
> >> > Fixes: 5640975003d0234d ("RISC-V: Add crash kernel support")
> >> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >>
> >> NACK
> >>
> >> There is nothing standard about "linux,elfcorehdr", it's an
> >
> > It is and it is documented which is more than we can say for
> > "linux,elfcorehdr" as a node.
> >
>
> Standard stuff goes on /drivers/of, not on /arch/arm64. The

... which is what I'm fixing ;-)

Once in a while, new code is added where it's used, and moved to
common code later.

> reserved-memory binding I use is on /drivers/of, is definitely a
> standard / documented binding and the only issue here is that the
> compatible string I used matched that property from arm64.

It's always a good idea to document your compatible strings, and run
your patches through the devicetree list, exactly to avoid issues
like this.

> >> arm64-specific property on /chosen and it's suboptimal, it gets the
> >> addr/length of ELF core of the previous kernel through that property
> >> and
> >> then goes on to reserve that region at:
> >> https://elixir.bootlin.com/linux/v5.13-rc6/source/arch/arm64/mm/init.c#L155
> >>
> >> Why on earth is this cleaner than just defining a reserved-region in
> >> the
> >> first place (a standard binding) with and hook up a callback with
> >> RESERVEDMEM_OF_DECLARE for it to also initialize elfcorehdr_addr/size
> >> ?
> >> If you don't like the compatible string I'm ok to change it, but this
> >> patch breaks kdump on riscv since that region won't be reserved any
> >> more
> >> and kernel will corrupt it.
> >
> > I might agree if we were designing this all from scratch, but we're
> > not. We've got powerpc doing /memreserve/ + kernel cmdline, arm64
> > using chosen, and RiscV a 3rd way.
> >
>
> I get it and I'd also like to consolidate things, but forcing riscv to
> use a suboptimal approach just because arm64 uses it doesn't make sense
> either, the goal should be for all to use the best possible approach
> (disclaimer: I'm not saying my approach is the best possible, I'm saying
> it's cleaner than arm64's).
>
> > What happens when/if RiscV wants to add an IMA buffer? That's no
> > different than this case. The 2 architectures supporting it both use
> > /chosen. Specifying an initrd is no different either.
>
> Those two are already on drivers/of/fdt.c and drivers/of/kexec.c, it's
> also interesting to note that for both of them, including
> "linux,elfcorehdr", the newly added drivers/of/kexec.c adds an entry to
> the fdt's memory reservation map when creating the fdt for the next
> kernel, so they are all basically reserved regions. Why this was chosen
> (a property on /chosen + an entry on the reservation map), effectively
> adding each region twice on the fdt, instead of just adding a
> reserved-memory node for each one beats me. Note that in case of arm64
> this is not what happens on kexec-tools, which is probably the reason
> why arm64 still reserves them in any case.

I can't comment on the duplication on arm64, but to me, /chosen
sounds like the natural place for both "linux,elfcorehdr" and
"linux,usable-memory-range".  First rule of DT is "DT describes
hardware, not software policy", with /chosen describing some software
configuration.

> Anyway I guess switching arm64 to reserved-memory is too much to ask
> since they would have to also change kexec-tools, handle different
> versions etc, and although I don't like it consolidation is more
> important than a duplicate region on the fdt, so let's go with
> "linux,elfcorehdr" on /chosen + entry on the reservation map. I'll
> update my kexec-tools patch instead.

OK, thanks!
But do you need the entry on the reservation map?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
