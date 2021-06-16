Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3DE3A97F3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhFPKps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 06:45:48 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:20541 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbhFPKpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:45:46 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 15GAhbJm078683
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 13:43:37 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1623840212; x=1626432212;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GvWDrpQ18tJYXKrSYhkofkZAxdsZKJZtHm7ZMn9f9q0=;
        b=Ox7pnLZpX/WR/RaCMSSFZyDMCrbV7+K6Fr9YaX95rJM7mpa+VHMmbiIKifK6D5pb
        vHZ74rjVGPrmiLeYPH52cBgB+M93USYDiDguv/5ykYyXnV8x2Z10ny3HJdlN2f6A
        FH2CD9lF1P88oTSc9bU6AhTwr9tLV2eIF8nSMvuqBkELPEl/cYBv9MMN5yuDSoJp
        WnpvgpbbnZ/RrR11EcHOyEBfPsKcGlk70+D+tJeQvkBDn30UYYaMwXq1bfvKEBFG
        fB9csLoGiO+0g4JCohqLVP8np14NKV/PbikgrPjtSFzD/a/WbRSqNuNFiHjru4ww
        X0nNMNpXzXYfBDSw314hJA==;
X-AuditID: 8b5b014d-96ef2700000067b6-d2-60c9d5d4bb02
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 89.7A.26550.4D5D9C06; Wed, 16 Jun 2021 13:43:32 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 16 Jun 2021 13:43:32 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        Rob Herring <robh+dt@kernel.org>,
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
Subject: Re: [PATCH 2/3] riscv: Remove non-standard linux,elfcorehdr handling
Organization: FORTH
In-Reply-To: <CAMuHMdVRcN+y0kwxxEH8UGo6bRT9SvxRSLU8VzWJFx=yLQ5S0g@mail.gmail.com>
References: <cover.1623780059.git.geert+renesas@glider.be>
 <bcc5c666f4ada9a8bbc26f559751f0da67f769f8.1623780059.git.geert+renesas@glider.be>
 <abadee118c1945c44d9bff7675b12ec4@mailhost.ics.forth.gr>
 <CAL_JsqLU7GWDxdnR2-Yd2vbj7w=5pNr_fFocDQgPbs17EpBG0g@mail.gmail.com>
 <bdfbf7cc997a10a94331d77332dbe88e@mailhost.ics.forth.gr>
 <CAMuHMdVRcN+y0kwxxEH8UGo6bRT9SvxRSLU8VzWJFx=yLQ5S0g@mail.gmail.com>
Message-ID: <ef1a9a97e0238a0ff2d8e044487602a5@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42Lpjp6urHvl6skEgzkPRCy2/p7FbvF+WQ+j
        xfwj51gtZr75z2bx7NZeJotNj6+xWlzeNYfNYtvnFjaL5nfn2C1eXu5htmibxW/RuvcIu0XL
        HVMHXo8189Ywerx5+ZLF43DHF3aPnbPusns83HSJyWPTqk42j0OHOxg9Ni+p97jUfJ3d4/Mm
        uQCuKC6blNSczLLUIn27BK6Mn837WQq+sVX07L7A1sB4h7WLkZNDQsBE4v6kx8xdjFwcQgJH
        GSUuf5jKApEwlZi9t5MRxOYVEJQ4OfMJWJxZwEJi6pX9jBC2vETz1tnMIDaLgKrE57+dYEPZ
        BDQl5l86CFTPwSEioCsx5ycTyHxmgYmsEpv2zgGrERbwlfg18yI7iM0vICzx6e5FsDinQKDE
        hFUH2SAOmsQs8fPVeRaII1wkrsxZyQxxnIrEh98P2EEWiALZm+cqTWAUnIXk1FlITp2F5NQF
        jMyrGAUSy4z1MpOL9dLyi0oy9NKLNjGCY4vRdwfj7c1v9Q4xMnEwHmKU4GBWEuHVLT6RIMSb
        klhZlVqUH19UmpNafIhRmoNFSZyXV29CvJBAemJJanZqakFqEUyWiYNTqoGJxT+6LTRK5EzI
        IwXmXUYeiqUrtvmIsam93uS22E1vpT1TwMHCToGLjgccH+112Nm6Mj0//+T2hqPBR+0NN3T7
        /HtbfuxCUfVz9ygZfmNWzcU+h2YEfPtieCowYoKP8EbDLRNv//hm+0Axbd+99VIm7z2m/pRs
        vpOlV7pDQf/yvscs8xwN3j7Kc9w4d8ae3Wdm5laWvf5SdGI+z7OcibvtRdYLvf+UcnLzD57Z
        1kb6Rnf0Dqxbxvx/zSXl/vqVySbdCVa5brXn97lLz7wzk/vC5+5tddPZs7ueXd2sFJbjOlOL
        a9YCtkkLutV9bwvejP1c2rfrpk5ftEKO0fu1jrMqFyx1Lz25X2Kh9tv1GTIzlFiKMxINtZiL
        ihMBoMjLOxwDAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2021-06-16 10:56, Geert Uytterhoeven έγραψε:
> 
> I can't comment on the duplication on arm64, but to me, /chosen
> sounds like the natural place for both "linux,elfcorehdr" and
> "linux,usable-memory-range".  First rule of DT is "DT describes
> hardware, not software policy", with /chosen describing some software
> configuration.
> 

We already have "linux,usable-memory" on /memory node:
https://elixir.bootlin.com/linux/v5.13-rc6/source/drivers/of/fdt.c#L1011
and it makes perfect sense to be there since it overrides /memory's reg 
property.

Why define another binding for the same thing on /chosen ?

> 
> OK, thanks!
> But do you need the entry on the reservation map?
> 

I'll add the entry from kexec-tools, so that the kernel will reserve the 
region as part of:
https://elixir.bootlin.com/linux/v5.13-rc6/source/drivers/of/fdt.c#L605
