Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725B43A8C7E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 01:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhFOXbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 19:31:38 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:20887 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhFOXbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:31:31 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 15FNTPsb058465
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 02:29:25 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1623799760; x=1626391760;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ysvqs1/K9ONe++S7r+yMb/Oe/Rgd4xGI6L/tmzqZrik=;
        b=BmPCIklcetMBqB07S7nUkB/zCCNdq6q9TT74SEG8aIJj+UwPy9eCcJj5j48XMZiX
        AYKr30lgIDymdSumCyZ85PIJUDc/Y3tQI1bHMrr/iPbkwX/LmXPDqJtkIi4dvrlD
        10Xh9i838pmKVpkoFQjM8oFdUoQMUxfqqOiYMnNzP13ihKCvt5jvAHTJ6EPuy0wr
        Qp0ZI3vPRfeTSTTYar9tooQMlO38NGFafmuE6Ol+055P8bF/0203SBPSYc+acNBq
        KM3xu+gSiKziOkAbwhz8JfhgJOXitxt1iO2iAABE+gdQCptk5gfNaBJKnmuvx4uP
        doxY+aS3kJdLj9yvNF/ffQ==;
X-AuditID: 8b5b014d-962f1700000067b6-5b-60c937d07ad1
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 5D.05.26550.0D739C06; Wed, 16 Jun 2021 02:29:20 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 16 Jun 2021 02:29:19 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] RISC-V: Add crash kernel support
Organization: FORTH
In-Reply-To: <CAL_JsqLHOmZ6az0bYGC3dg__YX3aq=+Un4_x4+R2nNksc0hM2g@mail.gmail.com>
References: <20210419005539.22729-1-mick@ics.forth.gr>
 <20210419005539.22729-6-mick@ics.forth.gr>
 <CAMuHMdW=23SPXwqcjD+30M_d0azdze2=ChZM-PF1brf9bCNtrA@mail.gmail.com>
 <fe02eb618eee141e8bc021e8e30906fc@mailhost.ics.forth.gr>
 <CAMuHMdXtT1L3yfzkTkbhqz3zgUQj89Bcm7mqz+m126NprAsK8Q@mail.gmail.com>
 <CAL_JsqLHOmZ6az0bYGC3dg__YX3aq=+Un4_x4+R2nNksc0hM2g@mail.gmail.com>
Message-ID: <a488d802940f7fc2ae34a4fe583ec187@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsXSHT1dWfeC+ckEg+NnRCzmHznHavHs1l4m
        i8u75rBZbPvcwmbR/O4cu8XLyz3MFm2z+C1a9x5hd+DwePPyJYvHw02XmDw2repk8zh0uIPR
        Y/OSeo9LzdfZPT5vkgtgj+KySUnNySxLLdK3S+DKaLzxkq3gM2/Fzj+t7A2MT7m6GDk5JARM
        JM6+vc7SxcjFISRwlFGia9kaFoiEqcTsvZ2MIDavgKDEyZlPwOLMAhYSU6/sZ4Sw5SWat85m
        BrFZBFQlrmzbDVbDJqApMf/SQTBbREBFYsPzW8wgC5gFFjJLbGqcwgqSEBawkbi14AhYEb+A
        sMSnuxfB4pwCgRJ90/aBLRAS+Mwk0b5TCOIIF4npbz4zQRynIvHh9wP2LkYODlEge/NcpQmM
        grOQnDoLyamzkJy6gJF5FaNAYpmxXmZysV5aflFJhl560SZGcDQw+u5gvL35rd4hRiYOxkOM
        EhzMSiK8usUnEoR4UxIrq1KL8uOLSnNSiw8xSnOwKInz8upNiBcSSE8sSc1OTS1ILYLJMnFw
        SjUwWZtYB72fs+ZY+caL2j/vh7Nka6TyvfXnO3dqQkXNtQSxMrXJxTzthqcfvX0s2dicWjLn
        kepi3mXWV9VTpkxSurBKatf6/Wa8BulXNX7MXdoWHd37V4X9+4f62yyKuf8PejTuyT54dNfM
        0+H3Nz3OWubd+SetYbH7/wKujAXf7QpmlZwuubN3/96GG32MoUI/zQp76z/GNaan9zH8z2v8
        PmVu/Ytjjf57j0RNenPi++m5f04rzujpcufRW/bg/uKc/PCt7/c95Steu9Yl9ZaAzp05xYm6
        RS3rbCIYyg7P8E5ymbBJ5JbRkv138+ey/XRYfLaWNffj1SVHkw9ucRQoLLC+Xvl0p9f2htAT
        QY7MU5RYijMSDbWYi4oTAWVGe4v1AgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2021-06-15 22:21, Rob Herring έγραψε:
> On Tue, Jun 15, 2021 at 12:48 PM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> 
>> Hi Nick,
>> 
>> On Tue, Jun 15, 2021 at 8:29 PM Nick Kossifidis <mick@ics.forth.gr> 
>> wrote:
>> > Στις 2021-06-15 16:19, Geert Uytterhoeven έγραψε:
>> > > This does not match
>> > > https://github.com/devicetree-org/dt-schema/blob/master/schemas/chosen.yaml#L77:
>> > >
>> > >     $ref: types.yaml#/definitions/uint64-array
>> > >     maxItems: 2
>> > >     description:
>> > >       This property (currently used only on arm64) holds the memory
>> > > range,
>> > >       the address and the size, of the elf core header which mainly
>> > > describes
>> > >       the panicked kernel\'s memory layout as PT_LOAD segments of elf
>> > > format.
>> > >
>> > > Hence "linux,elfcorehdr" should be a property of the /chosen node,
>> > > instead of a memory node with a compatible value of "linux,elfcorehdr".
>> > >
>> >
>> > That's a binding for a property on the /chosen node, that as the text
>> > says it's defined for arm64 only and the code that handled it was also
>> 
>> That doesn't mean it must not be used on other architectures ;-)
>> Arm64 was just the first one to use it...
> 
> It is used on arm64 because memory is often passed by UEFI tables and
> not with /memory node. As riscv is also supporting EFI, I'd think they
> would do the same.
> 

We've had this discussion before, riscv uses /memory for now and even if 
we switched to getting memory from ACPI/UEFI tables, the elf core header 
is passed from the crashed kernel to the kdump kernel, it has nothing to 
do with UEFI since the bootloader is the kernel itself. Am I missing 
something ?

Regards,
Nick
