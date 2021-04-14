Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10BE35EC03
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 06:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhDNEmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 00:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhDNEmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 00:42:25 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C77C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 21:42:05 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id r20so21857569ljk.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 21:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=boQU2MMoKZITSUuTZ9u7Ur1dr9594KKlp/l2Ec4ci6g=;
        b=OXmXimrwWLRnv/c0WHoL4YdTYIo7nh2IXSH3569UBFovI9i3UHB1gn8Bv09ZQOIvOR
         TM3hENR2aATfXhTh31H7fydNGhBG/MfZUKI9EJgDsMgGg5rU0dGVbQpqxuTV88WlHUPu
         O9C3CZaQ9vQyXSyNd6iszxBfujvQ6ZKpqwdl4yfwK/F4M1Bh3gokS2HYNRDUljQzny5E
         mIh7clpvkX4pyQvzhO8P7bhPIGspUuCQjEMOtVL0ucicS5VL1bBkpZ+nnSWVyt4ZASdf
         kG2GihFDNWzFCpBp5NKREcwiaPZuynJS+IE0H6Y/XM+yJGM8jvuzDF8e39NIawLlZeVf
         Dp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=boQU2MMoKZITSUuTZ9u7Ur1dr9594KKlp/l2Ec4ci6g=;
        b=VsR9jwY80PON/jkI97of0YAAY5z5xrGU2xB4TV8+p1GeGTsu4IHexhsb6QAsg1YGcv
         b36zrjkkp70LUNdvwL01tVBx+G/x5E3Hyhib8gvJtNovHeMZlNA78cfXnJZosbRFocS+
         IScgXA9YzXj4vnBiu6WjjWkkZKAMXOeiPbejVj0R09e43vw0KQHgt7ZusnOJkYuDnTV/
         nD4O9SWg9kx82i4w9PVXf44UKEXR8W0oEzLkN2E+A1wcFdWicx9GKP6gOpJvlm1PnMtv
         MsGV0hK0Fq+DpB3DYW/Emin65vFbHcwFbN4Uxgi2int9JEmz11JhIDe7ogVe3tKkARlL
         zkkw==
X-Gm-Message-State: AOAM533oHY/DJA1wjsj11rBNtaIaHePTeiWKy7JXzFrsiU/oV4Dp5/QZ
        QuJbr5af51C7P3W3JdVd+s4S4s1G1ZLyaovuy1RQfQ==
X-Google-Smtp-Source: ABdhPJzhEEU3PFDfyA39HxrKCbGBl2nHujmFShzAsmbHmtnCmz4KKLUO4tLF+jgOq0/kV1THJNmEKCgd4AyFIgQ5ANE=
X-Received: by 2002:a2e:b4a5:: with SMTP id q5mr22868080ljm.7.1618375323366;
 Tue, 13 Apr 2021 21:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210413010252.2255812-1-lzye@google.com> <a2be79bcf1ce93096d6843a0856927cda65d4842.camel@hadess.net>
In-Reply-To: <a2be79bcf1ce93096d6843a0856927cda65d4842.camel@hadess.net>
From:   Chris Ye <lzye@google.com>
Date:   Tue, 13 Apr 2021 21:41:52 -0700
Message-ID: <CAFFudd+ULT9TLEeXZ43J2dhk3de7aMr1nX6swsD0A8uNC8TQQg@mail.gmail.com>
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

That line was using tab + 4 spaces on the left and was reformatted to
use 2 tabs.
If you don't like it I've uploaded patch v5 not touching that line.


On Tue, Apr 13, 2021 at 5:34 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Tue, 2021-04-13 at 01:02 +0000, Chris Ye wrote:
> > Add "Select" button input capability and input event mapping for
> > Microsoft Xbox One controller. From product site this is also
> > referred as
> > "Share" button.
> > Fixed Microsoft Xbox One controller select button not working under
> > USB
> > connection.
> >
> > Signed-off-by: Chris Ye <lzye@google.com>
> > ---
> >  drivers/input/joystick/xpad.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/input/joystick/xpad.c
> > b/drivers/input/joystick/xpad.c
> > index 9f0d07dcbf06..99cb8bb78570 100644
> > --- a/drivers/input/joystick/xpad.c
> > +++ b/drivers/input/joystick/xpad.c
> > @@ -79,6 +79,7 @@
> >  #define MAP_DPAD_TO_BUTTONS            (1 << 0)
> >  #define MAP_TRIGGERS_TO_BUTTONS                (1 << 1)
> >  #define MAP_STICKS_TO_NULL             (1 << 2)
> > +#define MAP_SELECT_BUTTON              (1 << 3)
> >  #define DANCEPAD_MAP_CONFIG    (MAP_DPAD_TO_BUTTONS
> > |                  \
> >                                 MAP_TRIGGERS_TO_BUTTONS |
> > MAP_STICKS_TO_NULL)
> >
> > @@ -130,6 +131,7 @@ static const struct xpad_device {
> >         { 0x045e, 0x02e3, "Microsoft X-Box One Elite pad", 0,
> > XTYPE_XBOXONE },
> >         { 0x045e, 0x02ea, "Microsoft X-Box One S pad", 0,
> > XTYPE_XBOXONE },
> >         { 0x045e, 0x0719, "Xbox 360 Wireless Receiver",
> > MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
> > +       { 0x045e, 0x0b12, "Microsoft Xbox One X pad",
> > MAP_SELECT_BUTTON, XTYPE_XBOXONE },
> >         { 0x046d, 0xc21d, "Logitech Gamepad F310", 0, XTYPE_XBOX360
> > },
> >         { 0x046d, 0xc21e, "Logitech Gamepad F510", 0, XTYPE_XBOX360
> > },
> >         { 0x046d, 0xc21f, "Logitech Gamepad F710", 0, XTYPE_XBOX360
> > },
> > @@ -862,6 +864,8 @@ static void xpadone_process_packet(struct
> > usb_xpad *xpad, u16 cmd, unsigned char
> >         /* menu/view buttons */
> >         input_report_key(dev, BTN_START,  data[4] & 0x04);
> >         input_report_key(dev, BTN_SELECT, data[4] & 0x08);
> > +       if (xpad->mapping & MAP_SELECT_BUTTON)
> > +               input_report_key(dev, KEY_RECORD, data[22] & 0x01);
> >
> >         /* buttons A,B,X,Y */
> >         input_report_key(dev, BTN_A,    data[4] & 0x10);
> > @@ -1669,9 +1673,11 @@ static int xpad_init_input(struct usb_xpad
> > *xpad)
> >
> >         /* set up model-specific ones */
> >         if (xpad->xtype == XTYPE_XBOX360 || xpad->xtype ==
> > XTYPE_XBOX360W ||
> > -           xpad->xtype == XTYPE_XBOXONE) {
> > +               xpad->xtype == XTYPE_XBOXONE) {
>
> Why the indentation change here?
>
> >                 for (i = 0; xpad360_btn[i] >= 0; i++)
> >                         input_set_capability(input_dev, EV_KEY,
> > xpad360_btn[i]);
> > +               if (xpad->mapping & MAP_SELECT_BUTTON)
> > +                       input_set_capability(input_dev, EV_KEY,
> > KEY_RECORD);
> >         } else {
> >                 for (i = 0; xpad_btn[i] >= 0; i++)
> >                         input_set_capability(input_dev, EV_KEY,
> > xpad_btn[i]);
>
>
