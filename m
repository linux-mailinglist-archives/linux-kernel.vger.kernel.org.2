Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D223DA2C8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 14:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbhG2MDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 08:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbhG2MDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 08:03:43 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F6DC061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 05:03:38 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id f13so7801947edq.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 05:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5PqNao+LvVur5nM0wboYYWnzsoVPqlHC4aLEUSYkRe8=;
        b=02vV/yQEakIkTyXZD9abAeEHvCDnuoT3A1ic1/OunC54FJGKkJBv1H4fRFMBQfMVAu
         XOWD5tkW64NqSq7N3sE4eO/bLCm6C1zfEEU41QavjbGTWmXdRXmw2jJlTTDgYoIx6gRC
         Ox3IUbvriQygZZGNbsph59saddP5WR38z1DwF2MspP5WeDgoT/etD7cnTvKA/lbGcM9U
         g5wMzPlxtgqYoJPoteQwQOlqHmvFgkFRqWNPWc538vHyeSpwxuCIKPCX4/A6P00o7q4D
         UEazoOYyFYjOuOcR2DG+i7Q5enWsikDluSgPSe728mrbExGIZYzw9XZMwSwh5V/qL8Iw
         xNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5PqNao+LvVur5nM0wboYYWnzsoVPqlHC4aLEUSYkRe8=;
        b=QZSeSa8ybxy/Js1WzOzxh2Ka1I0Yk84bPJJwCSpsCQ2/Rg+c2gxWJCX7JBaIgcMWT6
         A1Lm01i19kpRJzCPRarvj3LkCvAWDnAxgSHb6/rgh4kGHu0gToR3GjzmAUBbfhykW0ow
         aYPyWHE0romhNZ/zW4pTmw0KB702a/E6HZYYHzxG77Xpl0f/csoQglKXwpiwq0MPW3yw
         ocEyzWXzjE1xAo0CEX2jys0haxVIwCgppBa2JlBmZFv+OScLYeA6Kgo//wjczkhFGdJg
         tFnm9BRNzjd+7uJpXffAwoIDF1M1L8iwPPbUwWAm6B//ZZ9uEZnjlaeNtfetbBKh3ypJ
         eh3w==
X-Gm-Message-State: AOAM5326T1JH0uljYmcFKUIHyNF7C0omuMsWn/Ml8QqRMZFC601nGa45
        +u2a5JMMfb4sXekF+UwUgz4QcqLVV9R/nmT6UZRwDQ==
X-Google-Smtp-Source: ABdhPJymcivsFGziq0SihV2i9nQXby5NtNXxaA1zhexuwQiwuYRDZBTYJQxO3n4NHJjRLJ2SOyCIu3Zhu+e9V+8nE7I=
X-Received: by 2002:a05:6402:4c5:: with SMTP id n5mr5580197edw.322.1627560217516;
 Thu, 29 Jul 2021 05:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjzyG_2wGDYmwgeoQuuQ7cykJ11THf8jMrOFXZ7vXheJQ@mail.gmail.com>
 <CAOuPNLh_KY4NaVWSEV2JPp8fx0iy8E1MU8GHT-w7-hMXrvSaeA@mail.gmail.com>
 <1556211076.48404.1626763215205.JavaMail.zimbra@nod.at> <CAOuPNLhti3tocN-_D7Q0QaAx5acHpb3AQyWaUKgQPNW3XWu58g@mail.gmail.com>
 <2132615832.4458.1626900868118.JavaMail.zimbra@nod.at> <CAOuPNLhCMT7QTF+QadJyGDFNshH9VjEAzWStRpe8itw7HXve=A@mail.gmail.com>
 <CAFLxGvywv29u6DJZrJxnJJmUDSQ4xpbT0u5LNKY1uGKyQom+WA@mail.gmail.com>
 <CAAEAJfCY+X-G=7Oe9NqrJ4yQZ29DBA78jOFAX44GD0g6=s7qhg@mail.gmail.com> <1668790824.35266.1627559144878.JavaMail.zimbra@nod.at>
In-Reply-To: <1668790824.35266.1627559144878.JavaMail.zimbra@nod.at>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Thu, 29 Jul 2021 09:03:26 -0300
Message-ID: <CAAEAJfDDtGcUquyP7Jn0Urttt4kSfAQbJ_qPQ90ROtWLavW9EA@mail.gmail.com>
Subject: Re: MTD: How to get actual image size from MTD partition
To:     Richard Weinberger <richard@nod.at>
Cc:     Pintu Agarwal <pintu.ping@gmail.com>,
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

On Thu, 29 Jul 2021 at 08:45, Richard Weinberger <richard@nod.at> wrote:
>
> Ezequiel,
>
> ----- Urspr=C3=BCngliche Mail -----
> > [snip]
> >
> > Ouch, so surprised that after all these years someone is doing squashfs=
/mtdblock
> > instead of using ubiblock :-)
> >
> > Can we patch either Kconfig or add some warn_once on mtdblock
> > usage, suggesting to use ubiblock instead?
>
> a hint in Kconfig makes IMHO sense. Do you want to send a patch?
> A warning is too much since on some tiny embedded system with NOR flash m=
tdblock is still
> a good choice.
> ubiblock is mostly useful for NAND flash.
>
> > I remember there was still some use case(s) for mtdblock but I can't re=
member
> > now what was it, perhaps we should document the expectations?
> > (Is that for JFFS2 to mount?)
>
> a long time ago mount didn't accept character devices, so you had to pass=
 mtdblockX to mount
> JFFS2.
> This limitation is gone.
>

OK, let me try to cook a patch for you.

Eze
