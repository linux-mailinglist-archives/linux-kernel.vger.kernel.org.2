Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E213809C4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 14:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbhENMmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 08:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbhENMmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 08:42:10 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A492C061574;
        Fri, 14 May 2021 05:40:59 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id m12so44509590eja.2;
        Fri, 14 May 2021 05:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZRgxo40I0rFkPz9jj0XkTv1Hdun+JJ86V3E35MkpYOs=;
        b=ZdNaVU/91J3Xj9s5FgcJdmCHyV3xXFwtzy5RHn1/DnU9Z4XViNO+fUvGG5/0feJ+AB
         LebfDxnR3pjrVML4Sb/eg8or05q/9ElKG03p22xlYuXHDEXLKrpso6k5hbG5IpAh+cp0
         H/sZxerhS3Myh5iNbdfO81H87jbyuZ0SwDh3fzAmzbGZLATcnNe5S84b+MUDCNqYoCPC
         veLtxU06DPrbwfYkc0XY2MnsVDO1O9DEOLcLToVFaiuH1sreo5Jz9tgrO8qTi02Ib0MI
         eqcv8Gg8gbRQd0Kkj4CFdMCFS7ii1owB04DOu8DgwqlWmITudTKbjQew1di2KNXUozhc
         Dn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZRgxo40I0rFkPz9jj0XkTv1Hdun+JJ86V3E35MkpYOs=;
        b=Fb36/8HLYLevKtzkpsrm+IEtD2gAe8kyyW0rzJS8tJVd2JoKQUbeXSFSxGAgUeWdV2
         3yNBKqUom0Hk39pH+UqNMGvtapo5r0+NiXsJ4/YyNd2ERcjKn0//traXgkdV7nCQp4A5
         IOh/gHt2q7Jpmoky1Zoh0yM9vIac3R4Pd324R2jttCjqPSiScN4DCANDN3vlWGSqoa0G
         dQ1WoX414dChDpgxCpGvnF7xEH2nmgMl6HaeIVYQe2q1PkuN/Tyokkobev5+g4oaRlwR
         28DVZtqkKsaHB5CEeqjxcYcWW7Autix+UsuMC6X5SAWh4L1y8l9aaSFNh5R7lB/6z3Yr
         9qSQ==
X-Gm-Message-State: AOAM532zanQBiK9NcIWJ0DLWsvJDPySx9Ig69XQvzSwvDpKL/aAivwXE
        m1PaGkl+pTHWLzFkTVj5R2oYZQ3KdOokmlIRWKk=
X-Google-Smtp-Source: ABdhPJzekAgyAtw9dhd50jNzlzFqVhRY6bC+nzVb6DmPoXScHsZ+L+g6xLgkWFqsplLN1G4MOmnN1yav2W0BJTw+t/Q=
X-Received: by 2002:a17:906:980f:: with SMTP id lm15mr36825664ejb.337.1620996057775;
 Fri, 14 May 2021 05:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210514123425.6345-1-mudongliangabcd@gmail.com> <YJ5u2oEjJyF+e0JU@kroah.com>
In-Reply-To: <YJ5u2oEjJyF+e0JU@kroah.com>
From:   =?UTF-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Date:   Fri, 14 May 2021 20:40:20 +0800
Message-ID: <CAD-N9QXxq5_ghgrvxGWZQ6Nc0hvE9kQhoFGaGg8ELGMc4Ew9=Q@mail.gmail.com>
Subject: Re: [PATCH v2] misc/uss720: fix memory leak in uss720_probe
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+636c58f40a86b4a879e7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 8:36 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, May 14, 2021 at 08:34:25PM +0800, Dongliang Mu wrote:
> > uss720_probe forgets to decrease the refcount of usbdev in uss720_probe.
> > Fix this by decreasing the refcount of usbdev by usb_put_dev.
> >
> > BUG: memory leak
> > unreferenced object 0xffff888101113800 (size 2048):
> >   comm "kworker/0:1", pid 7, jiffies 4294956777 (age 28.870s)
> >   hex dump (first 32 bytes):
> >     ff ff ff ff 31 00 00 00 00 00 00 00 00 00 00 00  ....1...........
> >     00 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00  ................
> >   backtrace:
> >     [<ffffffff82b8e822>] kmalloc include/linux/slab.h:554 [inline]
> >     [<ffffffff82b8e822>] kzalloc include/linux/slab.h:684 [inline]
> >     [<ffffffff82b8e822>] usb_alloc_dev+0x32/0x450 drivers/usb/core/usb.c:582
> >     [<ffffffff82b98441>] hub_port_connect drivers/usb/core/hub.c:5129 [inline]
> >     [<ffffffff82b98441>] hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
> >     [<ffffffff82b98441>] port_event drivers/usb/core/hub.c:5509 [inline]
> >     [<ffffffff82b98441>] hub_event+0x1171/0x20c0 drivers/usb/core/hub.c:5591
> >     [<ffffffff81259229>] process_one_work+0x2c9/0x600 kernel/workqueue.c:2275
> >     [<ffffffff81259b19>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2421
> >     [<ffffffff81261228>] kthread+0x178/0x1b0 kernel/kthread.c:292
> >     [<ffffffff8100227f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> >
> > Reported-by: syzbot+636c58f40a86b4a879e7@syzkaller.appspotmail.com
> > Fixes: 0f36163d3abe ("usb: fix uss720 schedule with interrupts off")
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >  drivers/usb/misc/uss720.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> What changed from v1?  That always goes below the --- line.
>

I just added the Fixes tag as we discussed. "That" means what? The changes?

> Please fix and send a v3.
>
> thanks,
>
> greg k-h
