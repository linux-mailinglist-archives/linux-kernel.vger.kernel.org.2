Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1648A44AF16
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 14:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbhKIN6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 08:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbhKIN6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 08:58:52 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1556C061766
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 05:56:06 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id e64so10081605vke.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 05:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N2NSdGItuH/fcx4ggcFuCYc3KaY8OKz0UKwkgWXZOwg=;
        b=CVLY+KS35il+CjF+6bh+XNIL4HsoiDrsb5cYUFBDNbGgN3srhceuD11mFJ0GOVw7WK
         xczIUU+nX/sm9RR8HM2Pwa8d0dY8J6rOCI/Fqp4LKM/8y3VIyGJIVAXiFu0qVxlvyDJq
         XulF4w1UmoUBB+U1Tiz4e/NJPsWbke42UNV1y3LO9fae3gW8MM7jOj26YgiIZuykxY6s
         pCCDr+ItawGyUUBSZSvU3jYI0GQswI59BFvi4n3teHDrJpOAvcxtgpgzr5N6ZK7dHUVB
         bmJevEiZrqC2UxGkzBnwdetr+JNRGNvGCW8ztV8p5jLfeEd0rk62bDsEUI0I+iIAF8dn
         /vuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N2NSdGItuH/fcx4ggcFuCYc3KaY8OKz0UKwkgWXZOwg=;
        b=Cgk9U3ycjXMGezqCXecSTdBoW1ZogdFGgehKH8XQLUzdM6xZmXd7A0ob7e1JrLyCTq
         FX+UGTg0NnVURnFDtY/h+pM/zoLQsgtAIKAlLKLB83fkkWBDjDPMpJZ4EFFjn4FUwHwc
         vpnT4RV5aZHxYlYTd//+TqQCppnoT7glJkeXFeT7QnpQqOhOfaOrjfNKyNmSrQNjy1R2
         dGMgkZ98J7MMS5l2VbfPKsMA9HAMEUu6G1v+bpsaohKbuXUxrQ2/M+YB9j4343sF6/fH
         CfUcJIH1BY+4Hs2FSaKiOFB4xirgNEqxc2A5OBDsV3+IkO6sALgO7cXpar75WY1xQdjd
         BH3g==
X-Gm-Message-State: AOAM532CbwBjXDhF1mLzWRbPdWqV2P4MOqPYhxnlqoyUaeuVYytFuMyA
        XCS/LF9uYWcAjEkpGsNZRfcWZFgssELPx5bUAaekXg==
X-Google-Smtp-Source: ABdhPJxZtw35lHOr93Yk27TdEM8xHLSbd7kXw2FSOfNX0T613BLywsPz6ZcyhR6l5svUdWt8qrwV9HBRcxilPtdejJk=
X-Received: by 2002:a05:6122:54b:: with SMTP id y11mr11339421vko.16.1636466165951;
 Tue, 09 Nov 2021 05:56:05 -0800 (PST)
MIME-Version: 1.0
References: <20211109000130.42361-1-hans-gert.dahmen@immu.ne> <YYoSPjF3M05dR0PX@kroah.com>
In-Reply-To: <YYoSPjF3M05dR0PX@kroah.com>
From:   Mauro Lima <mauro.lima@eclypsium.com>
Date:   Tue, 9 Nov 2021 10:55:54 -0300
Message-ID: <CAArk9MN99YjKV2AKCYsUqh7LNVCb2ddvcSnRgGGsXePkM6Q86Q@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        philipp.deppenwiese@immu.ne, Richard Hughes <hughsient@gmail.com>,
        platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Tue, Nov 9, 2021 at 3:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Nov 09, 2021 at 01:01:30AM +0100, Hans-Gert Dahmen wrote:
> > Make the 16MiB long memory-mapped BIOS region of the platform SPI flash
> > on X86_64 system available via /sys/kernel/firmware/flash_mmap/bios_reg=
ion
> > for pen-testing, security analysis and malware detection on kernels
> > which restrict module loading and/or access to /dev/mem.
>
> That feels like a big security hole we would be opening up for no good
> reason.
Please, can you explain why this could be a security hole?
IMO if the host is compromised the attacker already has information
about the BIOS version, and after a quick lookup they know the BIOS
vulnerabilities or the lack of them.
>
> > It will be used by the open source Converged Security Suite.
> > https://github.com/9elements/converged-security-suite
>
> What is the reason for this, and what use is this new interface?
In Eclypsium we are also interested in being able to dump the actual
binary from hosts and compare them to see if they are corrupted
somehow.
>
> >
> > Signed-off-by: Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
> > ---
> >  drivers/firmware/Kconfig             |  9 +++
> >  drivers/firmware/Makefile            |  1 +
> >  drivers/firmware/x86_64_flash_mmap.c | 86 ++++++++++++++++++++++++++++
>
> You forgot to document the new sysfs files in Documentation/ABI/ :(
>
>
> >  3 files changed, 96 insertions(+)
> >  create mode 100644 drivers/firmware/x86_64_flash_mmap.c
> >
> > diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> > index 75cb91055c17..27c2d0b074e0 100644
> > --- a/drivers/firmware/Kconfig
> > +++ b/drivers/firmware/Kconfig
> > @@ -293,6 +293,15 @@ config TURRIS_MOX_RWTM
> >         other manufacturing data and also utilize the Entropy Bit Gener=
ator
> >         for hardware random number generation.
> >
> > +config X86_64_FLASH_MMAP
> > +     tristate "Export platform flash memory-mapped BIOS region"
> > +     depends on X86_64
> > +     help
> > +       Export the memory-mapped BIOS region of the platform SPI flash =
as
> > +       a read-only sysfs binary attribute on X86_64 systems. The first=
 16MiB
> > +       will be accessible via /sys/devices/platform/flash_mmap/bios_re=
gion
> > +       for security and malware analysis for example.
> > +
> >  source "drivers/firmware/arm_ffa/Kconfig"
> >  source "drivers/firmware/broadcom/Kconfig"
> >  source "drivers/firmware/cirrus/Kconfig"
> > diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> > index 4e58cb474a68..60dc4ea08705 100644
> > --- a/drivers/firmware/Makefile
> > +++ b/drivers/firmware/Makefile
> > @@ -24,6 +24,7 @@ obj-$(CONFIG_SYSFB_SIMPLEFB)        +=3D sysfb_simple=
fb.o
> >  obj-$(CONFIG_TI_SCI_PROTOCOL)        +=3D ti_sci.o
> >  obj-$(CONFIG_TRUSTED_FOUNDATIONS) +=3D trusted_foundations.o
> >  obj-$(CONFIG_TURRIS_MOX_RWTM)        +=3D turris-mox-rwtm.o
> > +obj-$(CONFIG_X86_64_FLASH_MMAP)      +=3D x86_64_flash_mmap.o
> >
> >  obj-y                                +=3D arm_ffa/
> >  obj-y                                +=3D arm_scmi/
> > diff --git a/drivers/firmware/x86_64_flash_mmap.c b/drivers/firmware/x8=
6_64_flash_mmap.c
> > new file mode 100644
> > index 000000000000..23d8655d17bb
> > --- /dev/null
> > +++ b/drivers/firmware/x86_64_flash_mmap.c
> > @@ -0,0 +1,86 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Export the memory-mapped BIOS region of the platform SPI flash as
> > + * a read-only sysfs binary attribute on X86_64 systems.
> > + *
> > + * Copyright =C2=A9 2021 immune GmbH
> > + */
> > +
> > +#include <linux/version.h>
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/io.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/platform_device.h>
> > +
> > +#define FLASH_REGION_START 0xFF000000ULL
> > +#define FLASH_REGION_SIZE 0x1000000ULL
> > +#define FLASH_REGION_MASK (FLASH_REGION_SIZE - 1)
> > +
> > +struct platform_device *pdev;
> > +
> > +static ssize_t bios_region_read(struct file *file, struct kobject *kob=
j,
> > +                             struct bin_attribute *bin_attr, char *buf=
fer,
> > +                             loff_t offset, size_t count)
> > +{
> > +     resource_size_t pa;
> > +     size_t copysize, remapsize;
> > +     void __iomem *va;
> > +
> > +     offset =3D offset & FLASH_REGION_MASK;
> > +     pa =3D (FLASH_REGION_START + offset) & PAGE_MASK;
> > +
> > +     if ((offset + count) > FLASH_REGION_SIZE)
> > +             copysize =3D FLASH_REGION_SIZE - offset;
> > +     else
> > +             copysize =3D min(count, PAGE_SIZE);
> > +
> > +     if (((offset & ~PAGE_MASK) + copysize) > PAGE_SIZE)
> > +             remapsize =3D 2 * PAGE_SIZE;
> > +     else
> > +             remapsize =3D PAGE_SIZE;
> > +
> > +     va =3D ioremap(pa, remapsize);
> > +     memcpy_fromio(buffer, va, copysize);
> > +     iounmap(va);
> > +
> > +     return copysize;
> > +}
> > +
> > +static BIN_ATTR_RO(bios_region, FLASH_REGION_SIZE);
> > +
> > +static struct bin_attribute *flash_mmap_attrs[] =3D { &bin_attr_bios_r=
egion,
> > +                                                 NULL };
> > +
> > +static const struct attribute_group flash_mmap_group =3D {
> > +     .bin_attrs =3D flash_mmap_attrs,
> > +};
> > +
> > +static int __init flash_mmap_init(void)
> > +{
> > +     int ret;
> > +
> > +     pdev =3D platform_device_register_simple("flash_mmap", -1, NULL, =
0);
> > +     if (IS_ERR(pdev))
> > +             return PTR_ERR(pdev);
> > +
> > +     ret =3D sysfs_create_group(&pdev->dev.kobj, &flash_mmap_group);
>
> You just raced with userspace and lost :(
>
> Please set the attribute to the platform driver before you create the
> device.
>
> Also, you just bound this driver to ANY platform that it was loaded on,
> with no actual detection of the hardware present, which feels like it
> could cause big problems on all platforms.  Please, if you really want
> to do this, restrict it to hardware that actually has the hardware you
> are wanting to access, not all machines in the world.
>
> thanks,
>
> greg k-h
