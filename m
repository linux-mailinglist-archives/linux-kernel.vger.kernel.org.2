Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD6838C673
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbhEUM1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhEUM1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:27:32 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9BEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:26:09 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id a25so23081997edr.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o/SES9st0MMJCDzZsStAlcXxLW6LgDl8DlkoGljECP8=;
        b=bL3nOloUg9ddy0iuHbn8BYu3mcEfrgPp/WVy7D4u+5AzXacck5TVjafZQ+Y/sW8emS
         w+AAukft58C6NRVuLoQolOzsJpV62fcdwWS4o0j8apIId2bWQDAFoh1cNf8/4Ypvtks6
         nenBks0sD3ZhIbs2mwTeMhDIq/WiwaUW1s5qIK9d8kFPpSAbBRFfQFm1KkqmE7JHS0Na
         nFjjAXYCOlkQmwsfeABBG9a5GuEzhR+Rwq0RvriokJlONfFJU4A33JVSG/Uzrk4ws+LS
         lTHze6Oa/6W6TA69iuQ35XiN0ADsCa1PylNE43lXFYks/dKwHfRJe/9ugy2tbhYmDQNk
         2kVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o/SES9st0MMJCDzZsStAlcXxLW6LgDl8DlkoGljECP8=;
        b=TJOQFpIb8w2qT4Ogv8ijNwiV10piLEXm6Yh+0Oe6Euj4ikpbIybxi8h9RW3ca3TJul
         OzSdMYZHb7QT+uYb+jY8N93dqr/H/4b7Zbm2WHb0TGX83pevzvZi0LTJkBJhCaUElLs+
         Lp2ov5lkkAu3bUYBt4+suFs/V9zN41rc5VaxvQGTqThqJpHWxwCyjjz6Rp4h5oMsE6Gs
         i/A7mEqBWg8tusx9rrbZaDCeU/2Uze6TC7XSy0IrdpV6PDEAnuQTNcLlJApMiRffWipX
         CFRe9ziAzB7Y9pdVbyFtpwICp9SqaMQQjrsDHj9yfYbPZ82Ez17qbsMdKvxWY4Sqqy+p
         cN9Q==
X-Gm-Message-State: AOAM530drjiPa/os00ET+wYAL75Xxj14AYWL40XpcPbh5ut4RI5hi6j0
        MUeqg5kNpmmaBOS+9xwmbMdurQ/DzKBYxHpsP0SV9LS1i5wMcX+JNSlYoQ==
X-Google-Smtp-Source: ABdhPJyVFoL4zM1kmrY/78qscmmvyrSNnnT//URUbsQPMqUwvwMJgoBSc7dbew1Ew9cgt1OFv8N9oCwh3Nk2Wi1MAZE=
X-Received: by 2002:a05:6402:1109:: with SMTP id u9mr11149356edv.174.1621599967673;
 Fri, 21 May 2021 05:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210521120811.516339-1-mudongliangabcd@gmail.com> <YKelBRkGsLFz4byw@kroah.com>
In-Reply-To: <YKelBRkGsLFz4byw@kroah.com>
From:   =?UTF-8?B?5oWV5Yas5Lqu?= <mudongliangabcd@gmail.com>
Date:   Fri, 21 May 2021 20:24:58 +0800
Message-ID: <CAD-N9QUgYy4j3wnJX1gwq902ggarFaQPBQ3cyUAArYxv22Q-bQ@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8712: Fix memory leak in r8712_init_recv_priv
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

On Fri, May 21, 2021 at 8:18 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, May 21, 2021 at 08:08:11PM +0800, Dongliang Mu wrote:
> > r871xu_dev_remove failed to call r8712_free_drv_sw() and free the
> > resource (e.g., struct urb) due to the failure of firmware loading.
> >
> > Fix this by invoking r8712_free_drv_sw at the failure site.
> >
> > Reported-by: syzbot+1c46f3771695bccbdb3a@syzkaller.appspotmail.com
> > Fixes: b4383c971bc5 ("staging: rtl8712: handle firmware load failure")
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >  drivers/staging/rtl8712/usb_intf.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
> > index dc21e7743349..a5190b4250ce 100644
> > --- a/drivers/staging/rtl8712/usb_intf.c
> > +++ b/drivers/staging/rtl8712/usb_intf.c
> > @@ -589,7 +589,7 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
> >   */
> >  static void r871xu_dev_remove(struct usb_interface *pusb_intf)
> >  {
> > -     struct net_device *pnetdev = usb_get_intfdata(pusb_intf);
> > +     struct net_device *pnetdev, *newpnetdev = usb_get_intfdata(pusb_intf);
> >       struct usb_device *udev = interface_to_usbdev(pusb_intf);
> >
> >       if (pnetdev) {
>
> Did you test this?

For now, I only tested this patch in my local workspace. The memory
leak does not occur any more.

I have pushed a patch testing onto the syzbot dashboard [1]. Now it is
in the pending state.

[1] https://syzkaller.appspot.com/bug?id=3a325b8389fc41c1bc94de0f4ac437ed13cce584

>
> I think you just broke the code right here :(

If I broke any code logic, I am sorry. However, this patch only adds
some code to deallocate some resources when failing to load firmware.

Do you mean that I replace pnetdev with the variable - newpnetdev?

>
> thanks,
>
> greg k-h
