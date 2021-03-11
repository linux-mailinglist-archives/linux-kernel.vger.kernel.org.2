Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7FA337A85
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 18:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhCKRMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 12:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhCKRMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:12:07 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA32C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 09:12:06 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id a9so21334220qkn.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 09:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TSvvLBAPJ0EX/aN6NElajlnxXdyur7jPRoQFWWwQZ4k=;
        b=Cp3CzBv9k1N0jru2/I09rgwa1ckIYCaJ25o692QLbFYcD1Sqch2sbvaBnEF8B9+XFX
         bI140VmL7hiW+m5PMPmAjzYoJGbWUbA7Je9O4IoTxoE2bRroisTf6RAdverjSi5PxUbf
         3cuEBLKVcJ9k81q3RAKmRy8Ucoghnhw3wNrGw1Qy7LEQJAIUaGDxCd126TpqoFMKkUbO
         VGMnhrDH4NicdgU0KfuBOiEWjrjMR8rhlQsXR+PTq3XVRG2NZIUwc1jGRAT49zhx014s
         v0Jbups5hH/WtBdjtrUccOd8NARjrxAoqI1B4auIotrOM80ZcOpFAZEefqf/baJw6QB2
         0CWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TSvvLBAPJ0EX/aN6NElajlnxXdyur7jPRoQFWWwQZ4k=;
        b=VoO6BjsOvfo12Gw4+zqQndUO59Kxh2aF48YOHwHqwxPSd/4nVGmxL5k4vY4o1XdawZ
         J76o8poL2AXO4wntpv/OnvYjOQg0DmO2RA8WPuw+pGSMbjQLwHv77NM8CSripws/FtMn
         0GFK3YwFY4oYlgbWgjDc81MNOdNFEugqiynhXCp2WYB3vAh/TsLljR9oLtB36ImdvKo8
         6QqoyvEdffzbJrG0awLHHH/8lTDKvFZMoX6P5wenMVk/Sg6LLpbHvnbGdSNPTbfWLNcT
         gfnibEZq7TckHtY0zRiV1ghEd8NVLu4HRZ5c17LPMW5ecN+2BKqBiFCyCML1LgpcQANk
         8gpw==
X-Gm-Message-State: AOAM530K5IjHEGD3thI3Z+RU4/MlofFEd6a2qUad0KDvD+g6fiqeUZ6f
        CjXobRrH5KcYuNDAcaTtTsmLBKUZ/C4p2vE8KcTMA8hy7wc08Q==
X-Google-Smtp-Source: ABdhPJyYqq+WcTVVF7Da3fyLl3E5C46PjkBA8p42cikHh6H4SwSc0d8uyqbcTDVkg9xstpK5g1Scm25tHjIzt68j3n4=
X-Received: by 2002:a05:620a:410f:: with SMTP id j15mr8661471qko.424.1615482725536;
 Thu, 11 Mar 2021 09:12:05 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
 <20210311123315.GF37303@C02TD0UTHF1T.local>
In-Reply-To: <20210311123315.GF37303@C02TD0UTHF1T.local>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 11 Mar 2021 18:11:54 +0100
Message-ID: <CACT4Y+a0WkbcDwUHaVsNiACDWjMM3hK4qG5dX2BPyZDGom6Mrw@mail.gmail.com>
Subject: Re: arm64 syzbot instances
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     maz@kernel.org, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 1:33 PM Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Mar 11, 2021 at 12:38:21PM +0100, 'Dmitry Vyukov' via syzkaller wrote:
> > Hi arm64 maintainers,
> > The instances have KCOV disabled because it slows down execution too
> > much (KASAN in qemu emulation is already extremely slow), so no
> > coverage guidance and coverage reports for now :(
> >
> > The instances found few arm64-specific issues that we have not
> > observed on other instances:
> > https://syzkaller.appspot.com/bug?id=1d22a2cc3521d5cf6b41bd6b825793c2015f861f
> > https://syzkaller.appspot.com/bug?id=bb2c16b0e13b4de4bbf22cf6a4b9b16fb0c20eea
> > https://syzkaller.appspot.com/bug?id=b75386f45318ec181b7f49260d619fac9877d456
> > https://syzkaller.appspot.com/bug?id=5a1bc29bca656159f95c7c8bb30e3776ca860332
> > but mostly re-discovering known bugs we already found on x86.
>
> Likewise, my general experience these days (fuzzing under KVM on a
> ThunderX2 host) is that we mostly hit issues in core code or drivers
> rather than anything strictly specific to arm64. As my host is ARMv8.1
> that might just be by virtue of not exercising many of the new
> architectural features.
>
> > The instances use qemu emulation and lots of debug configs, so they
> > are quite slow and it makes sense to target them at arm64-specific
> > parts of the kernel as much as possible (rather
> > than stress generic subsystems that are already stressed on x86).
> > So the question is: what arm64-specific parts are there that we can reach
> > in qemu?
> > Can you think of any qemu flags (cpu features, device emulation, etc)?
>
> Generally, `-cpu max` will expose the more interesting CPU features, and
> you already seem to have that, so I think you're mostly there on that
> front.
>
> Devices vary a lot between SoCs (and most aren't even emulated), so
> unless you have particular platforms in mind I'd suggest it might be
> better to just use PV devices and try to focus fuzzing on arch code and
> common code like mm rather than drivers.

I don't have any specific SoC in mind. I think we are interested in
covering something more commonly used rather than a driver used only
on 1 SoC.
Testing virt drivers is good, but since we have 3 arm64 instances, we
could make then use different boards to get more coverage.
What about things like pstore, numa, mtdblock, pflash? When I do man
qemu-system-aarch64 for some reason I see help for x86_64, so I am not
sure if these are applicable to arm64.


> > Any kernel subsystems with heavy arm-specific parts that we may be missing?
>
> It looks like your configs already have BPF, which is probably one of
> the more interesting subsystems with architecture-specific bits, so I
> don't have further suggestions on that front.
>
> > Testing some of the arm64 drivers that qemu can emulate may be the
> > most profitable thing.
> > Currently the instances use the following flags:
> > -machine virt,virtualization=on,graphics=on,usb=on -cpu cortex-a57
> > -machine virt,virtualization=on,mte=on,graphics=on,usb=on -cpu max
>
> With `-cpu max`, QEMU will use a relatively expensive SW implementation
> of pointer authentication (which I found significantly magnified the
> cost of implementation like kcov), so depending on your priorities you
> might want to disable that or (assuming you have a recent enough build
> of QEMU) you might wantto force the use of a cheaper algorithm by
> passing `-cpu max,pauth-impef`.
>
> The relevant QEMU commit is:
>
> eb94284d0812b4e7 ("arget/arm: Add cpu properties to control pauth")
>
> ... but it looks like that might not yet be in a tagged release yet.

Interesting. I need to note this somewhere.


> > mte=on + virtualization=on is broken in the kernel on in the qemu:
> > https://lore.kernel.org/lkml/CAAeHK+wDz8aSLyjq1b=q3+HG9aJXxwYR6+gN_fTttMN5osM5gg@mail.gmail.com/
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller/CACT4Y%2BbeyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g%40mail.gmail.com.
