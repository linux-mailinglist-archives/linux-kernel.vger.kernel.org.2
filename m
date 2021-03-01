Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF6332A05E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241169AbhCBEQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346228AbhCAXjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 18:39:00 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9B7C061788
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 15:38:19 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id p15so12705651ljc.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 15:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gkvW9rnAlVrrlrrGD2GSKdie37JTF8GU86kA7j7aHeo=;
        b=nubbpxqyCyKgV5t3WaK1KD1T6BWuY3422/bdoUS1daT+y3rILpcjZpHRpVm1KcFoRQ
         vlZcFyXU+XGMxw4nVHeWzcaG9sMwjfqd7NrORrIAHXhn5YrJF7Xw2o4ORBVl0g8Pwlx+
         eUhyL/MbcinMj9xsgFNfN/tRdrPJYzKku/88UmF8crvGT+I9MGKFDWr73ULe4cGucncy
         NyKE84M+v+QjOoRsazVBiUAQii6hjYLo5SvUPZ9cCCbx87Xgr2gaw1tZcOY3oA/ReSYi
         jf63GfmDttlyqNJ34dGRH/cgjVQtmogk0r393gUUdyQdJI8NnRmTI+45+VoQlJWptDsh
         y4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gkvW9rnAlVrrlrrGD2GSKdie37JTF8GU86kA7j7aHeo=;
        b=qT/QJMuP3fO2BlpnU0EoVq5fzrY6TTTjBOWYGvYNcLcacSRklr9+OhUwiWg4vrcRs8
         15imexEHgpm2PZNJ9uDGMWsdcOVzzz20/eLtX7IvNpXf4nj38Dmdr6ZAuZfR5/9bypk1
         86HXoOaU14C11YYxRDSJfDxms+w7kQsbvRb/piiHLiQb5M5Cg5fBEIg+EXOjc7XQw0B3
         Pv7ZL8ApsxxuKY8hSvmq/z8Lf0MF5Nq1IMVUhWI/UDtpzh4nd5YV/UuZ80CeXn4uB1oA
         xgeG0XSbB6u3W72BC6AZ/WS5mHTkmfwPFH5oDpz+wzqgHbRhCW+8gzbZgq2jGVlQP5FX
         H2Gg==
X-Gm-Message-State: AOAM5335H3qH/X0rsLGeIx162vfEfy2fB3HT45BKBJRDQK2HmmKl8QGj
        yLyNY7OUWTBEdZREilzM31Isqm3zClzxp4uBadznLQ==
X-Google-Smtp-Source: ABdhPJxxQ5IFkLUqMOdxhkvL0U1j2fGqEOe5v8TZuky0ju7dH20Lo771DCVs5Dv4Zrd1EwBOMkQmpDzG6LLGA7xrv+s=
X-Received: by 2002:a2e:bc0c:: with SMTP id b12mr10601399ljf.201.1614641897775;
 Mon, 01 Mar 2021 15:38:17 -0800 (PST)
MIME-Version: 1.0
References: <20210225053204.697951-1-lzye@google.com> <78269a7f-f50b-d763-3511-0b3cf80fdbef@gmail.com>
In-Reply-To: <78269a7f-f50b-d763-3511-0b3cf80fdbef@gmail.com>
From:   Chris Ye <lzye@google.com>
Date:   Mon, 1 Mar 2021 15:38:06 -0800
Message-ID: <CAFFuddKhQ+hpTHbxWDveG2_6sL_Q8gkg7+o3eep-PTUGT2t+nQ@mail.gmail.com>
Subject: Re: [PATCH] [v2] Input: Add "Share" button to Microsoft Xbox One controller.
To:     Cameron Gutman <aicommander@gmail.com>
Cc:     =?UTF-8?Q?=C5=81ukasz_Patron?= <priv.luk@gmail.com>,
        Benjamin Valentin <benpicco@googlemail.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Olivier_Cr=C3=AAte?= <olivier.crete@ocrete.ca>,
        Sanjay Govind <sanjay.govind9@gmail.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cameron,
   I was first thinking of adding a new XTYPE but then realized it is
still XBox One but just a model with extra button, so adding
MAP_SHARE_BUTTON would avoid adding a new XTYPE there.
Addressed the name to be "Microsoft Xbox One X pad" and removed the
{}, please review again, thanks!
Chris


On Sat, Feb 27, 2021 at 6:01 PM Cameron Gutman <aicommander@gmail.com> wrote:
>
> On 2/24/21 11:32 PM, Chris Ye wrote:
> > Add "Share" button input capability and input event mapping for
> > Microsoft Xbox One controller.
> > Fixed Microsoft Xbox One controller share button not working under USB
> > connection.
> >
> > Signed-off-by: Chris Ye <lzye@google.com>
> > ---
> >  drivers/input/joystick/xpad.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> > index 9f0d07dcbf06..0c3374091aff 100644
> > --- a/drivers/input/joystick/xpad.c
> > +++ b/drivers/input/joystick/xpad.c
> > @@ -79,6 +79,7 @@
> >  #define MAP_DPAD_TO_BUTTONS          (1 << 0)
> >  #define MAP_TRIGGERS_TO_BUTTONS              (1 << 1)
> >  #define MAP_STICKS_TO_NULL           (1 << 2)
> > +#define MAP_SHARE_BUTTON             (1 << 3)
> >  #define DANCEPAD_MAP_CONFIG  (MAP_DPAD_TO_BUTTONS |                  \
> >                               MAP_TRIGGERS_TO_BUTTONS | MAP_STICKS_TO_NULL)
> >
> > @@ -130,6 +131,7 @@ static const struct xpad_device {
> >       { 0x045e, 0x02e3, "Microsoft X-Box One Elite pad", 0, XTYPE_XBOXONE },
> >       { 0x045e, 0x02ea, "Microsoft X-Box One S pad", 0, XTYPE_XBOXONE },
> >       { 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
> > +     { 0x045e, 0x0b12, "Microsoft X-Box One X pad", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
>
> Let's use 'Xbox' for new entries instead of 'X-Box'. There was an effort to
> standardize on 'Xbox' (which is what Microsoft uses), but changing device
> names can impact userspace which may use these names in mapping heuristics
> (SDL does this). We can at least not make the problem worse though.
>
> >       { 0x046d, 0xc21d, "Logitech Gamepad F310", 0, XTYPE_XBOX360 },
> >       { 0x046d, 0xc21e, "Logitech Gamepad F510", 0, XTYPE_XBOX360 },
> >       { 0x046d, 0xc21f, "Logitech Gamepad F710", 0, XTYPE_XBOX360 },
> > @@ -862,6 +864,8 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
> >       /* menu/view buttons */
> >       input_report_key(dev, BTN_START,  data[4] & 0x04);
> >       input_report_key(dev, BTN_SELECT, data[4] & 0x08);
> > +     if (xpad->mapping & MAP_SHARE_BUTTON)
> > +             input_report_key(dev, KEY_RECORD, data[22] & 0x01);
> >
>
> I was worried adding a button to an existing supported gamepad like this
> might cause a breaking change to SDL's gamepad mapping for this gamepad,
> since SDL assigns each present button an index rather than using the keycodes
> directly (adding a new one could change the old indices). Fortunately, SDL
> always processes buttons in the BTN_GAMEPAD range first, so this new button
> ends up at the end of the list anyway.
>
>
> >       /* buttons A,B,X,Y */
> >       input_report_key(dev, BTN_A,    data[4] & 0x10);
> > @@ -1669,9 +1673,12 @@ static int xpad_init_input(struct usb_xpad *xpad)
> >
> >       /* set up model-specific ones */
> >       if (xpad->xtype == XTYPE_XBOX360 || xpad->xtype == XTYPE_XBOX360W ||
> > -         xpad->xtype == XTYPE_XBOXONE) {
> > +             xpad->xtype == XTYPE_XBOXONE) {
> >               for (i = 0; xpad360_btn[i] >= 0; i++)
> >                       input_set_capability(input_dev, EV_KEY, xpad360_btn[i]);
> > +             if (xpad->mapping & MAP_SHARE_BUTTON) {
> > +                     input_set_capability(input_dev, EV_KEY, KEY_RECORD);
> > +             }
>
> Style nit: Drop the uneeded {} here
>
> >       } else {
> >               for (i = 0; xpad_btn[i] >= 0; i++)
> >                       input_set_capability(input_dev, EV_KEY, xpad_btn[i]);
> >
> LGTM, other than the minor changes suggested above.
>
>
> Regards,
> Cameron
