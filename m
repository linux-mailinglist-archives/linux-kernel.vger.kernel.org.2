Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685093A89D2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 21:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhFOT4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 15:56:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229898AbhFOT4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 15:56:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E60A16128B;
        Tue, 15 Jun 2021 19:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623786883;
        bh=W1xnnWvWsJfJPutiRyGO1n1B7NplEf1u/yklRr5NuJs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tK5G9DrjviDXt2s70irKKqTA9hgoFMYoOFnF8ATDkHvg2PmBhonYuP82rHCvzgnJB
         HBIrJR9A5eRMDWmjWc687AfWae0aY7aUWQJvk7zkUBoLc0Poj3PMgXYTfXUI28FiaR
         pqbPV66AfCWwwOt0U1qF9G5+NJZDAKnaNA801ttoZkOar24ORxLgqzScTm8kZgjZPn
         lvGVvRQrThm282fQcpBinnH7UboackJu9fQwSiDhJ3mO0+QBDdZHl+2MQrBe55L9io
         UCyIOI6XGeIerYLbs8PUnLexN0gnj4o14X0fm86pr+OPqRJZoDqpO4BGJiBQApM2fe
         H5LWtm921ip3Q==
Received: by mail-ej1-f49.google.com with SMTP id ce15so24427323ejb.4;
        Tue, 15 Jun 2021 12:54:43 -0700 (PDT)
X-Gm-Message-State: AOAM532GhUNHP0lisTZUFy4HX6g8v/MpGPGdVkVmst+jKrks8xH7v5hW
        nsZeXgj20vzabos6K7NNyEulNV1W1oB7FESX1A==
X-Google-Smtp-Source: ABdhPJws6EJc3AHI9SCrC49CmDB2SKmyNaBg1CnISwWPlKJmd/mj1fUa/9RW04SrT9zPSts7jNSN1kgXP2Sdl9DBSy8=
X-Received: by 2002:a17:906:9419:: with SMTP id q25mr1314651ejx.341.1623786882557;
 Tue, 15 Jun 2021 12:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623780059.git.geert+renesas@glider.be> <bcc5c666f4ada9a8bbc26f559751f0da67f769f8.1623780059.git.geert+renesas@glider.be>
 <abadee118c1945c44d9bff7675b12ec4@mailhost.ics.forth.gr>
In-Reply-To: <abadee118c1945c44d9bff7675b12ec4@mailhost.ics.forth.gr>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 15 Jun 2021 13:54:30 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLU7GWDxdnR2-Yd2vbj7w=5pNr_fFocDQgPbs17EpBG0g@mail.gmail.com>
Message-ID: <CAL_JsqLU7GWDxdnR2-Yd2vbj7w=5pNr_fFocDQgPbs17EpBG0g@mail.gmail.com>
Subject: Re: [PATCH 2/3] riscv: Remove non-standard linux,elfcorehdr handling
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 12:40 PM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> =CE=A3=CF=84=CE=B9=CF=82 2021-06-15 21:17, Geert Uytterhoeven =CE=AD=CE=
=B3=CF=81=CE=B1=CF=88=CE=B5:
> > RISC-V uses platform-specific code to locate the elf core header in
> > memory.  However, this does not conform to the standard
> > "linux,elfcorehdr" DT bindings, as it relies on a reserved memory node
> > with the "linux,elfcorehdr" compatible value, instead of on a
> > "linux,elfcorehdr" property under the "/chosen" node.
> >
> > The non-compliant code can just be removed, as the standard behavior is
> > already implemented by platform-agnostic handling in the FDT core code.
> >
> > Fixes: 5640975003d0234d ("RISC-V: Add crash kernel support")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> NACK
>
> There is nothing standard about "linux,elfcorehdr", it's an

It is and it is documented which is more than we can say for
"linux,elfcorehdr" as a node.

> arm64-specific property on /chosen and it's suboptimal, it gets the
> addr/length of ELF core of the previous kernel through that property and
> then goes on to reserve that region at:
> https://elixir.bootlin.com/linux/v5.13-rc6/source/arch/arm64/mm/init.c#L1=
55
>
> Why on earth is this cleaner than just defining a reserved-region in the
> first place (a standard binding) with and hook up a callback with
> RESERVEDMEM_OF_DECLARE for it to also initialize elfcorehdr_addr/size ?
> If you don't like the compatible string I'm ok to change it, but this
> patch breaks kdump on riscv since that region won't be reserved any more
> and kernel will corrupt it.

I might agree if we were designing this all from scratch, but we're
not. We've got powerpc doing /memreserve/ + kernel cmdline, arm64
using chosen, and RiscV a 3rd way.

What happens when/if RiscV wants to add an IMA buffer? That's no
different than this case. The 2 architectures supporting it both use
/chosen. Specifying an initrd is no different either.

Rob
