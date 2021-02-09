Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68983153E8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbhBIQak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 11:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbhBIQae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:30:34 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7D2C061574
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 08:29:54 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id w2so32600930ejk.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 08:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d0M7T0p8pfffMUPJ7UyjjBZYnrwZkHMwSr3yfUaYs3w=;
        b=gqsLlM0eVbMPOz9pFO1uPAOcrIw3ice09Phv+k4aQDpqpNpUKGDStkNLBOpVIQ5ocd
         iQIWoUx/5Cf7M5cLU8T30SFfkowNgr6d3iLFCbQcH9AqBmv+Kp3MsQjurmb/y2RPDTeW
         2FCMUVsoK8g+cTP5ZfIGrSxIguISC5VNux4RPhWCB6eLVu3WOFk+ztQrEh0+przXMoib
         PszG4+7xKsQMZUBWNGX3mxEEHGMHWKWkabVWYxCV7f6GRTpYuAxj6nVS3XjDw9o4w61f
         7pKgRv7oWAW0ImuJiTGGxCuA4K4U1y10dmFWFOolt+/NVosIQDOFnatt4l4xp/2p4Wiy
         iAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d0M7T0p8pfffMUPJ7UyjjBZYnrwZkHMwSr3yfUaYs3w=;
        b=ZQArGjrmW7GqQxXOhj1Xp1ZR2+XvJiME5BiJoLrzWLYroOrpbE+Kc6lOEeBdiKKv1W
         afO5ZCsf8ozE60wpASoCepXcFecD8IAxouPXc+i25oks6TrECIjSnYY6qG7OloZXY1cG
         yTKbl2YAODfk5pvCITOD/NQf/33R2O5o4Yjyq6V5KPNRMqvspdo6FScW51WmQhZQO8Cy
         MQnhDINmt+1zSmk70gFjHDPsqLMmcacXSPpNTdrcoGEyP6rm3FZa5CISJABilsBqrLog
         J5ngDH1uq+q9kqHvlDoCllUKSwCHB1BjqfaA8mIP/1nORc5Fz6mZpT0Qz/bezYp/v0eI
         GtlQ==
X-Gm-Message-State: AOAM533mVMRLT/1clNZeHx2E7stMPKJ5WUOL9V2UYKxYZpp0ho5cvi8R
        blmwWCFFi3CCViGmWJX6MUodLfw8BMIm8k4JLgqEBw==
X-Google-Smtp-Source: ABdhPJyHtio6KvscWCp5eNbMjWEaHGzUnl6nqLmvMUea17uwKZS8xaCbtXGlkhJ25OygnaPvJB27Cigzv5TiVYhGU+Q=
X-Received: by 2002:a17:906:4051:: with SMTP id y17mr22987959ejj.45.1612888193510;
 Tue, 09 Feb 2021 08:29:53 -0800 (PST)
MIME-Version: 1.0
References: <20210127225641.1342-1-mike.ximing.chen@intel.com>
 <20210127225641.1342-2-mike.ximing.chen@intel.com> <YCKP5ZUL1/wMzmf4@kroah.com>
In-Reply-To: <YCKP5ZUL1/wMzmf4@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 9 Feb 2021 08:29:41 -0800
Message-ID: <CAPcyv4hC2dJGAXbG2ogO=2THuDUHjgYekkNy4K_zwEmQcXLcjA@mail.gmail.com>
Subject: Re: [PATCH v10 01/20] dlb: add skeleton for DLB driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Mike Ximing Chen <mike.ximing.chen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Gage Eads <gage.eads@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 9, 2021 at 5:36 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 27, 2021 at 04:56:22PM -0600, Mike Ximing Chen wrote:
> > Add basic driver functionality (load, unload, probe, and remove callbacks)
> > for the DLB driver.
> >
> > Add documentation which describes in detail the hardware, the user
> > interface, device interrupts, and the driver's power-management strategy.
> > For more details about the driver see the documentation in the patch.
> >
> > Add a DLB entry to the MAINTAINERS file.
> >
> > Signed-off-by: Gage Eads <gage.eads@intel.com>
> > Signed-off-by: Mike Ximing Chen <mike.ximing.chen@intel.com>
> > Reviewed-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  Documentation/misc-devices/dlb.rst   | 259 +++++++++++++++++++++++++++
> >  Documentation/misc-devices/index.rst |   1 +
> >  MAINTAINERS                          |   8 +
> >  drivers/misc/Kconfig                 |   1 +
> >  drivers/misc/Makefile                |   1 +
> >  drivers/misc/dlb/Kconfig             |  18 ++
> >  drivers/misc/dlb/Makefile            |   9 +
> >  drivers/misc/dlb/dlb_hw_types.h      |  32 ++++
> >  drivers/misc/dlb/dlb_main.c          | 156 ++++++++++++++++
> >  drivers/misc/dlb/dlb_main.h          |  37 ++++
> >  10 files changed, 522 insertions(+)
> >  create mode 100644 Documentation/misc-devices/dlb.rst
> >  create mode 100644 drivers/misc/dlb/Kconfig
> >  create mode 100644 drivers/misc/dlb/Makefile
> >  create mode 100644 drivers/misc/dlb/dlb_hw_types.h
> >  create mode 100644 drivers/misc/dlb/dlb_main.c
> >  create mode 100644 drivers/misc/dlb/dlb_main.h
> >
> > diff --git a/Documentation/misc-devices/dlb.rst b/Documentation/misc-devices/dlb.rst
> > new file mode 100644
> > index 000000000000..aa79be07ee49
> > --- /dev/null
> > +++ b/Documentation/misc-devices/dlb.rst
> > @@ -0,0 +1,259 @@
> > +.. SPDX-License-Identifier: GPL-2.0-only
> > +
> > +===========================================
> > +Intel(R) Dynamic Load Balancer Overview
> > +===========================================
> > +
> > +:Authors: Gage Eads and Mike Ximing Chen
> > +
> > +Contents
> > +========
> > +
> > +- Introduction
> > +- Scheduling
> > +- Queue Entry
> > +- Port
> > +- Queue
> > +- Credits
> > +- Scheduling Domain
> > +- Interrupts
> > +- Power Management
> > +- User Interface
> > +- Reset
> > +
> > +Introduction
> > +============
> > +
> > +The Intel(r) Dynamic Load Balancer (Intel(r) DLB) is a PCIe device that
> > +provides load-balanced, prioritized scheduling of core-to-core communication.
> > +
> > +Intel DLB is an accelerator for the event-driven programming model of
> > +DPDK's Event Device Library[2]. The library is used in packet processing
> > +pipelines that arrange for multi-core scalability, dynamic load-balancing, and
> > +variety of packet distribution and synchronization schemes.
>
> As this is a networking related thing, I would like you to get the
> proper reviews/acks from the networking maintainers before I can take
> this.
>
> Or, if they think it has nothing to do with networking, that's fine too,
> but please do not try to route around them.

To be clear, I did not sense any attempt to route around networking
review as it appeared generically centered around hardware accelerated
IPC. At the same time I don't know what I don't know about how this
might interact with networking initiatives so the review trip seems
reasonable to me.
