Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFF838AF38
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243269AbhETMxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243086AbhETMvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:51:38 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269BAC069175
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:17 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id f22so10779276pgb.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+11Asx9mB6ZyWHyZn4h1vSOfApP9ND3aSL86GPZLDE8=;
        b=drRAtIfz7o3efRjYGNUrYYK4FSZooNjDRta0p9WGLPAgjwmUIB2Rt0HozeQ9k72rI6
         n0DfB7ldV8NvKV7bGfRMoElKKbwdsamH+qba9+Spn3R/XlRn0kh8YSIKnnyK4o9yEZZp
         Ipl8lTxvURBCzbqQZYBPaHtYwjPgLKVs6R2B/K0nWIbgIld2rgWK4OUx1z8vQeTbS3ah
         1tIRbbkS1YeBvUpBdcuf7UNwkFH3Ivwl1HuSocPqCCKnbztfuT2Rh3dLAr2uWx1TqPi0
         hEIKfv4vfStz3l/k4JT+cOoSo0A5Ybu0pwKh2TIWQo/r98HnZYxIQlUAYK0ePoU1eBFU
         PxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+11Asx9mB6ZyWHyZn4h1vSOfApP9ND3aSL86GPZLDE8=;
        b=k4+Y8kGvdkY+U96PAZvr91sO+5dKQdXzwrID/h/8kZZVItJJBEghZdPITQF+9Ip1Da
         evyD2NQdKnbkLFyrr19nTmmpK9PLUJhyklEmxswdhq3By2AKXbLFV1//umjyA4PkTFUM
         k8KOGXjUsEFohqdoJC6B2I3FNS88mZIsI52CQAJ8QHkmYwlTd0w9MImMPII7Vx4hpNZy
         rJzY7GVMQ8nZ1gZ18pzwfK5NOSbGikk/Gb+H6TUsvfe7PGnGoXOcYvZm/x/VEs0lig5+
         Y2i8jnhHmDXO9lCVf6JKtfEdSJ3r7NCT/3VhVed0uACcgywoNT97Y/p0G0The8fsBS/b
         /ItA==
X-Gm-Message-State: AOAM531MSR5KpGyxQ2UmrSxjGmK57huRelVAKt1240Ag41qsz0ah9tQW
        ETnlD1RzBAaermQp7b8CDYpzzAMQ465HWgNnX2qKGQ==
X-Google-Smtp-Source: ABdhPJwbodNgWFgeN2AQHQRqgbGi8pKONPqqgmZHyx3zuUWP8wat9k8I1mThIO5zDnJdgh+krIPYwYTr7uNlCIK1IH4=
X-Received: by 2002:a63:1054:: with SMTP id 20mr4317007pgq.120.1621512857098;
 Thu, 20 May 2021 05:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210511180728.23781-1-jonathan@marek.ca> <20210511180728.23781-10-jonathan@marek.ca>
In-Reply-To: <20210511180728.23781-10-jonathan@marek.ca>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 20 May 2021 14:14:04 +0200
Message-ID: <CAG3jFyv71xJxkH_aq9PMObSKRu1GUcekCHpwKRMTbnrch2vG_Q@mail.gmail.com>
Subject: Re: [PATCH 09/17] media: camss: csid: allow csid to work without a regulator
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "open list:QUALCOMM CAMERA SUBSYSTEM DRIVER" 
        <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 at 20:08, Jonathan Marek <jonathan@marek.ca> wrote:
>
> At least for titan HW, CSID don't have an associated regulator. This change
> is necessary to be able to model this in the CSID resources.
>
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/media/platform/qcom/camss/camss-csid.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
> index cc11fbfdae13..528674dea06c 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid.c
> @@ -162,7 +162,7 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
>                         return ret;
>                 }
>
> -               ret = regulator_enable(csid->vdda);
> +               ret = csid->vdda ? regulator_enable(csid->vdda) : 0;
>                 if (ret < 0) {
>                         pm_runtime_put_sync(dev);
>                         return ret;
> @@ -170,14 +170,16 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
>
>                 ret = csid_set_clock_rates(csid);
>                 if (ret < 0) {
> -                       regulator_disable(csid->vdda);
> +                       if (csid->vdda)
> +                               regulator_disable(csid->vdda);
>                         pm_runtime_put_sync(dev);
>                         return ret;
>                 }
>
>                 ret = camss_enable_clocks(csid->nclocks, csid->clock, dev);
>                 if (ret < 0) {
> -                       regulator_disable(csid->vdda);
> +                       if (csid->vdda)
> +                               regulator_disable(csid->vdda);
>                         pm_runtime_put_sync(dev);
>                         return ret;
>                 }
> @@ -188,7 +190,8 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
>                 if (ret < 0) {
>                         disable_irq(csid->irq);
>                         camss_disable_clocks(csid->nclocks, csid->clock);
> -                       regulator_disable(csid->vdda);
> +                       if (csid->vdda)
> +                               regulator_disable(csid->vdda);
>                         pm_runtime_put_sync(dev);
>                         return ret;

Since this & the previous chunks of failure cleanups are growing
larger, maybe it is time to extract all of the failure cleanups into
gotos. That should probably go into a seperate patch though.

>                 }
> @@ -197,7 +200,7 @@ static int csid_set_power(struct v4l2_subdev *sd, int on)
>         } else {
>                 disable_irq(csid->irq);
>                 camss_disable_clocks(csid->nclocks, csid->clock);
> -               ret = regulator_disable(csid->vdda);
> +               ret = csid->vdda ? regulator_disable(csid->vdda) : 0;
>                 pm_runtime_put_sync(dev);
>         }
>
> @@ -634,7 +637,9 @@ int msm_csid_subdev_init(struct camss *camss, struct csid_device *csid,
>
>         /* Regulator */
>
> -       csid->vdda = devm_regulator_get(dev, res->regulator[0]);
> +       csid->vdda = NULL;
> +       if (res->regulator[0])
> +               csid->vdda = devm_regulator_get(dev, res->regulator[0]);
>         if (IS_ERR(csid->vdda)) {
>                 dev_err(dev, "could not get regulator\n");
>                 return PTR_ERR(csid->vdda);

Reviewed-by: Robert Foss <robert.foss@linaro.org>
