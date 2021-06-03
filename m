Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76B739AA04
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhFCSbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:31:43 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:38853 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhFCSbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:31:42 -0400
Received: by mail-pj1-f43.google.com with SMTP id m13-20020a17090b068db02901656cc93a75so5982546pjz.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 11:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x0caGT42jTGhuDOTTIsQNvS2yEGE3q3nCqPaWtABsUk=;
        b=Dtfca2pBLzmoGLk5K8glf3S7OKkxAy0OJzTvsGCdwiSvz94dxCb0tD4eQ8WiETN9oh
         bYEjppsNQdRPXrRL4MmUOhD0JcUetQgwcFriWE8+Lz3kIssG0BL/rP8PlKy9pOowbQ6G
         8/KJmaj4vG6qnD6dJiRbdO4HpcnOQE1My/Lm2FvCdqofl7xlaRmsMz2dGmamBs/qwfA/
         vIy25qhoxsfawyAlLmlFGp7/gsYfuu/nQLbV/3lyzoB83HRKGLW1ZRbybTynUqChTbVw
         YXKx2rVEcqBs6DWmoz08Xo28EcAMSiVNvpuwAwFVCrNA16uYII00Wm4/oHmDYocI2agJ
         on9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x0caGT42jTGhuDOTTIsQNvS2yEGE3q3nCqPaWtABsUk=;
        b=qCn/UjHylZhUWTm4xZjDyNfhvnRTIrFt5m5ntKvefwNUOVBP76zKdGmJ5T+roUNYqc
         XLYqf+Upp59VLaVf1u04pnA0eOgSAJy/khIHafr1wHCysmulo+ocluQCKO5oOn+DqhkJ
         RcbJ3B9kuoTA1aumXEV+uUp9dzIZ48lBO2WzPA9i+hpfgUPfQD9znc786OC6TEKRh16B
         dNw6sJj6ck8kPoQQK5owwe7UzApuReF3kyK9Z8LveINatozw98qGLAPu3t5AIfraMm3m
         ikNiuvGoRBcOxCNG6nbClUiR9RG4ygPXHjbOulxlPPn2KKTprWedxmhKpAP3iX30RG9g
         uqkQ==
X-Gm-Message-State: AOAM53010efPjCpOAGjxc7X+6jvD+pDqiukYuSiqIFBe5oqupo1TEv48
        RXKv08BNyFl8qM8m3Tq/g3x1vM6G6h1OA5Lb0jAGuQ==
X-Google-Smtp-Source: ABdhPJzk+dQq9mAVKxlaMVLbyudy+S5qRVsOjRoB6HP+RHiy2xMjfy0t2//B7VH+dgBBcvac8cg3nsNX/bdI/GIoDcA=
X-Received: by 2002:a17:90b:17c9:: with SMTP id me9mr12811107pjb.13.1622744937160;
 Thu, 03 Jun 2021 11:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4i0y_4cMGEpNVShLUyUk3nyWH203Ry3S87BqnDJE0Rmxg@mail.gmail.com>
 <20210603181144.GA2129146@bjorn-Precision-5520>
In-Reply-To: <20210603181144.GA2129146@bjorn-Precision-5520>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 3 Jun 2021 11:28:46 -0700
Message-ID: <CAPcyv4jgVk2Cr_dgvmfqJak3jYHpaSNd5qR+OcPd2_QPvxVETQ@mail.gmail.com>
Subject: Re: [PATCH v4] /dev/mem: Revoke mappings when a driver claims the region
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021 at 11:12 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Jun 02, 2021 at 09:15:35PM -0700, Dan Williams wrote:
> > On Wed, Jun 2, 2021 at 8:40 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > [+cc Pali, Oliver]
> > >
> > > On Thu, May 27, 2021 at 02:30:31PM -0700, Dan Williams wrote:
> > > > On Thu, May 27, 2021 at 1:58 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > >
> > > > > [+cc Daniel, Krzysztof, Jason, Christoph, linux-pci]
> > > > >
> > > > > On Thu, May 21, 2020 at 02:06:17PM -0700, Dan Williams wrote:
> > > > > > Close the hole of holding a mapping over kernel driver takeover event of
> > > > > > a given address range.
> > > > > >
> > > > > > Commit 90a545e98126 ("restrict /dev/mem to idle io memory ranges")
> > > > > > introduced CONFIG_IO_STRICT_DEVMEM with the goal of protecting the
> > > > > > kernel against scenarios where a /dev/mem user tramples memory that a
> > > > > > kernel driver owns. However, this protection only prevents *new* read(),
> > > > > > write() and mmap() requests. Established mappings prior to the driver
> > > > > > calling request_mem_region() are left alone.
> > > > > >
> > > > > > Especially with persistent memory, and the core kernel metadata that is
> > > > > > stored there, there are plentiful scenarios for a /dev/mem user to
> > > > > > violate the expectations of the driver and cause amplified damage.
> > > > > >
> > > > > > Teach request_mem_region() to find and shoot down active /dev/mem
> > > > > > mappings that it believes it has successfully claimed for the exclusive
> > > > > > use of the driver. Effectively a driver call to request_mem_region()
> > > > > > becomes a hole-punch on the /dev/mem device.
> > > > >
> > > > > This idea of hole-punching /dev/mem has since been extended to PCI
> > > > > BARs via [1].
> > > > >
> > > > > Correct me if I'm wrong: I think this means that if a user process has
> > > > > mmapped a PCI BAR via sysfs, and a kernel driver subsequently requests
> > > > > that region via pci_request_region() or similar, we punch holes in the
> > > > > the user process mmap.  The driver might be happy, but my guess is the
> > > > > user starts seeing segmentation violations for no obvious reason and
> > > > > is not happy.
> > > > >
> > > > > Apart from the user process issue, the implementation of [1] is
> > > > > problematic for PCI because the mmappable sysfs attributes now depend
> > > > > on iomem_init_inode(), an fs_initcall, which means they can't be
> > > > > static attributes, which ultimately leads to races in creating them.
> > > >
> > > > See the comments in iomem_get_mapping(), and revoke_iomem():
> > > >
> > > >         /*
> > > >          * Check that the initialization has completed. Losing the race
> > > >          * is ok because it means drivers are claiming resources before
> > > >          * the fs_initcall level of init and prevent iomem_get_mapping users
> > > >          * from establishing mappings.
> > > >          */
> > > >
> > > > ...the observation being that it is ok for the revocation inode to
> > > > come on later in the boot process because userspace won't be able to
> > > > use the fs yet. So any missed calls to revoke_iomem() would fall back
> > > > to userspace just seeing the resource busy in the first instance. I.e.
> > > > through the normal devmem_is_allowed() exclusion.
> > >
> > > I did see that comment, but the race I meant is different.  Pali wrote
> > > up a nice analysis of it [3].
> > >
> > > Here's the typical enumeration flow for PCI:
> > >
> > >   acpi_pci_root_add                 <-- subsys_initcall (4)
> > >     pci_acpi_scan_root
> > >       ...
> > >         pci_device_add
> > >           device_initialize
> > >           device_add
> > >             device_add_attrs        <-- static sysfs attributes created
> > >     ...
> > >     pci_bus_add_devices
> > >       pci_bus_add_device
> > >         pci_create_sysfs_dev_files
> > >           if (!sysfs_initialized) return;    <-- Ugh :)
> > >           ...
> > >             attr->mmap = pci_mmap_resource_uc
> > >             attr->mapping = iomem_get_mapping()  <-- new dependency
> > >               return iomem_inode->i_mapping
> > >             sysfs_create_bin_file   <-- dynamic sysfs attributes created
> > >
> > >   iomem_init_inode                  <-- fs_initcall (5)
> > >     iomem_inode = ...               <-- now iomem_get_mapping() works
> > >
> > >   pci_sysfs_init                    <-- late_initcall (7)
> > >     sysfs_initialized = 1           <-- Ugh (see above)
> > >     for_each_pci_dev(dev)           <-- Ugh
> > >       pci_create_sysfs_dev_files(dev)
> > >
> > > The race is between the pci_sysfs_init() initcall (intended for
> > > boot-time devices) and the pci_bus_add_device() path (used for all
> > > devices including hot-added ones).  Pali outlined cases where we call
> > > pci_create_sysfs_dev_files() from both paths for the same device.
> > >
> > > "sysfs_initialized" is a gross hack that prevents this most of the
> > > time, but not always.  I want to get rid of it and pci_sysfs_init().
> > >
> > > Oliver had the excellent idea of using static sysfs attributes to do
> > > this cleanly [4].  If we can convert things to static attributes, the
> > > device core creates them in device_add(), so we don't have to create
> > > them in pci_create_sysfs_dev_files().
> > >
> > > Krzysztof recently did some very nice work to convert most things to
> > > static attributes, e.g., [5].  But we can't do this for the PCI BAR
> > > attributes because they support ->mmap(), which now depends on
> > > iomem_get_mapping(), which IIUC doesn't work until after fs_initcalls.
> >
> > Ah, sorry, yes, I see the race now. And yes, anything that gets in the
> > way of the static attribute conversion needs fixing. How about
> > something like this?
>
> That looks like it would solve our problem, thanks a lot!  Obvious in
> retrospect, like all good ideas :)
>
> Krzysztof noticed a couple other users of iomem_get_mapping()
> added by:
>
>   71a1d8ed900f ("resource: Move devmem revoke code to resource framework")
>   636b21b50152 ("PCI: Revoke mappings like devmem")
>
> I *could* extend your patch below to cover all these, but it's kind of
> outside my comfort zone, so I'd feel better if Daniel V (who wrote the
> commits above) could take a look and do a follow-up.
>
> If I could take the resulting patch via PCI, we might even be able to
> get the last static attribute conversions in this cycle.

Sounds good, I'll circle back and give it a try if Daniel does not get
a chance to chime in in the next few days.
