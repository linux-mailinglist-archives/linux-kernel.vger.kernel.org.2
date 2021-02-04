Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F87230FEE6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhBDUyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 15:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhBDUyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 15:54:14 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD79C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 12:53:34 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d16so5130936wro.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 12:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rm5E9I1Jnn2NR1RO/ViDD1T8VZeACseCrpKELC+5NQw=;
        b=owgB8nNrnI5qMsy6/a5v4tEwJsXpxovCtyjyXzWseibL0mCMLHVodUifJQxJL5YWbJ
         ZBctmBUU4cbCVacXfwqJTgIx8DAhet9+0Vum2yXCTPqyw8M6o0lBD2bKieeBYnMJFMSC
         Bogl0I9V9mckmZ7OJi7Vaj+1cTnayKXOlwhM9+Topkhpl/JSR1LM2KtJU48YyW6bFryL
         fETjr19TArDscNemwu+Gj1hiov2J6iJF7UCoviZrA4c6Pksji3YjQ0JatkHbrxww+DFE
         7Bn+pOCO3CZdQQpe78WRUAUwz6tBKco9I20Z8mRSHeg0nO/0UJOsdxbyL2tXU8UsLTVg
         OPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rm5E9I1Jnn2NR1RO/ViDD1T8VZeACseCrpKELC+5NQw=;
        b=kcN4gZ+s1vdNec31cLOq6C0GaWhOWGfzBiNboCWtH6ArUCidbcYNwK0Vjo2lkid5eR
         Wnf1FQ2dRZXGaRVxLz1JMRcoTKFBLnwrK7Qzi6MSLuMWKFfjZrWmmwHTZDSidpayKst3
         Sas/DM/aVVhJtPAHuDRAMCWD3owA6svOpLyG21EtEeRleXkl6GDdQjpDfupZ02Tg9rh4
         92H4E8UrMoWT3QGeoey+5kqMurHRZYTg1TokhbAXvjz6KrF3+W/2JyuTs/HR1fkdzlVm
         CFj7SD3z3yUIW2izIrjVpWIhn85O22oRWwjZWMeJM3wLGqp9km/3m3Yh37Wyj7WjLOj2
         prEA==
X-Gm-Message-State: AOAM5332hpHVfauKya4NZI9Rp8LJPFa4lqERzjBVWm5ygi6J6rXBTEhH
        ZnQ/Eo3DgUVXMrjIO5whUAlYO4sTQTxETvxOttzYEA==
X-Google-Smtp-Source: ABdhPJyaKxSl7I9CzmRMbFP8kloBqVHo6tv5EPkxsupi7HtcL9Bld+RxAlz1/jR/V91cApAU0cIxKEIyM6YC7x43auU=
X-Received: by 2002:adf:ffce:: with SMTP id x14mr1321596wrs.390.1612472012547;
 Thu, 04 Feb 2021 12:53:32 -0800 (PST)
MIME-Version: 1.0
References: <20210204132043.1.I2392cf11fb353d10459958100b69d93346fa167c@changeid>
 <ec6caa23-28d6-9695-2b0f-b3ba9ef28b60@infradead.org> <CAATStaMRHai=jWr4x1cZVs2MrME+1QSqoXD75xAOQfxb723hQQ@mail.gmail.com>
 <507e5062-f575-e034-d6fa-f1dca4bbbcc9@infradead.org> <CAATStaNxPwkVGUxTMUP+GdD+y=die7hZxYFaugwTNJ3c7W=PGA@mail.gmail.com>
 <586ac6a2-0b2b-1f15-47f6-8c42444133be@infradead.org> <ec62883b-a09f-e1e5-3c01-d5316d94e91b@infradead.org>
In-Reply-To: <ec62883b-a09f-e1e5-3c01-d5316d94e91b@infradead.org>
From:   "Anand K. Mistry" <amistry@google.com>
Date:   Fri, 5 Feb 2021 07:53:20 +1100
Message-ID: <CAATStaMi+qCJRz+AEfZBau=Y2HDsrEkjJ-WSETY1GP6drwZUbw@mail.gmail.com>
Subject: Re: [PATCH] x86: Add a prompt for HPET_EMULATE_RTC
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Hi,
> >
> > On plain vanilla 5.11-rc6, when I take this (partial) .config file
> > which contains:
> >
> > CONFIG_HPET=y
> > # CONFIG_HPET_EMULATE_RTC is not set
> > # CONFIG_HPET_MMAP is not set
> >
> > and run
> > $ make olddefconfig
> >
> > my new .config file contains
> >
> > CONFIG_HPET_TIMER=y
> > CONFIG_HPET_EMULATE_RTC=y
> > CONFIG_HPET=y
> > # CONFIG_HPET_MMAP is not set
> >
> >
> > Isn't that what you are expecting?
> > or are you trying to keep the opposite?
> >
> > # CONFIG_HPET_EMULATE_RTC is not set
> >
> > Hm, I bet that I misunderstood you and you want to keep
> > it disabled. Is that right?

Yes, I want to keep it disabled. My understanding (from the behaviour
I've seen with other settings, as well as reading the sources) is that
"is not set" is treated the same as "n".

In fact, if you change the old config to CONFIG_HPET_EMULATE_RTC=n,
you get the same before/after behaviour of this patch. Before,
olddefconfig will ignore the old setting and change it to "y". With
this patch, olddefconfig keeps the old setting, but re-writes it to
"is not set". This is even more surprising because the user is
explicit in what the old config setting is, but olddefconfig still
ignores it.

>
> If that's the case, then I agree that your original patch to
> make HPET_EMULATE_RTC user-visible is needed.
>
> Sorry to be so slow about understanding your goal (if I do
> understand it now).
>
> --
> ~Randy
>


-- 
Anand K. Mistry
Software Engineer
Google Australia
