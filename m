Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFC23A8892
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 20:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhFOSbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 14:31:53 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:28324 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhFOSbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:31:52 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 15FITjv4053935
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 21:29:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1623781780; x=1626373780;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=m7piPkU8QBBePrBqgwf01oOS25yDfifMF3547bNitF8=;
        b=trmCRoLfNK5aSh8iDz9fLNyGINNcgrNLplrjlV/hZC9aFUe2LtUSsrgvjsQw5MQF
        OU4i3vFW+n9eoqnUj8+mprPOArbEEoX1T9yR9pcOlrg/7JKKcaBOtAT0e+b6qlyP
        t6INWvw5xZOzfii98La4qKwDetZ5hIZ/UKyBa0evo1X5U91zDtqos7fPK9ACHrJ6
        /vt7eJ+Xv1x9HdAngDuiiyPhcNF689aHrLTOpqcK36JMv1py2FEOLkR9h8l3++mJ
        x3moWxhRQZVjDlrxZtd26DvuLit6vfiFkIP3IYhPzx827j7AREZW8jfgQi+uTJwy
        De0k1Bb+yfYal3oToGyeoA==;
X-AuditID: 8b5b014d-96ef2700000067b6-cc-60c8f194994e
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id F6.54.26550.491F8C06; Tue, 15 Jun 2021 21:29:40 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 15 Jun 2021 21:29:40 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] RISC-V: Add crash kernel support
Organization: FORTH
In-Reply-To: <CAMuHMdW=23SPXwqcjD+30M_d0azdze2=ChZM-PF1brf9bCNtrA@mail.gmail.com>
References: <20210419005539.22729-1-mick@ics.forth.gr>
 <20210419005539.22729-6-mick@ics.forth.gr>
 <CAMuHMdW=23SPXwqcjD+30M_d0azdze2=ChZM-PF1brf9bCNtrA@mail.gmail.com>
Message-ID: <fe02eb618eee141e8bc021e8e30906fc@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsXSHT1dWXfKxxMJBgc2q1nMP3KO1eLZrb1M
        Fpd3zWGz2Pa5hc2i+d05douXl3uYLdpm8Vu07j3C7sDh8eblSxaPh5suMXlsWtXJ5nHocAej
        x+Yl9R6Xmq+ze3zeJBfAHsVlk5Kak1mWWqRvl8CVcfTSIuaCjbwVPTPUGhgvc3UxcnJICJhI
        XFiznrWLkYtDSOAoo8Sas7sYIRKmErP3doLZvAKCEidnPmEBsZkFLCSmXtnPCGHLSzRvnc0M
        YrMIqEq0rv8GVsMmoCkx/9JBIJuDQ0RAV2LOTyaQ+cwCc5glVk5dww5SIyxgI3FrwRGwen4B
        YYlPdy+ygticAoES11adY4M4aBWjxIIl66GOcJF4O72JDeI4FYkPvx+wgywQBbI3z1WawCg4
        C8mps5CcOgvJqQsYmVcxCiSWGetlJhfrpeUXlWTopRdtYgTHAqPvDsbbm9/qHWJk4mA8xCjB
        wawkwqtbfCJBiDclsbIqtSg/vqg0J7X4EKM0B4uSOC+v3oR4IYH0xJLU7NTUgtQimCwTB6dU
        A5NuUPCJMsGXvzcbBP166Rykd2jVu5mG6zNXfD3FsFyhhcPzw5IMgSrupYEXBdJDZe/Z3PI7
        tbVc0mtu6RxXkzlM5vvM5hllpJ/7PDPF01SE+6e2ov/6/wZaUzQ7Y3hdGp9xbm1bVJ6+4d+n
        sl1hUTdObZJTLCy9wX2h/4f+VNHSWon1W4x6Pnt4Nt7JPHSw66xIWtsJXcWqvV/CiuL/fLjA
        +Fl0i78SSzmXWtTObIE5luvrVftdsta49b98sMOTOf2R3Jov2l/MnjRJWPXrHfig6HskV3mT
        U9e7uVcLrk85to/L9NZuX4nGPU82h2SeK9oUWFXBWf3w9P+1W5f4TvAyYRDR3ePdNL3v2oV2
        GyWW4oxEQy3mouJEAHOVAVX0AgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert,

Στις 2021-06-15 16:19, Geert Uytterhoeven έγραψε:
> 
> This does not match
> https://github.com/devicetree-org/dt-schema/blob/master/schemas/chosen.yaml#L77:
> 
>     $ref: types.yaml#/definitions/uint64-array
>     maxItems: 2
>     description:
>       This property (currently used only on arm64) holds the memory 
> range,
>       the address and the size, of the elf core header which mainly 
> describes
>       the panicked kernel\'s memory layout as PT_LOAD segments of elf 
> format.
> 
> Hence "linux,elfcorehdr" should be a property of the /chosen node,
> instead of a memory node with a compatible value of "linux,elfcorehdr".
> 

That's a binding for a property on the /chosen node, that as the text 
says it's defined for arm64 only and the code that handled it was also 
on arm64. Instead the reserved-region binding I used is a standard 
binding, if you don't like the name used for the compatible string 
because it overlaps with that property we can change it. I want to use a 
reserved-region for this because we'll have to reserve it anyway so 
using a property on /chosen and then using that property to reserve the 
region seemed suboptimal.

>> v2:
>>  * Use linux,usable-memory on /memory instead of a new binding
> 
> This part seems to have been removed in v3 and later?
> Note that "linux,usable-memory-range" should be a property of the
> /chosen node, too, cfr.
> https://github.com/devicetree-org/dt-schema/blob/master/schemas/chosen.yaml#L85
> 

No special handling is needed when using linux,usable-memory on /memory, 
limiting the available memory is handled by generic code at 
drivers/of/fdt.c

Regards,
Nick
