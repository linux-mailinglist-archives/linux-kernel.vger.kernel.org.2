Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F99244AF3B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 15:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbhKIOOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 09:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbhKIOOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 09:14:08 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7FFC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 06:11:22 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id t13so23405299uad.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 06:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EiRg6SIKq+YSu+jqYEaVc5JU0YFVIn9471h/hRlV1yU=;
        b=bor2aXVIBX/OGmsk7AoqRsGJK32IA1kxpXpTOuzR3NxZb6GLy74Zf40GYoBaqyAnHT
         /fEF49psAyibJCSW/Gb/rjfpHYrLSnpc3PsNnpEOOeqTjh3wPrgayGOI8QiU14WrwMFY
         eWiPeJerHrnBjUKm1nEH5GNhq01TYgUZ6fBMpyFH+BA+bRCpNE4slXxz5H+2zyw8/qHU
         PrZTAzB+N+Va1qcKUmV6lQsgvs1ZbWMxMQ6gyKrnJGAagiYJnz7An2EG23fZWyMwt8px
         U732AQkD0SdCZYsg9VuoabqUnKCcYxx4nlIfKZaq+1CN2uSXxkpbx0kpzc6l4b0Hw9i6
         sjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EiRg6SIKq+YSu+jqYEaVc5JU0YFVIn9471h/hRlV1yU=;
        b=irOFVzATPBZo0WrX15LaCBAEsNXx81PWN9gHuX/LJZ/F+lqDSwzHlqILrhZeJVRyqP
         Ov8uSVCHgspFGXdFRpKHLOGda0Bht4BUPZRzFQrxQZMHoX/zEQtkDZrSmuijhdZNiJTm
         0vsEeJ8x6Ppv4cco4SAO46QAP10MkGKFYudhgAHiVXlDeG29mJeqf6wrEVqBewXIQliU
         3nf49jpqcaoJQSa/J21YDadsBVVoO2zCzMc6xlXtRkj1hz4Y/jDSStdbVRoO0gESyMRf
         eBj6zlaUrjybw2U4y9EEV/PpB/lduM7Y+xNAQ+O+kR8PZj/Mb+GFLeHFRvKc4+YfveNy
         XAGg==
X-Gm-Message-State: AOAM5326m3jAeHnMgooNw/UQzZlNTMtYzL7G/1Csfhz5vrP86Dh1Bldt
        MY295P3F8oGlRw0/d6PGoWEg81D+dxNLdDcsjZbfAg==
X-Google-Smtp-Source: ABdhPJyQxHyf98iGLz7aLd3VCbK5cgEezzd/QQdMobI+cMYhm/JxxfVBYta0i8r8M56Ji5JsBJSNojMxftRJroHGRCA=
X-Received: by 2002:a67:fa0f:: with SMTP id i15mr22766004vsq.16.1636467081510;
 Tue, 09 Nov 2021 06:11:21 -0800 (PST)
MIME-Version: 1.0
References: <20211109000130.42361-1-hans-gert.dahmen@immu.ne>
 <YYoSPjF3M05dR0PX@kroah.com> <42cea157-55a2-bd12-335b-6348f0ff6525@immu.ne>
 <YYpNOMtp7Kwf0fho@kroah.com> <CAHifhD4f676jiQ52siiKQTjUFXFm6Sto8pQjF07w5y+gqrUvFQ@mail.gmail.com>
 <YYpsq/umygfTb8mM@kroah.com> <CAArk9MNtj9Q3kREOM_fhgUWSMhP15dGd3Mzg30pgG+RkKL-DQg@mail.gmail.com>
In-Reply-To: <CAArk9MNtj9Q3kREOM_fhgUWSMhP15dGd3Mzg30pgG+RkKL-DQg@mail.gmail.com>
From:   Mauro Lima <mauro.lima@eclypsium.com>
Date:   Tue, 9 Nov 2021 11:11:10 -0300
Message-ID: <CAArk9MPga5UtJTuL4YFELa+S0icy==hiuSG+mOMLPUbg-Pw5kA@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Philipp Deppenwiese <philipp.deppenwiese@immu.ne>,
        Richard Hughes <hughsient@gmail.com>,
        platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 11:09 AM Mauro Lima <mauro.lima@eclypsium.com> wrote:
>
> On Tue, Nov 9, 2021 at 9:42 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Nov 09, 2021 at 01:32:48PM +0100, Hans-Gert Dahmen wrote:
> > > On Tue, 9 Nov 2021, 11:28 Greg KH, <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Nov 09, 2021 at 09:52:53AM +0100, Hans-Gert Dahmen wrote:
> > > > > On 09.11.21 07:16, Greg KH wrote:
> > > > > > On Tue, Nov 09, 2021 at 01:01:30AM +0100, Hans-Gert Dahmen wrote:
> > > > > > > Make the 16MiB long memory-mapped BIOS region of the platform SPI flash
> > > > > > > on X86_64 system available via /sys/kernel/firmware/flash_mmap/bios_region
> > > > > > > for pen-testing, security analysis and malware detection on kernels
> > > > > > > which restrict module loading and/or access to /dev/mem.
> > > > > >
> > > > > > That feels like a big security hole we would be opening up for no good
> > > > > > reason.
> > > > > >
> > > > > > > It will be used by the open source Converged Security Suite.
> > > > > > > https://github.com/9elements/converged-security-suite
> > > > > >
> > > > > > What is the reason for this, and what use is this new interface?
> > > > > Because it is very hard to access the SPI flash to read the BIOS contents
> > > > > for (security) analysis and this works without the more complex and
> > > > > unfinished SPI drivers and it does so on a system where we may not access
> > > > > the full /dev/mem.
> > > >
> > > > Why not fix the spi drivers to do this properly?  What is preventing you
> > > > from doing that instead of adding a new user/kernel api that you will
> > > > have to support for the next 20+ years?
> > > >
> > >
> > > Because this interface we want to use is inherently tied to the
> > > workings of x86_64 CPUs. It is very stable and easy to use. The SPI
> > > drivers in contrast have a history of being complex, buggy and in
> > > general not reliable.
> >
> > Do you have a pointer to these complex and buggy drivers anywhere?
>
> Right now the intel spi driver has a _(DANGEROUS)_ tag [1], this is
> preventing the kernel engineers from compiling the driver into
> different distros.
> A couple of months ago I tried to modify the driver and make it RO [2]
>  but the drivers author told me that they don't want to remove the
> tag, even if the driver is compiled without any write/erase
> functionality as I proposed.
> The driver is fixed as the author claims but, as I said, they want to
> preserve the tag.
> This patch is close to what we need if we can't use the intel spi mechanism.
>
> >
> > > This module will require very little maintenance
> > > and will probably work in the future without needing modification for
> > > newer platforms. It generally is meant as a fallback to the real SPI
> > > flash drivers so that userspace programs are able to provide essential
> > > functionality.
> >
> > If it is a "fallback", how is it going to interact on a system where the
> > SPI driver is loaded?
> >
> > > > > > > +static int __init flash_mmap_init(void)
> > > > > > > +{
> > > > > > > + int ret;
> > > > > > > +
> > > > > > > + pdev = platform_device_register_simple("flash_mmap", -1, NULL, 0);
> > > > > > > + if (IS_ERR(pdev))
> > > > > > > +         return PTR_ERR(pdev);
> > > > > > > +
> > > > > > > + ret = sysfs_create_group(&pdev->dev.kobj, &flash_mmap_group);
> > > > > >
> > > > > > You just raced with userspace and lost  >
> > > > > > Please set the attribute to the platform driver before you create the
> > > > > > device.
> > > > > >
> > > > >
> > > > > Sorry, but I went through tons of code and could not find a single instance
> > > > > where I can use a default group for creation without using a probe function
> > > > > that does the magic for me. Please help me find the correct way of doing
> > > > > this without manually creating and adding kobjects.
> > > >
> > > > The problem here is that you are abusing the platform driver code and
> > > > making a "fake" device that is not attached to anything real, and
> > > > without a driver.  That should not be done, as you do not know what
> > > > hardware this driver is going to be run on.
> > > >
> > > > Bind to the real hardware resource please.
> > >
> > > In a previous mail in June you suggested this is some sort of platform
> > > device, that is why I rewrote it as such.
> >
> > That's fine, but bind to the real platform device that describes this
> > hardware!  You are not doing anything like this at all here, you are
> > just creating a random device in the sysfs tree and instantly allowing
> > userspace access to raw memory.  You are not actually controlling the
> > platform device at all.
> >
> > > The hardware resource here
> > > is the south bridge for x86_64 CPUs and the module dependencies will
> > > compile it only for these platforms.
> >
> > What "module dependencies"?  You do realize that distro kernels enable
> > all modules to be built. We have an "autoload only the modules that this
> > hardware needs" infrastructure that you need to tie into here, you are
> > totally ignoring it (despite it being present for almost 20 years
> > now...)
> >
> > > The situation is like, if you
> > > have that CPU, you have the hardware, so it is implicitly bound or it
> > > just will not execute on a machine code level.
> >
> > What do you mean "implicitly bound"?  How does this tie into the driver
> > model such that it will only be autoloaded, and have the driver bind to
> > the hardware, that it knows it can control?
> >
> > That is what needs to be fixed here, you are just claiming that it can
> > talk to the hardware without having any check at all for this.
> >
> > > I feel like your
> > > requirement is somewhat impossible to satisfy and I really don't know
> > > what to do. Please, can anyone help me by pointing out a proper
> > > example elsewhere in the kernel?
> >
> > What resource in the system describes the hardware you wish to bind to?
> > Write a driver for _that_ resource, and have it be properly autoloaded
> > when that resource is present in the system.
> >
> > You have hundreds of examples running on your system today, but as I do
> > not know where this hardware is described specifically, it's hard to be
> > able to point you to an example that works like that.
> >
> > So again, what hardware signature describes the resource you wish to
> > bind to?
> >
> > thanks,
> >
> > greg k-h
>
> Thanks, Mauro.

Sorry, I forgot the links

[1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1734147/+index?comments=all
[2] https://lore.kernel.org/linux-mtd/20210910211348.642103-1-mauro.lima@eclypsium.com/

Thanks
