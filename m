Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2903639367A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 21:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbhE0TpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 15:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbhE0TpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 15:45:18 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186CDC061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 12:43:45 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id z24so1748911ioi.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 12:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=woUpDlfXR4mgFixHQlzu3N9d4JrzYqmgck+ojtXAOcE=;
        b=Vx1dHNvUxDpibfzozk5E2MwMR6j994FAog1TWHrt1lKpgIsF+RedhdH5lkjsA2HaGT
         Szw5/rTGpDDJPUySlaD3SKQ9w8Lq84G1v9WcbIShuI5O1aeAPxrBsX0Q38wOWKQ8REPo
         PhTLBZ42dBW3sHeJajqV7fM6F5LIRreNEeQa+XgdOH9bRFfgDJsBuxiXt9I3AJrPLuOD
         YjIHMBk0U1j0BGwdqxaUOTqERCVQpdbN8XY6XMm2k3PHPQXJUjxtzX9zvc5PNmail3p0
         7jsNor9c7XdRlMUeogqV9KncxYbIMTuhtd46IdU057vI0oVIwpAC0jWpi3963nsrnn62
         To0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=woUpDlfXR4mgFixHQlzu3N9d4JrzYqmgck+ojtXAOcE=;
        b=NEwuOQmLUBGgbPjyFHRCtYIHLMKWx9HT0QFJGYkIGJo/TZsezGuhNOSQE5Tn9N77N8
         EvF/+b1tsbJqtMRbmZu1CpVS99I7w80QsPEB+m1CC4a1o2KpHxwZL7dPNs7PN8N3JC3Y
         SBsQ6zetGT+2CPabU6M7anZdzmbavdcgfW1lpi+NyvkqRQrnefEgBh7diz8ACrpykv66
         GH58/25nKfWgmnzgHl4yB+BxeltoGyWDslENeyGxboka423BjsVlO46Q6t9C0vvbaTrD
         P8ej4ViT9vX0H/ADzuDRk95J581YMFtGGaRrLYynRIP8jiMkTUFeNTVI2QQ7q1wfWeYC
         wNmg==
X-Gm-Message-State: AOAM5308R4ju2PGf+xwjl+NzbPF7/aarctL5Gz+bLmsK8jfmBfEx+7Ci
        vv34RA2ERRRA8NPGyJcEXP8hga2hKs9u3DlzaBmvCiQisqf82g==
X-Google-Smtp-Source: ABdhPJxhCk93piRm4uKOt2rat1iWMMX+Rq0dO8beHk993/GMxVRF0WM31pqq+neGlnQ2yP3KZtwKgssyRqSzkHjrHn4=
X-Received: by 2002:a05:6602:189:: with SMTP id m9mr4116791ioo.88.1622144624409;
 Thu, 27 May 2021 12:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <CA+HBbNGU4d4g0JrUKBhj07OsC7=s9qoubxNDi3MxPjmV457C+Q@mail.gmail.com>
 <8152a109-d76d-4f85-9da2-fe0a56c2019f@roeck-us.net> <CA+HBbNGBirE=Po7q5eUeHho0rBATa_ApWLiU_oPXsGN+6U9U+g@mail.gmail.com>
 <CA+HBbNGZ1axZpRy5UwQP_4eZCA32eyPJVcj6xN4i8AhOQMYeTA@mail.gmail.com>
 <493e4da4-8f2b-9856-b538-6e95e3766d5e@roeck-us.net> <CA+HBbNHspA5cZJSHJkLpnP+UODGy7w5i8mKP2NH9JALQ1RqQ_w@mail.gmail.com>
 <7af2d708-7e22-3970-7bf8-1cb23317cb55@roeck-us.net> <CA+HBbNFVKYPAPKkGJiRhW4VmEGX=da8QALNwbVA1gGegF6KPkQ@mail.gmail.com>
 <2ba03d58-a4de-b683-6169-3f12482aa29e@roeck-us.net> <CA+HBbNHp2-a-zgUKRLUQVLcs4qcUim=_75YgVZApH1hRrAaP6w@mail.gmail.com>
 <20210527192657.GA3454023@roeck-us.net>
In-Reply-To: <20210527192657.GA3454023@roeck-us.net>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Thu, 27 May 2021 21:43:33 +0200
Message-ID: <CA+HBbNHsgS_ZTf5_n0LDSv=6ztUHJ4sweWJL7=AGeR5nhu6Zrw@mail.gmail.com>
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

On Thu, May 27, 2021 at 9:27 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Thu, May 27, 2021 at 09:14:03PM +0200, Robert Marko wrote:
> > On Thu, May 27, 2021 at 6:37 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > On 5/27/21 7:58 AM, Robert Marko wrote:
> > > [ ... ]
> > >
> > > >>>>>> I tried applying the block support for mv64xx as well:
> > > >>>>>> https://patchwork.ozlabs.org/project/linux-i2c/patch/20200118115820.9080-1-fuga@studiofuga.com/
> > > >>>>
> > > >>>> That patch would be needed, but it looks buggy to me. This chunk:
> > > >>>>
> > > >>>> +               drv_data->effective_length = data+1;
> > > >>>> +               drv_data->bytes_left = data+1;
> > > >>>> +               drv_data->msg->len = data+1;
> > > >>>>
> > > >>>> should be:
> > > >>>>
> > > >>>> +               drv_data->effective_length = data+1;
> > > >>>> +               drv_data->bytes_left = data;
> > > >>>> +               drv_data->msg->len = data+1;
> > > >>>>
> > > >>>> It should also make sure that 'data' is not larger than I2C_SMBUS_BLOCK_MAX,
> > > >>>> and bail out if it isn't.
> > > >>>
> > > >>> Yeah, I did not check the contents, I just saw 2 reviews and tested it
> > > >>> since it can't hurt.
> > > >>
> > > >> That patch doesn't work at all. Make the above change, and also change
> > > >> the type of effective_length from u32 to int, and try again.
> > > >
> > > > I was just looking and it, and doing the changes you recommended make
> > > > no difference at all.
> > > >
> > >
> > > Is the i2c controller compatible with marvell,mv78230-i2c ?
> > > The block transfers would not work in that case. Let me know
> > > and I'll send you a patch that might fix it.
> >
> > Yes, the CPU is Armada 7040 and I can see that compatible is
> > marvell,mv78230-i2c indeed.
> >
> > It would be great if you have the patch,
>
> See below.

I can confirm that this does indeed enable block reads and
i2c_smbus_read_block_data()
works now.

PMBUS_MFR_ID and PMBUS_MFR_MODEL are indeed populated.

Regards,
Robert

>
> Guenter
>
> ---
> From 41f6113560e3082293cef6e8f2013e70ee8f54db Mon Sep 17 00:00:00 2001
> From: Federico Fuga <fuga@studiofuga.com>
> Date: Sat, 18 Jan 2020 12:58:20 +0100
> Subject: [PATCH] i2c: mv64xxx: Implement I2C_M_RECV_LEN and
>  I2C_FUNC_SMBUS_READ_BLOCK_DATA
>
> The i2c_mv64xxx driver doesn't implement the I2C_M_REC_LEN function
> essential to allow blocks with variable length to be read from an i2c
>  slave.
> This is needed to implement the SMBus Read Block Data function.
>
> This patch implements the function by changing the bytes_left and
> msg len on the fly if the flag is specified.
>
> It has been successfully tested on Allwinner A33 with a special
> i2c chip that returns variable length blocks on reading.
>
> Signed-off-by: Federico Fuga <fuga@studiofuga.com>
> Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> Link: https://lore.kernel.org/r/20200118115820.9080-1-fuga@studiofuga.com
> [groeck: Various fixes]
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/i2c/busses/i2c-mv64xxx.c | 75 ++++++++++++++++++++++++++------
>  1 file changed, 61 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
> index 5c8e94b6cdb5..9dda90359966 100644
> --- a/drivers/i2c/busses/i2c-mv64xxx.c
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> @@ -341,7 +341,17 @@ static void mv64xxx_i2c_send_start(struct mv64xxx_i2c_data *drv_data)
>  {
>         drv_data->msg = drv_data->msgs;
>         drv_data->byte_posn = 0;
> -       drv_data->bytes_left = drv_data->msg->len;
> +
> +       /*
> +        * If we should retrieve the length from the buffer, make sure
> +        * to read enough bytes to avoid sending the STOP bit after
> +        * the read if the first byte
> +        */
> +       if (drv_data->msg->flags & I2C_M_RECV_LEN)
> +               drv_data->bytes_left = 3;
> +       else
> +               drv_data->bytes_left = drv_data->msg->len;
> +
>         drv_data->aborting = 0;
>         drv_data->rc = 0;
>
> @@ -350,6 +360,47 @@ static void mv64xxx_i2c_send_start(struct mv64xxx_i2c_data *drv_data)
>                drv_data->reg_base + drv_data->reg_offsets.control);
>  }
>
> +static void
> +mv64xxx_i2c_do_send_stop(struct mv64xxx_i2c_data *drv_data)
> +{
> +       drv_data->cntl_bits &= ~MV64XXX_I2C_REG_CONTROL_INTEN;
> +       writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_STOP,
> +              drv_data->reg_base + drv_data->reg_offsets.control);
> +       drv_data->block = 0;
> +       if (drv_data->errata_delay)
> +               udelay(5);
> +
> +       wake_up(&drv_data->waitq);
> +}
> +
> +static void
> +mv64xxx_i2c_do_read_data(struct mv64xxx_i2c_data *drv_data)
> +{
> +       u8 data;
> +
> +       data = readl(drv_data->reg_base + drv_data->reg_offsets.data);
> +       drv_data->msg->buf[drv_data->byte_posn++] = data;
> +
> +       if (drv_data->msg->flags & I2C_M_RECV_LEN) {
> +               if (!data || data > I2C_SMBUS_BLOCK_MAX) {
> +                       /*
> +                        * FIXME
> +                        * Abort and report error. Needs to be
> +                        * verified/tested on real hardware.
> +                        */
> +                       drv_data->rc = -EPROTO;
> +                       mv64xxx_i2c_do_send_stop(drv_data);
> +                       return;
> +               }
> +               drv_data->msg->flags &= ~I2C_M_RECV_LEN;
> +               drv_data->bytes_left = data;
> +               drv_data->msg->len = data + 1;
> +       }
> +
> +       writel(drv_data->cntl_bits,
> +              drv_data->reg_base + drv_data->reg_offsets.control);
> +}
> +
>  static void
>  mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
>  {
> @@ -400,23 +451,13 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
>                 break;
>
>         case MV64XXX_I2C_ACTION_RCV_DATA:
> -               drv_data->msg->buf[drv_data->byte_posn++] =
> -                       readl(drv_data->reg_base + drv_data->reg_offsets.data);
> -               writel(drv_data->cntl_bits,
> -                       drv_data->reg_base + drv_data->reg_offsets.control);
> +               mv64xxx_i2c_do_read_data(drv_data);
>                 break;
>
>         case MV64XXX_I2C_ACTION_RCV_DATA_STOP:
>                 drv_data->msg->buf[drv_data->byte_posn++] =
>                         readl(drv_data->reg_base + drv_data->reg_offsets.data);
> -               drv_data->cntl_bits &= ~MV64XXX_I2C_REG_CONTROL_INTEN;
> -               writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_STOP,
> -                       drv_data->reg_base + drv_data->reg_offsets.control);
> -               drv_data->block = 0;
> -               if (drv_data->errata_delay)
> -                       udelay(5);
> -
> -               wake_up(&drv_data->waitq);
> +               mv64xxx_i2c_do_send_stop(drv_data);
>                 break;
>
>         case MV64XXX_I2C_ACTION_INVALID:
> @@ -680,6 +721,10 @@ mv64xxx_i2c_can_offload(struct mv64xxx_i2c_data *drv_data)
>         if (!drv_data->offload_enabled)
>                 return false;
>
> +       /* Offload not supported for block data transfers */
> +       if (msgs[0].flags & I2C_M_RECV_LEN)
> +               return false;
> +
>         /*
>          * We can offload a transaction consisting of a single
>          * message, as long as the message has a length between 1 and
> @@ -697,6 +742,7 @@ mv64xxx_i2c_can_offload(struct mv64xxx_i2c_data *drv_data)
>             mv64xxx_i2c_valid_offload_sz(msgs) &&
>             mv64xxx_i2c_valid_offload_sz(msgs + 1) &&
>             !(msgs[0].flags & I2C_M_RD) &&
> +           !(msgs[1].flags & I2C_M_RECV_LEN) &&
>             msgs[1].flags & I2C_M_RD)
>                 return true;
>
> @@ -713,7 +759,8 @@ mv64xxx_i2c_can_offload(struct mv64xxx_i2c_data *drv_data)
>  static u32
>  mv64xxx_i2c_functionality(struct i2c_adapter *adap)
>  {
> -       return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR | I2C_FUNC_SMBUS_EMUL;
> +       return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR |
> +               I2C_FUNC_SMBUS_READ_BLOCK_DATA | I2C_FUNC_SMBUS_EMUL;
>  }
>
>  static int
> --
> 2.25.1
>


-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
