Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C29421ADD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 01:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhJDXxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 19:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhJDXxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 19:53:03 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F8DC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 16:51:13 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 187so11427348pfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 16:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=19NmVTxrMofJXdMsxpuEpLvLDZr80mxpkGYvnpxUs4Y=;
        b=AhyevJtYhfFqPx7QqSQM97DBoDYsZ0gCc2jgka5szItiRcrCSmxru0PQvjJPnW4vYb
         wtIPitlH30WVbKFqF0ySs5+0ggrwN3+H+krpsKiJtV8pSig1jFNBPL+alWe8EaF0HCc+
         lOdJb5HNxjeUrfRaUvXb06ID9DPHzNuXtI3mixQVOqcyqP38/SYFwIThiIYaWnP30Vzb
         pFsBS+ltF2TFi+CVtbxgerChdxT26xnm5dzrhOGVWSLlcJX4ACO4hV8h2biNPQZ8FYXz
         TNmYYOty5WWuSRkBN/PlppCai3X5YJXq1jhCHNyBvovcRuk29CLlYb3aYoQRaJaiRcau
         13qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=19NmVTxrMofJXdMsxpuEpLvLDZr80mxpkGYvnpxUs4Y=;
        b=EvhzOp7iiqztboOcQijm0v0GrJbukovfeN02IS5EJtheg2ngRd+15d4NtdsiHJg5/h
         fpb/pL76RSQptJmfLpAB1pOFzggbqxoFGWT4SykQkizrMTRLSTJmGuTc5M3nVAdItsW+
         PvH5v+nxPavymkap/Hj+LBMOTKgEE7F2SXIhiMT4VqiV80wPp7RP+xsyvb7gNeE5PYDB
         Xj/k1DUjNtI4MWKRG6ADAQPPjULFGyXujjxYPgX6LBFVYG9bXnJliQy+pnUVeucNy3Ld
         /460nz/0TLICoVZiRH2nJUIJqeNCSkFIJbTqAJJ+8gl4x9VBZrLPEzP/xv/36TIPWmzW
         jTPg==
X-Gm-Message-State: AOAM530NiaeXhC5kELFta0VmP8gGymAfqRO5Rh86MljWDZK/iwxS0GV3
        0Qii2RZM/SXa3t8uBYwSG+eFQT3l+APp0Xj0ynE5P35woVyJWg==
X-Google-Smtp-Source: ABdhPJzHTZV4iqyH9t6Vs+E4CaP/1sgDrmIpBnz1+xwn3wHJ2P2d6Qt4QS3bYOswIzm+BK+HqR3mUWoQypxh0/OJsxQ=
X-Received: by 2002:a63:e64a:: with SMTP id p10mr13377655pgj.263.1633391472919;
 Mon, 04 Oct 2021 16:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210928161957.24628-1-andriy.tryshnivskyy@opensynergy.com> <20210930174043.0845f6ed@jic23-huawei>
In-Reply-To: <20210930174043.0845f6ed@jic23-huawei>
From:   Jyoti Bhayana <jbhayana@google.com>
Date:   Mon, 4 Oct 2021 16:51:01 -0700
Message-ID: <CA+=V6c34+VtYbUDG=NuY6YeyML23Tth2+fTjhvXpwMvrtkM5_Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] iio/scmi: Add reading "raw" attribute.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasyl.Vavrychuk@opensynergy.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andriy,

Please find my feedback below:

> @@ -286,6 +286,9 @@ static int scmi_iio_read_raw(struct iio_dev *iio_dev,
>         struct scmi_iio_priv *sensor = iio_priv(iio_dev);
>         s8 scale;
>         int ret;
> +       int err;


Why do we have two variables with a similar purpose of saving the
return value? Can't ret be used in this case instead of adding a new
one?


In the code below, why is the logic of enabling and disabling the
sensor in this function?  Generally the function to read the sensor
value is just used for the code to read the sensor values ? and not
enable/disable the sensor

>    case IIO_CHAN_INFO_RAW:
> +               sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> +                                          SCMI_SENS_CFG_SENSOR_ENABLE);
> +               err = sensor->sensor_ops->config_set(
> +                       sensor->ph, sensor->sensor_info->id, sensor_config);
> +               if (err) {
> +                       dev_err(&iio_dev->dev,
> +                               "Error in enabling sensor %s err %d",
> +                               sensor->sensor_info->name, err);
> +                       return err;
> +               }
> +
> +               err = sensor->sensor_ops->reading_get_timestamped(
> +                       sensor->ph, sensor->sensor_info->id,
> +                       sensor->sensor_info->num_axis, readings);
> +               if (err) {
> +                       dev_err(&iio_dev->dev,
> +                               "Error in reading raw attribute for sensor %s err %d",
> +                               sensor->sensor_info->name, err);
> +                       return err;
> +               }
> +
> +               sensor_config = FIELD_PREP(SCMI_SENS_CFG_SENSOR_ENABLED_MASK,
> +                                          SCMI_SENS_CFG_SENSOR_DISABLE);
> +               err = sensor->sensor_ops->config_set(
> +                       sensor->ph, sensor->sensor_info->id, sensor_config);
> +               if (err) {
> +                       dev_err(&iio_dev->dev,
> +                               "Error in enabling sensor %s err %d",
> +                               sensor->sensor_info->name, err);
> +                       return err;
> +               }
> +               /* Check if raw value fits 32 bits */
> +               if (readings[ch->scan_index].value < INT_MIN ||
> +                   readings[ch->scan_index].value > INT_MAX)
> +                       return -ERANGE;
> +               /* Use 32-bit value, since practically there is no need in 64 bits */
> +               *val = (int)readings[ch->scan_index].value;
>
> +               return IIO_VAL_INT;


On Thu, Sep 30, 2021 at 9:36 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 28 Sep 2021 19:19:56 +0300
> Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com> wrote:
>
> > This patch implements reading "raw" attribute.
> >
> > The patch is based on v5.14.
> >
> > Comparing to the previous version it has:
> > * adaptation for changes in structure scmi_iio_priv (no member named 'handle')
> >
> Ah.. If you have a case like this where you send out a new version because you've
> found an issue yourself, please also reply to the earlier version to say what the
> problem was.  That way no one reviews the wrong version :)
>
> Thanks,
>
> Jonathan
>
> > Any comments are very welcome.
> >
> > Thanks,
> > Andriy.
> >
> > Andriy Tryshnivskyy (1):
> >   iio/scmi: Add reading "raw" attribute.
> >
> >  drivers/iio/common/scmi_sensors/scmi_iio.c | 45 +++++++++++++++++++++-
> >  1 file changed, 44 insertions(+), 1 deletion(-)
> >
> >
> > base-commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f
>
