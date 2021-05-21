Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE89338C88F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhEUNpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbhEUNpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:45:06 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FD0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:43:42 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id c20so30600557ejm.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C3MV1Vf5iX+LkY9NKtecXOx3swTIZmEHhmIkAQBX6v8=;
        b=YH4t7Oeqyqc5PtUrO40l9ux8vc0c8vsAoVKaqdbjr6dufpIeMwRYuopgQgNcHO4A4T
         PcDl1in24Rnjhgz1knNxT+0ih2sGpwSrziBeq7WQTnO/u43GK5+Wlc+js4CJVLBM3Hpi
         9HjZ74As9LDOpBntcNIS4SBg9sTji0/85Nv+HetQGAGxkwP1q4Fw+hH2ZWyuSjtFtDJo
         5m01iFtAiFZISjRjI6zaQB0prEDkBrC6Sk1iYcXWumD1QAjTIWme64RnVCUAm5W0Hlre
         JMd2j3NVGmjIya1L8TU19LR8T208fipBdu8yJggv/s484X2UeFhDjsHxE3lEu3/2veQ4
         C5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C3MV1Vf5iX+LkY9NKtecXOx3swTIZmEHhmIkAQBX6v8=;
        b=TiVjyzxFXRslutRtK+alUQoSIac1U8ZNMUNebk9hU104Ftol2pVhy+AdyykVrQnMXu
         KBaxMfnkWUIQBEKz+Fhnci8zQsp2JBqp1VVS035ro1LVOermVj7VW24TMhtzKNGAvxUr
         GyOJ1bJ7tWJtv+AhSqgIOlWo3VlWTnESkZl0E1B6wn0boNc1DYA0f8YQKhWWPmVwdmbT
         Rpn4uiEFggJlRc00M7YpvmoyRE7zVjBeHvRsYPrsE1iBD5OP+ByPc/FwEbjdem4Vfw8u
         6U3Kw/g6EsvGCrWagvqPwyYnP9Hzc6NqRW6Td56kkbXIppxrZMSbvDxOS98z09ZoFOw6
         s5cA==
X-Gm-Message-State: AOAM532+JRb2888t5sHIhLX76vfTMrN+0oeeLP+/okmDvIVImVyJb7B0
        lok1tiumZ6o+zYnxQrFKH6U3Ty19w3lFQy9qJeg=
X-Google-Smtp-Source: ABdhPJwHIgjcYGnsRmn9KmY5QdPTI3MoLqfhEV2zt0JarasVYgL4OTTnDt6sq21oSyLUGwC5faswpAc/S9+pb7lsH9E=
X-Received: by 2002:a17:906:18b2:: with SMTP id c18mr10338162ejf.160.1621604621169;
 Fri, 21 May 2021 06:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210521120811.516339-1-mudongliangabcd@gmail.com>
 <YKelBRkGsLFz4byw@kroah.com> <CAD-N9QUgYy4j3wnJX1gwq902ggarFaQPBQ3cyUAArYxv22Q-bQ@mail.gmail.com>
 <YKeyl6DL9rZylbKw@kroah.com>
In-Reply-To: <YKeyl6DL9rZylbKw@kroah.com>
From:   =?UTF-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Date:   Fri, 21 May 2021 21:42:32 +0800
Message-ID: <CAD-N9QX+5aeugkPDVmZkFUG-Oup3pXWV2uvOOYK1WfJCKnt6Zg@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8712: Fix memory leak in r8712_init_recv_priv
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        rkovhaev@gmail.com, straube.linux@gmail.com,
        linux-staging@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+1c46f3771695bccbdb3a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 9:16 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, May 21, 2021 at 08:24:58PM +0800, =E6=85=95=E5=86=AC=E4=BA=AE wro=
te:
> > On Fri, May 21, 2021 at 8:18 PM Greg KH <gregkh@linuxfoundation.org> wr=
ote:
> > >
> > > On Fri, May 21, 2021 at 08:08:11PM +0800, Dongliang Mu wrote:
> > > > r871xu_dev_remove failed to call r8712_free_drv_sw() and free the
> > > > resource (e.g., struct urb) due to the failure of firmware loading.
> > > >
> > > > Fix this by invoking r8712_free_drv_sw at the failure site.
> > > >
> > > > Reported-by: syzbot+1c46f3771695bccbdb3a@syzkaller.appspotmail.com
> > > > Fixes: b4383c971bc5 ("staging: rtl8712: handle firmware load failur=
e")
> > > > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > > ---
> > > >  drivers/staging/rtl8712/usb_intf.c | 13 ++++++++++---
> > > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/r=
tl8712/usb_intf.c
> > > > index dc21e7743349..a5190b4250ce 100644
> > > > --- a/drivers/staging/rtl8712/usb_intf.c
> > > > +++ b/drivers/staging/rtl8712/usb_intf.c
> > > > @@ -589,7 +589,7 @@ static int r871xu_drv_init(struct usb_interface=
 *pusb_intf,
> > > >   */
> > > >  static void r871xu_dev_remove(struct usb_interface *pusb_intf)
> > > >  {
> > > > -     struct net_device *pnetdev =3D usb_get_intfdata(pusb_intf);
> > > > +     struct net_device *pnetdev, *newpnetdev =3D usb_get_intfdata(=
pusb_intf);
> > > >       struct usb_device *udev =3D interface_to_usbdev(pusb_intf);
> > > >
> > > >       if (pnetdev) {
> > >
> > > Did you test this?
> >
> > For now, I only tested this patch in my local workspace. The memory
> > leak does not occur any more.
> >
> > I have pushed a patch testing onto the syzbot dashboard [1]. Now it is
> > in the pending state.
> >
> > [1] https://syzkaller.appspot.com/bug?id=3D3a325b8389fc41c1bc94de0f4ac4=
37ed13cce584
> >
> > >
> > > I think you just broke the code right here :(
> >
> > If I broke any code logic, I am sorry. However, this patch only adds
> > some code to deallocate some resources when failing to load firmware.
> >
> > Do you mean that I replace pnetdev with the variable - newpnetdev?
>
> Yes, and then the first thing the code does is check the value of
> pnetdev which is totally undefined :(

You are right. Apology for the previous patch. I test my old patch
below in the local workspace, it works.

---------------------------------------------------------------------------=
---------------------------------------------
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -597,9 +597,9 @@ static void r871xu_dev_remove(struct usb_interface
*pusb_intf)

  /* never exit with a firmware callback pending */
  wait_for_completion(&padapter->rtl8712_fw_ready);
- pnetdev =3D usb_get_intfdata(pusb_intf);
+ struct net_device *newpnetdev =3D usb_get_intfdata(pusb_intf);
  usb_set_intfdata(pusb_intf, NULL);
- if (!pnetdev)
+ if (!newpnetdev)
  goto firmware_load_fail;
  release_firmware(padapter->fw);
  if (drvpriv.drv_registered)
@@ -625,6 +625,14 @@ static void r871xu_dev_remove(struct
usb_interface *pusb_intf)
  */
  if (udev->state !=3D USB_STATE_NOTATTACHED)
  usb_reset_device(udev);
+ if (pnetdev) {
+ struct _adapter *padapter =3D netdev_priv(pnetdev);
+ /* Stop driver mlme relation timer */
+ //r8712_stop_drv_timers(padapter);
+ //r871x_dev_unload(padapter);
+ r8712_free_drv_sw(padapter);
+ /* udev is already freed in failed fireware loading */
+ }
 }
---------------------------------------------------------------------------=
---------------------------------------------

However, the compiler complains the declaration of newpnetdev. So I
moved the declaration to the beginning, but I forget to initialize
both two variables. :(

I will revise this problem and test it in my local workspace. If it
works, I will resend a v2 patch.

BTW, should I uncomment "r8712_stop_drv_timers" and
"r871x_dev_unload"? I am not very sure about its functionability.

>
