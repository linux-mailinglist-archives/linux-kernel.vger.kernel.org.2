Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12443768E6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 18:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbhEGQgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 12:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236992AbhEGQgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 12:36:36 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371EBC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 09:35:36 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id i5so2777882pgm.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 09:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZMLMORoNSvvC0BEtc8Mea8MIFzdSS313j2tZp/uDuPQ=;
        b=Lyk4fFFPqxtBzGz4GyOl/2QfhfwKm6bSsEF5JLZ8/kM0OcCFP5CoYp4SdscSSONsZ2
         B9wckw2/DN7c0XrDDbVvqTnA3HmAbR4QeEp/UPBVgNySVi/m7fBgchfma/HiUzzmcqfZ
         s1vhfnJ4WADdOLqrbr/XWH/vEng2k1UC8PH/20sPnmGmFXJRTIlwKY7v89k1FQJ6r/U+
         7eVb9s4t8OlRB5Vkt251LyLhkTnPbSHcYNi2FrdF9bGTJqZxUBJTd1OCuolqfzzebFm+
         0xictBiH5rpEQT+mQkZPPR+3rkVALa7LAcZyOUsMlVWDpLcRmZVOE7Tt+d8CjKilcJHy
         aQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZMLMORoNSvvC0BEtc8Mea8MIFzdSS313j2tZp/uDuPQ=;
        b=fem9fOici5DPqSjqsxEiH3Oyvt8msbA3Nnpqe8DS931VBNqi6B9ycB0LLd5YlSnxMP
         8m+R22nWJI5yewtJY2BDFWSSTZDCiOL5wlI7eMXgRKx6opR8XjQmZSh0Y1ryGQ3fN184
         8RrKyeuiVkXeSQnHtsEAYcy3AJHCt3fKycaa1UEvNke2R9cmDxJ8WHedo569towiffkv
         RPyHQj3y23QPXEY3mFdtPPmvcW2qshtzme4/OuypQyoRjQisWicGBszc3vMyaaxcKgo8
         6C0sFxeVRjNHZyPe9YAgtIFnS+6VOcyacKydB1Su20isA59BPQLToJ0n1RA+mKt8qr+F
         d4FA==
X-Gm-Message-State: AOAM531hXbfJdu9xvV1muYJb5lI8waJAdyC+Zikdm/7Z76Q97HdG+8Pc
        B8NlCuMJqpavKT+1uOQ++wShiQ==
X-Google-Smtp-Source: ABdhPJy+gYj4c6p+Qvxd8IgRELIQUs0AlI0WJ+dM0qTl0KtleHQYLpTXiD57qyv43dwMUsmRoMImNQ==
X-Received: by 2002:a65:4185:: with SMTP id a5mr10658573pgq.388.1620405335686;
        Fri, 07 May 2021 09:35:35 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id y64sm5175789pfy.204.2021.05.07.09.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:35:35 -0700 (PDT)
Date:   Fri, 7 May 2021 10:35:33 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Julien Massot <julien.massot@iot.bzh>
Cc:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3 5/6] rpmsg: char: Introduce a rpmsg driver for the
 rpmsg char device
Message-ID: <20210507163533.GB1907885@xps15>
References: <20210429135507.8264-1-arnaud.pouliquen@foss.st.com>
 <20210429135507.8264-6-arnaud.pouliquen@foss.st.com>
 <20210505164159.GB1766375@xps15>
 <5a41e653-4d75-c5d5-a8e3-e247a50507f3@foss.st.com>
 <d840a1dc-c908-1be1-8354-ddd404045df6@iot.bzh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d840a1dc-c908-1be1-8354-ddd404045df6@iot.bzh>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Julien,

On Fri, May 07, 2021 at 10:17:12AM +0200, Julien Massot wrote:
> Hi Mathieu, Arnaud,
> 
> On 5/5/21 8:25 PM, Arnaud POULIQUEN wrote:
> > Hi Mathieu,
> > 
> > On 5/5/21 6:41 PM, Mathieu Poirier wrote:
> > > Hi Arnaud,
> > > 
> > > On Thu, Apr 29, 2021 at 03:55:06PM +0200, Arnaud Pouliquen wrote:
> > > > A rpmsg char device allows to probe the endpoint device on a remote name
> > > > service announcement.
> > > > 
> > > > With this patch the /dev/rpmsgX interface is created either by a user
> > > > application or by the remote firmware.
> > > > 
> > > > Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> > > > 
> > > > ---
> > > > update from V1:
> > > > 
> > > >   - add missing unregister_rpmsg_driver call on module exit.
> > > > ---
> > > >   drivers/rpmsg/rpmsg_char.c | 53 +++++++++++++++++++++++++++++++++++++-
> > > >   1 file changed, 52 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> > > > index 5c6a7da6e4d7..9166454c1310 100644
> > > > --- a/drivers/rpmsg/rpmsg_char.c
> > > > +++ b/drivers/rpmsg/rpmsg_char.c
> > > > @@ -18,6 +18,8 @@
> > > >   #include "rpmsg_char.h"
> > > > +#define RPMSG_CHAR_DEVNAME "rpmsg-raw"
> > > > +
> > > >   static dev_t rpmsg_major;
> > > >   static struct class *rpmsg_class;
> > > > @@ -413,6 +415,40 @@ int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent
> > > >   }
> > > >   EXPORT_SYMBOL(rpmsg_chrdev_eptdev_create);
> > > > +static int rpmsg_chrdev_probe(struct rpmsg_device *rpdev)
> > > > +{
> > > > +	struct rpmsg_channel_info chinfo;
> > > > +
> > > > +	memcpy(chinfo.name, RPMSG_CHAR_DEVNAME, sizeof(RPMSG_CHAR_DEVNAME));
> > > > +	chinfo.src = rpdev->src;
> > > > +	chinfo.dst = rpdev->dst;
> > > > +
> > > > +	return __rpmsg_chrdev_eptdev_create(rpdev, &rpdev->dev, chinfo, true);
> > > > +}
> > > > +
> > > > +static void rpmsg_chrdev_remove(struct rpmsg_device *rpdev)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	ret = device_for_each_child(&rpdev->dev, NULL, rpmsg_chrdev_eptdev_destroy);
> > > > +	if (ret)
> > > > +		dev_warn(&rpdev->dev, "failed to destroy endpoints: %d\n", ret);
> > > > +}
> > > > +
> > > > +static struct rpmsg_device_id rpmsg_chrdev_id_table[] = {
> > > > +	{ .name	= RPMSG_CHAR_DEVNAME },
> > > > +	{ },
> > > > +};
> > > > +
> > > > +static struct rpmsg_driver rpmsg_chrdev_driver = {
> > > > +	.probe = rpmsg_chrdev_probe,
> > > > +	.remove = rpmsg_chrdev_remove,
> > > > +	.id_table = rpmsg_chrdev_id_table,
> > > > +	.drv = {
> > > > +		.name = "rpmsg_chrdev",
> > > > +	},
> > > > +};
> > > 
> > > The sole purpose of doing this is to create instances of rpmsg_chrdevs from the
> > > name service - but is it really needed?  Up to now and aside from GLINK and SMD,
> > > there asn't been other users of it so I'm wondering if it is worth going through
> > > all this trouble.
> > 
> > It is a good point.
> > 
> > Just as a reminder, the need of ST and, I assume, some other companies, is to
> > have a basic/generic communication channel to control a remote processor
> > application.
> > 
> > Nothing generic exists today for a virtio transport based implementation.
> > Companies have to create their own driver.
> > 
> > The purpose of my work is to allow our customer to use RPMsg without developing
> > a specific driver to control remote applications.
> > 
> > The rpmsg_chrdev char is a good candidate for this. No protocol, just a simple
> > inter-processor link to send and receive data. The rpmsg_tty is another one.
> > 
> > Focusing on the rpmsg_chrdev:
> > We did a part of the work with the first patch set that would be in 5.13.
> > But is it simple to use it for virtio transport based platforms?
> > If we don't implement the NS announcement support in rpmsg_chrdev, using
> > rpmsg_chrdev for a user application seems rather tricky.
> > How to instantiate the communication?
> > The application will probably has to scan the /sys/bus/rpmsg/devices/ folder to
> > determine the services and associated remote address.
> > 
> > I don't think the QCOM drivers have the same problem because they seems to
> > initiate the communication and work directly with the RPMsg endpoints ( new
> > channel creation on endpoint creation) while Virtio works with the RPMsg channel.
> > 
> > By introducing the ability to instantiate rpmsg_chrdevs through the NS
> > announcement, we make this easy for applications to use.
> > 
> > And without rpmsg_chrdevs instantiation, It also means that we can't create an
> > RPMsg channel for the rpmsg_chrdevs using a new RPMSG_CREATE_DEV_IOCTL control,
> > right?
> > 
> > That said, If we consider that the aim was only to extract the rpmsg_ctrl part,
> > I'm not against leaving the rpmsg_char in this state and switching to the
> > rpmsg_tty driver upstream including the work on the rpmsg_ctrl to create rpmsg
> > channels.
> > 
> > We could come back on this if requested by someone else.
> 
> I'm personnaly following this thread, our project is to be able to do RPC call
> from Linux to an RTOS (Zephyr). Our plan is to do that in userspace using the nameservice
> announcement from virtio/rpmsg.

Good to know.  I highly encourage you to review patches and provide comments -
that will be very helpful to us.

Thanks,
Mathieu

> 
> We did an hackish patch to do that internally:
> https://github.com/iotbzh/meta-rcar-zephyr/blob/master/recipes-kernel/linux/linux-renesas/0001-Add-device-driver-for-rcar-r7-
> rpmsg.patch
> 
> That we will be really happy to drop by any cleaner solution.
> 
> Thanks for your work !
> Julien
