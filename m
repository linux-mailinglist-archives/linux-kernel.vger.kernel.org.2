Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F2035CFE4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 19:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243843AbhDLR6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 13:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239858AbhDLR6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 13:58:18 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F116C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 10:57:59 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id u200so473220vku.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 10:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wQwEibf/qRDlUg9g4tQhhRSZ449db5ajiJyiNZmODrg=;
        b=NF0WMlfkqU4i3PEuQLAlg8Jd2mtSsBq+sKarvmeiuUTGAvkyhbK9Iw5aiCTfcy0uPG
         bpHx67m4h2KPDkvSQKdgd45Gm8JHGlQiPisYhnD3cl1kz47m6e6Q2pqY5xs9si4fGOOU
         kazpYOw/y1GFkfZiA+tXBLbOXLGzuW/7/rtOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wQwEibf/qRDlUg9g4tQhhRSZ449db5ajiJyiNZmODrg=;
        b=GsZ7McWcZDDpHcLwzJiwExlkjGR1Y4fGWnGORfI+94v85umDuoRFlzMVwYGGyv/FOt
         y3azEGJrD0RrA4rU0eoncNQvfZbrU0ixIE9o6E3vp2H9ZmTnNmrRYDBoew4QMdfEH9Jh
         P8fnS2DZexPSGTiPU0VkMpPZaJ7GTOeRstwEWaTuOWbZQpw80T3Ifb/WHwUNfjfD8bBi
         2XEAvJ1xjL1kyEnTEIQoc2RsUWUp/s318oZFqP34ntCeoABSeIRA+YuVIOp4d+XN2Wup
         Iqc78NKaFwfdB56Fn7OXZ+yr8yMpVxQks2qJmE1DJv2xtH51z1qcJvSvGxnd5K6rMOrk
         c1xg==
X-Gm-Message-State: AOAM533ddqX6WW8HmOxMzoBCcOTPreehqYuQ7k/x3eyvNzNcFwRXS2E0
        ADLnh+mFD8VU67D5dZff4tFWaLtFRfrp9MVh
X-Google-Smtp-Source: ABdhPJwi/tj1cpV2lJ/yavfVP2W0y8odFVFrQttJ7KALHikTLGm85kTu4GVZwu9+6PQdZnTq4cDX4Q==
X-Received: by 2002:a1f:53c7:: with SMTP id h190mr21079083vkb.19.1618250278128;
        Mon, 12 Apr 2021 10:57:58 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id c129sm1254665vkb.21.2021.04.12.10.57.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 10:57:57 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id x14so2406951vsc.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 10:57:57 -0700 (PDT)
X-Received: by 2002:a67:f595:: with SMTP id i21mr20935076vso.16.1618250277111;
 Mon, 12 Apr 2021 10:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <1618190463-12993-1-git-send-email-johnny.chuang.emc@gmail.com> <CA+jURcu2a91quZc+gto=HixCH+O_V+fPVdKrO_9HvR2pcu9RmQ@mail.gmail.com>
In-Reply-To: <CA+jURcu2a91quZc+gto=HixCH+O_V+fPVdKrO_9HvR2pcu9RmQ@mail.gmail.com>
From:   Harry Cutts <hcutts@chromium.org>
Date:   Mon, 12 Apr 2021 10:57:46 -0700
X-Gmail-Original-Message-ID: <CA+jURcsvVSzjc2Mm=-pgG+fMhpj3VeT0+YeSjgWfYqe=Ga9_Vw@mail.gmail.com>
Message-ID: <CA+jURcsvVSzjc2Mm=-pgG+fMhpj3VeT0+YeSjgWfYqe=Ga9_Vw@mail.gmail.com>
Subject: Re: [PATCH v2] HID: i2c-hid: Skip ELAN power-on command after reset
To:     Johnny Chuang <johnny.chuang.emc@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Johnny Chuang <johnny.chuang@emc.com.tw>,
        James Chen <james.chen@emc.com.tw>,
        Jennifer Tsai <jennifer.tsai@emc.com.tw>,
        Paul Liang <paul.liang@emc.com.tw>,
        Jeff Chuang <jeff.chuang@emc.com.tw>,
        Douglas Anderson <dianders@chromium.org>,
        Jingle <jingle.wu@emc.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Apr 2021 at 10:56, Harry Cutts <hcutts@chromium.org> wrote:
>
> On Sun, 11 Apr 2021 at 18:21, Johnny Chuang <johnny.chuang.emc@gmail.com> wrote:
> >
> > Previous commit 43b7029f475e ("HID: i2c-hid:
> > Send power-on command after reset"), it fixed issue for SIS touchscreen.
> >
> > For ELAN touchscreen, we found our boot code of IC was not flexible enough
> > to receive and handle this command.
> > Once the FW main code of our controller is crashed for some reason,
> > the controller could not be enumerated successfully to be recognized
> > by the system host. therefore, it lost touch functionality.
> >
> > Add quirk for skip send power-on command after reset.
> > It will impact to ELAN touchscreen and touchpad on HID over I2C projects.
> >
> > Signed-off-by: Johnny Chuang <johnny.chuang.emc@gmail.com>
>
> It's probably a good idea to add a Fixes: tag, like so:
>
>     Fixes: 43b7029f475e ("HID: i2c-hid: Send power-on command after reset")
>
> Other than that,
>
> Reviewed-by: Harry Cutts <hcutts@chromium.org>
>
> Harry Cutts
> Chrome OS Touch/Input team
>
> > ---
> > Changes in v2:
> >     - move comment to quirk entry
> > ---
> >  drivers/hid/i2c-hid/i2c-hid-core.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> > index 9993133..957d865 100644
> > --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> > +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> > @@ -45,6 +45,7 @@
> >  #define I2C_HID_QUIRK_BOGUS_IRQ                        BIT(4)
> >  #define I2C_HID_QUIRK_RESET_ON_RESUME          BIT(5)
> >  #define I2C_HID_QUIRK_BAD_INPUT_SIZE           BIT(6)
> > +#define I2C_HID_QUIRK_NO_WAKEUP_AFTER_RESET    BIT(7)
> >
> >
> >  /* flags */
> > @@ -178,6 +179,12 @@ static const struct i2c_hid_quirks {
> >                  I2C_HID_QUIRK_RESET_ON_RESUME },
> >         { USB_VENDOR_ID_ITE, I2C_DEVICE_ID_ITE_LENOVO_LEGION_Y720,
> >                 I2C_HID_QUIRK_BAD_INPUT_SIZE },
> > +/*
> > + * Sending the wakeup after reset actually break ELAN touchscreen controller
> > + * Add I2C_HID_QUIRK_NO_WAKEUP_AFTER_RESET to skip wakeup after reset
> > + */

...though, just spotted, you should indent the comment.

> > +       { USB_VENDOR_ID_ELAN, HID_ANY_ID,
> > +                I2C_HID_QUIRK_NO_WAKEUP_AFTER_RESET },
> >         { 0, 0 }
> >  };
> >
> > @@ -461,7 +468,8 @@ static int i2c_hid_hwreset(struct i2c_client *client)
> >         }
> >
> >         /* At least some SIS devices need this after reset */
> > -       ret = i2c_hid_set_power(client, I2C_HID_PWR_ON);
> > +       if (!(ihid->quirks & I2C_HID_QUIRK_NO_WAKEUP_AFTER_RESET))
> > +               ret = i2c_hid_set_power(client, I2C_HID_PWR_ON);
> >
> >  out_unlock:
> >         mutex_unlock(&ihid->reset_lock);
> > --
> > 2.7.4
> >
