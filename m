Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF8D3A872B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhFORNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhFORNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:13:00 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C56AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 10:10:56 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g6so13766835pfq.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 10:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zKJQyijpS69Rxl64xPTkkstp4VcPIdfRNd5pgKCxk+A=;
        b=QExr49okHCo3huVcYOyHJnD6FOijKaXYI4oYEBcTkGw5E5j2K5Je+KWgUWtL9PPpHw
         v6wwF8aNeWYvPfupTXu0VQ8a5ECpIGdQTEutFS0HzIUzfMPQvuNDbO9S8YSJQD+iXBf0
         HcLPjyVli49o51ldcoxFYhWusFUPiAvrjpehYo837w17TDwYNeQkcrN3l9fJjHym79wH
         /dZ/CZoc+XyGLaWcTWBG752E3nAxUdnrDEm7uzBlcmwSd+EWupDApCaTpDNBN4W3Fs01
         ei1ulvtHBxpRheWth8xbAZcoLwP+1MfX5Ne+EN7hoK8wI0o67FBrtAy2vixnQ84zKtNk
         wHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zKJQyijpS69Rxl64xPTkkstp4VcPIdfRNd5pgKCxk+A=;
        b=PiLfY8U+PEzqT2GmiENpJi/v7mtJOifeDmFbI4STHWNNIpV2KELBkaqIJFGxqQ/0i2
         AKW58QXqzsWNf4tOnGg+CByHD9eN0cRCfqqfrZ/cBHrZwSHqu8Dv5T0wGWEqy54vD19F
         ZoT+4J0/9Y1WTJT+c3rZXwC2HVyxfB16muRMZ3lD392BYqGdblSc9uJxPfeR6qPF64M7
         TAmL4uM7B3Ij7/EjY3EGLq7OmJW/80qgTm8ktDF1CpNfHwQ6vBZCtUoTQgyGP8fAqmEy
         O8r0NKyVllo/Sp0/E9niN/kFnlyEby0BPZ0ErBHvkRqxjGFPeny/wi473Nyk3kgKiKQ5
         IWGQ==
X-Gm-Message-State: AOAM531HNLolfBaS1hnwSYmste2SxBXALMd/ZBfwPRGbXxjXtH2beIDc
        RQOd+AIkir2VXFXBgUil4ak=
X-Google-Smtp-Source: ABdhPJyeYKICbSh/vgHIDdreMAji0SNMHCH87WrlAt7aAk35Y1+Tup9ZGNi8g0XWnS46j7lcqkEmVg==
X-Received: by 2002:a62:7ccd:0:b029:2be:1466:5a28 with SMTP id x196-20020a627ccd0000b02902be14665a28mr5283027pfc.55.1623777055607;
        Tue, 15 Jun 2021 10:10:55 -0700 (PDT)
Received: from ojas ([182.69.244.244])
        by smtp.gmail.com with ESMTPSA id q3sm15443215pfj.89.2021.06.15.10.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 10:10:55 -0700 (PDT)
Date:   Tue, 15 Jun 2021 22:40:42 +0530
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     nsaenz@kernel.org, gregkh@linuxfoundation.org,
        dan.carpenter@oracle.com, phil@raspberrypi.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] Request to review progress decoupling vchiq platform
 code
Message-ID: <20210615171042.GA78787@ojas>
References: <cover.1623698773.git.ojaswin98@gmail.com>
 <2212368e-b597-b717-0d21-70b24322ca09@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2212368e-b597-b717-0d21-70b24322ca09@i2se.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 12:06:14AM +0200, Stefan Wahren wrote:
Hello,

> Hi,
> 
> Am 14.06.21 um 21:32 schrieb Ojaswin Mujoo:
> > Greetings,
> >
> > I'm working on addressing item 10 of the following TODO list:
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
> >
> > This patch is the first step towards decoupling the platform and the cdev code.
> > It moves all the cdev related code from vchiq_arm.c to vchiq_dev.c. However, for
> > now, I have aimed to keep the functionality untouched, hence the platform code
> > still calls the cdev initialisation function, and isn't truly decoupled yet.
> >
> > The summary of the changes is as follows:
> >
> >
> >  *  Definition of functions and variables shared by cdev and platform
> >     code are moved to vchiq_arm.h while declaration stays in vchiq_arm.c
> >
> >  *  Declaration and definition of functions and variables only used by
> >     cdev code are moved to vchiq_dev.c file.
> >
> >  *  Defined vchiq_deregister_chrdev() and vchiq_register_chrdev(..) in
> >     vchiq_dev.c which handle cdev creation and deletion. They are called by the
> >     platfrom code during probe().
> looks like this should be 3 separate patches. So you have the pure move
> at the end.

Got it, I'll split this into 3 commits:
1. Moving cdev code to a separate function
2. Moving to-be-shared declarations to vchiq_arm.h
3. Finally, moving cdev related code to vchiq_dev.c
> >
> >
> > I mainly wanted to put this patch out to see if I have the right idea of the
> > task at hand and to ensure I'm heading into the right direction. I would love to
> > hear your thoughts and suggestions on this. Once I have some feedback on this, I
> > can accordingly work towards a newer version to completely decouple the code. 
> >
> > Lastly, I had some questions related to the the task: 
> >
> > 1. So regarding the following line in the TODO:
> >
> >     "For instance to be able to use bcm2835-audio without having /dev/vchiq
> >     created." 
> >
> >   I was wondering about the possible ways to achieve this. Specifically, I was
> >   thinking of the following 2 ways:
> >
> >   1.1  Making a KConfig entry for Cdev creation, like CONFIG_VCHIQ_CDEV, and
> >        then do something like:
> >
> >          vchiq_probe(..) 
> >          {
> >            /* platform init code */
> >
> >            #if defined(CONFIG_VCHIQ_CDEV)
> >
> >            /* Call cdev register function */
> >
> >            #endif 
> >          }
> A common pattern is to keep the calls, but have "empty" definitions of
> the those functions in the header file in case CONFIG_VCHIQ_CDEV is not
> defined.
Ahh okay, I'll try to do that.
> >
> >   1.2  The second approach is creating an entirely separate module for the cdev,
> >        as suggested in the TODO. 
> >
> >   So I'm just wondering what the right approach should be?
> >
> > 2. Second, I currently tested by installing my patches to a pi3 B+ and running
> >    `cat /dev/vchiq` to compare the output with the original kernel.  Also, to
> >    see if the platform code works without the cdev code, I commented out the
> >    call to vchiq_register_cdev() and made sure the platform device (and
> >    children) was registered but the char device was not present. However, I'm
> >    not sure if these tests are comprehensive enough. What would be the right way
> >    to test my changes?
> 
> Sounds okay, but a functional test is still necessary (tool is provided
> by Raspberry Pi OS):
> 
> vchiq_test -f 10
> vchiq_test -p 10

Perfect, this was what I was looking for, thank you! 
> 
> Regards
> Stefan
> 
> 

I believe, after splitting the patch, the next logical steps would be 

1. Create a patch for adding CONFIG_VCHIQ_CDEV, but not splitting
   modules yet
2. After this, add a final patch to move cdev into it's own module
3. test test test

I can play around with this and see how it goes. Thanks again for the
help Stefan!

Regards,
Ojas
