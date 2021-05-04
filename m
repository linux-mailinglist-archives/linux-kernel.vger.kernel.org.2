Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14023726D3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 09:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhEDH4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 03:56:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52246 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhEDH4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 03:56:12 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620114916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EG4tNJcjNsmsslrGSicquG7Fu1CihCNL07ZbolWDgHQ=;
        b=jZspfJ0z46Gap2x0s9kMV9rquHr/aUkaPA48jfmnbiMuVy27yFZadthxxCgSib8tni/aud
        PuiWBRV1kCBTGulXTZflzaKB//CqB8GafGZ4psxkCAfsY3dgZO5gumRoaWArNu5/NFeBTO
        +dvh7aLsm9k2SXXHxOV5ba+f0ehfYlMzZNmqPidCoqhx/WsEgCeStDQ1zl+1L7KRRU7PDy
        pqNa5/Z04OWe6NEX50JlrenWl9SHig29pvRMPUL8lw00XdfwzS7aFplV1/x7vFswr9Zlgf
        jzakyrEmbLEzidBzxE+wW9kYDqIHHI4fsfgVaWopGEGBpjEO01DivZ7NHziozw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620114916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EG4tNJcjNsmsslrGSicquG7Fu1CihCNL07ZbolWDgHQ=;
        b=qgJIu8H/AsATE3brN7k4w2CxE+Uunir/O9znRbq13nLO/lnmNWLI6jmoi+PfikOYBFda8T
        SRjhX4ChYmvMJTAQ==
To:     "Anand K. Mistry" <amistry@google.com>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86: Add a prompt for HPET_EMULATE_RTC
In-Reply-To: <CAATStaMkJ_xdkHutcgH2bmZiO3z6fKoLNrP5=Q3XUsNTpvHP5g@mail.gmail.com>
References: <20210429155950.v2.1.I2392cf11fb353d10459958100b69d93346fa167c@changeid> <87bl9se07w.ffs@nanos.tec.linutronix.de> <CAATStaMkJ_xdkHutcgH2bmZiO3z6fKoLNrP5=Q3XUsNTpvHP5g@mail.gmail.com>
Date:   Tue, 04 May 2021 09:55:16 +0200
Message-ID: <87zgxbhr17.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04 2021 at 11:21, Anand K. Mistry wrote:
> On Mon, 3 May 2021 at 17:38, Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Thu, Apr 29 2021 at 16:00, Anand K. Mistry wrote:
>>
>> > This does two things:
>> > 1. Makes the option visible in menuconfig, allowing the user to easily
>> >    disable this option
>> > 2. Allows olddefconfig to respect the option if it is set in the old
>> >    .config file
>>
>> Well, it's pretty clear WHAT it does, but there is absolutely no
>> reasoning WHY this knob is needed in the first place.
>
> Without this option, 'make oldolddefconfig' ignores the option in the
> old .confg file and just sets it to the calculated default for the
> platform. An easy way to test this is to do 'make defconfig' on
> x86-64, set CONFIG_HPET_EMULATE_RTC=n in the generated .config, and
> run 'make olddefconfig'. Without this patch, olddefconfig will ignore
> the set option and overwrite it with CONFIG_HPET_EMULATE_RTC=y.

Rightfully so because it's a functional correctness issue. When HPET is
enabled in legacy mode it takes over the RTC interrupt line, which makes
RTC alarms disfunctional and therefore we have to emulate it. 

So, no.

> So, part of the why is that this enables the use of olddefconfig with
> the CONFIG_HPET_EMULATE_RTC option. The other part of why is that my
> team uses 'make olddefconfig' by providing a base config and then
> using olddefconfig to fill in the unset values with defaults to make a
> complete config file for a kernel build. I'd like to disable RTC
> emulation on a particular platform, but I can't use a config option to
> do it without this patch because 'make olddefconfig' will just ignore
> the option.

You can like to disable it, but that does not make it more correct. See
above. If your platform does not have RTC_DRV_CMOS then you have to
disable that which will also clear CONFIG_HPET_EMULATE_RTC.

Thanks,

        tglx
