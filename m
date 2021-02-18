Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9765E31EF13
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 19:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbhBRS61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 13:58:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:39048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233348AbhBRRLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 12:11:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEE4A60230
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 17:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613668264;
        bh=RV2hABDdoHPmTI0yk3PA6j+sQ8ooG6Zveggz914ksQc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aqfkE+vnY72FvNT26bwpFws69Sgbnc3THwyJShF5zgGOmZ1AxjXfKA/yUn94zJVWP
         JkGFjlmU0vsrvDwBX08lNKbA+0/TWUgaBuHyTcfgF3wtjFF4IbYg3lWsmkW9NBV5Gi
         HVjJxznxib6R2cr33pv3QLndFKe09aDOxidSLojq0lAVCjwuzrZykI/0TrWPv2favl
         vlpqzcGVODN0RgZjD6NHEr0Djznxjk0SfmhFysLnXj3pN1FDja/eFieFXrlzbny8OZ
         z2BnPSHmqObgDnWRyC61y6oexnCJnFysoONcdOsTw9FEkgPcg7XHB3AR3jPoxld2ZJ
         uVeH+JnommlsQ==
Received: by mail-oo1-f45.google.com with SMTP id y21so593005oou.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 09:11:04 -0800 (PST)
X-Gm-Message-State: AOAM531epqgSQff476DYig4SSDbPIoHvRTtVqz7dU9MngR32yt6ivkqK
        BxiExmaQ64N49KcwYz9RT1cqJoxZJEWocOld9B4=
X-Google-Smtp-Source: ABdhPJz8VRVCKvefO1jPsDKa4MFdmrN50u9t1R6eTFJ5dhrMXI94Qd70DLHRPSk+UkR1C91U9eJLLX0bkfG34EH8cCw=
X-Received: by 2002:a4a:870c:: with SMTP id z12mr3736151ooh.15.1613668264033;
 Thu, 18 Feb 2021 09:11:04 -0800 (PST)
MIME-Version: 1.0
References: <20210218091015.92467-1-pritthijit.nath@icloud.com> <YC41yC7+TYXaD/R+@kroah.com>
In-Reply-To: <YC41yC7+TYXaD/R+@kroah.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 18 Feb 2021 18:10:48 +0100
X-Gmail-Original-Message-ID: <CAK8P3a09TXVwZYz+ohU1uJh5XvEJ=aHqUq+hs2K-4nvppbTPSA@mail.gmail.com>
Message-ID: <CAK8P3a09TXVwZYz+ohU1uJh5XvEJ=aHqUq+hs2K-4nvppbTPSA@mail.gmail.com>
Subject: Re: [PATCH] staging: vc04_services: Fixed address type mismatch in vchiq_arm.c
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Pritthijit Nath <pritthijit.nath@icloud.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Amarjargal Gundjalam <amarjargal16@gmail.com>,
        Phil Elwell <phil@raspberrypi.com>,
        driverdevel <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 10:39 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Feb 18, 2021 at 02:40:15PM +0530, Pritthijit Nath wrote:
> > This change fixes a sparse address type mismatch warning "incorrect type
> > in assignment (different address spaces)".
> >
> > Signed-off-by: Pritthijit Nath <pritthijit.nath@icloud.com>
> > ---
> >  .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c   | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > index 59e45dc03a97..3c715b926a57 100644
> > --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > @@ -1214,11 +1214,7 @@ static int vchiq_ioc_await_completion(struct vchiq_instance *instance,
> >                   !instance->use_close_delivered)
> >                       unlock_service(service);
> >
> > -             /*
> > -              * FIXME: address space mismatch, does bulk_userdata
> > -              * actually point to user or kernel memory?
> > -              */
> > -             user_completion.bulk_userdata = completion->bulk_userdata;
> > +             user_completion.bulk_userdata = (void __user *)completion->bulk_userdata;
>
> So, this pointer really is user memory?
>
> How did you determine that?
>
> If so, why isn't this a __user * in the first place?
>
> You can't just paper over the FIXME by doing a cast without doing the
> real work here, otherwise someone wouldn't have written the FIXME :)

Agreed. I added the FIXME as part of a cleanup work I did last year.
The obvious step is to mark the corresponding field in
vchiq_completion_data_kernel as a __user pointer, and then check
all assignments *to* that members to ensure they all refer to __user
pointers as well.

At some point I gave up here, as far as I recall there were certain
assignments that were clearly kernel data, in particular the
vchiq_service_params_kernel->callback() argument seems to
sometimes come from kmalloc() and must not be passed down
to user space.

The alternative would be to look at the user space side to figure
out how the returned data is actually used. If user space doesn't
rely on it, it can simply get set to NULL, and if it does use it,
then the question is which code path in the kernel correctly
assigns it.

        Arnd
