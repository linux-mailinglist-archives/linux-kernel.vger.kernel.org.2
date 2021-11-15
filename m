Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C6E4518C7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 00:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348304AbhKOXHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 18:07:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:58130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243378AbhKOS5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 13:57:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 602C263490;
        Mon, 15 Nov 2021 18:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636999972;
        bh=F2zxYeotaXaYYRbtc8RJuA8MUR9XNAAv9/FV2gkGsE0=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=NT7VE7GS7I2V3wz2Pf+ZkbdwQCQChbnaDADjmk3lo2tzFAMxZcY/uq9Sz/2V3KcvY
         c+dNppx/5tuL4cPZI0Dsm7v61Pftpl1ke6QUzeT6L6fvFapphwYtHXUlxzV3CqzUxK
         TwlDfH7AvTdoIdNeDSkPgYQGqXa1HK3RSLaihWz+yNScp/VdqRhwJQ7kUATSlw+40c
         udbmC5hw7v3qpC4Ql+ww8FtitzUfQ3qJjSIC6gEKgP8kyQMxKUt6YzrGU3DcowrqmM
         f0Ga4l62o/7rC9+/e01aDnWk1NpBtLPJ6FR6WyEBdpgtnf/mip9txus1JKq1/+oAwz
         BVhmNCJizXZNA==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 74D7427C005A;
        Mon, 15 Nov 2021 13:12:50 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Mon, 15 Nov 2021 13:12:50 -0500
X-ME-Sender: <xms:IaOSYdqKA8M3JPabD-e9BvuQvBSMIh3HuxzzT5lzVPC0rpqmr107Qg>
    <xme:IaOSYfoWMIxW2ePIZULEfCMqU0lfsaz6sccxS_3E2bTXF7B3vbKBi1VqvkWPAx4S5
    1Dk5fxh-yDGM2n4IIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfedtgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedvleehjeejvefhuddtgeegffdtjedtffegveethedvgfejieevieeu
    feevuedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
    ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
    drlhhuthhordhush
X-ME-Proxy: <xmx:IaOSYaO89tYJPvGPuUBU3NqHL7AO8t2GfPADk8AOcctuzQtTer5aAA>
    <xmx:IaOSYY4vsLlKD1QuryEfCYhJeB1zb0H3Sj5e-Wm4XJ9VU4XeXbBP5g>
    <xmx:IaOSYc6X6ZGC9mL1wLp8Qm0a62U-U49-ndwNMeXxizNhGtDliXinVg>
    <xmx:IqOSYWTrAyK6GaN--s3z2QmqkbJPa3nylwOJ0syFlTHLuqMi_k5vJw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E937521E006E; Mon, 15 Nov 2021 13:12:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1371-g2296cc3491-fm-20211109.003-g2296cc34
Mime-Version: 1.0
Message-Id: <712750e7-a00a-4573-8864-0c07286289e3@www.fastmail.com>
In-Reply-To: <CAMzpN2jWs8heND7PydKw9CCZ0cjvJgxLMwXXQj45rwR6twpJLw@mail.gmail.com>
References: <20211113124035.9180-1-brgerst@gmail.com>
 <20211113124035.9180-4-brgerst@gmail.com>
 <719e0170-7645-4787-8c3a-676f34068c27@www.fastmail.com>
 <CAMzpN2gbOzsmnAh330+zk+ZZQmk-xNdUdCar6WaPrvHtgzknTA@mail.gmail.com>
 <20211114110305.GN174703@worktop.programming.kicks-ass.net>
 <CAMzpN2jWs8heND7PydKw9CCZ0cjvJgxLMwXXQj45rwR6twpJLw@mail.gmail.com>
Date:   Mon, 15 Nov 2021 10:12:28 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Brian Gerst" <brgerst@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Borislav Petkov" <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, "Ingo Molnar" <mingo@kernel.org>
Subject: Re: [PATCH 3/3] x86_64: Use relative per-cpu offsets
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, Nov 14, 2021, at 10:29 AM, Brian Gerst wrote:
> On Sun, Nov 14, 2021 at 6:03 AM Peter Zijlstra <peterz@infradead.org> =
wrote:
>>
>> On Sat, Nov 13, 2021 at 11:54:19PM -0500, Brian Gerst wrote:
>> > On Sat, Nov 13, 2021 at 8:18 PM Andy Lutomirski <luto@kernel.org> w=
rote:
>> > >
>> > >
>> > >
>> > > On Sat, Nov 13, 2021, at 4:40 AM, Brian Gerst wrote:
>> > > > The per-cpu section is currently linked at virtual address 0, b=
ecause
>> > > > older compilers hardcoded the stack protector canary value at a=
 fixed
>> > > > offset from the start of the GS segment.  Use a standard relati=
ve offset
>> > > > as the GS base when the stack protector is disabled, or a newer=
 compiler
>> > > > is used that supports a configurable location for the stack can=
ary.
>> > >
>> > > Can you explain the benefit?  Also, I think we should consider dr=
opping support for the fixed model like we did on x86_32.
>> >
>> > This patch probably makes more sense if we drop the fixed model, as
>> > that gets rid of alot of code that works around having to link the
>> > percpu section differently.
>>
>> Can someone spell out these benefits please? To me having per-cpu sta=
rt
>> at 0 makes perfect sense, how does not having that make things better?
>
> The best reason is that the percpu section is currently not subject to
> KASLR.  It actually needs extra support to counter the effects of
> relocation.  There have also been a number of linker bugs over the
> years that have had to be worked around.
>
> If we were to decide to drop the fixed stack protector the diffstat
> would look something like:
>
>  arch/x86/Makefile                         |  19 ++--
>  arch/x86/boot/compressed/misc.c           |  12 ---
>  arch/x86/entry/entry_64.S                 |   2 +-
>  arch/x86/include/asm/percpu.h             |  22 -----
>  arch/x86/include/asm/processor.h          |  24 ++---
>  arch/x86/include/asm/stackprotector.h     |  13 +--
>  arch/x86/kernel/asm-offsets_64.c          |   6 --
>  arch/x86/kernel/cpu/common.c              |   8 +-
>  arch/x86/kernel/head_64.S                 |  11 ++-
>  arch/x86/kernel/irq_64.c                  |   1 -
>  arch/x86/kernel/vmlinux.lds.S             |  33 -------
>  arch/x86/tools/relocs.c                   | 143 +--------------------=
---------
>  arch/x86/xen/xen-head.S                   |  10 +--
>  scripts/gcc-x86_64-has-stack-protector.sh |   2 +-
>  14 files changed, 35 insertions(+), 271 deletions(-)
>

Ack.  We did this for 32-bit and got few complaints. Let=E2=80=99s finis=
h the job.

> --
> Brian Gerst
