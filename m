Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6896F3F14FD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 10:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbhHSIST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 04:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbhHSISS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:18:18 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FF1C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:17:43 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id j18so5097684ile.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+0Qd59ccHKt5kJFIv8CQsqBPM7uBB43qHRbb83BwG5c=;
        b=UI+xZk2KPfckDnfd9qGLV1wLq13aZW86yh08PFAHoJ4/o7fLkS3yekXW38nV6Uz41O
         /f3Ve3N+NG3r5pOGwfHBNjaYQeT8FcZ5vZ2VOIV+ZYN3h9lo91sCBlENe4PkGxFiy6XF
         XzvLBGfkrYXle2CRJ2v1pRrAD+WbguCspM7r17mD7Byo9I7Nuc5F13F6GexrAN37Akp5
         52TdYUKlW8qFlsMHk+1XX0fZDDaLIViORDSc9TowLFXDv5+OYanYanghWPDbEwa6vLTH
         ymD3Z1sCU6NWj7llDteOC1X0pAMtuya9Wb63hKrdsQvvWG5EbpbwMrKtgVLWl+Ma8zAR
         u13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0Qd59ccHKt5kJFIv8CQsqBPM7uBB43qHRbb83BwG5c=;
        b=YfU/YIi4pgZLEnJ77F9JFeTizQvu9c6uB46OOOVf5cFTqCOIcf+Rt7Da98ugf5BLO9
         Z7yPii5qAncd5j4VOJprLh0mWs9cfgRlePXOlL7dCgW9w3OIb6MsuT2cBvBnn7s5XWbL
         t2qNpwCDhAhr2JrYNEwCEFrDaH0hM97dKLI/3DNjt73U6ChlW+1E/kWGvm2GHlWdObX1
         dHAlW9LaImLwwqJeM1tb5AC4GNgiL1G+iJQJzPK1iljEl4bulaIAnmNvV2es0H4BNyvo
         jsG457rAZLiUKZ6UunT4WvFc4dnMVu35YtowZugLLzF9vlcZPnhrDGeD9oQlF+J9jR34
         zsCQ==
X-Gm-Message-State: AOAM532eIVg2Am5AkSSSk3Eu32quDJilHVJCXIiY0vX7Z7LY2dMBiugk
        PChRTKs6SoxNdF3KP8hR5hlKTCtsQjffsOjs6FjzP5QGdHf1LrH2
X-Google-Smtp-Source: ABdhPJzDVqxmgayB5uG3ccIQoZmh18KygU+2O07sj1i9NvW9E/+5PbWXDPyd5xUi+PyxnkGV6RPQZkZLiclAcKcSXjY=
X-Received: by 2002:a92:d3cf:: with SMTP id c15mr8873348ilh.131.1629361062474;
 Thu, 19 Aug 2021 01:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKMLyx+CvBQbLz-xQvwLS692tx-4xOgU7b-V2J676D29yg@mail.gmail.com>
 <d983217b-e117-361c-0306-b131695bb93f@denx.de> <CAKmqyKOsUcta1cXxamJZnf01G9beCZrDKia068HR+J0AadgNiA@mail.gmail.com>
 <bff9ba97-bc26-f091-ba71-5e639af524d4@denx.de> <CAKmqyKPF3T_Sx+hL=4OSamLdjy=0fwmrTrVeb-GY0Ja9M=mi+Q@mail.gmail.com>
 <ab2b7f4f-3e36-461c-6a6c-02ee7ed6cb99@denx.de> <CAKmqyKN8devNyDvVL5B_dDASU3se1dSui0bsnf6gQ+CkZ_TaKg@mail.gmail.com>
 <YR1R7/nIUIN3LA7t@ravnborg.org>
In-Reply-To: <YR1R7/nIUIN3LA7t@ravnborg.org>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Thu, 19 Aug 2021 18:16:00 +1000
Message-ID: <CAKmqyKNzojeRtYUZyfVDBhAz5gNfRendSWduYJV_+gYiz8QAMg@mail.gmail.com>
Subject: Re: Revert "video: fbdev: mxsfb: Remove driver"
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, b.zolnierkie@samsung.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 4:31 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Alistair,
>
> > prctl(PR_CAPBSET_READ, 0x30 /* CAP_??? */) = -1 EINVAL (Invalid argument)
> > prctl(PR_CAPBSET_READ, 0x2c /* CAP_??? */) = -1 EINVAL (Invalid argument)
> > prctl(PR_CAPBSET_READ, 0x2a /* CAP_??? */) = -1 EINVAL (Invalid argument)
> > prctl(PR_CAPBSET_READ, 0x29 /* CAP_??? */) = -1 EINVAL (Invalid argument)
> > ioctl(5, FBIOPUT_VSCREENINFO, 0x4ce8e0) = -1 EINVAL (Invalid argument)
> >
> > I'm guessing it's related to FBIOPUT_VSCREENINFO then, is that
> > something that could be added to the DRM emulation?
>
> Just to try to verify this could you try to return early
> in the switch where we have FBIOPUT_VSCREENINFO?
>
> In fbmem.c in do_fb_ioctl() just add a printk("something\n") and
> return 0 in the FBIOPUT_VSCREENINFO case.

Yep, this diff changes the working screen with the fbdev driver to not working:

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 1c855145711b..0f781914eca0 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1099,18 +1099,8 @@ static long do_fb_ioctl(struct fb_info *info,
unsigned int cmd,
                ret = copy_to_user(argp, &var, sizeof(var)) ? -EFAULT : 0;
                break;
        case FBIOPUT_VSCREENINFO:
-               if (copy_from_user(&var, argp, sizeof(var)))
-                       return -EFAULT;
-               console_lock();
-               lock_fb_info(info);
-               ret = fb_set_var(info, &var);
-               if (!ret)
-                       fbcon_update_vcs(info, var.activate & FB_ACTIVATE_ALL);
-               unlock_fb_info(info);
-               console_unlock();
-               if (!ret && copy_to_user(argp, &var, sizeof(var)))
-                       ret = -EFAULT;
-               break;
+               printk("FBIOPUT_VSCREENINFO Returning early");
+               return -EINVAL;
        case FBIOGET_FSCREENINFO:
                lock_fb_info(info);
                memcpy(&fix, &info->fix, sizeof(fix));

So FBIOPUT_VSCREENINFO is the issue (or at least one of them).

Alistair

>
> The printk is just so something pops up in the logging.
>
> If this makes you going then we need to look at how to add this to the
> emulation or some other way to deal with this.
>
>         Sam
