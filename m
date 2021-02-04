Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA8730F609
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237171AbhBDPTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbhBDPSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:18:43 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE5CC06178A
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 07:18:03 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id q2so4600638edi.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 07:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1+3xdRCQ9NAWUuJA3bHjRi6VQUqOefCIRLIeou3c6kU=;
        b=jNaCJAbzAHyeXmXTBGReBNQYMIJ7tP1BcLMKnp1K3XgDOcX+WGOsVs5kKquhA8Sgzp
         TY8cIYgVgbZ1Wp6DOJn5NTg7vhpMMHI8jhWRK4ANlrQ5kSk1+OCB674JTJWcuZ7GIMRM
         7cFYLmMS9kAR0g48oUAPy6NaGXKLaY8xfBSksuJF4Lw0dSrLZUv/OtraEQl7gRjCAXPj
         E3dSft3uPTj7dJFySiHCHjot3a+vFeST1u1cbGFU93MH7p7NrHXEvxGUtxm3WInd/427
         PB6IGSs+m9XTYILfxMGnjKukNKE7+dsxFvajdtvLs+Rlkj62QFvQF+csceRMLpRf3Kzc
         zyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1+3xdRCQ9NAWUuJA3bHjRi6VQUqOefCIRLIeou3c6kU=;
        b=IIoouFLGvMYWKMp1iztjUP1xLwMETKmOOA0gKcduoDbJTFvYABsiu6/L0N/jVuG84r
         y06tUU/x4NTkokv1kYvPoHDFdeTn/hzAKRk9lEj4a81pKN8XKtg+sgtGdKVBG9ZiKSiZ
         BYe29r4lYVw0Yi4ITnai2on7079vqtFdvUyWuhs9nt2VDK7aUzFm4h+wy+5Cin96imQT
         Ayk0F6xkbARQHIlUyGBkJnnC97BZ4hmVca2kuM/rrxtyeF36haYM8l4Nzs7cX5HuF+gU
         nVSs5CU/Lpg+olW9cH+BWdvV86OgQY36mvDo9buDRyTQVKjIYHPsTjdopwen4A1K953p
         qG9A==
X-Gm-Message-State: AOAM533Ue1s+MXHWisS9CIGribwQaBgcEHRAsfCQoiqlsHZf5QyilQ/J
        moFlNY4gKVoVuPQYCAhQNwtkMCtWJgLkkbE/RO2bvg==
X-Google-Smtp-Source: ABdhPJwsmHu18v0CyLfEgU+2Mh2gmvkeQAnCLRBFYBBcOh61T91S81vmXFZHGGAav9v/cnZlzGVsYlCE1xgVPtuEyj0=
X-Received: by 2002:a05:6402:704:: with SMTP id w4mr6032069edx.59.1612451882152;
 Thu, 04 Feb 2021 07:18:02 -0800 (PST)
MIME-Version: 1.0
References: <20210204124357.3817-1-brgl@bgdev.pl> <YBv61eNnVksYq9mr@kroah.com>
 <CAMpxmJXcVOHbozzhQQW2GPg-6ivCWL3pQmyC-oU_YW5NX=gK3w@mail.gmail.com> <YBwGHWSV1/ZZm7u/@kroah.com>
In-Reply-To: <YBwGHWSV1/ZZm7u/@kroah.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 4 Feb 2021 16:17:51 +0100
Message-ID: <CAMpxmJUof3DN2YHBOQm1Z-hrtS1cj6in5CAHowce++36XtqsnA@mail.gmail.com>
Subject: Re: [PATCH] gpio: uapi: use the preferred SPDX license identifier
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 3:35 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Feb 04, 2021 at 03:15:50PM +0100, Bartosz Golaszewski wrote:
> > On Thu, Feb 4, 2021 at 2:47 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Feb 04, 2021 at 01:43:57PM +0100, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > GPL-2.0 license identifier is deprecated, let's use the preferred
> > > > identifier: GPL-2.0-only.
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > ---
> > > > Hi Kent, Greg,
> > > >
> > > > I started working on making libgpiod licensing reuse-compliant and noticed
> > > > that the reuse-tool is telling me that the GPL-2.0 SPDX identifier in the
> > > > GPIO uapi header is deprecated. Since I'm required to copy the header
> > > > verbatim into libgpiod's repository, I think we need to fix that at source
> > > > first.
> > > >
> > > >  include/uapi/linux/gpio.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/uapi/linux/gpio.h b/include/uapi/linux/gpio.h
> > > > index e4eb0b8c5cf9..3e01ededbf36 100644
> > > > --- a/include/uapi/linux/gpio.h
> > > > +++ b/include/uapi/linux/gpio.h
> > > > @@ -1,4 +1,4 @@
> > > > -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > > +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> > >
> > > No, there is no need to convert the kernel to the "latest" spdx level,
> > > when we started out there was no "-only" nonsense (hint no other license
> > > has that crud), and "GPL-2.0" is a totally valid summary of the license.
> > >
> > > So please don't go changing it all in-kernel, that way lies madness.
> > > Let's finish fixing up ALL kernel files before worrying about what SPDX
> > > "version" we are at.
> > >
> >
> > But then, the reuse script is telling me:
> >
> >     Unfortunately, your project is not compliant with version 3.0 of
> > the REUSE Specification :-(
> >
> > because I'm using a deprecated license. :(
>
> Go yell at the REUSE people, there's no requirement to have the most
> recent version of SPDX, is there?   :)
>
> And if that's the only thing wrong with the project when running 'reuse
> lint' then you should be happy, no one will complain at all.
>
> thanks,
>
> greg k-h

Ok, I get it but let me try one last time: there's absolutely no harm
in merging this patch for the next release, is there? Currently there
are around 15000 instances of "GPL-2.0-only" in the kernel vs 30000
"GPL-2.0" - so the former is not that uncommon.

Bartosz
