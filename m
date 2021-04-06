Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D01355EBD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 00:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbhDFWZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 18:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhDFWZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 18:25:23 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418C5C06174A;
        Tue,  6 Apr 2021 15:25:15 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id y1so18275746ljm.10;
        Tue, 06 Apr 2021 15:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vWTPaBvW3l1bq9lZ5d4jrmzuUGDyg37jjtUpZ9/p5pY=;
        b=bYOiJNCxSMIO28qq9e7Zz4gSmibccl8Jw3HUQGIAYx62vwGckCostJpu08+Z8+NROd
         +r1IRtf93oLkye5IC2lWEEvtac+ZRdtGFI7oipirybH+VJ//HUDmRcqUGm8mmp8q7Mcv
         bXSzKVv7Otx93/zBMvkyymICujHIaOx+njwLiVeLSBPAlNKI1LFaMAGJ8PQDo755BoNL
         l61K1uGvVY6DyNLpn5SoWbEwpdbo+HrqJkrCIe9lCjsyDHXIoaychDTWhuTE8kVX8YHP
         XK+ULbSYz274oJSDh2yDVZ9i0MvW+mZ3CHqcawRJCTB2qKzj3vjQbAJ1RS4gFwGdRpEW
         ptwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vWTPaBvW3l1bq9lZ5d4jrmzuUGDyg37jjtUpZ9/p5pY=;
        b=s9ymCI6Snp2EIYfSqpz0jxweWdtguv/krUHckLDNdpCurhjJMFyXuaRnQ6Q/o34Xcy
         TUt4UxSEf7xHRwAyq/PbDJCEo4IOMtnfO66YiQLKFLn7MGJd5b4+0CaEIcU5zyAEe0q7
         wH3sI7zKGZoXRvyBGh14QF8puzptyS5BDlt3tdultryYyEw2P4S0XEOJAuSlMJuDExtp
         LjgkzS/fYY3rER6qmGKxgHL5Q5igw6b5UQzthxI1hek47pYB/6SLLD7Db7JFDbszsGZ9
         tMXHyBzULCFLUbiBJdXgPXKezSSMSEKH3UxdopnJ5PM4GGBOdIBs0Qtp1DLy0XSRfn+T
         rIiw==
X-Gm-Message-State: AOAM533Jopf3MJZQl9pH+CKZrhO4q+VkLNLY9sZOrE7BjK1Vn/BjKG65
        mjswTmkEUW7dtgFd0UooQJ1TfPnPVMfMkCFv4DE=
X-Google-Smtp-Source: ABdhPJzPnznY6uPQoTMXmzY70ceBhZUewX0mRm0fNcD3D2hZ67eupim1gl1Hw2MZCKLseCNgcJjBzrI+da4fXWeWM44=
X-Received: by 2002:a2e:b6c6:: with SMTP id m6mr142978ljo.411.1617747913670;
 Tue, 06 Apr 2021 15:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <ed438518-66ad-6e08-2a1b-597ac3f2ae8d@roeck-us.net>
 <20210406181624.713-1-aladyshev22@gmail.com> <0ba1d271-78cd-c30a-e662-97ab8ba6451a@roeck-us.net>
 <CACSj6VUCgxCQeA9EF4Oz+pKY+TdF9Gp=DV1V=-TcVE4ixtg45Q@mail.gmail.com>
 <40d02688-d40c-fcdd-b8eb-580a1e44b244@roeck-us.net> <CACSj6VVjJ9Avd0Ni0Zp4-skv-7Dk9cQkhB5hrsEyb+0ZQR5eJg@mail.gmail.com>
 <422092a4-a87d-59d2-f6cb-9adf19e8f006@roeck-us.net>
In-Reply-To: <422092a4-a87d-59d2-f6cb-9adf19e8f006@roeck-us.net>
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Date:   Wed, 7 Apr 2021 01:25:02 +0300
Message-ID: <CACSj6VW2+8TBh971CERjxPzhyO5JeP0rbkrw0ZjfE4bkhMfo4Q@mail.gmail.com>
Subject: Re: [PATCH v2] hwmon: (sbtsi) Don't read sensor more than once if it
 doesn't respond
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kun Yi <kunyi@google.com>, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What I'm trying to say, shouldn't the call
"i2c_smbus_read_byte_data(data->client, SBTSI_REG_CONFIG)" be
surrounded with the "mutex_lock/mutex_unlock" like it is done for the
others "i2c_smbus_read_byte_data" calls?
Something like:
```
mutex_lock(&data->lock);
err = i2c_smbus_read_byte_data(data->client, SBTSI_REG_CONFIG);
if (err < 0)
    return err;
mutex_unlock(&data->lock);
```
Because it is not surrounded with the mutex lock/unlock in the original driver.

Best regards,
Konstantin Aladyshev


On Wed, Apr 7, 2021 at 12:34 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 4/6/21 2:09 PM, Konstantin Aladyshev wrote:
> > Thanks for the answer!
> > Sorry for the confusion, by the "CPU is off" I meant "CPU is present,
> > but currently it is in the powered off state".
> > Therefore it is not possible to put these checks only in a probe
> > function. And I don't know either if it is a good idea to cache
> > config/min/max values.
> >
> > I use this driver on an OpenBMC system, which uses other software
> > rather than lm-sensors utility. I guess that is why my priorities are
> > shifted.
> >
> > By the way, I've noticed that the mutex check is absent in a
> > SBTSI_REG_CONFIG read call both in the original driver version and in
> > my patch, is this an error?
> >
>
> What do you mean with "mutex check" ?
>
> Thanks,
> Guenter
>
>
> > Best regards,
> > Konstantin Aladyshev
> >
> >
> > On Tue, Apr 6, 2021 at 11:09 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> On 4/6/21 12:20 PM, Konstantin Aladyshev wrote:
> >>> Thanks for the comment.
> >>> Yes, you are correct, this patch adds an extra 'i2c_smbus_read_byte_data' call for the temp_max/temp_min reads.
> >>> I guess I did that intentionally because I just wanted to keep the restructured code concise. After all I thought, 'temp_input' generally is read more often than 'temp_max/temp_min'.
> >>> As I understand now, it seems like it is not acceptable. Therefore could you point me in the right direction about what I should do?
> >>> Should I just stick with the original driver version and simply add two more i2c call checks for the first operations for min/max?
> >>>
> >>
> >> Correct, it is not acceptable. A normal use case for hwmon devices is to use the "sensors"
> >> command which _will_ read all attributes. i2c reads are expensive, and unnecessary read
> >> operations should be avoided.
> >>
> >> There are several ways to solve the problem. Checking return values after each
> >> read is the simple option. There are other possibilities, such as reading the limits
> >> and the read order only once during probe, but I don't know enough about the
> >> hardware to suggest a more sophisticated solution. For example, I don't know
> >> what "CPU is off" means. Offline ? Not present ? If it means "not present",
> >> or if the status is permanent, the condition should be handled in the is_visible
> >> function (or the driver should not be instantiated in the first place).
> >> Otherwise, the code should possibly return -ENODATA instead of -ETIMEDOUT
> >> on error. But, again, I can not really suggest a better solution since
> >> I don't know enough (nothing, actually) about the hardware (and the public
> >> part of the SBTSI specification doesn't say anything about expected behavior
> >> for offline CPUs or CPU cores).
> >>
> >> What I did find, though, is that the driver does not implement temperature
> >> offset support, and it that doesn't support reporting alerts. I'd have assumed
> >> this to be more important than optimizing error handling, but that is just
> >> my personal opinion.
> >>
> >> Thanks,
> >> Guenter
> >>
> >>> Best regards,
> >>> Konstantin Aladyshev
> >>>
> >>>
> >>> On Tue, Apr 6, 2021 at 9:42 PM Guenter Roeck <linux@roeck-us.net <mailto:linux@roeck-us.net>> wrote:
> >>>
> >>>     On 4/6/21 11:16 AM, Konstantin Aladyshev wrote:
> >>>     > SBTSI sensors don't work when the CPU is off.
> >>>     > In this case every 'i2c_smbus_read_byte_data' function would fail
> >>>     > by a timeout.
> >>>     > Currently temp1_max/temp1_min file reads can cause two such timeouts
> >>>     > for every read.
> >>>     > Restructure code so there will be no more than one timeout for every
> >>>     > read operation.
> >>>     >
> >>>     > Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com <mailto:aladyshev22@gmail.com>>
> >>>     > ---
> >>>     > Changes in v2:
> >>>     >   - Fix typo in a commit message
> >>>     >   - Don't swap temp_int/temp_dec checks at the end of the 'sbtsi_read' function
> >>>     >
> >>>
> >>>     This doesn't explain the reason for the extra read operation for
> >>>     limits. Preventing a second read in error cases is not an argument
> >>>     for adding an extra read for non-error cases.
> >>>
> >>>     Guenter
> >>>
> >>>     >  drivers/hwmon/sbtsi_temp.c | 55 +++++++++++++++++++-------------------
> >>>     >  1 file changed, 27 insertions(+), 28 deletions(-)
> >>>     >
> >>>     > diff --git a/drivers/hwmon/sbtsi_temp.c b/drivers/hwmon/sbtsi_temp.c
> >>>     > index e35357c48b8e..4ae48635bb31 100644
> >>>     > --- a/drivers/hwmon/sbtsi_temp.c
> >>>     > +++ b/drivers/hwmon/sbtsi_temp.c
> >>>     > @@ -74,48 +74,47 @@ static int sbtsi_read(struct device *dev, enum hwmon_sensor_types type,
> >>>     >                     u32 attr, int channel, long *val)
> >>>     >  {
> >>>     >       struct sbtsi_data *data = dev_get_drvdata(dev);
> >>>     > +     u8 temp_int_reg, temp_dec_reg;
> >>>     >       s32 temp_int, temp_dec;
> >>>     >       int err;
> >>>     >
> >>>     >       switch (attr) {
> >>>     >       case hwmon_temp_input:
> >>>     > -             /*
> >>>     > -              * ReadOrder bit specifies the reading order of integer and
> >>>     > -              * decimal part of CPU temp for atomic reads. If bit == 0,
> >>>     > -              * reading integer part triggers latching of the decimal part,
> >>>     > -              * so integer part should be read first. If bit == 1, read
> >>>     > -              * order should be reversed.
> >>>     > -              */
> >>>     > -             err = i2c_smbus_read_byte_data(data->client, SBTSI_REG_CONFIG);
> >>>     > -             if (err < 0)
> >>>     > -                     return err;
> >>>     > -
> >>>     > -             mutex_lock(&data->lock);
> >>>     > -             if (err & BIT(SBTSI_CONFIG_READ_ORDER_SHIFT)) {
> >>>     > -                     temp_dec = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_DEC);
> >>>     > -                     temp_int = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_INT);
> >>>     > -             } else {
> >>>     > -                     temp_int = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_INT);
> >>>     > -                     temp_dec = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_DEC);
> >>>     > -             }
> >>>     > -             mutex_unlock(&data->lock);
> >>>     > +             temp_int_reg = SBTSI_REG_TEMP_INT;
> >>>     > +             temp_dec_reg = SBTSI_REG_TEMP_DEC;
> >>>     >               break;
> >>>     >       case hwmon_temp_max:
> >>>     > -             mutex_lock(&data->lock);
> >>>     > -             temp_int = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_HIGH_INT);
> >>>     > -             temp_dec = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_HIGH_DEC);
> >>>     > -             mutex_unlock(&data->lock);
> >>>     > +             temp_int_reg = SBTSI_REG_TEMP_HIGH_INT;
> >>>     > +             temp_dec_reg = SBTSI_REG_TEMP_HIGH_DEC;
> >>>     >               break;
> >>>     >       case hwmon_temp_min:
> >>>     > -             mutex_lock(&data->lock);
> >>>     > -             temp_int = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_LOW_INT);
> >>>     > -             temp_dec = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_LOW_DEC);
> >>>     > -             mutex_unlock(&data->lock);
> >>>     > +             temp_int_reg = SBTSI_REG_TEMP_LOW_INT;
> >>>     > +             temp_dec_reg = SBTSI_REG_TEMP_LOW_DEC;
> >>>     >               break;
> >>>     >       default:
> >>>     >               return -EINVAL;
> >>>     >       }
> >>>     >
> >>>     > +     /*
> >>>     > +      * ReadOrder bit specifies the reading order of integer and
> >>>     > +      * decimal part of CPU temp for atomic reads. If bit == 0,
> >>>     > +      * reading integer part triggers latching of the decimal part,
> >>>     > +      * so integer part should be read first. If bit == 1, read
> >>>     > +      * order should be reversed.
> >>>     > +      */
> >>>     > +     err = i2c_smbus_read_byte_data(data->client, SBTSI_REG_CONFIG);
> >>>     > +     if (err < 0)
> >>>     > +             return err;
> >>>     > +
> >>>     > +     mutex_lock(&data->lock);
> >>>     > +     if (err & BIT(SBTSI_CONFIG_READ_ORDER_SHIFT)) {
> >>>     > +             temp_dec = i2c_smbus_read_byte_data(data->client, temp_dec_reg);
> >>>     > +             temp_int = i2c_smbus_read_byte_data(data->client, temp_int_reg);
> >>>     > +     } else {
> >>>     > +             temp_int = i2c_smbus_read_byte_data(data->client, temp_int_reg);
> >>>     > +             temp_dec = i2c_smbus_read_byte_data(data->client, temp_dec_reg);
> >>>     > +     }
> >>>     > +     mutex_unlock(&data->lock);
> >>>     >
> >>>     >       if (temp_int < 0)
> >>>     >               return temp_int;
> >>>     >
> >>>
> >>
>
