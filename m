Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6F14119E3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 18:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbhITQhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 12:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhITQhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 12:37:04 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188DAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:35:37 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id t4so44735836qkb.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2bpycfdO69tvhTRtma9jQs4XhE8PVrSk+wX8dAk4GKg=;
        b=n7aURfq1Uj/O4fSWOlz7gaxw+6ZlX8bXPYvx83mISg5oiKiwLmFEZrfIQ/KUfkac/2
         4ICidRpNCfqYGA5BbaopXMn6Pk//4osgxm133jkNMO549F3Et46Z3U/Cf2fwZI67a9c2
         YcrmS+5qFz9Y2+0sOEBOX3Q2E03E5wiY2Wx+rPDELldbJKTZ0SYE+rYgzNkaiuDrXRgq
         901DLdE4Ta4p4gxPSJexw3o5rVQQRLr50zRx0G2wljh4LHHMxvsp58QqAxjz4mf1R1Dd
         I3QagX+JaD06mXuzUlgxnSrK3CigHxh5PW+fAbuMx0xWcu64ZD0K36h+Nwsy2qddBEMW
         ZHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2bpycfdO69tvhTRtma9jQs4XhE8PVrSk+wX8dAk4GKg=;
        b=KdN5VHACZMceBqS53cYzkj5PlWmLbmznenbUR+KGXk7g7wH8plqUbaS1V3hONQ7tPI
         wsZYxI7Ok9hk5o1GRPFEGl7R0UQIl9RoBn2Sf5SMoCo21c8PPsBV9cRFpXXfHdxiE3vP
         zfuz8ovfrQazD2V7ctgKKC/mImQ6EsLjYJDpZvTvDksPdMUypEnxBSiTpTXwiWZKr05t
         r3PvyaHP2JhRq5zlYBcocGZ4BzQfb4yACIRS0bUlSCaCei6q1pZvsOmRJWxj1RpW/iCU
         BXY4hfiL2HoTrPSUGc3lfR/zLPuG7KqEuw7Q3IlEC31Fp8BDHYPyQ0/NYsmCZZjYEGH0
         W9ag==
X-Gm-Message-State: AOAM530s0T5zccvnM3KOD09FnKaaMSJum/kepXQ4eOho9lPeHHMv2rss
        f8AFLR0XoC+DAng/XzPrNBd5mJutBtnYg45M8wQ=
X-Google-Smtp-Source: ABdhPJz62UNKDL3EQx25/fJU7ZUL4shhcMWUq3o+UMRNp9L0dSoFfAXNDVxCOJS9SOuD3atqwlyX1v0at3Kg8XoRyTw=
X-Received: by 2002:a25:b7c6:: with SMTP id u6mr31287242ybj.16.1632155736231;
 Mon, 20 Sep 2021 09:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <CADVatmPB9-oKd=ypvj25UYysVo6EZhQ6bCM7EvztQBMyiZfAyw@mail.gmail.com>
 <20210903160302.yh42vpkuob45dbpb@gilmour> <CADVatmMqT1yq3YHBzt4-VsL8uVHUULmy2gpaH27rAqimao2i_A@mail.gmail.com>
 <20210904091050.g5axxctgelciihjn@gilmour> <CADVatmN+9euG5Fegor1+kaSPewbW8vRwBgnxmr5SsK3mOE6FEg@mail.gmail.com>
 <20210920144730.d7oabqfbx7pmyyfb@gilmour> <20210920154333.vunyxeshdb7jt5ka@gilmour>
 <20210920155350.h6624mt65vwg72p2@gilmour>
In-Reply-To: <20210920155350.h6624mt65vwg72p2@gilmour>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 20 Sep 2021 17:35:00 +0100
Message-ID: <CADVatmNi+jN+EwiWuoDoocZFyErDVNt1ND0BxtjuKiV63aNuJg@mail.gmail.com>
Subject: Re: Regression with mainline kernel on rpi4
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 4:53 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Mon, Sep 20, 2021 at 05:43:33PM +0200, Maxime Ripard wrote:
> > On Mon, Sep 20, 2021 at 04:47:31PM +0200, Maxime Ripard wrote:
> > > On Sat, Sep 04, 2021 at 10:40:29AM +0100, Sudip Mukherjee wrote:
> > > > Hi Maxime,
> > > >
> > > > On Sat, Sep 4, 2021 at 10:10 AM Maxime Ripard <maxime@cerno.tech> wrote:
> > > > >
> > > > > On Fri, Sep 03, 2021 at 09:09:50PM +0100, Sudip Mukherjee wrote:
> > > > > > Hi Maxime,
> > > > > >
> > > > > > On Fri, Sep 3, 2021 at 5:03 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > > > > >
> > > > > > > Hi Sudip,
> > > > > > >
> > > > > > > On Thu, Sep 02, 2021 at 10:08:19AM +0100, Sudip Mukherjee wrote:
> > > > > > > > Hi All,
> > > > > > > >
> > > > > > >
> > > > > >
> > > > > > <snip>
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > You can see the complete dmesg at
> > > > > > > > https://openqa.qa.codethink.co.uk/tests/76#step/dmesg/8
> > > > > > >
> > > > > > > What test were you running?
> > > > > >
> > > > > > Nothing particular, its just a boot test that we do every night after
> > > > > > pulling from torvalds/linux.git
> > > > >
> > > > > What are you booting to then?
> > > >
> > > > I am not sure I understood the question.
> > > > Its an Ubuntu image. The desktop environment is gnome. And as
> > > > mentioned earlier, we use the HEAD of linus tree every night to boot
> > > > the rpi4 and test that we can login via desktop environment and that
> > > > there is no regression in dmesg.
> > >
> > > Looking at the CI, this isn't from a RPi but from qemu?

No, this is from rpi4 board (4GB), not qemu. The CI is a little
complicated here, lava boots the board with the new kernel and will
then trigger the openQA job. openQA will then connect to the board
using vnc to test the desktop. This is the last link that I sent to
Linus when he asked for it.
https://lava.qa.codethink.co.uk/scheduler/job/164#L1356

And this is the lava job for today -
https://lava.qa.codethink.co.uk/scheduler/job/173

> > >
> > > What defconfig are you using? How did you generate the Ubuntu image?
> > > Through debootstrap? Any additional package?

Its the default ubuntu config. I can send you the config if you want.

> >
> > So qemu (at least on Fedora 34) doesn't seem to have an RPI4 target, nor
> > upstream:
> > https://github.com/qemu/qemu/blob/079b1252e9de384385c9da910262312ec2e574c8/hw/arm/raspi.c#L367
> >

Like I said, its not on qemu.

> > I've tested an Ubuntu 21.04 arm64 build (since it seems like it's what
> > you've been using), built using debootstrap + ubuntu-desktop, both with
> > and without a monitor attached, and up to the desktop once logged in.

I am using the official ubuntu image downloaded from
https://cdimage.ubuntu.com/releases/21.04/release/ubuntu-21.04-preinstalled-desktop-arm64+raspi.img.xz


-- 
Regards
Sudip
