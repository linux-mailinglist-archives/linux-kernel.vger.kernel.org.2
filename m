Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDBD43C6BC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 11:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbhJ0JsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 05:48:00 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:35516 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbhJ0Jr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 05:47:56 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4HfP210Fxmz1qwxk;
        Wed, 27 Oct 2021 11:45:29 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4HfP2068n6z1qqkB;
        Wed, 27 Oct 2021 11:45:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id aM9GS1BKj2Zb; Wed, 27 Oct 2021 11:45:27 +0200 (CEST)
X-Auth-Info: C2/eG4m35MkI9B3Bxg1aiLH7XdmCmAifjuwSKAmQZlq5VktfNATtjZ8fcmt6k9ZP
Received: from igel.home (ppp-46-244-163-205.dynamic.mnet-online.de [46.244.163.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 27 Oct 2021 11:45:27 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 591102C2200; Wed, 27 Oct 2021 11:45:27 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, alex@ghiti.fr,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH] RISC-V: Make CONFIG_RELOCATABLE user selectable
References: <20211026212847.43108-1-palmer@dabbelt.com>
        <87mtmuaodc.fsf@igel.home>
        <CA+zEjCuRuKtZAhkS_RFyby6UhLvYmg=4BdnXEwUdaCdtbB7ZAA@mail.gmail.com>
X-Yow:  It's the land of DONNY AND MARIE as promised in TV GUIDE!
Date:   Wed, 27 Oct 2021 11:45:27 +0200
In-Reply-To: <CA+zEjCuRuKtZAhkS_RFyby6UhLvYmg=4BdnXEwUdaCdtbB7ZAA@mail.gmail.com>
        (Alexandre Ghiti's message of "Wed, 27 Oct 2021 10:58:44 +0200")
Message-ID: <87ee86ajig.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Okt 27 2021, Alexandre Ghiti wrote:

> On Wed, Oct 27, 2021 at 10:03 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
>>
>> On Okt 26 2021, Palmer Dabbelt wrote:
>>
>> > +config RELOCATABLE
>> > +     bool "Build a relocatable kernel"
>> > +     depends on MMU && 64BIT && !XIP_KERNEL
>> > +     help
>> > +          This builds a kernel as a Position Independent Executable (PIE),
>> > +          which retains all relocation metadata required to relocate the
>> > +          kernel binary at runtime to a different virtual address than the
>> > +          address it was linked at.
>> > +          Since RISCV uses the RELA relocation format, this requires a
>> > +          relocation pass at runtime even if the kernel is loaded at the
>> > +          same address it was linked at.
>>
>> When in doubt, do what?
>
> Then do not enable.

Please add that to the help string.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
