Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89D63E594F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 13:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240236AbhHJLoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 07:44:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33149 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240131AbhHJLoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 07:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628595837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=POv/Coih+TmbH68jiX1oKwFFmrU4E+GCK1cZ8fcdxcY=;
        b=XEQFiwAr4EgXM4++trMFqrQboXJfLcsTl9qT55+EJFEnf8xJ4vWbTIfHTQFKljuLDKBoJ/
        ZEwGilAG5891/rT3ywhcEsEseM2s9ULRY05EGtS5PZhzVpg6+eDunHnTpbOl5c53TfDzO4
        WYp/41DNU8SiJJWDsZwTQPiRVBtNLF8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-huMv6PIyNSOQ2EN_TnvT3A-1; Tue, 10 Aug 2021 07:43:56 -0400
X-MC-Unique: huMv6PIyNSOQ2EN_TnvT3A-1
Received: by mail-lj1-f198.google.com with SMTP id b39-20020a05651c0b27b02901b47664ce3eso1921191ljr.21
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 04:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=POv/Coih+TmbH68jiX1oKwFFmrU4E+GCK1cZ8fcdxcY=;
        b=buKCHYlzVshFw3wLlN7JfpFEZlQJhMsivlDvmHynaAsghxQ/KSzr/kOU+s5jaftAuI
         AbgFLqCEsBkSvlUX4mhtW0aFGIv5bL3LXGXBdyVlx3P2OYQm521P9pwmzmjVRYt5EQAR
         WaA8Qwz998ic7AIshUuxgN6g1SERC72xgO/50Nai0xYwRy9LrzwVDy3Ux9jv5meLvHy6
         0LOAEaQ6o9VBq0OTGRc+Tvpe2OVA3CYcm5GsFl+YpaQS+lqmsI6dPwP4wg/rB7I7AfCh
         mS42j4Xhy1wMERA2ORg47Cc2LIyzwGFg/mvQ7oY04MMGjbzwWtIZFn/lRnhvsg1w2zxL
         cwTQ==
X-Gm-Message-State: AOAM531VD5mArtn+bl9v4lSMnbmbAerhwA2s/U860K31Z3Bxu1ID6NdT
        d7QHX5cjOIVj54uziUzMjvyozCEInhYBcki8f4wIbTEkmkc1N3+g+iYOAmuzynz1lPHcpVI/Duw
        ZDnTATTTqh5M1ieP7pCCwHCJmoT456CtPr/MkNcZs
X-Received: by 2002:ac2:484c:: with SMTP id 12mr21647947lfy.31.1628595833752;
        Tue, 10 Aug 2021 04:43:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6D50ioyE6X0l+l4mykyWQGf5Yme/N88BVqC8wBZZQd2ykyLax+dJ9lpnUTYCPue0EfVLNwCOb4OfBjPxtsbo=
X-Received: by 2002:ac2:484c:: with SMTP id 12mr21647932lfy.31.1628595833523;
 Tue, 10 Aug 2021 04:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210810095832.4234-1-hpa@redhat.com> <20210810095832.4234-10-hpa@redhat.com>
 <YRJPebbK3uQBU9K8@lahna>
In-Reply-To: <YRJPebbK3uQBU9K8@lahna>
From:   Kate Hsuan <hpa@redhat.com>
Date:   Tue, 10 Aug 2021 19:43:42 +0800
Message-ID: <CAEth8oE5we991RS12AJdFHtfD4kJkzFd4A0wHdEFKkX-i6kmvg@mail.gmail.com>
Subject: Re: [PATCH 09/20] Move Intel SCU IPC of pdx86 to intel directory to
 increase readability.
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
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

Hi Mika,

Thanks for your suggestion.
I'll add them to the patches and resend them again.

Thank you.

BR,
Kate

Kate Hsuan

PhD

Senior Software Engineer

Red Hat APAC

Rm. 2708, 27F., No.9, Songgao Rd., Xinyi Dist., Taipei City 110

kate.hsuan@redhat.com
M: +886-919560388



On Tue, Aug 10, 2021 at 6:06 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> No objections, I think this is good idea but..
>
> On Tue, Aug 10, 2021 at 05:58:21PM +0800, Kate Hsuan wrote:
>
> .. I suggest to add proper commit message here. Many maintainers ignore
> patches that don't have one.
>
> > Signed-off-by: Kate Hsuan <hpa@redhat.com>
> > ---
> >  drivers/platform/x86/Kconfig                  | 47 -----------------
> >  drivers/platform/x86/Makefile                 |  6 +--
> >  drivers/platform/x86/intel/Kconfig            |  1 +
> >  drivers/platform/x86/intel/Makefile           |  5 ++
> >  drivers/platform/x86/intel/scu/Kconfig        | 52 +++++++++++++++++++
> >  drivers/platform/x86/intel/scu/Makefile       | 11 ++++
> >  .../x86/{ => intel/scu}/intel_scu_ipc.c       |  0
> >  .../x86/{ => intel/scu}/intel_scu_ipcutil.c   |  0
> >  .../x86/{ => intel/scu}/intel_scu_pcidrv.c    |  0
> >  .../x86/{ => intel/scu}/intel_scu_pltdrv.c    |  0
> >  .../x86/{ => intel/scu}/intel_scu_wdt.c       |  0
> >  11 files changed, 70 insertions(+), 52 deletions(-)
> >  create mode 100644 drivers/platform/x86/intel/scu/Kconfig
> >  create mode 100644 drivers/platform/x86/intel/scu/Makefile
> >  rename drivers/platform/x86/{ => intel/scu}/intel_scu_ipc.c (100%)
> >  rename drivers/platform/x86/{ => intel/scu}/intel_scu_ipcutil.c (100%)
> >  rename drivers/platform/x86/{ => intel/scu}/intel_scu_pcidrv.c (100%)
> >  rename drivers/platform/x86/{ => intel/scu}/intel_scu_pltdrv.c (100%)
> >  rename drivers/platform/x86/{ => intel/scu}/intel_scu_wdt.c (100%)
>

