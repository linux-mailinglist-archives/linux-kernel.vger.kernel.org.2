Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2D038CB09
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 18:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbhEUQcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 12:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbhEUQcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 12:32:14 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA35C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 09:30:50 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b17so24006229ede.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 09:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q8OVoD/UCRoREhZUYu+gQHmOs+0flAlDPXRHdAtK/ig=;
        b=PoGp9f92+J7n+WBDGANlXbv0XTlKt4uZR02F3eFObRXhqT+x4PzglaqikIOZmgcB6U
         XFV1RXWXbhQPXxvsBP93SVbI6OBpsjF66rjp3+Z1Z3YpcJ4WfWs1I6SOQiY4g2P1DDPM
         LK2fdyjXowUysONkC/KA22FCrJPNEgeWaNurRx/s4FVbyOQXD63vFaPihQWiRIYCEIN3
         Ls8gskDnWMyL00FGy3Sx1/0y3A714+xnRR1ZH68k1ezaC8cf4AY3m599Y1jkZcbuLx09
         jIf045xR+o0sG8KuyPFeCGCEDTcbc7AT+G0xBSourtF3C/vhfvJyQKpCAS3G7Gq3Fx1H
         S4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q8OVoD/UCRoREhZUYu+gQHmOs+0flAlDPXRHdAtK/ig=;
        b=AwESnSz+dcVCdw+cKwjZ2cdu/ybacTWDJwfKzRhVEHb7Iha/GVOGf8Miq6OnzSXqhI
         YRoxsjCgKsx2p0tEw+4bh2VZedmCS47k+jzJ4kqjfm6xKvrzkUX/szulFyTjCnRGr8ZK
         /hmfVdiJurXxqNMnuwapcPxtTpdpqtrHiWL4V/qIXV/heR2l7/A+HZ+U0r+AYCKivC/o
         TONpDWYbowaJM5hMVFopNOMz+KBlIeP2wtAel7VUzY6ilDWY8iN7o7NW3GQB8Bkkr9tY
         H+q4k1k2l3sUzxVmRpNheEW6nqDOVCaAqeHn2f8SRuGBUrcn4Db8oWkvox7C4pMZ0Pzj
         yzdg==
X-Gm-Message-State: AOAM530wahBc/M4zg9Z2BhYNqR7kzZo4twH27g89JsSInru1CSlh9xT8
        ZW4xkJjntlDUFUC9gWaNHXiKzoV0uXA8NJCN4jI=
X-Google-Smtp-Source: ABdhPJwh7svWqjQ0h5m/W/D+NxASqhWd8QCp1bCv/908crXNBOIjkw4kCEWj203qtkjoQswxzvS+HWnBp/VDvdTSRX4=
X-Received: by 2002:a05:6402:15:: with SMTP id d21mr8809748edu.66.1621614649421;
 Fri, 21 May 2021 09:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210521162519.677074-1-mudongliangabcd@gmail.com>
In-Reply-To: <20210521162519.677074-1-mudongliangabcd@gmail.com>
From:   =?UTF-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Date:   Sat, 22 May 2021 00:29:39 +0800
Message-ID: <CAD-N9QWMrEALHHweVZ1hgarzNQ3qi-+G0Qd44dP61AWTK4_yAQ@mail.gmail.com>
Subject: Re: [PATCH v2] staging: rtl8712: Fix memory leak in r8712_init_recv_priv
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        Greg KH <gregkh@linuxfoundation.org>, rkovhaev@gmail.com,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot+1c46f3771695bccbdb3a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2021 at 12:25 AM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
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
> v1->v2: fix the initialization of pnetdev
>
>  drivers/staging/rtl8712/usb_intf.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
> index dc21e7743349..57e773464e18 100644
> --- a/drivers/staging/rtl8712/usb_intf.c
> +++ b/drivers/staging/rtl8712/usb_intf.c
> @@ -593,13 +593,14 @@ static void r871xu_dev_remove(struct usb_interface *pusb_intf)
>         struct usb_device *udev = interface_to_usbdev(pusb_intf);
>
>         if (pnetdev) {
> +               struct net_device *newpnetdev = NULL;
>                 struct _adapter *padapter = netdev_priv(pnetdev);
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
> @@ -625,6 +626,10 @@ static void r871xu_dev_remove(struct usb_interface *pusb_intf)
>          */
>         if (udev->state != USB_STATE_NOTATTACHED)
>                 usb_reset_device(udev);
> +       if (pnetdev) {
> +               struct _adapter *padapter = netdev_priv(pnetdev);
> +               r8712_free_drv_sw(padapter);
> +       }
>  }
>
>  static int __init r8712u_drv_entry(void)
> --
> 2.25.1
>

I tested my patch in my local workspace. No matter for the latest
upstream or f40ddce88593482919761f74910f42f4b84c004b (the kernel
version for the first crash in the syzbot), my local workspace both
show the memory leak disappears once the kernel is patched. However,
syzbot testing shows it still triggers the memory leak. @Dmitry Vyukov
Can you please help take a look? Maybe I incorrectly use this feature.
Thanks in advance.
