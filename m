Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899EB30C238
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 15:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbhBBOo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 09:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbhBBOgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 09:36:41 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D28DC0617A9
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 06:35:11 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id z18so18973572ile.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 06:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metormote-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxbCZhrXyEpBms1PMxN/fgNiG5aPJp7Qh0x0WvUOWqc=;
        b=cmt8oCF45ERdnS4TC62ZyvNjANtMgkD0Qz/TtoQe/hp8xWz/SVzwWjr6zxgHHb0xBV
         mLgEijse1KP7kfkP5CRiDI3+uXjG9MMoXaOjvZ9IJElBHuyMrZ5gC+zoO6KvdAJihfTj
         5eNGwOCBTRcEVS4cZmsmWiTdI3Nh1wr11g2+Nfia4JPwZ5MtYboowHIXA69EZW1AGfPx
         wKFVnHHPvpH3RbSxuk1SD61vKEl1DvBe0ViDSxBMqT/utmLy7QMtan01LGwMvsHDjeHp
         QcntjqEQXybQoRrU4z0QHaRQDqtxqRvpm0Jc83xAMG1nJVwpxCDY+uEgGZQNp83gieOz
         SHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxbCZhrXyEpBms1PMxN/fgNiG5aPJp7Qh0x0WvUOWqc=;
        b=RAbfPyZTwLYdVByJnipE6mslJG4+iQPKb/O6g8d8BSpbGpqJ+V9RbZMb9SIipd22Y6
         ppML5vWQqVaNKtPtx89L26lryyLlKulOwYaBHaOjrB7s+hys3BoJaVSLGLiJVGCNMmr/
         WH6g0HoElp4xw5QnC7zTQDdIs76BIBWdr1KKZF//5n+SFTPLm/CEvpjUQe+hu4U47zUw
         8kxG+S0uuFqL+jgMmH3f7kXPM9Td+457UJ29Tgmu9qc0x0sNokTU8rWoJu3PK3hXfton
         B+I3duK34TPIVZ2t5VygC75PE6VsQbI7dCED0zlCMQfeEKHgq82iEKj0d1URNsFPPD26
         q2rg==
X-Gm-Message-State: AOAM5333tbLzr6HMvGtxByQLq/RLrsBgDJlXZ+8gKP1wNUQRWA9NtE7H
        LbwUJrVB4rI8/Z8lpm1vY7gkd+LQHoJRpMiq1C0zMZUaDkCrIg1f4wW2GQ==
X-Google-Smtp-Source: ABdhPJwGmXCZYeeBZOUl5j9mn0aLQjPeBGQnCkb1RiZqR7Y0A1g7wCEZ3gcZxoxo5HZY985vRu0pwp5s8zOJ6Elg7mk=
X-Received: by 2002:a05:6e02:b46:: with SMTP id f6mr7458783ilu.230.1612276510632;
 Tue, 02 Feb 2021 06:35:10 -0800 (PST)
MIME-Version: 1.0
References: <20210127084140.35626-1-erik.rosen@metormote.com>
 <20210127084140.35626-2-erik.rosen@metormote.com> <20210127173255.GA144627@roeck-us.net>
 <CA+ui0HmbcQe_CD-0d+AMgx_jSuY=AG9Qx4Ab2g71kPVFrMDe_w@mail.gmail.com>
 <ee2a89f6-0f55-9328-b53d-b5893eb625db@roeck-us.net> <CA+ui0H=UC495kfZuZeg-ryPh_aSa0wFqf=hnn7oS782qFgh60A@mail.gmail.com>
 <778339a4-501c-d73f-4378-9b0c2a6a03c0@roeck-us.net>
In-Reply-To: <778339a4-501c-d73f-4378-9b0c2a6a03c0@roeck-us.net>
From:   Erik Rosen <erik.rosen@metormote.com>
Date:   Tue, 2 Feb 2021 15:34:59 +0100
Message-ID: <CA+ui0H=XW-WSThuYiY0r1-1EhGui1on0UvNYMUD+XsvA+K6ePA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Add ST STPDDC60 pmbus driver
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 10:38 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 2/1/21 8:48 AM, Erik Rosen wrote:
> > Hi Guenter
> >
> >
> > On Fri, Jan 29, 2021 at 4:50 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> Hi Erik,
> >>
> >> On 1/29/21 5:07 AM, Erik Rosen wrote:
> >> [ ... ]
> >>>>
> >>>>> +             break;
> >>>>> +     case PMBUS_VOUT_OV_FAULT_LIMIT:
> >>>>> +     case PMBUS_VOUT_UV_FAULT_LIMIT:
> >>>>> +             ret = pmbus_read_word_data(client, page, phase, reg);
> >>>>> +             if (ret < 0)
> >>>>> +                     return ret;
> >>>>> +             ret &= 0x07ff;
> >>>>
> >>>> This needs explanation. The BMR481 datasheet does not suggest that only
> >>>> 11 bits are valid.
> >>>
> >>> Ok, I will add a clarification. These registers use LINEAR11 whereas
> >>> LINEAR16 is expected for vout-related registers.
> >>>
> >> Is that the correct fix, then ? LINEAR11 means that the exponent is flexible,
> >> while it is fixed for LINEAR16. Just assuming that the exponents always match
> >> seems risky. Also, bit 11 in LINEAR11 is the sign bit, meaning negative limits
> >> (which seem at least theoretically be possible) would be reported as large
> >> positive values.
> >
> > The chip actually uses fixed exponents for representing all linear values and
> > the specification explicitly states the values of the LSB for all registers.
> > It also states that the limits can be handled as linear format when
> > writing  _if_
> > the exponent is the fixed value used for that limit. This means I'll have to
> > convert all limit writes to use the expected exponent.
>
> I understand the datasheet a bit differently. You are correct, the exponent for
> VOUT limits is always the same (LSB=0.00390625V, exponent -8), as it should be.
> But it also seems to me that the data format is LINEAR16, not LINEAR11.
> The datasheet says that the vout limit values are in bit 0..15.
>
> For other sensors, the datasheet is a bit ambiguous. I can read it as always
> using a fixed exponent when reading, or that it expects a fixed exponent when
> writing. It might make sense to check this with an actual chip instead of
> guessing. In this context, it is a bit odd that the datasheet keeps talking
> about a "System Register IOUT_EXP" without actually specifying it.
>
> In this context, you might want to watch out for register MFR_SVID_SLOW_SR_SELECTOR.
> Its value seems to impact the exponents used for IOUT and POUT.
>
> Also, I am not sure about the scale of other registers. It almost seems as if
> limit registers are LINEAR11, but actual READ_xxx registers are LINEAR16.
> For example, READ_IOUT is supposed to be bit 15:0 with the LSB determined
> by IOUT_EXP, but IOUT_OC_WARN_LIMIT is in bit 9:0. This would be a problem
> if READ_IOUT does not include the exponent, since it is interpreted as
> LINEAR11 and expects the exponent in bit 11..15. With an expected exponent
> of -1, the reported value would always be wrong. The same might apply
> to pretty much all READ_xxx registers (what a mess).

I have tested all commands on a real chip and the behavior is as follows:

All linear (both limits and READ_XXX) registers return the exponent i.e. use
the LINEAR11 format (even the vout related ones that really should use LINEAR16
according to the pmbus standard), so reading registers is quite straightforward.

I got hold of an excel-document from ST that describes the pmbus
commands and system registers of the chip in greater detail. Unfortunately
it has got 'STMicroelectronics Confidential' stamped all over it so I
can't really
share it publicly.

Iout and pout data and limits are described as:
[15:11]: Encoded/Decoded with N programmed by HC_SUPPORT bit or IOUT_EXP
[10]: 0b0
[9:0]: Y mantissa

Other data and limits (including vout) are described as:
[15:11]: Encoded/Decoded with N=X, LSB=XX
[10]: Don't care (returns 0 in read access)
[9:0]: Y; max XXX

where X... are fixed values. The sign bit is always zero.

You are correct in that it is possible to change the fixed exponents used for
iout and pout by manipulating the system registers accessible via
 extended commands.

However, in a footnote on the bottom of the page it says:
(***) Number format - When Linear, data need to be formatted with N specified.
Data sent with N different from what reported, will be decoded as if N
is the one
reported.

I can only interpret this as that the chip expects data written to a
linear register
to be encoded with the same exponent as it uses when the same register is read.

So the simplest way of ensuring that the correct exponent is used when
writing to
the chip seems to be to first read the value from the chip, extract the exponent
and then adjust the value to use this exponent before writing it.

/Erik
>
> Thanks,
> Guenter
>
> > Given this, I think it's safe to assume that the exponents are
> > constant, but I'll
> > add a check to handle potential negative values.
> >
> >>
> >>>>
> >>>>> +             break;
> >>>>> +     default:
> >>>>> +             ret = -ENODATA;
> >>>>> +             break;
> >>>>> +     }
> >>>>> +
> >>>>> +     return ret;
> >>>>> +}
> >>>>> +
> >>>>> +/*
> >>>>> + * The vout under- and over-voltage limits are readonly for this chip.
> >>>>> + */
> >>>>
> >>>> Not really. The BMR481 datasheet suggests that the value can be changed
> >>>> by writing to MFR_OV_LIMIT_OFFSET and MFR_UV_LIMIT_OFFSET.
> >>>> I am not saying that you should implement that if you don't want to,
> >>>> but I would suggest a better (more accurate) explanation.
> >>>
> >>> I have looked into this a bit more and it's a bit more to it than I expected.
> >>> The limits are actually dynamic values that will follow both commanded
> >>> output voltage via the PMBus or SVID/AVSBus as well as current
> >>> load (droop). To account for this I propose a mechanism to set the
> >>
> >> Yes, I noticed.
> >>
> >>> 'update' flag on selected sensors after auto-detection of limit attributes.
> >>>
> >>> Maybe add a function like this to pmbus_core that can be called
> >>> after the probing is done?
> >>>
> >>> int pmbus_set_update(struct i2c_client *client, u8 reg)
> >>> {
> >>>         struct pmbus_data *data = i2c_get_clientdata(client);
> >>>         struct pmbus_sensor *sensor;
> >>>
> >>>         for (sensor = data->sensors; sensor; sensor = sensor->next) {
> >>>                 if (sensor->reg == reg) {
> >>>                         sensor->update = true;
> >>>                         return 0;
> >>>                 }
> >>>         }
> >>>         return -ENXIO;
> >>> }
> >>>
> >>
> >> Add a boolean 'update' parameter (to be able to disable updates),
> >> and make the function void. Also, remember that 'reg' may be repeated
> >> on a chip with multiple pages, so you can't return after the first match.
> >> Otherwise looks ok.
> >
> > Ok
> >
> >>
> >>> I did also implemented writes to the limit registers via the offset
> >>> registers but it might be
> >>> a bit confusing to the user since the limits are set in relation to
> >>> the current commanded
> >>> output voltage and will change together with this. In the worst case,
> >>> the voltage might
> >>> change at the same time as the limit is written to, which will give
> >>> unexpected results.
> >>
> >> Agreed, that can be tricky.
> >>
> >>> The alternative would be to just set these limits read-only. What is
> >>> your opinion?
> >>>
> >>
> >> Your call. Just add a note explaining why it is made read-only to explain
> >> the reasoning for future readers.
> >
> > Ok, I'll keep the functionality and add a note in the docs.
> >
> >
> >>
> >>> Also, I found a problem in how pmbus_set_sensor() works together with
> >>> pmbus_clear_cache()
> >>> as used in the zl6100 and lm25066 drivers. The new value is written to
> >>> the sensor struct _after_
> >>> the _pmbus_write_word_data() has returned and thus after
> >>> pmbus_clear_cache() is called.
> >>> The effect is that all values are cleared, except the one just written
> >>> to, which I believe defeats
> >>> the purpose of clearing the cache in the first place.> One solution would be to write the new value to sensor->data before
> >>> the _pmbus_write_word_data
> >>> is called and to restore the old value in case of error.
> >>> I can make a separate patch for this if it seems like a reasonable solution?
> >>>
> >>
> >> Good catch.
> >>
> >> An alternate and more generic solution might be to set sensor->data to
> >> -ENODATA after updates. After all, it seems risky to assume that the chip
> >> returns the value that was written (I have seen it often enough in other
> >> drivers that this is not necessarily the case). That would also mean that
> >> it would no longer be necessary to call pmbus_clear_cache() in the zl6100
> >> and lm25066 drivers. Impact would be that a limit read after a write would
> >> always be sent to the chip for all drivers, but that seems minimal compared
> >> to the gain (and presumably limit registers are not frequently updated).
> >
> > I agree that this is a more robust solution. I'll send a separate patch for this
> > update. The zl6100 in fact still needs to clear the cache since a write to the
> > fault limit also changes the value of the warning limit and vice versa. As far
> > as I can see the usage in lm25066 can be removed however.
> >
> >>
> >> Thanks,
> >> Guenter
>
