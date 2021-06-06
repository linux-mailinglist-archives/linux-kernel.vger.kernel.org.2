Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3F839CE67
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 11:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFFJ3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 05:29:37 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:39640 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhFFJ3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 05:29:36 -0400
Received: by mail-pj1-f52.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so10031415pjp.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 02:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9hJszFq4lHbv1ND+qGe92RXy6gvvhI7dS9USahuU+98=;
        b=Vt3+cyZRJXGj6xpBlOINayeqRQyPymvqKkEkTi8r2G35aqYVZ5kDrQ9wz76UPIKp1O
         J/GUI71fJWta4TBwyCyzp1772WWL+Jc4O79foJqWuLVazVO6UUCvPhwIzHmkKXsd5rtu
         cQlEr/WOLcKrOLrd9pySXBySDSwgLRqI0bMVfUO1WnSkau36v/duvOfIkU7KbAlAawkw
         6yrPADea992BdvvmISJxGS3Tq8RbTCc/+Xoe9GHqB+2wYT8aCGV8uuRZX0kwHw8C9vO/
         QnfCJ4ohQ42XkUqnhwtPKT2tFtyQLH22o32nvPbtQ/pL4WuE8+fXteX2xvPyfELGzElv
         yVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9hJszFq4lHbv1ND+qGe92RXy6gvvhI7dS9USahuU+98=;
        b=HfDAJbok5VYQBLDD2jVow4vwz7P8XNAm9SBq9F6yZPpsBQJtQ6VqyUYTvMQJdQQJjc
         R/pnYMHw4mCGy3I3s8wwl4+U1am/ZQ9O68jE6a4wBvRBbmcaOr6mda77XRLFKn9ltoLT
         2dgDaaaemuOeFk+l52ABvb742ZtgqyI7xvf+A2jRPU99L6Ci+D6SMJ0cr0q0vseeCdEI
         XOQku8D80Gi8nHwARwQpKdjVmLmEjr2Z9mWU8g8YlY5s+okmvu3vKYylEMzzxA9XdwwW
         I/CP1Sgyh4ceCg4BZ4L+4tJhrmEfDbzwmdcDb0y8jl9rveUwcH6gwLJtV0It1qCOfG0O
         JC/A==
X-Gm-Message-State: AOAM533tKBsh7xdKCNs1PNi0akGObnXFAnPj/HgSGCaErOvqf03rWhiE
        QeSZPMXKOqpOQXt+x7Q5yK8=
X-Google-Smtp-Source: ABdhPJzRFNHBngQCYf1/triH9Yxq3zROcJpdkjGA9Iwn69RR5HN2xm2Uw5zFqa1dC0DF99WdlmRoMA==
X-Received: by 2002:a17:90a:be0b:: with SMTP id a11mr13647302pjs.197.1622971606863;
        Sun, 06 Jun 2021 02:26:46 -0700 (PDT)
Received: from ojas ([2405:204:130d:e843:24e:5eab:4be9:d84d])
        by smtp.gmail.com with ESMTPSA id gn4sm9047526pjb.16.2021.06.06.02.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 02:26:46 -0700 (PDT)
Date:   Sun, 6 Jun 2021 14:56:32 +0530
From:   Ojaswin Mujoo <ojaswin98@gmail.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, nsaenz@kernel.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, phil@raspberrypi.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: staging: vc04_services: Need suggestions on trying to fix sparse
 warning in vchiq_arm.c
Message-ID: <20210606092601.GA6609@ojas>
References: <20210601200513.GA10204@ojas>
 <20210601202307.GC1955@kadam>
 <20210602145000.GA3999@ojas>
 <9ba341f7-17fc-980d-a7a0-2293c75dcf92@i2se.com>
 <20210605072249.GA5967@ojas>
 <57aa6e2b-0267-664d-539a-e82000928101@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57aa6e2b-0267-664d-539a-e82000928101@i2se.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 05, 2021 at 10:41:17AM +0200, Stefan Wahren wrote:
> Hi Ojaswin,
> 
> Am 05.06.21 um 09:23 schrieb Ojaswin Mujoo:
> > On Fri, Jun 04, 2021 at 08:13:06AM +0200, Stefan Wahren wrote:
> >> Hi Ojaswin,
> >>
> >> Am 02.06.21 um 16:50 schrieb Ojaswin Mujoo:
> >>> On Tue, Jun 01, 2021 at 11:23:07PM +0300, Dan Carpenter wrote:
> >>>> The problem is not the Sparse warning, the problem is that this code is
> >>>> a mess.  It used to very clearly buggy and I reported the bug.  I think
> >>>> Arnd found the bug again independently and fixed it.
> >>>>
> >>>> A couple weeks ago Al Viro looked at this code.  Here is his write up:
> >>>>
> >>>> https://www.spinics.net/lists/kernel/msg3952745.html
> >>>>
> >>>> It shouldn't take Al Viro dozens of pages of detailed analysis to try
> >>>> figure out if the code is safe or not.  Your idea silences the warning
> >>>> but would make the code even more subtle and complicated.
> >>>>
> >>>> The right thing to do is to re-write the code to be simpler.
> >>>>
> >>>> regards,
> >>>> dan carpenter
> >>>>
> >>> Thank you for the prompt reply and the link, it was very insightful. You
> >>> are right, I was definitely going about this the wrong way and missing
> >>> the larger picture. I'll spend some time trying to understand this
> >>> codebase as I think that'd be a good start to understand how stuff works in
> >>> the kernel (even though some of the things in this driver are anti patterns)
> >>> and hopefully get some ideas on ways to clean this up.
> >>>
> >>> Anyways, thanks again for the help, cheers!
> >> thanks for your interest in cleaning this up. Yes, it's not clear which
> >> points on the TODO list are the lower hanging fruits. In case you don't
> >> want to fix checkpatch issues, maybe you can look at points 8, 9, 10, 12
> >> and 13. Most of them require testing with a Raspberry Pi, but feel free
> >> to ask if you have problems with it.
> >>
> >> Regards
> >> Stefan
> >>
> > Got it, Task 10 (cdev to its own file) seems like a pretty good task to
> > get started with. I'm planning to buy a Rpi 4 so I think I can run tests
> > on that. 
> 
> okay, but the AFAIK the vchiq driver in the mainline kernel doesn't work
> with Rpi 4 yet. The Raspberry Pi 3 B Plus is currently the recommend
> devel platform, so you can test 32 and 64 bit kernel.
> 
> Best regards
Hey Stefan,

Ahh got it. sure I can get a 3B+ instead, thanks for the heads up.
> 
> >
> > Thank you so much for the help, I'll get back incase I face any issues down 
> > the line.
> >
> > Regards,
> > Ojaswin
> >
> >>> Ojaswin
> >>>
> >>> _______________________________________________
> >>> linux-arm-kernel mailing list
> >>> linux-arm-kernel@lists.infradead.org
> >>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

Regards,
Ojaswin
