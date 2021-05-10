Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1953799F8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 00:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhEJWWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 18:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbhEJWWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 18:22:23 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489F5C061350
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 15:21:00 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id r5so8508328lfr.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 15:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F/mygZtksxxw7ebcmiKl2JaPpBSjJqhK2xo7cgVegBg=;
        b=bRrmxrdr1iOaibrv9cizl2QRi3u+OeaySXanNQ0pi15kpxBfvLETb8dxk2J5vayapj
         Olhy8OeDmqAAOOKMLpbUs7zYKIfztm7qM1SVT92jGz3qbSjc4BWcrYbyj/3t7UyyNLth
         zeHY7rnL917j0NoPMRLH/BEBBP8dlcY22ZKbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F/mygZtksxxw7ebcmiKl2JaPpBSjJqhK2xo7cgVegBg=;
        b=tqJc5XqO02FpbweM9MzSqQgfp3Vk1vnAOUYvPbma0AG5fFoX+APMoQHRbrk+99Rgaj
         rSSr5K/TB0isrecU4F2mteveHXI8iTbStmBSzh3F3hfiIo6sREXhTA5Dcq33jVZgjqe1
         jDD7t9dxlrUnLc8MPwmBA04BjNBxSdUTWel16i/5lKAR5tjIzN9X3Ep7yGnz7ByUkeaz
         98yxQxs9sFHqgrhFITonIU3E+8hyVJXNElebVg0Xd+oRWB+6KEaIrmUho/E31ZrAiUPo
         f8YnDMSwYpwww9ZovoVzs3TwN4lUhd7F05PoBHQQrv/gBI3Lr2bVrbyKj/4uDJJpceKQ
         tOog==
X-Gm-Message-State: AOAM533kXnM0OkrCURlUJhEtCoO0F+L1CqfkZQGXJyS9lxbMmGBL2g3t
        QrOXgOYT+yyjw5VjwvuFgwNmDyK6YhWNJj35V+Y=
X-Google-Smtp-Source: ABdhPJxLkKnCTcoB+aX3yg7KYdnnSCxz9R7v/PpoK0ZJ902OupkNag9a2I93zxo0Vm3FQa6IX8cVog==
X-Received: by 2002:a05:6512:3b2a:: with SMTP id f42mr10465909lfv.208.1620685258420;
        Mon, 10 May 2021 15:20:58 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id y13sm2390032lfl.252.2021.05.10.15.20.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 15:20:57 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id o16so22734198ljp.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 15:20:57 -0700 (PDT)
X-Received: by 2002:a05:651c:1311:: with SMTP id u17mr21150586lja.48.1620685257343;
 Mon, 10 May 2021 15:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiWTU+=wK9pv_YG01rXSqApCS_oY+78Ztz5-ORH5a-kvg@mail.gmail.com>
 <20210510025414.GA2041281@roeck-us.net> <CAHk-=wjsQz-RJzXPu6eeZE+R9m2SH6JoreV6e_mwguitZ5_=zw@mail.gmail.com>
 <20210510193924.GA3929105@roeck-us.net>
In-Reply-To: <20210510193924.GA3929105@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 May 2021 15:20:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whcSbW+CprMV4=F2QQG_yuoD9kJRi2Ec2XP8Hu1ixkYOA@mail.gmail.com>
Message-ID: <CAHk-=whcSbW+CprMV4=F2QQG_yuoD9kJRi2Ec2XP8Hu1ixkYOA@mail.gmail.com>
Subject: Re: Linux 5.13-rc1
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Saravana Kannan <saravanak@google.com>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just adding Greg & co explicitly to the participants to make sure
they're aware of this..

Greg? This came through your driver core tree.

                Linus

On Mon, May 10, 2021 at 12:39 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, May 10, 2021 at 12:01:00PM -0700, Linus Torvalds wrote:
> > On Sun, May 9, 2021 at 7:54 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > Qemu test results:
> > >         total: 462 pass: 460 fail: 2
> > > Failed tests:
> > >         arm:raspi2:multi_v7_defconfig:net,usb:bcm2836-rpi-2-b:initrd
> > >         arm:raspi2:multi_v7_defconfig:sd:net,usb:bcm2836-rpi-2-b:rootfs
> > >
> > > The raspi2 problem (a crash in of_clk_add_hw_provider) is well known.
> > > It was introduced with commit 6579c8d97ad7 ("clk: Mark fwnodes when
> > > their clock provider is added"). Unfortunately it appears that there
> > > is still no agreement on how to fix it.
> >
> > Hmm. I see
> >
> >     https://lore.kernel.org/linux-acpi/20210426065618.588144-1-tudor.ambarus@microchip.com/
> >
> > and don't see any objections to that version.
> >
> > Does that fix it for you too?
> >
>
> Yes, it does. It was submitted ~2 weeks ago, so I have no idea what its
> status might be (it is not in the most recent -next). I just sent a
> Tested-by:, figuring that it can't hurt.
>
> Guenter
