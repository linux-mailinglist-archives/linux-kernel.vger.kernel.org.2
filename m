Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969D53C1B46
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 23:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhGHWAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 18:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhGHWAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 18:00:05 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBF2C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 14:57:22 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id k11so10122426ioa.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 14:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h1Nw5vlDLzAgvrulBSETvQkc9AOySYTU4bju4sEyOtU=;
        b=uh1B7OktdVdQAKyT5bAo1eLgRq/GVHtrx02nYVWG5t6vt2iZ27b4+7O0ayMEp3yyf4
         cg9zald17/uAd1kpNfUegcYmv5j4CLHe5V84p+cOIeOS2+HFJ+PkTqYgdkZ0GKALBzr9
         lBISKAO3ILMGf7Ttuht8/Dx2GHRwGRWaTyuLpx650f/7iX0zJAy4AGnhJ1khYVJP/Fqo
         ii0wigMPDlUsxjXg/ffp587S9atABDx/QngBQM0GovQ166zrK2vjSy4UrZv0C98NS0/L
         NT4/ke2B+HWt5Jr2FvsUrToHy5g2qDdBCbDAuxCS4inde0wNaeY05nUjZGKUVDFKivpa
         IthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h1Nw5vlDLzAgvrulBSETvQkc9AOySYTU4bju4sEyOtU=;
        b=GCMmAaYMurNWxiAkD0tHw5ms/i4vzfro5suqxTmnPXEZbp4aVTsOuPJv9P+jjFXyBf
         ZGh/xYYdyWYbrswzTKiZyHM2+Vby0fvAGnMJHiGDiZnZL6Oq5ZPLmwiF4WkhcSgibTHv
         3WuqJQbJ4PZnAMSRHZVVDxaAhV/MonRtbFPu/bFMjvw6bGE3U6CqXjjgf594LbL6AIKg
         xc18hV5CxslYGghYa/ckemjt3F+raS6PpnqicZNGyKJHYrXp6v63eLtCelORjHFBRow9
         WxZMTJo6qn4REbQPbQZtbc67e8GpjI28VK9sebr3MOjzdtz5GqrSufX69o2nMhAddsey
         AbVg==
X-Gm-Message-State: AOAM533PaFJiGJc9ZfJpm7FzWf265i21jP7fXg+dFSxGbr1IItgHIAhl
        wmYcQUf8oT0IL7fVVbCqGjYJcIocbxcbV4dI8fg=
X-Google-Smtp-Source: ABdhPJwCIGlyUtzySF4gtuORUJ/1ZGzkctTs9yzBCiQS7a1wi1Zd9/DY2uoG0AKNlwvDxLNxHmAwgD8//okue8sI3TY=
X-Received: by 2002:a05:6602:2157:: with SMTP id y23mr10122550ioy.116.1625781441691;
 Thu, 08 Jul 2021 14:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <CADLJR24hQya0MkJhdDAJ0KO4MG+Fj4tRU5dNrbNdD9DMG_gLHg@mail.gmail.com>
 <YOPl3dXamM3FERYT@kroah.com> <fe95e46b-fbc9-6411-0e4c-7b72040cddc5@infradead.org>
 <YOVDSjXuOll5I8uL@kroah.com>
In-Reply-To: <YOVDSjXuOll5I8uL@kroah.com>
From:   Sunip Mukherjee <sunipkmukherjee@gmail.com>
Date:   Thu, 8 Jul 2021 17:57:11 -0400
Message-ID: <CADLJR24PrAFUFvcpLH=FBaRSc7gF+x675OKFt1s5QBo0JnCUgw@mail.gmail.com>
Subject: Re: Char Driver for Silicon Labs Si446x Transceivers
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you so much, I will follow the documentation and submit a patch
soon for review.

Thanks,
Sunip

On Wed, Jul 7, 2021 at 2:01 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 06, 2021 at 01:17:09PM -0700, Randy Dunlap wrote:
> > On 7/5/21 10:10 PM, Greg KH wrote:
> > > On Mon, Jul 05, 2021 at 06:09:28PM -0400, Sunip Mukherjee wrote:
> > >> Hi,
> > >>
> > >> I am very new to the kernel community; this is my first message in the
> > >> LKML so my apologies if I am doing things wrong.
> > >>
> > >> I have been using an Si4463 transceiver for UHF communication with a
> > >> cubesat I developed. I could not find any code to control the
> > >> transceiver on Linux. The closest thing I could find was an AVR
> > >> implementation by Zak Kemble
> > >> (https://blog.zakkemble.net/si4463-radio-library-avr-arduino/).
> > >> I followed the API docs and rewrote the whole thing at first for
> > >> userland only (can be found here:
> > >> https://github.com/SPACE-HAUC/si446x_linux/releases/tag/v3.1), and
> > >> then I decided it would be a great learning opportunity for me to port
> > >> it to the kernel.
> > >>
> > >> The kernel port has gone mostly smoothly. The transceiver communicates
> > >> with the host MCU over SPI, and requires a pin for RESET, and another
> > >> pin for IRQ.
> > >> I have implemented the driver to provide a char device (/dev/si446x#)
> > >> to the userland for open, read, write, poll and ioctl.
> > >> I had initially set up a pull request for the driver and the device
> > >> tree overlay to the Raspberry Pi kernel community. They have agreed to
> > >> accept the device tree overlay for the device, however the driver
> > >> needs to be included by the Linux Kernel community. I want to use this
> > >> opportunity to find some people who have access to a Si446x
> > >> transceiver and a Raspberry Pi, so that the code I have can be tested,
> > >> and if deemed worthy, included in the kernel tree.
> > >>
> > >> My code is hosted here: https://github.com/sunipkmukherjee/silabs.git
> > >>
> > >> Any suggestions/criticisms are welcome.
> > >
> > > If you post it in a patch form, as described in our documentation, I
> > > will be glad to review it.  Otherwise just looking at a random github
> > > repo is quite difficult and provides no way to give proper feedback.
> > >
> > > Instructions on how to make a patch and submit it and the proper format
> > > for everything can be found in the Documentation/SubmittingPatches file.
> >
> > which is now known as Documentation/process/submitting-patches.rst
>
> That's what that file says :)
>
> I should update my bot one of these days to point to the real
> location...
>
> thanks,
>
> greg k-h
