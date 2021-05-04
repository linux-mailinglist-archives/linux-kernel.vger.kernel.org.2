Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234BB37243A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 03:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhEDBXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 21:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhEDBXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 21:23:06 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089A4C061574
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 18:22:12 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n2so7533513wrm.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 18:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IzzF3KWafe/C9Je1bpczoCEDkbcz8tx6HwYKHoZrMEk=;
        b=VxvvcTMYV0obIK7tRheNVtgrR/JG1/COkQhKXAftG++ZjidFixX2dUHxZ/59YEj/Uw
         mELcgKzyo+RExSPuTF9nGIFy6E60vtGo1ddFIqAdfwmq7sBKKKivymZCBcnXNcuYubo5
         LJB9fW7D/q2sODFNE6+CEyxSxltbyzoy0EcUW9mb/xLavfX4Bd6NdhtkXLFKD7v2gVD/
         tMhmG+EYv+jnUdRmebpWnAFAZEFln18aq6uAHPAmab9SOTT5oek5r2jvViB9elKKMaz6
         /pRcGiS8rBELf7ahoWeFYW16bIqAtK2WdQCpeppol/p8R5XumYN3ecnP8L6nyIjoyqOB
         jH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IzzF3KWafe/C9Je1bpczoCEDkbcz8tx6HwYKHoZrMEk=;
        b=NyTj8K0jPwKmYKl4iSfXoCBdHeb4d0KITxgycih3kQktQjvGQ5V+c77J1o5en2Qkma
         f17c0HO6SfpASwB3pYu2m23/f1c5vCEQ8gbedzTCqRBVjO4wD2RFBsZOsapEFuwo8RKg
         MliWOoSB1XxOJ7UOtzm/mfmlIpZ5hFmIR19jHla82nawivV8xW4mJQr7xEuahajO6rm2
         4WRfyzSycdn3pML7v8WbUQo4b80IjjBaxmEourVLHn/AZDXxlapcqYez0DmZ6tkKllZK
         NlJluioi9vvFZhBgk0Z1c+21ZC3+u0KGwycEzxuYpNZWTORTsQjXvsPOC7xxy7ikvv2U
         W67w==
X-Gm-Message-State: AOAM530yD6dBknTz7RW7vPxI/WzFzbOo8FAvrlqyoHBDqh3DpZZLI6KS
        DmYj+cG7T5xrSTgt3DT6CP5Eo3r1wLXmOWvM30rFjw8jsUvMOg==
X-Google-Smtp-Source: ABdhPJyEtjQnZpu8HvmeYDtQI2iFxahQwAHTiZhO+cZrhBMTi3pfDL1uQWTQbzzVt2RieIfqzCH6sQmAjTneraHQWJQ=
X-Received: by 2002:a5d:5047:: with SMTP id h7mr15213218wrt.287.1620091330434;
 Mon, 03 May 2021 18:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210429155950.v2.1.I2392cf11fb353d10459958100b69d93346fa167c@changeid>
 <87bl9se07w.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87bl9se07w.ffs@nanos.tec.linutronix.de>
From:   "Anand K. Mistry" <amistry@google.com>
Date:   Tue, 4 May 2021 11:21:58 +1000
Message-ID: <CAATStaMkJ_xdkHutcgH2bmZiO3z6fKoLNrP5=Q3XUsNTpvHP5g@mail.gmail.com>
Subject: Re: [PATCH v2] x86: Add a prompt for HPET_EMULATE_RTC
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 May 2021 at 17:38, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, Apr 29 2021 at 16:00, Anand K. Mistry wrote:
>
> > This does two things:
> > 1. Makes the option visible in menuconfig, allowing the user to easily
> >    disable this option
> > 2. Allows olddefconfig to respect the option if it is set in the old
> >    .config file
>
> Well, it's pretty clear WHAT it does, but there is absolutely no
> reasoning WHY this knob is needed in the first place.

Without this option, 'make oldolddefconfig' ignores the option in the
old .confg file and just sets it to the calculated default for the
platform. An easy way to test this is to do 'make defconfig' on
x86-64, set CONFIG_HPET_EMULATE_RTC=n in the generated .config, and
run 'make olddefconfig'. Without this patch, olddefconfig will ignore
the set option and overwrite it with CONFIG_HPET_EMULATE_RTC=y.

Or, tested on 5.12:
~/linux-stable % make defconfig
... SNIP
#
# configuration written to .config
#
~/linux-stable % grep CONFIG_HPET_EMULATE_RTC .config
CONFIG_HPET_EMULATE_RTC=y
~/linux-stable % sed -i 's/EMULATE_RTC=y/EMULATE_RTC=n/g' .config
~/linux-stable % grep CONFIG_HPET_EMULATE_RTC .config
CONFIG_HPET_EMULATE_RTC=n
~/linux-stable % make olddefconfig
#
# configuration written to .config
#
~/linux-stable % grep CONFIG_HPET_EMULATE_RTC .config
CONFIG_HPET_EMULATE_RTC=y

With this patch, the 'make olddefconfig' results in:
~/linux-stable % grep CONFIG_HPET_EMULATE_RTC .config
# CONFIG_HPET_EMULATE_RTC is not set

So, part of the why is that this enables the use of olddefconfig with
the CONFIG_HPET_EMULATE_RTC option. The other part of why is that my
team uses 'make olddefconfig' by providing a base config and then
using olddefconfig to fill in the unset values with defaults to make a
complete config file for a kernel build. I'd like to disable RTC
emulation on a particular platform, but I can't use a config option to
do it without this patch because 'make olddefconfig' will just ignore
the option.

Debugging why this was the case, I discovered the kconfig tools
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/kconfig/symbol.c#n379)
ignore set values if the option is not visible. Why this is the case,
I don't know. But it looks like in order to have kconfig respect the
config value, it must be visible.

>
> Thanks,
>
>         tglx




--
Anand K. Mistry
Software Engineer
Google Australia
