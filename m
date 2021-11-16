Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E540452E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 10:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhKPJjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 04:39:24 -0500
Received: from mail-ua1-f49.google.com ([209.85.222.49]:36486 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbhKPJjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 04:39:24 -0500
Received: by mail-ua1-f49.google.com with SMTP id r15so13815123uao.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 01:36:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E0eR9zkAbihj7HFpbj20+RG8BagR/Ljq9p4NqypyKkY=;
        b=C/vZhH4l4hrz2Q/i5MAVWMBCPN3PHUotsdYKGvpbeiveJDuPqxgwtk0ALfe9ILZl34
         w2Gw+zboobr3kFiw5GMnthT99ZsT8SR34QUiABfrn4EOswSH6gWovRpcNrjq3pO2P4e3
         k89LJaWEHHsRCr6Cx6PwMs1gyEBFZ4ZjkqsP+t4vf7SnMkzvpODD1nzDRbtqQnUdaUH0
         ySTzIqf27pgSVuq+2N5BCfdCygqYYJLPXbZEGiFy5UpEny+X5A30N7VaAGrrnUfaKIuW
         Q7ejjzx3ZA87V2skyDqeAhCq+Jjegi3yduZA8K++S/araGWrlkgkznn/Da4m+Q2qNWWB
         OmqQ==
X-Gm-Message-State: AOAM531ugSePvHx1451k6USry6pkvIdsdzrlpjj0Kfy8KEKsomQiBlBK
        luZQJygQ5x/3pNwvt444Ro0AUV4JZNsYTw==
X-Google-Smtp-Source: ABdhPJz+PfDx7PlzXZMq/GHX4SgVbCIEx+1bUtaAVxmUcoo/tzGhULTgVXLcvYCCBStK2BDC+QrJcw==
X-Received: by 2002:a05:6102:7b1:: with SMTP id x17mr52912083vsg.13.1637055386805;
        Tue, 16 Nov 2021 01:36:26 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id 15sm9884457vkj.49.2021.11.16.01.36.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 01:36:26 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id b17so41131508uas.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 01:36:26 -0800 (PST)
X-Received: by 2002:a05:6102:e82:: with SMTP id l2mr52824758vst.37.1637055386105;
 Tue, 16 Nov 2021 01:36:26 -0800 (PST)
MIME-Version: 1.0
References: <20211028061341.1479333-1-andr2000@gmail.com>
In-Reply-To: <20211028061341.1479333-1-andr2000@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 16 Nov 2021 10:36:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXEGtr5Js4QwyGBMLP_LzG8mk0Ovv9PiOpnU2-VVp+7dg@mail.gmail.com>
Message-ID: <CAMuHMdXEGtr5Js4QwyGBMLP_LzG8mk0Ovv9PiOpnU2-VVp+7dg@mail.gmail.com>
Subject: Re: [PATCH] xen-pciback: allow compiling on other archs than x86
To:     Oleksandr Andrushchenko <andr2000@gmail.com>
Cc:     xen-devel@lists.xenproject.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, julien@xen.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jan Beulich <jbeulich@suse.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Anastasiia Lukianenko <anastasiia_lukianenko@epam.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksandr,

On Thu, Oct 28, 2021 at 8:15 AM Oleksandr Andrushchenko
<andr2000@gmail.com> wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>
> Xen-pciback driver was designed to be built for x86 only. But it
> can also be used by other architectures, e.g. Arm.
>
> Currently PCI backend implements multiple functionalities at a time,
> such as:
> 1. It is used as a database for assignable PCI devices, e.g. xl
>    pci-assignable-{add|remove|list} manipulates that list. So, whenever
>    the toolstack needs to know which PCI devices can be passed through
>    it reads that from the relevant sysfs entries of the pciback.
> 2. It is used to hold the unbound PCI devices list, e.g. when passing
>    through a PCI device it needs to be unbound from the relevant device
>    driver and bound to pciback (strictly speaking it is not required
>    that the device is bound to pciback, but pciback is again used as a
>    database of the passed through PCI devices, so we can re-bind the
>    devices back to their original drivers when guest domain shuts down)
> 3. Device reset for the devices being passed through
> 4. Para-virtualised use-cases support
>
> The para-virtualised part of the driver is not always needed as some
> architectures, e.g. Arm or x86 PVH Dom0, are not using backend-frontend
> model for PCI device passthrough.
>
> For such use-cases make the very first step in splitting the
> xen-pciback driver into two parts: Xen PCI stub and PCI PV backend
> drivers.
>
> For that add new configuration options CONFIG_XEN_PCI_STUB and
> CONFIG_XEN_PCIDEV_STUB, so the driver can be limited in its
> functionality, e.g. no support for para-virtualised scenario.
> x86 platform will continue using CONFIG_XEN_PCIDEV_BACKEND for the
> fully featured backend driver.
>
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Signed-off-by: Anastasiia Lukianenko <anastasiia_lukianenko@epam.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> Reviewed-by: Juergen Gross <jgross@suse.com>

Thanks for your patch, which is now commit a67efff28832a597
("xen-pciback: allow compiling on other archs than x86")
in v5.16-rc1.

> --- a/drivers/xen/Kconfig
> +++ b/drivers/xen/Kconfig
> @@ -181,10 +181,34 @@ config SWIOTLB_XEN
>         select DMA_OPS
>         select SWIOTLB
>
> +config XEN_PCI_STUB
> +       bool
> +
> +config XEN_PCIDEV_STUB
> +       tristate "Xen PCI-device stub driver"
> +       depends on PCI && !X86 && XEN
> +       depends on XEN_BACKEND
> +       select XEN_PCI_STUB
> +       default m

Please note that this means "default y" if CONFIG_MODULES=n.
Perhaps this should be "default m if MODULES" instead?

> +       help
> +         The PCI device stub driver provides limited version of the PCI
> +         device backend driver without para-virtualized support for guests.
> +         If you select this to be a module, you will need to make sure no
> +         other driver has bound to the device(s) you want to make visible to
> +         other guests.
> +
> +         The "hide" parameter (only applicable if backend driver is compiled
> +         into the kernel) allows you to bind the PCI devices to this module
> +         from the default device drivers. The argument is the list of PCI BDFs:
> +         xen-pciback.hide=(03:00.0)(04:00.0)
> +
> +         If in doubt, say m.
> +
>  config XEN_PCIDEV_BACKEND
>         tristate "Xen PCI-device backend driver"
>         depends on PCI && X86 && XEN
>         depends on XEN_BACKEND
> +       select XEN_PCI_STUB
>         default m
>         help
>           The PCI device backend driver allows the kernel to export arbitrary

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
