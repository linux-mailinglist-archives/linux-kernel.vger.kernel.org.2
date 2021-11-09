Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4360A44B07B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 16:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237572AbhKIPiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 10:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhKIPhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 10:37:55 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD33BC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 07:35:09 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id l7-20020a0568302b0700b0055ae988dcc8so28223757otv.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 07:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6P9kfAq25M0Ott2fQCCUtK4XDP/IOjInuL3zZIDGlDI=;
        b=I0QaZrYPjsQL6+JdoXG+V2WbIFNVhdI+JtmDiggHAqwpFAe0jw6hk+dyzWy5+jZyGG
         Hs+BJvTDt5EA+1t/CUY3E82GonptnHzV2jTsFtth147tDDhxpxFrCaYIz59VTkgigqvK
         GerBizDc4vzO9rakXKwdj6aHEJ7KQSw4DB2qkw9sbUqdDH1Fw76Ds4PZg1P6N3azly2J
         shwFHGUwISj5zVy/9wHuZ/ugpjapHD3lim6wnhr3wMXCdHhEBIUeTgzuz+FpsgTxOr6q
         ACbnewVcQOTASZ+h6ZvSuyqzePepMY9ioFdYVswNZWFfg7366vMFT6JH11PXDTkjZUJT
         1kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6P9kfAq25M0Ott2fQCCUtK4XDP/IOjInuL3zZIDGlDI=;
        b=rFZPR0XWszXr43u3ALrXMJOx15mJsBeUTzGmpJSGsiG1gLBNNYes5OrPP9jTRzOtBr
         bEOJFzHe6GS7jNUzNRRF7SZlNwws1wBKaH+1nIw+M0MwpeM2GCG+VHcJL0UEPa2c+hIG
         N+FQDzG5N1s1r/90P/EN7w5hBlFu+JrRkiKGbdLps9HmF2CP2GS6agEA3R076JPGhp2/
         EKV9yhg+XxxN41XTfwhVlTmZXdauvew5XHa8DXuzLzlH6RrA7hXhim8sWGD3E3dXOsHe
         adDmCny6fNMj6QnypYdMAcllHIxqEBamFxue0RC1xZ4jIeWXhTi+EpFYrBCsXdQ5yHoR
         G+/g==
X-Gm-Message-State: AOAM532L25l4Yr4Ks66twMP1eLcvxKUSrsMw0RYypmKyQHbXctaHL/YQ
        SRRYdIQzT04kSB+JVpEKxhD0buYxp8tBP+c2MzVfhIJEiydpe5PxOYs=
X-Google-Smtp-Source: ABdhPJyhMiCf84UiYlsJt3vq62Gicq5w67HOzTTVUdxLu7GqanMf3/ChRnXWo/99GQURcH2cITjJxxPJgp/+2O8RYo4=
X-Received: by 2002:a9d:4502:: with SMTP id w2mr6918192ote.182.1636472109076;
 Tue, 09 Nov 2021 07:35:09 -0800 (PST)
MIME-Version: 1.0
References: <20211108185818.GA73382@makvihas> <YYoUYOyyP4EFYTSJ@kroah.com>
 <CAH1kMwSqfNT-jB70c6Md_Wa6Sn6GJKr2=LOunSaZwEk2TKzraA@mail.gmail.com> <YYpaP1fAg7jrFyhJ@kroah.com>
In-Reply-To: <YYpaP1fAg7jrFyhJ@kroah.com>
From:   Vihas Mak <makvihas@gmail.com>
Date:   Tue, 9 Nov 2021 21:04:57 +0530
Message-ID: <CAH1kMwR7BA6kpcHCmEnEQ_EPeJxFDHQ3QB9mAn0D8NzdB8LNhw@mail.gmail.com>
Subject: Re: [PATCH] char: ppdev: fixed a validation issue
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     sudipm.mukherjee@gmail.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What happens today if the mode is not set properly?  Will the code paths
> error out eventually, or will the call succeed?  The problem is that
> there might be code that is working today that would break with a change
> like this, as again, this is a very old driver.

I see. So I guess this driver might be better off without any changes,
as new changes might break things more severely.

Thanks,
Vihas

On Tue, Nov 9, 2021 at 4:53 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Nov 09, 2021 at 04:11:20PM +0530, Vihas Mak wrote:
> > > On Tue, Nov 09, 2021 at 12:28:18AM +0530, Vihas Mak wrote:
> > > > Make sure the mode is a valid IEEE1284 mode.
> > > What is a valid mode?
> >
> > The valid IEEE1284 modes are the ones defined in
> > <uapi/linux/parport.h>. Currently there are 10 modes. Namely nibble
> > mode, byte mode, ECP, ECPRLE, EPP and some specials.
>
> But what happens today if code has not been sending those values
> properly?  This is a very old driver for very old hardware.
>
> > > How did you test this?  And why is this needed now?  What hardware was
> > > working that is now not going to work with this driver?
> >
> > I tested this on my local pc using a parallel port and read the
> > incoming data on my Raspberry PI.
> > I also used https://github.com/strezh/VPPSniffer. It's a simple
> > virtual parallel port used for debugging and sniffing.
> >
> > The mainline code wasn't validating the mode when a user-space program
> > does a ioctl call to change the current mode. It might
> > create some bugs if the new mode isn't one of the IEEE1284 modes
> > defined in <uapi/linux/parport.h>. So it's better to throw a EINVAL
> > beforehand, if the mode is invalid.
>
> What happens today if the mode is not set properly?  Will the code paths
> error out eventually, or will the call succeed?  The problem is that
> there might be code that is working today that would break with a change
> like this, as again, this is a very old driver.
>
> thanks,
>
> greg k-h
