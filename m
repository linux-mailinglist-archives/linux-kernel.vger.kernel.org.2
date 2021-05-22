Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FB338D2A4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 02:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhEVAqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 20:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbhEVAqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 20:46:05 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3E5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 17:44:36 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lg14so32892715ejb.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 17:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xKufOdTA0IDQaVHCUEydAsDz+LCNGA7EJicC4zXyjAE=;
        b=JGk3UHtAI5QxjcGp02y0zo7b3sQDTM7jAlpgJjP1D2OeeSYCxi0EVBfN3+4gXl8Br+
         /HHrmyYUpszbjxoqfZQG4cz+Pl+pVo5byMq1CfBKnU+vJu5MvnKruhojl/mnUlSnIVrz
         IH5buevJO4hUrUdSMqtOX0LnoaDBpOYhUMD8btClUPiiloiAbswcuO2f5DcUNBN6I2Z6
         weSOznICMFbkkGwjEwVNacB8JLvj1JHBzP0nNLql56UU/dNRhWIN/CiNgYzA98S4ChOH
         JzuBi1+VDKwrXc2cENYFaj1MEnzpptC9dyom4psYlXnJ3zQBrwMdR2al8hGVXS+6pjiY
         RhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xKufOdTA0IDQaVHCUEydAsDz+LCNGA7EJicC4zXyjAE=;
        b=K70QLbDxGFahJ2S9lJuYqIjZ1CQ3cwLmNDlUn5Y5WEO4TFxzw9Sj7Jw2fMV5zGStYj
         vycwqVahINmW4RswfS3ErqVB54ht3B4VfAAvKXoT4GW34Fi9+yjzrDytNtPKU0DdimvN
         +aF9jhptiAE7FEjRZbgh4iK4wDFVlNXZpedU+pNYzRABIlAkzBY+O/T4t3WXg55aInXu
         7dkRvcFHcym8OlLqxTvrJWXl0dp0KPYlyr5Fua+Z2aQ/nI+fOjXxSp+nZ7WAVsPAZtpP
         xt2dETEtmktGnwqgMMrGNnQKNjJ8FGJcVMmP8A2UmOHeIbCMfvUobbCc/RtscV23Cc3F
         taiA==
X-Gm-Message-State: AOAM5313AayjIPDzQMJxD3jvRf+w12kva0CHtA/VOCdPyZDhbEiaFQy2
        sA6BzwMKKAGPck/DJce86C1TB64g53Is7x4heqE=
X-Google-Smtp-Source: ABdhPJySxFmmty9MypAq5rhbBvS1a6T3Pao+pMUqtLUfiDd6sRCF8pDdVx0MRZi4xButyiCbgl2gGtrUrQpwXq7sDfA=
X-Received: by 2002:a17:907:1002:: with SMTP id ox2mr12370999ejb.337.1621644275147;
 Fri, 21 May 2021 17:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210521162519.677074-1-mudongliangabcd@gmail.com> <YKfnjYAsNzbfJh1d@kroah.com>
In-Reply-To: <YKfnjYAsNzbfJh1d@kroah.com>
From:   =?UTF-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Date:   Sat, 22 May 2021 08:43:25 +0800
Message-ID: <CAD-N9QWiu=6QefJaWzfUS3ep-8so+KBv-=S0LQs+EqO3tf8Cew@mail.gmail.com>
Subject: Re: [PATCH v2] staging: rtl8712: Fix memory leak in r8712_init_recv_priv
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        rkovhaev@gmail.com, straube.linux@gmail.com,
        linux-staging@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+1c46f3771695bccbdb3a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2021 at 1:02 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, May 22, 2021 at 12:25:19AM +0800, Dongliang Mu wrote:
> > r871xu_dev_remove failed to call r8712_free_drv_sw() and free the
> > resource (e.g., struct urb) due to the failure of firmware loading.
> >
> > Fix this by invoking r8712_free_drv_sw at the failure site.
> >
> > Reported-by: syzbot+1c46f3771695bccbdb3a@syzkaller.appspotmail.com
> > Fixes: b4383c971bc5 ("staging: rtl8712: handle firmware load failure")
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> > v1->v2: fix the initialization of pnetdev
> >
> >  drivers/staging/rtl8712/usb_intf.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
> > index dc21e7743349..57e773464e18 100644
> > --- a/drivers/staging/rtl8712/usb_intf.c
> > +++ b/drivers/staging/rtl8712/usb_intf.c
> > @@ -593,13 +593,14 @@ static void r871xu_dev_remove(struct usb_interface *pusb_intf)
> >       struct usb_device *udev = interface_to_usbdev(pusb_intf);
> >
> >       if (pnetdev) {
> > +             struct net_device *newpnetdev = NULL;
> >               struct _adapter *padapter = netdev_priv(pnetdev);
> >
> >               /* never exit with a firmware callback pending */
> >               wait_for_completion(&padapter->rtl8712_fw_ready);
> > -             pnetdev = usb_get_intfdata(pusb_intf);
> > +             newpnetdev = usb_get_intfdata(pusb_intf);
>
> Please learn a bit more C knowledge before messing around in the kernel
> tree.  Between the mistake in this chunk you added, and the mistake in
> the previous submission, I think you need more experience here as there
> are some things you still need to learn.

I am a kernel newbie in developing patches for Linux kernel. Sorry for
my naive mistakes. I will learn more and then submit some "good"
patches.

BTW, I think I have pointed out the underlying bug here, you guys can
fix it yourself.

>
> Best of luck!
>
> greg k-h
