Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD8A440099
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 18:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhJ2Qvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 12:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhJ2Qv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 12:51:28 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315BAC061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 09:48:59 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ee16so27711586edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 09:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TcdDCTnshuOVSyDW/uKIGCO0k0Q0QuNljv9FfVgGquU=;
        b=XW/nwR1DaprA+6lvFbPBCOd0bN3lJVEF9cYWuEn9m8pW5LxK3WuFsM11Z69u6vxXiO
         ztz3pSaA+w+pHCxDWruKBK5LuME726e2So8Gd4Q69RDZiFlXB0Tai0zfVV3ODIeBLz1w
         jZucDCDXy0v4fAyxVxPAeM7YwfvgsjR4IQmZNramZY2ynRWf9+jW7xkg3XxpIWmBvZJD
         8jaxGQK/OkgiysxA0EyvKupk0tRlkACraeI4VgFkFhwVoP9h4iOB5Q6n0AFyUUomukqL
         YJi/krR3ClQ9zhT3WJsDk867aNKGzp8e8b8NlJj3uxFUmKefKhw6ni07wxDj34MX9M9P
         gZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TcdDCTnshuOVSyDW/uKIGCO0k0Q0QuNljv9FfVgGquU=;
        b=lsuscvNhZQ1FHTwaB8VTfqhZGr/7uWGxdeZ4SetdM92gnZD04ppzgaacxyF0ZxAe0S
         Fo4wEjsF53OxueBXXii9YXAFtPLTpyfRDzseLU3ORUeU7HtFMkz/dcVONgTv0HVIEu61
         E6VgFKVyR7yGiXZ6894qMlwbJD+ggP6ivDzTxO/rWFlp+xkNgt4MetmFlcbAMclpD5Bb
         LyKRxGb+qlbMyQNGpWZXpFYk79JlGQ5RANHOzwEiwLBVS1Qho04+iSIMUp563jdfGpCr
         E3BDWg28ZIswqNGmiMAo5FL0U7tXINsAwKKHKS0sd7Q4N+uFn4UP3OJc5/cmqsi1IYTY
         QeEw==
X-Gm-Message-State: AOAM530liaJDpHC8+tM4uOc2RI6iKsnBPtphM1PnZBLWf9RXSDtJ9xzo
        6tjTGKXS/8ghUZYoDQJXaOSkyVBtVOrk0mhXcHwCzj9NlepnQQ==
X-Google-Smtp-Source: ABdhPJxwvPySxfNfECgzOG4aRpUBvpfyeS07DGP4QZYA33DPlucAZRZ0p250pR1OaoRjcS21Y5oyuztLavgnQ1qombI=
X-Received: by 2002:a17:906:e011:: with SMTP id cu17mr15540749ejb.244.1635526137764;
 Fri, 29 Oct 2021 09:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjzyG_2wGDYmwgeoQuuQ7cykJ11THf8jMrOFXZ7vXheJQ@mail.gmail.com>
 <CAOuPNLh_KY4NaVWSEV2JPp8fx0iy8E1MU8GHT-w7-hMXrvSaeA@mail.gmail.com>
 <1556211076.48404.1626763215205.JavaMail.zimbra@nod.at> <CAOuPNLhti3tocN-_D7Q0QaAx5acHpb3AQyWaUKgQPNW3XWu58g@mail.gmail.com>
 <2132615832.4458.1626900868118.JavaMail.zimbra@nod.at> <CAOuPNLhCMT7QTF+QadJyGDFNshH9VjEAzWStRpe8itw7HXve=A@mail.gmail.com>
 <CAFLxGvywv29u6DJZrJxnJJmUDSQ4xpbT0u5LNKY1uGKyQom+WA@mail.gmail.com>
 <CAAEAJfCY+X-G=7Oe9NqrJ4yQZ29DBA78jOFAX44GD0g6=s7qhg@mail.gmail.com>
 <1668790824.35266.1627559144878.JavaMail.zimbra@nod.at> <CAAEAJfDDtGcUquyP7Jn0Urttt4kSfAQbJ_qPQ90ROtWLavW9EA@mail.gmail.com>
 <CAOuPNLj+DSigRY_AgHQnGKCK-Vm4ykQBR8UfnTi2UObORTcBFg@mail.gmail.com>
 <CAOuPNLgfJGzp-RJBjydFDL1ZAvOd7=-MgXhnsb2eb_xFSLC66w@mail.gmail.com>
 <CAAEAJfBuut7VSbrrz6CxOC+Cke36eGGv8VUvfdbfLwvSBxOAAA@mail.gmail.com>
 <CAOuPNLjJMCyxK8mvnBo2aZQXSNqY47YeXCxWmtPECq-=csz6bQ@mail.gmail.com> <CAOuPNLghc1ktLrOEf8PN+snMB3QZG-LwzPbd3kGzrhGz8mEAVg@mail.gmail.com>
In-Reply-To: <CAOuPNLghc1ktLrOEf8PN+snMB3QZG-LwzPbd3kGzrhGz8mEAVg@mail.gmail.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Fri, 29 Oct 2021 13:48:46 -0300
Message-ID: <CAAEAJfDS3FK19xMs-7LcEjDe7Fx1XW6HZJGyb6Ff=zs2ZKHpJA@mail.gmail.com>
Subject: Re: MTD: How to get actual image size from MTD partition
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Greg KH <greg@kroah.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Sean Nyekjaer <sean@geanix.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2021 at 13:13, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> Hi All,
>
> On Mon, 30 Aug 2021 at 21:28, Pintu Agarwal <pintu.ping@gmail.com> wrote:
> >
> > On Sun, 22 Aug 2021 at 19:51, Ezequiel Garcia
> > <ezequiel@vanguardiasur.com.ar> wrote:
> >
> > > In other words, IMO it's best to expose the NAND through UBI
> > > for both read-only and read-write access, using a single UBI device,
> > > and then creating UBI volumes as needed. This will allow UBI
> > > to spread wear leveling across the whole device, which is expected
> > > to increase the flash lifetime.
> > >
> > > For instance, just as some silly example, you could have something like this:
> > >
> > >                                | RootFS SquashFS  |
> > >                                | UBI block        | UBIFS User R-W area
> > > ------------------------------------------------------------------------
> > > Kernel A | Kernel B | RootFS A | RootFS B         | User
> > > ------------------------------------------------------------------------
> > >                                  UBIX
> > > ------------------------------------------------------------------------
> > >                                  /dev/mtdX
> > >
> > > This setup allows safe kernel and rootfs upgrading. The RootFS is read-only
> > > via SquashFS and there's a read-write user area. UBI is supporting all
> > > the volumes, handling bad blocks and wear leveling.
> > >
> > Dear Ezequiel,
> > Thank you so much for your reply.
> >
> > This is exactly what we are also doing :)
> > In our system we have a mix of raw and ubi partitions.
> > The ubi partitioning is done almost exactly the same way.
> > Only for the rootfs (squashfs) I see we were using /mtd/block<id> to
> > mount the rootfs.
> > Now, I understood we should change it to use /dev/ubiblock<id>
> > This might have several benefits, but one most important could be,
> > using ubiblock can handle bad-blocks/wear-leveling automatically,
> > whereas mtdblocks access the flash directly ?
> > I found some references for these..
> > So, this seems good for my proposal.
> >
> > Another thing that is still open for us is:
> > How do we calculate the exact image size from a raw mtd partition ?
> > For example, support for one of the raw nand partitions, the size is
> > defined as 15MB but we flash the actual image of size only 2.5MB.
> > So, in the runtime how to determine the image size as ~2.5MB (at least
> > roughly) ?
> > Is it still possible ?
> >
>
> I am happy to inform you that using "ubiblock" for squashfs mounting
> seems very helpful for us.
> We have seen almost the double performance boost when using ubiblock
> for rootfs as well as other read-only volume mounting.
>
> However, we have found few issues while defining the read only volume as STATIC.
> With static volume we see that OTA update is failing during "fsync".
> That is ota_fsync is failing from here:
> https://gerrit.pixelexperience.org/plugins/gitiles/bootable_recovery/+/ff6df890a2a01bf3bf56d3f430b17a5ef69055cf%5E%21/otafault/ota_io.cpp
> int status = fsync(fd);
> if (status == -1 && errno == EIO)
> *
> { have_eio_error = true; }
> *
> return status;
> }
>
> Is this the known issue with static volume?
>

I don't know exactly how you are updating your volume,
the right way is using UBI_IOCVOLUP.

See http://www.linux-mtd.infradead.org/doc/ubi.html#L_volupdate

If you google around I'm sure you'll find some articles about this,
but I'm not sure if they'll go into details and subtleties.

There are probably a few different ways to do firmware upgrade
when you are on top of static volumes (and you want to be on top
of static volumes if it's read-only, because AFAIK they give you an
extra data-integrity guarantee).

One way, would be to have two static volumes A/B. The system
uses normally the A volume, and then you doUBI_IOCVOLUP
(or ubiupdatevol) to update the B volume. After the update is succesful
you run the atomic volume rename and flip A->B, B->A.

(If you don't have enough space to hold two A/B volumes....
 ... you'll have to find some other solution, I have no idea about that.)

Hope it helps,
Eze
