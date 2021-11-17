Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9017454992
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 16:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhKQPKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 10:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbhKQPKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 10:10:38 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1220C061764
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 07:07:39 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id o4so6973020oia.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 07:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z0+UqyGpQ62LM9RtAj0or8WWQ/siounJCEOYzLQDOkk=;
        b=YLcYHWrIJOaS7iK9pYFb/D5PXKMb4E3y6MD2zFcy6tehGQkF2pPfq3b7S1QozI/2JU
         vBT3vvw8gjOelj0qQsg5bMeMESJqYMXaMsbb5UaMNep+WShNOZ9C3Jqdc6ISywXhXaIu
         oSzLem9sCi7auuYLwIPBM9UfTgigyVs7iMS5mNUk6tGsbL7PgCEidfnH4KuszDmtQLci
         vRdsffBHZlyurrcbVomlASoYaBZKFAbcFd0lzJDWX9nHh3ih/XUyg5A5UMkJFpxp8nef
         UP3fHHjsZ48u9Qul/dEi1HDAhrYYGNkGArHMb2Dh6cF0ubxFS/YMDEEY4bE18GGSByvC
         AIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z0+UqyGpQ62LM9RtAj0or8WWQ/siounJCEOYzLQDOkk=;
        b=gRKGX0hojYVmlDG0sa6rYNFfXuWXkrHhFBQnDnKcPOap/GKXSUx92ESlwth0G1rLpU
         VPXKdn/r/JMzEcsEySBvYbjTzwRbdtCXZppi+7zcqYqKj0WVYs0Cg65WCoa7GVpn5+mm
         5doOVobI+Ufdy55Qe42QjqiFAuFazi0X7vwVKgT+HUYJf3k4sBTseA31MQDrk46NHp8S
         B8iKwKpIVZXpy8kO0jO8FDk0xA1N3iXQNCALIXrHf2yfwWiRiacck9CIwT0owkCD9Dqa
         g4OokqArn4PUvD8YouNFFmwJbOkOhSZboLB61iQ1SDYHicJVgj+l67CQNbcl0uN1QBDo
         zhAQ==
X-Gm-Message-State: AOAM533n8SyIca1ZWz5EkAnESQPUeLZHPsZMO+iUOdzRRS5gDSoUKtpf
        tQFs4YQZFagxO5npIMbDNx5Un1a5iO69rw==
X-Google-Smtp-Source: ABdhPJw9k3akfafs/Y87evainVodJJH+j6/xhjf01cL8P5BLZz7L5LV2Gw6upDL3kOCD5gA59zCVAQ==
X-Received: by 2002:aca:4307:: with SMTP id q7mr294739oia.3.1637161658796;
        Wed, 17 Nov 2021 07:07:38 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w10sm23376ott.46.2021.11.17.07.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 07:07:38 -0800 (PST)
Date:   Wed, 17 Nov 2021 09:07:33 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/1] rpmsg: add syslog driver
Message-ID: <YZUatUlg72DQb8ui@builder.lan>
References: <20211109083926.32052-1-christian.gmeiner@gmail.com>
 <20211109083926.32052-2-christian.gmeiner@gmail.com>
 <YYq4tjyv0qh+Zpqe@ripper>
 <CAH9NwWcyKyaGrTZ1=N73gA+zjO0wH_oMzLG_zi2TUc3dN69SNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH9NwWcyKyaGrTZ1=N73gA+zjO0wH_oMzLG_zi2TUc3dN69SNg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11 Nov 04:36 CST 2021, Christian Gmeiner wrote:

> Hi Bjorn
> 
> 
> > > Allows the remote firmware to log into syslog.
> > >
> >
> > This allows the remote firmware to print log messages in the kernel log,
> > not the syslog (although your system might inject the kernel log into
> > the syslog as well)
> >
> 
> Correct.
> 
> > > Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> > > ---
> > >  drivers/rpmsg/Kconfig        |  8 +++++
> > >  drivers/rpmsg/Makefile       |  1 +
> > >  drivers/rpmsg/rpmsg_syslog.c | 65 ++++++++++++++++++++++++++++++++++++
> >
> > drivers/rpmsg is for rpmsg bus and transport drivers. Client drivers
> > should live elsewhere.
> >
> 
> Ahh .. yes.
> 
> > But perhaps, rather than having a driver for this, you could simply use
> > rpmsg_char and a userspace tool; if you want to get the remote processor
> > logs into syslog, instead of the kernel log?
> >
> 
> I thought about that too (also regarding the rpmsg tty driver) but that means I
> need to start/supervise a user space tool.
> 
> > >  3 files changed, 74 insertions(+)
> > >  create mode 100644 drivers/rpmsg/rpmsg_syslog.c
> > >
> > > diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
> > > index 0b4407abdf13..801f9956ec21 100644
> > > --- a/drivers/rpmsg/Kconfig
> > > +++ b/drivers/rpmsg/Kconfig
> > > @@ -73,4 +73,12 @@ config RPMSG_VIRTIO
> > >       select RPMSG_NS
> > >       select VIRTIO
> > >
> > > +config RPMSG_SYSLOG
> > > +     tristate "SYSLOG device interface"
> > > +     depends on RPMSG
> > > +     help
> > > +       Say Y here to export rpmsg endpoints as device files, usually found
> > > +       in /dev. They make it possible for user-space programs to send and
> > > +       receive rpmsg packets.
> > > +
> > >  endmenu
> > > diff --git a/drivers/rpmsg/Makefile b/drivers/rpmsg/Makefile
> > > index 8d452656f0ee..75b2ec7133a5 100644
> > > --- a/drivers/rpmsg/Makefile
> > > +++ b/drivers/rpmsg/Makefile
> > > @@ -9,3 +9,4 @@ obj-$(CONFIG_RPMSG_QCOM_GLINK_RPM) += qcom_glink_rpm.o
> > >  obj-$(CONFIG_RPMSG_QCOM_GLINK_SMEM) += qcom_glink_smem.o
> > >  obj-$(CONFIG_RPMSG_QCOM_SMD) += qcom_smd.o
> > >  obj-$(CONFIG_RPMSG_VIRTIO)   += virtio_rpmsg_bus.o
> > > +obj-$(CONFIG_RPMSG_SYSLOG)   += rpmsg_syslog.o
> > > diff --git a/drivers/rpmsg/rpmsg_syslog.c b/drivers/rpmsg/rpmsg_syslog.c
> > > new file mode 100644
> > > index 000000000000..b3fdae495fd9
> > > --- /dev/null
> > > +++ b/drivers/rpmsg/rpmsg_syslog.c
> > > @@ -0,0 +1,65 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/rpmsg.h>
> > > +
> > > +static int rpmsg_syslog_cb(struct rpmsg_device *rpdev, void *data, int len,
> > > +                        void *priv, u32 src)
> > > +{
> > > +     const char *buffer = data;
> > > +
> > > +     switch (buffer[0]) {
> > > +     case 'e':
> > > +             dev_err(&rpdev->dev, "%s", buffer + 1);
> > > +             break;
> > > +     case 'w':
> > > +             dev_warn(&rpdev->dev, "%s", buffer + 1);
> > > +             break;
> > > +     case 'i':
> > > +             dev_info(&rpdev->dev, "%s", buffer + 1);
> > > +             break;
> > > +     default:
> > > +             dev_info(&rpdev->dev, "%s", buffer);
> > > +             break;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int rpmsg_syslog_probe(struct rpmsg_device *rpdev)
> > > +{
> > > +     struct rpmsg_endpoint *syslog_ept;
> > > +     struct rpmsg_channel_info syslog_chinfo = {
> > > +             .src = 42,
> > > +             .dst = 42,
> > > +             .name = "syslog",
> > > +     };
> > > +
> > > +     /*
> > > +      * Create the syslog service endpoint associated to the RPMsg
> > > +      * device. The endpoint will be automatically destroyed when the RPMsg
> > > +      * device will be deleted.
> > > +      */
> > > +     syslog_ept = rpmsg_create_ept(rpdev, rpmsg_syslog_cb, NULL, syslog_chinfo);
> >
> > The rpmsg_device_id below should cause the device to probe on the
> > presence of a "syslog" channel announcement, so why are you creating a
> > new endpoint with the same here?
> >
> > Why aren't you just specifying the callback of the driver?
> >
> 
> Good question. I think I was happy that I got work working somehow. I
> also want to send out
> a documentation update as it is not up to date with the current API.
> 

I'd be happy to take any documentation updates - or perhaps we should
reduce the duplication between the kerneldoc and Documentation/*...

> > > +     if (!syslog_ept) {
> > > +             dev_err(&rpdev->dev, "failed to create the syslog ept\n");
> > > +             return -ENOMEM;
> > > +     }
> > > +     rpdev->ept = syslog_ept;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static struct rpmsg_device_id rpmsg_driver_syslog_id_table[] = {
> > > +     { .name = "syslog" },
> > > +     { },
> > > +};
> > > +MODULE_DEVICE_TABLE(rpmsg, rpmsg_driver_syslog_id_table);
> > > +
> > > +static struct rpmsg_driver rpmsg_syslog_client = {
> > > +     .drv.name       = KBUILD_MODNAME,
> > > +     .id_table       = rpmsg_driver_syslog_id_table,
> > > +     .probe          = rpmsg_syslog_probe,
> > > +};
> > > +module_rpmsg_driver(rpmsg_syslog_client);
> >
> > I would expect that building this as a module gives you complaints about
> > lacking MODULE_LICENSE().
> >
> 
> Yeah .. I never built it as a module.
> 
> The biggest question I have: do you see any possibility to get such a
> redirection
> driver into mainline? At the moment I have not heard a big no.
> 

My feeling is "do we really need a dedicated driver for it", but I do
recognize that it solves a problem for you.

The only "objection" I have is that I personally wouldn't want all the
firmware logs mixed up with the kernel logs. Somehow getting this into
journald separately seems more useful.

Regards,
Bjorn

> -- 
> greets
> --
> Christian Gmeiner, MSc
> 
> https://christian-gmeiner.info/privacypolicy
