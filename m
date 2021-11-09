Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EF044AD9F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 13:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242202AbhKIMfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 07:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbhKIMfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 07:35:41 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2539CC061766
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 04:32:55 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id i5so32750091wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 04:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=immu-ne.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6vZ6aUIeCJbBlIO0Lv+WQYFDNRnVtb+GSHZa0RcE2rc=;
        b=zjefnNTa5dG2lLyDyFwcYr3GkGFdRiMW0BfUjt11dHS7twn/Wx415BTEVSo+UwPmc3
         RN0qNqol2NwaZG3z4qUFCf1L+MjGfPc8B1g6HqAgGHReiyj4nQRf4VEk71Zh7keJgcML
         4JitDL82G2/YrG2OQThFdBv9TDmcUQL6KHLjy4E7fNVv9WPjDRDmc6fVQ0O18jau0P8d
         zGB+NKmzP65RSpSB6dKXEHYDzNm02RKiLbMGIoaOZw9z7lkhR5+v4FhcMFbB20iMBayp
         o5cdVdLyh28b7gsRtDoHuVB0JzR2jSOeY946ws55eUYej9prMz3GG0QpEeC8obCx5Dkk
         aF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6vZ6aUIeCJbBlIO0Lv+WQYFDNRnVtb+GSHZa0RcE2rc=;
        b=bdLIgJBazMZyARdxIOJLwpF9Qx42Iw1o155kSggfWUsPzAu25hoqS7OWKvv0o8bJ/+
         sDNuM3z8U1b2btFVw76eAdhgFZNbgAgwogWL+YUNTW/bw+B6LmGr6XRc+2mXqNKJcX83
         L1udkmYt0DPlbLlMS2cX0bCUtZMvEyOkLh9z/btPnlYT8WHKYAgJzIOmmQhxzJE/FrLy
         xneqJT6mYxwBwQd7bpO3wRUOYdohQfHkT0T6WTSLREfWoVBYXv5x3PZWrs4qI5m5L4eS
         mhBLRhZIEsJ6F9I2sZI7VhvXb2k+uaWHV7BMQ3kWCh6ThOQl1AySuBRyIBPZ6zmP6S/M
         uhhQ==
X-Gm-Message-State: AOAM533jfAjCNhv5YnYYW0N/BA0OTMo6uVFoMuBgBAUlnqOGWUbbO1yT
        Fb03T8tJO0RL7McNQPftwIbcfmmX8DRH86JYYWDE2g==
X-Google-Smtp-Source: ABdhPJxBVGq3/twpZtrzbiJORWrfHffp4rl1UwLaiG27C8lDBzeYC7fhbtt4/m1JVkrSQn260BYhdO/Q3ZlAgtSOg5Q=
X-Received: by 2002:a5d:6c6b:: with SMTP id r11mr8800449wrz.231.1636461173687;
 Tue, 09 Nov 2021 04:32:53 -0800 (PST)
MIME-Version: 1.0
References: <20211109000130.42361-1-hans-gert.dahmen@immu.ne>
 <YYoSPjF3M05dR0PX@kroah.com> <42cea157-55a2-bd12-335b-6348f0ff6525@immu.ne> <YYpNOMtp7Kwf0fho@kroah.com>
In-Reply-To: <YYpNOMtp7Kwf0fho@kroah.com>
From:   Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Date:   Tue, 9 Nov 2021 13:32:48 +0100
Message-ID: <CAHifhD4f676jiQ52siiKQTjUFXFm6Sto8pQjF07w5y+gqrUvFQ@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Philipp Deppenwiese <philipp.deppenwiese@immu.ne>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>,
        platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Nov 2021, 11:28 Greg KH, <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Nov 09, 2021 at 09:52:53AM +0100, Hans-Gert Dahmen wrote:
> > On 09.11.21 07:16, Greg KH wrote:
> > > On Tue, Nov 09, 2021 at 01:01:30AM +0100, Hans-Gert Dahmen wrote:
> > > > Make the 16MiB long memory-mapped BIOS region of the platform SPI flash
> > > > on X86_64 system available via /sys/kernel/firmware/flash_mmap/bios_region
> > > > for pen-testing, security analysis and malware detection on kernels
> > > > which restrict module loading and/or access to /dev/mem.
> > >
> > > That feels like a big security hole we would be opening up for no good
> > > reason.
> > >
> > > > It will be used by the open source Converged Security Suite.
> > > > https://github.com/9elements/converged-security-suite
> > >
> > > What is the reason for this, and what use is this new interface?
> > Because it is very hard to access the SPI flash to read the BIOS contents
> > for (security) analysis and this works without the more complex and
> > unfinished SPI drivers and it does so on a system where we may not access
> > the full /dev/mem.
>
> Why not fix the spi drivers to do this properly?  What is preventing you
> from doing that instead of adding a new user/kernel api that you will
> have to support for the next 20+ years?
>

Because this interface we want to use is inherently tied to the
workings of x86_64 CPUs. It is very stable and easy to use. The SPI
drivers in contrast have a history of being complex, buggy and in
general not reliable. This module will require very little maintenance
and will probably work in the future without needing modification for
newer platforms. It generally is meant as a fallback to the real SPI
flash drivers so that userspace programs are able to provide essential
functionality.

> > > > +static int __init flash_mmap_init(void)
> > > > +{
> > > > + int ret;
> > > > +
> > > > + pdev = platform_device_register_simple("flash_mmap", -1, NULL, 0);
> > > > + if (IS_ERR(pdev))
> > > > +         return PTR_ERR(pdev);
> > > > +
> > > > + ret = sysfs_create_group(&pdev->dev.kobj, &flash_mmap_group);
> > >
> > > You just raced with userspace and lost  >
> > > Please set the attribute to the platform driver before you create the
> > > device.
> > >
> >
> > Sorry, but I went through tons of code and could not find a single instance
> > where I can use a default group for creation without using a probe function
> > that does the magic for me. Please help me find the correct way of doing
> > this without manually creating and adding kobjects.
>
> The problem here is that you are abusing the platform driver code and
> making a "fake" device that is not attached to anything real, and
> without a driver.  That should not be done, as you do not know what
> hardware this driver is going to be run on.
>
> Bind to the real hardware resource please.

In a previous mail in June you suggested this is some sort of platform
device, that is why I rewrote it as such. The hardware resource here
is the south bridge for x86_64 CPUs and the module dependencies will
compile it only for these platforms. The situation is like, if you
have that CPU, you have the hardware, so it is implicitly bound or it
just will not execute on a machine code level. I feel like your
requirement is somewhat impossible to satisfy and I really don't know
what to do. Please, can anyone help me by pointing out a proper
example elsewhere in the kernel?

Hans-Gert
