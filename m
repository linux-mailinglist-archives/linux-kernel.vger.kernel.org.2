Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD33454DC6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 20:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240430AbhKQTVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 14:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbhKQTVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 14:21:34 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFB9C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 11:18:35 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id h12-20020a056830034c00b0055c8458126fso6609577ote.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 11:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+YfvWYF4IZNyi2lEdYo/x4crg0+4q5Jc7gRQzkjs7k8=;
        b=erf7gllQwdMyp93yUZ/0DXdC+ZCXcDt1pvLdG8QQA8OkmbuQlsa+GRVQdiALOJk2ug
         ztBu9ze05N2P7/EwaqZQ+mO3/SxriSUAnm/ZQQx4WTMshV/ObIRIFMlCTCf36LGvyxgQ
         cKpSBJ3VCCydRibj8h/kqdh80WgtL0PC+ncyKesX/vWBh84yQuG9VPTpVWsVnWofuPl5
         DHwvRwfxVkTKtAng8fXMUnt8fM37iVo0n+O77IwN3VM8PAxH7NNOw1OJuu1khqPgP3h3
         FrnN/+b1EGQ9QxHwzjWYu7grMW5mG7bG49FqMpkkpDhQd/927svkJabiwxeEaUV+tLh0
         rSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+YfvWYF4IZNyi2lEdYo/x4crg0+4q5Jc7gRQzkjs7k8=;
        b=2au0ME53uw+6sI0Guw+ylsbetfxAQOcTcOA7EpdPAgDUiGeXdKufaaU1floFu6MDd+
         pay/EupJ/9UZXHezs9U/E+vep9pfGKEqx2ID38HUiK0PAZdYSgjSv7Wq1+WbLkYxPais
         vSXhmoOYD6IWRWMl1B6hjib2wLB7cMYksZRoCPemEUTTiesfj83vhrsUprY6RnyAX7i8
         9NAqJK43hogYy8gcrSDrnzkDixr+lnRUKpLP8J+XwyA7V46RY+VswEVsGWueU1+/j7to
         LQPEKWFSI9bAKXvMtrPLRf6+a1PK8I/p/EzAavMJiF8ADZ8p2C9iWnzGX53vAWoj1KJ1
         L2ZQ==
X-Gm-Message-State: AOAM5336SNsey4wwPwCCr7stsFsLOHbpTtDk4z5SuYQ+hPRf+4LxdIt0
        JnU+fYOHEx4nMKTkxqxAobD7qA==
X-Google-Smtp-Source: ABdhPJzxgPJpTVefnVmswHdZ2n5gfIfQ+YLNf6rduqFUd9mEGABGPz0iB7SjeUvqxq5df4vI3zdHTQ==
X-Received: by 2002:a9d:6854:: with SMTP id c20mr16240865oto.190.1637176714583;
        Wed, 17 Nov 2021 11:18:34 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n189sm142549oif.33.2021.11.17.11.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 11:18:34 -0800 (PST)
Date:   Wed, 17 Nov 2021 11:20:23 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Russ Weight <russell.h.weight@intel.com>, sudeep.holla@arm.com,
        cristian.marussi@arm.com, ardb@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com, "Gong, Richard" <richard.gong@intel.com>
Subject: Re: [RFC PATCH 0/5] Firmware Upload Framework
Message-ID: <YZVV98XoiI3NQHQ1@ripper>
References: <20211111011345.25049-1-russell.h.weight@intel.com>
 <8b7bbdcd-ef48-9f48-10c0-021c41575522@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b7bbdcd-ef48-9f48-10c0-021c41575522@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 15 Nov 05:57 PST 2021, Tom Rix wrote:

> 
> On 11/10/21 5:13 PM, Russ Weight wrote:
> > The Firmware Upload framework provides a common API for uploading firmware
> > files to target devices. An example use case involves FPGA devices that
> > load FPGA, Card BMC, and firmware images from FLASH when the card boots.
> > Users need the ability to update these firmware images while the card is
> > in use.
> > 
> > Device drivers that instantiate the Firmware Upload class driver will
> > interact with the target device to transfer and authenticate the firmware
> > data. Uploads are performed in the context of a kernel worker thread in
> > order to facilitate progress indicators during lengthy uploads.
> > 
> > This driver was previously submitted in the context of the FPGA sub-
> > system as the "FPGA Image Load Framework", but the framework is generic
> > enough to support other devices as well. The previous submission of this
> > patch-set can be viewed here:
> > 
> > https://marc.info/?l=linux-kernel&m=163295640216820&w=2
> > 
> > The n3000bmc-sec-update driver is the first driver to use the Firmware
> > Upload API. A recent version of these patches can be viewed here:
> > 
> > https://marc.info/?l=linux-kernel&m=163295697217095&w=2
> > 
> > I don't think I am duplicating any functionality that is currently covered
> > in the firmware subsystem. I appreciate your feedback on these patches.
> 
> This may be a common api for fpga/dfl-, but it is not likely common for
> general devices.
> 

During my years of hacking on device drivers I've run into the need for
being able to reflash/update firmware in things such as touchscreen
controllers, hdmi bridges, usb network devices and (embedded) usb hubs.

The implementation typically manifest itself as some sysfs or debugfs
knob which when written triggers a request_firmware() followed by the
operation to write the content to flash. But the result is often quite
hacky and requires that you store the firmware-to-be-written in some
path that will be looked at by request_firmware() - and hence these
patches often doesn't end up upstream.

So I'm certainly in favor of some generic way for drivers to expose an
interface for userspace to flash new firmware to their associated
hardware.

Regards,
Bjorn

> Could the scope of this patchset be reduced to just fpga/dfl for now ?
> 
> Something more like stratix10-rsu.
> 
> Tom
> 
> > 
> > - Russ
> > 
> > Russ Weight (5):
> >    firmware: Create firmware upload framework
> >    firmware: upload: Enable firmware uploads
> >    firmware: upload: Signal eventfd when complete
> >    firmware: upload: Add status ioctl
> >    firmware: upload: Enable cancel of firmware upload
> > 
> >   .../driver-api/firmware/firmware-upload.rst   |  54 +++
> >   Documentation/driver-api/firmware/index.rst   |   1 +
> >   MAINTAINERS                                   |   9 +
> >   drivers/firmware/Kconfig                      |   8 +
> >   drivers/firmware/Makefile                     |   1 +
> >   drivers/firmware/firmware-upload.c            | 413 ++++++++++++++++++
> >   include/linux/firmware/firmware-upload.h      |  69 +++
> >   include/uapi/linux/firmware-upload.h          |  73 ++++
> >   8 files changed, 628 insertions(+)
> >   create mode 100644 Documentation/driver-api/firmware/firmware-upload.rst
> >   create mode 100644 drivers/firmware/firmware-upload.c
> >   create mode 100644 include/linux/firmware/firmware-upload.h
> >   create mode 100644 include/uapi/linux/firmware-upload.h
> > 
> 
