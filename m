Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D7E324128
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbhBXPnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbhBXPWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 10:22:08 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5761DC06174A;
        Wed, 24 Feb 2021 07:21:25 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id s8so2999417edd.5;
        Wed, 24 Feb 2021 07:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XLYDyAsA5UUZQt9Fovct9QetXnZJ6EON0SAynzEMdE0=;
        b=TEk6zj0ZKSOENCRiJumILsizH4xt5iHOkT5+P7sGwbi4i8XqrNklBwYQOpu4ggsZjN
         BbImWPDVUNSdzz+kAbfioZazKTaC3ByapAdufUS1DjMCf/pUoOaALu+B0BsZhCaMWRR2
         HKdlI6U+s3QJTp3Jsyg4rkdttWIiLOjrdL6VRxxyALE29EPYQCve1fayGyKNtQw7cx3q
         orqy4gR9JfsJNNw0bqnfTdTxJ6x6rn22kT+aeQXqxELvARCGu+VmjUINDw/qpO0lOwtp
         beVHqRYB0Y7BD5ehPJg268c2er7riQujpgn/guq2q2sY52LIKyO4PVCUGS77GFql1Fqv
         SqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLYDyAsA5UUZQt9Fovct9QetXnZJ6EON0SAynzEMdE0=;
        b=X0hIh74gzN4hTTAdSG3bgxzp1MZHpiqUtS5sGRy9sf8X3J3yUeRsDKMkcqoT7wP2IC
         se9vIjScpBk7N/em0VARrCFvMER8gIH0XrrOf8M9mw6OrpSVAl4wRcv6CotnVHgtlc+y
         bWOXZvu9E4LHtNcOUu0oEFq/g+ztmnZBcvZaIj6QWLjKTyAKO0KJwFkaTqFduXuFxFAM
         b8cmmKv2pWVFWUleT3AzqWjZVsgLB//QUSQc8gdiD0555mnVgAtPDvOpP+YHlAvec2l3
         4n7PNR4IaMScLGuve7AujXW+8ofEl1yWFLGHvDJkKm1gJeknvakLPp6MLqS2EYRPYvqu
         GmVA==
X-Gm-Message-State: AOAM532dwPiA9q+bEb9OQjeb3gB65glrCqPDH3dm4M9qGWYSRZWwTZvj
        Fw+yAN2kaWCAl5cXV+yxdJ8eNMcboGAL6f1yfTs=
X-Google-Smtp-Source: ABdhPJwVd4KUvTK7Qd8oZspTB1wgzkrXb9nE+BFniIE+ByTQWhinjzN8fjZfnMLBsmmeVs1ki88Up8MMElmmftm4XDA=
X-Received: by 2002:a05:6402:270d:: with SMTP id y13mr33669546edd.149.1614180084062;
 Wed, 24 Feb 2021 07:21:24 -0800 (PST)
MIME-Version: 1.0
References: <CAH+2xPCmZNW0ct8XoBmAnd0QK53guv2e4HLn40NvWrEA7pj3qw@mail.gmail.com>
 <CAH+2xPCkKRhXJSqMx7kzsO53JwXbrmYPLLL-_ANO9waNJREDWA@mail.gmail.com> <777991bb72f8842e3e730f9b600b2086478f5d36.camel@suse.com>
In-Reply-To: <777991bb72f8842e3e730f9b600b2086478f5d36.camel@suse.com>
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Wed, 24 Feb 2021 16:21:08 +0100
Message-ID: <CAH+2xPAB4bWN9NiTQr4WggUX6eDXzMikzYJySx3sAj3Ho3AdxA@mail.gmail.com>
Subject: Re: usb: cdc-acm: BUG kmalloc-128 Poison overwritten
To:     Oliver Neukum <oneukum@suse.com>
Cc:     linux-usb@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Bruno Thomsen <bth@kamstrup.com>,
        Lars Alex Pedersen <laa@kamstrup.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den man. 22. feb. 2021 kl. 10.36 skrev Oliver Neukum <oneukum@suse.com>:
>
> Am Donnerstag, den 18.02.2021, 16:52 +0100 schrieb Bruno Thomsen:
> > Den fre. 12. feb. 2021 kl. 16.33 skrev Bruno Thomsen <bruno.thomsen@gmail.com>:
> > > Hi,
> > >
> > > I have been experience random kernel oops in the cdc-acm driver on
> > > imx7 (arm arch). Normally it happens during the first 1-3min runtime
> > > after power-on. Below oops is from 5.8.17 mainline kernel with an
> > > extra patch back-ported in an attempt to fix it:
> > > 38203b8385 ("usb: cdc-acm: fix cooldown mechanism")
> >
> > I can now boot board with 5.11 kernel without any extra patches and
> > it produce similar issue. Hopefully that make the oops more useful.
> > Issue has been seen on multiple devices, so I don't think it's a bad
> > hardware issue.
>
> is this a regression from 5.10?

Hi Oliver

No, this is not a regression from 5.10. It seems that many attempts to
fix cdc-acm in the 5.x kernel series have failed to fix the root cause of
these oops. I have not seen this on 4.14 and 4.19, but I have observed
it on at least 5.3 and newer kernels in slight variations.
I guess this is because cdc-acm is very common in the embedded
ARM world and rarely used on servers or laptops. Combined with
ARM devices still commonly use 4.x LTS kernels. Not sure if
hardening options on the kernel has increased change of reproducing
oops.

I am ready to test new patches and will continue to report oops

/Bruno
