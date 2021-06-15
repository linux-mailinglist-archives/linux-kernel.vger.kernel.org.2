Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EDD3A8C5F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 01:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhFOXV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 19:21:28 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:37367 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOXV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:21:27 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 15FNJKpK058325
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:19:20 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1623799155; x=1626391155;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uwFXfKsUDq2hvWkMUShCCiVgWGg1LtvvqsBZuvGXYp0=;
        b=LMz1xsXB6BGLWnG55k8/4KVd5f2tm9aH0Ier9huFlt/47D4vW0sg/ztO6pSrB4uf
        PnP5v6Lk2IFZRfbxeRoVDbrfSiTG3RUvYI09ZSIPOtLY8Ipw8J+WFfznFmKDnrvJ
        dGFWD2uHkO2EPf5eLhCGxZZ7e60j+5XaUEgrq1BiQZDmh/9DEickjKKmjGvwRSW0
        fqXA8pZS0s7cU7pSVbEBuaVf4LhBFMTz//P2uBSS+eQQP8zYHd752GIG8RxC6dcf
        nfMDiTNRe/eQE29a/poJC3vogvHlxsFpSLvZiO117EWH0jxRwPTOdGFCEAQU1pd1
        y6HmTkZB3yzgPfAOx/1lhQ==;
X-AuditID: 8b5b014d-96ef2700000067b6-12-60c93573b2c3
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 87.05.26550.37539C06; Wed, 16 Jun 2021 02:19:15 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 16 Jun 2021 02:19:14 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] riscv: Remove non-standard linux,elfcorehdr handling
Organization: FORTH
In-Reply-To: <CAL_JsqLU7GWDxdnR2-Yd2vbj7w=5pNr_fFocDQgPbs17EpBG0g@mail.gmail.com>
References: <cover.1623780059.git.geert+renesas@glider.be>
 <bcc5c666f4ada9a8bbc26f559751f0da67f769f8.1623780059.git.geert+renesas@glider.be>
 <abadee118c1945c44d9bff7675b12ec4@mailhost.ics.forth.gr>
 <CAL_JsqLU7GWDxdnR2-Yd2vbj7w=5pNr_fFocDQgPbs17EpBG0g@mail.gmail.com>
Message-ID: <bdfbf7cc997a10a94331d77332dbe88e@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42Lpjp6urFtsejLB4M8yDYutv2exW7xf1sNo
        Mf/IOVaLmW/+s1nMnT2J0WLT42usFpd3zWGz2Pa5hc2i+d05douXl3uYLdpm8Vu07j3CbtFy
        x9SB12PNvDWMHm9evmTxONzxhd1j4lldj52z7rJ7PNx0iclj06pONo/NS+o9LjVfZ/f4vEku
        gCuKyyYlNSezLLVI3y6BK+P99/WsBRdkK2adC21gfC/excjBISFgIrFqb14XIyeHkMBRRonF
        TeEgtoSAqcTsvZ2MIDavgKDEyZlPWEBsZgELialX9jNC2PISzVtnM4PYLAKqEp2bVrKD2GwC
        mhLzLx0EqxcRUJHY8PwWUA0XUP0+Fom2lyfAioQFfCV+zbwIZvMLCEt8unuRFcTmFAiUeH/5
        GhNIg5DABCaJfV9usUFc4SLxrfU1G8R1KhIffj9gB3lAFMjePFdpAqPgLCS3zkJy6ywkty5g
        ZF7FKJBYZqyXmVysl5ZfVJKhl160iREcVYy+Oxhvb36rd4iRiYPxEKMEB7OSCK9u8YkEId6U
        xMqq1KL8+KLSnNTiQ4zSHCxK4ry8ehPihQTSE0tSs1NTC1KLYLJMHJxSDUyup6ex2j0Ib95W
        YMqsevBi9b0W7UJt5e9vPnkGn7xrOkn/1+kZ7/i3nS5ZuG6tSF9Ye+eWZaceqUcXORt8Sjzx
        7eLsBx3mAZOfTbrLa6riFmcmJ6dy5qCYd+B8HR9zS78ZCx9riKect7HYfcvabq3jwq1P7rCr
        6X/d9iaSn+lnpuX+e5LWqdPu8EdfEJqYkpw/f+HDOzpbWqWvF0zgnS3cEubaLCg4UdZ7Wqni
        xEvrvsyI2RD4cdvDd4fnR2pcyHt/P25jtIfx45B3m9ofz+tfvnqr7Pz9pQsurpdo9L+tuzzI
        Q4NXTY774FY3lto/myepLmye2j9p94eqC+4RQsUpbKrV0y5yMfxZosh98IClEktxRqKhFnNR
        cSIAWD8HaxkDAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2021-06-15 22:54, Rob Herring έγραψε:
> On Tue, Jun 15, 2021 at 12:40 PM Nick Kossifidis <mick@ics.forth.gr> 
> wrote:
>> 
>> Στις 2021-06-15 21:17, Geert Uytterhoeven έγραψε:
>> > RISC-V uses platform-specific code to locate the elf core header in
>> > memory.  However, this does not conform to the standard
>> > "linux,elfcorehdr" DT bindings, as it relies on a reserved memory node
>> > with the "linux,elfcorehdr" compatible value, instead of on a
>> > "linux,elfcorehdr" property under the "/chosen" node.
>> >
>> > The non-compliant code can just be removed, as the standard behavior is
>> > already implemented by platform-agnostic handling in the FDT core code.
>> >
>> > Fixes: 5640975003d0234d ("RISC-V: Add crash kernel support")
>> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> 
>> NACK
>> 
>> There is nothing standard about "linux,elfcorehdr", it's an
> 
> It is and it is documented which is more than we can say for
> "linux,elfcorehdr" as a node.
> 

Standard stuff goes on /drivers/of, not on /arch/arm64. The 
reserved-memory binding I use is on /drivers/of, is definitely a 
standard / documented binding and the only issue here is that the 
compatible string I used matched that property from arm64.

>> arm64-specific property on /chosen and it's suboptimal, it gets the
>> addr/length of ELF core of the previous kernel through that property 
>> and
>> then goes on to reserve that region at:
>> https://elixir.bootlin.com/linux/v5.13-rc6/source/arch/arm64/mm/init.c#L155
>> 
>> Why on earth is this cleaner than just defining a reserved-region in 
>> the
>> first place (a standard binding) with and hook up a callback with
>> RESERVEDMEM_OF_DECLARE for it to also initialize elfcorehdr_addr/size 
>> ?
>> If you don't like the compatible string I'm ok to change it, but this
>> patch breaks kdump on riscv since that region won't be reserved any 
>> more
>> and kernel will corrupt it.
> 
> I might agree if we were designing this all from scratch, but we're
> not. We've got powerpc doing /memreserve/ + kernel cmdline, arm64
> using chosen, and RiscV a 3rd way.
> 

I get it and I'd also like to consolidate things, but forcing riscv to 
use a suboptimal approach just because arm64 uses it doesn't make sense 
either, the goal should be for all to use the best possible approach 
(disclaimer: I'm not saying my approach is the best possible, I'm saying 
it's cleaner than arm64's).

> What happens when/if RiscV wants to add an IMA buffer? That's no
> different than this case. The 2 architectures supporting it both use
> /chosen. Specifying an initrd is no different either.

Those two are already on drivers/of/fdt.c and drivers/of/kexec.c, it's 
also interesting to note that for both of them, including 
"linux,elfcorehdr", the newly added drivers/of/kexec.c adds an entry to 
the fdt's memory reservation map when creating the fdt for the next 
kernel, so they are all basically reserved regions. Why this was chosen 
(a property on /chosen + an entry on the reservation map), effectively 
adding each region twice on the fdt, instead of just adding a 
reserved-memory node for each one beats me. Note that in case of arm64 
this is not what happens on kexec-tools, which is probably the reason 
why arm64 still reserves them in any case.

Anyway I guess switching arm64 to reserved-memory is too much to ask 
since they would have to also change kexec-tools, handle different 
versions etc, and although I don't like it consolidation is more 
important than a duplicate region on the fdt, so let's go with 
"linux,elfcorehdr" on /chosen + entry on the reservation map. I'll 
update my kexec-tools patch instead.

Regards,
Nick


