Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0388638BB99
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 03:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbhEUBdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 21:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236829AbhEUBdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 21:33:38 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517F2C061763
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 18:32:15 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id w7so8689712lji.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 18:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i6+GU1989dc+c/4pBqXP2ejMJrlEQH+40HXELyyCBFg=;
        b=sUQIEChif+iFRYvkbiyr/AA8zebUW1MBFkmvXgAqKoB1NtWATeTE9VUk4/gFePidHc
         V8AItxPmghNp2WiiqVXB/V29GS448Pa9SR+6G3D8upmpyPS/dqQ9IqelVI8VfbCiTKxG
         AA1fZoN+IRJGkIHK2yvKDYdkR8+3DBf9yFjNHRJnl3NtKbE4FRWpZ88rRgpRi+J/KG/k
         dmzBKeTOtZhXJwg0xUyAOE1TwklQ4kgh3c/CamKCwOU3EVsDP1IuGl7NlfVkf0sNNmjl
         lYOU3SCHrCO65TE+5hJcUo3RYuWw0cfaObbrWIpuKHRPX5cfCvUqfzRccbnfxSKiueP4
         b8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i6+GU1989dc+c/4pBqXP2ejMJrlEQH+40HXELyyCBFg=;
        b=gIjEeYwScUR1G6ShocVcib6qlNU/QuxyUr0GVN/3mL0tUg/f/3ja1JvTGGWCoy5GCe
         FDHWv9kFd5ceCjGFMY3T1UTlai5k5Uu1kAjOkxKR39gTe34x2eJBKMJqHqMJqcR2lBn7
         H4fd8qHdArEcbsNFqS6t/5ovMjVvg5p09cwPMh5EI0s1ZtfnryJFa0783zEm1ex3HqGb
         Et7KlLfYLDm8aHgy9w4jzDayhBIA7h/H5JgoTzVYPcqW3cWHM2fR+g4VKrB0R8Utr37w
         RFqDFCx7hZdWkjE9XPe0jvYndp4kbm8/TJmSaoRyBvWk7GdZ0DPWzEpzSMDXgD1VIbD5
         qfXg==
X-Gm-Message-State: AOAM532eli9xpo844uR1UNlz31/P/t51IsuoR7c3rzwYrt4Xa1WsEFk6
        BEO5M7YcUa9C/xkkxCbX+ZktsAtwgzBzts15RFV8lw==
X-Google-Smtp-Source: ABdhPJyZNWeEBlPshz3dE96QWqsEPAkawS8AVDk1QHNfZh/n9URQWtLLDiAuePsk2NDxqDFWl/lOJAp8uk6RvkmSB8w=
X-Received: by 2002:a2e:880f:: with SMTP id x15mr4814880ljh.503.1621560733358;
 Thu, 20 May 2021 18:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210413010252.2255812-1-lzye@google.com> <a2be79bcf1ce93096d6843a0856927cda65d4842.camel@hadess.net>
 <CAFFudd+ULT9TLEeXZ43J2dhk3de7aMr1nX6swsD0A8uNC8TQQg@mail.gmail.com>
In-Reply-To: <CAFFudd+ULT9TLEeXZ43J2dhk3de7aMr1nX6swsD0A8uNC8TQQg@mail.gmail.com>
From:   Chris Ye <lzye@google.com>
Date:   Thu, 20 May 2021 18:32:02 -0700
Message-ID: <CAFFuddKreeKEUWWn2emOCP1vTL0wc5y4Y+9O2kLn16M1hYkxQQ@mail.gmail.com>
Subject: Re: [PATCH] [v4] Input: Add "Select" button to Microsoft Xbox One controller.
To:     Bastien Nocera <hadess@hadess.net>
Cc:     =?UTF-8?Q?=C5=81ukasz_Patron?= <priv.luk@gmail.com>,
        Benjamin Valentin <benpicco@googlemail.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Olivier_Cr=C3=AAte?= <olivier.crete@ocrete.ca>,
        Sanjay Govind <sanjay.govind9@gmail.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-input <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, trivial@kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bastien,
  Please check v5 for the patch let me know if you still have any comment.
Thanks!
Chris

On Tue, Apr 13, 2021 at 9:41 PM Chris Ye <lzye@google.com> wrote:
>
> That line was using tab + 4 spaces on the left and was reformatted to
> use 2 tabs.
> If you don't like it I've uploaded patch v5 not touching that line.
>
>
> On Tue, Apr 13, 2021 at 5:34 AM Bastien Nocera <hadess@hadess.net> wrote:
> >
> > On Tue, 2021-04-13 at 01:02 +0000, Chris Ye wrote:
> > > Add "Select" button input capability and input event mapping for
> > > Microsoft Xbox One controller. From product site this is also
> > > referred as
> > > "Share" button.
> > > Fixed Microsoft Xbox One controller select button not working under
> > > USB
> > > connection.
> > >
> > > Signed-off-by: Chris Ye <lzye@google.com>
> > > ---
> > >  drivers/input/joystick/xpad.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/input/joystick/xpad.c
> > > b/drivers/input/joystick/xpad.c
> > > index 9f0d07dcbf06..99cb8bb78570 100644
> > > --- a/drivers/input/joystick/xpad.c
> > > +++ b/drivers/input/joystick/xpad.c
> > > @@ -79,6 +79,7 @@
> > >  #define MAP_DPAD_TO_BUTTONS            (1 << 0)
> > >  #define MAP_TRIGGERS_TO_BUTTONS                (1 << 1)
> > >  #define MAP_STICKS_TO_NULL             (1 << 2)
> > > +#define MAP_SELECT_BUTTON              (1 << 3)
> > >  #define DANCEPAD_MAP_CONFIG    (MAP_DPAD_TO_BUTTONS
> > > |                  \
> > >                                 MAP_TRIGGERS_TO_BUTTONS |
> > > MAP_STICKS_TO_NULL)
> > >
> > > @@ -130,6 +131,7 @@ static const struct xpad_device {
> > >         { 0x045e, 0x02e3, "Microsoft X-Box One Elite pad", 0,
> > > XTYPE_XBOXONE },
> > >         { 0x045e, 0x02ea, "Microsoft X-Box One S pad", 0,
> > > XTYPE_XBOXONE },
> > >         { 0x045e, 0x0719, "Xbox 360 Wireless Receiver",
> > > MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
> > > +       { 0x045e, 0x0b12, "Microsoft Xbox One X pad",
> > > MAP_SELECT_BUTTON, XTYPE_XBOXONE },
> > >         { 0x046d, 0xc21d, "Logitech Gamepad F310", 0, XTYPE_XBOX360
> > > },
> > >         { 0x046d, 0xc21e, "Logitech Gamepad F510", 0, XTYPE_XBOX360
> > > },
> > >         { 0x046d, 0xc21f, "Logitech Gamepad F710", 0, XTYPE_XBOX360
> > > },
> > > @@ -862,6 +864,8 @@ static void xpadone_process_packet(struct
> > > usb_xpad *xpad, u16 cmd, unsigned char
> > >         /* menu/view buttons */
> > >         input_report_key(dev, BTN_START,  data[4] & 0x04);
> > >         input_report_key(dev, BTN_SELECT, data[4] & 0x08);
> > > +       if (xpad->mapping & MAP_SELECT_BUTTON)
> > > +               input_report_key(dev, KEY_RECORD, data[22] & 0x01);
> > >
> > >         /* buttons A,B,X,Y */
> > >         input_report_key(dev, BTN_A,    data[4] & 0x10);
> > > @@ -1669,9 +1673,11 @@ static int xpad_init_input(struct usb_xpad
> > > *xpad)
> > >
> > >         /* set up model-specific ones */
> > >         if (xpad->xtype == XTYPE_XBOX360 || xpad->xtype ==
> > > XTYPE_XBOX360W ||
> > > -           xpad->xtype == XTYPE_XBOXONE) {
> > > +               xpad->xtype == XTYPE_XBOXONE) {
> >
> > Why the indentation change here?
> >
> > >                 for (i = 0; xpad360_btn[i] >= 0; i++)
> > >                         input_set_capability(input_dev, EV_KEY,
> > > xpad360_btn[i]);
> > > +               if (xpad->mapping & MAP_SELECT_BUTTON)
> > > +                       input_set_capability(input_dev, EV_KEY,
> > > KEY_RECORD);
> > >         } else {
> > >                 for (i = 0; xpad_btn[i] >= 0; i++)
> > >                         input_set_capability(input_dev, EV_KEY,
> > > xpad_btn[i]);
> >
> >
