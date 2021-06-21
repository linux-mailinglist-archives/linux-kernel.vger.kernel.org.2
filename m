Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4033AEAE0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 16:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFUOOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 10:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhFUOO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 10:14:27 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888E7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 07:12:10 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x16so13712390pfa.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 07:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+lczONSEvVNXxTnKGlZ6DC6sW4u/mKkInGnG8PkkewE=;
        b=fDtP+6Lv72v+KUKRZF6ITEMx7YgZdz5GzuXEaCasH4Mc5kHzDZOHfSCGdINiCBZ8+2
         wDAxz9is91YUTNKB1qHpKfL34osSiCkY+sOB1zAK2CfvzNYUe9iCMuH8aZT3Ampj1/hr
         zKoE5ecI8dHVoTvDFuLetbJjBPcBP8Hs4bhUmavSi0eLwBVWlMNtvGRfT2QDePz9HGKk
         c9f56LbUxQyfatPlaV25hpVpjTl3dpqNsO2bKShMHxWMHBzpDNM3kmOsLuweX8cfeVbs
         crmXKvB93+x3xSCOraFjADBHbSaDFGFukoT7wzvsXpUGVqqGApfXrZShyhVogx6JxTB6
         thWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+lczONSEvVNXxTnKGlZ6DC6sW4u/mKkInGnG8PkkewE=;
        b=qOM68dd1jWtWSpNyOycgdbL4EerwDtl6cEV85FeAM7mcUwgBd+ErFCzFuxcWefgcTW
         y/7FAQ2q5zrZWUH7ytCBwfY5E9xU3m9jqT9lD1V+tusvv3Z7xr/S0J863GrYXR02jMPl
         2HCegw4Vnlwv8x0EEDwpXsfPjERNJycrOXkweVwxBoXDGvdcXfan/E2fq2gf86VS8vPE
         Pan01VuKF/eKqZ+8FLR3ghJrL9Q6CWm6yXEQBWMjze/FpNwbRblwSJXDOjyWDVqMaUXR
         t5kT8Bjotbqnvvnu3q469bKNT9jFUMf0dGd6UU9Q8h2BJt24Krcb4hO7reQXtQldxAES
         ZWRQ==
X-Gm-Message-State: AOAM531W8vM/DDx8pGsH7ji+KEQvVepLtcpoD/Kh4GHD0+ujHV7Myb8U
        h9CnervUMplCfzotllXBxC4=
X-Google-Smtp-Source: ABdhPJzK4d4g2YguCgFh6tGV4hkJGxu/weQiFZoNb5Z72fTuKTCnrB5KyQ1cuFTaK988kk+IhmbtjA==
X-Received: by 2002:aa7:8587:0:b029:2f8:8439:c265 with SMTP id w7-20020aa785870000b02902f88439c265mr19697773pfn.38.1624284730037;
        Mon, 21 Jun 2021 07:12:10 -0700 (PDT)
Received: from ojas ([122.177.154.120])
        by smtp.gmail.com with ESMTPSA id k6sm15244288pfa.215.2021.06.21.07.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 07:12:09 -0700 (PDT)
Date:   Mon, 21 Jun 2021 19:41:58 +0530
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     nsaenz@kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de,
        dan.carpenter@oracle.com, phil@raspberrypi.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] vchiq: Patch to separate platform and cdev code
Message-ID: <20210621141158.GA186639@ojas>
References: <cover.1624185152.git.ojaswin98@gmail.com>
 <edd6f6ad-f06f-5871-a3bb-da18e114c135@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edd6f6ad-f06f-5871-a3bb-da18e114c135@i2se.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2021 at 03:28:43PM +0200, Stefan Wahren wrote:
Hello Stefan!

> Hi Ojaswin,
> 
> Am 20.06.21 um 14:55 schrieb Ojaswin Mujoo:
> > Hello,
> >
> > This patchset adderesses the TODO item number 10 specified at:
> >
> >     drivers/staging/vc04-services/interface/TODO
> >
> > For reference, the task is:
> >
> >     10) Reorganize file structure: Move char driver to it's own file and join
> >     both platform files
> >
> >     The cdev is defined alongside with the platform code in vchiq_arm.c. It
> >     would be nice to completely decouple it from the actual core code. For
> >     instance to be able to use bcm2835-audio without having /dev/vchiq created.
> >     One could argue it's better for security reasons or general cleanliness. It
> >     could even be interesting to create two different kernel modules, something
> >     the likes of vchiq-core.ko and vchiq-dev.ko. This would also ease the
> >     upstreaming process.
> >
> > As Stefan suggested in the last revision, I have split the commits into
> > more finer parts for ease of readability and maintainability. I have
> > also added 2 more patches to define a KConfig entry for vchiq cdev, and
> > to merge the code in vchiq_2835_arm.c to vchiq_arm.c
> >
> > A summary of the patches is now as follows:
> >
> > - Patch 1: Move cdev init code into a function
> > - Patch 2: Shift some devlarations from vchiq_arm.c to vchiq_arm.h for
> >            sharing
> > - Patch 3: Move vchiq cdev init code from vchiq_arm.c into vchiq_dev.c
> > - Patch 4: Decouple cdev code by defining a Kconfig entry to allow
> >            optional compilation of it.
> > - Patch 5: Merge code in vchiq_2835_arm.c to vchiq_arm.c
> >
> > (More details can be found in the commit messages)
> >
> >
> > NOTE:  This patchset is built against the raspberry pi mainline kernel at
> > https://github.com/raspberrypi/linux/blob/rpi-5.10.y, and has been
> > tested on Raspberry Pi 3B+
> please don't do this, because it's a waste of time. Greg can only apply
> patches against the mainline kernel and the patches must be tested with
> the mainline kernel. Additionally i've sent a lot of patches recently
> which are not applied against the vendor tree.
Understood Stefan, I'll keep that in mind going forward.
> >
> > At this point, I have some questions and ideas and would like to hear your
> > thoughts and suggestions on them:
> >
> > 1. So as mentioned, I have built this against the raspberry pi kernel,
> >    since I was not able to figure out a way to build the vanilla
> >    mainline kernel for Raspberry Pi. However, I understand that since
> >    this will be applied to the mainline, I need to make sure it is
> >    consistent with it.  
> 
> Can you please describe the issue in detail?
> 
> Or try this older guide [1]
Thanks for the guide, I tried this out (along with some other things) but 
I'm not able to get the Pi to boot. I'm using a headless setup with
Wifi+SSH, due to lack of hardware, and I'm not able to SSH/ping when using
mainline. This works correctly with the downstream kernel + Raspbian.
(Maybe because of missing drivers and/or config options).

I'm still looking into this but a I'm a bit in the dark till I can get my
hands on a UART to USB cable although they are difficult to get
around here. I'm also trying to maybe figure out if I can somehow use my
Arduino to capture the serial output. 

May I ask what setup you are using for kernel development on pi? 
> 
> Best regards
> Stefan Wahren
> 
> [1] - https://gist.github.com/lategoodbye/c7317a42bf7f9c07f5a91baed8c68f75
> 
Thank you again for the help!
Ojaswin
> >
> >    Hence to confirm that, I tried to "git am" this patchset to the
> >    mainline kernel but there are some merge conflicts in doing so. I
> >    have an idea how to resolve most of them except the following:
> >
> >     - The mainline vchiq_arm.c differs from the one in rapberry pi
> >       mainline which caused conflict in Patch 3.
> >
> >    I'm not sure which vchiq_arm.c to treat as the base for my patches.
> >    The one in mainline? or the one in raspberry pi's git tree?
> >
> >
> > 2. This question is more related to the next set of patches I'm
> >    planning to submit. So the last thing left in this TODO is to
> >    completely decouple vchiq platform and cdev code into 2 separate
> >    modules and I am planning to do that in a different patchset. 
> >
> >    The approach I have in mind is to start by using EXPORT_SYMBOL to
> >    export all the functions (and accessor functions for variables like
> >    g_state) that would be required for cdev init. Majority of these
> >    would be exported from vchiq_arm.c and vchiq_core.c, and will then be
> >    used in vchiq-dev.ko. Is this the right way to approach this? 
> >
> > Thank you in advance for looking into this and best regards!
> > Ojaswin
> >
> >
> > Ojaswin Mujoo (5):
> >   staging: vchiq: Refactor vchiq cdev code
> >   staging: vchiq: Move certain declarations to vchiq_arm.h
> >   staging: vchiq: Move vchiq char driver to its own file
> >   staging: vchiq: Make creation of vchiq cdev optional
> >   staging: vchiq: Combine vchiq platform code into single file
> >
> >  arch/arm/configs/bcm2709_defconfig            |    1 +
> >  arch/arm/configs/bcm2711_defconfig            |    1 +
> >  arch/arm/configs/bcmrpi_defconfig             |    1 +
> >  drivers/staging/vc04_services/Kconfig         |   10 +
> >  drivers/staging/vc04_services/Makefile        |    5 +-
> >  .../interface/vchiq_arm/vchiq_2835_arm.c      |  651 -----
> >  .../interface/vchiq_arm/vchiq_arm.c           | 2477 ++++++-----------
> >  .../interface/vchiq_arm/vchiq_arm.h           |   79 +
> >  .../interface/vchiq_arm/vchiq_dev.c           | 1488 ++++++++++
> >  9 files changed, 2402 insertions(+), 2311 deletions(-)
> >  delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
> >  create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> >
> 
