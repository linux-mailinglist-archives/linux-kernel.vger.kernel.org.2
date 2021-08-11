Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805F23E89DD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 07:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbhHKFoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 01:44:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31697 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234386AbhHKFoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 01:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628660634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4hIWA/ZAFS2MMOAAsU+N75I/sScSS4YfIRGrpwkpI0I=;
        b=fYx9yOA/a3Qav4Krj5/qF93HNRgStlfXm5wiODt30BhjIVBSg2CIFkscHQrE8BK3ZeyjCq
        +0k+O055RpLVQQHkv9nSJh25yY6oPPyZ3Cev5t8oT0j+XIe0zeWLp/sHPUu6kArJviGGXP
        CIP3wnOBgqCeiFyxlzcaTVzLWDlGnUY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-phN4akusNfmNDko6tVX1yA-1; Wed, 11 Aug 2021 01:43:53 -0400
X-MC-Unique: phN4akusNfmNDko6tVX1yA-1
Received: by mail-lf1-f69.google.com with SMTP id h39-20020a0565123ca7b02903ba26e9bc4cso497355lfv.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 22:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4hIWA/ZAFS2MMOAAsU+N75I/sScSS4YfIRGrpwkpI0I=;
        b=faRKcA6KqYGGcueMX1vC89YXygM1P3p/JKDFUwlbQo33kh0mRHWrMpMcNjtYqPbgbo
         XX4BZsNIfgUrC5M1KfYNbJkBnVzYDQSi0Hu3IbIjMHsbwrZq8JW5lu7YsfY3pJ0NjeqL
         rz7RQbxVzNKWwii3uKY2e0vGWCY/2ed23F4F2CMErbyqnZ0x+n+J3xJzpuGd7lXED6zo
         bslqb+AySfztff5oi1J8FVIfdFRIIzOsX6EE3+JEd3w2QtCkwz7JIlcGo4+V/LWqO1Aw
         pNzWhsb4m+wiB7eHQV+CvKms6Orej5BFvXPF1kxgnJyNtyyjXQThpHTxqOO+zP0wN185
         yddg==
X-Gm-Message-State: AOAM5326DCMCJntQx7B8XAsIr+busPaz1zCaz0HQG+EugqwhzerZViYd
        xQxQW/xomGEfXFkkaCjEvDro0L2tnqEcdYnRIvylcJhk0xlvYouTpQGeALyVwzUcoEt8iCz2Tn5
        H3Wnsb3I3WfuXaEEcK21WUSNrX0jo1gznZsi4vgYl
X-Received: by 2002:ac2:4573:: with SMTP id k19mr1017196lfm.622.1628660631684;
        Tue, 10 Aug 2021 22:43:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyohZQmjblPe3qlUFBCjz5iykbwcJjsqfuKqDpXh/TOjU87ppME9Ue+1Uu60UjM65a7/Oiwkf4ep1bL4jQiR1k=
X-Received: by 2002:ac2:4573:: with SMTP id k19mr1017182lfm.622.1628660631321;
 Tue, 10 Aug 2021 22:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210810095832.4234-1-hpa@redhat.com> <20210810095832.4234-9-hpa@redhat.com>
 <eb2f2024e0f58cffab76d6551eec499420196617.camel@linux.intel.com>
In-Reply-To: <eb2f2024e0f58cffab76d6551eec499420196617.camel@linux.intel.com>
From:   Kate Hsuan <hpa@redhat.com>
Date:   Wed, 11 Aug 2021 13:43:40 +0800
Message-ID: <CAEth8oG9p-AZ1d21ByC-VvVDF-KKo=FHTw2pb41hK=dQE8PHvQ@mail.gmail.com>
Subject: Re: [PATCH 08/20] Move Intel P-Unit of pdx86 to intel/ directory to
 improve readability.
To:     david.e.box@linux.intel.com
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com,
        platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some commit mistakes. I'll correct this.

Thank you. :)

On Wed, Aug 11, 2021 at 12:55 AM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> Hi,
>
> On Tue, 2021-08-10 at 17:58 +0800, Kate Hsuan wrote:
> > Signed-off-by: Kate Hsuan <hpa@redhat.com>
> > ---
> >  drivers/platform/x86/Kconfig                  | 43 -----------------
> > --
> >  drivers/platform/x86/Makefile                 |  2 +-
> >  drivers/platform/x86/intel/Kconfig            |  1 +
> >  drivers/platform/x86/intel/Makefile           |  1 +
> >  drivers/platform/x86/intel/punit/Kconfig      | 10 +++++
> >  drivers/platform/x86/intel/punit/Makefile     |  6 +++
> >  .../x86/{ => intel/punit}/intel_punit_ipc.c   |  0
> >  7 files changed, 19 insertions(+), 44 deletions(-)
> >  create mode 100644 drivers/platform/x86/intel/punit/Kconfig
> >  create mode 100644 drivers/platform/x86/intel/punit/Makefile
> >  rename drivers/platform/x86/{ => intel/punit}/intel_punit_ipc.c
> > (100%)
> >
> > diff --git a/drivers/platform/x86/Kconfig
> > b/drivers/platform/x86/Kconfig
> > index b9a324ba17e3..00fa213e9adb 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -1086,49 +1086,6 @@ config INTEL_UNCORE_FREQ_CONTROL
> >           will be called intel-uncore-frequency.
> >
> >
> > -
> > -config INTEL_PMT_CLASS
> > -       tristate
> > -       help
> > -         The Intel Platform Monitoring Technology (PMT) class driver
> > provides
> > -         the basic sysfs interface and file hierarchy used by PMT
> > devices.
> > -
> > -         For more information, see:
> > -         <file:Documentation/ABI/testing/sysfs-class-intel_pmt>
> > -
> > -         To compile this driver as a module, choose M here: the
> > module
> > -         will be called intel_pmt_class.
> > -
> > -config INTEL_PMT_TELEMETRY
> > -       tristate "Intel Platform Monitoring Technology (PMT)
> > Telemetry driver"
> > -       depends on MFD_INTEL_PMT
> > -       select INTEL_PMT_CLASS
> > -       help
> > -         The Intel Platform Monitory Technology (PMT) Telemetry
> > driver provides
> > -         access to hardware telemetry metrics on devices that
> > support the
> > -         feature.
> > -
> > -         To compile this driver as a module, choose M here: the
> > module
> > -         will be called intel_pmt_telemetry.
> > -
> > -config INTEL_PMT_CRASHLOG
> > -       tristate "Intel Platform Monitoring Technology (PMT) Crashlog
> > driver"
> > -       depends on MFD_INTEL_PMT
> > -       select INTEL_PMT_CLASS
> > -       help
> > -         The Intel Platform Monitoring Technology (PMT) crashlog
> > driver provides
> > -         access to hardware crashlog capabilities on devices that
> > support the
> > -         feature.
> > -
> > -         To compile this driver as a module, choose M here: the
> > module
> > -         will be called intel_pmt_crashlog.
> > -
>
> Accidentally caught the above configs not part of P-Unit IPC driver.
>
> > -config INTEL_PUNIT_IPC
> > -       tristate "Intel P-Unit IPC Driver"
> > -       help
> > -         This driver provides support for Intel P-Unit Mailbox IPC
> > mechanism,
> > -         which is used to bridge the communications between kernel
> > and P-Unit.
> > -
> >  config INTEL_SCU_IPC
> >         bool
> >
> > diff --git a/drivers/platform/x86/Makefile
> > b/drivers/platform/x86/Makefile
> > index 1310b1ebc3f0..dbb62085e7f9 100644
> > --- a/drivers/platform/x86/Makefile
> > +++ b/drivers/platform/x86/Makefile
> > @@ -124,7 +124,7 @@ obj-
> > $(CONFIG_INTEL_UNCORE_FREQ_CONTROL)             += intel-uncore-
> > frequency.o
> >
> >
> >
> > -obj-$(CONFIG_INTEL_PUNIT_IPC)          += intel_punit_ipc.o
> > +
> >  obj-$(CONFIG_INTEL_SCU_IPC)            += intel_scu_ipc.o
> >  obj-$(CONFIG_INTEL_SCU_PCI)            += intel_scu_pcidrv.o
> >  obj-$(CONFIG_INTEL_SCU_PLATFORM)       += intel_scu_pltdrv.o
> > diff --git a/drivers/platform/x86/intel/Kconfig
> > b/drivers/platform/x86/intel/Kconfig
> > index 38bfca25940d..189a34226fe0 100644
> > --- a/drivers/platform/x86/intel/Kconfig
> > +++ b/drivers/platform/x86/intel/Kconfig
> > @@ -26,6 +26,7 @@ source
> > "drivers/platform/x86/intel/chtdc_ti/Kconfig"
> >  source "drivers/platform/x86/intel/mrfld/Kconfig"
> >  source "drivers/platform/x86/intel/pmc_core/Kconfig"
> >  source "drivers/platform/x86/intel/pmt/Kconfig"
> > +source "drivers/platform/x86/intel/punit/Kconfig"
> >
> >
> >  endif # X86_PLATFORM_DRIVERS_INTEL
> > diff --git a/drivers/platform/x86/intel/Makefile
> > b/drivers/platform/x86/intel/Makefile
> > index 746bee1db055..9bd49a920900 100644
> > --- a/drivers/platform/x86/intel/Makefile
> > +++ b/drivers/platform/x86/intel/Makefile
> > @@ -21,3 +21,4 @@ obj-$(CONFIG_INTEL_PMC_CORE)          += pmc_core/
> >  obj-$(CONFIG_INTEL_PMT_CLASS)          += pmt/
> >  obj-$(CONFIG_INTEL_PMT_TELEMETRY)      += pmt/
> >  obj-$(CONFIG_INTEL_PMT_CRASHLOG)       += pmt/
> > +obj-$(CONFIG_INTEL_PUNIT_IPC)          += punit/
> > diff --git a/drivers/platform/x86/intel/punit/Kconfig
> > b/drivers/platform/x86/intel/punit/Kconfig
> > new file mode 100644
> > index 000000000000..db56ef3bb086
> > --- /dev/null
> > +++ b/drivers/platform/x86/intel/punit/Kconfig
> > @@ -0,0 +1,10 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# X86 Platform Specific Drivers
> > +#
> > +
> > +config INTEL_PUNIT_IPC
> > +       tristate "Intel P-Unit IPC Driver"
> > +       help
> > +         This driver provides support for Intel P-Unit Mailbox IPC
> > mechanism,
> > +         which is used to bridge the communications between kernel
> > and P-Unit.
> > diff --git a/drivers/platform/x86/intel/punit/Makefile
> > b/drivers/platform/x86/intel/punit/Makefile
> > new file mode 100644
> > index 000000000000..f25284806f63
> > --- /dev/null
> > +++ b/drivers/platform/x86/intel/punit/Makefile
> > @@ -0,0 +1,6 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# X86 Platform Specific Drivers
> > +#
> > +
> > +obj-$(CONFIG_INTEL_PUNIT_IPC)          += intel_punit_ipc.o
> > \ No newline at end of file
> > diff --git a/drivers/platform/x86/intel_punit_ipc.c
> > b/drivers/platform/x86/intel/punit/intel_punit_ipc.c
> > similarity index 100%
> > rename from drivers/platform/x86/intel_punit_ipc.c
> > rename to drivers/platform/x86/intel/punit/intel_punit_ipc.c
>
>

