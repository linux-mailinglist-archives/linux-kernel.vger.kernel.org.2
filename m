Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE0842C6C1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 18:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237272AbhJMQxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:53:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233731AbhJMQxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:53:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3CCB61168;
        Wed, 13 Oct 2021 16:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634143887;
        bh=LBXct+kmDvk5TkVtHHW7PAuxFFNJuafSepYBdwCX45M=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=XUWkhdoYmoYJ1RszQRAvXM1laNkpz+L2dSEERb+eQOYg8SwjCZEIovM6rBWLWJ4lo
         wogVzszJFYyAnG1Wp5aZRrZ8O26ZoSJ0QkEnAaBv9zV51nZoE2dIQ8km8CkvhM5is1
         u4r33jjRniHAqQLrpNbZg7NKSPq2psbNwzTpRgo8cYoiQ4DUek/fER6hLriDagshaQ
         YvPhGI2zI5zRQwlVt4PR69XnRphY1l9DUAtLHWYEsxm5zyaMYyc1TwxIs1yH1IfwtY
         u/IyDtuMuCfkPIaTw/gEOMAD88nU4qyYlmd6KmU/WLI910AdS/UDInJYzCq99p1ULr
         SWxYsS265cTBg==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id E276D27C0054;
        Wed, 13 Oct 2021 12:51:25 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Wed, 13 Oct 2021 12:51:25 -0400
X-ME-Sender: <xms:jA5nYdYIrqufvqR0QHSxKzwIPiJL1yNB3PkhEAY3pXqxj0ynWH4aiQ>
    <xme:jA5nYUYjSHb_-dxb1qcLJ_Okzhxz2WZOrqLpj4q7ahMY1Upty9x-CPxWjc6vBqM6l
    aYpH3MdJyJv_D6kjl8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddutddguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnheptdfhheettddvtedvtedugfeuuefhtddugedvleevleefvdetleff
    gfefvdekgeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:jA5nYf9AUFxaiR2f9tDmelAP3-v_r3_3-DfbpJmpn439msThUDgCXw>
    <xmx:jA5nYboyiLpT5i5cglr4OUO4waXIzqlJiZ60zGmaI7MsB_PNqr88Yw>
    <xmx:jA5nYYp5TBUp4JxLJpoyfgpKerCpmvQlX5K9ed8SL7dQlRZ6IbibIw>
    <xmx:jQ5nYf11V0b9Uw_lFNrmthfBfpLIaXxtUf6C9e0kYSzX-gQFZyZDPBzWrNg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6ED4221E006A; Wed, 13 Oct 2021 12:51:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1345-g8441cd7852-fm-20211006.001-g8441cd78
Mime-Version: 1.0
Message-Id: <98e38690-6be2-4839-99a4-148b61cc9749@www.fastmail.com>
In-Reply-To: <20211013163023.GD8557@1wt.eu>
References: <YWXwQ2P0M0uzHo0o@zn.tnic>
 <20211012222311.578581-1-ammar.faizi@students.amikom.ac.id>
 <YWbUbSUVLy/tx7Zu@zn.tnic> <20211013125142.GD5485@1wt.eu>
 <YWbZz7gHBV18QJC3@zn.tnic> <20211013140723.GE5485@1wt.eu>
 <YWbrR1BqI1CxneN/@zn.tnic> <20211013142433.GB8557@1wt.eu>
 <alpine.LSU.2.20.2110131601000.26294@wotan.suse.de>
 <20211013163023.GD8557@1wt.eu>
Date:   Wed, 13 Oct 2021 09:51:04 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Willy Tarreau" <w@1wt.eu>, "Michael Matz" <matz@suse.de>
Cc:     "Borislav Petkov" <bp@alien8.de>,
        "Ammar Faizi" <ammar.faizi@students.amikom.ac.id>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the clobber
 list
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Oct 13, 2021, at 9:30 AM, Willy Tarreau wrote:
> Hello Michael,
>
> On Wed, Oct 13, 2021 at 04:24:28PM +0000, Michael Matz wrote:
> (...)
>> In short:  Ammars initial claim:
>> 
>> > Linux x86-64 syscall only clobbers rax, rcx and r11 (and "memory").
>> > 
>> >   - rax for the return value.
>> >   - rcx to save the return address.
>> >   - r11 to save the rflags.
>> > 
>> > Other registers are preserved.
>> 
>> is accurate and I will clarify the psABI to make that explicit.
>
> Many thanks for this very detailed explanation! Ammar, I'll take your
> patch.

Acked-by: Andy Lutomirski <luto@kernel.org>

>
> Thanks all,
> Willy
