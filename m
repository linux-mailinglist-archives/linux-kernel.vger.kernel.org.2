Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FA03799F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 00:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbhEJWV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 18:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhEJWVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 18:21:19 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928C1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 15:20:13 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id l19so15446152ilk.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 15:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FN6iTMK7hIktHgqpc3ijQCBqrZ7ymkqilRRyERzJDvQ=;
        b=L8xQzuassvepilB0T3g/2/n8rUnojrY5tdSLtg53gqWpHMXciFdQvy+Lpb/sDxRFJb
         Y1K2iMhw48lBTTNFo3Md3DUZvbvZfzHTj9+elm+IZ6K+om4luDBsTJQdPKM2CCl7KdyU
         ef6+Vs2ioXCRqh6ht44VLcga1OBAGqHC0Tt+t4f78HJ8vrI5uWVY0jhlW1K1ZIOsEUWd
         lStHRh8Ol+2lKzsPSPu8AJbCSoRfHBwiGwgGo0Vu0+kJe8C663G57N1NK+zYKxhFriUr
         6Pd5LhM1WBdHViqiK9w4eCKi4LvtwOIhLugablxxRpH2/ytOBN8iubw0cjUJ3lMBsL/V
         s8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FN6iTMK7hIktHgqpc3ijQCBqrZ7ymkqilRRyERzJDvQ=;
        b=qTA6CD1CAbz/256DxlNjraue89aq2xGeA7MaFuFzLXK9gYlZWqHx6jxLiU9dFhJGPS
         Gi2N8MpEGJcgfbo6sjSr6C5wWDwOo0ksXG5Yl4AReoDgfmXqXUpuXs0vKYBcS/mwicZI
         pNRRO3H1Y+5rCqSGIZVJ5UOfihwLTHoXiBNKabvqoMub4QYH1eu5lc0h8Vr5u1iivRsO
         BxmhE2TzXjW4a19YUoBvsoKecdN2Hzwc0VSVc/9xn+ct3PgZ4RfsRHpbmqhF7seDJhbY
         0iqM7Ooct3jvtD5oLO5XEdgIv7KVUso0yuzDK2m58DLu5grbzNhgb2o9zG2/6D6qEsq5
         yCPw==
X-Gm-Message-State: AOAM530+WKJ4aOcnYn9bGAjRlixhxKQd7jlpwXwqSgs3jhhw7zZUQMlB
        rxKmjhmp8PQ5tcT/ygoEVYuHJB4WXroWZuf0/s2cUBJgL+Pv682u
X-Google-Smtp-Source: ABdhPJyP9qSWNxy3zUAtBWjTSo93UqAgjrdvNCerFZGPU4OQFbWkOTaudyi/h5BG6qwux29+eAQ2XS7kO9S+82XtYB8=
X-Received: by 2002:a92:c8d2:: with SMTP id c18mr23985639ilq.81.1620685213064;
 Mon, 10 May 2021 15:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210426220728.1230340-1-ztong0001@gmail.com> <YJlE+Z2VKhamVWaw@kroah.com>
In-Reply-To: <YJlE+Z2VKhamVWaw@kroah.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Mon, 10 May 2021 15:20:02 -0700
Message-ID: <CAA5qM4CAdb_Aaay1_gjy_AC48Doxtga0f69E1P36=8vscsR9Eg@mail.gmail.com>
Subject: Re: [PATCH] misc: alcor_pci: fix null-ptr-deref when there is no PCI bridge
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 7:36 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Apr 26, 2021 at 06:07:27PM -0400, Tong Zhang wrote:
> > the PCI bridge might be NULL, so we'd better check before use it
> >
> > [    1.246492] BUG: kernel NULL pointer dereference, address: 00000000000000c0
> > [    1.248731] RIP: 0010:pci_read_config_byte+0x5/0x40
> > [    1.253998] Call Trace:
> > [    1.254131]  ? alcor_pci_find_cap_offset.isra.0+0x3a/0x100 [alcor_pci]
> > [    1.254476]  alcor_pci_probe+0x169/0x2d5 [alcor_pci]
> >
> > Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> > ---
> >  drivers/misc/cardreader/alcor_pci.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/misc/cardreader/alcor_pci.c b/drivers/misc/cardreader/alcor_pci.c
> > index cd402c89189e..1c33453fd5c7 100644
> > --- a/drivers/misc/cardreader/alcor_pci.c
> > +++ b/drivers/misc/cardreader/alcor_pci.c
> > @@ -102,6 +102,9 @@ static int alcor_pci_find_cap_offset(struct alcor_pci_priv *priv,
> >       u8 val8;
> >       u32 val32;
> >
> > +     if (!pci)
> > +             return 0;
> > +
> >       where = ALCOR_CAP_START_OFFSET;
> >       pci_read_config_byte(pci, where, &val8);
> >       if (!val8)
> > --
> > 2.25.1
> >
>
> I do not understand, how can pci ever be NULL?  There is only 1 way this

Hi Greg,
I think the problem is with
    priv->parent_pdev = pdev->bus->self
where bus->self can be NULL. when bus->self is NULL, calling
    alcor_pci_find_cap_offset(priv, priv->parent_pdev) is equivalent
to alcor_pci_find_cap_offset(priv, NULL)

- Tong

> function can be called, and it's through the alcor_pci_probe() call,
> which should have always set up the parent and pci pointers that get
> passed to this function.
>
> How can that not happen?  If it can happen, then something earlier than
> this should be fixed instead of papering over the root problem here.
>
> How did you duplicate the crash you list above?
>
> thanks,
>
> greg k-h
