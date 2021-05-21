Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D177638C647
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhEUMLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhEUMLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:11:41 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB03C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:10:17 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id k14so26651348eji.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WEQXur4fHHNCbUkGisN9Mvm9Bkhht++DmG49GXVjdxc=;
        b=cS38JkZ2B1xj4stQHt9WIoVyEm4CvkrCowRF5mW7jIhrI/xCuBSRdZz+V0tvtFsG3+
         mMdcO+9h875uFiTKgfRa9kUWCM6xIBX8T+VJuKURTVYxLudIJaqkzP0FXgWCmGXuDHGu
         DAn2gI0aB9kfFMxiTB0ZZgWEMphBbQxLS37UBf9yrrNyuHwUTQLeFEDpAaFRHrWOZzUw
         9lfjwH1YvaO1xoTnhjiKMJMm+syivYt6EkS9Lu4AFn4V1OCL2LYweI2bG18lEgXUYTbT
         gqk5HfnqNxBHP0SdDBEvgaA4SEKUbPuxr5Kz4fg9NfK/hItQ9iHiPhQzpy/7c3vZ4zu6
         HK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WEQXur4fHHNCbUkGisN9Mvm9Bkhht++DmG49GXVjdxc=;
        b=pgWhsEJTqzZluBFSIQ28NpLAV00JFClSRIfHbRQNX9Col+ssCXMEKcnqdfcDkWlzWl
         JNjll2AMMNbBk0u4PSfQNmhDWXx9wMLcfyc/H4LOzbXQkwDgnmI1aSbCie6gG7JNXOIR
         i2GFc+kwfxPUTMtqnvwr13MEevfjZg1wCEHnQl/93u54LBYGStVO6k3TsWnmevV+DxED
         0Rf7Q+vN7Uzd3DkPcRXxxO3rKy/YMYplOZDwLZ1D8ILE1BXMF4eB61jmFiPvnncDNZi4
         Fq0KMaJvER7AL1KqrUTtYiXZVGIFlg8JRLAf/pbQ59NRSHFnby1bGOgarEH6BIOp8ulb
         woqw==
X-Gm-Message-State: AOAM531U0TL9nasv9DMlC020E0yNnVCWQB8dHdlA+NzvVZ5PFPM3nV8L
        tGijKHR3fTWBLMdSZEaZqOjDPwMllpb0TdRTrbQ=
X-Google-Smtp-Source: ABdhPJxpNIzxd0YSkyamu5BEICCA7WZg2tqHLkDC/8e8LLRGzP8jqqSCC7ckt81BZ7FJ21mfAmlRIXnciFPZ90E/U8c=
X-Received: by 2002:a17:907:1002:: with SMTP id ox2mr9782899ejb.337.1621599015504;
 Fri, 21 May 2021 05:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210521120811.516339-1-mudongliangabcd@gmail.com>
In-Reply-To: <20210521120811.516339-1-mudongliangabcd@gmail.com>
From:   =?UTF-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Date:   Fri, 21 May 2021 20:09:06 +0800
Message-ID: <CAD-N9QX4A2dsDxS+oKvahHS8CC_Rt1iYCMABUEtR4NGJH5m1YQ@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8712: Fix memory leak in r8712_init_recv_priv
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        Greg KH <gregkh@linuxfoundation.org>, rkovhaev@gmail.com,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     syzbot+1c46f3771695bccbdb3a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 8:08 PM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> r871xu_dev_remove failed to call r8712_free_drv_sw() and free the
> resource (e.g., struct urb) due to the failure of firmware loading.
>
> Fix this by invoking r8712_free_drv_sw at the failure site.
>
> Reported-by: syzbot+1c46f3771695bccbdb3a@syzkaller.appspotmail.com
> Fixes: b4383c971bc5 ("staging: rtl8712: handle firmware load failure")
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  drivers/staging/rtl8712/usb_intf.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
> index dc21e7743349..a5190b4250ce 100644
> --- a/drivers/staging/rtl8712/usb_intf.c
> +++ b/drivers/staging/rtl8712/usb_intf.c
> @@ -589,7 +589,7 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
>   */
>  static void r871xu_dev_remove(struct usb_interface *pusb_intf)
>  {
> -       struct net_device *pnetdev = usb_get_intfdata(pusb_intf);
> +       struct net_device *pnetdev, *newpnetdev = usb_get_intfdata(pusb_intf);
>         struct usb_device *udev = interface_to_usbdev(pusb_intf);
>
>         if (pnetdev) {
> @@ -597,9 +597,9 @@ static void r871xu_dev_remove(struct usb_interface *pusb_intf)
>
>                 /* never exit with a firmware callback pending */
>                 wait_for_completion(&padapter->rtl8712_fw_ready);
> -               pnetdev = usb_get_intfdata(pusb_intf);
> +               newpnetdev = usb_get_intfdata(pusb_intf);
>                 usb_set_intfdata(pusb_intf, NULL);
> -               if (!pnetdev)
> +               if (!newpnetdev)
>                         goto firmware_load_fail;
>                 release_firmware(padapter->fw);
>                 if (drvpriv.drv_registered)
> @@ -625,6 +625,13 @@ static void r871xu_dev_remove(struct usb_interface *pusb_intf)
>          */
>         if (udev->state != USB_STATE_NOTATTACHED)
>                 usb_reset_device(udev);
> +       if (pnetdev) {
> +               struct _adapter *padapter = netdev_priv(pnetdev);
> +               /* Stop driver mlme relation timer */
> +               //r8712_stop_drv_timers(padapter);
> +               //r871x_dev_unload(padapter);

I am not sure if I should add those deallocation functions in this
branch. I will appreciate it if anyone can give some advice here.

> +               r8712_free_drv_sw(padapter);
> +       }
>  }
>
>  static int __init r8712u_drv_entry(void)
> --
> 2.25.1
>
