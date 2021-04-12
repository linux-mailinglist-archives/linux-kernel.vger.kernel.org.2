Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BC335C72C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 15:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239867AbhDLNLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 09:11:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41698 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241498AbhDLNLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 09:11:13 -0400
Received: from mail-lj1-f197.google.com ([209.85.208.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lVwL8-0002Mq-Pq
        for linux-kernel@vger.kernel.org; Mon, 12 Apr 2021 13:10:54 +0000
Received: by mail-lj1-f197.google.com with SMTP id t14so2093447ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 06:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PrLEyIjUJblo7S+sNtRpgmhy7N1VnkqDo/WR8LuV+WE=;
        b=jNul/lgHmi4GeGBB2I+aUc/ZGDdwOuJBN+f/O7iqGPPYWsrwwtJHIfKRobfYqrj1il
         4a0OujO6jmNx+pNJE+IAEaHowuueC48Ms4zrQYiDkWICGOZ2HjJozEjzHrs+ahiZPvH+
         aQwOwNuZ0NmZVVyn6S4vvYkE0Iquyy2AeXKOUMKtyL0fM5SUjcnl0qxyasfSpY1oZIIh
         dSRSnTeTI92B6qqyEktVAVURA/WqwP8D5lRY9gjER5wa3l5oZlBNxhUYIC54FjSG/GYA
         NtwEmuR69WwT5rMS/5ETeYMvV11uouhwNtwASv5nV4pg0iydahBlhg9lE6dthhaWnh2H
         6PsA==
X-Gm-Message-State: AOAM5314wDv+xuN4YwFfdnIjSDBGkaJRT3QHsrn0C5Nmmsqk4uDRVwMs
        1wiyYsaHNQ9py5rsR39xe7xx3tGhb4/JMETnj+6zG2jwxBabmfeAFfMiBJl8R7iMbKvDT8uAOKa
        7fBwU/e9yT9kmj6F0+V/kd2LZC8GWm2VzpGXm1lD+jbplmJ6vH1iFG/7Yhw==
X-Received: by 2002:a2e:3013:: with SMTP id w19mr6015217ljw.97.1618233054225;
        Mon, 12 Apr 2021 06:10:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxR6IaQiNoP7RnPnhejo3H1RZrmk1Ll/HnLTHpwJGxLrQRRT95FsAHdmJyp1uD9Y3PpSPQl+1ZnWlUgkJFFsvs=
X-Received: by 2002:a2e:3013:: with SMTP id w19mr6015202ljw.97.1618233053976;
 Mon, 12 Apr 2021 06:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210412130521.782373-1-kai.heng.feng@canonical.com> <YHRGhQ51LeouoWEv@hovoldconsulting.com>
In-Reply-To: <YHRGhQ51LeouoWEv@hovoldconsulting.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 12 Apr 2021 21:10:41 +0800
Message-ID: <CAAd53p6He-YUh8pUS=bQvfbyQYXWpm+B-6b=Tc_VDy4jMu2rvA@mail.gmail.com>
Subject: Re: [PATCH v2] USB: Add LPM quirk for Lenovo ThinkPad USB-C Dock Gen2 Ethernet
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        penghao <penghao@uniontech.com>,
        Oliver Neukum <oneukum@suse.com>,
        Jonathan Cox <jonathan@jdcox.net>,
        Kars Mulder <kerneldev@karsmulder.nl>,
        =?UTF-8?Q?Tomasz_Meresi=C5=84ski?= <tomasz@meresinski.eu>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 9:09 PM Johan Hovold <johan@kernel.org> wrote:
>
> On Mon, Apr 12, 2021 at 09:05:20PM +0800, Kai-Heng Feng wrote:
> > This is another branded 8153 device that doesn't work well with LPM
> > enabled:
> > [ 400.597506] r8152 5-1.1:1.0 enx482ae3a2a6f0: Tx status -71
> >
> > So disable LPM to resolve the issue.
> >
> > BugLink: https://bugs.launchpad.net/bugs/1922651
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v2:
> >  - Put the quirk in the right order.
>
> Seriously... You sent the exact same patch again. Still not ordered.

Oops, sorry for that, I mistyped the patch name :(
Will send a correct one.

Kai-Heng

>
> >
> >  drivers/usb/core/quirks.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> > index 76ac5d6555ae..dfedb51cf832 100644
> > --- a/drivers/usb/core/quirks.c
> > +++ b/drivers/usb/core/quirks.c
> > @@ -434,6 +434,9 @@ static const struct usb_device_id usb_quirk_list[] = {
> >       { USB_DEVICE(0x1532, 0x0116), .driver_info =
> >                       USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
> >
> > +     /* Lenovo ThinkPad USB-C Dock Gen2 Ethernet (RTL8153 GigE) */
> > +     { USB_DEVICE(0x17ef, 0xa387), .driver_info = USB_QUIRK_NO_LPM },
> > +
> >       /* Lenovo ThinkCenter A630Z TI024Gen3 usb-audio */
> >       { USB_DEVICE(0x17ef, 0xa012), .driver_info =
> >                       USB_QUIRK_DISCONNECT_SUSPEND },
>
> Johan
