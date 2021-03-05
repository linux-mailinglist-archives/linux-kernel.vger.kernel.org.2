Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7063E32F42B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhCETmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhCETmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:42:17 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EE6C06175F;
        Fri,  5 Mar 2021 11:42:17 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id g27so3256334iox.2;
        Fri, 05 Mar 2021 11:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=nt32QhVHzb3AENSb5YIy5UA4K+u/RYIwLbCnQB1uC4Q=;
        b=cN6sWaGUr7uk5054iUQya5vyfzhWjihiu9zHJixqNTx+519hMe0GIVJpQ03aebfcLX
         OXjfPzZKOBACLFgu+N1y+PzR5mqiyOV4UmlkpP3HL2zbykb4Eg1uWUndqaGR1aIJQeoM
         xfDsdZIDmhrtxStve4B+yZ+kRkijzgzJwX496jFvjUPGcSRfx4zwNLaWogxESSV9LGXt
         r8ZjCZJPDsDa+a0b23ebjmfUb1Hb3YyBVHX/I2PVM3P3SRhjQyT7/J1FtfwORo+EyvwT
         1whISDx+BMTNGnbRN1Z/HMfHDKAG1jWRydHnRw5Da9ub6DsAJebqRzfGO85ZV/bN7yO6
         lPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=nt32QhVHzb3AENSb5YIy5UA4K+u/RYIwLbCnQB1uC4Q=;
        b=ive7mP+kY+LEwfdWeAQGO4jCpFGFY9izn+6GHCu499/kk7CDRoBHWMYKwcq9tLXJsu
         qVdrvvtIiQRONcmUXsl7nHQc7ruaTjsXXQ9bbBSLDuRDEqWYL0MaZU+Hblzn4r+QhDcm
         YCOLVNb2mwJiiDekAUl+M/55CKnBw/UVi0YBuhlTy5BBvIei7bL3Cm70RVcCG62QPhOe
         S/zRgLtFL4FHSdGEBzRwI6Vo2iZSgZC+qEtutiQhE7iamiXMZNtZHUfK8tTr77inOb7p
         f4sDk15MQjlTMsUoRIrf0wGt7YzPfuOjANi+ItKCatH2cXIm1f4ooguqRbEGB1iZFEYR
         jyGw==
X-Gm-Message-State: AOAM532TLwxD+PZ+V5AXOgtv0IM17X6SqAoLHiazyStAqZ9do22Rtvbx
        kkjn2MWRsQpsEKEeqKqSqY6xnyLAQR7Y0EQA5fABZQuqbAO63g==
X-Google-Smtp-Source: ABdhPJxZISgEXK/GkurIncyKWx/JpMQGogEABHu8j6Ql6/X3NDp+W67mWZNUAZ3SnOsWwNabIRjCPi+aXkOqniG+Y5I=
X-Received: by 2002:a02:b890:: with SMTP id p16mr11266473jam.138.1614973336876;
 Fri, 05 Mar 2021 11:42:16 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUWJyPTefHkGEgQtDO9TOM4CN_b2qPJGQVF7NE=Q=fGAEQ@mail.gmail.com>
 <CA+icZUUzBvmi9SvJ4Bh8ER_+Rkm9vv9FkKwoS8ofmRsko_fJhg@mail.gmail.com>
 <CA+icZUXCgW0bPcqNf+DSubBciQeBMbNX5zbjkMXinqRdkE1PfA@mail.gmail.com>
 <20210301155321.GA1490228@rowland.harvard.edu> <CA+icZUVpQtsq8y=rjR3Ad_G1VXWpR4D4xao8DGUkRiuxoT+cPA@mail.gmail.com>
 <20210305160728.GE38200@rowland.harvard.edu> <CA+icZUXnjDwyKEoX_7KOaVd=PpvEQhpJRvwZbW_xocDfXZpUzQ@mail.gmail.com>
 <CA+icZUUFGh5CWH-UJK4T-h_Qd2KNnOCrGuT8fg0+Fvjm0C2kbg@mail.gmail.com> <20210305193003.GE48113@rowland.harvard.edu>
In-Reply-To: <20210305193003.GE48113@rowland.harvard.edu>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 5 Mar 2021 20:41:40 +0100
Message-ID: <CA+icZUXUAVAusGBKSAtUEN1kH2PLchpi0cU+w-m67QznA7+F4A@mail.gmail.com>
Subject: Re: [xhci] usb 4-1: reset SuperSpeed Gen 1 USB device number 2 using xhci_hcd
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 8:30 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, Mar 05, 2021 at 08:22:22PM +0100, Sedat Dilek wrote:
> > The quirks match:
> >
> > [Fri Mar  5 20:06:56 2021] usb-storage 4-1:1.0: USB Mass Storage device detected
> > [Fri Mar  5 20:06:56 2021] usb-storage 4-1:1.0: Quirks match for vid
> > 174c pid 55aa: 400000
> >
> > That seems not to be the trick:
> >
> > root# LC_ALL=C dmesg -T | grep 'usb 4-1:'
> > [Fri Mar  5 20:06:55 2021] usb 4-1: new SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
> > [Fri Mar  5 20:06:55 2021] usb 4-1: New USB device found,
> > idVendor=174c, idProduct=55aa, bcdDevice= 1.00
> > [Fri Mar  5 20:06:55 2021] usb 4-1: New USB device strings: Mfr=2,
> > Product=3, SerialNumber=1
> > [Fri Mar  5 20:06:55 2021] usb 4-1: Product: MEDION HDDrive-n-GO
> > [Fri Mar  5 20:06:55 2021] usb 4-1: Manufacturer: MEDION
> > [Fri Mar  5 20:06:55 2021] usb 4-1: SerialNumber: 3180000000000000092C
> > [Fri Mar  5 20:06:57 2021] usb 4-1: reset SuperSpeed Gen 1 USB device
> > number 2 using xhci_hcd
>
> Okay, that indicates the ATA commands are being sent not by the kernel
> but by some program.  I'm not sure how you can easily find out which
> program; probably the best thing to do is turn them off one by one until
> you find the one responsible.
>

I can hardly imagine which user-space tools other than powertop can
interfere here.
Any ideas?

I will remove or better comment the quirks in
/etc/modules-load.d/usb-storage.conf for now.

- Sedat -
