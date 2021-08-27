Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6EF3F9F00
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 20:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhH0Sjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 14:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhH0Sjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 14:39:36 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CFEC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 11:38:46 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x16so6429468pfh.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 11:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOesIXKJJNa1Sx9trMTD2opjFGNCOI1Wpfe81HUAjoE=;
        b=YpVCJry+9GD2TexMD6O2eplHAo/YaE7DPfyh8mgdDzkQ8gHMhZf3lYQ71p70L4v7fb
         6XVNiImuQvYdVR2oJXugvsACa6njRlLVZVxGNu6hV3p1LzQgZWFATIkyWMpJXu7vTlWm
         2jBDgNFTkcUb+UugMemndDrLn6cQrJiP8gTa6JiANWc/qwbOapTzNobXQfdT/NWSxewS
         lTpA8wMZsQ4QdNy4zLg5JlJLihsmszlw4FcsLRp9eVmzQ0LSl3D9xt4cqvfFaH+5Rn9E
         3lfdjkHioQjdZ9D/vTg5PtEwqXpdhiUdftdxY5nzZ6eWE542TBXQlfo+wQVnPKKVyhdB
         nbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOesIXKJJNa1Sx9trMTD2opjFGNCOI1Wpfe81HUAjoE=;
        b=a7h78nXA9AvffsaK39HGQR2pEtsDSsWkvqMzQR4eAXFfNy1Q3i7zoBbnfdargoCkYt
         rSwQ3m+8CLhaXLWTF2dWFi/cU7PF/yPhD8vnh66A0a+bIpBBUitlP/RYdsBxNlX8r7Q7
         izsxN6R3cd1AXCy/eX116wEI1QWBgbec0kL7DjuJc8wcGqJ1KPbUk1rCQjKwos7GS7a/
         19GsW3vlweJhzUMkRYHn1jRghGW11TaDRC4v18l8b3xNC/4SLhwuK4MZ6QlkuGIolEcD
         jwWtGobH1/cOPfXozLw52k984annWwqc7KoTQEoHMF54zuRnSyNStS+ItPPQHIrbP/v0
         oFuw==
X-Gm-Message-State: AOAM5333Wx6HLHG6lHQP9Odi5UsOsFpaihOc/tiB0WgcN0FmDc0E6plg
        3U6TYF7nECzuA5J7JTaSUBsqYGNFFG1Y61UtMT9LqgbMmHs=
X-Google-Smtp-Source: ABdhPJw73O1wIYv0SJg+gmzLA1yLg7AfoVSlPiSyYltzbbHIR+9RxjrPIkkJQvwtxveg14zbD2F0UpGZnxzaAxCQb7w=
X-Received: by 2002:a62:1d94:0:b0:3eb:321d:671a with SMTP id
 d142-20020a621d94000000b003eb321d671amr10269441pfd.2.1630089526490; Fri, 27
 Aug 2021 11:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAPGkw+x+B1731SL=afoSKiWwH-n-FA5YJ+WOwYdv8iyFhWk1zA@mail.gmail.com>
 <3634721.RBzQ2xsved@localhost.localdomain> <1742120.GgyQvu0Ciu@localhost.localdomain>
 <CAPGkw+yJ=V0OwFE+uqCeWWS8JbJD=YBE3+Uk-OKpmHRnvSTh+A@mail.gmail.com>
In-Reply-To: <CAPGkw+yJ=V0OwFE+uqCeWWS8JbJD=YBE3+Uk-OKpmHRnvSTh+A@mail.gmail.com>
From:   Krish Jain <krishjain02939@gmail.com>
Date:   Fri, 27 Aug 2021 20:38:33 +0200
Message-ID: <CAPGkw+w-y+iC3dMDLxi8DR3N+jf8roiJ2Vs_-uHxJ=i57eTiUA@mail.gmail.com>
Subject: Re: [PATCH] Declare the file_operations struct as const
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So what do you think I can do?

Best Regards


On Fri, Aug 27, 2021 at 10:50 AM Krish Jain <krishjain02939@gmail.com> wrote:
>
> Hi, yes, this is my first time programming at this low level. And yes,
> I read both docs now. Furthermore the issue is that my current
> hardware can't handle building the kernel, it barely managed to
> survive the first build after 2 hours so I don't know how I can. If I
> change it to static const would it fix the issue and build
> successfully?  If not what would be the error message, then I can
> debug. Thanks
>
> On Fri, Aug 27, 2021 at 9:48 AM Fabio M. De Francesco
> <fmdefrancesco@gmail.com> wrote:
> >
> > On Friday, August 27, 2021 8:49:30 AM CEST Fabio M. De Francesco wrote:
> > > On Friday, August 27, 2021 3:59:28 AM CEST Krish Jain wrote:
> > > >  From: Krish Jain <krishjain02939@gmail.com>
> > > >
> > > > Declare the file_operations struct as const as done elsewhere in the
> > > > kernel, as there are no modifications to its fields.
> > > >
> > > > Signed-off-by: Krish Jain <krishjain02939@gmail.com>
> > > > ---
> > > > []
> > > Are you sure that it works? I wouldn't be.
> > > You didn't build this file. Please build your changes before submitting patches.
> > >
> > > Furthermore, please always rebase to the current version of the staging tree.
> > >
> > > Finally, please use the class modifier "static" as the first keyword of a declaration/definition
> > > as it is done everywhere in the kernel (see "grep -rn "static const" drivers/staging/" and
> > > then switch to "const static" and read the output).
> >
> > Please don't misunderstand me: as far as I can see this is your first patch and
> > (I'm pretty sure I can speak for everyone else about this) you are very welcome
> > to staging and to kernel hacking :)
> >
> > However, before posting further works, you'd better read at least the following
> > documents:
> >
> > https://www.kernel.org/doc/html/latest/process/4.Coding.html
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> >
> > And please don't forget to always CC linux-kernel@vger.kernel.org.
> >
> > Have a nice time with kernel hacking.
> >
> > Thanks,
> >
> > Fabio
> >
> >
