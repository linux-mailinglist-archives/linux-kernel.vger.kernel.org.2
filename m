Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672213E8CD6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 11:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbhHKJH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 05:07:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23570 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236397AbhHKJHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 05:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628672817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tJdK2Xheq3PeuWs1Z89FnNTCTYj2RWeTBpjwVuqsHUU=;
        b=GG7B8fiPlGd46o3lUjD1BS2NRIJN91dr4vQOas3QnE7t5FdzIxiMwBsIua0MYgQmvm1yRF
        ZkZSvnm+/p7SUvQK5hgL10TglBpAvzb9tD7zmhkXRfT2El7Xg4KweSJibUJMzS4YcaymCz
        4575g4jf3XMw1d1j44nooiOq4ww3nME=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-0jU58dPYNcSY52b0EBuZ0w-1; Wed, 11 Aug 2021 05:06:56 -0400
X-MC-Unique: 0jU58dPYNcSY52b0EBuZ0w-1
Received: by mail-lj1-f200.google.com with SMTP id h6-20020a05651c1146b029019d82baae44so552530ljo.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 02:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJdK2Xheq3PeuWs1Z89FnNTCTYj2RWeTBpjwVuqsHUU=;
        b=fsIbZJObjom51nJdqGJyRYp2jmhmqlMlw/AB0gXIbE/v4fCis8FNTOrK9tzYYeePiL
         UBlU3BS6v+xj24HHgytqFITB/O1Te9wkwxWRzjcjPqHaWjLzomyknpTG5s9W1aZNQgOh
         jeFwzOxD2xd7o56cUU++3HDi/3ZbDpNjy1Rjw5Cp5afaL+KIqvBH3JNU5skhcu3FrB75
         Hk2yXk3ubrz3b4x2sTVd0CKsHrTwjzj2DY/7qzXKSfOaLfHzK63uXonPtmUwIeciIrYQ
         G7TNG43Q9VJMhaNlfX+L/+Hm4KSgyw8QPXLAiv9LsSpvlbRo1S07wp7EklApq1QWZB1o
         uD1w==
X-Gm-Message-State: AOAM5320wkX1pgjRlX8X9uZr9T4Jo3AtIdeCZcKV6CRC+I+BhZ84KWIA
        XYgSy6bdd6S9NwJ1b1C0VMufiOrsD4eh9y7hVhy89ucWuO5YQs4D2Kab0l+J8OPRS3tXypQht8H
        ZMobxnfqUX9OrPqGwTKNvNaRw8ftBumbiWYB8VfBX
X-Received: by 2002:a2e:9e1a:: with SMTP id e26mr22692143ljk.265.1628672814681;
        Wed, 11 Aug 2021 02:06:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzABPdaiDmJXM7Y7FMTZCtk45xPEwlUEzlH1nbKPKuFHyJ5liwtXCF7fiEZ36NAOV1hX2cBZIZhsGOc1IPL2sY=
X-Received: by 2002:a2e:9e1a:: with SMTP id e26mr22692126ljk.265.1628672814418;
 Wed, 11 Aug 2021 02:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210810095832.4234-1-hpa@redhat.com> <3a69ebb0-b27d-e8d5-e219-c6ee388cd628@redhat.com>
In-Reply-To: <3a69ebb0-b27d-e8d5-e219-c6ee388cd628@redhat.com>
From:   Kate Hsuan <hpa@redhat.com>
Date:   Wed, 11 Aug 2021 17:06:43 +0800
Message-ID: <CAEth8oHeRimhmMhA8EYL+WWkPLYZgM94W_nkO2Axt7JFFkgE9Q@mail.gmail.com>
Subject: Re: [PATCH 00/20] Move Intel platform drivers to intel directory to
 improve readability.
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
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

On Tue, Aug 10, 2021 at 10:05 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Kate,
>
> On 8/10/21 11:58 AM, Kate Hsuan wrote:
> > All the intel platform specific drivers are moved to intel/.
> > It makes more clear file structure to improve the readability.
> >
> > Kate Hsuan (20):
> >   Move Intel hid of pdx86 to intel directory to improve readability.
> >   Move Intel WMI driver of pdx86 to intel/ directory to improve
> >     readability.
> >   Move Intel bxtwc driver of pdx86 to intel/ directory to improve
> >     readability.
> >   Move Intel chtdc_ti driver of pdx86 to improve readability.
> >   Move MRFLD power button driver of pdx86 to intel directory to improve
> >     readability.
> >   Move Intel PMC core of pdx86 to intel/ directory to improve
> >     readability.
> >   Move Intel PMT driver of pdx86 to intel/ to improve readability.
> >   Move Intel P-Unit of pdx86 to intel/ directory to improve readability.
> >   Move Intel SCU IPC of pdx86 to intel directory to increase
> >     readability.
> >   Move Intel SoC telemetry driver to intel directory to improve
> >     readability.
> >   Move Intel IPS driver of pdx86 to improve readability.
> >   Move Intel RST driver of pdx86 to intel directory to improve
> >     readability.
> >   Move Intel smartconnect driver of pdx86 to intel/ directory to improve
> >     readability.
> >   Move Intel SST driver to intel/ directory to improve readability.
> >   Move Intel turbo max 3 driver to intel/ directory to improve
> >     readability.
> >   Move Intel uncore freq driver to intel/ directory to improve
> >     readability.
> >   Move Intel int0002 vgpio driver to intel/ directory to inprove
> >     readability.
> >   Move Intel thermal driver for menlow platform driver to intel/
> >     directory to improve readability.
> >   Move OakTrail driver to the intel/ directory to improve readability.
> >   Move Intel virtual botton driver to intel/ directory to improve
> >     readability.
>
> Thank you for doing this. I have a couple of remarks which I would
> like to see addressed for version 2 of this series:
>
> 1. The commit messages are currently all one line, so basically
> only a Subject and they are missing a Body describing the change
> in more detail (as already pointed out by Mika).
>
>
> 2. Kernel patch subjects (the first line of the commit message)
> should always be prefixed with the subsystem + component which they
> are for, so instead of e.g.
>
> "Move Intel hid of pdx86 to intel directory to improve readability."
>
> you would use:
>
> "platform/x86: intel-hid: Move to intel sub-directory to improve readability."
>
> But that is a bit long; and normally the Subject line is just
> a summary while the body explains things like the why, so this should
> probably be shorted to:
>
> "platform/x86: intel-hid: Move to intel sub-directory"
>
> For the Subject, with the Body explaining what exactly is being changed
> and why.
>
>
> 3. You are using new sub-directories for all drivers which you
> are moving, but for drivers which are currently just 1 c-file, this
> means going from 1 c-file to 3 files (c-file + Kconfig + Makefile)
> this seems a bit too much. I believe that it would be better for
> the single file drivers (e.g. intel-hid.c, intel-vbtn.c) to be moved
> directly under drivers/platform/x86/intel and for there Kconfig
> and Makefile bits to be moved to the already existing Kconfig
> and Makefile files there.
>
>
> 4. As Andy already mentioned when moving a file like
> "intel_scu_ipc.c" to drivers/platform/x86/intel/scu then the
> whole path becomes:
>
> drivers/platform/x86/intel/scu/intel_scu_ipc.c
>
> Which is quite long / quite a lot to type and repeats
> intel + scu twice, so it would be better to drop the intel_scu
> prefix from the filenames in this case resulting in:
>
> drivers/platform/x86/intel/scu/ipc.c
>
> in this example's case. This requires some extrea work:
>
> 4.1 You will need to adjust private includes to the new
> filenames
>
> 4.2 If you simply adjust say this Makefile line:
>
> obj-$(CONFIG_INTEL_SCU_PCI)             += intel_scu_pcidrv.o
>
> to:
>
> obj-$(CONFIG_INTEL_SCU_PCI)             += pcidrv.o
>
> a pcidrv.ko will get build, but that is a very generic name
> and then we end up with module-name clashes which are not
> allowed.
>
> So the Makefile needs to become a bit more complicated like this:
>
> intel_scu_pcidrv-y                      := pcidrv.o
> obj-$(CONFIG_INTEL_SCU_PCI)             += intel_scu_pcidrv.o
>
> See for example:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/tree/drivers/platform/x86/intel/pmt/Makefile?h=for-next
>
>
> 5. Some of the files which you are moving are mentioned in the
> MAINTAINERS file. For each file which you are moving please check if
> it is listed in the MAINTAINERS file, keeping wildcards in mind,
> so search e.g. for intel_scu for the intel_scu_* move.
>
> And if the file is listed then update the MAINTAINERS entry to
> point to the new location.
>
> Regards,
>
> Hans
>

Thanks Hans. I'll do that for my v2 patches.

