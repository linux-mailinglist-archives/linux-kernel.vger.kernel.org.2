Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC94327A4C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 10:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbhCAJBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 04:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbhCAIzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 03:55:54 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D27C0617AA;
        Mon,  1 Mar 2021 00:55:14 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id e7so13969808ile.7;
        Mon, 01 Mar 2021 00:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=DmAA6tgfdHxBBo/R7khg/z33Al26yV6cc7Ji0SRbkLw=;
        b=cxuy6GKqqU9oceLGCbnAKaFy6dIvpyJH0aJLeaHt8i0h0BSeaWS4gT5xpYTGF01oBj
         Gu7Kb8wwdLAc4Am5OIIz9CTJHt6CzrTYyx8+a0fzDHBHoVL8DRqqJ673UwzjCibvEb0b
         KAHJVwx8WTA4CfDuO7ZrVqOkW226S87g0JDdYP0Xrq55MawryFekb1S8rRLt28+QR2/X
         2itA/TJDrdhP/sv86bICIytKXaACmQSfvz0UnlJrMzNIT5gvV43Tgc0VenkzyAX+h8TN
         HzeG+zGV0NQ6bcPUv+dYvsx1U3qsgGoLyoP2KhQxuUHPaNwGe6G9sLMAJ1wfiOyyCC1K
         MLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=DmAA6tgfdHxBBo/R7khg/z33Al26yV6cc7Ji0SRbkLw=;
        b=DI7OQFgcNBAfQTVFab4VaCEU+A3rTzX1wCs7owRXAS7ftTUAyXxn0mJqt3WCF6ijYy
         fU0euSpW0hB7fmiIYzz4TUdxUH/5rolxobXY4vOiBrLGgAjy+2yaif98jA4Q1SUKJWe1
         g7NBqkJUzWkpFMFtRr//Fz6WvoM5JfGWSbSJC5CGgHGTLaqK/i3Wer1Ls7PBuKIGNjcu
         RYTeAsThEcrNUr4bw5FnMt0qqGL41qK1Eblfa4EdL8dEVvEJxSDE53oN0IAJBZZb5n7G
         D8mE48U+Ths93LGDhns6wS7rPMavqGWZ2F03ehJl7rO6+oQj1Ckhrs39l46OBstHO2CV
         uDng==
X-Gm-Message-State: AOAM531EYXO2ntFVBb+YJgsC92npiyhycfNVUnWmyE/j49eoGsE0hJGA
        kvLbKqubxZaryjPMhmwSBcTMxPC/oICNzrQ1b9uKfUwm6NeI3g==
X-Google-Smtp-Source: ABdhPJyOLb5Nc7qxuH3tSL6W3Cdglxdla7mYQ0/GlxfIBLrQyf5rdawAyfzHiCjD2ktnosiyTNuWYxGmdGqHRq6EFxE=
X-Received: by 2002:a92:c7c2:: with SMTP id g2mr12575928ilk.209.1614588913968;
 Mon, 01 Mar 2021 00:55:13 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUWJyPTefHkGEgQtDO9TOM4CN_b2qPJGQVF7NE=Q=fGAEQ@mail.gmail.com>
 <CA+icZUUzBvmi9SvJ4Bh8ER_+Rkm9vv9FkKwoS8ofmRsko_fJhg@mail.gmail.com>
In-Reply-To: <CA+icZUUzBvmi9SvJ4Bh8ER_+Rkm9vv9FkKwoS8ofmRsko_fJhg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 1 Mar 2021 09:54:38 +0100
Message-ID: <CA+icZUXCgW0bPcqNf+DSubBciQeBMbNX5zbjkMXinqRdkE1PfA@mail.gmail.com>
Subject: Re: [xhci] usb 4-1: reset SuperSpeed Gen 1 USB device number 2 using xhci_hcd
To:     Mathias Nyman <mathias.nyman@intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 6:25 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Wed, Feb 24, 2021 at 2:44 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > Hi Mathias,
> >
> > I am here on Linux-v5.11-10201-gc03c21ba6f4e.
> >
> > I see a lot xhci-resets in my dmesg-log:
> >
> > root# LC_ALL=C dmesg -T | grep 'usb 4-1: reset SuperSpeed Gen 1 USB
> > device number 2 using xhci_hcd' | wc -l
> > 75
> >
> > This is what I have:
> >
> > root# lsusb -s 004:001
> > Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> >
> > root# lsusb -s 004:002
> > Bus 004 Device 002: ID 174c:55aa ASMedia Technology Inc. ASM1051E SATA
> > 6Gb/s bridge, ASM1053E SATA 6Gb/s bridge, ASM1153 SATA 3Gb/s bridge,
> > ASM1153E SATA 6Gb/s bridge
> >
> > My external USB 3.0 HDD contains the partition with my Debian-system
> > and is attached to the above xhci bus/device.
> >
> > Can you enlighten what this means?
> > Is this a known issue?
> > Is there a fix around?
> >
> > BTW, in which Git tree is the xhci development happening?
> > Can you point me to it?
> >
> > I am attaching my linux-config and full dmesg-log.
> >
> > Also I have attached outputs of:
> >
> > $ sudo lsusb -vvv -d 1d6b:0003
> > $ sudo lsusb -vvv -d 174c:55aa
> >
> > If you need further information, please let me know.
> >
> > Thanks.
> >
>
> Looks like that xhci-reset happens here every 10min.
>

[ To Greg ]

The problem still remains with Linux v5.12-rc1 (see [1]).

Yesterday, I ran some disk-health checks with smartctl and gsmartcontrol.
All good.

For the first time I used badblocks from e2fsprogs Debian package:

root# LC_ALL=C badblocks -v -p 1 -s /dev/sdc -o
badblocks-v-p-1-s_dev-sdc_$(uname -r).txt
Checking blocks 0 to 976762583
Checking for bad blocks (read-only test): done
Pass completed, 0 bad blocks found. (0/0/0 errors)

Good, there is no file-system corruption or badblocks or even a hardware damage.

Anyway, feedback is much appreciated.

Thanks.

Regards,
- Sedat -

[1] https://lore.kernel.org/lkml/CA+icZUUjVnBjC4AJTT9LYS4J+QbuQZUVj5XdW+iPmjxxuODVmA@mail.gmail.com/
