Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994AC38AFAD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240670AbhETNJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243577AbhETNJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:09:19 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C317C061257
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 06:02:26 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id b13so21288358ybk.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 06:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7LXxmecV2iJZ9InHfexCFHijyuYNy6jWbSHDMut4U0U=;
        b=HppKd/sSakxiwwDGtGXzyOs+yKmfoHOwYo6J/oe0askIBtKETyDbNAYk+Vr+1vMeBm
         HraGZ8tMy/mB3Sd7G0XcSp5k7yZsKRpWyvBmyv/CCIjxq7/eIqnJFHujSB0eeD0D4Whv
         Dxosom3Zj1zAIAf148scx8MGe1ThYx5JkFJfWKIisS5RQFtJ6hjOAgZwhzfbokmSBoT5
         EfAFVSd3sszqod4Ia45Rrf3VgxfP9IX+qWFIDWbB61+uML4ho17dczv6uBuxobwm4pKQ
         UwdKlu90G2D+M0bfyWhOnz0QQSWa6zTV+wqA3lfCuZaLDtSlHYCeTCVq/MgjLnVQcqt9
         DG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7LXxmecV2iJZ9InHfexCFHijyuYNy6jWbSHDMut4U0U=;
        b=NfoGAgLJI6V0ndVMzvKHNdw+qGjWbUPFWyCugo8REvYusg5yv5Bict35W9Kdyjbld5
         hi9Q2B3sBl5Jr2sFbiWovEE5y/reXjOB8kZbinlWKY0kh/B8ihzkg+ZTJIK30K7r6fjx
         pIbiMRbZ+eZOEV2CfRzNQU8qzUSK/3Aehtfo2gSafmquOZYKOU3ojQuzFUjXMI5LVGbt
         q+aGEpUNvCbw+m/DawJ/K15p1TuxDqvHsH8RC4iVpCIdd61RCWKCped+5NP5o+KBbkGA
         Zfxw5uOTiFUMINBN4uPvaiHL1WwLp7IErCYGXdfH9wqTwvrIcsXpkEq+htjbJNCplVgL
         4xzg==
X-Gm-Message-State: AOAM531siDW6PHseG07oj+WnmEAFKrPc0MxGGM1ZNvBDVC2X9e0vKosB
        YXg6zWKZaKoQklKEeTw6zbmzTWU2bEiIVzUF9s1Onw==
X-Google-Smtp-Source: ABdhPJxP7eeMaocnkV/FIKZOLrjN3s+PE6yrQTmOfs3aBogXe5fTUWss8RrNfQrVjeocmKy0yW5CcWEil/nveR4Omc8=
X-Received: by 2002:a25:8804:: with SMTP id c4mr7020788ybl.469.1621515745561;
 Thu, 20 May 2021 06:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210518155013.45622-1-andriy.shevchenko@linux.intel.com>
 <20210518232451.GA7362@sol> <YKTCDNcyUlrgE0Y4@smile.fi.intel.com>
 <20210519080434.GA22854@sol> <YKTMninSSY3MK6Hf@smile.fi.intel.com>
In-Reply-To: <YKTMninSSY3MK6Hf@smile.fi.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 20 May 2021 15:02:14 +0200
Message-ID: <CAMpxmJVJBx2J87bS0CUYPyJkHKt=nvFw65y_+iG-5JbVekuaqw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] gpiolib: Never return internal error codes to user space
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Suresh Balakrishnan <suresh.balakrishnan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 10:30 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, May 19, 2021 at 04:04:34PM +0800, Kent Gibson wrote:
> > On Wed, May 19, 2021 at 10:45:16AM +0300, Andy Shevchenko wrote:
> > > On Wed, May 19, 2021 at 07:24:51AM +0800, Kent Gibson wrote:
> > > > On Tue, May 18, 2021 at 06:50:12PM +0300, Andy Shevchenko wrote:
> > > > > Currently it's possible that character device interface may return
> > > > > the error codes which are not supposed to be seen by user space.
> > > > > In this case it's EPROBE_DEFER.
> > > > >
> > > > > Wrap it to return -ENODEV instead as sysfs does.
> > >
> > > > > Fixes: d7c51b47ac11 ("gpio: userspace ABI for reading/writing GPIO lines")
> > > > > Fixes: 61f922db7221 ("gpio: userspace ABI for reading GPIO line events")
> > > > > Fixes: 3c0d9c635ae2 ("gpiolib: cdev: support GPIO_V2_GET_LINE_IOCTL and GPIO_V2_LINE_GET_VALUES_IOCTL")
> > >
> > > ...
> > >
> > > > You immediately revert this patch in patch 2.
> > > > My understanding is that is not allowed within a patch set.
> > >
> > > > Why split the patches instead of going direct to the new helper?
> > >
> > > It's for backporting to make it easier. (I deliberately left the context above)
> > >
> > > I can fold them if maintainers think it's okay to do.
> > >
> >
> > Not sure what the constraints are on backporting, but wouldn't it be
> > simpler and cleaner to backport the new helper?
>
> Logically (and ideally) it would be three different patches:
>  1) introduce helper
>  2) use helper
>  3) fix places where it's needed to be done
>
> But the above scheme doesn't fit backporting idea (we don't backport new
> features and APIs without really necessity). So, the options left are:
>
> Option a: One patch (feels a bit like above)
> Option b: Two patches like in this series (yes, you are correct about
>           disadvantages)
>
> > But, as you say, it is the maintainers' call.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Third option is to backport this patch but apply the helper
immediately to master.

Bart
