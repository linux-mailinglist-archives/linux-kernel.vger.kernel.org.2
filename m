Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B064F4145CB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 12:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbhIVKMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 06:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbhIVKMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 06:12:40 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2048C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 03:11:10 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c7so7968338qka.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 03:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GhM/Y9+D46gEUTZuvdjvNsvZPusW0NadobRSHJLoxtc=;
        b=HW5VgJq/zJoEgNjzWbxTVt1iZYATwQEDmk3nFl9IpkVB2Hq4/gNkxiavTHj7fazATW
         EJkiwhq8d4KvaNpD9guKy9nkfmrn6YHEue1LgN+fykp0/n67Qbfk57cFWqF2mlwVJP72
         xB23LiheYy2XlaqFF0jVk+vIArzPlTvHewxpWg57wg/fng4pRn/FAKaDVJNa2fY5kzpZ
         RGuAoIrlZK0ckrdS0HGmqRmeLJHYsgy1mlDbDtcoWvI7nuv8B1yGxYUggvPDcVxAzXDi
         WrNOGbGnZ8lHGRQaK0i/Wx420GW4Cq+75OABIvbMP2UP85/SHbUwAJ7gH0O7AIk121FP
         FSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GhM/Y9+D46gEUTZuvdjvNsvZPusW0NadobRSHJLoxtc=;
        b=XKAGegrXLen5dNiYdbLinEhJdIUlqzumy+I5yLh7fZDEk/148zUN19rgeGTnN0NuII
         9DZ0K3OkP0yMLhAGVSjE3ZRPDB+eElnuMZTAQzKjHu60ZG+ZVEYrs4F9oscIkSNeFj8Z
         CScnJqVrSLGqxBZoIPRIg5s0ucFgPeEuOWsJzAHV3Wm9VotYEoqt7M+S1rD6XdJo0TpB
         n6wqduxXYOdejcgo8eFfO1zx2OJ72IBiLmRPy8jptTFWVS2pi7g1VTud+MzU1vGNum6Q
         mu+M+TMfr0v8BN2HS+Uisu9piOxBDZ91POvI5Osz7ZpeEAPFR84PeKrptELtc8Jc1xYK
         rB9g==
X-Gm-Message-State: AOAM531rUS/DqXfFo77RzD1yummKfIZ2AYwk4Ebkq1RmzAa8LPOZomyc
        i8R1bmSMM+AhZ22OKbxsougZjk2JiWpT6+VS/9FF1P9DhwM=
X-Google-Smtp-Source: ABdhPJyJYmPaDIEbIiIUHUc3UtJIN7euSfGCYm2UWbHitWQvVOxU5h782ui7x6Bz1M2Tk/Xc7TlalOQSNNVX/RX4J3Y=
X-Received: by 2002:a25:b7c6:: with SMTP id u6mr42516756ybj.16.1632305469985;
 Wed, 22 Sep 2021 03:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210903160302.yh42vpkuob45dbpb@gilmour> <CADVatmMqT1yq3YHBzt4-VsL8uVHUULmy2gpaH27rAqimao2i_A@mail.gmail.com>
 <20210904091050.g5axxctgelciihjn@gilmour> <CADVatmN+9euG5Fegor1+kaSPewbW8vRwBgnxmr5SsK3mOE6FEg@mail.gmail.com>
 <20210920144730.d7oabqfbx7pmyyfb@gilmour> <20210920154333.vunyxeshdb7jt5ka@gilmour>
 <20210920155350.h6624mt65vwg72p2@gilmour> <CADVatmNi+jN+EwiWuoDoocZFyErDVNt1ND0BxtjuKiV63aNuJg@mail.gmail.com>
 <20210920171042.oq3ndp3ox4xv5odh@gilmour> <CADVatmOs7Cc1EdCZXMyXcWM-3-J4bU_3zF1thkOohVUL-G6ZrQ@mail.gmail.com>
 <20210922095725.dk4vk42zb3kh7y6s@gilmour>
In-Reply-To: <20210922095725.dk4vk42zb3kh7y6s@gilmour>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Wed, 22 Sep 2021 11:10:34 +0100
Message-ID: <CADVatmOMV5gMhCuoP65O9mbW639x5=0+bGh92WVL8FFX2Mvu3w@mail.gmail.com>
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

On Wed, Sep 22, 2021 at 10:57 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Mon, Sep 20, 2021 at 06:21:42PM +0100, Sudip Mukherjee wrote:
> > On Mon, Sep 20, 2021 at 6:10 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > >
> > > On Mon, Sep 20, 2021 at 05:35:00PM +0100, Sudip Mukherjee wrote:
> > > > On Mon, Sep 20, 2021 at 4:53 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > > >
> > > > > On Mon, Sep 20, 2021 at 05:43:33PM +0200, Maxime Ripard wrote:
> > > > > > On Mon, Sep 20, 2021 at 04:47:31PM +0200, Maxime Ripard wrote:
> > > > > > > On Sat, Sep 04, 2021 at 10:40:29AM +0100, Sudip Mukherjee wrote:
> > > > > > > > Hi Maxime,
> > > > > > > >
> > > > > > > > On Sat, Sep 4, 2021 at 10:10 AM Maxime Ripard <maxime@cerno.tech> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Sep 03, 2021 at 09:09:50PM +0100, Sudip Mukherjee wrote:
> > > > > > > > > > Hi Maxime,
> > > > > > > > > >
> > > > > > > > > > On Fri, Sep 3, 2021 at 5:03 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Sudip,
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Sep 02, 2021 at 10:08:19AM +0100, Sudip Mukherjee wrote:
> > > > > > > > > > > > Hi All,
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > <snip>
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > You can see the complete dmesg at
> > > > > > > > > > > > https://openqa.qa.codethink.co.uk/tests/76#step/dmesg/8
> > > > > > > > > > >
> > > > > > > > > > > What test were you running?
> > > > > > > > > >
> > > > > > > > > > Nothing particular, its just a boot test that we do every night after
> > > > > > > > > > pulling from torvalds/linux.git
> > > > > > > > >
> > > > > > > > > What are you booting to then?
> > > > > > > >
> > > > > > > > I am not sure I understood the question.
> > > > > > > > Its an Ubuntu image. The desktop environment is gnome. And as
> > > > > > > > mentioned earlier, we use the HEAD of linus tree every night to boot
> > > > > > > > the rpi4 and test that we can login via desktop environment and that
> > > > > > > > there is no regression in dmesg.
> > > > > > >
> > > > > > > Looking at the CI, this isn't from a RPi but from qemu?
> > > >
> > > > No, this is from rpi4 board (4GB), not qemu. The CI is a little
> > > > complicated here, lava boots the board with the new kernel and will
> > > > then trigger the openQA job. openQA will then connect to the board
> > > > using vnc to test the desktop. This is the last link that I sent to
> > > > Linus when he asked for it.
> > > > https://lava.qa.codethink.co.uk/scheduler/job/164#L1356
> > > >
> > > > And this is the lava job for today -
> > > > https://lava.qa.codethink.co.uk/scheduler/job/173
> > >
> > > Is it connected to a monitor then?
> >
> > Missed replying to this one earlier. I have a hdmi lilliput monitor
> > connected to it.
> >
> > >
> > > > > > >
> > > > > > > What defconfig are you using? How did you generate the Ubuntu image?
> > > > > > > Through debootstrap? Any additional package?
> > > >
> > > > Its the default ubuntu config. I can send you the config if you want.
> > >
> > > Yes, please.
> >
> > Attached.
> > My build script will copy this config as .config,  do olddefconfig
> > and then build.
>
> I still can't reproduce it.
>
> What other customisations did you do to that image? It looks like
> there's some customs scripts in there (test-mainline.sh), what are they
> doing?

That test script is triggering the openqa job, but its running only
after lava is able to login. The trace is appearing before the login
prompt even, so test_mainline.sh should not matter here.
The only customization done to the default ubuntu image is the initrd.
Can you please try with the initrd from
https://elisa-builder-00.iol.unh.edu/kernel/mainline/rpi4/initrd.gz..
I will check with another board also.


-- 
Regards
Sudip
