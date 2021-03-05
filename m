Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274D032E6EA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 11:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhCEK7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 05:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhCEK6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 05:58:30 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A384C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 02:58:30 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id l12so1987044edt.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 02:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OOEIFSTrwX0V6Vun3jdALndaWZrqExp3UM68CwiNleQ=;
        b=LZ3jr38YG9hP82AVjoOd4lA0dQq8BnLwQfrxaMT/JixWq097VLc6ioW7SVMwReHdji
         FzzCs36qtJEHf8stgdH5UheYfMwHiZ065aS3RaN5EBJg6Mh8MY6dNoBjJFMZO+CnjYHP
         h4XgysXGLdkdj8Sr+ToIpE5LLrnv8pEYpIRU8FSofUl6d7QfsRRWyqWsUnlv0YgG0uMz
         KnY0XUm7lD5FQGAt72cBTdOEJMMr7ZRlz2MqcbO3f8AkLuoN5J48YhgCpNBdFgC3VdNp
         qBKsWeClssOuB20pVqCLp92mxbvvOwRLOKe6qFA2bk/pmwkF/J+IUl7OE12l8xNVCYYV
         X8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OOEIFSTrwX0V6Vun3jdALndaWZrqExp3UM68CwiNleQ=;
        b=IKcefm4dQSeWJ+nnmki2HuDqK2QJmAchhU1AsZR5C+E0RO2k+K0rdfdiXLakkYQ8Xe
         hXGmZVECoS7FzMCuI1uqMtzU/vskoajNZELXzbW4fjEaaf3z1ITROKQvv+itZ/xJnNa8
         6+ju6XMA6YbVQXuU6az6uvRb71TuLFazEu4Ns+AtNqr5k7FFH03F8KTBpSM0OW85nrMh
         k1Zd5h63iJDWd9mwST+RC6XI9Ik0Oxx3XiRDk+3Q+80w2em96g6dUvrsiYgO40weq6O5
         TvSwe5Denf4FrDCIJOgUKAIBwVW805QpMDR2HQ4UAqK6F8hES89fui2WJF7xgjpaUwkR
         wPxg==
X-Gm-Message-State: AOAM5322TMp+rZbr2qzjmpCrzB9BfJc+rkxktUnRES9xPBWhxAWX7LOl
        EKLqFQTXADkdeneBME2sP80FQ9nwXQ+GUK0ELNFD3g==
X-Google-Smtp-Source: ABdhPJwvyQ8n5pWcFzlsm1MGavzkF8SlsLQv23r8wI7E4WGBUlPuvf+Cf6GxyLc7pmVMD3cz7dq2Zsm6D7xpGTNZh2E=
X-Received: by 2002:a05:6402:17d6:: with SMTP id s22mr8552890edy.232.1614941908962;
 Fri, 05 Mar 2021 02:58:28 -0800 (PST)
MIME-Version: 1.0
References: <20210304102452.21726-1-brgl@bgdev.pl> <20210304102452.21726-9-brgl@bgdev.pl>
 <CAMuHMdXRK5=w1-Z=EbM60Sf2bLY1EiVaxbZjMP+XyQ3g7nBpZw@mail.gmail.com>
 <YEHs3CxWnusWklME@kroah.com> <CAMRc=MddDb+nakgEM+Xeqm=rMMkkWO2EDekD36EoPJashYP88w@mail.gmail.com>
 <YEHyDUQ3V7Pl6+TU@kroah.com> <CAMRc=Md7FeQAd4Syh685+jyZAq2QStBNoo0ACQxrSB=4N6d3dg@mail.gmail.com>
 <YEIG0u8Vg3e6ZBhz@kroah.com>
In-Reply-To: <YEIG0u8Vg3e6ZBhz@kroah.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 5 Mar 2021 11:58:18 +0100
Message-ID: <CAMRc=Meznt=5m_4OnSRf04xHsUy39hH7S7_8ftZaHq6GD-taEw@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] drivers: export device_is_bound()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>, Shuah Khan <shuah@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Kent Gibson <warthog618@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 11:24 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Mar 05, 2021 at 10:16:10AM +0100, Bartosz Golaszewski wrote:
> > On Fri, Mar 5, 2021 at 9:55 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Fri, Mar 05, 2021 at 09:45:41AM +0100, Bartosz Golaszewski wrote:
> > > > On Fri, Mar 5, 2021 at 9:34 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Fri, Mar 05, 2021 at 09:18:30AM +0100, Geert Uytterhoeven wrote:
> > > > > > CC Greg
> > > > > >
> > > > > > On Thu, Mar 4, 2021 at 11:30 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > > > > >
> > > > > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > > > >
> > > > > > > Export the symbol for device_is_bound() so that we can use it in gpio-sim
> > > > > > > to check if the simulated GPIO chip is bound before fetching its driver
> > > > > > > data from configfs callbacks in order to retrieve the name of the GPIO
> > > > > > > chip device.
> > > > > > >
> > > > > > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > > > > ---
> > > > > > >  drivers/base/dd.c | 1 +
> > > > > > >  1 file changed, 1 insertion(+)
> > > > > > >
> > > > > > > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > > > > > > index 9179825ff646..c62c02e3490a 100644
> > > > > > > --- a/drivers/base/dd.c
> > > > > > > +++ b/drivers/base/dd.c
> > > > > > > @@ -353,6 +353,7 @@ bool device_is_bound(struct device *dev)
> > > > > > >  {
> > > > > > >         return dev->p && klist_node_attached(&dev->p->knode_driver);
> > > > > > >  }
> > > > > > > +EXPORT_SYMBOL_GPL(device_is_bound);
> > > > >
> > > > > No.  Please no.  Why is this needed?  Feels like someone is doing
> > > > > something really wrong...
> > > > >
> > > > > NACK.
> > > > >
> > > >
> > > > I should have Cc'ed you the entire series, my bad.
> > > >
> > > > This is the patch that uses this change - it's a new, improved testing
> > > > module for GPIO using configfs & sysfs as you (I think) suggested a
> > > > while ago:
> > > >
> > > > https://lkml.org/lkml/2021/3/4/355
> > > >
> > > > The story goes like this: committing the configfs item registers a
> > > > platform device.
> > >
> > > Ick, no, stop there, that's not a "real" device, please do not abuse
> > > platform devices like that, you all know I hate this :(
> > >
> > > Use the virtbus code instead perhaps?
> > >
> >
> > I have no idea what virtbus is and grepping for it only returns three
> > hits in: ./drivers/pci/iov.c and it's a function argument.
> >
> > If it stands for virtual bus then for sure it sounds like the right
> > thing but I need to find more info on this.
>
> Sorry, wrong name, see Documentation/driver-api/auxiliary_bus.rst for
> the details.  "virtbus" was what I think about it as that was my
> original name for it, but it eventually got merged with a different
> name.
>
> > > > As far as I understand - there's no guarantee that
> > > > the device will be bound to a driver before the commit callback (or
> > > > more specifically platform_device_register_full() in this case)
> > > > returns so the user may try to retrieve the name of the device
> > > > immediately (normally user-space should wait for the associated uevent
> > > > but nobody can force that) by doing:
> > > >
> > > > mv /sys/kernel/config/gpio-sim/pending/foo /sys/kernel/config/gpio-sim/live/
> > > > cat /sys/kernel/config/gpio-sim/live/foo/dev_name
> > > >
> > > > If the device is not bound at this point, we'll have a crash in the
> > > > kernel as opposed to just returning -ENODEV.
> > >
> > > How will the kernel crash?  What has created the dev_name sysfs file
> > > before it is possible to be read from?  That feels like the root
> > > problem.
> > >
> >
> > It's not sysfs - it's in configfs. Each chip has a read-only configfs
> > attribute that returns the name of the device - I don't really have a
> > better idea to map the configfs items to devices that committing
> > creates.
>
> Same question, why are you exporting a configfs attribute that can not
> be read from?  Only export it when your driver is bound to the device.
>

The device doesn't know anything about configfs. Why would it? The
configuration of a GPIO chip can't be changed after it's instantiated,
this is why we have committable items.

We export a directory in configfs: gpio-sim -> user creates a new
directory (item) in gpio-sim/pending/foo and it's not tied to any
device yet but exports attributes which we use to configure the device
(label, number of lines, line names etc.), then we mv
gpio-sim/pending/foo gpio-sim/live and this is when the device gets
created and registered with the subsystem. We take all the configured
attributes and put them into device properties for both the driver and
gpiolib core (for standard properties) to read - just like we would
with a regular GPIO driver because this is the goal: test the core
code.

Configfs doesn't even allow to dynamically export and unexport attributes.

Bart
