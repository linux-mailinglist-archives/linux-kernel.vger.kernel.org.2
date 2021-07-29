Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341323DA1F0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 13:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbhG2LSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 07:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236244AbhG2LSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 07:18:11 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3393CC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 04:18:07 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id hs10so1401402ejc.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 04:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=65ZwwJqLgs4c9HtCALozYsS5NsihCPZf/ynWKHwUyR8=;
        b=KzMZFRO6hmvgYKId5o3d7SOQb8EMTg17Lt7c87ajkq3mxdsrAnZuzjd78zV0hB5Ak3
         RuFRi/DPGHSeLWQzsrOq8Zd1HeQ2O8CeHk0XTbJtxEGCyWC7asw5mHDbHXgFdTiXRE8N
         XGJ29IMNwRmw0twXFXZkQcrCvoXJLz/XngDGdADdW7jHpe+J/6pruVphVa6LRvJHmewK
         /hLCmSB0eIdXXBmW5mIucvOw2q31pAjUa8YFBq2I3h02fldHSdy2aqyUcFe2mihrB1eG
         TDt65ZvGSiD1eIJ7QY4RhbmAuF26F2phzx/LqqecLEDMpBbsu5/2f6HBamAYpIiIctO0
         VfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=65ZwwJqLgs4c9HtCALozYsS5NsihCPZf/ynWKHwUyR8=;
        b=YrnGyxVFVLq1uchtfH6mAZ9E5F+1ZXxk/kAvDliVwTWG56Sr8GH/sr9kOoGjuo/ZYw
         Lmi0O+UFFG8EMvoWwBv2S0C5mC+gupMmIVZbbJCclqyb9CSgMhwfsMlleA4a9PdtSjvr
         frBFQnWHQz+OvjuJKACQHJ9d7fXI6wnI6tqQTv6AsVm7SqLkEmcFbuA1byQ+NzZ1B6Bx
         OPiVCcLAjFcm+ZbpsIR0u969dYVlmayVzfVaYcAXkKdUffTvyuw9WSvUgifWdAqUbYiU
         sZRmpBzYxMAhw0JrH4P3aKRpj9HsVygU9GGadpu/8Gokh+Nbpn3SQaqOs51V4SoXJw+e
         e4Zg==
X-Gm-Message-State: AOAM5309/1z7DU4CaLYjW+AyZs+SKM/ITwyu21S6/IFHzJUL1Jsj6ffw
        hHKDppa3NB7o6mQlsTSOfOWeYSSePpUojR3qRxMZlA==
X-Google-Smtp-Source: ABdhPJySfQ1NPMpN+/lsPjW164mn0r8d3REf4kf9pWPQ8yyRotEZCYiRLEJVSRNfO8LG3+VSGEByagnqdZ8GMYanqTw=
X-Received: by 2002:a17:906:4fd6:: with SMTP id i22mr4214483ejw.92.1627557485657;
 Thu, 29 Jul 2021 04:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjzyG_2wGDYmwgeoQuuQ7cykJ11THf8jMrOFXZ7vXheJQ@mail.gmail.com>
 <YPGojf7hX//Wn5su@kroah.com> <568938486.33366.1626452816917.JavaMail.zimbra@nod.at>
 <CAOuPNLj1YC7gjuhyvunqnB_4JveGRyHcL9hcqKFSNKmfxVSWRA@mail.gmail.com>
 <1458549943.44607.1626686894648.JavaMail.zimbra@nod.at> <CAOuPNLh_KY4NaVWSEV2JPp8fx0iy8E1MU8GHT-w7-hMXrvSaeA@mail.gmail.com>
 <1556211076.48404.1626763215205.JavaMail.zimbra@nod.at> <CAOuPNLhti3tocN-_D7Q0QaAx5acHpb3AQyWaUKgQPNW3XWu58g@mail.gmail.com>
 <2132615832.4458.1626900868118.JavaMail.zimbra@nod.at> <CAOuPNLhCMT7QTF+QadJyGDFNshH9VjEAzWStRpe8itw7HXve=A@mail.gmail.com>
 <CAFLxGvywv29u6DJZrJxnJJmUDSQ4xpbT0u5LNKY1uGKyQom+WA@mail.gmail.com>
In-Reply-To: <CAFLxGvywv29u6DJZrJxnJJmUDSQ4xpbT0u5LNKY1uGKyQom+WA@mail.gmail.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Thu, 29 Jul 2021 08:17:53 -0300
Message-ID: <CAAEAJfCY+X-G=7Oe9NqrJ4yQZ29DBA78jOFAX44GD0g6=s7qhg@mail.gmail.com>
Subject: Re: MTD: How to get actual image size from MTD partition
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Pintu Agarwal <pintu.ping@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Greg KH <greg@kroah.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Sean Nyekjaer <sean@geanix.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Tue, 27 Jul 2021 at 18:16, Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> On Thu, Jul 22, 2021 at 1:11 PM Pintu Agarwal <pintu.ping@gmail.com> wrot=
e:
> >
> > On Thu, 22 Jul 2021 at 02:24, Richard Weinberger <richard@nod.at> wrote=
:
> > >
> > > ----- Urspr=C3=BCngliche Mail -----
> > > >> But let me advertise ubiblock a second time.
> > > > Sorry, I could not understand about the ubiblock request. Is it
> > > > possible to elaborate little more ?
> > > > We are already using squashfs on top of our UBI volumes (including
> > > > rootfs mounting).
> > > > This is the kernel command line we pass:
> > > > rootfstype=3Dsquashfs root=3D/dev/mtdblock44 ubi.mtd=3D40,0,30
> > > > And CONFIG_MTD_UBI_BLOCK=3Dy is already enabled in our kernel.
> > > > Do we need to do something different for ubiblock ?
> > >
> > > From that command line I understand that you are *not* using squashfs=
 on top of UBI.
> > > You use mtdblock. ubiblock is a mechanism to turn an UBI volume into =
a read-only
> > > block device.
> > > See: http://www.linux-mtd.infradead.org/doc/ubi.html#L_ubiblock
> > >
[snip]

Ouch, so surprised that after all these years someone is doing squashfs/mtd=
block
instead of using ubiblock :-)

Can we patch either Kconfig or add some warn_once on mtdblock
usage, suggesting to use ubiblock instead?

I remember there was still some use case(s) for mtdblock but I can't rememb=
er
now what was it, perhaps we should document the expectations?
(Is that for JFFS2 to mount?)

Thanks,
Ezequiel
