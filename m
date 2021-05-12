Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13CC37EB1F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379443AbhELTTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244555AbhELQut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 12:50:49 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C236AC022A93
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 09:25:06 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id c16so1763451ilo.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 09:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P9rr397rdUt7Waq5QtuqB7oSxRF8/ndzB7G5mNte1Gg=;
        b=P1UAVOpkt1FcnF9t9fBdz8VQGflGerEPqLgIBhj4ROvjbX8KETcTY/7V15JyMcx+Eh
         skR8dDqUPc5B+yJwFKygfANOKWgfJORjYXkoNqf3M2ClXm5eBKh1jEwC5R+fRWD3Ip30
         jevn7E5sg6Fj3m/tqLrPQW5zfXbdPzECFwlBuKDEzeGTKlcVFYVMHKPn9RYXNxwQVJMq
         bbs4GvuYRQAsW9mozqa3AjWaqdsNlJDPLuZOOS/vNTAjX8H4ha4EcLZ1mDsTbnb0aiue
         e9601g4WbZ4b8bFEetS7JhvAjqaq7BjcQL9YW3lt94wacUYEmPm9bc4fcTOqsHz4EXkH
         xsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P9rr397rdUt7Waq5QtuqB7oSxRF8/ndzB7G5mNte1Gg=;
        b=q2rvI8UqK0uZOHgY7NzPzY9EAXokl2ONa3jIn0M/knASv8dSG4PX8WsPxmciROrmUo
         H1BtOZtmTiE2a6TcSJvUR1RlVg3mU8Zw/H84gmX7hQsLt7O5sw7avrSKIEjlxuMZai4H
         x48gpz0iL3I0df9gygDWuvhHkfT+hljNP733sOqBWzNUqtUAv7RyuO/9s8KTtQwzzsip
         BbjUKj7+irO/3toWnF4DcNcZMBnrTO2/QRks9H58+bWRJloU1h4Qi4j3lAmnB1u2j4+L
         RNYgYLrBYiUfUAXN8ZAxXrhnJX9/R26tJrqS6+tkR6Nr01vaNXjVJy9SCEUkFR7l0B3U
         oO4A==
X-Gm-Message-State: AOAM533pQd99LGyxYGlRSLUcM7Yv6yBAizhdWDN+0lhRFFP5qLzgzyHl
        iYqovupLUb5nj+jW+0Vh5WK9eIWGdX0BMOlMWxg=
X-Google-Smtp-Source: ABdhPJzcCAokNAuu1GrA4PI1fYW7mwW4wpRwATCgxDCsG7qcmnXoVew8iUGWRkaSdsHCiMaeaXU9BDqoaQrUk0YbOUE=
X-Received: by 2002:a05:6e02:1391:: with SMTP id d17mr739348ilo.9.1620836706205;
 Wed, 12 May 2021 09:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <YJrFib6BD8JcX3DM@kroah.com> <20210511212937.1269191-1-ztong0001@gmail.com>
 <YJt0nI8lG+2juL5S@kroah.com>
In-Reply-To: <YJt0nI8lG+2juL5S@kroah.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Wed, 12 May 2021 09:24:55 -0700
Message-ID: <CAA5qM4A2-RD-cnJrGrsAcRixU0nfX7xFWDkxevDoC4TsBbkh9w@mail.gmail.com>
Subject: Re: [PATCH v2] misc: alcor_pci: fix null-ptr-deref when there is no
 PCI bridge
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 11:24 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, May 11, 2021 at 05:29:38PM -0400, Tong Zhang wrote:
> > Device might be attached to root complex directly. In this case,
> > bus->self(bridge) will be NULL, so we'd better check before use it
> >
> > [    1.246492] BUG: kernel NULL pointer dereference, address: 00000000000000c0
> > [    1.248731] RIP: 0010:pci_read_config_byte+0x5/0x40
> > [    1.253998] Call Trace:
> > [    1.254131]  ? alcor_pci_find_cap_offset.isra.0+0x3a/0x100 [alcor_pci]
> > [    1.254476]  alcor_pci_probe+0x169/0x2d5 [alcor_pci]
> >
> > Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> > Co-Developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > v2: check before calling alcor_pci_find_cap_offset()
> >
> >  drivers/misc/cardreader/alcor_pci.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/misc/cardreader/alcor_pci.c b/drivers/misc/cardreader/alcor_pci.c
> > index cd402c89189e..175c6b06f7aa 100644
> > --- a/drivers/misc/cardreader/alcor_pci.c
> > +++ b/drivers/misc/cardreader/alcor_pci.c
> > @@ -139,6 +139,9 @@ static void alcor_pci_init_check_aspm(struct alcor_pci_priv *priv)
> >       u32 val32;
> >
> >       priv->pdev_cap_off    = alcor_pci_find_cap_offset(priv, priv->pdev);
> > +
> > +     if (!priv->parent_pdev)
> > +             return;
>
> That feels wrong, you just prevented all of the remaining logic in this
> call to not be set up.  Did you test this and did the driver and device
> still work properly if it hits this check?
>
> thanks,
>
> greg k-h

Sorry, probably I misunderstood your previous email. Please correct me
if I am wrong.
What I did here is to disable ASPM completely if it is attached to the
root complex, which is OK since ASPM is optional and we cannot really
do ASPM on the root complex.
Also, alcor_pci_init_check_aspm() is responsible for checking the
device and its parent(bridge) aspm capability offset.
This function will set priv->parent_cap_off and priv->pdev_cap_off.
Those two capability offset will be used in alcor_pci_aspm_ctrl() to
determine whether the PCI link+device supports aspm or not.
In our case the pdev_cap_off remains 0 when alcor_pci_aspm_ctrl() is
called and it simply returns.
So I think it can still work.
- Tong
