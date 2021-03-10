Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538C43334C5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 06:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhCJFPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 00:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhCJFPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 00:15:10 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A269BC061763
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 21:15:09 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id p21so31261353lfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 21:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UiJsJNOiBm83fFLXpqk2WZEpnaCEog3O/QAN1Beolgw=;
        b=mMxAC7+XqZJtvqPlzrX8H8HsuDT3PIQhBPZgHEZY7uSUXMOt8eK64tK1BN2d2NJ87O
         dy5qm0kARf89bitpEgGirnDhLNypQzkyVSp6Uc7SMLqE9ZpoA3ImyIcZzrQhGZkCzC23
         YLZ64Umyue7CnQPoip9grEaYaDmGmCEXDkKXEQeSj1qNAwm2Gd0ZhIX2aXrPsNqsED4T
         /Jr8ZYX7newASgm08bVGZv7gokq5WIWnEXSZfju3yfxW8bb9GjsMLud/iAdJpiEH7Rom
         wCvq80nt9aOaBrdykb4ISM4GI8Bd5xQd45Vi8qlpDxnk3IlXKf1I8kGhLlZNBsgTNuXx
         BELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UiJsJNOiBm83fFLXpqk2WZEpnaCEog3O/QAN1Beolgw=;
        b=UQH8OhnUriH0XrAuzj0s7dcn31uq3kHCZdEJ5Smnvqf+IVg6pQoUm3hq1IsR9Ab/vz
         hTNHxLXnjPOXY+8keqloOfBRwN5TwMFjIHQBqGX1Ztp09xiXhkHpXO3nkxDcjG5YX/ms
         3/R54JzQWG39fCrNAr7TsD3CO5L09bPmdL1SkTHS9BfvUvJNxR6/dozh2mdVxALUMEyK
         uKLH+5fOXFijZsCYHA1WPIxkA4JfuSIT+QaD9wcsc8phUZ2D44WE6XBtCCOn0q/fIr63
         Ay8DnOUL58rrWaWK7y7mgkS0DAK2jUAR1QYfrBbkt9M8QgnintaJRlxRfh7Y1I0Vn0mj
         A38A==
X-Gm-Message-State: AOAM531cxyZSZKo822HZWtETHdqUjGnmBtb+xrVtRaOu/397N/zOR8LJ
        zg2hWD7/qUu56NXls4F+50D4h9akyMA+x1kAozh+9w==
X-Google-Smtp-Source: ABdhPJwFtZgar+wUjdSWUlZLQ5UKaYKz078M+ePh7BM1x6vt3vlU5X9TaM5D3xzXGLb+CzhnfsoM3ZqRIk4bKeD0wMA=
X-Received: by 2002:ac2:46db:: with SMTP id p27mr972790lfo.396.1615353307886;
 Tue, 09 Mar 2021 21:15:07 -0800 (PST)
MIME-Version: 1.0
References: <20210303135500.24673-1-alex.bennee@linaro.org>
 <20210303135500.24673-2-alex.bennee@linaro.org> <CAK8P3a0W5X8Mvq0tDrz7d67SfQA=PqthpnGDhn8w1Xhwa030-A@mail.gmail.com>
 <20210305075131.GA15940@goby> <CAK8P3a0qtByN4Fnutr1yetdVZkPJn87yK+w+_DAUXOMif-13aA@mail.gmail.com>
 <CACRpkdb4RkQvDBgTMW_+7yYBsHNRyJZiT5bn04uQJgk7tKGDOA@mail.gmail.com> <6c542548-cc16-af68-c755-df52bd13b209@marcan.st>
In-Reply-To: <6c542548-cc16-af68-c755-df52bd13b209@marcan.st>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 10 Mar 2021 10:44:56 +0530
Message-ID: <CAFA6WYOYmTgguVDwpyjnt3gLssqW48qzAkRD_nyPYg0nNhxT2A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To:     Hector Martin <marcan@marcan.st>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@linaro.org>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Joakim Bech <joakim.bech@linaro.org>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Ruchika Gupta <ruchika.gupta@linaro.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>, yang.huang@intel.com,
        bing.zhu@intel.com, Matti.Moell@opensynergy.com,
        hmo@opensynergy.com, linux-mmc <linux-mmc@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-nvme@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021 at 02:47, Hector Martin <marcan@marcan.st> wrote:
>
> On 09/03/2021 01.20, Linus Walleij wrote:
> > I suppose it would be a bit brutal if the kernel would just go in and
> > appropriate any empty RPMB it finds, but I suspect it is the right way
> > to make use of this facility given that so many of them are just sitting
> > there unused. Noone will run $CUSTOM_UTILITY any more than they
> > run the current RPMB tools in mmc-tools.
>
> AIUI the entire thing relies on a shared key that is programmed once
> into the RPMB device, which is a permanent operation. This key has to be
> secure, usually stored on CPU fuses or derived based on such a root of
> trust. To me it would seem ill-advised to attempt to automate this
> process and have the kernel do a permanent take-over of any RPMBs it
> finds (with what key, for one?) :)
>

Wouldn't it be a good idea to use DT here to represent whether a
particular RPMB is used as a TEE backup or is available for normal
kernel usage?

In case of normal kernel usage, I think the RPMB key can come from
trusted and encrypted keys subsystem.

-Sumit

> For what it's worth, these days I think Apple uses a separate, dedicated
> secure element for replay protected storage, not RPMB. That seems like a
> sane approach, given that obviously Flash storage vendors cannot be
> trusted to write security-critical firmware. But if all you have is
> RPMB, using it is better than nothing.
>
> The main purpose of the RPMB is, as the name implies, replay protection.
> You can do secure storage on any random flash with encryption, and even
> do full authentication with hash trees, but the problem is no matter how
> fancy your scheme is, attackers can always dump all memory and roll your
> device back to the past. This defeats stuff like PIN code attempt
> limits. So it isn't so much for storing crypto keys or such, but rather
> a way to prevent these attacks.
>
> --
> Hector Martin (marcan@marcan.st)
> Public Key: https://mrcn.st/pub
