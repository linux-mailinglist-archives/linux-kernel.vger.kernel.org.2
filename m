Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD6C318C82
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 14:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhBKNqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 08:46:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:34756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231576AbhBKNas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 08:30:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B9F564E92
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 13:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613050201;
        bh=o/e4beENXXmh54Z0rgt8bFChDG3kQJZkCnEDdk9Nbyc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BKe4ocPKZZMwcYaTbCft+TiqYENFPq63Np08o83RlWF61cSCkYeuhC3R7966+mAVq
         O/mpZbWBPOdHO3iA9rKmQ99hHnlxT5+uABA7HBcO2bImqeuhS1Z9s1Zd6py6Z0Sj/V
         7lCbW7pymnj8lhaIKPp7leHpN5u5wErEs5UJU8EJP/NmYPIa3kOOCfrWQPKkXZRZ9b
         T30VV2ShjBobinnZYoJLiZ5J7AJwlcrhKZgtgJdFysYnZBBtxERbHLdBLGUy0EzacZ
         wwXKcojlsBW2ecTtBoJflOFX55OoG5/mG19SCqg3ur9Mmfc7bebEHgqSV5pZ1az4F6
         joYhERUnwYSQw==
Received: by mail-oo1-f43.google.com with SMTP id s23so410699oot.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 05:30:01 -0800 (PST)
X-Gm-Message-State: AOAM533EqfcZcWUL9RwuSx9K8fQDkq2BCDNBrByb78jueTRBAkvvYSjq
        wrGeIO7sc0E53VcDIsowlX/wy8MyKY+ouqRGzcU=
X-Google-Smtp-Source: ABdhPJxGEKmmZxtRgu6QNpq4msxxp/++EU6KHmeAiG+8cRM2OvosVNtXhokYjCqaAN6Hk+oUrm/QIFWDDqf9Dp5N1ZY=
X-Received: by 2002:a4a:870c:: with SMTP id z12mr5339986ooh.15.1613050200233;
 Thu, 11 Feb 2021 05:30:00 -0800 (PST)
MIME-Version: 1.0
References: <1613012611-8489-1-git-send-email-min.li.xe@renesas.com>
In-Reply-To: <1613012611-8489-1-git-send-email-min.li.xe@renesas.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 11 Feb 2021 14:29:43 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3YhAGEfrvmi4YhhnG_3uWZuQi0ChS=0Cu9c4XCf5oGdw@mail.gmail.com>
Message-ID: <CAK8P3a3YhAGEfrvmi4YhhnG_3uWZuQi0ChS=0Cu9c4XCf5oGdw@mail.gmail.com>
Subject: Re: [PATCH net-next] misc: Add Renesas Synchronization Management
 Unit (SMU) support
To:     min.li.xe@renesas.com
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        gregkh <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 4:03 AM <min.li.xe@renesas.com> wrote:
>
> From: Min Li <min.li.xe@renesas.com>
>
> This driver supports 1588 related functions of ClockMatrix(TM)
> and 82P33xxx families of timing and synchronization devices. The
> supported functons are:
>
> - set combomode
> - get dpll's state
> - get dpll's ffo
>
> Please note that this driver needs to work with rsmu mfd driver
> to access SMU through I2C/SPI.
>
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
>  drivers/misc/Kconfig      |   7 +
>  drivers/misc/Makefile     |   3 +
>  drivers/misc/rsmu_cdev.c  | 430 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/misc/rsmu_cdev.h  |  75 ++++++++
>  drivers/misc/rsmu_cm.c    | 214 +++++++++++++++++++++++
>  drivers/misc/rsmu_sabre.c | 153 +++++++++++++++++
>  include/uapi/linux/rsmu.h |  61 +++++++
>  7 files changed, 943 insertions(+)
>  create mode 100644 drivers/misc/rsmu_cdev.c
>  create mode 100644 drivers/misc/rsmu_cdev.h
>  create mode 100644 drivers/misc/rsmu_cm.c
>  create mode 100644 drivers/misc/rsmu_sabre.c
>  create mode 100644 include/uapi/linux/rsmu.h
>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index fafa8b0..2ba5070 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -466,6 +466,13 @@ config HISI_HIKEY_USB
>           switching between the dual-role USB-C port and the USB-A host ports
>           using only one USB controller.
>
> +config RSMU
> +       tristate "Renesas Synchronization Management Unit (SMU)"
> +       depends on MFD_RSMU_I2C || MFD_RSMU_SPI
> +       help
> +         This driver provides support for Renesas SMU,
> +         such as Clockmatrix and 82P33XXX series.

There should probably be a description of the purpose of the
hardware both here and in the patch description.

In particular, please explain how it relates to the existing
clockmatrix driver.

> +
> +#define DRIVER_NAME    "rsmu"
> +#define DRIVER_MAX_DEV BIT(MINORBITS)
> +
> +static struct class *rsmu_class;
> +static dev_t rsmu_cdevt;

Maybe split the class support from the hardware specific parts
to let other drivers interface with the class when they provide
the same functionality through the common ioctl?

> +static u8 scsr_page;
> +
> +static int
> +rsmu_set_combomode(struct rsmu_cdev *rsmu, void __user *arg)
> +{
> +       struct rsmu_combomode mode;
> +       int err;
> +
> +       if (copy_from_user(&mode, arg, sizeof(mode)))
> +               return -EFAULT;
> +
> +       mutex_lock(rsmu->lock);
> +       switch (rsmu->type) {
> +       case RSMU_CM:
> +               err = rsmu_cm_set_combomode(rsmu, mode.dpll, mode.mode);
> +               break;
> +       case RSMU_SABRE:
> +               err = rsmu_sabre_set_combomode(rsmu, mode.dpll, mode.mode);
> +               break;
> +       default:
> +               err = -EINVAL;
> +       }

The multiplexer here already looks like this should be two drivers that
attach to the class and provide callbacks.

> +static ssize_t scsr_show_regs_show(struct device *dev,
> +                                  struct device_attribute *attr, char *page)

The user ABI needs to be documented.

> +       for (row = 0; row < rows; row++) {
> +               u8 index = row * 8;
> +
> +               cnt += snprintf(page + cnt, PAGE_SIZE - cnt - 1, fmt,
> +                               start + index, regs[index], regs[index + 1],
> +                               regs[index + 2], regs[index + 3],
> +                               regs[index + 4], regs[index + 5],
> +                               regs[index + 6], regs[index + 7]);
> +       }
> +static DEVICE_ATTR_RO(scsr_show_regs);

A pure list of register values seems neither particular portable
nor intuitive. How is a user expected to interpret these, and are
you sure that any driver for this class would have the same
interpretation at the same register index?

> +       /* Only one open per device at a time */
> +       if (!atomic_dec_and_test(&rsmu->open_count)) {
> +               atomic_inc(&rsmu->open_count);
> +               return -EBUSY;
> +       }

Can you explain the purpose of this restriction? Why is it
ok for two threads to access the same file descriptor, but not
two different file descriptors for the same device?

> +
> +static const struct file_operations rsmu_fops = {
> +       .owner = THIS_MODULE,
> +       .open = rsmu_open,
> +       .release = rsmu_release,
> +       .unlocked_ioctl = rsmu_ioctl,
> +};

There should be a .compat_ioctl entry here for 32-bit processes.
If the commands are all defined to be compatible, you can point
it to compat_ptr_ioctl

> +static const struct platform_device_id rsmu_id_table[] = {
> +       { "rsmu-cdev0", },
> +       { "rsmu-cdev1", },
> +       { "rsmu-cdev2", },
> +       { "rsmu-cdev3", },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(platform, rsmu_id_table);
> +
> +static const struct of_device_id rsmu_of_match[] = {
> +       { .compatible = "renesas,rsmu-cdev0", },
> +       { .compatible = "renesas,rsmu-cdev1", },
> +       { .compatible = "renesas,rsmu-cdev2", },
> +       { .compatible = "renesas,rsmu-cdev3", },
> +       { /* end of table */ }
> +};
> +MODULE_DEVICE_TABLE(of, rsmu_of_match);

Each of these needs a device tree binding. It's usually better to
name the compatible strings according to the chips that contain
this hardware, such as "renesas,r8a1234567-rsmucdev" instead
of "renesas,rsmu-cdev0".

Since you don't seem to about the difference between the devices,
the driver can also just bind to one of them (usually the oldest)
and then the newer devices contain the string as a fallback, so
you don't have to update the driver every time another variant
gets made.

> +static struct platform_driver rsmu_driver = {
> +       .driver = {
> +               .name = DRIVER_NAME,

I'd suggest open-coding the string here, to make it easier to grep for.

> +               .of_match_table = rsmu_of_match,
> +       },

> diff --git a/drivers/misc/rsmu_cdev.h b/drivers/misc/rsmu_cdev.h
> new file mode 100644
> index 0000000..4b38790a
> --- /dev/null
> +++ b/drivers/misc/rsmu_cdev.h
> @@ -0,0 +1,75 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * This driver is developed for the IDT ClockMatrix(TM) of
> + * timing and synchronization devices.
> + *
> + * Copyright (C) 2019 Integrated Device Technology, Inc., a Renesas Company.
> + */
> +#ifndef __LINUX_RSMU_CDEV_H
> +#define __LINUX_RSMU_CDEV_H
> +
> +#include <linux/cdev.h>
> +
> +/**
> + * struct rsmu_cdev - Driver data for RSMU character device
> + * @dev: pointer to platform device
> + * @mfd: pointer to MFD device
> + * @open_count: Count of char device being opened
> + * @rsmu_cdev: Character device handle
> + * @lock: Mutex to protect operations from being interrupted
> + */
> +struct rsmu_cdev {
> +       struct device *dev;
> +       struct device *mfd;
> +       struct cdev rsmu_cdev;
> +       struct mutex *lock;
> +       enum rsmu_type type;
> +       atomic_t open_count;
> +       u8 index;
> +};

This should probably be part of the .c file, as no other driver needs to
interface with it.

> +extern int
> +rsmu_cm_set_combomode(struct rsmu_cdev *rsmu, u8 dpll, u8 mode);
> +extern int
> +rsmu_cm_get_combomode(struct rsmu_cdev *rsmu, u8 dpll, u8 *mode);
> +extern int
> +rsmu_cm_get_dpll_state(struct rsmu_cdev *rsmu, u8 dpll, u8 *state);
> +extern int
> +rsmu_cm_get_dpll_ffo(struct rsmu_cdev *rsmu, u8 dpll, struct rsmu_get_ffo *ffo);
> +extern int
> +rsmu_sabre_set_combomode(struct rsmu_cdev *rsmu, u8 dpll, u8 mode);
> +extern int
> +rsmu_sabre_get_combomode(struct rsmu_cdev *rsmu, u8 dpll, u8 *mode);
> +extern int
> +rsmu_sabre_get_dpll_state(struct rsmu_cdev *rsmu, u8 dpll, u8 *state);
> +extern int
> +rsmu_sabre_get_dpll_ffo(struct rsmu_cdev *rsmu, u8 dpll,
> +                       struct rsmu_get_ffo *ffo);

This tells me that you got the abstraction the wrong way: the common files
should not need to know anything about the specific implementations.

Instead, these should be in separate modules that call exported functions
from the common code.


> +/* Get dpll ffo */
> +struct rsmu_get_ffo {
> +       __u8 dpll;
> +       __s64 ffo; /* in ppqt */
> +};

Please avoid padding in uapi data structures, see
Documentation/driver-api/ioctl.rst

> +/**
> + * @Description
> + * ioctl to set SMU combo mode.
> + *
> + * @Parameters
> + * pointer to struct rsmu_combomode that contains dpll combomode setting
> + */
> +#define RSMU_SET_COMBOMODE  _IOW(RSMU_MAGIC, 1, struct rsmu_combomode *)

This does not match the code, which expects the argument to point directly
to the data, rather than an indirect pointer. By fixing the command definition,
it also becomes compatible with 32-bit processes:

#define RSMU_SET_COMBOMODE  _IOW(RSMU_MAGIC, 1, struct rsmu_combomode)

Maybe expand the documentation for each command a little to explain what
the fields exactly refer to. This also ensures that you are not making it
too specific to a particular hardware implementation.

        Arnd
