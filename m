Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10A73FDEBE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 17:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343744AbhIAPfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 11:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244434AbhIAPfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 11:35:45 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D048C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 08:34:48 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gp20-20020a17090adf1400b00196b761920aso1914050pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 08:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N8B7cD0D9ZFwyRPa4aYEuuZAbEVPjLVcuT/MQvCFZ4E=;
        b=T4SZZPrPT2o7P4c6l1hWht9BmeX9neTWX/U9dCtFAbIDE0jFkgSuUtfVVsgSgMVeg6
         vwdxfvvT4RhLD0BOfJ2GKCfyccZkXF4pgONNsjLUk994SrSUOJeuoxdndAA5E9ybRSUH
         wZZcsiiiO0FWr5PSZXbaiS9IyCiAH4t4yfJCtF1sLnMfRsoyC06pucJ9wy4SQ+0OXMPN
         bGtw5iEm1ZCG3Kf+w/sFsSVnlP4uKITchdNOv2oTAdsjIvUcqrE8xuRKOATKgC4rYn65
         t0hlXbk694aBoUWouJY04jcvk2IFb/pLZH2OT7MFNY6SjVrayJ8VfjEXPga9uwE066i2
         A61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N8B7cD0D9ZFwyRPa4aYEuuZAbEVPjLVcuT/MQvCFZ4E=;
        b=aSVRb0Y++qv+Jv+tgKTZPYje6QjklkaYOpCZBDeM72WfoGc7wsTtEFQV+vNcxWAAY0
         1YCFQkMd3n8icb46UCzNMFtawvGbXCRW1QqohTD4u2uWbRhWyIPOY1iSUpaSBspDyUAw
         GUgF2T0iGhfuUvrZWx7cpHVMLa0koi8V9xsaZbqH99HjrhAI6fVTYhWz7e6dBbkvRzv1
         /+MsU+9cmikcin6WdUBztVm10oVm2josnHgmaKXjoF3S30f7+8+e3f5JoPsH3bMoVAq6
         qd4GD+Jm90m+hJTUn6A9Qluowd0fl9hZdxjOOahXYl4hYqixRePei8lYXPMVBKIp9VVz
         NhVQ==
X-Gm-Message-State: AOAM533Ie9B0ZuWQWRcfrfKh4OnpIbkvp313dAPzeZEZMUdL2EsIBYzT
        V5N5UqJ2rNEZXhTyL5Ved/Wnjk0hK+VhGztYlCw=
X-Google-Smtp-Source: ABdhPJw041CRUdRva8kjcC5J0upx/B6SBQaO+F/VUwnh+Onnt9D4eC4ldqppLqBgvXeAalzPVlvZc11RXwrJnP5sjG0=
X-Received: by 2002:a17:90a:8801:: with SMTP id s1mr12491424pjn.166.1630510487915;
 Wed, 01 Sep 2021 08:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210829144531.c2syu4vv4s22dlg7@h510> <CAPGkw+wyH3Pj6DV_m8wqCV5yujhjRwTwVNs6dK4i9JO-Y3ys6w@mail.gmail.com>
 <20210831133533.6aayzjghdakrhy56@h510> <13366651.n50aozgL3V@localhost.localdomain>
 <20210831230014.cp46vho2hnndacjp@h510> <CAPGkw+zpYsovnXL_4GfjsQ60fqre+xyiwvwKuDj_fHPTKEfzeQ@mail.gmail.com>
 <YS+cexhuqldPaACs@kroah.com>
In-Reply-To: <YS+cexhuqldPaACs@kroah.com>
From:   Krish Jain <krishjain02939@gmail.com>
Date:   Wed, 1 Sep 2021 17:34:36 +0200
Message-ID: <CAPGkw+z+uepM0hiNh48xjjD7=2rpgr+RSLzMcHbw2iE=8y+xqQ@mail.gmail.com>
Subject: Re: [PATCH] Declare the file_operations struct as const
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Bryan Brattlof <hello@bryanbrattlof.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 5:30 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Sep 01, 2021 at 05:20:13PM +0200, Krish Jain wrote:
> > On Wed, Sep 1, 2021 at 1:00 AM Bryan Brattlof <hello@bryanbrattlof.com> wrote:
> > >
> > > On this day, August 31, 2021, thus sayeth Fabio M. De Francesco:
> > > >
> > > > I just want to *really* thank you for the hard work you got involved and that
> > > > you carried out with one of the highest levels of professionalism (and
> > > > patience :)) very few of us could ever equal (not I, for sure).
> > > >
> > > > I thank you also not for the technical hints you gave to Krish, instead for
> > > > your your choice "to not rob [you] Krish the opportunity to learn".
> > > >
> > > > Actually I was tempted to write something like "first do this, than that, and
> > > > finally run this tool". But I was able to desist, by learning from you how
> > > > people should be helped for real.
> > > >
> > > > Most of us here should learn by your attitude.
> > > >
> > > > Thanks again, seriously.
> > > >
> > >
> > > Thank you for such kind words, Fabio.
> > >
> > > I was very lucky to be, and still am, surrounded by people who
> > > demonstrated this idea to me when I was young. I am very happy to see
> > > others here see how beneficial and helpful (in the long term) learning
> > > this way can be.
> > >
> > > I'm grateful to have found and be a part of this community.
> > > ~Bryan
> > >
> >
> >
> >
> > Interesting.
> >
> > "make drivers/staging/android/ " works now (finally!) and shows me the
> > errors when I mess up in the file  ashmem.c for example.
> > Furthermore, " make CCFLAGS=-Werror W=1 drivers/staging/android/    "
> > outputs the same errors too just more verbose. So it works completely
> > now, However, "make CCFLAGS=-Werror W=1 M=drivers/staging/android/
> > " just takes to new prompt line and does not output anything. Do you
> > know why?
>
> "M=pathname" is different than "pathname", you are asking for different
> things to happen here, so depending on your kernel configuration,
> different things will be built (or not built).
>
> And don't mes with CCFLAGS settings for building the kernel unless you
> _really_ know what you are doing.  For staging tree work, it's not
> advised at all.
>
> good luck!
>
> greg k-h


Oh ok, thanks Greg. I only attempted to use "make CCFLAGS=-Werror W=1
M=drivers/staging/android/" as that's the command Bryan used earlier
and it worked.

"As for your patch, I built the driver using:

  $ make CCFLAGS=-Werror W=1 M=drivers/staging/android"


Can you tell me why this is the case? And whether I can just start
working on an android driver patch and testing whether the android
driver builds successfully using "make drivers/staging/android/ "
instead of that command, would it be the same effectively?

Best Regards,

Thanks so much for helping a high schooler learn his way around the kernel
