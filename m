Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9630D3E0FF9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 10:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239224AbhHEIML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 04:12:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239215AbhHEIMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 04:12:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27DD660F43;
        Thu,  5 Aug 2021 08:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628151116;
        bh=uIB0BoCskDsD79gCcHLXIEBoVLc8Ir8gHuaC7+0TPCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d6FpcrEvaNhM8kh1TLFRKFD1w1wOfxi5tpxHRPJqPupdxXp3r2Y7E5u1IowJKB88s
         Dz3MNQtN1dYUJMibBpBnbBxN9if4vXEaaI5i6LreNgizNaO1imwnxxA89nmQ1SKX26
         S4EFVKmLe6bIGD7yvqiB0VU1qJgHrmTnHsJbgiVijr2HCYGRshSGIGSgtQFHWYFl8j
         wQXzQCFmTb0N3b2yMHNUkgYIZN6oVbAPOy9alTPKRnopdjw01IQEbFjsdI6ZMnKBnj
         oHnfmbxwsjv7XvnTx8yHrz2/11hGkXlDiZyYR3BEEyPuys4yE37W+EZmQLRF0/GdtR
         V5G38PMEIJ8Zg==
Received: by pali.im (Postfix)
        id A2C80817; Thu,  5 Aug 2021 10:11:53 +0200 (CEST)
Date:   Thu, 5 Aug 2021 10:11:53 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>
Subject: Re: [RFT, PATCH v1 1/1] platform/x86: dell-smo8800: Convert to be a
 platform driver
Message-ID: <20210805081153.5exc6iih2yu5a3ph@pali>
References: <20210803194039.35083-1-andriy.shevchenko@linux.intel.com>
 <20210804200025.iqsvknddoxix7yw7@pali>
 <CAHp75Vc1r+9N6_BiJzO3JYppgaokKiQwk4sLrp72kPEDgYEweg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vc1r+9N6_BiJzO3JYppgaokKiQwk4sLrp72kPEDgYEweg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 August 2021 10:20:40 Andy Shevchenko wrote:
> On Wednesday, August 4, 2021, Pali Rohár <pali@kernel.org> wrote:
> 
> > On Tuesday 03 August 2021 22:40:39 Andy Shevchenko wrote:
> > > ACPI core in conjunction with platform driver core provides
> > > an infrastructure to enumerate ACPI devices. Use it in order
> > > to remove a lot of boilerplate code.
> >
> > Are there any other dependences for this patch?
> 
> 
> >
> Assuming that you are asking because something is not working, what are the
> symptoms?
> 

Because I thought that it is something new, but I have not found
anything special about it in last kernel versions...

> > And in which kernel
> > version is (or will be) introduced this ACPI infrastructure?
> 
> 
> I don’t remember, I think it is in v3 era or even v2.6.x.

... and this answers why.

I will try to find some time to test this change on a real hw.

> 
> 
> >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  drivers/platform/x86/dell/Kconfig        |  2 +-
> > >  drivers/platform/x86/dell/dell-smo8800.c | 74 ++++++------------------
> > >  2 files changed, 20 insertions(+), 56 deletions(-)
> > >
> > > diff --git a/drivers/platform/x86/dell/Kconfig
> > b/drivers/platform/x86/dell/Kconfig
> > > index 9e7314d90bea..821aba31821c 100644
> > > --- a/drivers/platform/x86/dell/Kconfig
> > > +++ b/drivers/platform/x86/dell/Kconfig
> > > @@ -140,7 +140,7 @@ config DELL_SMBIOS_SMM
> > >  config DELL_SMO8800
> > >       tristate "Dell Latitude freefall driver (ACPI SMO88XX)"
> > >       default m
> > > -     depends on ACPI
> > > +     depends on ACPI || COMPILE_TEST
> > >       help
> > >         Say Y here if you want to support SMO88XX freefall devices
> > >         on Dell Latitude laptops.
> > > diff --git a/drivers/platform/x86/dell/dell-smo8800.c
> > b/drivers/platform/x86/dell/dell-smo8800.c
> > > index 5d9304a7de1b..3385e852104c 100644
> > > --- a/drivers/platform/x86/dell/dell-smo8800.c
> > > +++ b/drivers/platform/x86/dell/dell-smo8800.c
> > > @@ -10,13 +10,14 @@
> > >
> > >  #define DRIVER_NAME "smo8800"
> > >
> > > -#include <linux/kernel.h>
> > > -#include <linux/module.h>
> > > -#include <linux/acpi.h>
> > > +#include <linux/fs.h>
> > >  #include <linux/interrupt.h>
> > > +#include <linux/kernel.h>
> > >  #include <linux/miscdevice.h>
> > > +#include <linux/mod_devicetable.h>
> > > +#include <linux/module.h>
> > > +#include <linux/platform_device.h>
> > >  #include <linux/uaccess.h>
> > > -#include <linux/fs.h>
> > >
> > >  struct smo8800_device {
> > >       u32 irq;                     /* acpi device irq */
> > > @@ -44,37 +45,6 @@ static irqreturn_t smo8800_interrupt_thread(int irq,
> > void *data)
> > >       return IRQ_HANDLED;
> > >  }
> > >
> > > -static acpi_status smo8800_get_resource(struct acpi_resource *resource,
> > > -                                     void *context)
> > > -{
> > > -     struct acpi_resource_extended_irq *irq;
> > > -
> > > -     if (resource->type != ACPI_RESOURCE_TYPE_EXTENDED_IRQ)
> > > -             return AE_OK;
> > > -
> > > -     irq = &resource->data.extended_irq;
> > > -     if (!irq || !irq->interrupt_count)
> > > -             return AE_OK;
> > > -
> > > -     *((u32 *)context) = irq->interrupts[0];
> > > -     return AE_CTRL_TERMINATE;
> > > -}
> > > -
> > > -static u32 smo8800_get_irq(struct acpi_device *device)
> > > -{
> > > -     u32 irq = 0;
> > > -     acpi_status status;
> > > -
> > > -     status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
> > > -                                  smo8800_get_resource, &irq);
> > > -     if (ACPI_FAILURE(status)) {
> > > -             dev_err(&device->dev, "acpi_walk_resources failed\n");
> > > -             return 0;
> > > -     }
> > > -
> > > -     return irq;
> > > -}
> > > -
> > >  static ssize_t smo8800_misc_read(struct file *file, char __user *buf,
> > >                                size_t count, loff_t *pos)
> > >  {
> > > @@ -136,7 +106,7 @@ static const struct file_operations
> > smo8800_misc_fops = {
> > >       .release = smo8800_misc_release,
> > >  };
> > >
> > > -static int smo8800_add(struct acpi_device *device)
> > > +static int smo8800_probe(struct platform_device *device)
> > >  {
> > >       int err;
> > >       struct smo8800_device *smo8800;
> > > @@ -160,14 +130,12 @@ static int smo8800_add(struct acpi_device *device)
> > >               return err;
> > >       }
> > >
> > > -     device->driver_data = smo8800;
> > > +     platform_set_drvdata(device, smo8800);
> > >
> > > -     smo8800->irq = smo8800_get_irq(device);
> > > -     if (!smo8800->irq) {
> > > -             dev_err(&device->dev, "failed to obtain IRQ\n");
> > > -             err = -EINVAL;
> > > +     err = platform_get_irq(device, 0);
> > > +     if (err < 0)
> > >               goto error;
> > > -     }
> > > +     smo8800->irq = err;
> > >
> > >       err = request_threaded_irq(smo8800->irq, smo8800_interrupt_quick,
> > >                                  smo8800_interrupt_thread,
> > > @@ -189,9 +157,9 @@ static int smo8800_add(struct acpi_device *device)
> > >       return err;
> > >  }
> > >
> > > -static int smo8800_remove(struct acpi_device *device)
> > > +static int smo8800_remove(struct platform_device *device)
> > >  {
> > > -     struct smo8800_device *smo8800 = device->driver_data;
> > > +     struct smo8800_device *smo8800 = platform_get_drvdata(device);
> > >
> > >       free_irq(smo8800->irq, smo8800);
> > >       misc_deregister(&smo8800->miscdev);
> > > @@ -211,21 +179,17 @@ static const struct acpi_device_id smo8800_ids[] =
> > {
> > >       { "SMO8831", 0 },
> > >       { "", 0 },
> > >  };
> > > -
> > >  MODULE_DEVICE_TABLE(acpi, smo8800_ids);
> > >
> > > -static struct acpi_driver smo8800_driver = {
> > > -     .name = DRIVER_NAME,
> > > -     .class = "Latitude",
> > > -     .ids = smo8800_ids,
> > > -     .ops = {
> > > -             .add = smo8800_add,
> > > -             .remove = smo8800_remove,
> > > +static struct platform_driver smo8800_driver = {
> > > +     .probe = smo8800_probe,
> > > +     .remove = smo8800_remove,
> > > +     .driver = {
> > > +             .name = DRIVER_NAME,
> > > +             .acpi_match_table = smo8800_ids,
> > >       },
> > > -     .owner = THIS_MODULE,
> > >  };
> > > -
> > > -module_acpi_driver(smo8800_driver);
> > > +module_platform_driver(smo8800_driver);
> > >
> > >  MODULE_DESCRIPTION("Dell Latitude freefall driver (ACPI SMO88XX)");
> > >  MODULE_LICENSE("GPL");
> > > --
> > > 2.30.2
> > >
> >
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
