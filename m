Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBEC9393617
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 21:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbhE0TPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 15:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhE0TPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 15:15:49 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D5CC061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 12:14:15 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id k16so1623634ios.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 12:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ku2NKkULVbfZwyW7jGY6ydjs2MLQ+KhB/I+lldp2vR8=;
        b=kbTLP7VTAtzKu0qPSneXDSwJ+SF2fSL/prm4RpBt1/7pkLgnCtyWeDXHcP+2dUReDq
         DqXEU6TnbR19e8kyI8bfOLOnDJCtSqIojsMJA/IyU/y1MxeJ/Lyyio01Ruv/0cHtgGf8
         xEM7QcsFwf6cI2mS7SkFrDlWJE8ozjdn1dn7+x5xaoV5loIdYS8E5WdFaB+AarbrYpOp
         EfigtHFPun5x4eyhECCX7xMZtufl7BWQi8rklXV/cpZ5C3YVpbBsJZZZ23XiiaQbQKZt
         6yukZ4ZNCYzDstjFWYMmk4+TESEJXGwL9PMUAaRhF9Pbn82FIKvilH1tDfhQlC21yhgZ
         72gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ku2NKkULVbfZwyW7jGY6ydjs2MLQ+KhB/I+lldp2vR8=;
        b=tDl29opkFJTFL1+Otav9fXqpSTlKYZuAkMEpyM79stQGhbSTweW4+X76ceX29JB2AD
         4xJMz4OeiBQDbOJIumrb8uNXyqKdaR+mej45p0bTyISiVEG+K1raLmdjBE5nwCHxDqwG
         b/KmYU4DfNl+GbhYYAycFt2nDMMOVJYdb61cTeVSxs5VFnPp0aMZT/hSo/qke7LoSZ2u
         Hf2Xm4+uIaPUUwyfK/1nQcyqDPFDnX2IUHLm6H3WTUE5zqd6ZvK2WzP5v+wha+0b12wA
         Ic0dFRrcNSAlzvxAmmH2uMid4z8F4ZEaJM9cQ0Ku9Obr61V5RqSVCNPHW7omEGFvy7+S
         Ckpg==
X-Gm-Message-State: AOAM530/LWq1RQ9CUwKIyKTTJbKRd2Z/jQvgvOrOG0zxaVe2xPZL+iwc
        YZ/Ju6nJXNJq7rTh+ibgWv/RMf73yLEaG/jnvyH/PQ==
X-Google-Smtp-Source: ABdhPJwLK92UjPLV/iWaoOZ28QkNvXI/OHgGYo6GnZV0AE2HhIPjkdcOfaB43SjFHLkJd6rT8y0RK4qJUG+Hdaq3+E0=
X-Received: by 2002:a02:2a0b:: with SMTP id w11mr4995717jaw.22.1622142854642;
 Thu, 27 May 2021 12:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210430132735.127342-1-robert.marko@sartura.hr>
 <20210430134810.GA2714262@roeck-us.net> <CA+HBbNH+gQOmu_Ho0ivFuGHdu0zBtOrr1474z+7FA1zmNb4bug@mail.gmail.com>
 <2b990feb-dc26-debb-4f81-430bbc89b51c@roeck-us.net> <CA+HBbNHQHqD-wgryaBLZ5M2Lxafb0OwNcbiQJmRQPcZfprmUEg@mail.gmail.com>
 <2a1a63c7-c9b0-e38d-df1d-7643ad493aba@roeck-us.net> <CA+HBbNF62xzBt2r60qfzn9iveiusLKp6R-T4KU-NgoHaE6c3kQ@mail.gmail.com>
 <dec7d641-2954-29f0-124b-d0020866bf7b@roeck-us.net> <CA+HBbNGU4d4g0JrUKBhj07OsC7=s9qoubxNDi3MxPjmV457C+Q@mail.gmail.com>
 <8152a109-d76d-4f85-9da2-fe0a56c2019f@roeck-us.net> <CA+HBbNGBirE=Po7q5eUeHho0rBATa_ApWLiU_oPXsGN+6U9U+g@mail.gmail.com>
 <CA+HBbNGZ1axZpRy5UwQP_4eZCA32eyPJVcj6xN4i8AhOQMYeTA@mail.gmail.com>
 <493e4da4-8f2b-9856-b538-6e95e3766d5e@roeck-us.net> <CA+HBbNHspA5cZJSHJkLpnP+UODGy7w5i8mKP2NH9JALQ1RqQ_w@mail.gmail.com>
 <7af2d708-7e22-3970-7bf8-1cb23317cb55@roeck-us.net> <CA+HBbNFVKYPAPKkGJiRhW4VmEGX=da8QALNwbVA1gGegF6KPkQ@mail.gmail.com>
 <2ba03d58-a4de-b683-6169-3f12482aa29e@roeck-us.net>
In-Reply-To: <2ba03d58-a4de-b683-6169-3f12482aa29e@roeck-us.net>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Thu, 27 May 2021 21:14:03 +0200
Message-ID: <CA+HBbNHp2-a-zgUKRLUQVLcs4qcUim=_75YgVZApH1hRrAaP6w@mail.gmail.com>
Subject: Re: [PATCH 1/3] hwmon: (pmbus) Add driver for Delta DPS-920AB PSU
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luka Perkov <luka.perkov@sartura.hr>, jmp@epiphyte.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Donald Buczek <buczek@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 6:37 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 5/27/21 7:58 AM, Robert Marko wrote:
> [ ... ]
>
> >>>>>> I tried applying the block support for mv64xx as well:
> >>>>>> https://patchwork.ozlabs.org/project/linux-i2c/patch/20200118115820.9080-1-fuga@studiofuga.com/
> >>>>
> >>>> That patch would be needed, but it looks buggy to me. This chunk:
> >>>>
> >>>> +               drv_data->effective_length = data+1;
> >>>> +               drv_data->bytes_left = data+1;
> >>>> +               drv_data->msg->len = data+1;
> >>>>
> >>>> should be:
> >>>>
> >>>> +               drv_data->effective_length = data+1;
> >>>> +               drv_data->bytes_left = data;
> >>>> +               drv_data->msg->len = data+1;
> >>>>
> >>>> It should also make sure that 'data' is not larger than I2C_SMBUS_BLOCK_MAX,
> >>>> and bail out if it isn't.
> >>>
> >>> Yeah, I did not check the contents, I just saw 2 reviews and tested it
> >>> since it can't hurt.
> >>
> >> That patch doesn't work at all. Make the above change, and also change
> >> the type of effective_length from u32 to int, and try again.
> >
> > I was just looking and it, and doing the changes you recommended make
> > no difference at all.
> >
>
> Is the i2c controller compatible with marvell,mv78230-i2c ?
> The block transfers would not work in that case. Let me know
> and I'll send you a patch that might fix it.

Yes, the CPU is Armada 7040 and I can see that compatible is
marvell,mv78230-i2c indeed.

It would be great if you have the patch,
Regards
Robert
>
> Guenter



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
