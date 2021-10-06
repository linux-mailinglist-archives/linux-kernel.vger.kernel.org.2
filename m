Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653754234DC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 02:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237051AbhJFAS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 20:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbhJFASY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 20:18:24 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6911C06174E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 17:16:33 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id b22so579055pls.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 17:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FsmOcyeSF5LDALD7AdWRbXWLdG0zO7+WUiqdNCezuHc=;
        b=jjILV6lHdBkHdfDeE167mW3yw3DgacBfFLFIqrdpFEphqu7gr5eQbTyq/bFiEJrvwm
         lF6b3/99Sh7dF2t6FHkXdOqBT6c1WnDGCi0QOyRRQ38+jehDZkGLVPBNK1YlElQZgeHh
         crpWe5OgLIsypO1pyfBfnOxUQb/A1EmwqHy8BSbjzn3kHDLeQBmkIyNLDM43cnpupUxT
         FqQhIa8/Op3x50d1/JkbcSxGyANvfzP/9LXbG0QEqvi4vThdq42sK+CSFR8DmK+0CRF6
         ILIWrZdc9/ZRd3FTHiFkAODhhk9XxdLMtAr4TUe1RcgWTsmflT3rWt0dl+E4WXpAp78Z
         xm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FsmOcyeSF5LDALD7AdWRbXWLdG0zO7+WUiqdNCezuHc=;
        b=AGCrQHVVvi3u2D2wiOvhT7tecUGn5ZmzwY7aHzorg4KXR3AsWaBz7oUKdIIiEgj00z
         Y3ghbploMuE/KDCkIR7a+m8sc3fSEu9xBBgJg5HgPKJtaxdCdve7JsHXheiS3UINfP17
         nm2DrPZNRY1LxO/O6+UGBLyXFxzpmrkqlnKdqeUJRQ2WxBMtAzlEc+0l6x0wJZuhVbrD
         CMEhKCnhMLkz/3cUJkQJRiFDyMdOzu2a+1UtTGgrvINMmZarb0C8BAr6/mXENR272H1K
         NbfE5+i2j6/ntMxUyMEGK51q2HKmAg9crAGqnlScQIMjEd8Tybyq7WCMf8DhYta3E0I1
         nH5A==
X-Gm-Message-State: AOAM530aJfwpYdslL08fapzF10WnvenFVH1gwye+iD3pN4SGxPXVYEaM
        3LAyTdgMcNx3KGsux0yY29nbsac7p0L0EHHXV4B2vg==
X-Google-Smtp-Source: ABdhPJxm2mrIkvX1H5FZqrRIvq/NW592WPZPWtxWAKdaIixsmln+D5I2mF9rQg+zHJZWe9VAKADevheENmdKLBXcV88=
X-Received: by 2002:a17:90a:2902:: with SMTP id g2mr7212693pjd.161.1633479392911;
 Tue, 05 Oct 2021 17:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210928161957.24628-1-andriy.tryshnivskyy@opensynergy.com>
 <20210930174043.0845f6ed@jic23-huawei> <CA+=V6c34+VtYbUDG=NuY6YeyML23Tth2+fTjhvXpwMvrtkM5_Q@mail.gmail.com>
 <650ec3b8-c970-604c-9be6-577c46d3e762@opensynergy.com>
In-Reply-To: <650ec3b8-c970-604c-9be6-577c46d3e762@opensynergy.com>
From:   Jyoti Bhayana <jbhayana@google.com>
Date:   Tue, 5 Oct 2021 17:16:21 -0700
Message-ID: <CA+=V6c10xE-1uUzGWusBiGVMV2Fwy93dGGHA9FH0PC4tYggVUQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] iio/scmi: Add reading "raw" attribute.
To:     Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vasyl,

Regarding below question, yes reading raw attribute should be blocked
if buffer is enabled for that sensor.

> 1. Should we block reading raw attribute and IIO buffer enabled, for for
> SCMI sensor it can coexist?


PLease see  https://elixir.bootlin.com/linux/latest/source/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c#L667
as well. It has

case IIO_CHAN_INFO_RAW:
ret = iio_device_claim_direct_mode(indio_dev);
if (ret)
return ret;
mutex_lock(&st->lock);
ret = inv_mpu6050_read_channel_data(indio_dev, chan, val);
mutex_unlock(&st->lock);
iio_device_release_direct_mode(indio_dev);
return ret;

Regarding the question below, the answer is yes.

> 2. Should we wrap reading raw attribute implementation in iio_dev->mlock
> mutex?


Thanks, Jyoti





On Tue, Oct 5, 2021 at 5:52 AM Vasyl Vavrychuk
<vasyl.vavrychuk@opensynergy.com> wrote:
>
> Hi, Jyoti,
>
> > In the code below, why is the logic of enabling and disabling the
> > sensor in this function?  Generally the function to read the sensor
> > value is just used for the code to read the sensor values ? and not
> > enable/disable the sensor
>
> But to read sensor value we have to enable it first. Other way to enable
> sensor we found is, for example:
>
>    echo 1 > /sys/bus/iio/devices/.../scan_elements/in_anglvel_x_en
>
> But, this command is related to IIO buffers use.
>
> Other sensors drivers enable/disable sensor in read raw too, for
> example, drivers/iio/accel/kxcjk-1013.c has:
>
>    case IIO_CHAN_INFO_RAW:
>            mutex_lock(&data->mutex);
>            if (iio_buffer_enabled(indio_dev))
>                    ret = -EBUSY;
>            else {
>                    ret = kxcjk1013_set_power_state(data, true);
>                    ... reading ...
>                    ret = kxcjk1013_set_power_state(data, false);
>            }
>            mutex_unlock(&data->mutex);
>
> But, after looking on this code I have some questions:
>
> 1. Should we block reading raw attribute and IIO buffer enabled, for for
> SCMI sensor it can coexist?
> 2. Should we wrap reading raw attribute implementation in iio_dev->mlock
> mutex?
>
> >>     case IIO_CHAN_INFO_RAW:
> >> +               sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> >> +                                          SCMI_SENS_CFG_SENSOR_ENABLE);
> >> +               err = sensor->sensor_ops->config_set(
> >> +                       sensor->ph, sensor->sensor_info->id, sensor_config);
> >> +               if (err) {
> >> +                       dev_err(&iio_dev->dev,
> >> +                               "Error in enabling sensor %s err %d",
> >> +                               sensor->sensor_info->name, err);
> >> +                       return err;
> >> +               }
> >> +
> >> +               err = sensor->sensor_ops->reading_get_timestamped(
> >> +                       sensor->ph, sensor->sensor_info->id,
> >> +                       sensor->sensor_info->num_axis, readings);
> >> +               if (err) {
> >> +                       dev_err(&iio_dev->dev,
> >> +                               "Error in reading raw attribute for sensor %s err %d",
> >> +                               sensor->sensor_info->name, err);
> >> +                       return err;
> >> +               }
> >> +
> >> +               sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> >> +                                          SCMI_SENS_CFG_SENSOR_DISABLE);
> >> +               err = sensor->sensor_ops->config_set(
> >> +                       sensor->ph, sensor->sensor_info->id, sensor_config);
> >> +               if (err) {
> >> +                       dev_err(&iio_dev->dev,
> >> +                               "Error in enabling sensor %s err %d",
> >> +                               sensor->sensor_info->name, err);
> >> +                       return err;
> >> +               }
> >> +               /* Check if raw value fits 32 bits */
> >> +               if (readings[ch->scan_index].value < INT_MIN ||
> >> +                   readings[ch->scan_index].value > INT_MAX)
> >> +                       return -ERANGE;
> >> +               /* Use 32-bit value, since practically there is no need in 64 bits */
> >> +               *val = (int)readings[ch->scan_index].value;
> >>
> >> +               return IIO_VAL_INT;
